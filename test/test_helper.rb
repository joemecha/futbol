require "simplecov"

SimpleCov.start

require 'pry'
require "minitest/autorun"
require "minitest/pride"
require "mocha/minitest"
require "csv"

require './lib/data_loadable'
require "./lib/game_team"
require "./lib/game"
require "./lib/league_statistics"
require "./lib/season_statistics"
require "./lib/stat_tracker"
require "./lib/team"
require "./lib/game_manager"
require "./lib/game_team_manager"
require "./lib/team_manager"
