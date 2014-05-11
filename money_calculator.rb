class MoneyCalculator
  attr_accessor :ones, :fives, :tens, :twenties, :fifties, :hundreds, :five_hundreds, :thousands, :money
  def initialize(ones, fives, tens, twenties, fifties, hundreds, five_hundreds, thousands)
    self.ones = ones
    self.fives = fives
    self.tens = tens
    self.twenties = twenties
    self.fifties = fifties
    self.hundreds = hundreds
    self.five_hundreds = five_hundreds
    self.thousands = thousands
    self.money = (ones * 1) + (fives * 5) + (tens * 10) + (twenties * 20) + (fifties * 50) + (hundreds * 100) + (five_hundreds * 500)  + (thousands * 1000)
    @money = money
  end

NOTES = { :thousands => 1000, :five_hundreds => 500, :hundreds => 100,
           :fifties => 50, :twenties => 20, :tens => 10, 
           :fives => 5, :ones => 1 }
def change(x)
  cost = x
  money = @money
  change = money - cost

  Hash.new { |hash, key| hash[key] = 0 }.tap do |notes| 
    NOTES.each do |name, value|
      while change >= value
        change -= value
        notes[name] += 1
      end
    end
  end
end
  


end