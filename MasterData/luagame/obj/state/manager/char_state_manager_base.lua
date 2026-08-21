local Base = require("obj.state.manager.state_manager")
local Math = require("base.mathx")
local NEED_SPEED_ACTS = Config.NEED_SPEED_ACTS
local STATE_NAME = Config.STATE_NAME
local BEHIT_TYEP = Config.BEHIT_TYEP
local ACT_DEFINE = Config.ACT_DEFINE
local BEHIT_INTERRUPT_TYPE = Config.BEHIT_INTERRUPT_TYPE
local _floor = math.floor
local STUN_STATE_COURSE = {
  StunStart = ACT_DEFINE.StunStart,
  Stun = ACT_DEFINE.Stun
}
local RANDOM_HIT_TYPE = {
  [true] = Config.BEHIT_TYEP.LEFT_LARGE,
  [false] = Config.BEHIT_TYEP.RIGHT_LARGE
}
local M = Util.create_child_mt(Base)

function M:_init(...)
  Base._init(self, ...)
  self.v_lock_move = 0
  self.v_skill_end_to_idle = true
  self.v_oepn_auto_forward_move_mode = false
  self.v_replace_hit_type = nil
  self.v_cur_move_state_name = STATE_NAME.move
  self.v_skill_to_move_enable = true
  self.v_blocked_stun_handle_map = {}
end

function M:exit_state(state_name)
  local re = Base.exit_state(self, state_name)
  if re and not self:has_action_state() then
    self:to_idle_state()
  end
end

function M:exit_move_state()
  self:exit_state(STATE_NAME.move)
end

function M:exit_auto_forward_move_state()
  self:exit_state(STATE_NAME.auto_forward_move)
end

function M:exit_attack_state()
  self:exit_state(STATE_NAME.attack)
end

function M:exit_channel_skill_state()
  self:exit_state(STATE_NAME.channel_skill)
end

function M:exit_die_state()
  self:exit_state(STATE_NAME.die)
end

function M:try_action(action, layer, callback, cbdata, is_loop, early_entry_into_fade)
  local act_ctrl = self:_get_act_ctrl()
  layer = layer or 0
  self.v_fall_down = false
  if action == ACT_DEFINE.BeHitFly or action == ACT_DEFINE.HoverHitRoll or action == ACT_DEFINE.Hoverhit or action == ACT_DEFINE.BeHitRollFly then
    self:to_fly_state()
  elseif action == ACT_DEFINE.Falldown or action == ACT_DEFINE.Lieonfloor then
    self.v_fall_down = true
    self:to_fly_state()
  end
  if act_ctrl then
    layer = layer or Config.ANIMATOR_DEFAULT_LAYER
    local need_follow_speed = NEED_SPEED_ACTS[action]
    return act_ctrl:try_action(action, layer, callback, cbdata, is_loop, need_follow_speed, nil, nil, early_entry_into_fade)
  end
end

function M:set_keep_end(layer, keep_end)
  local act_ctrl = self:_get_act_ctrl()
  if act_ctrl then
    layer = layer or Config.ANIMATOR_DEFAULT_LAYER
    act_ctrl:set_keep_end(layer, keep_end)
  end
end

function M:_get_act_ctrl()
  return self.v_owner.act_ctrl
end

function M:set_skill_end_to_idle(param)
  self.v_skill_end_to_idle = param
end

function M:is_skill_end_to_idle()
  return self.v_skill_end_to_idle
end

function M:has_action(action)
  local has_action = false
  local act_ctrl = self:_get_act_ctrl()
  if act_ctrl then
    has_action = act_ctrl:has_group(action)
  end
  return has_action
end

function M:set_action_speed(speed)
  local act_ctrl = self:_get_act_ctrl()
  if act_ctrl then
    act_ctrl:set_action_speed(speed)
  end
end

function M:stop_action(layer)
  if self.v_owner.act_ctrl then
    self.v_owner.act_ctrl:stop_action(layer)
  end
end

function M:get_turnover_state()
  return self.v_states[STATE_NAME.turnover]
end

function M:get_die_state()
  return self.v_states[STATE_NAME.die]
end

function M:get_attack_state()
  return self.v_states[STATE_NAME.attack]
end

function M:get_behitfly_state()
  return self.v_states[STATE_NAME.behitfly]
end

function M:get_cur_attack_action()
  local state = self.v_states[STATE_NAME.attack]
  return state:get_cur_attack_action()
end

function M:can_enter_state(state_name, param)
  assert(self.v_states[state_name], "state not exist: " .. state_name)
  if not self.v_owner:is_on_recreate_gameobj() and (not self.v_owner:can_update() or self.v_owner:is_empty_obj()) then
    return false
  end
  local state = self.v_cur_states[state_name]
  if state then
    return state:state_can_reenter()
  end
  if state_name == STATE_NAME.die then
    return true
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

function M:can_role_ctrl_stop_move()
  return not self:is_fixed_move_state()
end

function M:to_die_state(...)
  self:enter_state(STATE_NAME.die, ...)
end

function M:to_born_state(action)
  self:enter_state(STATE_NAME.born, action)
end

function M:to_idle_state(reset, ...)
  if self.v_oepn_auto_forward_move_mode then
    if not self:is_moving_state() then
      self:move_by_dir(0, 1, true)
    end
  else
    self:enter_state(STATE_NAME.idle, reset, ...)
  end
end

function M:to_run_state(reset, ...)
  self:enter_state(STATE_NAME.run, ...)
end

function M:to_attack_state(skill_cfg, start_frame)
  return self:enter_state(STATE_NAME.attack, skill_cfg, start_frame)
end

function M:to_fly_state(...)
  self:enter_state(STATE_NAME.behitfly, ...)
end

function M:on_beattack(target, missile, missile_cfg, is_in_armor)
  if (self:is_idle_state() or self:is_behitfly_state()) and self.v_owner.time_mgr and self.v_owner.time_mgr:is_in_freeze() then
    return
  end
  local behitfly_state = self.v_cur_states[STATE_NAME.behitfly]
  local is_on_be_hit_fly = behitfly_state and not behitfly_state:is_standup()
  local hit_type = missile_cfg.Type
  if is_on_be_hit_fly then
    behitfly_state:on_beattack(missile, missile_cfg)
  else
    hit_type = self:check_can_hit_fly(hit_type, target)
    if hit_type == BEHIT_TYEP.HIT_FLY and not is_in_armor then
      self:enter_state(STATE_NAME.behitfly, missile, missile_cfg, false, false)
    elseif hit_type == BEHIT_TYEP.HIT_DOWN and not is_in_armor then
      self:enter_state(STATE_NAME.behitfly, missile, missile_cfg, true, false)
    elseif hit_type == BEHIT_TYEP.ROLL_HIT_FLY and not is_in_armor then
      self:enter_state(STATE_NAME.behitfly, missile, missile_cfg, false, true)
    else
      if not is_in_armor then
        self:to_beattack_state(missile, missile_cfg, hit_type)
      end
      if missile_cfg.HitBackSpeed > 0 or missile_cfg.SAHitBackSpeed > 0 then
        local dir = missile:get_hit_back_dir(target)
        target.role_move_ctrl:on_behit(dir, missile_cfg, missile, is_in_armor)
      end
    end
  end
  if not is_in_armor and not is_on_be_hit_fly then
    self.beattack_type = hit_type
  end
end

function M:check_can_hit_fly(hit_type, target)
  if target.character_cfg.CanNotHitFly and (hit_type == BEHIT_TYEP.HIT_FLY or hit_type == BEHIT_TYEP.HIT_DOWN) then
    if self.v_replace_hit_type == nil then
      local random = math.random(1, 100)
      self.v_replace_hit_type = random > 50
      hit_type = RANDOM_HIT_TYPE[self.v_replace_hit_type]
    else
      self.v_replace_hit_type = not self.v_replace_hit_type
      hit_type = RANDOM_HIT_TYPE[self.v_replace_hit_type]
    end
  end
  return hit_type
end

function M:on_rebound()
  local behitfly_state = self.v_cur_states[STATE_NAME.behitfly]
  if behitfly_state then
    behitfly_state:on_rebound()
  end
end

function M:to_beattack_state(...)
  self:enter_state(STATE_NAME.beattack, ...)
end

function M:to_appoint_anim_state(anim_name)
  self:enter_state(STATE_NAME.appoint_anim, anim_name)
end

function M:to_anim_state(anim, time, callback)
  self:enter_state(STATE_NAME.anim, anim, time, callback)
end

function M:to_nonbeattack_state()
  self:enter_state(STATE_NAME.nonbeattack)
end

function M:exit_nonbeattack_state()
  self:exit_state(STATE_NAME.nonbeattack)
end

function M:to_stun_state(duration, exit_cb)
  self:enter_state(STATE_NAME.stun, duration, exit_cb)
end

function M:exit_stun_state()
  self:exit_state(STATE_NAME.stun)
end

function M:raw_lock_move()
  if not self:is_quick_move_state() then
    self.v_owner.role_move_ctrl:stop_move(true)
  end
  if self:is_moving_state() then
    self:to_idle_state()
  end
end

function M:lock_move(lock, add_lock)
  if lock then
    self:raw_lock_move()
    self.v_lock_move = self.v_lock_move + 1
  else
    self.v_lock_move = self.v_lock_move - 1
  end
end

function M:is_lock_move()
  return self.v_lock_move > 0
end

function M:to_jump_state()
  if not self:is_lock_move() then
    self:enter_state(STATE_NAME.jump)
  end
  return self.v_cur_states[STATE_NAME.jump] ~= nil
end

function M:to_move_state()
  self:enter_state(self.v_cur_move_state_name, nil, 0)
end

function M:to_fixed_move_state(ride_id, path_finding)
  if not self:is_lock_move() then
    self:enter_state(STATE_NAME.fixed_move, ride_id, path_finding)
  end
end

function M:to_chant_state(spell_id, spell_lv, spell_stage, is_spell_wake, target_uuid)
  self:enter_state(STATE_NAME.chant, spell_id, spell_lv, spell_stage, is_spell_wake, target_uuid)
end

function M:to_quick_move_state(...)
  self:enter_state(STATE_NAME.quick_move, ...)
end

function M:to_ride_chant_state()
  self:enter_state(STATE_NAME.ride_chant)
end

function M:to_relive_state()
  self:enter_state(STATE_NAME.relive)
end

function M:to_ride_state()
  self:enter_state(STATE_NAME.ride)
end

function M:to_ridemove_state()
  self:enter_state(STATE_NAME.ridemove)
end

function M:to_turn_over_state()
  self:enter_state(STATE_NAME.turnover)
end

function M:is_idle_state()
  return self:is_in_state(STATE_NAME.idle)
end

function M:is_die_state()
  return self:is_in_state(STATE_NAME.die)
end

function M:is_attack_state()
  return self:is_in_state(STATE_NAME.attack)
end

function M:is_beattack_state()
  return self:is_in_state(STATE_NAME.beattack)
end

function M:is_behitfly_state()
  return self:is_in_state(STATE_NAME.behitfly)
end

function M:is_common_attack_state()
  if not self:is_in_state(STATE_NAME.attack) then
    return false
  end
  return self:get_attack_state():is_common_attack()
end

function M:is_spell_attack_state()
  if not self:is_in_state(STATE_NAME.attack) then
    return false
  end
  return not self:get_attack_state():is_common_attack()
end

function M:is_ride_state()
  return self:is_in_state(STATE_NAME.ride)
end

function M:is_ridemove_state()
  return self:is_in_state(STATE_NAME.ridemove)
end

function M:is_moving_state()
  return self:is_in_state(self.v_cur_move_state_name)
end

function M:is_jump_state()
  return self:is_in_state(STATE_NAME.jump)
end

function M:is_fly_state()
  return self:is_in_state(STATE_NAME.behitfly)
end

function M:is_fall_state()
  return self:is_in_state(STATE_NAME.fall)
end

function M:redo_default_layer_attack()
  self.v_states[STATE_NAME.attack]:redo_default_layer_attack()
end

function M:role_need_update_height()
  if self.v_cur_states[STATE_NAME.jump] then
    return true
  end
  local quick_move_state = self.v_cur_states[STATE_NAME.quick_move]
  return quick_move_state and quick_move_state:is_jump()
end

function M:role_can_remove()
  return not self.v_cur_states[self.v_cur_move_state_name] and self.v_cur_states[STATE_NAME.idle]
end

function M:get_cur_jump_state()
  return self.v_cur_states[STATE_NAME.jump]
end

function M:get_move_state()
  return self.v_states[self.v_cur_move_state_name]
end

function M:get_cur_attack_state()
  return self.v_cur_states[STATE_NAME.attack]
end

function M:get_cur_beattack_state()
  return self.v_cur_states[STATE_NAME.beattack]
end

function M:get_cur_behitfly_state()
  return self.v_cur_states[STATE_NAME.behitfly]
end

function M:is_appoint_anim_state()
  return self:is_in_state(STATE_NAME.appoint_anim)
end

function M:is_anim_state(...)
  return self:is_in_state(STATE_NAME.anim)
end

function M:is_fixed_move_state()
  return self:is_in_state(STATE_NAME.fixed_move)
end

function M:is_quick_move_state()
  return self:is_in_state(STATE_NAME.quick_move)
end

function M:is_chant_state()
  return self:is_in_state(STATE_NAME.chant)
end

function M:is_stun_state()
  return self:is_in_state(STATE_NAME.stun)
end

function M:on_group_end(layer, group)
  if layer == Config.ANIMATOR_ATTACK_LAYER then
    self:exit_state(STATE_NAME.attack)
  end
end

function M:can_move()
  if not Global.is_aimed_move and self.v_owner:is_hero() and Global.camera and Global.camera:check_camera_aimed() then
    return false
  end
  local attack_state = self.v_cur_states[STATE_NAME.attack]
  if attack_state and not attack_state:can_move() then
    return false
  end
  local behitfly_state = self.v_cur_states[STATE_NAME.behitfly]
  if behitfly_state then
    return behitfly_state:can_move()
  end
  local stun_state = self.v_cur_states[STATE_NAME.stun]
  if stun_state and not stun_state:can_move() then
    return false
  end
  if not self.v_skill_end_to_idle then
    return false
  end
  local beattack_state = self.v_cur_states[STATE_NAME.beattack]
  if beattack_state then
    return beattack_state:can_quit() or beattack_state:can_interrupt(BEHIT_INTERRUPT_TYPE.MOVE)
  end
  if self.v_owner.is_in_puppet_mode then
    return false
  end
  if self.v_owner:check_transmit() then
    return false
  end
  return true
end

function M:can_turn_dir()
  return not self:is_in_state(STATE_NAME.quick_move) and not self:is_in_state(STATE_NAME.quick_move)
end

function M:move_by_dir(dirx, dirz, force_runing)
  if not self:can_move() then
    return false
  end
  self:set_correct_dir(false)
  local attack_state = self.v_cur_states[STATE_NAME.attack]
  if attack_state then
    self.v_owner.skill_mgr:abort(Config.SKILL_ABORT_TYPE.MOVE_ABORT)
  end
  self:to_move_state()
  local move_state = self.v_cur_states[self.v_cur_move_state_name]
  if move_state then
    dirx = _floor(dirx * 10 + 0.5) / 10
    dirz = _floor(dirz * 10 + 0.5) / 10
    move_state:move_by_dir(dirx, dirz, force_runing)
  end
  return true
end

function M:set_correct_dir(need)
  self.v_need_correct_dir = need
end

function M:check_correct_dir()
  return self.v_need_correct_dir
end

function M:get_after_correct_dir_x_y(cur_x, cur_z)
  local cur_dir = self.v_owner:get_dir()
  local tar_dir = cur_dir > 180 and 360 or 0
  if not Util.almost_zero(cur_dir - tar_dir) then
    local next_dir = Math.lerp_number(cur_dir, tar_dir, 0.1)
    if Util.almost_zero(next_dir - 360) then
      next_dir = 0
    end
    self.v_owner:set_target_dir(next_dir, true)
  end
  local forward_x, _, forward_z = self.v_owner.transform:GetForwardA()
  return Util.get_equal_len_vector(cur_x, cur_z, forward_x, forward_z)
end

function M:check_need_move(dstx, dstz, callback, cbdata)
  local curx, _, curz = self.v_owner:get_pos()
  local dx = curx - dstx
  local dz = curz - dstz
  local distance = dx * dx + dz * dz
  if distance <= 0.01 then
    self.v_owner.role_move_ctrl:stop_move(true)
    self.v_owner:set_pos(dstx, self.v_owner:get_pos_height(), dstz)
    if callback then
      callback(cbdata)
    end
    return
  end
  return true
end

function M:move_to_dst(dstx, dstz, deviation, callback, cbdata, speed, ignore_block, not_update_dir, from_server)
  if not self:can_move() then
    if from_server then
      self.v_need_sync_server_move = true
      self.v_dst_x = dstx
      self.v_dst_z = dstz
    end
    return false
  end
  if not self:check_need_move(dstx, dstz, callback, cbdata) then
    return
  end
  self.v_need_sync_server_move = false
  self:to_move_state()
  self.v_owner.role_move_ctrl:move_to_dst(dstx, dstz, nil, deviation, callback, cbdata, speed, nil, nil, nil, nil, ignore_block, not_update_dir)
  return true
end

function M:move_to_target(target, speedx, speedz, deviation, need_action, callback, cbdata)
  if not self:can_move() then
    return
  end
  self:to_move_state()
  self.v_owner.role_move_ctrl:move_to_target(target, speedx, speedz, deviation, need_action, callback, cbdata)
end

function M:quest_fixed_move(points, move_info, deviation, callback, cbdata, ride_id, is_fly)
  if self:is_fixed_move_state() then
    self.v_owner.role_move_ctrl:move_along_points(points, Config.XYZ_DIMENSION, move_info, deviation, callback, cbdata, nil, is_fly)
    return true
  end
  return false
end

function M:stop_move()
  if self.v_oepn_auto_forward_move_mode then
    self:set_correct_dir(true)
  else
    local move_state = self.v_cur_states[self.v_cur_move_state_name]
    if move_state then
      move_state:stop_move()
    end
    Global.hero:keep_cur_dir()
  end
end

function M:update_move_type()
  local move_state = self.v_cur_states[self.v_cur_move_state_name]
  if move_state then
    move_state:state_update_value()
  end
end

function M:switch_idle_state(idle_state)
  local idle_state = self.v_cur_states[STATE_NAME.idle]
  if not idle_state then
    return
  end
  idle_state:switch_idle_state(idle_state)
end

function M:on_joystick_change()
  self:exit_state(STATE_NAME.chant)
  self:exit_state(STATE_NAME.ride_chant)
  self:exit_state(STATE_NAME.channel_skill)
end

function M:on_destroy_gameobj()
  self:exit_state(STATE_NAME.jump)
  Base.on_destroy_gameobj(self)
end

function M:on_destroy()
  Base.on_destroy(self)
  self.v_oepn_auto_forward_move_mode = nil
  self.v_cur_move_state_name = STATE_NAME.move
end

function M:enter_stun(duration, exist_armor, exit_cb)
  if self.v_blocked_stun then
    return
  end
  self.v_owner.exist_armor = exist_armor
  self:to_stun_state(duration, exit_cb)
end

function M:exit_stun()
  local stun_state = self.v_cur_states[STATE_NAME.stun]
  if stun_state then
    stun_state:exit_stun()
  end
end

function M:on_stun_attack()
  local stun_state = self.v_cur_states[STATE_NAME.stun]
  if stun_state then
    stun_state:on_stun_attack()
  end
end

function M:is_really_enter_stun()
  return self.v_owner:is_stun()
end

function M:stun_is_end()
  return self:is_stun_state()
end

function M:get_stun_total_time(clear_tough)
  local cfg
  local time = 0
  local stun_time = clear_tough and self.v_owner.character_cfg.ForceRecoverToughTime or self.v_owner.character_cfg.TimeOfStunState
  for key, action in pairs(STUN_STATE_COURSE) do
    cfg = self.v_owner.motion_cfg[action]
    if not cfg then
      do
        local model_cfg = self.v_owner.model_cfg
        Log.Error("找不到action配置: ", model_cfg.ModelPath, action, debug.traceback())
      end
    elseif action == STUN_STATE_COURSE.Stun then
      if stun_time and not (stun_time <= 0) then
        time = time + stun_time
      end
    else
      time = time + Util.frame2realtime(cfg.TotalFrame, cfg.TailLength)
      goto lbl_52
    end
    ::lbl_52::
  end
  return time
end

function M:is_in_stun_start()
  local stun_state = self.v_cur_states[STATE_NAME.stun]
  if stun_state then
    return stun_state:is_in_stun_start()
  end
end

function M:set_auto_forward_move_mode(is_open)
  if not is_open then
    self:exit_auto_forward_move_state()
    self.v_cur_move_state_name = STATE_NAME.move
  else
    self.v_cur_move_state_name = STATE_NAME.auto_forward_move
  end
  self.v_oepn_auto_forward_move_mode = is_open
end

function M:set_dir_to_run(enable)
  self.dir_to_run = enable
end

function M:get_counter_to_run_speed()
  local move_state = self.v_cur_states[STATE_NAME.run]
  return move_state and move_state:get_counter_to_run_speed()
end

function M:set_skill_to_move_enable(enable)
  self.v_skill_to_move_enable = enable
end

function M:get_skill_to_move_enable()
  return self.v_skill_to_move_enable
end

function M:add_blocked_stun_handle()
  local handle = Util.get_index()
  self.v_blocked_stun_handle_map[handle] = true
  self.v_blocked_stun = true
  return handle
end

function M:remove_blocked_stun_handle(handle)
  self.v_blocked_stun_handle_map[handle] = nil
  self.v_blocked_stun = nil ~= next(self.v_blocked_stun_handle_map)
end

return M
