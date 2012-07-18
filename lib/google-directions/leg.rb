module GoogleDirections
  class Leg
    attr_accessor :distance, :duration, :end_address, :end_location, :start_address, :start_location, :steps, :via_waypoint, :departure_time, :arrival_time

    def initialize leg
      self.distance = leg[:distance]
      self.duration = leg[:duration]
      self.start_address = leg[:start_address]
      self.start_location = leg[:start_location]
      self.end_address = leg[:end_address]
      self.end_location = leg[:end_location]
      self.steps =[]
      leg[:steps].each { |step|
        self.steps << Step.new(step)
      }
      self.via_waypoint = leg[:via_waypoint]
      self.departure_time = leg[:departure_time]
      self.arrival_time = leg[:arrival_time]
    end
  end
end