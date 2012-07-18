require "rspec"
require "google-directions"

describe "Directions" do

  it "should addPoints" do
    gd = GoogleDirections::Directions.new
    gd.addPoint "Hamburg, Germany"
    gd.points.size.should == 1
  end

  it "should fail when requesting directions with one point" do
    gd = GoogleDirections::Directions.new
    gd.addPoint "Hamburg, Germany"
    lambda {gd.get}.should raise_error(Exception)
  end

  it "should get route between two points" do
    gd = GoogleDirections::Directions.new(["Hamburg, Germany", "Elmshorn, Germany"])
    gd.get
    gd.results.size.should == 1
    gd.results[0].status.should == "OK"
  end

  it "should get route directions between 10 points" do
    gd = GoogleDirections::Directions.new(["Hamburg, Germany","Pinneberg, Germany", "Tornesch ,Germany", "Uetersen ,Germany", "Elmshorn, Germany", "Barmstedt ,Germany", "Kaltenkirchen ,Germany",  "Bad Oldeslohe ,Germany", "Neumuenster ,Germany", "Kiel ,Germany",])
    gd.get
    gd.results.size.should == 1
    gd.results[0].status.should == "OK"
  end

  it "should get route directions between 11 points" do
    gd = GoogleDirections::Directions.new(["Hannover, Germany", "Hamburg, Germany","Pinneberg, Germany", "Tornesch ,Germany", "Uetersen ,Germany", "Elmshorn, Germany", "Barmstedt ,Germany", "Kaltenkirchen ,Germany",  "Bad Oldeslohe ,Germany", "Neumuenster ,Germany", "Kiel ,Germany",])
    gd.get
    gd.results.size.should == 2
    gd.results[0].status.should == "OK"
    gd.results[1].status.should == "OK"
  end

  it "should get route directions between 21 points" do
    gd = GoogleDirections::Directions.new(["Muenchen, Germany", "Nuernberg, Germany", "Chemnitz, Germany", "Berlin, Germany", "Rostock, Germany", "Kassel, Germany", "Bielefeld, Germany", "Dortmund, Germany", "Bochum, Germany", "Duesseldorf, Germany", "Hannover, Germany", "Hamburg, Germany","Pinneberg, Germany", "Tornesch ,Germany", "Uetersen ,Germany", "Elmshorn, Germany", "Barmstedt ,Germany", "Kaltenkirchen ,Germany",  "Bad Oldeslohe ,Germany", "Neumuenster ,Germany", "Kiel ,Germany",])
    gd.get
    gd.results.size.should == 3
    gd.results[0].status.should == "OK"
    gd.results[1].status.should == "OK"
    gd.results[2].status.should == "OK"
  end

  it "should create combined polyline overview" do
    gd = GoogleDirections::Directions.new(["Hamburg, Germany", "Elmshorn, Germany"])
    gd.get
    polyline = gd.get_polyline
    Digest::MD5.hexdigest(polyline.to_s).should == "a8bc39ffaed6b60baea4cdc4ff4e020f"
  end

  it "should create combined detailed polyline" do
    gd = GoogleDirections::Directions.new(["Hamburg, Germany", "Elmshorn, Germany"])
    gd.get
    polyline = gd.get_polyline(true)
    Digest::MD5.hexdigest(polyline.to_s).should == "f01ff5ca2e5484ed543562fb480f9ebc"
  end

  it "should throw exception when requesting polyline for unavailable route" do
    gd = GoogleDirections::Directions.new(["Hamburg, Germany", "Elmshorn, Germany"])
    gd.get
    lambda {gd.get_polyline(false, 1)}.should raise_error(ArgumentError)
  end
end