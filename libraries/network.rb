module KTC
  class Network
    class << self

      def if_addr node, int
        interface_node = node["network"]["interfaces"][int]["addresses"]
        interface_node.select do |address, data|
          if data['family'] == family
            return address
          end
        end
      end

      def last_octet ipaddr
        ipaddr.split(".")[3].to_i
      end

    end
  end
end
