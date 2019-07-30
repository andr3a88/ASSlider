Pod::Spec.new do |s|
  s.name             = 'ASSlider'
  s.version          = '1.0.0'
  s.summary          = 'An enhanced UISlider subclass'
  s.description      = <<-DESC
An enhanced UISlider subclass that add a pin above the slider with the current slider index
                       DESC

  s.homepage         = 'https://github.com/andr3a88/ASSlider'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'andr3a88' => 'runner_corsa@msn.com' }
  s.source           = { :git => 'https://github.com/andr3a88/ASSlider.git', :tag => s.version.to_s }
  s.swift_version    = '5.0'

  s.ios.deployment_target = '10.0'

  s.source_files = 'ASSlider/Classes/**/*'
  
  s.resource_bundles = {
      'ASSlider' => ['ASSlider/Assets/**/*.png', 'ASSlider/Assets/**/*.xcassets']
  }
end
