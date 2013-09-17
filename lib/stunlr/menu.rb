class Stunlr

  class Menu

    ################
    #              #
    # Declarations #
    #              #
    ################
    
    attr_reader :registry, :scanner
    
    CLEAR  = %Q(\e[H\e[2J)

    PROMPT = "?>"

    ###############
    #             #
    # Constructor #
    #             #
    ###############
    
    def initialize()
      @registry = TunnelRegistry.new
      @scanner  = Scanner.new(registry)
    end

    ####################
    #                  #
    # Instance Methods #
    #                  #
    ####################
    
    def start
      loop do
        print CLEAR
        display
        print "#{ PROMPT } "
        
        handle_response(gets.chomp)
      end
    end

    def display
      puts Tunnel.header
      puts '-' * Tunnel.header.length

      registry.each do |tunnel|
        puts tunnel
      end

      puts @error if @error
    end

    def handle_response(input)
      @error = nil

      case input
      when "\\q" then exit!
      when /^open (.+):(\d+) at (\d+)$/i
        open_tunnel($1, $2, $3)
      when ''
        # Don't do anything
      else
        @error = "I don't understand '#{ input }'"
      end
    end

    def open_tunnel(host, port, local)
      tunnel = Tunnel.new(host, port, local)
      tunnel.start!

      registry.register(tunnel)
    end

  end

end
