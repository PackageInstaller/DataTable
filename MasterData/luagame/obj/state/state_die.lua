local Base = require("obj.state.state_obj_base")
local M = Util.create_child_mt(Base)

function M:_init(owner, state_manager)
  Base._init(self, owner, state_manager)
  self.v_old_action = nil
end

function M:state_on_enter(action_name, action_remove, enter_die_cb)
  Base.state_on_enter(self)
  self.v_dead_time = Date.real_time()
  self.v_animation_finished = false
  self.v_owner.role_move_ctrl:stop_move(true)
  if self.v_owner:is_hero() then
    self.v_owner:update_pos_height()
  end
  if action_name then
    self.v_state_manager:try_action(action_name, nil, function()
      self.v_animation_finished = true
      if action_remove then
        Global.scene_mgr:remove_npc(self.v_owner)
      end
      if self.v_owner:is_hero() and TowerMgr then
        TowerMgr:on_role_die_anima_end()
      end
    end)
  elseif enter_die_cb then
    local die_action_name = self.v_old_action
    if die_action_name then
      self.v_state_manager:try_action(die_action_name, nil, function()
        self.v_animation_finished = true
      end)
    end
  elseif self.v_owner:is_hero() and TowerMgr then
    TowerMgr:on_role_die_anima_end()
  end
  self.v_old_action = nil
  self:send_on_npc_dead(action_name)
end

function M:send_on_npc_dead(action_name)
  local owner = self.v_owner
  if owner:is_hero() or nil ~= action_name and owner:is_monster() then
    BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.ON_NPC_DEAD, owner)
    BehaviorMgr:call_behavior_fun(owner, "on_self_npc_dead")
  end
  local is_next_frame_remove = owner:is_pre_destroy() or owner.update_start or owner.late_update_start
  if not is_next_frame_remove then
    owner.need_lock_destroy = true
  end
  BehaviorMgr:call_scene_logic_event_fun(BehaviorMgr.EVENTS.ON_NPC_DEAD, owner)
  if not is_next_frame_remove then
    owner.need_lock_destroy = nil
  end
end

function M:state_update()
  Base.state_update(self)
end

function M:state_get_name()
  return Config.STATE_NAME.die
end

function M:state_on_leave()
  Base.state_on_leave(self)
  self.v_auto_destroy = nil
end

function M:get_dead_time()
  return self.v_dead_time
end

function M:in_animation()
  return not self.v_animation_finished
end

function M:set_old_action(old_action)
  self.v_old_action = old_action
end

return M
