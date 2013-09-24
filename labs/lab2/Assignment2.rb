#Austin Longo
#9/24/13
#CSCI 3308 - Assignment 2


# Part 1: Classes
#------------------------------------------------------------------------------
#------------------------------------------------------------------------------

class Dessert
	attr_accessor :name
	attr_accessor :calories

    def initialize(name, calories)
        @name = name
        @calories = calories
    end

    def healthy?
    	@calories<200
    end

    def delicious?
        true
    end
end

class JellyBean < Dessert
	attr_accessor :flavor

    def initialize(name, calories, flavor)        
        @flavor = flavor
        super(name, calories)
    end

    def delicious?
        @flavor != "black licorice"
    end
end

#Test code for Dessert & Jellybean
=begin
BL = JellyBean.new("JellyBean", 100, "black licorice")
puts BL.flavor
puts "Delicious?: "
puts BL.delicious?
puts "Healthy?: "
puts BL.healthy?

CC = JellyBean.new("JellyBean", 203, "cotton candy")
puts CC.flavor
puts "Delicious?: "
puts CC.delicious? 
puts "Healthy?: "
puts CC.healthy?

D1 = Dessert.new("Apple Pie", 500)
puts D1.name
puts "Delicious?: "
p D1.delicious?
puts "Healthy?: "
p D1.healthy?
=end



# Part 2: Object Oriented Programming
#------------------------------------------------------------------------------
#------------------------------------------------------------------------------

class Class
    def attr_accessor_with_history(attr_name)
        attr_name = attr_name.to_s       # make sure it's a string
        attr_reader attr_name            # create the attribute's getter
        attr_reader attr_name+"_history" # create bar_history getter
        class_eval %Q" 
            def #{attr_name}=(value)
                if !defined? @#{attr_name}_history
                    @#{attr_name}_history = [@#{attr_name}]
                end
                @#{attr_name} = value
                @#{attr_name}_history << value
            end
        "
    end
end


class Foo
    attr_accessor_with_history :bar
end

#Test code for attr_accessor_with_history
=begin
f = Foo.new
f.bar = 1
f.bar = 2
puts f.bar
puts f.bar_history
=end



# Part 3: More OOP
#------------------------------------------------------------------------------
#------------------------------------------------------------------------------

#a)

class Numeric
    @@currencies = {'yen' => 0.013, 'euro' => 1.292, 'rupee' => 0.019, 'dollar' => 1}
    #@@currencies_from_dollars = {'yen' => 76.92, 'euro' => 0.773}
    def method_missing(method_id)
        singular_currency = method_id.to_s.gsub( /s$/, '') #converts plural to singular
        if @@currencies.has_key?(singular_currency)
            self * @@currencies[singular_currency]
        else
            super
        end
        
    end

    def in(new_currency)
        singular_currency = new_currency.to_s.gsub( /s$/, '') #converts plural to singular
        if @@currencies.has_key?(singular_currency)
            self / @@currencies[singular_currency]
        else
            super
        end
    end
end

#Test Code for conversions
=begin
raise "failed" unless 1.dollar.in(:rupees) == 1/0.019
raise "failed" unless 10.rupees.in(:euro) == (10*0.019)/(1.292)
raise "failed" unless 10.yen.in(:dollars) == (10*0.013)
puts 1.dollar.in(:rupees)
puts 10.rupees.in(:euro)
puts 10.yen.in(:dollars)
=end


#b)

class String
    def palindrome?
        self.downcase!
        self.gsub!(/\W+/, '')
        puts self
        if self === self.reverse
            puts "true"
        else
            puts "false"
        end
    end
end

#Test code for .palindrome?
=begin
"Bob".palindrome?
"fred".palindrome?
"A man, a plan, a canal -- Panama".palindrome?
=end


# c)

class Array
    def palindrome?        
            self.each do |element| 
                begin 
                    element.downcase! 
                rescue
                    next
                end
            end
                    
        puts self
        if self === self.reverse
            puts "true"
        else
            puts "false"
        end
    end
end

#Test code for array.palindrome?
=begin
[1,2,3,2,1].palindrome?
["Dog", 1, 2, "cat", 2, 1, "dog"].palindrome?
=end



# Part 4: Blocks
#------------------------------------------------------------------------------
#------------------------------------------------------------------------------


class CartesianProduct
  include Enumerable

  def initialize(xs, ys)
    @xs = xs
    @ys = ys
  end

  def each
    return to_enum unless block_given?
    @xs.each do |x| 
      @ys.each { |y| yield [x, y] }
    end
  end
end

#Test code for CartesianProduct
=begin
c = CartesianProduct.new([:a,:b], [4,5])
c.each { |elt| puts elt.inspect }

c = CartesianProduct.new([:a,:b], [])
c.each { |elt| puts elt.inspect }
=end