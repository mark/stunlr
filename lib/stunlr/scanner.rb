class Stunlr

  class Scanner

    ################
    #              #
    # Declarations #
    #              #
    ################
    
    attr_reader :registry, :scanning

    ###############
    #             #
    # Constructor #
    #             #
    ###############
    
    def initialize(registry)
      scan_for_running_tunnels
    end

    ####################
    #                  #
    # Instance Methods #
    #                  #
    ####################
    
    def scan_for_running_tunnels
      output = `ps aux axo | grep 'ssh -C'`.split("\n")
      
      output.each do |line|
        if line =~ /(\d+)\s+ssh -C -f -N -L (\d+):(.+):(\d+)/
          tunnel = Tunnel.new($3, $4, $2, $1)
          registry.register(tunnel)
        end
      end
    end

  end

end
