Pod::Spec.new do |s|
    s.name = "ExchangeSdk"
    s.version = "1.0.2"
    s.summary = "API wrapper for 1inch service"
    s.homepage = 'https://github.com/tangem/exchange-sdk-swift'
    s.description  = "Use ExchangeSDK for simple integration 1inch swap router"
    # s.license = { :type => "MIT", :file => "LICENSE" }
    s.ios.deployment_target = "13.0"
    s.source = { :git => 'https://github.com/tangem/exchange-sdk-swift.git', :tag => s.version }
    s.author = "Tangem AG"
    s.source_files = "Sources/ExchangeSdk/**/*.swift"
    s.swift_version = "5.0"
    s.dependency 'Moya', '~> 15.0.0'
end
