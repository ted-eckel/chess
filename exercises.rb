class Employee
  attr_reader :name,:title,:salary,:boss
  def initialize(name,title,salary,boss)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
    @boss.employees << self unless boss.nil?
  end

  def inspect
    "#{@name}: #{@title}, #{@salary}, Boss: #{@boss.name}"
  end

  def bonus(multiplier)
    salary * multiplier
  end
end

class Manager < Employee
  attr_reader :employees
  def initialize(name,title,salary,boss)
    super(name,title,salary,boss)
    @employees = []
  end

  def inspect
    super.inspect + "Employees: " + employees.map(&:inspect).join(" ")
  end

  def employees_salaries
    total = 0
    employees.each do |employee|
      if employee.is_a?(Manager)
        total += employee.employees_salaries
      end
      total += employee.salary
    end
    total
  end

  def bonus(multiplier)
    employees_salaries * multiplier
  end
end

if $PROGRAM_NAME == __FILE__
  ned = Manager.new("Ned", "Founder", 1000000, nil)
  darren = Manager.new("Darren", "TA Manager", 78000, ned)
  shawna = Employee.new("Shawna", "TA", 12000, darren)
  david = Employee.new("David", "TA", 10000, darren)

  p ned.bonus(5)
  p darren.bonus(4)
  p david.bonus(3)
end
