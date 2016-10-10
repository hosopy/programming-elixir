defmodule NationalWeatherServiceTest do
  use ExUnit.Case
  doctest Weather

  import Weather.NationalWeatherService, only: [ current_obs_url: 1,
                                                 decode_response: 1 ]

  test "current_obs_url" do
    assert current_obs_url("KALB") == "http://w1.weather.gov/xml/current_obs/KALB.xml"
    assert current_obs_url("kalb") == "http://w1.weather.gov/xml/current_obs/KALB.xml"
  end

  test "decode_response" do
    assert decode_response({:ok, test_xml}) == %{
      location:           "Denton Municipal Airport, TX",
      station_id:         "KDTO",
      observation_time:   "Last Updated on Oct 9 2016, 9:53 pm CDT",
      weather:            "Fair",
      temperature_string: "63.0 F (17.2 C)",
      wind_string:        "Northwest at 3.5 MPH (3 KT)",
      relative_humidity:  "63",
      pressure_string:    "1023.7 mb"}
  end

  def test_xml do
    """
    <?xml version="1.0" encoding="ISO-8859-1"?>
    <?xml-stylesheet href="latest_ob.xsl" type="text/xsl"?>
    <current_observation version="1.0"
    	 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
    	 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    	 xsi:noNamespaceSchemaLocation="http://www.weather.gov/view/current_observation.xsd">
    	<credit>NOAA's National Weather Service</credit>
    	<credit_URL>http://weather.gov/</credit_URL>
    	<image>
    		<url>http://weather.gov/images/xml_logo.gif</url>
    		<title>NOAA's National Weather Service</title>
    		<link>http://weather.gov</link>
    	</image>
    	<suggested_pickup>15 minutes after the hour</suggested_pickup>
    	<suggested_pickup_period>60</suggested_pickup_period>
    	<location>Denton Municipal Airport, TX</location>
    	<station_id>KDTO</station_id>
    	<latitude>33.20505</latitude>
    	<longitude>-97.20061</longitude>
    	<observation_time>Last Updated on Oct 9 2016, 9:53 pm CDT</observation_time>
            <observation_time_rfc822>Sun, 09 Oct 2016 21:53:00 -0500</observation_time_rfc822>
    	<weather>Fair</weather>
    	<temperature_string>63.0 F (17.2 C)</temperature_string>
    	<temp_f>63.0</temp_f>
    	<temp_c>17.2</temp_c>
    	<relative_humidity>63</relative_humidity>
    	<wind_string>Northwest at 3.5 MPH (3 KT)</wind_string>
    	<wind_dir>Northwest</wind_dir>
    	<wind_degrees>300</wind_degrees>
    	<wind_mph>3.5</wind_mph>
    	<wind_kt>3</wind_kt>
    	<pressure_string>1023.7 mb</pressure_string>
    	<pressure_mb>1023.7</pressure_mb>
    	<pressure_in>30.24</pressure_in>
    	<dewpoint_string>50.0 F (10.0 C)</dewpoint_string>
    	<dewpoint_f>50.0</dewpoint_f>
    	<dewpoint_c>10.0</dewpoint_c>
    	<visibility_mi>10.00</visibility_mi>
     	<icon_url_base>http://forecast.weather.gov/images/wtf/small/</icon_url_base>
    	<two_day_history_url>http://www.weather.gov/data/obhistory/KDTO.html</two_day_history_url>
    	<icon_url_name>nskc.png</icon_url_name>
    	<ob_url>http://www.weather.gov/data/METAR/KDTO.1.txt</ob_url>
    	<disclaimer_url>http://weather.gov/disclaimer.html</disclaimer_url>
    	<copyright_url>http://weather.gov/disclaimer.html</copyright_url>
    	<privacy_policy_url>http://weather.gov/notice.html</privacy_policy_url>
    </current_observation>
    """
  end
end
