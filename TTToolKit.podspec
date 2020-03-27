#
#  Be sure to run `pod spec lint TTToolKit.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

# 验证语法
# pod lib lint

# 将当前本地的podspec文件传到CocoaPods官方的索引库中
# pod trunk register 573682532@qq.com 'tong' --description='mac mini' --verbose
# pod trunk push TTToolKit.podspec 

version = "0.0.3";

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
  #  When using multiple platforms
  # spec.ios.deployment_target = "5.0"
  # spec.osx.deployment_target = "10.7"
  # spec.watchos.deployment_target = "2.0"
  # spec.tvos.deployment_target = "9.0"

  spec.source       = { :git => "https://github.com/TongFangyuan/TTTool.git", :tag => "#{version}" }


  
  # 代码源文件地址，**/*表示Classes目录及其子目录下所有文件，如果有多个目录下则用逗号分开，
  # 如果需要在项目中分组显示，这里也要做相应的设置
  spec.source_files  = "TTTool", "TTTool/TTTool.h"
  spec.public_header_files = "TTTool/TTTool.h"
  # 资源文件地址
  # spec.exclude_files = "Classes/Exclude"

  #Marco
  spec.subspec 'Macro' do |macro|
    macro.source_files = 'TTTool/Macro/MacroHeader.h'
    macro.public_header_files = 'TTTool/Macro/MacroHeader.h'
  end

  # Categories
  spec.subspec 'Categories' do |categories|
    categories.source_files = 'TTTool/Categories/TTCategoriesHeader.h'
    categories.public_header_files = 'TTTool/Categories/TTCategoriesHeader.h'
    #三级
    categories.subspec 'Foundation' do |foundation|
      foundation.source_files = 'TTTool/Categories/Foundation/TTFoundation.h'
      foundation.public_header_files = 'TTTool/Categories/Foundation/TTFoundation.h'
      #四级
      foundation.subspec 'NSDate' do |date|
        date.source_files = 'TTTool/Categories/Foundation/NSDate/*.h'
      end
      foundation.subspec 'NSArray' do |array|
        array.source_files = 'TTTool/Categories/Foundation/NSArray/*.h'
        # array.source_files = 'TTTool/Categories/Foundation/NSArray/*.m'
      end
    end
  end

end
