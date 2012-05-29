require 'sass'

module Sass
  module Tree
	  class Node
	    def order_children!
	      order = [
          "position",
          "display",
          "float",
          "top",
          "bottom",
          "left",
          "right",
          "z-index",
          "margin",
          "margin-left",
          "margin-right",
          "margin-top",
          "margin-bottom",
          "box-sizing",          
          "width",
          "max-width",
          "min-width",
          "height",
          "max-height",
          "min-height",
          "padding",
          "padding-left",
          "padding-right",
          "padding-top",
          "padding-bottom",
          "border",
          "border-top",
          "border-bottom",
          "border-left",
          "border-right",
          "outline",
          "-webkit-box-shadow",
          "-moz-box-shadow",
          "box-shadow",          
          "overflow",
          "clip",
          "background",
          "background-color",
          "background-position",
          "background-image",
          "background-repeat",
          "line-height",      
          "font",
          "font-weight",
          "font-size",
          "font-family",
          "text-indent",
          "text-decoration",
          "text-align",
          "vertical-align",
          "text-transform",
          "color",
          "-webkit-user-select",
          "-moz-user-select",
          
          "cursor",
          "-webkit-transition"
          ]
          
        # Have large array of sorted things
        ordered_children = Array.new(order.length)
	      
	      children.each do |c|
	        if(c.class == Sass::Tree::PropNode)
	          
	          
	          if(order.index(c.name[0]))
	            ordered_children[order.index(c.name[0])] = c
	          else
              puts "//Not found: #{c.name}"
	            ordered_children.push(c)
	          end
	        elsif c.class == Sass::Tree::RuleNode
	          c.order_children!
	          ordered_children.push(c)	          
	        else
	          ordered_children.push(c)
	        end
	      
	      end
	    
        self.children = ordered_children.compact
	    end
	
	  end
  end
end

engine = Sass::Engine.for_file(ARGV[0], {:style => :expanded})
tree = engine.to_tree
tree.children.each do |n|
   
  n.order_children!
  puts n.to_scss
  
end


