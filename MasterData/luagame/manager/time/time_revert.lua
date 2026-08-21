local Base = require("obj.base_component")
local M = Util.create_child_mt(Base)
local TypeTimeline = typeof(CS.Chronos.Timeline)
local GlobalMode = CS.Chronos.TimelineMode.Global
local MAX_RECORD_DURATION = 60
local DEF_RECORD_INTERVAL = 0.03

function M:_init()
  Base._init(self)
end

function M:init_gameobj(gameobj)
  self.v_gameobj = gameobj
  local comp = gameobj:GetComponent(TypeTimeline)
  if comp and not comp:IsNull() then
    self.v_timeline = comp
    self.v_timeline.enabled = false
  end
  self.v_born_time = Global.real_time
end

function M:get_born_time()
  return self.v_born_time
end

function M:update_born_time(v)
  self.v_born_time = v
end

function M:start_record(time_limit)
  if self.v_timeline == nil then
    self.v_timeline = self.v_gameobj:AddComponent(TypeTimeline)
  end
  self.v_timeline.enabled = true
  local duration = math.min(MAX_RECORD_DURATION, time_limit)
  local timeline = self.v_timeline
  timeline.enabled = true
  timeline.mode = GlobalMode
  timeline.globalClockKey = "Root"
  timeline.recordingDuration = duration
  timeline.recordingInterval = DEF_RECORD_INTERVAL
end

return M
