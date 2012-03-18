require "rubygems"
require "awesome_print" rescue nil

if defined?(AwesomePrint)
  unless IRB.version.include?("DietRB")
    IRB::Irb.class_eval do
      def output_value
        ap @context.last_value
      end
    end
  end
end
