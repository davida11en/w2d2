require_relative "room"
require 'byebug'

class Hotel
    attr_reader :rooms
    def initialize(name, rooms)
        @name = name
        @rooms = {}
        rooms.each do |name, cap|
            @rooms[name] = Room.new(cap)
        end
    end

    def name
        fixd = []
        @name.split(' ').each do |word|
            fixd << word.capitalize
        end
        fixd.join(' ')
    end

    def room_exists?(roomname)
        if @rooms[roomname]
            return true
        else
            return false
        end
    end

    def check_in(person, roomname)
        exists = self.room_exists?(roomname)

        if !exists  
            p "sorry, room does not exist"
            return
        end

        room = @rooms[roomname]
        if room.add_occupant(person)
            p "check in successful"
        else
            p "sorry, room is full"
        end
    end 

    def has_vacancy?
        @rooms.each do |roomname, roominstance|
            if roominstance.capacity == roominstance.occupants.length
                return false
            else
                return true
            end
        end
    end

    def list_rooms
        res = []
        @rooms.each do |rmname, rm|
            res << rmname + " " + rm.available_space.to_s
        end
        puts res.join("\n") + "\n"
    end
end
