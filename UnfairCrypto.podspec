Pod::Spec.new do |s|
    s.name = 'UnfairCrypto'
    s.version = '0.9.3'
    s.summary = 'This is an example of a cross-platform Swift framework!'
    s.source = { :git => 'https://github.com/UnfairAdvantageAB/UnfairCrypto', :tag => s.version }
    s.authors = 'Unfair Advantage AB'
    s.license = 'Copyright'
    s.homepage = 'unfair.me'

    s.ios.deployment_target = '11.3'
    s.osx.deployment_target = '10.13'

    s.source_files = 'Framework/**/*.swift'
    s.dependency 'Alamofire', '4.7'
    s.dependency 'Starscream', '~> 3.0.2'
end
