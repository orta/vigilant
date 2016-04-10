Pod::Spec.new do |s|
  s.name             = "Vigilant"
  s.version          = "1.0.0"
  s.summary          = "Glues Quick & Nimble together. Makes sure you run an expectation on every test."
  s.description      = <<-DESC
                        Be Quick, be Nimble, be Vigilent. Vigilent keeps track of whether any test
                        runs it's expectations. This makes it easier to notice when you have async code
                        which "passes" because the expectations are not ran during the test.
                       DESC

  s.homepage         = "https://github.com/orta/vigilant"
  s.license          = 'MIT'
  s.author           = { "Orta Therox" => "orta.therox@gmail.com" }
  s.source           = { :git => "https://github.com/orta/vigilant.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/orta'
  s.source_files = 'Vigilent/Classes/**/*'
  s.frameworks = 'Foundation', 'XCTest'
  s.dependency 'Quick'
  s.dependency 'Nimble'
end
