local Base = require("obj.base_component")
local Vec3 = require("base.vec3")
local Vec2 = require("base.vec2")
local Math = require("base.mathx")
local _floor = math.floor
local M = Util.create_child_mt(Base)
local ROOT_MOTION_ANIM = {born = true, finish = true}
local COUNTER_ANIMA = {
  skill1_counter_1 = true,
  skill1_counter_2 = true,
  skill1_counter_3 = true,
  skill1_counter_4 = true
}

function M:_init(char, motion_cfg, transition_cfg)
  Base._init(self)
  self.v_char = self.v_char or char
  self.v_org_motion_cfg = self.v_org_motion_cfg or motion_cfg
  self.v_motion_cfg = self.v_org_motion_cfg
  self.v_org_transition_cfg = self.v_org_transition_cfg or transition_cfg
  self.v_transition_cfg = self.v_org_transition_cfg
  self.v_cur_action = nil
  self.v_anim_time = 0
  self.v_anim_delta_time = 0
  self.v_is_loop = false
  self.v_offsets_multiplier = 1
  self.v_real_offset = Vec3.New(0, 0, 0)
  self.v_offset_diff = Vec2.New(0, 0)
  self.v_last_offset_x, self.v_last_offset_z = 0, 0
  self.v_offset_cfg = nil
  self.v_motion_cache_pos = Vec3.New()
  self.v_action_sound = nil
  self.v_action_sound_playstate = nil
end

function M:on_before_destroy()
  self.v_char = nil
end

function M:can_npc_play_act(action)
  return self.v_motion_cfg and self.v_motion_cfg[action] ~= nil
end

function M:try_action(action, layer, callback, cbdata, is_loop, follow_move_speed, custom_transition_time, start_frame, early_entry_into_fade)
  if not self.v_enable then
    return
  end
  if not self.v_char.animator or self.v_char.animator:IsNull() or self.v_char.v_is_part_mode then
    return
  end
  if self.v_char.model_cfg and self.v_char.model_cfg.ModelId then
    local target_id = tonumber(string.match(self.v_char.model_cfg.ModelId, "%d+"))
    if nil ~= target_id then
      local sound_cfg = ShareRes.get_action_sound_cfg(target_id, action)
      if nil ~= sound_cfg then
        self:play_action_sound(target_id, action)
      else
        self:play_action_sound(self.v_char.character_cfg.NpcId, action)
      end
    end
  end
  local cfg = self.v_motion_cfg and self.v_motion_cfg[action]
  if not cfg then
    local model_cfg = self.v_char.model_cfg
    Log.Error("找不到action配置: ", model_cfg.ModelPath, "action：", action, debug.traceback())
    cfg = self.v_motion_cfg.Stand2
    if not cfg then
      return
    end
  end
  local cur_action = self.v_cur_action
  self.v_next_end = false
  self:_on_new_action()
  self:_on_anim_end()
  self.v_offset_cfg = cfg
  self.v_offset_x_list = cfg.OffsetX or {}
  self.v_offset_z_list = cfg.OffsetZ or {}
  if 0 == #self.v_offset_x_list and 0 == #self.v_offset_z_list then
    self.v_has_offset = false
  else
    self.v_has_offset = true
  end
  local animation = cfg.Animation
  local transition_time = custom_transition_time or self:get_transition_time(layer, cur_action, animation, Global.debug_transition_cfg_name)
  local anim_len
  if is_loop then
    self.v_is_loop = true
    self.v_anim_time = 0
    self.v_anim_delta_time = 0
    anim_len = Util.frame2realtime(cfg.TotalFrame, cfg.TailLength)
  else
    anim_len = Util.frame2realtime(cfg.TotalFrame, cfg.TailLength)
    self.v_anim_time = (start_frame or 0) * Config.LOGIC_FRAME
    self.v_anim_delta_time = 0
    self.v_is_loop = false
  end
  self.v_anim_len = early_entry_into_fade and anim_len - transition_time or anim_len
  self.v_anim_callback = callback
  self.v_follow_move_speed = follow_move_speed
  self.v_anim_cbdata = cbdata
  self.v_layer = layer
  self.v_total_frame = cfg.TotalFrame
  self.v_anim_frame_endtime = Config.LOGIC_FRAME * (cfg.TotalFrame - 1)
  self.v_tail_length = cfg.TailLength
  self.v_last_frame = nil
  self.v_has_set_root_motion_pos = false
  local is_root_motion = ROOT_MOTION_ANIM[action] or true == cfg.RootMotion
  self.v_chara_util = self.v_char:get_character_util()
  if self.v_chara_util then
    self.v_chara_util:EnableRootMotion(is_root_motion)
    self.v_is_root_motion = is_root_motion
  else
    self.v_is_root_motion = false
  end
  if self.v_is_root_motion then
    if self.v_char.orienter then
      self.v_char.orienter:set_enable(false)
    end
    if self.v_char:is_monster() then
      self.v_char:set_rigid_extrapolate()
    end
  end
  self.v_motion_cache_pos.x = 0
  self.v_motion_cache_pos.y = 0
  self.v_motion_cache_pos.z = 0
  self.v_cur_action = action
  self.v_new_action = action
  self.v_new_action_tt = transition_time
  self.v_new_layer = layer
  local fixedtimeoffset = (start_frame or 0) * Config.LOGIC_FRAME
  if fixedtimeoffset > 0 then
    local normalized_time_offset = fixedtimeoffset / self.v_anim_len
    local normalized_transition_time = transition_time / self.v_anim_len
    self.v_char.animator:CrossFade(action, normalized_transition_time, layer, normalized_time_offset)
    self.v_char.weapon_mgr:crossfade_weapon_ani_in_normalizedtime(action, normalized_transition_time, layer, normalized_time_offset)
  else
    self.v_char.animator:CrossFadeInFixedTime(action, transition_time, layer, 0)
    self.v_char.weapon_mgr:crossfade_weapon_ani_in_fixedtime(action, transition_time, layer, 0)
  end
  if self.v_char.attach_model_mgr then
    self.v_char.attach_model_mgr:play_model_ani(action, transition_time, layer, 0.0)
  end
  if Global.debug_transition_cfg_name then
    self.v_last_try_action_time = self.v_char.time_mgr and self.v_char.time_mgr:get_time()
  end
  return true
end

function M:get_transition_time(layer, cur_action, animation, show_log)
  local transition_time
  local layer_cfg = self.v_transition_cfg[layer]
  if layer_cfg then
    local cfg_name, c2n_name, c2a_name, n_name, final_name
    if not show_log then
      if self.v_fade_config_name and layer_cfg[self.v_fade_config_name] then
        transition_time = layer_cfg[self.v_fade_config_name]
      elseif cur_action then
        cfg_name = cur_action .. animation
        if layer_cfg[cfg_name] then
          transition_time = layer_cfg[cfg_name]
        else
          cfg_name = cur_action .. "ANY"
          transition_time = layer_cfg[cfg_name]
        end
      end
      if not transition_time then
        transition_time = layer_cfg[animation]
      end
    else
      if self.v_fade_config_name and layer_cfg[self.v_fade_config_name] then
        c2n_name = self.v_fade_config_name
        final_name = c2n_name
        transition_time = layer_cfg[self.v_fade_config_name]
      elseif cur_action then
        cfg_name = cur_action .. animation
        local temp_name = cur_action .. "-" .. animation
        c2n_name = self.v_fade_config_name and self.v_fade_config_name .. "\t" .. temp_name or temp_name
        final_name = c2n_name
        if layer_cfg[cfg_name] then
          transition_time = layer_cfg[cfg_name]
        else
          c2a_name = cur_action .. "-ANY"
          final_name = c2a_name
          cfg_name = cur_action .. "ANY"
          transition_time = layer_cfg[cfg_name]
        end
      end
      if not transition_time then
        cfg_name = animation
        n_name = cfg_name
        final_name = n_name
        transition_time = layer_cfg[animation]
      end
      local cur_time = self.v_char.time_mgr and self.v_char.time_mgr:get_time()
      Log.Error("动画融合配置 尝试获取key：", c2n_name, c2a_name, n_name, "最终使用key :", final_name, "融合时间 :", transition_time or 0, cur_action and "动画时间" .. self:get_anima_total_time(cur_action), "间隔时间：", cur_time and cur_time - (self.v_last_try_action_time or cur_time), "npc_id", self.v_char.id, "uuid", self.v_char.uuid, debug.traceback())
    end
  end
  self.v_fade_config_name = nil
  return transition_time or 0
end

function M:set_motion_cfg(motion_cfg)
  self.v_motion_cfg = motion_cfg
end

function M:set_transition_cfg(transition_cfg)
  self.v_transition_cfg = transition_cfg
end

function M:set_fade_config_name(config_name)
  self.v_fade_config_name = config_name
end

function M:get_real_offset()
  return self.v_real_offset.x, self.v_real_offset.z
end

function M:is_in_action(layer, action)
  return self.v_layer == layer and self.v_cur_action == action
end

function M:update()
  if not self.v_enable then
    return
  end
  if not self.v_cur_action then
    return
  end
  local dt = self.v_char.time_mgr:get_dt_time()
  if self.v_follow_move_speed then
    dt = dt * self.v_char:get_speed_ratio() * (1 / self.v_char.model_scale)
  end
  self.v_anim_time = self.v_anim_time + dt
  self.v_anim_delta_time = dt
  if not self.v_is_loop and not self.v_keep_end and self.v_anim_time >= self.v_anim_len then
    self:_on_anim_end()
    self.v_next_end = true
  end
  if not self.v_char:is_hero() or not self.v_char:check_background() then
    self:_update_anim_offset()
  end
end

function M:_check_set_root_motion_pos()
  if self.v_is_root_motion and not self.v_has_set_root_motion_pos then
    local tf = self.v_char:get_transform()
    local x, y, z = tf:GetPositionA()
    self.v_char:raw_set_pos(x, y, z)
    if self.v_char.orienter then
      self.v_char.orienter:set_enable(true)
    end
    self.v_char:sync_dir()
    self.v_chara_util:EnableRootMotion(false)
    self.v_has_set_root_motion_pos = true
    self:update_camera_pos()
  end
end

function M:update_camera_pos()
  if self.v_is_root_motion and self.v_char:is_hero() then
    local pos_x, pos_y, pos_z = self.v_char.transform:GetPositionA()
    self.v_motion_cache_pos.x = pos_x
    self.v_motion_cache_pos.y = pos_y
    self.v_motion_cache_pos.z = pos_z
    Global.camera:_follow_target(false, self.v_motion_cache_pos)
  end
end

function M:check_motion_pos()
  return self.v_is_root_motion
end

function M:clear()
end

function M:set_keep_end(layer, keep_end)
  self.v_keep_end = keep_end
end

local function get_offset_helper(offsets, frame, dt, multi_map)
  if not offsets or 0 == #offsets then
    return 0
  end
  local scale = multi_map and multi_map[frame] or 1
  local s = offsets[frame] * scale
  local e = offsets[frame + 1] * scale
  local base = s + (e - s) * dt
  return base
end

local function get_tail_offset(offsets, frame, dt, multi_map)
  if not offsets or #offsets < frame + 1 then
    return 0
  end
  local scale = multi_map and multi_map[frame] or 1
  local s = offsets[frame] * scale
  local e = offsets[frame + 1] * scale
  local base = s + (e - s) * dt
  return base
end

function M:_update_anim_offset()
  if not self.v_cur_action or self.v_is_root_motion then
    self:update_camera_pos()
    return
  end
  self.v_old_action = self.v_cur_action
  local frame = _floor(self.v_anim_time / Config.LOGIC_FRAME) + 1
  local frame_fraction = self.v_anim_time - (frame - 1) * Config.LOGIC_FRAME
  local t = frame_fraction / Config.LOGIC_FRAME
  self.v_last_frame = self.v_last_frame or frame
  local x_multi_map, z_multi_map
  if self.v_offsets_multi_map and self.v_offsets_multi_map[self.v_cur_action] then
    local multi_map = self.v_offsets_multi_map[self.v_cur_action]
    x_multi_map = multi_map.x
    z_multi_map = multi_map.z
  end
  local dx, dz
  if frame + 1 <= self.v_total_frame then
    dx = get_offset_helper(self.v_offset_x_list, frame, t, x_multi_map)
    dz = get_offset_helper(self.v_offset_z_list, frame, t, z_multi_map)
  else
    frame = self.v_total_frame
    if self.v_tail_length > 0 then
      dx = get_tail_offset(self.v_offset_x_list, frame, t, x_multi_map)
      dz = get_tail_offset(self.v_offset_z_list, frame, t, z_multi_map)
    else
      frame = self.v_total_frame
      dx = self.v_last_offset_x
      dz = self.v_last_offset_z
    end
  end
  local rotate
  if not Global.camera or not Global.camera:check_camera_aimed() then
    rotate = -Math.Deg2Rad * self.v_char:get_dir()
  elseif Global.camera and Global.camera:check_camera_aimed() then
    rotate = Math.Deg2Rad * ((Math.get_angle2A(Global.camera_joystick_x, Global.camera_joystick_y) or 0) - 90)
  end
  self.v_offset_diff:Set(dx - self.v_last_offset_x, dz - self.v_last_offset_z)
  self.v_offset_diff:SetRotate(rotate)
  self.v_offset_diff:Mul(self.v_char.model_scale or 1)
  self.v_offset_diff:Mul(self.v_offsets_multiplier)
  self.v_char:move(self.v_offset_diff.x, self.v_offset_diff.y)
  if self.v_old_action and COUNTER_ANIMA[self.v_old_action] then
    if self.v_last_frame ~= frame then
      self.v_last_counter_move_speed = self.v_counter_move_speed
    end
    self.v_counter_move_speed = self.v_offset_diff:Magnitude() / self.v_anim_delta_time
    if Global.debug_move_speed then
      local Behavior = require("manager.fight.behavior")
      Behavior.log_on_npc(self.v_char, "帧：" .. frame .. "速度: " .. self.v_counter_move_speed, true)
    end
  end
  self.v_last_offset_x = dx
  self.v_last_offset_z = dz
  self.v_last_frame = frame
end

function M:get_last_frame()
  return self.v_last_frame
end

function M:get_cur_frame_offset()
  return self.v_offset_diff.x, self.v_offset_diff.y
end

function M:_on_new_action()
  self.v_real_offset.x = 0
  self.v_real_offset.z = 0
  self.v_last_offset_x = 0
  self.v_last_offset_z = 0
  self.v_offset_x_list = nil
  self.v_offset_z_list = nil
  self.v_keep_end = false
end

function M:_on_anim_end()
  if self.v_is_loop then
    return
  end
  self:_check_set_root_motion_pos()
  self.v_keep_end = nil
  self.v_cur_action = nil
  self.v_anim_time = 0
  self.v_anim_delta_time = 0
  self:_call_anim_cb()
end

function M:clear_anim_cb()
  self.v_anim_callback = nil
  self.v_anim_cbdata = nil
end

function M:_call_anim_cb()
  if not self.v_anim_callback then
    return
  end
  local anim_callback = self.v_anim_callback
  local anim_cbdata = self.v_anim_cbdata
  self.v_anim_callback = nil
  self.v_anim_cbdata = nil
  anim_callback(anim_cbdata)
end

function M:get_cur_anim_len()
  return self.v_anim_len
end

function M:get_cur_action()
  return self.v_cur_action
end

function M:old_action_is_counter()
  return self.v_old_action ~= nil and COUNTER_ANIMA[self.v_old_action] ~= nil
end

function M:get_counter_move_speed()
  return self.v_last_counter_move_speed
end

function M:is_in_animationstate(animationstateinfo_name)
  return self.v_char.animator and self.v_char.animator:GetCurrentAnimatorStateInfo(0):IsName(animationstateinfo_name)
end

function M:check_have_die1_action()
  return self.v_char.motion_cfg ~= nil and nil ~= self.v_char.motion_cfg[Config.ACT_DEFINE.Die1]
end

function M:set_move_offsets_multi_map(offsets_multi_map)
  self.v_offsets_multi_map = offsets_multi_map
end

function M:set_move_offsets_multiplier(multiplier)
  self.v_offsets_multiplier = multiplier
end

function M:play_action_sound(npc_id, action_name)
  self:stop_action_sound()
  local cfg = ShareRes.get_action_sound_cfg(npc_id, action_name)
  if cfg and cfg.SoundName then
    self.v_action_sound = cfg.SoundName
    self.v_action_sound_playstate = true
    Global.sound_mgr:play_sound_by_id(self.v_action_sound)
  end
end

function M:stop_action_sound()
  if self.v_action_sound_playstate and self.v_action_sound then
    Global.sound_mgr:stop_sound_by_id(self.v_action_sound)
    self.v_action_sound_playstate = nil
    self.v_action_sound = nil
  end
end

function M:get_anima_total_time(action)
  if self.v_motion_cfg[action] then
    local cfg = self.v_motion_cfg[action]
    return Util.frame2realtime(cfg.TotalFrame, cfg.TailLength)
  end
end

function M:is_follow_move_speed()
  return self.v_follow_move_speed
end

return M
