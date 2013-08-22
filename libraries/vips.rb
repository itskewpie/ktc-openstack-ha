module KTC
  class Vips
    class << self

      #
      # return ip addresssesof the specified vips
      #  can specify a network name to return that set
      def addresses vips, network=nil
        if network
          data = on_network(network, vips)
          ips = data.map { |v| v.has_key? :ip ? v[:ip] : nil }
        else
          vips.each_key.map { |k| vips[k][:ip] }
        end
      end

      # see if the vip  is on specified network
      # return  a list of vips
      def on_network network, vips
        matched = Array.new
        vips.each do |name, data|
          if data.has_key? :net
            # vip has a net key push it
            if data[:net] == network
              matched.push data
            end
          # default with no key is public
          elsif network == "public"
            matched.push data
          end
        end
        matched
      end

    end
  end
end
