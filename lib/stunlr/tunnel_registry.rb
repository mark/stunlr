class Stunlr

  class TunnelRegistry

    ################
    #              #
    # Declarations #
    #              #
    ################
    
    attr_reader :tunnels

    ###############
    #             #
    # Constructor #
    #             #
    ###############
    
    def initialize
      @tunnels = {}
    end
    
    ####################
    #                  #
    # Instance Methods #
    #                  #
    ####################
    
    def each
      tunnels.values.each { |tunnel| yield tunnel }
    end

    def register(tunnel)
      tunnels[tunnel.pid] ||= tunnel
    end
    
  end

end
