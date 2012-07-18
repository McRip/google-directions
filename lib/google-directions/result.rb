module GoogleDirections
  class Result
    attr_accessor :routes, :status

    def initialize json
      res = MultiJson.load json, :symbolize_keys => true
      self.status = res[:status]
      self.routes =[]
      res[:routes].each { |route|
        self.routes << Route.new(route)
      }
    end

    def get_polyline(detailed=false, route=0)
      throw ArgumentError.new("Route with index "+route.to_s+" not available") if !self.routes[route]
      polyline = []
      if detailed
        self.routes[route].legs.each {|leg|
          leg.steps.each {|step|
            polyline += step.polyline
          }
        }
      else
        polyline += self.routes[route].overview_polyline
      end
      polyline
    end
  end
end