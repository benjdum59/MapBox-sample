# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'

def common_pods
  pod 'Mapbox-iOS-SDK', '~> 3.7'
  pod 'MapboxGeocoder.swift', '~> 0.8'
  pod 'RxCocoa', '~> 4.1'
  pod 'Hero', '~> 1.1'
end

target 'MapBox-sample' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for MapBox-sample
  common_pods
 
  target 'MapBox-sampleTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'MapBox-sampleUITests' do
    inherit! :search_paths
    # Pods for testing
    common_pods
  end

end
