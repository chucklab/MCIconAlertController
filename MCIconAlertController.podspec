Pod::Spec.new do |s|
  s.name         = "MCIconAlertController"
  s.version      = "0.0.16"
  s.summary      = "Alert controller with icon."
  s.description  = <<-DESC
  Alert controller with icon, have fun.
                   DESC
  s.homepage     = "https://github.com/chucklab/MCIconAlertController"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author             = { "Chuck MA" => "chuck@chucklab.com" }
  s.platform     = :ios, '8.0'
  s.ios.deployment_target = '8.0'
  s.source       = { :git => "https://github.com/imegatron/MCIconAlertController.git", :tag => "#{s.version}" }
  s.source_files  = "Classes"
  s.exclude_files = "Classes/Exclude"
  s.public_header_files = "Classes/*.h"
  s.frameworks = "Foundation", "UIKit"
  s.requires_arc = true
  s.dependency 'Masonry', '~> 1.0'
end
