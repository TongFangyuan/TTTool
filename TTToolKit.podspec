#
# Be sure to run `pod lib lint TTToolKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TTToolKit'
  s.version          = '0.1.0'
  s.summary          = 'A short description of TTToolKit.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/TongFangyuan/TTTool'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'TongFangyuan' => '9019860+TongFangyuan@users.noreply.github.com' }
  s.source           = { :git => 'https://github.com/TongFangyuan/TTTool.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'TTToolKit/Classes/**/*'
  s.resource     = 'TTToolKit/Assets/TTToolKit.bundle'
  
  s.subspec 'Encryption' do |ency|
      ency.source_files = 'TTToolKit/Classes/Encryption/*.{h,m}'
      ency.public_header_files = 'TTToolKit/Classes/Encryption/*.h'
  end
  
  s.subspec 'Helper' do |helper|
      helper.source_files = 'TTToolKit/Classes/Helper/*.{h,m}'
      helper.public_header_files = 'TTToolKit/Classes/Helper/*.h'
  end
  
  s.subspec 'Keychain' do |keychain|
      keychain.source_files = 'TTToolKit/Classes/Keychain/*.{h,m}'
      keychain.public_header_files = 'TTToolKit/Classes/Keychain/*.h'
  end
  
  s.subspec 'Log' do |log|
      log.source_files = 'TTToolKit/Classes/Log/*.{h,m}'
      log.public_header_files = 'TTToolKit/Classes/Log/*.h'
  end
  
  s.subspec 'UX' do |ux|
      ux.source_files = 'TTToolKit/Classes/UX/*.{h,m}'
      ux.public_header_files = 'TTToolKit/Classes/UX/*.h'
  end
  
  # s.resource_bundles = {
  #   'TTToolKit' => ['TTToolKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'TTCategories', '~> 0.0.1'
end
