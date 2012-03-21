require 'iactionable/connection.rb'
require 'iactionable/settings.rb'
require 'iactionable/objects.rb'

module IActionable
  
  class Api
    attr :connection
    attr :wrap_in_object
    
    @@settings = nil
  
    def initialize
      if @@settings
        @connection = IActionable::Connection.new(@@settings)
      else
        raise IActionable::ConfigError.new("IActionable::Api cannot be initialized without credentials being set in IActionable::Api.init_settings()")
      end
      @wrap_in_object = true
    end
  
    def self.init_settings(values)
      @@settings = IActionable::Settings.new(values)
    rescue IActionable::ConfigError => e
      raise e
    end
  
    def self.settings
      @@settings
    end
  
    def set_object_wrapping(bool)
      @wrap_in_object = !!bool
      self
    end
  
    # =================
    # = Event Logging =
    # =================
  
    def log_event(profile_type, id_type, id, event_key, event_attrs = {})
      response = @connection.request.with_app_key.with_api_key.to("/#{profile_type}/#{id_type}/#{id}/events/#{event_key}").with_params(event_attrs).post
    end
  
    # =====================
    # = Profile API calls =
    # =====================
  
    def get_profile_summary(profile_type, id_type, id, achievement_count = nil)
      request = @connection.request.with_app_key.to("/#{profile_type}/#{id_type}/#{id}")
      request.with_params(:achievementCount => achievement_count) unless achievement_count.blank?
      if @wrap_in_object
        IActionable::Objects::ProfileSummary.new(request.get)
      else
        request.get
      end
    end
  
    def create_profile(profile_type, id_type, id, display_name = nil)
      request = @connection.request.with_app_key.with_api_key.to("/#{profile_type}/#{id_type}/#{id}")
      request.with_params(:displayName => display_name) unless display_name.blank?
      request.post
    end
    alias_method :update_profile, :create_profile
  
    def add_profile_identifier(profile_type, id_type, id, alt_id_type, alt_id)
      @connection.request.with_app_key.with_api_key.to("/#{profile_type}/#{id_type}/#{id}/identifiers/#{alt_id_type}/#{alt_id}").post
    end
  
    # ====================
    # = Points API calls =
    # ====================
  
    def get_profile_points(profile_type, id_type, id, point_type)
      response = @connection.request.with_app_key.to("/#{profile_type}/#{id_type}/#{id}/points/#{point_type}").get
      if @wrap_in_object
        IActionable::Objects::ProfilePoints.new(response)
      else
        response
      end
    end
  
    def update_profile_points(profile_type, id_type, id, point_type, amount, reason = nil)
      request = @connection.request.with_app_key.with_api_key.to("/#{profile_type}/#{id_type}/#{id}/points/#{point_type}").with_params(:value => amount)
      request.with_params(:description => reason) unless reason.blank?
      if @wrap_in_object
        IActionable::Objects::ProfilePoints.new(request.post)
      else
        request.post
      end
    end
  
    # =========================
    # = Achievement API calls =
    # =========================
  
    def get_profile_achievements(profile_type, id_type, id, filter_type = nil)
      request = @connection.request.with_app_key
      case filter_type
      when :completed
        request.to("/#{profile_type}/#{id_type}/#{id}/achievements/Completed")
      when :available
        request.to("/#{profile_type}/#{id_type}/#{id}/achievements/Available")
      else
        request.to("/#{profile_type}/#{id_type}/#{id}/achievements")
      end
      
      if @wrap_in_object
        IActionable::Objects::ProfileAchievements.new(request.get)
      else
        request.get
      end
    end
  
    def get_achievements()
      response = @connection.request.with_app_key.to("/achievements").get
      if @wrap_in_object
        response.map{|achievement_json| IActionable::Objects::Achievement.new(achievement_json)}
      else
        response
      end
    rescue NoMethodError => e
      []
    end
  
    # ========================
    # = Challenges API calls =
    # ========================
  
    def get_profile_challenges(profile_type, id_type, id, filter_type = nil)
      request = @connection.request.with_app_key
      case filter_type
      when :completed
        request.to("/#{profile_type}/#{id_type}/#{id}/challenges/Completed")
      when :available
        request.to("/#{profile_type}/#{id_type}/#{id}/challenges/Available")
      else
        request.to("/#{profile_type}/#{id_type}/#{id}/challenges")
      end
      
      if @wrap_in_object
        IActionable::Objects::ProfileChallenges.new(request.get)
      else
        request.get
      end
    end
  
    def get_challenges()
      response = @connection.request.with_app_key.to("/challenges").get
      if @wrap_in_object
        response.map{|challenge_json| IActionable::Objects::Challenge.new(challenge_json)}
      else
        response
      end
    rescue NoMethodError => e
      []
    end
  
    # ===================
    # = Goals API calls =
    # ===================
  
    def get_profile_goals(profile_type, id_type, id, filter_type = nil)
      request = @connection.request.with_app_key
      case filter_type
      when :completed
        request.to("/#{profile_type}/#{id_type}/#{id}/goals/Completed")
      when :available
        request.to("/#{profile_type}/#{id_type}/#{id}/goals/Available")
      else
        request.to("/#{profile_type}/#{id_type}/#{id}/goals")
      end
      
      if @wrap_in_object
        IActionable::Objects::ProfileGoals.new(request.get)
      else
        request.get
      end
    end
  
    def get_goals()
      response = @connection.request.with_app_key.to("/goals").get
      if @wrap_in_object
        response.map{|goal_json| IActionable::Objects::Goal.new(goal_json)}
      else
        response
      end
    rescue NoMethodError => e
      []
    end
  
    # =========================
    # = Leaderboard API calls =
    # =========================
  
    def get_leaderboard(profile_type, point_type, leaderboard, page_number=nil, page_count=nil, id=nil, id_type=nil)
      request = @connection.request.with_app_key.to("/#{profile_type}/leaderboards/points/#{point_type}/#{leaderboard}")
      request.with_params(:pageNumber => page_number) unless page_number.blank?
      request.with_params(:pageCount => page_count) unless page_count.blank?
      request.with_params(:id => id) unless id.blank? || id_type.blank?
      request.with_params(:idType => id_type) unless id.blank? || id_type.blank?
      
      if @wrap_in_object
        IActionable::Objects::LeaderboardReport.new(request.get)
      else
        request.get
      end
    end
  
    # ===================================
    # = Profile Notifications API calls =
    # ===================================
  
    def get_profile_notifications(profile_type, id_type, id)
      response = @connection.request.with_app_key.to("/#{profile_type}/#{id_type}/#{id}/notifications").get

      if @wrap_in_object
        IActionable::Objects::ProfileNotifications.new(response)
      else
        response
      end
    end
  end
end