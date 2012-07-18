module GoogleDirections
  class Step < Leg
    attr_accessor :polyline, :html_instructions, :travel_mode, :transit_details , :sub_steps

    def initialize step
      self.distance = step[:distance]
      self.duration = step[:duration]
      self.start_location = step[:start_location]
      self.end_location = step[:end_location]
      self.html_instructions = step[:html_instructions]
      self.travel_mode = step[:travel_mode]
      self.polyline = Polylines::Decoder.decode_polyline(step[:polyline][:points])
      self.transit_details = step[:transit_details]
      self.sub_steps =[]
      step[:sub_steps].each {|sub_step|
        self.sub_steps << Step.new(sub_step)
      } if step[:sub_steps]
    end
  end
end