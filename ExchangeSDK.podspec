Pod::Spec.new do |s|
    s.name = "ExchangeSDK"
    s.version = "1.0.10"
    s.summary = "Summary"
    s.homepage = 'https://github.com/tangem/ExchangeSDK'
    s.description  = "Description"
    s.license = { :type => "MIT", :file => "LICENSE" }
    s.ios.deployment_target = "13.0"
    s.source = { :git => 'https://github.com/tangem/Exchanger.git', :tag => '1.0.8' }
    s.author = "Tangem AG"
    s.source_files = "Sources/Exchanger/**/*.swift"
    s.swift_version = "5.0"
    s.dependency 'Moya', '~> 15.0.0'
end
