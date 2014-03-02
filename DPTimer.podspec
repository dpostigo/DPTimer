Pod::Spec.new do |s|
  s.name         = "DPTimer"
  s.version      = "0.0.2"
  s.summary      = "DPTimer"
  s.homepage     = "http://dpostigo.com"
  s.license      = 'BSD'
  s.author       = { "Dani Postigo" => "dani@firstperson.is" }


  s.source       = { :git => "https://github.com/dpostigo/DPTimer.git", :tag => s.version.to_s }
  s.platform     = :osx, '10.8'
  s.dependency     'DPKit'
  s.dependency     'NSView-DPFrameUtils'
  s.frameworks   = 'Foundation', 'QuartzCore'
  s.requires_arc = true

  s.source_files = 'DPTimer/*.{h,m}'


  s.subspec 'Data Views' do |dataViews|
    dataViews.source_files = 'DPTimer/Data Views/*.{h,m}'
  end


  s.dependency	'NSView-NewConstraints'
  s.dependency	'NSDate-Extensions'
  s.dependency  'NSColor-Crayola'
  
end
