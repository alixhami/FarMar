require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

require_relative '../far_mar'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
