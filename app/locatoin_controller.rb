class LocationController < UIViewController
  def viewDidLoad
    view.backgroundColor = UIColor.underPageBackgroundColor
    create_location_label
    check_location
  end

  def check_location
    if (CLLocationManager.locationServicesEnabled)
      @location_manager = CLLocationManager.alloc.init
      @location_manager.desiredAccuracy = KCLLocationAccuracyKilometer
      @location_manager.delegate = self
      @location_manager.purpose = "Our applications functionality is based on your current location"
      @location_manager.startUpdatingLocation
    else
      show_error_message("Please enable the Location Services for this app in Settings.")
    end
  end

  def create_location_label
    @latitudeLabel = UILabel.alloc.initWithFrame([[25,30],[250,40]])
    @latitudeLabel.backgroundColor = UIColor.clearColor

    @longitudeLabel = UILabel.alloc.initWithFrame([[25,80],[250,40]])
    @longitudeLabel.backgroundColor = UIColor.clearColor
    @latitudeLabel.text = "Latitude:"
    @longitudeLabel.text = "Longitude:"
    view.addSubview(@latitudeLabel)
    view.addSubview(@longitudeLabel)
  end

  def locationManager(manager, didUpdateToLocation:newLocation, fromLocation:oldLocation)
    @latitudeLabel.text = @latitudeLabel.text + newLocation.coordinate.latitude.to_s
    @longitudeLabel.text = @longitudeLabel.text + newLocation.coordinate.longitude.to_s
  end

  def locationManager(manager, didFailWithError:error)
    show_error_message("Please enable the Location Services for this app in Settings.")
  end

  def show_error_message msg
    alert = UIAlertView.new
    alert.message = msg
    alert.show
  end
end
