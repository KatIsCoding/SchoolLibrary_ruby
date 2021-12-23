class Rental

  attr_accessor :date, :book, :owner
  def initialize(date, book, owner)
    @date = date
    @book = book
    @owner = owner
  end
  def book(book = @book)
    @book.add_rental(self)
  end
  def owner(owner = @owner)
    @owner.add_rental(self)
  end
    
end