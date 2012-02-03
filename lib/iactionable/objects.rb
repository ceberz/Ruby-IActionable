module IActionable
  module Objects
  end
end

require 'iactionable/objects/i_actionable_object.rb'
require 'iactionable/objects/progress.rb'
require 'iactionable/objects/awardable.rb'

IActionable::Objects::IActionableObject.send(:include, IActionable::Objects::Awardable)

require 'iactionable/objects/achievement.rb'
require 'iactionable/objects/challenge.rb'
require 'iactionable/objects/goal.rb'
require 'iactionable/objects/identifier.rb'
require 'iactionable/objects/leaderboard.rb'
require 'iactionable/objects/leaderboard_report.rb'
require 'iactionable/objects/level_type.rb'
require 'iactionable/objects/level.rb'
require 'iactionable/objects/point_type.rb'
require 'iactionable/objects/profile_level.rb'
require 'iactionable/objects/profile_points.rb'
require 'iactionable/objects/profile_summary.rb'
require 'iactionable/objects/profile_achievements.rb'
require 'iactionable/objects/profile_challenges.rb'
require 'iactionable/objects/profile_goals.rb'
require 'iactionable/objects/profile_notifications.rb'
