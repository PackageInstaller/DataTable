local Vec3 = require("base.vec3")
local Quat = require("base.quat")
local change_pos_speed = 8
local change_angle_speed = 16
local change_angle_speed_custom = 16
local change_angle_speed_slow = 6
local model_change_angle_speed = 0.5
local Math = require("base.mathx")
local Layer = require("utils.layer")
local Transform_state = require("utils.transform_state")
local CSUnityEngine = UnityEngine
local CSChangeLayer = CSHelper.ChangeLayerRecursively
local Gyro = CSUnityEngine.Input.gyro
local SignBoardGirlMgr = _ENV.SignBoardGirlMgr
local CSInput = CSUnityEngine.Input
local TouchPhase = CSUnityEngine.TouchPhase
local UnityVector2 = _ENV.UnityVector2
local UnityVector3 = _ENV.UnityVector3
local ACT_DEFINE = Config.ACT_DEFINE
local Base = require("ui.model_rt_view.model_rt_view_new")
local M = Util.create_child_mt(Base)
local _abs = math.abs
local _max = math.max
local SCENE_MODEL_PARAM_TYPE = {LOOK_AT = 1, USE_PARAM = 0}
local GYRO_MODEL_Y = ShareRes.get_comm_value("ModelGyroValueY")
local GYRO_MODEL_X = ShareRes.get_comm_value("ModelGyroValueX")
local GYRO_SCEME_Y = 200
local GYRO_SCEME_X = 100
local TOUCH_ROTATE_SPEED = ShareRes.get_comm_value("CharRtViewRotateSpeed")
local TOUCH_SCALE_SPEED = ShareRes.get_comm_value("CharRtViewScaleSpeed")
local TOUCH_ROTATE_SPEED_M = ShareRes.get_comm_value("CharRtViewRotateSpeedM")
local TOUCH_SCALE_SPEED_M = ShareRes.get_comm_value("CharRtViewScaleSpeedM")
local TOUCH_ROTATE_SPEED_MAX = ShareRes.get_comm_value("CharRtViewRotateSpeedMax")

local function almost_zero(a, b)
  return _abs(a - b) < 0.01
end

local function almost_zero_angle(a, b)
  local diff = _abs(a - b)
  return diff < 0.01 or diff > 359.99
end

function M:_init(...)
  Base._init(self, ...)
  self.v_not_set_light = true
  self.v_effect_is_play = false
  self.v_tmp_quat = Quat.Euler(0, 0, 0)
  self.v_camera_is_fast = false
  self.v_model_is_fast = true
  self.v_npc_param = {}
  self.v_npc_anim = {}
  self.v_force_play = {}
  self.v_anim_callback = {}
  self.v_npc_effect_name_list = {}
  self.v_effect_is_play = {}
  self.effect_trans = {}
  self.v_effect_duration = {}
  self.v_npc_is_playing = {}
  self.v_anim_is_loop = {}
  self.v_custom_transition_time = {}
  self.v_effect_param = {}
  self.v_camera_change_end = false
  self.v_model_change_end = false
  if self.v_use_gyro then
    Gyro.enabled = true
    self.v_gyro_cache_y = 0
    self.v_gyro_cache_x = 0
    Gyro.updateInterval = 0.2
  end
  Util.bind_msg(self, Const.MSG_ON_GM_CHANGE_GYRO_MODEL, self.change_gyro_val, self)
  self.v_npc_effect_id_list = {}
  local args = {
    ...
  }
  self.v_fixed_rt_name = args[6]
end

function M:update()
  if not SignBoardGirlMgr:is_can_update() then
    return
  end
  if not self.v_is_visible then
    return
  end
  Base.update(self)
  self:_check_touch()
  self:camera_update()
  self:model_update()
  self:_play_anim()
  self:_play_effect()
  self:lie_anim_update()
  self:gyro_update()
  self:update_effect_param()
end

function M:on_destroy()
  self:clear_effect_by_effect_ctl()
  Base.on_destroy(self)
  self.v_npc_param = nil
  self.v_npc_anim = nil
  self.v_force_play = nil
  self.v_anim_callback = nil
  self.v_npc_effect_name_list = nil
  self.v_effect_is_play = nil
  self.effect_trans = nil
  self.v_effect_duration = nil
  self.v_npc_is_playing = nil
  self.v_scene_model_cfg = nil
  self.v_anim_is_loop = nil
  self.v_custom_transition_time = nil
  self.v_effect_param = nil
  self:clear_timer()
  self:set_touch_area(nil)
  Util.unbind_all_msg(self)
end

function M:clear_timer()
  if self.v_remove_effect_timer then
    for _, timer_idx in pairs(self.v_remove_effect_timer) do
      Timer:remove_timer(timer_idx)
    end
    self.v_remove_effect_timer = {}
  end
end

function M:load_signboard_npc_param(param, model_idx)
  local pos_x = param.pos_x
  local pos_y = param.pos_y
  local pos_z = param.pos_z
  local rot_x = param.rot_x
  local rot_y = param.rot_y
  local rot_z = param.rot_z
  self.v_npc_param[model_idx] = {
    pos_x = pos_x,
    pos_y = pos_y,
    pos_z = pos_z,
    rot_x = rot_x,
    rot_y = rot_y,
    rot_z = rot_z
  }
  self.v_model_change_end = false
end

function M:change_camera_param(camera_param, is_fast, callback, slow_camera_y)
  self:set_gyro_pause(false)
  local pos_x = camera_param.pos_x
  local pos_y = camera_param.pos_y
  local pos_z = camera_param.pos_z
  local rot_x = camera_param.rot_x
  local rot_y = camera_param.rot_y
  local rot_z = camera_param.rot_z
  local fov = camera_param.fov
  local clip_near = camera_param.clip_near
  local clip_far = camera_param.clip_far
  local speed = camera_param.speed
  self.v_target_pos = Vec3.New(pos_x, pos_y, pos_z)
  rot_x = rot_x < 0 and rot_x + 360 or rot_x
  rot_y = rot_y < 0 and rot_y + 360 or rot_y
  rot_z = rot_z < 0 and rot_z + 360 or rot_z
  self.v_target_angle = Vec3.New(rot_x, rot_y, rot_z)
  self.v_cache_angle = Vec3.New(rot_x, rot_y, rot_z)
  self.v_cache_speed = speed
  self.v_camera_target_fov = fov
  self.v_camera_is_fast = is_fast
  self.v_change_camera_cb = callback
  if clip_near then
    self.v_camera.nearClipPlane = clip_near
    self.v_camera.farClipPlane = clip_far
  end
  if is_fast then
    local trans = self.v_camera_transform
    local target_pos = self.v_target_pos
    local target_angle = self.v_target_angle
    trans:SetLocalPositionA(target_pos.x, target_pos.y, target_pos.z)
    trans:SetEuler(target_angle.x, target_angle.y, target_angle.z)
    if fov then
      self.v_camera.fieldOfView = fov
    end
    self:camera_change_end()
    return
  end
  change_angle_speed_custom = slow_camera_y and change_angle_speed_slow or change_angle_speed
  self.v_camera_change_end = false
end

function M:set_camera_change_end(is_end)
  self.v_camera_change_end = is_end
end

function M:get_camera_change_end()
  return self.v_camera_change_end
end

function M:change_camera_y(value)
  local trans = self.v_camera_root_transform
  local x = trans.localPosition.x
  local z = trans.localPosition.z
  local rot_x, rot_y, rot_z = trans:GetEulerAnglesA3()
  local camera_param = {
    pos_x = x,
    pos_y = value,
    pos_z = z,
    rot_x = rot_x,
    rot_y = rot_y,
    rot_z = rot_z
  }
  self:change_camera_param(camera_param, false)
end

function M:lie_anim_update()
  if not self.v_play_idle_anim then
    return
  end
  for idx, data in pairs(self.v_npc_lie_timer) do
    if not self.v_npc_is_playing[idx] then
      local cd = data.cd
      local lie_cfg = data.lie_cfg
      data.cd = cd + GlobalTimeMgr:get_dt_time()
      if cd > lie_cfg.LieCd then
        local act_index = math.random(#lie_cfg.Act)
        local random_act = lie_cfg.Act[act_index]
        if not Util.is_empty(random_act) then
          self:play_anim(random_act, idx, function()
            data.cd = 0
          end)
          local random_effect = lie_cfg.Effect[act_index]
          local npc = self.v_npc_loaded_map[idx]
          if not Util.is_destroy(npc) and not Util.is_empty(random_effect) then
            local random_point = lie_cfg.Point[act_index]
            self:play_act_effect(idx, random_effect, random_point)
          end
        end
      end
    else
      data.cd = 0
    end
  end
end

function M:camera_update()
  if not SignBoardGirlMgr:is_camera_can_update() then
    return
  end
  local trans = self.v_camera_transform
  local target_pos = self.v_target_pos
  local target_angle = self.v_target_angle
  local ex_speed = self.v_cache_speed or 1
  if self.v_camera_change_end then
    return
  end
  if not target_angle and not target_pos then
    return
  end
  local dt_time = self:get_dt()
  local posx, posy, posz = trans:GetLocalPositionA3()
  local angle_x, angle_y, angle_z = trans:GetLocalEulerAnglesA3()
  angle_x = angle_x < 0 and angle_x + 360 or angle_x
  angle_y = angle_y < 0 and angle_y + 360 or angle_y
  angle_z = angle_z < 0 and angle_z + 360 or angle_z
  local pos_x = Math.lerp_number(posx, target_pos.x, dt_time * change_pos_speed * ex_speed)
  local pos_y = Math.lerp_number(posy, target_pos.y, dt_time * change_pos_speed * ex_speed)
  local pos_z = Math.lerp_number(posz, target_pos.z, dt_time * change_pos_speed * ex_speed)
  local rot_x = Math.lerp_angle(angle_x, target_angle.x, dt_time * change_angle_speed * ex_speed)
  local rot_y = Math.lerp_angle(angle_y, target_angle.y, dt_time * change_angle_speed_custom * ex_speed)
  local rot_z = Math.lerp_angle(angle_z, target_angle.z, dt_time * change_angle_speed * ex_speed)
  if self.v_camera_target_fov then
    local fov = self.v_camera.fieldOfView
    fov = Math.lerp_number(fov, self.v_camera_target_fov, dt_time * change_pos_speed)
    self.v_camera.fieldOfView = fov
  end
  trans:SetLocalPositionA(pos_x, pos_y, pos_z)
  trans:SetEuler(rot_x, rot_y, rot_z)
  if almost_zero(pos_x, target_pos.x) and almost_zero(pos_y, target_pos.y) and almost_zero(pos_z, target_pos.z) and almost_zero_angle(rot_x, target_angle.x) and almost_zero_angle(rot_y, target_angle.y) and almost_zero_angle(rot_z, target_angle.z) then
    self:camera_change_end()
  end
  self:look_at_camera_logic()
end

function M:look_at_camera_logic()
  if self.v_look_at_camera then
    self:set_content_rotate_zero()
  end
end

function M:set_content_rotate_zero()
  self.v_content_root_transform:SetEulerY(0)
end

function M:model_update()
  if not SignBoardGirlMgr:is_camera_can_update() or self.v_model_change_end then
    return
  end
  self:set_npc_pos_rot_euler()
end

function M:set_npc_pos_rot_euler()
  self.v_model_change_end = true
  for idx, data in pairs(self.v_npc_param) do
    local npc = self.v_npc_loaded_map[idx]
    if npc then
      local go = npc.gameobj
      if go and not go:IsNull() then
        local pos_x = data.pos_x
        local pos_y = data.pos_y
        local pos_z = data.pos_z
        local rot_x = data.rot_x
        local rot_y = data.rot_y
        local rot_z = data.rot_z
        local tran = npc.transform
        if self.v_model_is_fast then
          tran:SetLocalPositionA(pos_x, pos_y, pos_z)
          tran:SetLocalEuler(rot_x, rot_y, rot_z)
        else
          local angle_x, angle_y, angle_z = tran:GetLocalEulerAnglesA3()
          local target_angle_x = Math.lerp_angle(angle_x, rot_x, model_change_angle_speed)
          local target_angle_y = Math.lerp_angle(angle_y, rot_y, model_change_angle_speed)
          local target_angle_z = Math.lerp_angle(angle_z, rot_z, model_change_angle_speed)
          tran:SetLocalEuler(target_angle_x, target_angle_y, target_angle_z)
          tran:SetLocalPositionA(pos_x, pos_y, pos_z)
          if not (almost_zero_angle(target_angle_x, rot_x) and almost_zero_angle(target_angle_y, rot_y)) or not almost_zero_angle(target_angle_z, rot_z) then
            self.v_model_change_end = false
          end
        end
      end
    end
  end
end

function M:gyro_update()
  if self.v_use_gyro then
    local att_x, att_y, att_z, att_w = CSHelper.GetGyroAttitudeA()
    local now_gyro_cache_y = att_y
    local now_gyro_cache_x = att_x
    local gyro_diff_y = now_gyro_cache_y - self.v_gyro_cache_y
    local gyro_diff_x = now_gyro_cache_x - self.v_gyro_cache_x
    if _abs(gyro_diff_y) > 0.01 then
      self.v_gyro_cache_y = now_gyro_cache_y
      self.v_target_angle.y = self.v_target_angle.y + gyro_diff_y * GYRO_MODEL_Y
      self.v_bg_target_x = self.v_bg_target_x + gyro_diff_y * GYRO_SCEME_Y
    end
    if _abs(gyro_diff_x) > 0.01 then
      self.v_gyro_cache_x = now_gyro_cache_x
      self.v_target_angle.x = self.v_target_angle.x + gyro_diff_x * GYRO_MODEL_X
      self.v_bg_target_y = self.v_bg_target_y + gyro_diff_x * GYRO_SCEME_X
    end
    if self.v_camera_change_end then
      local trans = self.v_camera_transform
      local dt_time = self:get_dt()
      local temp_num = Math.lerp_number(self.v_target_angle.y, self.v_cache_angle.y, dt_time)
      self.v_target_angle.y = temp_num
      local temp_num_x = Math.lerp_number(self.v_target_angle.x, self.v_cache_angle.x, dt_time)
      self.v_target_angle.x = temp_num_x
      local target_angle = self.v_target_angle
      local angle_x, angle_y, angle_z = trans:GetLocalEulerAnglesA3()
      local rot_x = Math.lerp_angle(angle_x, target_angle.x, dt_time * change_angle_speed)
      local rot_y = Math.lerp_angle(angle_y, target_angle.y, dt_time * change_angle_speed)
      local rot_z = Math.lerp_angle(angle_z, target_angle.z, dt_time * change_angle_speed)
      trans:SetEuler(rot_x, rot_y, rot_z)
      if self.v_bg_go then
        local bg_trans = Util.get_rect_transform(nil, self.v_bg_go)
        local bg_temp_x = Math.lerp_number(self.v_bg_target_x, self.v_bg_x, dt_time)
        self.v_bg_target_x = bg_temp_x
        local bg_temp_y = Math.lerp_number(self.v_bg_target_y, self.v_bg_y, dt_time)
        self.v_bg_target_y = bg_temp_y
        local now_bg_x = bg_trans.anchoredPosition.x
        local now_bg_y = bg_trans.anchoredPosition.y
        local result_x = Math.lerp_number(now_bg_x, self.v_bg_target_x, dt_time * change_angle_speed)
        local result_y = Math.lerp_number(now_bg_y, self.v_bg_target_y, dt_time * change_angle_speed)
        bg_trans:SetAnchoredPositionA(result_x, result_y)
      end
    end
  end
end

function M:get_dt()
  return GlobalTimeMgr:get_dt_time()
end

function M:clear_anim()
  self.v_npc_anim = {}
  self.v_force_play = {}
  self.v_anim_callback = {}
  self.v_anim_is_loop = {}
  self.v_custom_transition_time = {}
  self.v_effect_param = {}
end

function M:play_anim(anim_name, model_index, callback, is_loop, custom_transition_time, effect_param, force_play)
  self.v_npc_anim[model_index] = anim_name
  self.v_force_play[model_index] = force_play
  self.v_anim_callback[model_index] = callback
  self.v_anim_is_loop[model_index] = is_loop
  self.v_custom_transition_time[model_index] = custom_transition_time
  self.v_effect_param[model_index] = effect_param and UtilTable.copy_table(effect_param)
end

function M:_play_anim()
  for idx, anim_name in pairs(self.v_npc_anim) do
    local npc = self.v_npc_loaded_map[idx]
    if npc and (not npc.act_ctrl:is_in_animationstate(anim_name) or self.v_force_play[idx]) then
      npc.act_ctrl:clear_anim_cb()
      npc:try_load_attach_model_by_act(anim_name, function()
        npc.act_ctrl:try_action(anim_name, 0, function()
          if self.v_anim_callback[idx] then
            local callback = self.v_anim_callback[idx]
            self.v_anim_callback[idx] = nil
            callback()
          end
          self.v_npc_is_playing[idx] = false
          local normal_action_name = ACT_DEFINE.Idle
          local is_bird = false
          if TaskMgr then
            is_bird = npc:get_npc_id() == TaskMgr:get_bird_npc_id()
          end
          if self.v_fixed_rt_name == "UIModelRtViewMain" and not is_bird then
            normal_action_name = SignBoardGirlMgr:get_cur_view_stand_by_act()
          end
          if not is_bird and anim_name ~= normal_action_name then
            Util.try_action(npc, normal_action_name)
          end
        end, nil, self.v_anim_is_loop[idx], nil, self.v_custom_transition_time[idx], nil, true)
      end)
      self.v_npc_anim[idx] = nil
      self.v_force_play[idx] = nil
      self.v_anim_is_loop[idx] = nil
      self.v_custom_transition_time[idx] = nil
      self.v_npc_is_playing[idx] = true
    end
  end
end

function M:set_view_param(buddy_id, type, camera_is_fast, model_is_fast, model_idx, fashion_id)
  local buddy_view_cfg = ShareRes.get_show_buddy_pos_info(buddy_id, fashion_id)
  buddy_view_cfg = buddy_view_cfg and buddy_view_cfg[type]
  local default_view_cfg = ShareRes.get_show_buddy_pos_info(0)[type]
  local model_pos = default_view_cfg.ModelPosition
  local model_rot = default_view_cfg.ModelRotation
  local camera_pos = default_view_cfg.CameraPosition
  local camera_rot = default_view_cfg.CameraRotation
  local camera_fov = default_view_cfg.CameraFOV
  local camera_clipping = default_view_cfg.CameraClipping
  self.v_closest_camera_pos = default_view_cfg.ClosestCameraPosition
  self.v_farthest_camera_pos = default_view_cfg.FarthestCameraPosition
  if buddy_view_cfg then
    if buddy_view_cfg.ModelPosition then
      model_pos = buddy_view_cfg.ModelPosition
    end
    if buddy_view_cfg.ModelRotation then
      model_rot = buddy_view_cfg.ModelRotation
    end
    if buddy_view_cfg.CameraPosition then
      camera_pos = buddy_view_cfg.CameraPosition
    end
    if buddy_view_cfg.CameraRotation then
      camera_rot = buddy_view_cfg.CameraRotation
    end
    if buddy_view_cfg.CameraFOV then
      camera_fov = buddy_view_cfg.CameraFOV
    end
    if buddy_view_cfg.CameraRotation then
      camera_clipping = buddy_view_cfg.CameraClipping
    end
    if buddy_view_cfg.ClosestCameraPosition then
      self.v_closest_camera_pos = buddy_view_cfg.ClosestCameraPosition
    end
    if buddy_view_cfg.FarthestCameraPosition then
      self.v_farthest_camera_pos = buddy_view_cfg.FarthestCameraPosition
    end
  end
  self.v_model_is_fast = model_is_fast
  local npc_param = {
    pos_x = model_pos and model_pos[1] or 0,
    pos_y = model_pos and model_pos[2] or 0,
    pos_z = model_pos and model_pos[3] or 0,
    rot_x = model_rot[1],
    rot_y = model_rot[2],
    rot_z = model_rot[3]
  }
  local camera_param = {
    pos_x = camera_pos[1],
    pos_y = camera_pos[2],
    pos_z = camera_pos[3],
    rot_x = camera_rot[1],
    rot_y = camera_rot[2],
    rot_z = camera_rot[3]
  }
  if camera_fov then
    camera_param.fov = camera_fov
  end
  if camera_clipping then
    camera_param.clip_near = camera_clipping[1]
    camera_param.clip_far = camera_clipping[2]
  end
  self:load_signboard_npc_param(npc_param, model_idx)
  self:change_camera_param(camera_param, camera_is_fast)
end

function M:play_effect(effect_name, duration, model_idx)
  if Util.is_empty(effect_name) then
    return
  end
  self.v_npc_effect_name_list[model_idx] = Util.split_str(effect_name, "|")
  self.v_effect_duration[model_idx] = duration
end

function M:_play_effect()
  for model_idx, data in pairs(self.v_npc_effect_name_list) do
    local npc = self.v_npc_loaded_map[model_idx]
    if npc then
      local npc_go = npc.gameobj
      if npc_go and not npc_go:IsNull() and Util.is_empty(data) and not self.v_effect_is_play[model_idx] then
        self.v_effect_is_play[model_idx] = true
        local attach_point = Util.get_child_gameobj(npc_go.transform.name .. "/" .. data[2], self.v_content_root)
        local effect_param = npc.act_effect_ctrl.create_effect_param()
        effect_param.prefab_name = data[1]
        effect_param.parent = attach_point.transform
        
        function effect_param.load_callback()
          CSChangeLayer(attach_point.transform, Layer.Layer.UIModelView)
          self.effect_trans[model_idx] = attach_point.transform:GetChild(attach_point.transform.childCount - 1)
        end
        
        self.effect_id[model_idx] = npc.act_effect_ctrl:play_effect(effect_param)
        self.v_remove_effect_timer[model_idx] = Timer:add_timer("remove_signboard_girl_action_effect", self.v_effect_duration[model_idx], function()
          CSChangeLayer(self.effect_trans[model_idx], Layer.Layer.Default)
          npc.act_effect_ctrl:stop_effect(self.effect_id[model_idx])
          self.v_effect_is_play[model_idx] = false
          self.effect_trans[model_idx] = nil
        end)
        self.v_npc_effect_name_list[model_idx] = nil
      end
    end
  end
end

function M:stop_effect(model_idx)
  local npc = self.v_npc_loaded_map[model_idx]
  if not (npc and npc:is_real_finish_init()) or not self.effect_trans[model_idx] then
    return
  end
  CSChangeLayer(self.effect_trans[model_idx], Layer.Layer.Default)
  npc.act_effect_ctrl:stop_effect(self.effect_id[model_idx])
  self.v_effect_is_play[model_idx] = false
  self.v_npc_effect_name_list[model_idx] = nil
  self.effect_trans[model_idx] = nil
  Timer:remove_timer(self.v_remove_effect_timer[model_idx])
end

function M:remove_npc_by_index(model_idx)
  Base.remove_npc_by_index(self, model_idx)
  self.v_npc_param[model_idx] = nil
  self.v_npc_anim[model_idx] = nil
  self.v_force_play[model_idx] = nil
  self.v_anim_callback[model_idx] = nil
  self.v_npc_effect_name_list[model_idx] = nil
  self.v_effect_is_play[model_idx] = nil
  self.effect_trans[model_idx] = nil
  self.v_effect_duration[model_idx] = nil
  self.v_npc_is_playing[model_idx] = nil
  self.v_effect_param[model_idx] = nil
end

function M:update_scene_model_type(ui_name, type, is_fast, fashion_id)
  local scene_model_cfg_list = ShareRes.get_scene_model_cfg()[ui_name]
  if scene_model_cfg_list then
    self.v_scene_model_cfg = scene_model_cfg_list[type]
    local scene_model_cfg = scene_model_cfg_list[self.v_model_id]
    if scene_model_cfg and scene_model_cfg[type] then
      self.v_scene_model_cfg = scene_model_cfg[type]
    end
    if self.v_scene_model_cfg then
      local type_cfg = self.v_scene_model_cfg
      local IsRectifyAngle = type_cfg.IsRectifyAngle
      self.v_look_at_camera = IsRectifyAngle == SCENE_MODEL_PARAM_TYPE.LOOK_AT
      local camera_pos = type_cfg.CameraPosition
      local camera_rot = type_cfg.CameraRotation
      local camera_fov = type_cfg.CameraFOV
      local camera_clipping = type_cfg.CameraClipping
      local camera_param = {
        pos_x = camera_pos[1],
        pos_y = camera_pos[2],
        pos_z = camera_pos[3],
        rot_x = camera_rot[1],
        rot_y = camera_rot[2],
        rot_z = camera_rot[3]
      }
      if camera_fov then
        camera_param.fov = camera_fov
      end
      if camera_clipping then
        camera_param.clip_near = camera_clipping[1]
        camera_param.clip_far = camera_clipping[2]
      end
      self:update_camera_param(camera_param, is_fast)
      local model_position = self.v_scene_model_cfg.ModelPosition
      local model_rotation = self.v_scene_model_cfg.ModelRotation
      local npc_param = {
        pos_x = 0,
        pos_y = 0,
        pos_z = 0,
        rot_x = model_rotation[1],
        rot_y = model_rotation[2],
        rot_z = model_rotation[3]
      }
      if model_position then
        npc_param.pos_x = model_position[1] or 0
        npc_param.pos_y = model_position[2] or 0
        npc_param.pos_z = model_position[3] or 0
      end
      local fashion_cfg = ShareRes.get_fashion_cfg(fashion_id)
      for model_idx, npc in pairs(self.v_npc_loaded_map) do
        if not Util.is_empty(self.v_scene_model_cfg.ModelId) then
          if fashion_cfg and npc.character_cfg and npc.character_cfg.NpcId == fashion_cfg.BuddyId then
            self:load_signboard_npc_param(npc_param, model_idx)
          end
        else
          self:load_signboard_npc_param(npc_param, model_idx)
        end
      end
    end
  end
end

function M:update_camera_param(camera_param, is_fast)
  self:change_camera_param(camera_param, is_fast)
end

function M:camera_change_end()
  self:look_at_camera_logic()
  self.v_camera_change_end = true
  if self.v_change_camera_cb then
    self.v_change_camera_cb()
    self.v_change_camera_cb = nil
  end
end

function M:change_gyro_val(msg)
  if not msg then
    return
  end
  local x = msg.mm_x
  local y = msg.mm_y
  GYRO_MODEL_Y = y
  GYRO_MODEL_X = x
end

function M:play_act_effect(idx, effect, point, not_set_gameobj, set_effect_root, init_position)
  local npc = self.v_npc_loaded_map[idx]
  local param = npc.act_effect_ctrl:create_effect_param()
  param.prefab_name = effect
  if set_effect_root then
    param.parent = self.v_effect_root and self.v_effect_root.transform
  else
    param.attach_point = point
  end
  
  function param.load_callback(go)
    CSChangeLayer(go.transform, Layer.Layer.Character)
    if init_position then
      if set_effect_root or point then
        go.transform.localPosition = init_position
      else
        go.transform.position = init_position
      end
    end
  end
  
  local effect_id
  
  function param.callback()
    if self.v_npc_effect_id_list[idx] and self.v_npc_effect_id_list[idx][effect_id] then
      self.v_npc_effect_id_list[idx][effect_id] = nil
    end
  end
  
  if param.attach_point and not not_set_gameobj then
    local go = npc:get_setting_point(param.attach_point)
    param.effect_gameobj = go
  end
  effect_id = npc.act_effect_ctrl:play_effect(param, npc)
  self.v_npc_effect_id_list[idx] = self.v_npc_effect_id_list[idx] or {}
  self.v_npc_effect_id_list[idx][effect_id] = effect_id
end

function M:clear_effect_by_effect_ctl()
  for npc_index, effect_ids in pairs(self.v_npc_effect_id_list) do
    local npc = self.v_npc_loaded_map[npc_index]
    if not Util.is_destroy(npc) then
      for key, effect_id in pairs(effect_ids) do
        npc.act_effect_ctrl:stop_effect(effect_id)
      end
      npc.cid = self.v_cid
      npc.effect_owner = self.v_model_root
    end
    self.v_npc_effect_id_list[npc_index] = nil
  end
end

function M:set_touch_area(touch_area_rect)
  if touch_area_rect then
    self:signboard_set_dynamic_bone_enable(true)
    self.v_use_touch = true
    self.v_touch_area = Util.get_screen_area(touch_area_rect)
  else
    self:signboard_set_dynamic_bone_enable(false)
    self.v_use_touch = false
    self.v_touch_area = nil
  end
end

function M:stop_touch_rotate()
  self.v_use_touch = false
end

function M:reset_touch_rotate()
  self.v_use_touch = self.v_touch_area ~= nil
end

function M:signboard_set_dynamic_bone_enable(enable)
  self:set_dynamic_bone_enable(self.v_cur_npc, enable)
end

function M:check_touch_area(pos)
  return self.v_touch_area and Util.is_in_area(pos, self.v_touch_area)
end

function M:_on_pinch(diff)
  if not SignBoardGirlMgr:is_camera_can_update() then
    return
  end
  if not (self.v_target_pos and self.v_farthest_camera_pos) or not self.v_closest_camera_pos then
    return
  end
  local dt_time = self:get_dt()
  local trans = self.v_camera_transform
  local min_pos = self.v_farthest_camera_pos
  local max_pos = self.v_closest_camera_pos
  local _, cur_pos_y, _ = trans:GetLocalPositionA3()
  local start_pos = diff > 0 and min_pos or max_pos
  local end_pos = diff > 0 and max_pos or min_pos
  local total_dis = _abs(end_pos[2] - start_pos[2])
  if 0 == total_dis then
    return
  end
  local pass_dis = _abs(cur_pos_y - start_pos[2])
  local next_dis = _abs(diff) * dt_time
  local lerp_ratio = (pass_dis + next_dis) / total_dis
  local pos_x = Math.lerp_number(start_pos[1], end_pos[1], lerp_ratio)
  local pos_y = Math.lerp_number(start_pos[2], end_pos[2], lerp_ratio)
  local pos_z = Math.lerp_number(start_pos[3], end_pos[3], lerp_ratio)
  self.v_target_pos = UnityVector3(pos_x, pos_y, pos_z)
  self.v_camera_change_end = false
end

function M:_clamp_rotate_speed(val)
  if SignBoardGirlMgr.TOUCH_ROTATE_SPEED_MAX then
    TOUCH_ROTATE_SPEED_MAX = SignBoardGirlMgr.TOUCH_ROTATE_SPEED_MAX
  end
  if not TOUCH_ROTATE_SPEED_MAX then
    return val
  end
  if val > 0 then
    return val < TOUCH_ROTATE_SPEED_MAX and val or TOUCH_ROTATE_SPEED_MAX
  else
    return val > -TOUCH_ROTATE_SPEED_MAX and val or -TOUCH_ROTATE_SPEED_MAX
  end
end

function M:_check_touch()
  if not (self.v_touch_area and self.v_use_touch) or UIMgr:get_has_tips() then
    return
  end
  if UNITY_EDITOR or UNITY_STANDALONE_WIN then
    local is_in_area = self:check_touch_area(CSInput.mousePosition)
    if is_in_area then
      local diff = CSInput.GetAxis("Mouse ScrollWheel")
      if 0 ~= diff then
        self:_on_pinch(diff * TOUCH_SCALE_SPEED_M)
      end
    end
    if is_in_area and CSInput.GetMouseButtonDown(0) then
      self.v_model_change_end = true
      self.v_touch_cache_x = CSInput.mousePosition.x
    elseif CSInput.GetMouseButton(0) and self.v_touch_cache_x then
      local cur_x = CSInput.mousePosition.x
      local dis = cur_x - self.v_touch_cache_x
      local val = self:_clamp_rotate_speed(dis * TOUCH_ROTATE_SPEED_M)
      Base.change_content_angle_y(self, val)
      self.v_touch_cache_x = cur_x
    elseif CSInput.GetMouseButtonUp(0) then
      self.v_touch_cache_x = nil
    end
  elseif 1 == CSInput.touchCount then
    local touch_1 = CSInput.GetTouch(0)
    local touch_1_pos = touch_1.position
    if not self:check_touch_area(touch_1_pos) then
      self.v_touch_cache_x = nil
      return
    end
    if touch_1.phase == TouchPhase.Began or self.v_touch_cache_x == nil then
      self.v_model_change_end = true
      self.v_touch_cache_x = touch_1_pos.x
      return
    end
    local dis = touch_1_pos.x - self.v_touch_cache_x
    local val = self:_clamp_rotate_speed(dis * TOUCH_ROTATE_SPEED_M)
    Base.change_content_angle_y(self, val)
    self.v_touch_cache_x = touch_1_pos.x
    self.v_is_double_touching = false
  elseif 2 == CSInput.touchCount then
    local touch_1 = CSInput.GetTouch(0)
    local touch_2 = CSInput.GetTouch(1)
    local touch_1_pos = touch_1.position
    local touch_2_pos = touch_2.position
    if touch_2.phase == TouchPhase.Ended then
      self.v_is_double_touching = false
      return
    end
    local is_begin = touch_2.phase == TouchPhase.Began
    if is_begin and self:check_touch_area(touch_1_pos) and self:check_touch_area(touch_2_pos) then
      self.v_is_double_touching = true
    end
    if not self.v_is_double_touching then
      return
    end
    local cur_dis = UnityVector2.Distance(touch_1_pos, touch_2_pos)
    local center_x = (touch_1_pos.x + touch_2_pos.x) / 2
    if not (not is_begin and self.v_touch_cache_cent_x) or not self.v_touch_cache_distance then
      self.v_touch_cache_x = nil
      self.v_touch_cache_cent_x = center_x
      self.v_touch_cache_distance = cur_dis
      return
    end
    local dis = center_x - self.v_touch_cache_cent_x
    Base.change_content_angle_y(self, dis * TOUCH_ROTATE_SPEED)
    self.v_touch_cache_cent_x = center_x
    local diff = cur_dis - self.v_touch_cache_distance
    self:_on_pinch(diff * TOUCH_SCALE_SPEED)
    self.v_touch_cache_distance = cur_dis
  end
end

function M:update_effect_param()
  if not self.v_is_visible then
    return
  end
  local frame, effect_param
  for index, npc in pairs(self.v_npc_loaded_map) do
    effect_param = self.v_effect_param[index]
    if effect_param and npc:get_gameobj_active() and npc.act_ctrl then
      frame = npc.act_ctrl:get_last_frame() or 0
      for key, param in pairs(effect_param) do
        if frame >= param.frame then
          self:play_act_effect(index, param.effect_name, param.attach_point, true)
          effect_param[key] = nil
          if not next(effect_param) then
            self.v_effect_param[index] = nil
          end
        end
      end
    end
  end
end

function M:cache_camera_rotate()
  local rot_x, rot_y, rot_z = self.v_camera_transform:GetLocalEulerAnglesA3()
  self.v_cache_angle = Vec3.New(rot_x, rot_y, rot_z)
end

return M
