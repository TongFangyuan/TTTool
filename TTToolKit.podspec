#
#  Be sure to run `pod spec lint TTToolKit.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

# 验证语法
# pod lib lint --allow-warnings

# 将当前本地的podspec文件传到CocoaPods官方的索引库中
# pod trunk register 573682532@qq.com 'tong' --description='mac mini' --verbose
# pod trunk push TTToolKit.podspec --allow-warnings

# 🔥🔥🔥 在此处编辑版本号
version = "0.1.13";

Pod::Spec.new do |spec|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  spec.name         = "TTToolKit"
  spec.version      = version
  spec.summary      = "TTToolKit工具类"
  spec.description  = <<-DESC
                    An integrated, simple, independent, efficient, lightweight, and continuously updated image selects a third-party framework.
                   DESC
  spec.homepage     = "https://github.com/TongFangyuan/TTTool"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author             = { "tongfy" => "573682532@qq.com" }
  spec.platform     = :ios, "9.0"
  spec.ios.deployment_target = "9.0"
  spec.source       = { :git => "https://github.com/TongFangyuan/TTTool.git", :tag => "#{version}" }
  spec.requires_arc = true
  spec.frameworks = 'UIKit'
  spec.resource     = 'TTToolKit/TTToolKit.bundle'

  # 代码源文件地址，**/*表示Classes目录及其子目录下所有文件，如果有多个目录下则用逗号分开，
  # 如果需要在项目中分组显示，这里也要做相应的设置
  spec.source_files  = 'TTToolKit/TTToolKit.h'
  spec.public_header_files = 'TTToolKit/TTToolKit.h'
  # 资源文件地址
  # spec.exclude_files = "Classes/Exclude"

  spec.subspec 'UIKit' do |uikit|
    uikit.source_files = 'TTToolKit/UIKit/*.{h,m}'
    uikit.public_header_files = 'TTToolKit/UIKit/*.h'
  end

  spec.subspec 'Foundation' do |foundation|
    foundation.source_files = 'TTToolKit/Foundation/*.{h,m}'
    foundation.public_header_files = 'TTToolKit/Foundation/*.h'
  end

  spec.subspec 'Helper' do |helper|
    helper.source_files = 'TTToolKit/Helper/*.{h,m}'
    helper.public_header_files = 'TTToolKit/Helper/*.h'
  end

  spec.subspec 'MediaPlayer' do |mediaPlayer|
    mediaPlayer.source_files = 'TTToolKit/MediaPlayer/*.{h,m}'
    mediaPlayer.public_header_files = 'TTToolKit/MediaPlayer/*.h'
  end

  spec.subspec 'Base' do |base|
    base.source_files = 'TTToolKit/Base/*.{h,m}'
    base.public_header_files = 'TTToolKit/Base/*.h'
  end

end
