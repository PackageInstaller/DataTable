local M = Util.create_class()
local PLAYER_STATE_TBL = ShareRes.create("player_state_tbl")
local MONSTER_STATE_TBL = ShareRes.create("monster_state_tbl")
local STATE_DEFINE = ShareRes.create("state_define")
local STATE_RELATION = Config.STATE_RELATION

function M:_init(owner, state_manager)
  self.v_owner = owner
  self.v_state_manager = state_manager
  state_manager:register_state(self)
  if owner and type(owner) == "table" then
    if owner:is_monster() or owner:is_npc() then
      self.v_state_tbl = MONSTER_STATE_TBL[self:state_get_name()]
    elseif owner:is_player() or owner:is_hero() then
      self.v_state_tbl = PLAYER_STATE_TBL[self:state_get_name()]
    end
  end
end

function M:on_destroy()
  self.v_owner = nil
  self.v_state_manager = nil
  self.v_state_tbl = nil
end

function M:has_old_state()
  return self.v_has_old_state
end

function M:set_has_old_state(has_old)
  self.v_has_old_state = has_old
end

function M:state_update()
end

function M:state_on_enter()
  self.in_state = true
end

function M:state_on_leave()
  self.in_state = false
  self.v_protection = false
end

function M:state_update_value(...)
end

function M:state_get_name()
  assert(nil)
end

function M:state_can_transit(state_name)
  local tbl = self.v_state_tbl
  if not tbl then
    Global.log.Debug("transit_tbl not exist: " .. self:state_get_name())
    return true
  end
  local state_relation = self.v_state_tbl[state_name]
  if not state_relation then
    local msg = string.format("state_relation not exist: %s %s", self:state_get_name(), state_name)
    Global.log.Debug(msg)
    return false
  end
  if state_relation == STATE_RELATION.can_transit or state_relation == STATE_RELATION.can_coexist then
    return true
  end
  return false
end

function M:state_can_coexist(state_name)
  local tbl = self.v_state_tbl
  if not tbl then
    return false
  end
  local state_relation = self.v_state_tbl[state_name]
  if not state_relation then
    local msg = string.format("state_can_coexist, state_relation not exist: %s %s", self:state_get_name(), state_name)
    Global.log.Debug(msg)
    return false
  end
  return state_relation == STATE_RELATION.can_coexist
end

function M:state_can_reenter()
  return true
end

function M:state_has_action()
  local tbl = STATE_DEFINE[self:state_get_name()]
  return tbl and tbl["是否有动作"]
end

function M:state_do_exit()
  if self.v_protection then
    return
  end
  self.v_state_manager:exit_state(self:state_get_name())
end

function M:try_action_auto_leave(action, end_frame, layer, event_data, cross_fade, not_need_event)
  self.v_protection = true
  self.v_state_manager:try_action(action, end_frame, layer, self.state_do_exit, self, event_data, cross_fade, not_need_event)
  self.v_protection = false
end

return M
