local Base = require("obj.base_component")
local M = Util.create_child_mt(Base)
local STATE_NAME = Config.STATE_NAME
local CommDefine = require("cs_share.common_define")

function M:_init(owner)
  Base._init(self)
  self.v_owner = owner
  self.v_states = {}
  self.v_cur_states = {}
  self.v_action_states = {}
  self:register_all_state()
  if owner and type(owner) == "table" then
    self.v_is_hero = owner:is_hero()
  end
end

function M:on_before_destroy()
  self.v_owner = nil
end

function M:on_destroy_gameobj()
  self.v_cur_states = nil
  for _, state in pairs(self.v_states) do
    state:on_destroy()
  end
  self.v_states = nil
  self.v_action_states = nil
end

function M:on_destroy_luaobj()
  self.v_god_mode_time = nil
  self.v_god_mode_key = nil
  for state_name, state in pairs(self.v_cur_states) do
    self.v_cur_states[state_name] = nil
    self.v_action_states[state_name] = nil
    state:state_on_leave()
  end
end

function M:register_all_state()
  assert(nil)
end

function M:register_state(state)
  local state_name = state:state_get_name()
  assert(not self.v_states[state_name])
  self.v_states[state_name] = state
end

function M:enter_state(state_name, ...)
  if not self:can_enter_state(state_name, ...) then
    return false
  end
  local new_state = self.v_states[state_name]
  local has_old_state = false
  for name, state in pairs(self.v_states) do
    if state.in_state and name ~= state_name and not state:state_can_coexist(state_name, ...) then
      self.v_cur_states[name] = nil
      self.v_action_states[name] = nil
      has_old_state = true
      state:state_on_leave(state_name)
    end
  end
  new_state:set_has_old_state(has_old_state)
  if self.v_cur_states[state_name] then
    if new_state:state_can_reenter() then
      new_state:state_update_value(...)
    end
  else
    self.v_cur_states[state_name] = new_state
    new_state:state_on_enter(...)
    new_state:state_update_value(...)
    if Global.debug_client_statemachine and self.v_is_hero then
      local state_names = {}
      for state_name, _ in pairs(self.v_cur_states) do
        table.insert(state_names, state_name)
      end
      local str = table.concat(state_names, "\n")
      Global.log.Debug("current states: \n", str)
    end
  end
  if new_state:state_has_action() and new_state.in_state then
    self:set_action_state(state_name)
  end
  if self.v_owner and self.v_owner:is_role() then
    local attacker_id = self.v_owner:get_last_hurt_attacker_id()
    local is_building = MagicReporter:is_building_report()
    local status = self.v_owner:get_status()
    if self.v_owner:is_com_monster() and self.v_owner:get_role_kind() ~= CommDefine.NPC_KIND.SUMMON_MONSTER and status == Config.CHARACTER_STATE_TYPE.DIE and not self.v_owner:get_is_set_die_state() and ChallengeRingPlusMgr then
      ChallengeRingPlusMgr:record_kill_enemy_count(self.v_owner.uuid, self.v_owner:get_npc_id())
    end
    self:_report_set_state(attacker_id, is_building, status)
  end
  if self.v_fall_down and state_name == STATE_NAME.behitfly then
    self.v_cur_states[STATE_NAME.fall] = new_state
  else
    self.v_cur_states[STATE_NAME.fall] = nil
  end
  if Global.state_sound_mgr then
    Global.state_sound_mgr:trigger_char_state_by_name(self.v_owner, state_name)
  end
  if self.v_owner.time_mgr and Config.NEED_QUIT_TIME_SCALE_STATE[state_name] then
    self.v_owner.time_mgr:remove_time_scale_on_be_hit()
  end
  return true
end

function M:exit_state(state_name)
  local state = self.v_cur_states[state_name]
  if not state then
    return false
  end
  self.v_cur_states[state_name] = nil
  self.v_action_states[state_name] = nil
  if state_name == STATE_NAME.behitfly then
    self.v_cur_states[STATE_NAME.fall] = nil
  end
  state:state_on_leave()
  return true
end

function M:update()
  if self.v_owner:is_hero() and self.v_owner:check_background() then
    return
  end
  if self.v_owner:is_hero() and not self.v_owner:check_background() and self.v_owner.skill_mgr:is_in_fight_end_skill() then
    return
  end
  for _, state in pairs(self.v_states) do
    if state.in_state then
      state:state_update()
    end
  end
  if self.v_god_mode_time and self.v_god_mode_key and self.v_god_mode_time <= self.v_owner.time_mgr:get_time() then
    self.v_owner:set_godmode(false, self.v_god_mode_key)
    self.v_god_mode_time = nil
    self.v_god_mode_key = nil
  end
end

function M:can_enter_state(state_name, param)
  if not self.v_states[state_name] then
    return false
  end
  local state = self.v_cur_states[state_name]
  if state then
    return state:state_can_reenter()
  end
  if self.v_owner:is_die() and self.v_owner.attr_mgr:get_hp() <= 0 then
    return false
  end
  for _, cur_state in pairs(self.v_cur_states) do
    if not cur_state:state_can_transit(state_name, param) then
      return false
    end
  end
  return true
end

function M:is_empty_state()
  return next(self.v_cur_states) == nil
end

function M:has_action_state()
  return next(self.v_action_states) ~= nil
end

function M:has_extra_action_state(state_name)
  for name in pairs(self.v_action_states) do
    if name ~= state_name then
      return true
    end
  end
end

function M:is_in_state(state_name)
  return self.v_cur_states[state_name] ~= nil
end

function M:get_cur_state(state_name)
  return self.v_cur_states[state_name]
end

function M:get_all_state()
  return self.v_cur_states
end

function M:_report_set_state(attacker_id, is_building, status)
  if status == Config.CHARACTER_STATE_TYPE.DIE then
    if self.v_owner:get_is_set_die_state() then
      return
    else
      self.v_owner:set_is_set_die_state(true)
    end
    if is_building then
      MagicReporter:set_npc_status(is_building, self.v_owner.uuid, status, attacker_id)
    else
      SceneMgr:c2gs_call_scene("set_npc_status", self.v_owner.uuid, status, attacker_id)
    end
  end
end

function M:report_set_die_state()
  local attacker_id = self.v_owner:get_last_hurt_attacker_id()
  local is_building = MagicReporter:is_building_report()
  local status = Config.CHARACTER_STATE_TYPE.DIE
  if self.v_owner:is_com_monster() and self.v_owner:get_role_kind() ~= CommDefine.NPC_KIND.SUMMON_MONSTER and not self.v_owner:get_is_set_die_state() and ChallengeRingPlusMgr then
    ChallengeRingPlusMgr:record_kill_enemy_count(self.v_owner.uuid, self.v_owner:get_npc_id())
  end
  self:_report_set_state(attacker_id, is_building, status)
end

function M:on_enter_lie()
  if self.v_owner:is_hero() and not self.v_owner:is_die() then
    local cur_time = self.v_owner.time_mgr:get_time()
    local god_mode_time = ShareRes.get_comm_value("EnterLieGodModeTime")
    if not god_mode_time then
      return
    end
    self.v_god_mode_time = cur_time + god_mode_time
    self.v_god_mode_key = "lie"
    self.v_owner:set_godmode(true, self.v_god_mode_key)
  end
end

function M:on_enter_lie_to_stand()
  if self.v_owner:is_hero() and not self.v_owner:is_die() then
    local cur_time = self.v_owner.time_mgr:get_time()
    local god_mode_time = ShareRes.get_comm_value("EnterLieToStandGodModeTime")
    if not god_mode_time then
      return
    end
    self.v_god_mode_time = cur_time + god_mode_time
    self.v_god_mode_key = "lie_to_stand"
    self.v_owner:set_godmode(true, self.v_god_mode_key)
  end
end

function M:on_leave_lie()
  if self.v_god_mode_time and self.v_god_mode_key == "lie" then
    self.v_owner:set_godmode(false, self.v_god_mode_key)
    self.v_god_mode_time = nil
  end
end

function M:on_leave_lie_to_stand()
  if self.v_god_mode_time and self.v_god_mode_key == "lie_to_stand" then
    self.v_owner:set_godmode(false, self.v_god_mode_key)
    self.v_god_mode_time = nil
  end
end

function M:on_lie_hit_end()
  local behitfly = self:get_cur_state(STATE_NAME.behitfly)
  if behitfly then
    behitfly:on_lie_hit_end()
  end
end

function M:is_in_behitfly_state()
  return self:is_in_state(STATE_NAME.behitfly) or self:is_in_state(STATE_NAME.fall)
end

function M:check_die_action()
  local die_state = self.v_states[STATE_NAME.die]
  if self.v_owner.act_ctrl:check_have_die1_action() then
    die_state:set_old_action(Config.ACT_DEFINE.Die1)
  elseif not self:is_in_behitfly_state() then
    local old_action
    local action_index = math.random(Config.BEHIT_TYEP.LEFT_LARGE, Config.BEHIT_TYEP.RIGHT_LARGE)
    old_action = Config.BEHIT_ACTION[action_index]
    die_state:set_old_action(old_action)
  end
end

function M:set_action_state(state_name)
  self.v_action_states[state_name] = true
end

return M
