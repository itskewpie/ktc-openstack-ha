module KTC
  class Vips
    class << self

      #
      # return ip addresssesof the specified vips
      #  can specify a network name to return that set
      def addresses( vips, network=nil )
        if network
          ips = no_network(network, vips).map { |v| v[:ip] }
        else
          vips.each_key.map {|k| vips[k][:ip]}
        end
      end

      # see if the vip  is on specified network
      # return  a list of vips
      def on_network( network, vips )
        matched = Array.new
        vips.each do |vip|
          if vip.has_key? :net
            # vip has a net key push it
            if vip[:net] == network
              matched.push vip
            end
          # default with no key is public
          elsif network == "public"
            matched.push vip
          end
        end
      end

    end
  end
end
