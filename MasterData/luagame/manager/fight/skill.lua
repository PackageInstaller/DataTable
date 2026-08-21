local Vec3 = require("base.vec3")
local KeyFrameAction = require("manager.fight.keyframe_action")
local SkillDefine = require("manager.fight.skill_define")
local _abs = math.abs
local _min = math.min
local _min_dist_diff = 0.3
local _tinsert = table.insert
local Mathx = require("base.mathx")
local SKILL_TYPE = Config.SKILL_ATTACK_TYPE
local CSShadow = CS.Game.Shadow
local _slower = string.lower
local _amost_zero2 = Mathx.almost_zero2
local rad2Deg = math.deg(1)
local _atan = math.atan
local _clamp = Mathx.Clamp
local M = Util.create_class()
local SKILL_FX_ABORT_TYPE = SkillDefine.SKILL_FX_ABORT_TYPE
local SKILL_MOVE_TYPE = SkillDefine.SKILL_MOVE_TYPE
local TURN_TYPE = SkillDefine.TURN_TYPE
local NOTIFY_TYPE = SkillDefine.NOTIFY_TYPE
local MAGIC_TURN_DIR_TYPE = SkillDefine.MAGIC_TURN_DIR_TYPE
local SKILL_FACE_TYPE = SkillDefine.SKILL_FACE_TYPE
local SOUND_ABORT_TYPE = SkillDefine.SOUND_ABORT_TYPE
local RENDER_SHADOW_MAP_MAGIC_TYPE = 5
local NEXT_FRAME_EXIT_DEG = 0.05
local UnitySkinnedMeshRenderer = typeof(UnityEngine.SkinnedMeshRenderer)

function M:_init(skill_id, char)
  local skill_cfg = ShareRes.create("skill.skill", skill_id)
  assert(skill_cfg, "can't find skill cfg: " .. skill_id)
  self.skill_id = skill_id
  self.skill_cfg = skill_cfg
  self.v_char = char
  self.v_skill_time = 0
  self.v_skill_cast_end_time = 0
  local dist_abort = skill_cfg.DistAbort or 0
  self.v_dist_abort_sqruare = dist_abort * dist_abort
  self.v_skill_move_type = skill_cfg.SkillMoveType
  self.v_skill_face_type = skill_cfg.SkillFaceType
  self.v_need_look_target = skill_cfg.SkillFaceType == SKILL_FACE_TYPE.TO_TARGET or skill_cfg.SkillFaceType == SKILL_FACE_TYPE.LOCK_TARGET
  self:get_keyframe()
  self.v_frame = 0
  self.v_skill_type = skill_cfg.SkillType
  self.v_effects = {}
  self.v_cast_missile_map = {}
  self.v_stop = false
  self.v_skill_priority = skill_cfg.SkillPriority or 0
  self.v_shift = false
  self.v_shift_speed = 0
  self.v_duration = 0
  self.v_shift_time = 0
  self.v_shift_start_time = self.v_char.time_mgr:get_time()
  self.v_last_touch_terrain = 0
  self.v_touch_terrain_interval = skill_cfg.LandIntTime or Config.A_LARGE_NUM
  self.v_shift_acc = 0
  self.v_shift_start_speed = 0
  self.v_force_stop_dist = skill_cfg.StopByMoveDirDist
  self.v_level = 1
  self.v_need_deduct_consume = false
  self.v_ignore_consume_detect = false
  if self.skill_cfg.Name == "dashIn" or self.skill_cfg.Name == "dashOut" then
    self.v_can_shoulder_camera_focus = false
  else
    self.v_can_shoulder_camera_focus = true
  end
  self:check_need_init_energy()
end

function M:on_destroy()
  self.v_char = nil
  self.v_keyframes = nil
  self.v_skill_cfg = nil
  self.v_effects = nil
  self.v_cast_missile_map = nil
end

local function _get_tag2actions(keys, ret, all_actions_container)
  for _, keyframe_action in pairs(keys) do
    local temp_tag = keyframe_action.Tag or 0
    ret[temp_tag] = ret[temp_tag] or {}
    _tinsert(ret[temp_tag], keyframe_action)
    all_actions_container[temp_tag] = all_actions_container[temp_tag] or {}
    _tinsert(all_actions_container[temp_tag], keyframe_action)
  end
end

function M:get_tag2actions(all_actions_container)
  local keyframes = ShareRes.get_skill_keyframe_cfg(self.skill_id)
  if not keyframes then
    return
  end
  local ret = {}
  _get_tag2actions(keyframes.Key, ret, all_actions_container)
  if keyframes.SpecialKey and self.v_char:is_role() then
    local fashion_id = self.v_char:get_fashion_id() or 0
    if keyframes.SpecialKey[fashion_id] then
      _get_tag2actions(keyframes.SpecialKey[fashion_id], ret, all_actions_container)
    end
  end
  return ret
end

function M:_play_magics(magics)
  for _, magic_id in ipairs(magics) do
    local magic_level = self:get_magic_level(magic_id)
    self.v_char.magic_mgr:add_magic(self.v_char, magic_id, nil, self, magic_level, nil, {
      frame_num = self.v_frame
    })
  end
end

function M:_on_skill_begin()
  if self.skill_cfg.CastMagicIds then
    self:_play_magics(self.skill_cfg.CastMagicIds)
  end
  if self.v_char.uuid == Global.hero_uuid and self.v_energy_info.skill_type ~= Config.SKILL_ATTACK_TYPE.NORMAL then
    MsgGame:mq_publish2(Const.MSG_UI_FIGHT_CAST_SKILL)
  end
end

function M:check_skill_after_time()
  local before_time = self:get_before_time()
  local cast_time = self:get_cast_time()
  local after_time = self:get_after_time()
  local cur_time = self:get_elapse()
  if cur_time >= before_time + cast_time then
    return true
  end
end

function M:_on_skill_end(is_abort)
  self:stop_bind_skill_missile()
  if (is_abort or self:check_skill_after_time()) and self.skill_cfg.FinalMagicIds then
    self:_play_magics(self.skill_cfg.FinalMagicIds)
  end
  if self.v_shift or is_abort then
    self:stop_skill_shift()
  end
  if self.fixed_time_shift_data or is_abort then
    self:stop_fixed_time_shift()
  end
  if self.v_is_bezier_moving then
    self:stop_bezier_move()
  end
  self:_on_joystick_move_time_end()
  self:clear_turn_dir()
end

function M:_on_joystick_move_time_end()
  if self.v_joystick_move then
    self.v_char.role_move_ctrl:set_move_by_skill_joystick(false)
    self.v_char.role_move_ctrl:set_joystick_dir(0, 0)
    self.v_joystick_move = false
  end
end

function M:cast(target_pos, target, skill_action_info, start_frame)
  self.v_frame = start_frame or 0
  self.v_skill_time = start_frame and start_frame * Config.LOGIC_FRAME or 0
  self.v_last_touch_terrain = 0
  self.v_before_time_event_trigger = false
  self.v_cast_time_event_trigger = false
  self.v_last_frame_time = (start_frame and start_frame * Config.LOGIC_FRAME or 0) - Config.LOGIC_FRAME
  self:report_skill_start()
  BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.ON_SKILL_BEGIN, self.v_char, self.skill_id, self.v_skill_type, self.skill_cfg)
  BehaviorMgr:call_behavior_fun(self.v_char, "on_self_skill_begin", self.skill_id, self.v_skill_type, self.skill_cfg)
  self:set_target(target)
  self.v_target_pos = target_pos
  local cast_end_time = self.skill_cfg.CastTime
  if self.v_char.time_mgr then
    self.v_skill_cast_end_time = self.v_char.time_mgr:get_time() + cast_end_time
  else
    self.v_skill_cast_end_time = Global.time + cast_end_time
  end
  self.v_stop = false
  if self.v_need_look_target then
    local pos = self:get_target_pos()
    if pos then
      self.v_char:face_to_pos(pos.x, pos.z)
    end
  end
  if self.v_skill_move_type ~= SKILL_MOVE_TYPE.DONT_MOVE then
    local dt = self.v_target_pos - self.v_char:get_pos_vec3()
    if self.v_skill_move_type == SKILL_MOVE_TYPE.TO_FACE_DIR or self.v_skill_move_type == SKILL_MOVE_TYPE.LOCK_FACE_DIR or dt:AlmostZero() then
      self.v_skill_move_dir = self.v_char:get_dir_vec()
    else
      local dir = dt:SetNormalize()
      self.v_skill_move_dir = dir
    end
  end
  if self.v_char == Global.hero and target and Global.camera:get_view_type() == Config.CAMERA_VIEW_TYPE.SHOULDER and self.v_can_shoulder_camera_focus and target:is_com_monster() then
    Global.camera:set_camera_focal(target, "Bip001 Chest")
  end
  if Global.camera:get_view_type() == Config.CAMERA_VIEW_TYPE.SHOULDER and target == Global.hero then
    local msg = MsgGame:mq_publish2(Const.MSG_ON_MONSTER_BEGIN_ATTACK_HERO)
    msg.mm_x = self.v_char.uuid
    self.v_is_begin_attack_hero = true
  end
  local suc = self.v_char.state_manager:to_attack_state(self.skill_cfg, start_frame)
  if not suc and self.v_char:can_update() then
    Log.Error("进入攻击状态失败", self.skill_id, debug.traceback())
  end
  self.v_need_deduct_consume = not self.v_ignore_consume_detect
  self.v_skill_action_info = skill_action_info
  self:check_skill_consume()
  self:_on_skill_begin()
  self:_do_update_keyframe()
  JournalMgr:insert_skill_journal(self.v_char, self.skill_id, self.v_skill_type, self.v_target)
end

function M:update(dt)
  if self.v_stop then
    return
  end
  local time_mgr = self.v_char.time_mgr
  self.v_skill_time = self.v_skill_time + time_mgr:get_dt_time()
  self:check_skill_consume()
  self:update_skill_shift()
  self:update_fixed_time_shift()
  if self.v_skill_time - self.v_last_touch_terrain > self.v_touch_terrain_interval then
    self.v_last_touch_terrain = self.v_skill_time
    self.v_char:on_step()
  end
  self:update_keyframe()
  self:update_dir()
  self:check_skill_time_event()
end

function M:low_update()
  if self.v_dist_abort_sqruare > 0 then
    local distance
    if self.v_target then
      distance = self.v_char:get_square_dist(self.v_target)
    else
      distance = Vec3.SquareDistance(self.v_char:get_pos_vec3(), self.v_target_pos)
    end
    if distance > self.v_dist_abort_sqruare then
      self:stop()
      return
    end
  end
  if self.v_target then
    self.v_target_pos = self.v_target:get_pos_vec3()
  end
end

function M:check_skill_time_event()
  if not self.v_before_time_event_trigger and self.v_skill_time >= self:get_before_time() then
    self.v_before_time_event_trigger = true
    BehaviorMgr:call_behavior_fun(self.v_char, BehaviorMgr.EVENTS.ON_SKILL_BEFORE_TIME, self.skill_id)
  end
  if not self.v_cast_time_event_trigger and self.v_skill_time >= self:get_before_time() + self:get_cast_time() then
    self.v_cast_time_event_trigger = true
    BehaviorMgr:call_behavior_fun(self.v_char, BehaviorMgr.EVENTS.ON_SKILL_CAST_TIME, self.skill_id)
  end
end

function M:update_energy()
  local info = self.v_energy_info
  if info and info.cur_energy < info.max_energy then
    local re_multi = self.v_char.attr_mgr:get_attr(Config.CHAR_ATTR_TYPE.RECOVER_ENERGY_ADDITIVE)
    info.real_recover_energy = info.recover_energy * (1 + re_multi * Config.NUM_TO_RATIO)
    local add_energy = info.real_recover_energy * self.v_char.time_mgr:get_low_dt_time()
    self:set_skill_cur_energy(info.cur_energy + add_energy)
  end
end

function M:_update_dir_by_joystick()
  if self.v_char ~= Global.hero then
    return
  end
  local x, y = Global.camera_joystick_x, Global.camera_joystick_y
  if _amost_zero2(x, y) then
    return
  end
  local dir = _atan(x, y) * rad2Deg
  self.v_char:set_target_dir(dir)
end

function M:start_turn_dir(deg, time, type, acc, stop_type)
  self.v_turn_dir_deg_speed = deg
  self.v_trun_acc = acc or 0
  self.v_abs_turn_speed = _abs(deg)
  self.v_turn_dir_time = time
  self.v_turn_type = type
  self.v_turn_dir_stop_type = stop_type
end

local function update_skill_speed(skill, dt)
  skill.v_turn_dir_deg_speed = skill.v_turn_dir_deg_speed + dt * skill.v_trun_acc
  skill.v_abs_turn_speed = _abs(skill.v_turn_dir_deg_speed)
end

local DirHelper = {
  [MAGIC_TURN_DIR_TYPE.BY_ARGS] = function(skill, cur_deg, dt)
    update_skill_speed(skill, dt)
    return cur_deg + skill.v_turn_dir_deg_speed * dt
  end,
  [MAGIC_TURN_DIR_TYPE.TURN_TO_TAR] = function(skill, cur_deg, dt)
    update_skill_speed(skill, dt)
    local pos = skill:get_target_pos()
    if pos then
      local dx, _, dz = skill.v_char:get_dir_to_pos2(pos)
      return _atan(dx, dz) * rad2Deg
    end
  end,
  [MAGIC_TURN_DIR_TYPE.BY_JOYSTICK] = function()
    local x, y = Global.camera_joystick_x, Global.camera_joystick_y
    if not _amost_zero2(x, y) then
      return _atan(x, y) * rad2Deg
    end
  end,
  [MAGIC_TURN_DIR_TYPE.BY_TURN_POS] = function(skill, cur_deg, dt)
    update_skill_speed(skill, dt)
    skill.v_turn_pos = skill.v_turn_pos or skill.v_char:get_turnpos()
    if skill.v_turn_pos then
      local dir = skill.v_turn_pos - skill.v_char:get_pos_vec3()
      if not _amost_zero2(dir.x, dir.z) then
        return _atan(dir.x, dir.z) * rad2Deg
      end
    end
  end
}

function M:_update_turn_dir()
  if self.v_pause_turn_dir then
    return
  end
  if self.v_turn_dir_time and self.v_turn_dir_time > 0 then
    local dt = self.v_char.time_mgr:get_dt_time()
    self.v_turn_dir_time = self.v_turn_dir_time - dt
    local cur_deg = self.v_char:get_dir()
    local dir_get_func = DirHelper[self.v_turn_type]
    assert(dir_get_func, "no such turn_type" .. self.v_turn_type)
    local tar_deg = dir_get_func(self, cur_deg, dt)
    if not tar_deg then
      return
    end
    tar_deg = (tar_deg + 360) % 360
    if (not self.v_turn_dir_stop_type or self.v_turn_dir_stop_type == Config.SKILL_TURN_DIR_STOP_TYPE.NORMAL_OUT) and math.abs(cur_deg - tar_deg) < NEXT_FRAME_EXIT_DEG * self.v_char.time_mgr:get_time_scale() then
      if not Util.almost_zero(dt) then
        self:clear_turn_dir()
      end
      return
    end
    local step = self.v_abs_turn_speed * dt
    local diff = (tar_deg - cur_deg + 180) % 360 - 180
    local abs_diff = _abs(diff)
    if step > abs_diff then
      step = abs_diff
    end
    local dir = diff > 0 and 1 or -1
    self.v_char:set_target_dir(cur_deg + step * dir, true)
  end
end

function M:clear_turn_dir()
  self.v_turn_dir_deg_speed = nil
  self.v_turn_dir_time = nil
  self.v_turn_dir_stop_type = nil
  self.v_abs_turn_speed = nil
  self.v_turn_type = nil
  self.v_turn_pos = nil
end

local FaceHelper = {
  [SKILL_FACE_TYPE.LOCK_CUR_DIR] = function(skill)
  end,
  [SKILL_FACE_TYPE.TO_TARGET] = function(skill, attack_state)
    if attack_state:is_cast_time() then
      local pos = skill:get_target_pos()
      if pos then
        skill.v_char:face_to_pos(pos.x, pos.z, true)
      end
    end
  end,
  [SKILL_FACE_TYPE.LOCK_TARGET] = function(skill)
    local pos = skill:get_target_pos()
    if pos then
      skill.v_char:face_to_pos(pos.x, pos.z, true)
    end
  end,
  [SKILL_FACE_TYPE.TO_OPERATION] = function(skill)
    skill:_update_dir_by_joystick()
  end,
  [SKILL_FACE_TYPE.TO_KEYFRAME] = function(skill)
    skill:_update_turn_dir()
  end
}

function M:update_dir()
  local attack_state = self.v_char.state_manager:get_attack_state()
  if not attack_state then
    return
  end
  local face_func = FaceHelper[self.v_skill_face_type]
  assert(face_func, "no such face_type")
  face_func(self, attack_state)
end

function M:update_keyframe()
  while true do
    local temp_time = self.v_last_frame_time + Config.LOGIC_FRAME
    local can_next_frame = temp_time < self.v_skill_time
    if not can_next_frame then
      break
    end
    self.v_last_frame_time = temp_time
    self.v_frame = self.v_frame + 1
    self:_do_update_keyframe()
  end
end

function M:_do_update_keyframe()
  local keyframe
  if UNITY_EDITOR then
    self:get_keyframe()
  end
  keyframe = self.v_keyframes
  if not keyframe then
    return
  end
  local frame_event = keyframe[self.v_frame]
  if not frame_event then
    return
  end
  local skill_mgr = self.v_char.skill_mgr
  for _, event in ipairs(frame_event) do
    local action = event[2]
    if skill_mgr:try_do_keyframe(event[0]) then
      KeyFrameAction[action](self, event)
    end
  end
end

function M:is_stoped()
  return self.v_stop
end

function M:stop(is_abort, is_behit_abort, break_abort)
  if self.v_stop == true then
    return
  end
  self.v_stop = true
  self:_on_skill_end(is_abort)
  local effects = self.v_effects
  for effect_id, abort_type in pairs(effects) do
    self.v_char.act_effect_ctrl:stop_effect(effect_id)
    local need_remove = abort_type == SKILL_FX_ABORT_TYPE.BOTH_ABORT or abort_type == SKILL_FX_ABORT_TYPE.BEHIT_ABORT and is_behit_abort or abort_type == SKILL_FX_ABORT_TYPE.SELF_ABORT and not is_behit_abort
    if need_remove then
      self.v_char.act_effect_ctrl:stop_effect(effect_id)
      effects[effect_id] = nil
    end
  end
  self.v_char.magic_mgr:remove_magics_by_skill_id(self.skill_id, is_behit_abort, self.v_magic_stop_type)
  self.v_need_deduct_consume = false
  self:report_skill_end(is_abort)
  self:check_abort_sound(is_behit_abort, break_abort)
  if self.v_char:is_hero() then
    Global.camera:atk_correct_distance()
  end
  if Global.camera:get_view_type() == Config.CAMERA_VIEW_TYPE.SHOULDER and self.v_is_begin_attack_hero then
    local msg = MsgGame:mq_publish2(Const.MSG_ON_MONSTER_END_ATTACK_HERO)
    msg.mm_x = self.v_char.uuid
    self.v_is_begin_attack_hero = false
  end
  self.v_char.skill_mgr:on_skill_end(self.skill_id)
end

function M:play_cast(missile_id)
  if SceneMgr:be_cleaning_up_missile() then
    return
  end
  local target_pos
  if Util.is_true(self.skill_cfg.MissileLockTarget) then
    target_pos = self.v_target and self.v_target:get_pos_vec3() or self.v_target_pos
  else
    target_pos = self.v_target_pos
  end
  local ext_args
  if self.v_skill_action_info then
    ext_args = {
      skill_action_info = self.v_skill_action_info
    }
  end
  local missile = SceneMgr:create_missile(self.v_char, nil, missile_id, self.v_target, nil, self.v_level, self.skill_id, target_pos, Vec3.zero, ext_args)
  if missile then
    missile:set_cast_frame(self.v_frame)
  end
end

function M:_check_can_shift_fixed()
  local data = self.fixed_time_shift_data
  if not data then
    return
  end
  local dt = self.v_char.time_mgr:get_dt_time()
  local s = data.total_time <= data.acc_time and data.cur_speed * dt + data.acc_speed * dt / 2 or data.cur_speed * dt - data.redu_speed * dt / 2
  return self:_can_shift(s)
end

function M:play_skill_fixed_time_shift(start_speed, acc_time, redu_time)
  if self.v_skill_move_type ~= SKILL_MOVE_TYPE.FIXED_TIME_MOVE then
    return
  end
  local cur_dist = self:get_cur_dist()
  local total_time = acc_time + redu_time
  local acc_dist = acc_time / total_time * cur_dist
  local redu_dist = redu_time / total_time * cur_dist
  local acc_speed = 2 * acc_dist / acc_time ^ 2 - 2 * start_speed / acc_time
  local final_acc_speed = acc_speed * acc_time + start_speed
  local redu_speed = 2 * final_acc_speed / redu_time - 2 * redu_dist / redu_time ^ 2
  local x, z = self.v_char:get_pos2()
  local tpos = self:get_target_pos()
  self.v_break_x, self.v_break_z = Mathx.normalize2(x - tpos.x, z - tpos.z)
  self.fixed_time_shift_data = {
    total_time = 0,
    acc_speed = acc_speed,
    redu_speed = redu_speed,
    cur_speed = start_speed,
    acc_start_speed = start_speed,
    redu_start_speed = final_acc_speed,
    is_acc = true,
    acc_time = acc_time,
    redu_time = redu_time,
    total_disp = 0
  }
  local _, final_step = self:_check_can_shift_fixed()
  if final_step then
    self:stop_fixed_time_shift()
  end
  self.v_char.role_move_ctrl:set_fixed_time_shift_data(self.fixed_time_shift_data)
end

function M:play_skill_shift(start_speed, duration, acc, deg, break_config, turn_type, notify_type)
  if not break_config then
    if self.v_skill_move_type == SKILL_MOVE_TYPE.DONT_MOVE then
      return
    end
    if self.v_skill_move_type == SKILL_MOVE_TYPE.TO_TARGET_TRACK or self.v_skill_move_type == SKILL_MOVE_TYPE.TO_TARGET_TRACK_ALWAYS then
      self.v_dir_stop_dist = self.v_force_stop_dist and self.v_force_stop_dist + self.v_char.collider:get_radius() or nil
    elseif self.v_skill_move_type == SKILL_MOVE_TYPE.TO_TARGET_TRACK_WITHOUT_BODY or self.v_skill_move_type == SKILL_MOVE_TYPE.TO_TARGET_TRACK_ALWAYS_WITHOUT_BODY then
      self.v_dir_stop_dist = self.v_force_stop_dist
    end
  end
  self.v_shift = true
  self.v_shift_start_speed = start_speed
  self.v_shift_speed = start_speed
  self.v_shift_acc = acc
  self.v_shift_duration = duration
  self.v_shift_time = 0
  self.v_shift_deg = nil
  self.v_shift_trace = false
  self.v_shift_turn_type = turn_type
  self.v_shift_notify_type = notify_type
  local x, z = self.v_char:get_pos2()
  local tpos = self:get_target_pos()
  self.v_break_x, self.v_break_z = Mathx.normalize2(x - tpos.x, z - tpos.z)
  if deg > 0 then
    self.v_shift_deg = deg
  end
  local target
  if break_config then
    if break_config and turn_type == TURN_TYPE.TO_TARGET_TRACK_ALWAYS then
      target = self.v_target
      self.v_shift_trace = true
    end
  elseif self.v_skill_move_type == SKILL_MOVE_TYPE.TO_TARGET_TRACK_ALWAYS or self.v_skill_move_type == SKILL_MOVE_TYPE.TO_TARGET_TRACK_ALWAYS_WITHOUT_BODY then
    target = self.v_target
    self.v_shift_trace = true
  end
  self.v_char.role_move_ctrl:set_move_by_skill(true, target)
  self.v_char.role_move_ctrl:set_skill_move_speed(self.v_shift_speed, self.v_shift_acc, self.v_shift_trace, self.v_shift_start_speed)
  self.v_char.role_move_ctrl:set_skill_move_param(self.v_shift_deg)
  self.v_char.role_move_ctrl:set_skill_break_config(break_config)
end

function M:skill_move_by_joystick(max_speed, fade_in_time, fade_out_time, duration)
  if not duration or duration < -1 or 0 == duration or self.v_skill_move_type == SKILL_MOVE_TYPE.DONT_MOVE then
    return
  end
  self.v_joystick_move = true
  self.v_char.role_move_ctrl:skill_move_by_joystick(max_speed, fade_in_time, fade_out_time, duration)
end

function M:get_cur_dist()
  if self.v_target then
    return self.v_char.role_move_ctrl:get_dist_to_target(self.v_target)
  else
    return Vec3.Distance(self.v_char:get_pos_vec3(), self.v_target_pos)
  end
end

function M:get_target_pos()
  return self.v_target and self.v_target:get_pos_vec3() or self.v_target_pos
end

function M:get_target_radius()
  return self.v_target and self.v_target.radius or 0
end

function M:_can_shift(move_step)
  if self.v_skill_move_type == SKILL_MOVE_TYPE.TO_TARGET then
    return true
  end
  local dir = self.v_shift_speed * -1
  local dist = self:get_cur_dist()
  local break_lenth = self.v_dir_stop_dist or 0.01
  local end_step
  local tpos = self:get_target_pos()
  local break_x, break_z = tpos.x + self.v_break_x * break_lenth, tpos.z + self.v_break_z * break_lenth
  local cx, cz = self.v_char:get_pos2()
  local end_line_dist = Mathx.distance2(break_x, break_z, cx, cz)
  local act_ctrl = self.v_char.act_ctrl
  if act_ctrl then
    local anim_x, anim_z = act_ctrl:get_cur_frame_offset()
    move_step = move_step + Mathx.distance2(anim_x, anim_z, 0, 0)
  end
  if move_step and end_line_dist < move_step then
    end_step = end_line_dist
  end
  return dir >= 0 and dist < break_lenth or dir <= 0 and dist > break_lenth, end_step
end

function M:update_skill_shift()
  if not self.v_shift then
    return
  end
  local dt = self.v_char.time_mgr:get_dt_time()
  self.v_shift_time = self.v_shift_time + dt
  if self.v_shift_time >= self.v_shift_duration then
    self:stop_skill_shift()
    return
  end
end

function M:get_skill_shift_remain_time()
  return math.max(self.v_char.time_mgr:get_time() - self.v_shift_start_time, 0)
end

function M:update_fixed_time_shift()
  if not self.fixed_time_shift_data then
    return
  end
  local move_time = self.v_char.time_mgr:get_dt_time()
  local shift_data = self.fixed_time_shift_data
  local total_time = shift_data.total_time
  local is_acc = total_time < shift_data.acc_time
  if shift_data.is_acc ~= is_acc then
    shift_data.total_disp = 0
  end
  shift_data.is_acc = is_acc
  local start_speed, acc_speed, cur_time, next_time, cur_total_disp
  if is_acc then
    start_speed = shift_data.acc_start_speed
    acc_speed = shift_data.acc_speed
    cur_time = total_time
    next_time = cur_time + move_time
    cur_total_disp = start_speed * next_time + acc_speed / 2 * next_time ^ 2
    self.v_shift_speed = start_speed + acc_speed * next_time
  else
    start_speed = shift_data.redu_start_speed
    acc_speed = shift_data.redu_speed
    cur_time = total_time - shift_data.acc_time
    next_time = cur_time + move_time
    cur_total_disp = start_speed * next_time - acc_speed / 2 * next_time ^ 2
    self.v_shift_speed = start_speed - acc_speed * next_time
  end
  if shift_data.total_time > shift_data.acc_time + shift_data.redu_time then
    cur_total_disp = 0
  end
  shift_data.total_time = shift_data.total_time + move_time
  local stop = cur_total_disp - shift_data.total_disp <= 0
  self.v_char.role_move_ctrl:set_fixed_time_shift_step(cur_total_disp, stop)
  self.v_char.role_move_ctrl:update_fixed_time_shift()
end

function M:pause_skill_shift(is_pause)
  if is_pause then
    if self.v_shift_turn_type == TURN_TYPE.PAUSE_ROTATE_ON_MOVE_PAUSE then
      self.v_pause_turn_dir = true
    end
    if self.v_shift_notify_type == NOTIFY_TYPE.ON_PAUSE_AND_STOP then
      BehaviorMgr:call_behavior_fun(self.v_char, BehaviorMgr.EVENTS.ON_SKILL_SHIFT_PAUSE, self.skill_id, false)
    end
  else
    self.v_pause_turn_dir = nil
  end
end

function M:stop_skill_shift()
  self.v_shift = false
  if self.v_shift_turn_type == TURN_TYPE.STOP_ROTATE_ON_MOVE_STOP or self.v_shift_turn_type == TURN_TYPE.PAUSE_ROTATE_ON_MOVE_PAUSE then
    self:clear_turn_dir()
  end
  if self.v_shift_notify_type == NOTIFY_TYPE.ON_STOP or self.v_shift_notify_type == NOTIFY_TYPE.ON_PAUSE_AND_STOP then
    BehaviorMgr:call_behavior_fun(self.v_char, BehaviorMgr.EVENTS.ON_SKILL_SHIFT_PAUSE, self.skill_id, true)
  end
  self.v_shift_turn_type = nil
  self.v_shift_notify_type = nil
  self.v_pause_turn_dir = nil
  self.v_char.role_move_ctrl:set_move_by_skill(false)
end

function M:stop_fixed_time_shift()
  self.fixed_time_shift_data = nil
  self.v_char.role_move_ctrl:set_fixed_time_shift_data(nil)
end

function M:play_effect(param)
  if not self.v_char.act_effect_ctrl then
    return
  end
  local effect_param = self.v_char.act_effect_ctrl.create_effect_param()
  effect_param.prefab_name = param[3]
  effect_param.attach_point = param[4]
  effect_param.follow_time = param[6]
  effect_param.effect_length = param[7]
  effect_param.scale = param[8]
  effect_param.time_scale = param[9]
  effect_param.is_weapon_attach = param[10]
  effect_param.effect_source = Config.EFFECT_SOURCE.SKILL_PLAY
  local effect_id = self.v_char.act_effect_ctrl:play_attach_effect(effect_param, self.v_char)
  if param[5] ~= SKILL_FX_ABORT_TYPE.NONE then
    self:add_effect(effect_id, param[5])
  end
  return effect_id
end

function M:get_magic_level(magic_id)
  return self.v_char.skill_mgr:get_magic_level(magic_id) or self.v_level
end

function M:play_magic(magic_id, magic_level, stop_type)
  if self.v_char:is_destroy() then
    return
  end
  if not magic_level or 0 == magic_level then
    magic_level = self:get_magic_level(magic_id)
  end
  if stop_type then
    self.v_magic_stop_type = self.v_magic_stop_type or {}
    self.v_magic_stop_type[magic_id] = stop_type or 0
  end
  self.v_char.magic_mgr:add_magic(self.v_char, magic_id, nil, self, magic_level, nil, {
    frame_num = self.v_frame,
    frame_event = true,
    attacker_magic_mgr = self.v_char.magic_mgr,
    attacker_attr_mgr = self.v_char.attr_mgr
  })
end

function M:add_effect(effect_id, abort_type)
  self.v_effects[effect_id] = abort_type
end

function M:get_char()
  return self.v_char
end

function M:get_animation()
  return self.skill_cfg.Animation
end

function M:get_name()
  return self.skill_cfg.Name
end

function M:get_skill_face_type()
  return self.skill_cfg.SkillFaceType
end

function M:get_skill_move_track_distance()
  return self.skill_cfg.SkillMoveTrackDistance
end

function M:get_skill_move_type()
  return self.skill_cfg.SkillMoveType
end

function M:get_after_time()
  return self.skill_cfg.AfterTime
end

function M:get_cast_time()
  return self.skill_cfg.CastTime
end

function M:get_before_time()
  return self.skill_cfg.BeforeTime or 0
end

function M:get_skill_quit_sign()
  return self.skill_cfg.QuitSign
end

function M:get_cast_end_time()
  return self.v_skill_cast_end_time
end

function M:get_skill_type()
  return self.skill_cfg.SkillType
end

function M:get_skill_priority()
  return self.v_skill_priority
end

function M:get_dist_no_target()
  return self.skill_cfg.DistNoTarget
end

function M:get_elapse()
  return self.v_skill_time
end

function M:get_armor_atk_lv()
  return self.skill_cfg.SuperArmorAtkLevel or 0
end

function M:get_armor_def_lv()
  return self.skill_cfg.SuperArmorDefLevel or 0
end

function M:can_coexist(skill_id)
  return self.v_coexist_skills[skill_id]
end

function M:get_keyframe()
  local fashion_id = self.v_char:is_role() and self.v_char:get_fashion_id()
  self.v_keyframes = FightDataMgr:get_cache_keyframe_cfg(self.skill_id, fashion_id)
end

function M.check_face_shadow_map(magics)
  for _, magic_id in ipairs(magics) do
    local magic_cfg = ShareRes.get_magic_cfg(magic_id)
    if magic_cfg and magic_cfg.logic then
      return magic_cfg.logic.type == RENDER_SHADOW_MAP_MAGIC_TYPE
    end
  end
end

function M:check_need_init_energy()
  if self.v_char:is_hero() and not self.v_energy_info then
    self:init_energy()
  end
end

function M:init_energy()
  local re_multi = self.v_char.attr_mgr:get_attr(Config.CHAR_ATTR_TYPE.RECOVER_ENERGY_ADDITIVE)
  local recover_energy = self.skill_cfg.CdChargePerSecRecover
  local cur_energy = self.skill_cfg.CdChargeMax
  local cost_energy = self.skill_cfg.CdChargePerCost
  self.v_energy_info = {
    owner_buddy_id = self.v_char:is_hero() and self.v_char:get_npc_id() or nil,
    skill_id = self.skill_id,
    skill_type = self.skill_cfg.SkillType,
    cur_energy = cur_energy,
    cost_energy = cost_energy,
    max_energy = self.skill_cfg.CdChargeMax,
    charge_times = self.skill_cfg.CdChargeTimes,
    recover_energy = recover_energy,
    init_recover_energy = recover_energy,
    energy_section = cost_energy > 0 and cur_energy / cost_energy or 0,
    real_recover_energy = recover_energy * (1 + re_multi * Config.NUM_TO_RATIO)
  }
end

function M:get_energy_info()
  return self.v_energy_info
end

function M:get_skill_charge_time()
  return self.v_energy_info and self.v_energy_info.charge_times or 0
end

function M:on_change_skill_energy(energy, is_max_energy)
  if not is_max_energy then
    if self.v_energy_info.qte_type then
      self:set_skill_cur_energy(0)
    end
    self:set_skill_cur_energy(self.v_energy_info.cur_energy + energy)
  elseif self.v_energy_info.skill_type == SKILL_TYPE.COUNTER or self.v_energy_info.skill_type == SKILL_TYPE.LEVEL then
    self.v_energy_info.max_energy = self.v_energy_info.max_energy + energy
    self:set_skill_cur_energy(self.v_energy_info.cur_energy + energy)
  end
  local msg = MsgGame:mq_publish2(Const.MSG_UI_FIGHT_ENERGY)
  msg.mm_x = self.skill_id
end

function M:on_set_skill_energy(energy, is_max_energy)
  if not is_max_energy then
    self:set_skill_cur_energy(energy)
  elseif self.v_energy_info.skill_type == SKILL_TYPE.COUNTER or self.v_energy_info.skill_type == SKILL_TYPE.LEVEL then
    self.v_energy_info.max_energy = energy
  end
  local msg = MsgGame:mq_publish2(Const.MSG_UI_FIGHT_ENERGY)
  msg.mm_x = self.skill_id
end

function M:set_skill_cur_energy(energy)
  local info = self.v_energy_info
  info.cur_energy = _clamp(energy, 0, info.max_energy)
  info.energy_section = info.cost_energy > 0 and math.floor(info.cur_energy / info.cost_energy) or 0
end

function M:on_change_skill_recover_energy(recover_energy)
  recover_energy = recover_energy + self.v_energy_info.init_recover_energy
  self.v_energy_info.recover_energy = recover_energy
end

function M:on_set_skill_recover_energy(recover_energy)
  self.v_energy_info.recover_energy = recover_energy
end

function M:get_skill_init_recover_energy()
  return self.v_energy_info and self.v_energy_info.init_recover_energy or 0
end

function M:get_skill_max_energy()
  return self.v_energy_info and self.v_energy_info.max_energy or 0
end

function M:get_skill_energy()
  return self.v_energy_info and self.v_energy_info.cur_energy or 0
end

function M:get_skill_energy_info()
  return self.v_energy_info
end

function M:set_level(level)
  self.v_level = level
end

function M:get_level()
  return self.v_level
end

function M:report_skill_start()
  if not StateReport then
    return
  end
  self.rtid = SceneMgr:get_rtid()
  local request = {
    uuid = self.v_char.uuid,
    skill_id = self.skill_id,
    skill_rtid = self.rtid
  }
  StateReport:cast_skill(request)
end

function M:report_skill_end(is_abort)
  if not StateReport then
    return
  end
  if TowerMgr and TowerMgr:will_exit() then
    return
  end
  is_abort = is_abort or false
  local request = {
    uuid = self.v_char.uuid,
    is_abort = is_abort,
    skill_rtid = self.rtid,
    is_building = MagicReporter:is_building_report()
  }
  StateReport:stop_skill(request)
end

function M:skill_play_sound(sound_id, abort_type, fade_out_time, binding_time)
  local binding_obj
  if binding_time and 0 ~= binding_time then
    binding_obj = self.v_char
  end
  if fade_out_time then
    self.v_sound_fade_out_time = fade_out_time
  end
  if abort_type ~= SOUND_ABORT_TYPE.NONE then
    self.v_abort_type = abort_type
  end
  self.v_is_sound = true
  Global.sound_mgr:skill_key_frame_play_sound(self.v_char, sound_id, binding_obj, binding_time, abort_type)
end

function M:check_abort_sound(is_behit_abort, break_abort)
  if break_abort then
    Global.sound_mgr:abort_skill_sound(self.v_char, self.v_sound_fade_out_time, self.v_abort_type)
    return
  end
  if not self.v_is_sound then
    return
  end
  local abort_type = self.v_abort_type
  if not abort_type or abort_type == SOUND_ABORT_TYPE.NONE then
    return
  end
  local is_abort = true
  if abort_type == SOUND_ABORT_TYPE.BEHIT_ABORT and not is_behit_abort then
    is_abort = false
  end
  if not is_abort then
    return
  end
  Global.sound_mgr:abort_skill_sound(self.v_char, self.v_sound_fade_out_time)
  self.v_is_sound = false
end

function M:can_cast_next()
  if not self.v_energy_info then
    return true
  end
  local cost = self.skill_cfg.BattleResCost
  if 1 == self.skill_cfg.BattleResCostType and cost and cost > 0 then
    local cur_sp_value = self.v_char.attr_mgr:get_attr(Config.CHAR_ATTR_TYPE.CHAR_SP)
    return cur_sp_value and cur_sp_value - cost >= 0 or true
  end
  return true
end

function M:get_use_res_id()
  return 1 == self.skill_cfg.BattleResCostType and Config.CHAR_ATTR_TYPE.CHAR_SP
end

function M:check_skill_consume()
  if not self.v_need_deduct_consume or self.v_skill_time < self:get_before_time() then
    return
  end
  if 1 == self.skill_cfg.BattleResCostType then
    local battle_res_cost = self.skill_cfg.BattleResCost
    if battle_res_cost and battle_res_cost > 0 then
      local magic_id = Config.SKILL_CONSUME_MAGIC.BATTLE_RES_COST
      self.v_char.magic_mgr:add_magic(self.v_char, magic_id, nil, self, battle_res_cost)
    end
    local skill_res_cost = self.skill_cfg.SkillResCost
    if skill_res_cost and skill_res_cost > 0 then
      local magic_id = Config.SKILL_CONSUME_MAGIC.SKILL_RES_COST
      self.v_char.magic_mgr:add_magic(self.v_char, magic_id, nil, self, skill_res_cost)
    end
    local ult_res_cost = self.skill_cfg.UltResCost
    if ult_res_cost and ult_res_cost > 0 then
      local magic_id = Config.SKILL_CONSUME_MAGIC.ULT_RES_COST
      self.v_char.magic_mgr:add_magic(self.v_char, magic_id, nil, self, ult_res_cost)
    end
  end
  if self.v_energy_info then
    self:on_change_skill_energy(-self.v_energy_info.cost_energy)
  end
  self.v_need_deduct_consume = false
end

function M:play_bezier_move(spline_file_path, align_curve)
  self.v_is_bezier_moving = true
  self.v_spline_file_path = spline_file_path
  self.v_align_curve = align_curve
  self.v_char.role_move_ctrl:start_bezier_move(spline_file_path, align_curve)
end

function M:stop_bezier_move()
  self.v_char.role_move_ctrl:stop_bezier_move()
  self.v_is_bezier_moving = false
end

function M:set_ignore_consume_detect(is_ignore)
  if is_ignore and self.v_energy_info then
    self:on_change_skill_energy(self.v_energy_info.max_energy)
  end
  self.v_ignore_consume_detect = is_ignore
end

function M:is_ignore_consume_detect()
  return self.v_ignore_consume_detect
end

function M:get_check_move_param()
  return self.v_skill_move_type, self.v_dir_stop_dist, self.v_break_x, self.v_break_z
end

function M:add_bind_skill_missile(missile_uuid)
  self.v_cast_missile_map[missile_uuid] = true
end

function M:remove_bind_skill_missile(missile_uuid)
  if not self.v_cast_missile_map then
    return
  end
  self.v_cast_missile_map[missile_uuid] = nil
end

function M:stop_bind_skill_missile()
  for missile_uuid in pairs(self.v_cast_missile_map) do
    local missile = SceneMgr:get_missile_by_id(missile_uuid)
    if not Util.is_destroy(missile) then
      missile:stop()
    end
    self.v_cast_missile_map[missile_uuid] = nil
  end
end

function M:set_target(target, target_pos)
  self.v_target = target
  self.v_target_pos = target_pos
  if self.v_cast_missile_map then
    for missile_uuid in pairs(self.v_cast_missile_map) do
      local missile = SceneMgr:get_missile_by_id(missile_uuid)
      if not Util.is_destroy(missile) then
        missile:set_target(target)
        missile:set_target_pos(target_pos)
      end
    end
  end
end

return M
