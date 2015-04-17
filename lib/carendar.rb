require "carendar/version"

module Carendar
  module Rails
    class Engine < ::Rails::Engine
    end
  end

  CalendarItem = Struct.new(:starts_at, :ends_at, :options) do
    attr_accessor :overlapping_with_earlier, :overlapping_with_later, :offset_right, :offset_left
    def day
      starts_at.beginning_of_day
    end

    def duration
      end_min - start_min
    end

    def start_min
      starts_at.hour * 60 + starts_at.min
    end

    def end_min
      ends_at.hour * 60 + ends_at.min
    end

    def color
      '#' + (0..2).map do
        VisitorsController.r.rand(255).to_i.to_s(16)
      end.join('')
    end
  end

  class CalendarDay
    attr_reader :day, :items

    def initialize(day, items)
      @day = day
      @items = items.map do |item|
        CalendarItem.new(item[:starts_at], item[:ends_at], item[:options] || {})
      end
      @items.sort_by!(&:start_min)
      @items.each do |item|
        item.overlapping_with_later = []
        item.offset_right = 0
        item.offset_left = 0
        item.overlapping_with_earlier = @items.select do |other|
          other.start_min <= item.start_min && other.end_min > item.start_min
        end
      end

      @items.each do |item|
        item.overlapping_with_earlier.each do |overlapper|
          overlapper.overlapping_with_later << item
        end
      end

      @items.each do |item|
        item.offset_left = if item.overlapping_with_earlier.any?
           item.overlapping_with_earlier.last.offset_left + 1
        else
          0
        end
      end
      @items.reverse.each do |item|
        item.offset_right = if item.overlapping_with_later.present?
           item.overlapping_with_later.first.offset_right + 1
        else
          0
        end
      end

    end

  end

  class Calendar
    attr_reader :days
    def initialize(from, to, item_hashes)
      items_by_day = item_hashes.group_by do |item_hash|
        item_hash[:starts_at].beginning_of_day
      end

      beginning_of_calendar = from.beginning_of_week
      end_of_calendar = to.end_of_week
      current_day = beginning_of_calendar
      @days = []
      while (current_day <= end_of_calendar) do
        @days << CalendarDay.new(current_day, items_by_day[current_day] || [])
        current_day += 1.day
      end
    end
  end
end
