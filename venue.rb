require('pry')
class Venue

  attr_reader :name, :rooms, :bank_account, :stock

  def initialize(name, rooms, bank_account, stock)
    @name = name
    @rooms = rooms
    @bank_account = bank_account
    @stock = stock
  end

  def stock_level(item)
    return @stock[item]
  end

  def add_item(item)
    if @stock.include?(item)
      @stock[item] += 1
    else
      @stock[item] = 1
    end
  end

  def remove_item(item)
    @stock[item] -= 1
  end
# Transfer money received from a room to the venue's bank account.
  def transfer_money(room_name)
    room = @rooms.find { |room| room.name == room_name }
    amount = room.money_received
    room.minus_money(amount)
    @bank_account += amount
  end
# Restock a room with food or drinks.
  def restock_room(item, room)
    remove_item(item)
    if item.type == "drink"
      room.add_drink(item)
    elsif item.type == "food"
      room.add_food(item)
    end
  end

end
