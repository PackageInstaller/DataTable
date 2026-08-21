local Base = require("obj.state.state_idle")
local ACT_DEFINE = Config.ACT_DEFINE
local M = Util.create_child_mt(Base)
local BATTLE_IDLE_TIME = 2
local COMMON_IDLE = 1
local STAND_CHANGE = 2
local BATTLE_IDLE = 3

function M:state_on_enter(...)
  Base.state_on_enter(self, ...)
  if self.v_owner:is_hero() then
    BehaviorMgr:call_behavior_fun(self.v_owner, BehaviorMgr.EVENTS.ON_ROLE_BEHIT_STATE_CHANGE, Config.BEHIT_STATE_TYPE.ENTER_IDLE)
  end
end

function M:state_update_value(reset)
  if reset then
    self:_on_common()
  else
    self:_on_battle()
  end
  self.v_enter_time = self.v_owner.time_mgr:get_time()
end

function M:state_on_leave()
  Base.state_on_leave(self)
  self.v_state = nil
  self.v_owner:set_idle_stand_changing(false)
end

function M:state_update()
  Base.state_update(self)
  local now_time = self.v_owner.time_mgr:get_time()
  if self.v_state == BATTLE_IDLE and now_time - self.v_battle_time >= 2.5 and self.v_owner.gameobj.activeInHierarchy then
    self:_on_change()
  end
end

function M:_on_common()
  self.v_state = COMMON_IDLE
  self.v_state_manager:try_action(ACT_DEFINE.Idle, 0, nil, nil, true)
  self.v_owner:set_idle_stand_changing(false)
end

function M:_on_battle()
  self.v_state = BATTLE_IDLE
  self.v_state_manager:try_action(ACT_DEFINE.Idle2, 0, nil, nil, true)
  self.v_battle_time = self.v_owner.time_mgr:get_time()
  self.v_owner:set_idle_stand_changing(false)
end

function M:_on_change()
  self.v_state = STAND_CHANGE
  self.v_owner:set_idle_stand_changing(true)
  self.v_state_manager:try_action(ACT_DEFINE.StandChange, 0, function()
    self.v_owner:set_idle_stand_changing(false)
    if self.v_state == STAND_CHANGE then
      self:_on_common()
    end
  end, nil)
end

return M
