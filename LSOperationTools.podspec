Pod::Spec.new do |s|

  
  s.name         = "LSOperationTools"
  s.version      = "0.0.5"
  s.summary      = "LSOperationTools."

  
  s.description  = <<-DESC 
                         LSOperationTools  业务工具组件，包括网络请求，图片加载，支付，分享，推送，缓存管理等
                   DESC

  s.homepage     = "https://github.com/LISONG040576/LSOperationTools.git"
  
  s.license      = "MIT"
  
  s.author             = { "lisong" => "lisong.s@haier.com" }
  
  s.source       = { :git => "https://github.com/LISONG040576/LSOperationTools.git", :tag => s.version.to_s }

#s.source_files  = "LSOperationTools/**/module/*.{h,m}","LSOperationTools/**/pushtool/*.{h,m}"


  s.subspec 'networking' do |s1|

	s1.source_files = "LSOperationTools/**/networking/*.{h,m}"
	
	s1.subspec 'AFN' do |ss1|
		
		ss1.source_files = "LSOperationTools/**/networking/AFN/*.{h,m}"
	end
	
  end

  s.subspec 'cachemanage' do |s2|

	s2.source_files = "LSOperationTools/**/cachemanage/*.{h,m}"
	
  end

  s.subspec 'paytool' do |s3|

	s3.source_files = "LSOperationTools/**/paytool/*.{h,m}"
	
  end

  s.subspec 'sharetool' do |s4|

	s4.source_files = "LSOperationTools/**/sharetool/*.{h,m}"
    s4.public_header_files = "LSOperationTools/LSOperationTools/sharetool/LSShareManager.h"
	
  end


s.subspec 'pushtool' do |s6|

s6.source_files = "LSOperationTools/**/pushtool/*.{h,m}"
s6.public_header_files = "LSOperationTools/LSOperationTools/pushtool/LSPushManager.h"


end


s.subspec 'module' do |s5|

s5.source_files = "LSOperationTools/**/module/*.{h,m}"



end




	


  s.requires_arc = true

  s.platform = :ios

  s.frameworks ="UIKit","Foundation"

  s.ios.deployment_target = '8.0'



  s.dependency "LSCommonality", "~> 0.0.13"

  s.dependency "LSMiddleWare", "~> 0.0.4"

  s.dependency "UMengUShare/Social/ReducedWeChat"

  s.dependency "UMengUShare/Social/ReducedQQ"

  s.dependency "UMengUShare/Social/ReducedSina"

  s.dependency "JPush", "~> 3.1.0"



















  # s.exclude_files = "Classes/Exclude"

  # s.public_header_files = "Classes/**/*.h"


  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  A list of resources included with the Pod. These are copied into the
  #  target bundle with a build phase script. Anything else will be cleaned.
  #  You can preserve files from being cleaned, please don't preserve
  #  non-essential files like tests, examples and documentation.
  #

  # s.resource  = "icon.png"
  # s.resources = "Resources/*.png"

  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"


  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Link your library with frameworks, or libraries. Libraries do not include
  #  the lib prefix of their name.
  #

  # s.framework  = "SomeFramework"
  # s.frameworks = "SomeFramework", "AnotherFramework"

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"


  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If your library depends on compiler flags you can set them in the xcconfig hash
  #  where they will only apply to your library. If you depend on other Podspecs
  #  you can include multiple dependencies to ensure it works.



  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"

end
