Pod::Spec.new do |s|
  
  s.name        = "PPBlinkOCR"
  s.version     = "1.1.1"
  s.summary     = "A state-of-the-art OCR module for mobile devices"
  s.homepage    = "http://microblink.com"
  
  s.description = <<-DESC
       BlinkOCR SDK is a state-of-the-art OCR module for mobile devices. It's OCR technology is optimized 
       specifically for mobile devices and architectures. This allows faster results and lower error rate 
       than regular desktop-based OCR software. BlinkOCR features: 

        - integrated camera management
        - integrated **text parsing** feature for fields like IBANs, prices, email addresses, urls, and many more!
        - layered API, allowing everything from simple integration to complex UX customizations.
        - lightweight and no internet connection required
        - enteprise-level security standards
        DESC
  
  s.license     = { 
        :type => 'commercial',
        :text => <<-LICENSE
                © 2013-2015 MicroBlink Ltd. All rights reserved.
                LICENSE
        }

  s.authors     = {
        "MicroBlink" => "info@microblink.com",
        "Jurica Cerovec" => "jurica.cerovec@microblink.com"
  }

  s.source      = { 
        :git => 'https://github.com/BlinkOCR/blinkocr-ios.git', 
        :tag => 'v1.1.1'
  }
  
  s.preserve_paths = 'MicroBlink.embeddedframework/*'

  s.platform     = :ios

  # ――― MULTI-PLATFORM VALUES ――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.ios.deployment_target = '6.0.0'
  s.ios.source_files = 'MicroBlink.embeddedframework/MicroBlink.framework/Versions/A/Headers/*.{h}'
  s.ios.header_dir = 'MicroBlink'
  s.ios.public_header_files = "MicroBlink.embeddedframework/MicroBlink.framework/Versions/A/Headers/*.h"
  s.ios.resources = "MicroBlink.embeddedframework/MicroBlink.framework/Versions/A/Resources/*.{strings,wav,png,zzip}"
  s.ios.requires_arc = false
  
  s.ios.xcconfig = { 
        'FRAMEWORK_SEARCH_PATHS' => '"$(PODS_ROOT)/PPBlinkOCR/MicroBlink.embeddedframework"'
  }

  s.ios.frameworks = 'MicroBlink', 'AVFoundation', 'AudioToolbox', 'CoreMedia'
  s.ios.libraries = 'c++', 'iconv'

end
