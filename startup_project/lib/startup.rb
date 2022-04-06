require "employee"
require 'byebug'
class Startup  
    attr_reader :name, :funding, :salaries, :employees  
    def initialize(name, funding, salaries)
        @name = name 
        @funding = funding
        @salaries = {}
        @employees = []

        salaries.each do |title, salary|
            @salaries[title] = salary
        end
    end

    def valid_title?(title)
        if @salaries[title]
            return true
        else
            return false
        end
    end

    def >(startup)
        if self.funding > startup.funding
            return true
        else
            return false
        end
    end

    def hire(name, title)
        if self.valid_title?(title)
            @employees << Employee.new(name, title)
        else
            raise ArgumentError.new "not a valid title"     
        end
    end

    def size
        @employees.length
    end

    def pay_employee(employee)
        salary = @salaries[employee.title]
        if @funding >= salary
            employee.pay(salary)
            @funding -= salary
        else
            raise 'Not Enough Bread'
        end
    end

    def payday
        @employees.map {|el| pay_employee(el)}
    end

    def average_salary
        # debugger
        sum = 0
        @employees.each do |employee|
            sum += @salaries[employee.title]
        end
        sum / @employees.length
    end

    def close
        @employees = []
        @funding = 0
    end

    def acquire(startup2)
        @funding += startup2.funding
        startup2.salaries.each do |k, v|
            if !@salaries[k]
                @salaries[k] = v
            end
        end
        @employees.concat(startup2.employees)
        startup2.close
    end
end
