class Stunlr

  class Tunnel

    ################
    #              #
    # Declarations #
    #              #
    ################
    
    attr_reader :pid, :port, :server, :local

    ###############
    #             #
    # Constructor #
    #             #
    ###############
    
    def initialize(server, port, local, pid = nil)
      @server = server
      @port   = port.to_i
      @local  = local.to_i
      @pid    = pid
    end

    #################
    #               #
    # Class Methods #
    #               #
    #################
    
    def self.header
      "#{ 'port'.ljust(10) }|#{ 'address'.ljust(20) }|status"

    end

    ####################
    #                  #
    # Instance Methods #
    #                  #
    ####################
    
    def running?
      return false unless pid

      @pid = nil unless `ps -p #{ pid }`[pid.to_s]
      ! pid.nil?
    end

    def start!
      @pid = spawn("ssh -C -f -N -L #{ local }:#{ server }:#{ port } wa-current@wa-etl-q0")

      puts "PID = #{ pid }"
    end

    def stop!
      Process.kill(:TERM, pid)
    end

    def to_s
      host_port = "#{ server }:#{ port }".ljust(20)

      status = running? ? "[OK #{ pid }]" : ""

      "#{ local.to_s.ljust(10)} #{ host_port } #{ status }"
    end

  end

end
