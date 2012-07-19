module GoogleDirections
  class Directions

    attr_accessor :points, :options, :results

    # Points is an array of strings consisting of Named Locations or comma seperated point data (latitude, longitude)
    # Options are:
    # * mode: driving, walking, bicycling, transit (defaults to driving)
    # * alternatives: true, false (defaults to false)
    # * avoid: tolls, highways
    # * units: metric, imperial (defaults to metric)
    # * region: any ccTLD
    # * departureTime: unixTimestamp (mandatory for transit mode)
    # * arrivalTime: unixTimestamp (mandatory for transit mode)
    # * optimize: true, false (defaults to false)

    def initialize points=[], options={}
      self.points = points
      self.options = options.merge({
          :mode => "driving",
          :alternatives => false,
          :units => "metric",
          :optimize => false
      })
      self.results =[]
    end

    def addPoint *args
      if args.size == 1
        if args[0].is_a?(Array)
          self.points << args[0].join(",")
        else
          self.points << args[0]
        end
      elsif args.size == 2
        self.points << args[0].to_s+","+args[1].to_s
      else
        throw ArgumentError.new("Wrong number of arguments: Only 1 or 2 arguments supported.")
      end
    end

    def get
      throw Exception.new("You need a minimum of two points to request directions!") if points.size < 2

      request_count = ((self.points.size-10.0)/9).ceil
      point_index = 0
      (0..request_count).each { |request_index|
        if request_count > 15
          sleep 0.2
        end
        end_index = point_index+9
        params = buildParams(self.points[point_index..end_index])
        response = HTTParty.get("https://maps.googleapis.com/maps/api/directions/json?"+params)
        self.results << Result.new(response.body)
        point_index = end_index
      }
      true
    end

      polyline = []
      self.results.each {|result|
        polyline += result.get_polyline(detailed, route)
      }
      polyline
    end

    private

    def buildParams points
      args = {}

      start_point = points.first
      end_point = points.last

      waypoints = points[1..(points.size-2)]
      waypoints << "optimize:true" if self.options[:optimize] if !waypoints.empty?

      args[:mode] = options[:mode]
      args[:alternatives] = options[:alternatives]
      args[:units] = options[:units]
      args[:origin] = start_point.to_s
      args[:destination] = end_point.to_s
      args[:waypoints] = waypoints.join("|") if !waypoints.empty?
      args[:region] = options[:region] if options[:region]
      args[:departureTime] = options[:departureTime] if options[:departureTime]
      args[:arrivalTime] = options[:arrivalTime] if options[:arrivalTime]
      args[:sensor] = false

      QueryParams.encode(args)
    end
  end
end