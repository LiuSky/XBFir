#
# Be sure to run `pod lib lint XBFir.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'XBFir'
  s.version          = '1.0.0'
  s.summary          = 'A short description of XBFir.'
  s.homepage         = 'https://github.com/LiuSky/XBFir'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Sky' => '327847390@qq.com' }
  s.source           = { :git => 'https://github.com/LiuSky/XBFir.git', :tag => s.version.to_s }
  s.swift_version         = '4.2'
  s.ios.deployment_target = '9.0'
  s.source_files = 'XBFir/Classes/**/*'
end
