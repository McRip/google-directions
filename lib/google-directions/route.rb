module GoogleDirections
  class Route
    attr_accessor :bounds, :copyrights, :legs, :overview_polyline, :summary, :warnings, :waypoint_order

    def initialize route
      self.bounds = route[:bounds]
      self.copyrights = route[:copyrights]
      self.legs =[]
      route[:legs].each { |leg|
        self.legs << Leg.new(leg)
      }
      self.overview_polyline = Polylines::Decoder.decode_polyline(route[:overview_polyline][:points])
      self.summary = route[:summary]
      self.warnings = route[:warnings]
      self.waypoint_order = route[:waypoint_order]
    end
  end
end