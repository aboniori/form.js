webdriver = require 'webdriverio'

exports.getBrowser = ->
  console.log("GetBrowser", process.env.BROWSER, process.env.PLATFORM, process.env.VERSION)
  caps =
    browserName:        process.env.BROWSER.replace(/_/g,' ') ? 'phantomjs'
    # deviceName:        process.env.DEVICE_NAME
    # deviceOrientation: process.env.DEVICE_ORIENTATION
    'phantomjs.binary.path': './node_modules/phantomjs/bin/phantomjs'
    logLevel: 'verbose'

  caps.deviceName = process.env.DEVICE_NAME.replace(/_/g,' ') if process.env.DEVICE_NAME
  caps.platform =   process.env.PLATFORM.replace(/_/g,' ') if process.env.PLATFORM
  caps.version =    process.env.VERSION.replace(/_/g,' ') if process.env.VERSION

  opts =
    desiredCapabilities: caps

  if process.env.TRAVIS?
    opts =
      desiredCapabilities: caps
      host: 'ondemand.saucelabs.com'
      port: 80
      user: process.env.SAUCE_USERNAME
      key: process.env.SAUCE_ACCESS_KEY
      logLevel: 'silent'

    # annotate tests with travis info
    caps.name = process.env.TRAVIS_COMMIT
    caps.tags = [
      process.env.TRAVIS_PULL_REQUEST
      process.env.TRAVIS_BRANCH
      process.env.TRAVIS_BUILD_NUMBER
    ]
    caps['tunnel-identifier'] = process.env.TRAVIS_JOB_NUMBER
  else
    caps.browserName = 'chrome'

  webdriver.remote(opts).init()

 # webdriver = require 'webdriverio'

# exports.getBrowser = ->
#   browserName = process.env.BROWSER

#   opts =
#     desiredCapabilities:
#       browserName: browserName ? 'phantomjs'
#       'phantomjs.binary.path': './node_modules/phantomjs/bin/phantomjs'
#       logLevel: 'verbose'

#   if process.env.TRAVIS?
#     opts =
#       desiredCapabilities:
#         browserName: browserName
#         name: process.env.TRAVIS_COMMIT
#         tags: [
#           process.env.TRAVIS_PULL_REQUEST
#           process.env.TRAVIS_BRANCH
#           process.env.TRAVIS_BUILD_NUMBER
#         ]
#         'tunnel-identifier': process.env.TRAVIS_JOB_NUMBER
#       host: 'ondemand.saucelabs.com'
#       port: 80
#       user: process.env.SAUCE_USERNAME
#       key: process.env.SAUCE_ACCESS_KEY
#       logLevel: 'silent'

#   webdriver.remote(opts).init()
