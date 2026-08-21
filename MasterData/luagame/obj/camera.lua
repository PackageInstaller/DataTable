local Global = require("global")
local Math = require("base.mathx")
local ease_helper = require("base.ease_helper")
local Layer = require("utils.layer")
local Vec2 = require("base.vec2")
local Vec3 = require("base.vec3")
local Quat = require("base.quat")
local vec3 = require("base.vec3")
local Vec4 = require("base.vec4")
local Transform_State = require("utils.transform_state")
local FightDefine = require("cs_share.fight_define")
local spline_bezier = require("gamelogic.splines.spline_bezier")
local ColorBlack = UnityEngine.Color.black
local MagicDef = require("cs_share.magic_def")
local UnityFind = _ENV.UnityFind
local TypeCamDist = typeof(CS.CameraDistance)
local UnityLineCast = UnityEngine.Physics.Linecast
local CSCameraRayCast = CSHelper.CameraRayCast
local CSGetColliderHeight = CSHelper.GetColliderHeight
local TypeCamera = typeof(UnityEngine.Camera)
local TypeCinemachineVC = typeof(CS.Cinemachine.CinemachineVirtualCamera)
local CSGetOffset = CSHelper.GetOffset
local CSGetShakeOffset = CSHelper.GetShakeOffset
local CSRandomVector3 = CSHelper.GetRandomVector3
local CSScreen = UnityEngine.Screen
local CSInput = UnityEngine.Input
local TypeCameraFocusBlur = typeof(CS.Game.CameraFocusBlur)
local UnityQuat = UnityEngine.Quaternion
local CSShadow = CS.Game.Shadow
local CSMathf = UnityEngine.Mathf
local CSDebug = UnityEngine.Debug
local Color = UnityEngine.Color
local rad2Deg = Math.Rad2Deg
local TypeAttachPoint = typeof(CS.AttachPoint)
local CHARACTER_STATE_TYPE = Config.CHARACTER_STATE_TYPE
local _tinsert = table.insert
local _lerp_angle = Math.lerp_angle
local CSGameMgr = CS.Game.GameMgr
local Timer = Global.timer
local ATTR_TYPE = FightDefine.ATTR_TYPE
local UnityRenderTexture = UnityEngine.RenderTexture
local UnityRawImage = UnityEngine.UI.RawImage
local Diff_val = 40
local SHAKE_VALUE_LUT_INTERVAL = 0.016666666666666666
local _vec3 = Vec3.New(0, 0, 0)
local default_DragParam = {
  0.2,
  0.2,
  -15,
  40,
  15
}
local pinch_damping = 4
local dbm_interval = 2
local NEW_SHAKE_TYPE = {
  [1] = 1,
  [2] = 2,
  [3] = 3
}

local function get_zero_vec3()
  _vec3.x = 0
  _vec3.y = 0
  _vec3.z = 0
  return _vec3
end

local CORD_TYPE = {
  WORLD = 0,
  SELF = 1,
  POS_SELF_AND_RO_WORLD = 2,
  RO_SELF_AND_POS_WORLD = 3,
  RO_SELF_AND_POS_GLOBAL = 4
}
local V_FOCAL_STATE = {
  LOCK_TAR = 1,
  LOCK_HERO = 2,
  AIMED = 3
}
local CAMERA_VIEW_TYPE = {DEPRESSION = 1, SHOULDER = 2}
local OffsetReference = {Global = 1, Local = 2}
local CAMERA_FOCUS_MODE = {TARGET = 1, MIDDLE_OF_TARGET_AND_CHAR = 2}
local default_swipe_init_minus_distance = 20
local default_swipe_rotation_x = 0.26
local default_swipe_rotation_y = 0.09
local default_angle_limit_to_y = 45
local default_pinch_distance = 0.03
local default_min_angle_x = 0
local default_max_angle_x = 40
local default_init_angle_x = 20
local default_min_distance = 1.0
local default_max_distance = 30.0
local default_init_distance = 9
local default_zoom_smoothing = 5
local default_swipe_protect_duration = 0.6
local defaule_target_lerp_val = 0.05
local default_camera_level = 0
local FOCAL_DEFAULT_HEIGHT = 2
local default_fov = 45
local FREE = 0
local LOCK_FORWARD = 1
local LOCK_TARGET = 2
local _abs = math.abs
local _clamp = Math.Clamp
local _inverse_lerp = Math.inverse_lerp
local _lerp = Math.lerp_number
local _floor = math.floor
local _tan = math.tan
local _sin = math.sin
local _cos = math.cos
local _sqrt = math.sqrt
local _max = math.max
local _format = string.format
local _min = math.min
local PI = math.pi
local deg2Rad = Math.Deg2Rad
local SHAKE_TYPE = {
  NORMAL = 1,
  UP = 2,
  DOWN = 3,
  FORWARD = 4,
  BACK = 5,
  LEFT = 6,
  RIGHT = 7,
  ABSUP = 8,
  ABSDOWN = 9
}
local CAMERA_DRAG_TYPE = {
  NONE = 0,
  ROTATION = 1,
  MOVE = 2
}
local CAMERA_MOTION_TYPE = {
  NONE = 0,
  FIRST = 1,
  CACHE_POS = 2,
  CACHE_END_RECOVER = 3,
  CACHE_END = 4
}
local OPERATION = {
  POINT_CLICK = 1,
  LONG_CLICK = 2,
  SWIP = 3
}
local COORDINATETYPE = {
  WORLD = 1,
  CHAR = 2,
  CHAR_DIR = 3,
  CHAR_NOW = 4
}
local PINCH_TYPE = {FREE = 1, GEAR = 2}
local CAMERA_PINCH_SWITCH_TYPE_TO = {
  NONE = 1,
  DEPRESSION = 2,
  SHOULDER = 3
}
local HIT_TAG_TYPE = {
  [PINCH_TYPE.GEAR] = "CameraCollider"
}
local CORRECT_TYPE = {
  NONE = 0,
  DEFAULE = 1,
  ATK = 2,
  MOVE = 3,
  GEAR = 4,
  COLLIDER = 5,
  CHANGE_FOCUS = 6
}
local LONG_CLICK_TIME = 0.3
local STOP_CORRECT_TIME = ShareRes.get_comm_value("StopCorrectTime")
local CHECK_PINCH_TIME = 0.3
local CAMERA_GEAR = {
  DOWN = 1,
  DEF = 2,
  UP = 3
}
local ALPHA_DISTANCE = 1
local ALPHA_STATE = {NONE = 0, ALPHA = 1}
local COLLIDER_DIS = 0.1
local PINCH_SWITCH_CAMERAMODE_DURATION = 5.0
local CAMERA_FOLLOW_TYPE = {
  DEFAULE = 0,
  TARGET_POS = 1,
  KEEP_FOCUS_POS = 2,
  SET_DEFAULT_FOCUS_POS = 3,
  BACK_TO_DEFAULT_FOCUS_POS = 4
}
local SHOULDERMODE_CAMERA_FAR_PLANE = {IN_FIGHT = 200, OUT_FIGHT = 700}
local PINCH_FAIL_MESSAGE = {
  PINCH_IN_FIGHT = 30,
  PINCH_IN_FOCUS = 30,
  PINCH_IN_PENALTY_AREA = 30
}
local CAMERA_PINCH_SWITCH_DIS = 3
local CAMERA_SHOULDER_ID = 1
local DUTCH_EFFECT = require("obj.CameraEffect.CameraDutch")
local FOCUS_EFFECT = require("obj.CameraEffect.CameraFocus")
local AIMED_EFFECT = require("obj.CameraEffect.CameraAimed")
local BLUR_FOCUS_EFFECT = require("obj.CameraEffect.CameraBlurFocus")
local FOCUS_HERO_EFFECT = require("obj.CameraEffect.CameraFocusHero")
local COLLISION_EFFECT = require("obj.CameraEffect.CameraCollision")
local NO_CHANGE_CAMERA = 0
local M = Util.create_class()
local pinch_start_camera_offset = Vec3.New()
local pinch_end_camera_offset = Vec3.New()
local shoulder_camera_default_distance = 3.5
local temp_vec3_00 = Vec3.New()
local temp_vec3_01 = Vec3.New()
local temp_vec3_02 = Vec3.New()
local temp_vec3_03 = Vec3.New()
local temp_vec2_00 = Vec2.New()
local temp_quat_00 = Quat.New()
local temp_quat_01 = Quat.New()

function M:_init(char, camera_obj)
  self.v_camera_obj = camera_obj.gameObject
  self.v_cinemachinebrain = self.v_camera_obj:GetComponent(TypeCinemachineBrain)
  self.v_camera = self.v_camera_obj:GetComponent(TypeCamera)
  self.v_cinimachine_vc = self.v_camera_obj:GetComponentInChildren(TypeCinemachineVC)
  self.clip_dist = self.v_camera_obj:GetComponent(TypeCamDist)
  self.v_camera_transform = self.v_camera_obj.transform
  self.v_defaule_val = _tan(30 * deg2Rad)
  self.v_visible_effect_root = self.v_camera_transform:FindChild("VisibleEffectRoot")
  self.v_effect_root = self.v_camera_transform:FindChild("ChildRoot")
  self.v_effect_root_active = self.v_effect_root.activeSelf
  self.v_effect_root.transform:SetLocalScaleA(1, 1, 1)
  self.v_vcamera = Util.get_child_gameobj("vcamera", self.v_camera_transform)
  self.v_cur_fov = default_fov
  self.v_cinimachine_vc:SetFov(self.v_cur_fov)
  self.v_camera_mode = BattleSettingMgr:get_camera_view_type()
  CSGameMgr.IsOTS = self.v_camera_mode == CAMERA_VIEW_TYPE.SHOULDER
  CSGameMgr.SetCameraObj(self.v_camera_obj)
  self.v_last_target_pos = Vec3.New()
  if not Util.is_destroy(char) then
    self.v_char = char
    local bind_target = char:get_camera_focal_transform()
    self.v_last_target_pos:Set(bind_target:GetPositionA())
    self.v_char_init_euler_y = self.v_char:get_enter_point_dir()
    self.attach_point = char.transform:GetComponent(TypeAttachPoint)
  end
  self.is_active = true
  self:reset_params()
  self.v_target_distance = self.v_init_distance
  self.v_collide_dis = self.v_target_distance
  self.v_cur_distance = self.v_target_distance
  self.v_on_magic_ctrl = false
  self.v_update_count = 0
  self.v_target_offset = Vec3.New()
  self.v_current_offset = Vec3.Clone(self.v_target_offset)
  self.v_pinch_limit_min = ShareRes.get_comm_value("PinchLimitMin")
  self.v_pinch_limit_max = ShareRes.get_comm_value("PinchLimitMax")
  self.v_d2s_pinch_distance = ShareRes.get_comm_value("DToSPinchDistance")
  self.v_s2d_pinch_distance = ShareRes.get_comm_value("SToDPinchDistance")
  self.v_ots_shake_scale_x = ShareRes.get_comm_value("OTSShakeScalePositionX")
  self.v_ots_shake_scale_y = ShareRes.get_comm_value("OTSShakeScalePositionY")
  self.v_ots_shake_scale_z = ShareRes.get_comm_value("OTSShakeScalePositionZ")
  self.v_cache_move_pos = Vec2.New(0, 0)
  self.v_target_euler = Vec2.New(45, 0)
  self.v_swipe_minus_distance = self.v_swipe_init_minus_distance
  self.v_add_camera_pos_y = 0
  self:_create_focal_point()
  self:_clamp_euler(self.v_target_euler)
  self.v_cur_quat = Quat.Euler(self.v_target_euler.x, self.v_target_euler.y, 0)
  self.v_magic_pos_prop = -1
  self.v_magic_trans_prop = -1
  self.v_magic_vcam = {
    start_quat = nil,
    quat = Quat.Euler(0, 0, 0),
    tar_quat = Quat.Euler(0, 0, 0),
    start_pos = Vec3.New(),
    start_offset = Vec3.New(),
    offset = Vec3.New(),
    tar_pos = Vec3.New(),
    tar_offset = Vec3.New(),
    follow_tar = true,
    ease_in = 0,
    duration = 0,
    ease_out = 0,
    elapsed = 0,
    remove_correction = false
  }
  self.v_old_shake_data_stack = {}
  self.v_new_shake_data_stack = {}
  self.v_scene_cam_prop = -1
  self.v_ease_in_speed = 1
  self.v_cameraSpeed_on_characterMove = 1
  self.v_camera_pos_offset_y = 0
  self.v_camera_lookpoint_offset_y = 0
  self.v_camera_lookpoint_offset_y_map = {}
  self.v_focusing_pos = Vec3.New()
  self.v_camera_focusing_pos = Vec3.New()
  self.v_camera_focusing_ort = Quat.New()
  self.v_shake_pos = Vec3.New()
  self.v_shake_rot = Vec3.New()
  self.v_raw_shake_offset = Vec3.New()
  self.v_shakes = {}
  self.v_camera_pos_before_enter_timeline = Vec3.New()
  self.v_camera_rot_before_enter_timeline = Quat.New()
  self.v_pinch_end_flag = true
  self.v_dbm_timestamp = math.mininteger
  self.v_temp_focal_pos_vec3 = Vec3.New()
  self.v_temp_camera_pos_vec3 = Vec3.New()
  self.v_move_correct_Lerp_y = 2
  self:_apply_rotation_and_distance()
  self.v_allow_rotation = false
  self.v_allow_zoom = false
  self.v_shoulder_mode_camera_focal_point_offset_y = ShareRes.get_comm_value("ShoulderModeCameraFocalPointOffsetY")
  self:set_lerp_target(true, ShareRes.get_comm_value("SceneCamSpeedLimit"))
  if UNITY_EDITOR then
    self.v_data_component = self.v_camera_obj:GetComponent(typeof(CS.Game.GameCameraData))
  end
  self.v_correct_time = 0
  self.v_shoulder_mode_focusing_duration = ShareRes.get_comm_value("ShoulderModeCameraFocusDuration")
  self.v_last_camera_info = {}
  local camera_id = DebugSetting:get_camera_id()
  if Util.is_client_only() then
    local default_camera_id = ShareRes.get_comm_value("ClientOnlyCameraId")
    default_camera_id = default_camera_id or 0
    camera_id = 0 ~= camera_id and camera_id or default_camera_id
    self:set_scene_camera(camera_id)
    self:set_cam_pinch_switch(true)
  end
  self.v_vcamera_pos = Vec3.New(0, 0, 0)
  self.v_magic_camera_pos = Vec3.New(0, 0, 0)
  self.v_camera_rotate = Vec3.New(0, 0, 0)
  self.v_joystick_pos = Vec3.New(0, 0, 0)
  local camera_cfg = ShareRes.get_camera_cfg(CAMERA_SHOULDER_ID, false)
  shoulder_camera_default_distance = camera_cfg.DefaultDistance
  self:init_camera_effect_lua()
  self:init_camera_info()
  self:set_active(true)
  Util.bind_msg(self, Const.MSG_SCENE_LEAVE, self.msg_on_leave_scene, self)
  self.v_default_texture_path = Config.DEFAULT_CAMERA_TEXTURE
  self:check_change_switch_sp_bg_on_init()
  self:set_ui_rt()
  self.v_camera_enable = 0 ~= self.v_camera.cullingMask
  self:reset_shadoe_camara_enable()
  Util.bind_msg(self, Const.MSG_RESOLUTION_CHANGE, self.set_ui_rt, self)
  local is_low_memory_device = Global.render_mgr:is_low_memory_device()
  local streaming_controller = self.v_camera_obj:GetComponent(typeof(UnityEngine.StreamingController))
  if is_low_memory_device then
    streaming_controller.enabled = true
  else
    streaming_controller.enabled = false
  end
end

function M:set_ui_rt(msg)
  if not Global.disable_custom_resolve_camera then
    UIMgr:set_game_raw_img_active(true)
    return
  end
  if self.v_rt_img then
    self:release_ui_rt()
  end
  local crc = self.v_camera_obj:GetComponent(typeof(CS.CustomResolveCamera))
  crc.enabled = false
  local resolution_height = msg and msg.mm_x or BattleSettingMgr:get_resolution()
  local screen_width, screen_height = UnityEngine.Screen.width, UnityEngine.Screen.height
  local height = math.min(screen_height, resolution_height)
  local org_down_rate = screen_height / height
  local width = _floor(screen_width / org_down_rate)
  self.v_rt_img = CompExtensions.GetUIRT(width, height, "CameraRawRT")
  local raw_img = UIMgr:get_game_raw_img()
  UIMgr:set_game_raw_img_active(true)
  raw_img.texture = self.v_rt_img
  self.v_camera.targetTexture = self.v_rt_img
end

function M:msg_on_leave_scene()
  self:clean_change_follow_target_data()
end

function M:on_destroy()
  self.v_light_info = nil
  self.v_effect_root_active = nil
  self.v_default_texture_path = nil
  if self.v_focal_point.gameObject and not self.v_focal_point.gameObject:IsNull() then
    UnityDestroy(self.v_focal_point.gameObject)
    self.v_focal_point = nil
  end
  self:release_effect()
  self:release_ui_rt()
  self:remove_role_effect_on_destroy()
  Util.unbind_all_msg(self)
  Global.render_mgr:on_destroy_camera()
end

function M:release_ui_rt()
  UIMgr:set_game_raw_img_active(false)
  do return end
  UIMgr:set_game_raw_img_active(false)
  self.v_camera.targetTexture = nil
  if self.v_rt_img then
    UnityRenderTexture.ReleaseTemporary(self.v_rt_img)
    self.v_rt_img = nil
  end
end

function M:camera_activated_event(incoming_camera, outgoing_camera)
  if incoming_camera and outgoing_camera then
    if incoming_camera.gameObject.name == "VirtualCamera" and outgoing_camera.gameObject.name == "vcamera" then
      if self.v_camera_mode == CAMERA_VIEW_TYPE.SHOULDER then
        self.v_camera_pos_before_enter_timeline:Set(outgoing_camera.transform:GetPositionA())
        self.v_camera_rot_before_enter_timeline:Set(outgoing_camera.transform:GetRotationA())
      end
    elseif incoming_camera.gameObject.name == "vcamera" and outgoing_camera.gameObject.name == "VirtualCamera" then
      if self.v_camera_mode == CAMERA_VIEW_TYPE.SHOULDER then
        self.v_blend_begin_time = GlobalTimeMgr:get_time()
        if self.v_blend_cut_flag then
          self.v_timeduration_default = 0
          self:release_camera_blend_flag()
        else
          self.v_timeduration_default = Cinemachine:get_settings().m_CustomBlends[1].m_Blend.m_Time
        end
        self.v_should_blend_by_ourself = true
        self.v_lerp_camera_pos_end = false
        self.v_cur_distance = shoulder_camera_default_distance
        self.v_target_distance = shoulder_camera_default_distance
      elseif self.v_camera_mode == CAMERA_VIEW_TYPE.DEPRESSION and BattleSettingMgr:get_depression_mode_rotate() == Config.SETTING.CAMERA_DEPRESSION_MODE_ROTATE.ON then
        self.v_target_euler.y = outgoing_camera.transform:GetEulerY()
        self.v_cur_quat:SetEuler(self.v_target_euler.x, self.v_target_euler.y, 0)
      end
    end
  end
end

function M:set_scene_camera(camera_id, is_setting, is_api, not_clear_data, is_new_config, is_force_switch_cameramode, forbid_camera_blend, gm_or_editor)
  if camera_id == NO_CHANGE_CAMERA and not is_new_config then
    return
  end
  if not gm_or_editor and self.v_camera_cfg_id and self.v_camera_cfg_id == camera_id then
    return
  end
  self.v_is_first_person_camera = false
  local now_camera_id
  local last_camera_mode = self.v_camera_mode
  if is_force_switch_cameramode then
    self.v_lock_camera_mode = is_force_switch_cameramode
    local camera_cfg = ShareRes.get_camera_cfg(camera_id, is_new_config)
    if 3 == camera_cfg.CameraViewType then
      self.v_camera_mode = CAMERA_VIEW_TYPE.DEPRESSION
      self.v_is_first_person_camera = true
    elseif not Util.is_client_only() and self.v_cur_room.room_cfg.IsBanShoulderCamera then
      self.v_camera_mode = CAMERA_VIEW_TYPE.DEPRESSION
    elseif 2 == camera_cfg.CameraViewType then
      self.v_camera_mode = CAMERA_VIEW_TYPE.SHOULDER
    elseif 1 == camera_cfg.CameraViewType then
      self.v_camera_mode = CAMERA_VIEW_TYPE.DEPRESSION
    end
  else
    self:set_cameramode_by_camera_id(camera_id, is_new_config)
  end
  CSGameMgr.IsOTS = self.v_camera_mode == CAMERA_VIEW_TYPE.SHOULDER
  if last_camera_mode == CAMERA_VIEW_TYPE.DEPRESSION and self.v_camera_mode == CAMERA_VIEW_TYPE.SHOULDER then
    self:clean_change_follow_target_data()
  end
  if not is_setting then
    self.v_last_camera_id = camera_id
  end
  if self.v_camera_mode == CAMERA_VIEW_TYPE.SHOULDER then
    if is_force_switch_cameramode then
      now_camera_id = camera_id
    else
      now_camera_id = CAMERA_SHOULDER_ID
    end
    if self.v_camera_cfg_id == now_camera_id then
      return
    end
  else
    now_camera_id = camera_id
  end
  if not Util.is_client_only() and not is_api then
    local custom_camera_view = BattleSettingMgr:get_custom_camera_view()
    if custom_camera_view == Config.SETTING.CUSTOM_CAMERA_VIEW.DEPRESSION_ANGLE then
      now_camera_id = Config.CAMERA_VIEW_TYPE_ID.SIDEPRESON_ANGLE
    elseif custom_camera_view == Config.SETTING.CUSTOM_CAMERA_VIEW.SHOULDER_ANGLE then
      now_camera_id = Config.CAMERA_VIEW_TYPE_ID.SHOULDER_ANGLE
    else
      now_camera_id = self.v_last_camera_id
    end
  end
  self.v_scene_camera_id = now_camera_id
  self.v_scene_camera_is_new_config = is_new_config
  if now_camera_id == self.v_camera_cfg_id and not is_api then
    return
  end
  if is_api and not not_clear_data then
    self.v_pinch_val = nil
    self.v_last_camera_info = {}
  end
  self:stop_distance_correct()
  self.v_is_new_config = is_new_config
  self.v_camera_cfg_id = now_camera_id
  self.v_lerp_fov_start = self.v_cur_fov
  self:init_camera_info(forbid_camera_blend)
end

function M:clean_last_camera_data()
  self.v_target_val = nil
  self.v_target_height = nil
end

function M:set_cameramode_by_camera_id(camera_id, is_new_config)
  local camera_cfg = ShareRes.get_camera_cfg(camera_id, is_new_config)
  if not Util.is_client_only() and self.v_cur_room.room_cfg.IsBanShoulderCamera then
    self.v_camera_mode = CAMERA_VIEW_TYPE.DEPRESSION
  elseif 2 == camera_cfg.CameraViewType then
    self.v_camera_mode = CAMERA_VIEW_TYPE.SHOULDER
  elseif 1 == camera_cfg.CameraViewType and not self.v_has_pinch_switch_cameramode then
    self.v_camera_mode = BattleSettingMgr:get_camera_view_type()
  end
  CSGameMgr.IsOTS = self.v_camera_mode == CAMERA_VIEW_TYPE.SHOULDER
end

function M:init_camera_info(forbid_camera_blend, on_pre_set_camera_cfg)
  if not self.v_camera_cfg_id then
    return
  end
  self:clean_last_camera_data()
  self.v_last_camera_info[self.v_camera_cfg_id] = self.v_last_camera_info[self.v_camera_cfg_id] or {}
  local last_camera_info = self.v_last_camera_info[self.v_camera_cfg_id]
  if self.v_camera_mode == CAMERA_VIEW_TYPE.SHOULDER then
    self.v_is_new_config = false
  end
  local camera_cfg
  if on_pre_set_camera_cfg then
    camera_cfg = UtilTable.copy_table(ShareRes.get_camera_cfg(self.v_camera_cfg_id, self.v_is_new_config))
    assert(camera_cfg, "No CameraId" .. self.v_camera_cfg_id)
    on_pre_set_camera_cfg(camera_cfg)
  else
    camera_cfg = ShareRes.get_camera_cfg(self.v_camera_cfg_id, self.v_is_new_config)
    assert(camera_cfg, "No CameraId" .. self.v_camera_cfg_id)
  end
  self.v_target_euler.x = 45
  self.v_target_euler.y = 0
  self.v_camera_cfg = camera_cfg
  local camera_height = camera_cfg.DefaultHeight or 0
  self.v_camera_height = last_camera_info and last_camera_info.camera_height or camera_height
  local camera_defaul_angle_x = camera_cfg.DefaultXAngle or 0
  local camera_defaul_angle_y = camera_cfg.DefaultYAngle or 0
  local msg = MsgGame:mq_publish2(Const.MSG_ON_CHANGE_CAMERA_ANGLE)
  msg.mm_x = camera_defaul_angle_y
  local camera_defaul_pos_z = camera_cfg.DefaultZPOs or 0
  local defaule_pos_y = camera_cfg.DefaultYPOs or 0
  self.v_target_offset.x = camera_cfg.DefaultXPOs or 0
  self.v_target_offset.y = defaule_pos_y
  self.v_target_offset.z = camera_defaul_pos_z
  if not self.v_need_lerp_fov then
    self.v_cur_fov = camera_cfg.DefalutFOV
    self.v_cinimachine_vc:SetFov(self.v_cur_fov)
  end
  default_fov = camera_cfg.DefalutFOV
  self.v_target_distance = last_camera_info and last_camera_info.camera_distance or camera_cfg.DefaultDistance
  local asin_val = _clamp(self.v_camera_height / self.v_target_distance, -1, 1)
  local target_euler = Vec3.New()
  target_euler.x = self.v_target_euler.x
  target_euler.y = self.v_target_euler.y
  target_euler.x = math.asin(asin_val) * rad2Deg
  target_euler.x = target_euler.x + camera_defaul_angle_x
  self:update_cache_camera_info(self.v_camera_height, self.v_target_distance)
  local distance_limit = camera_cfg.DefaultCorrectVal
  self.v_pinch_distance = distance_limit[1]
  self.v_min_distance = distance_limit[2]
  self.v_max_distance = distance_limit[3]
  local atk_correct_list = camera_cfg.AtkCorrectVal
  if atk_correct_list then
    self.v_atk_default_distacne = atk_correct_list[1]
    self.v_atk_correct_val = atk_correct_list[2]
    self.v_atk_correct_min_val = atk_correct_list[3]
    self.v_atk_correct_time = atk_correct_list[4]
  end
  self.v_move_correct_val = camera_cfg.MoveCorrectVal
  self.v_camera_shake_type = camera_cfg.CameraShakeType or 1
  self.v_gear_distance_max_val = camera_cfg.GearCameraVal and camera_cfg.GearCameraVal[1] or nil
  self.v_gear_height_max_val = camera_cfg.GearCameraVal and camera_cfg.GearCameraVal[2] or nil
  self.v_gear_distance_min_val = camera_cfg.GearCameraVal and camera_cfg.GearCameraVal[3] or nil
  self.v_gear_height_min_val = camera_cfg.GearCameraVal and camera_cfg.GearCameraVal[4] or nil
  self.v_camera_gear = CAMERA_GEAR.DEF
  self.v_battle_cam_dist_limit_max = camera_cfg.BattleCamDistLimit[1] and camera_cfg.BattleCamDistLimit[1] or 0
  self.v_battle_cam_dist_limit_min = camera_cfg.BattleCamDistLimit[2] and camera_cfg.BattleCamDistLimit[2] or 0
  self.v_battle_cam_height_limit_max = camera_cfg.BattleCamDistLimit[3] and camera_cfg.BattleCamDistLimit[3] or 0
  self.v_battle_cam_height_limit_min = camera_cfg.BattleCamDistLimit[4] and camera_cfg.BattleCamDistLimit[4] or 0
  if camera_cfg.CoordinateType == COORDINATETYPE.WORLD then
    target_euler.y = target_euler.y + camera_defaul_angle_y
  elseif camera_cfg.CoordinateType == COORDINATETYPE.CHAR then
    target_euler.y = self.v_char_init_euler_y + camera_defaul_angle_y
  elseif camera_cfg.CoordinateType == COORDINATETYPE.CHAR_DIR then
    target_euler.y = self.v_char_init_euler_y
  elseif camera_cfg.CoordinateType == COORDINATETYPE.CHAR_NOW then
    target_euler.y = self.v_char:get_dir() + camera_defaul_angle_y
  end
  self.v_target_euler.x = target_euler.x
  self.v_target_euler.y = target_euler.y
  self:_clamp_euler(self.v_target_euler)
  self.v_cur_quat = Quat.Euler(self.v_target_euler.x, self.v_target_euler.y, 0)
  if not camera_cfg.SetCameraDuration or 0 == camera_cfg.SetCameraDuration then
    self.v_target_distance = camera_cfg.DefaultDistance
    self.v_cur_distance = self.v_target_distance
    self:set_nolerp_target_trigger()
  end
  if camera_cfg.OffsetReference == OffsetReference.Local then
    self.v_focal_point:SetEulerY(self.v_target_euler.y)
  end
  if self.v_enter_scene_dir then
    self:init_scene_camera_euler_y(self.v_enter_scene_dir)
  end
  if not forbid_camera_blend then
    self.v_temp_focal_pos = nil
    self.v_temp_camera_pos = nil
  end
  self.v_lerp_camera_pos_end = forbid_camera_blend
  self.v_lerp_camera_passed_time = 0
  self:set_lerp_target(true, camera_cfg.CamSpeedLimit)
  if camera_cfg.CameraPinchType == PINCH_TYPE.GEAR then
    self.v_correct_state = CORRECT_TYPE.GEAR
    self:switch_camera_gear(false, true)
  end
  MsgGame:mq_publish2(Const.MSG_ON_CHANGE_CAMERA)
  self:reset_attach_point(Global.hero)
  self.v_move_correct_Lerp_y = self.v_camera_cfg.MoveCorrectYLerp or 2
  if self.v_follow_target_param then
    local default_distance = self.v_camera_cfg.DefaultDistance
    local max_add_val = _min(self.v_follow_target_param[2], self.v_gear_distance_max_val - default_distance)
    local add_val = _floor(max_add_val / self.v_follow_target_param[5])
    self.v_char_to_focal_max_distance = (self.v_follow_target_param[1] + add_val * self.v_follow_target_param[4]) / 2
  end
  self:init_camera_effect_lua_cfg()
end

function M:start_target_offset(offset)
  if self.v_camera_mode == CAMERA_VIEW_TYPE.SHOULDER then
    return
  end
  self.v_target_offset_reset = self.v_target_offset_reset or Vec3.Clone(self.v_target_offset)
  self.v_target_offset.x = offset.x
  self.v_target_offset.y = offset.y
  self.v_target_offset.z = offset.z
end

function M:stop_target_offset()
  if self.v_camera_mode == CAMERA_VIEW_TYPE.SHOULDER then
    return
  end
  if self.v_target_offset_reset then
    self.v_target_offset.x = self.v_current_offset.x
    self.v_target_offset.y = self.v_current_offset.y
    self.v_target_offset.z = self.v_current_offset.z
  end
end

function M:reset_target_offset(dispose)
  if self.v_camera_mode == CAMERA_VIEW_TYPE.SHOULDER then
    return
  end
  if self.v_target_offset_reset then
    self.v_target_offset.x = self.v_target_offset_reset.x
    self.v_target_offset.y = self.v_target_offset_reset.y
    self.v_target_offset.z = self.v_target_offset_reset.z
  end
  if dispose then
    self.v_target_offset_reset = nil
  end
end

function M:init_camera_effect_lua()
  self.v_dutch_effect = DUTCH_EFFECT:new(self)
  self.v_focus_effect = FOCUS_EFFECT:new(self)
  self.v_aimed_effect = AIMED_EFFECT:new(self)
  self.v_blur_focus_effect = BLUR_FOCUS_EFFECT:new(self)
  self.v_focus_hero_effect = FOCUS_HERO_EFFECT:new(self)
  self.v_collision_effect = COLLISION_EFFECT:new(self)
end

function M:init_camera_effect_lua_cfg()
  if self.v_focus_effect then
    self.v_focus_effect:init_camera_cfg(self.v_camera_cfg)
  end
  if self.v_aimed_effect then
    self.v_aimed_effect:init_camera_cfg(self.v_camera_cfg)
  end
  if self.v_focus_hero_effect then
    self.v_focus_hero_effect:init_camera_cfg(self.v_camera_cfg)
  end
  if self.v_collision_effect then
    self.v_collision_effect:init_camera_cfg(self.v_camera_cfg)
  end
end

function M:init_scene_camera_euler_y(char_dir)
  if not self.v_camera_cfg then
    self.v_enter_scene_dir = char_dir
    return
  end
  if self.v_camera_cfg.CoordinateType ~= COORDINATETYPE.CHAR then
    return
  end
  if self.is_set_euler then
    return
  end
  self.v_char_init_euler_y = char_dir
  self.v_target_euler.y = char_dir
  self:_clamp_euler(self.v_target_euler)
  self.v_cur_quat = Quat.Euler(self.v_target_euler.x, self.v_target_euler.y, 0)
  self.is_set_euler = true
  self.v_enter_scene_dir = nil
end

function M:stop_follow_tar()
  self.v_stop_frame = nil
  self.v_stop_follow_tar = true
end

function M:set_target(tar)
  if not tar then
    return
  end
  if not self.v_char then
    self.v_char_init_euler_y = tar:get_enter_point_dir()
    local bind_target = tar:get_camera_focal_transform()
    self.v_last_target_pos:Set(bind_target:GetPositionA())
  end
  self.v_char = tar
end

function M:reset_attach_point(hero)
  if not hero:can_update() then
    return
  end
  self.attach_point = hero.transform:GetComponent(TypeAttachPoint)
  self.v_attach_point_transform = self.attach_point:GetPoint("Bip001 Chest")
  local _, position_y, _ = self.v_attach_point_transform:GetPositionA()
  self.v_camera_pos_offset_y = position_y - hero:get_pos_vec3().y + 1
  self.v_camera_pos_destination_offset_y = self.v_camera_pos_offset_y
  if self.v_camera_lookpoint_offset_y_map[hero.id] then
    self.v_camera_lookpoint_offset_y = self.v_camera_lookpoint_offset_y_map[hero.id] + self.v_shoulder_mode_camera_focal_point_offset_y
  else
    self.v_camera_lookpoint_offset_y_map[hero.id] = position_y - hero:get_pos_vec3().y
    self.v_camera_lookpoint_offset_y = self.v_camera_lookpoint_offset_y_map[hero.id] + self.v_shoulder_mode_camera_focal_point_offset_y
  end
end

function M:get_attach_point_transform()
  return self.v_attach_point_transform
end

function M:try_enter_scene()
  self.is_set_euler = false
  self:clear_scene_data()
  self:clear_room_data()
  if SceneMgr:check_main_scene() then
    self:set_active(false)
  end
end

function M:clear_scene_data()
  self.v_char = nil
end

function M:clear_room_data()
  self.v_focus_pos = nil
  self.v_lerp_camera_pos_end = true
  if self.v_focus_hero_effect then
    self.v_focus_hero_effect:clear_data()
  end
  self:set_focus_hero_lerp_state(true, true)
  self.v_focal_state = nil
  self.v_magic_effect = false
  self.v_magic_pos_prop = -1
  self.v_magic_trans_prop = -1
end

function M:set_nolerp_target_trigger()
  self.v_target_nolerp_trigger = true
end

function M:set_lerp_target(need_lerp, lerp_speed)
  self.v_target_lerp = need_lerp
  self.v_lerp_speed = lerp_speed
end

function M:on_scene_load(msg)
  local obj = UnityFind("SceneEffect")
  local info = obj:GetComponent(typeof(CS.SceneIllumination))
  self.v_light_info = info.IlluminationInfo
  if self.v_cam_effect and not self.v_cam_effect:IsNull() then
    ResMgr:destroy_gameobj(self.v_cam_effect)
  end
  if self.v_light_info then
    CS.SceneIlluminationInfo.Apply(self.v_light_info)
    local cam_fx_path = self.v_light_info.SceneCamFx
    if not Util.is_empty(cam_fx_path) then
      local cam_effect = ResMgr:load_gameobj(Path.get_res_path(cam_fx_path), nil, true)
      cam_effect.transform:SetParent(self.v_camera_transform, false)
      cam_effect.transform:ResetAttr()
      self.v_cam_effect = cam_effect
    end
  end
end

function M:set_active(is_active)
  self.v_last_alpha_state = nil
  self.v_camera_obj:SetActive(is_active)
  if not is_active then
    self.v_pinch_val = nil
  end
  if not self.is_active and is_active then
    Util.bind_msg(self, Const.MSG_SCENE_LOAD, self.on_scene_load, self)
    CSGameMgr.SetCameraObj(self.v_camera_obj)
  end
  Util.bind_msg(self, Const.MSG_REMOVE_MAGIC, self.remove_magic, self)
  self.is_active = is_active
  if not is_active then
    self.v_magic_fov = false
    Global.camera:stop_pos_rotation_offset()
  end
end

function M:on_enter_room(room)
  if not self.is_active then
    return
  end
  local char_dir = Global.hero:get_dir()
  self.v_target_euler.y = char_dir
  self:_clamp_euler(self.v_target_euler)
  self.v_char_init_euler_y = char_dir
  self.v_cur_quat = Quat.Euler(self.v_target_euler.x, self.v_target_euler.y, 0)
  self.v_enter_scene_dir = nil
  self.v_cur_room = room
  self:clean_change_follow_target_data()
  self.v_is_camera_focusing_in_shoulder_mode = false
  CSGameMgr.SetCameraObj(self.v_camera_obj)
end

function M:set_camera_compent_enable(is_enable)
  local cullingMask = self.v_camera.cullingMask
  if is_enable then
    if 0 ~= cullingMask then
      return
    end
    self.v_camera.cullingMask = self.v_original_culling_mask or cullingMask
    self.v_original_culling_mask = nil
  else
    if 0 == cullingMask then
      return
    end
    self.v_original_culling_mask = cullingMask
    self.v_camera.cullingMask = 0
    self.v_camera.backgroundColor = ColorBlack
  end
  self.v_camera_enable = is_enable
end

function M:adjust_culling_mask(layer_name, enable)
  local bit = Layer.LayerMask[layer_name]
  self.v_camera.cullingMask = enable and self.v_camera.cullingMask | bit or self.v_camera.cullingMask & ~bit
end

local mesh_layer = {
  "Terrain",
  "SceneObjNear",
  "SceneObjMiddle",
  "SceneObjFarAway",
  "SceneBlock",
  "WalkBlock",
  "DepthCaster"
}

function M:adjust_all_mesh_culling_mask(enable)
  if self.v_original_culling_mask then
    for _, layer_name in ipairs(mesh_layer) do
      local bit = Layer.LayerMask[layer_name]
      self.v_original_culling_mask = enable and self.v_original_culling_mask | bit or self.v_original_culling_mask & ~bit
    end
  else
    for _, layer_name in ipairs(mesh_layer) do
      self:adjust_culling_mask(layer_name, enable)
    end
  end
  local all_functional_npcs = SceneMgr:get_all_functional_npc()
  for uuid, npc in pairs(all_functional_npcs) do
    npc:set_enable(enable)
  end
  CSHelper.ShowOrHideGrassRender(not enable)
end

function M:set_enable_camera(is_enable)
  if is_enable then
    UIMgr:revert_game_raw_img_active()
  else
    UIMgr:force_close_game_raw_img()
  end
  self:set_camera_compent_enable(is_enable)
  self:reset_shadoe_camara_enable()
end

function M:reset_shadoe_camara_enable()
  local shadow_camera = CSShadow.ShadowCamera
  if shadow_camera then
    shadow_camera:SetActive(self.v_camera_enable and BattleSettingMgr:is_enable_shadow_camera())
  end
end

function M:release_effect()
  if self.v_dutch_effect then
    self.v_dutch_effect:on_release()
    self.v_dutch_effect = nil
  end
  if self.v_focus_effect then
    self.v_focus_effect:on_release()
    self.v_focus_effect = nil
  end
  if self.v_aimed_effect then
    self.v_aimed_effect:on_release()
    self.v_aimed_effect = nil
  end
  if self.v_blur_focus_effect then
    self.v_blur_focus_effect:on_release()
    self.v_blur_focus_effect = nil
  end
  if self.v_focus_hero_effect then
    self.v_focus_hero_effect:on_release()
    self.v_focus_hero_effect = nil
  end
end

function M:late_update()
  if not self.is_active then
    return
  end
  if self.v_camera_mode == CAMERA_VIEW_TYPE.SHOULDER then
    self.v_cinemachinebrain:InverseVCNoiseOriCorrection(self.v_cinimachine_vc)
  end
  self:check_switch_fight_camera()
  local hit_distance = self:check_camera_hit()
  local is_hit = self.v_camera_cfg and self.v_camera_cfg.CameraPinchType == PINCH_TYPE.GEAR and hit_distance > 0
  self:_follow_target(is_hit)
  if self:_can_update_rotate() then
    self:_update_rotation()
  end
  self:check_camera_collider(hit_distance)
  if SceneMgr:can_update() then
    self:_update_shake()
  end
  self:check_pinch_time()
  if Global.hero and Global.hero:is_in_state(CHARACTER_STATE_TYPE.MOVE) then
    if self.v_camera_mode == CAMERA_VIEW_TYPE.DEPRESSION then
      self:move_correct_distance()
    end
  elseif self.v_correct_state == CORRECT_TYPE.MOVE then
    self.v_correct_state = CORRECT_TYPE.NONE
  end
  if self.v_camera_mode == CAMERA_VIEW_TYPE.SHOULDER then
    self:move_correct_distance_on_shouldermode()
  end
  local is_collider = self:_update_distance()
  self:_update_magic_vcam()
  self:update_lerp_camera_fov()
  self:simple_lerp_fov()
  self:_apply_rotation_and_distance(is_collider)
  self:face_npc()
  self:check_click_time()
  self:correct_camera_distance()
  self:check_trackparent_camera()
  self:buddy_alpha()
  self:camera_aimed_follow_hero()
  if self.v_dutch_effect then
    self.v_dutch_effect:late_update()
  end
  self.v_update_count = 1
  if self.v_stop_frame then
    self.v_stop_follow_tar = false
  end
  if self.v_stop_follow_tar then
    self.v_stop_frame = true
  end
end

local v_camera_pos = Vec3.New()

function M:buddy_alpha()
  if not Global.hero then
    return
  end
  v_camera_pos.x, v_camera_pos.y, v_camera_pos.z = self.v_camera_transform:GetPositionA()
  local hero_pos = Global.hero:get_pos_vec3()
  local distance = Vec3.Distance(v_camera_pos, hero_pos)
  local state = distance <= ALPHA_DISTANCE and ALPHA_STATE.ALPHA or ALPHA_STATE.NONE
  if state == self.v_last_alpha_state then
    return
  end
  self.v_last_alpha_state = state
  Global.hero:check_transparent(state == ALPHA_STATE.ALPHA)
end

function M:check_trackparent_camera()
  local ct_info = Cinemachine:get_ct_info()
  if not ct_info then
    if self.v_track_hit_obj then
      for _, lua_obj in pairs(self.v_track_hit_obj) do
        lua_obj:check_transparent()
      end
      self.v_track_hit_obj = nil
    end
    return
  end
  Util.VEC3_TEMP_1:Set(ct_info.transform:GetPositionA())
  local hero_pos = Global.hero:get_pos_vec3()
  Util.VEC3_TEMP:Set(hero_pos:Get())
  Util.VEC3_TEMP:Sub(Util.VEC3_TEMP_1)
  Util.VEC3_TEMP:SetNormalize()
  local dir_x, dir_y, dir_z = Util.VEC3_TEMP:Get()
  local origin_x, origin_y, origin_z = Util.VEC3_TEMP_1:Get()
  local distance = Vec3.Distance(Util.VEC3_TEMP_1, hero_pos)
  local suc, hit_num = CSHelper.RaycastNonAlloc2(origin_x, origin_y, origin_z, dir_x, dir_y, dir_z, distance, Layer.LayerMask.NPC)
  if suc then
    self.v_track_hit_obj = self.v_track_hit_obj or {}
    local hit_info = CSHelper.HitInstanceIDTemp
    for i = 0, hit_num - 1 do
      local instance_id = hit_info[i]
      if not self.v_track_hit_obj[instance_id] then
        local lua_obj = SceneMgr:pick_by_cid(instance_id)
        if lua_obj then
          lua_obj:check_transparent(true)
          self.v_track_hit_obj[instance_id] = lua_obj
        end
      end
    end
  end
end

function M:check_pinch_time()
  if self.v_check_pinch_time and self.v_check_pinch_time > 0 then
    self.v_check_pinch_time = self.v_check_pinch_time - Config.LOGIC_FRAME
    if self.v_check_pinch_time <= 0 then
      self.v_check_pinch_time = 0
      if self.v_is_pinch then
        self.v_stop_correct_time = STOP_CORRECT_TIME
        self.v_is_pinch = false
      end
    end
  end
end

local WAVEFORM = {SINEWAVE = 1, CUSTOMWAVE = 2}

function M:get_time_envelope_factor(time_envelope, new_decay, duration)
  if duration < time_envelope.attack then
    return 1 - ease_helper.Damp(duration / time_envelope.attack)
  end
  duration = duration - time_envelope.attack
  if duration < time_envelope.sustain then
    return 1
  end
  duration = duration - time_envelope.sustain
  return ease_helper.Damp(duration / new_decay)
end

function M:evaluate_wave_data(wave_data, duration, total_duration)
  if wave_data.waveform == WAVEFORM.SINEWAVE then
    return wave_data.amplitude * math.sin(2 * math.pi * wave_data.frequency / total_duration * duration)
  elseif wave_data.waveform == WAVEFORM.CUSTOMWAVE then
    local curve_value_lut = ShareRes.get_shake_curve_value_lut(wave_data.curveName)
    local q, r = math.modf(duration / total_duration / SHAKE_VALUE_LUT_INTERVAL)
    local index = q + 1
    index = Math.Clamp(index, 1, 59)
    local value_start = curve_value_lut[index]
    local value_end = curve_value_lut[index + 1]
    local value = Math.lerp_number(value_start, value_end, r)
    return value
  end
end

local shake_pos = Vec3.New()
local shake_rot = Vec3.New()
local offset = Vec3.New()
local rot_offset = Vec3.New()
local BLEND_DURATION = 0.1

function M:_update_shake()
  shake_pos:Set(0, 0, 0)
  shake_rot:Set(0, 0, 0)
  local npc_map = SceneMgr:get_all_npc()
  local elite_count = 0
  for _, npc in pairs(npc_map) do
    if npc:get_role_kind() == Config.CommonDefine.NPC_KIND.ELITE then
      elite_count = elite_count + 1
    end
  end
  local modifier = 1 / (0 == elite_count and 1 or elite_count)
  for mutual, shake_data in pairs(self.v_shakes) do
    local source = self.v_shakes[mutual].source
    local source_time_scale = 1
    local consider_global_timescale = true
    if source and source:is_role() and self.v_shakes[mutual].timescale_type == MagicDef.TIME_SCELE_TYPE.ALL then
      source_time_scale = source:get_time_scale()
    elseif self.v_shakes[mutual].timescale_type == MagicDef.TIME_SCELE_TYPE.UNSCALE then
      consider_global_timescale = false
    end
    local cur_duration = self.v_shakes[mutual].duration + Global.delta_time * (consider_global_timescale and GlobalTimeMgr:get_time_scale() or 1) * source_time_scale
    self.v_shakes[mutual].duration = cur_duration
    if cur_duration >= shake_data.life_time then
      self:release_shake(shake_data)
      self.v_shakes[mutual] = nil
    else
      offset:Set(0, 0, 0)
      rot_offset:Set(0, 0, 0)
      if shake_data.preset then
        if shake_data.ablation_flag then
          offset:Set(shake_data.ablation_pos_x, shake_data.ablation_pos_y, shake_data.ablation_pos_z)
          rot_offset:Set(shake_data.ablation_rot_x, shake_data.ablation_rot_y, shake_data.ablation_rot_z)
          local factor = ease_helper.Damp(cur_duration / shake_data.decay)
          offset:Mul(factor)
          rot_offset:Mul(factor)
        elseif shake_data.blend_flag then
          if cur_duration > BLEND_DURATION then
            shake_data.blend_flag = nil
          else
            temp_vec3_02:Set(shake_data.blend_pos_x, shake_data.blend_pos_y, shake_data.blend_pos_z)
            temp_vec3_03:Set(shake_data.blend_rot_x, shake_data.blend_rot_y, shake_data.blend_rot_z)
            self:calc_shake_data(shake_data, cur_duration, temp_vec3_00, temp_vec3_01)
            Vec3.LerpA(temp_vec3_02, temp_vec3_00, cur_duration / BLEND_DURATION, temp_vec3_00)
            Vec3.LerpA(temp_vec3_03, temp_vec3_01, cur_duration / BLEND_DURATION, temp_vec3_01)
            offset:SetA(temp_vec3_00)
            rot_offset:SetA(temp_vec3_01)
          end
        end
        if not shake_data.blend_flag and not shake_data.ablation_flag then
          self:calc_shake_data(shake_data, cur_duration, offset, rot_offset)
        end
      else
        local atten = _floor(cur_duration * shake_data.freq)
        local range = shake_data.amplitude + atten * shake_data.cycle * shake_data.atten
        local type = shake_data.type
        if type == SHAKE_TYPE.NORMAL then
          local random_vec3 = CSRandomVector3(range)
          offset:Set(random_vec3.x, random_vec3.y, random_vec3.z)
        else
          local offset_now = cur_duration * shake_data.freq
          local value = _sin(2 * offset_now * PI)
          value = value * range
          if type == SHAKE_TYPE.UP or type == SHAKE_TYPE.ABSUP then
            offset.y = value
          elseif type == SHAKE_TYPE.DOWN or type == SHAKE_TYPE.ABSDOWN then
            offset.y = -value
          elseif type == SHAKE_TYPE.FORWARD then
            offset.z = value
          elseif type == SHAKE_TYPE.BACK then
            offset.z = -value
          elseif type == SHAKE_TYPE.LEFT then
            offset.x = -value
          elseif type == SHAKE_TYPE.RIGHT then
            offset.x = value
          end
        end
      end
      shake_data.shake_pos_x, shake_data.shake_pos_y, shake_data.shake_pos_z = offset:Get()
      shake_data.shake_rot_x, shake_data.shake_rot_y, shake_data.shake_rot_z = rot_offset:Get()
      self.v_raw_shake_offset:SetA(offset)
      if shake_data.type == SHAKE_TYPE.ABSDOWN or shake_data.type == SHAKE_TYPE.ABSUP then
        shake_pos:Add(offset)
      else
        temp_vec3_00:Set(self.v_camera_transform:GetTransformVector(offset.x, offset.y, offset.z))
        shake_pos:Add(temp_vec3_00:Mul(mutual == NEW_SHAKE_TYPE[3] and 1 or modifier))
      end
      shake_rot:Add(rot_offset:Mul(mutual == NEW_SHAKE_TYPE[3] and 1 or modifier))
    end
  end
  self.v_shake_pos:SetA(shake_pos)
  self.v_shake_rot:SetA(shake_rot)
end

function M:calc_shake_data(shake_data, duration, out_pos, out_rot)
  local shake_scale = false
  if (self.v_camera_mode == CAMERA_VIEW_TYPE.SHOULDER or self.v_camera_shake_type == Config.CAMERA_SHAKE_TYPE.OTS) and 1 == shake_data.mutual then
    shake_scale = true
  end
  local time_envelope_factor = self:get_time_envelope_factor(shake_data.preset.timeEnvelope, shake_data.decay, duration)
  local curve_value_pos_x = self:evaluate_wave_data(shake_data.preset.posWaveData_X, duration, shake_data.life_time) * (shake_scale and self.v_ots_shake_scale_x or 1)
  local curve_value_pos_y = self:evaluate_wave_data(shake_data.preset.posWaveData_Y, duration, shake_data.life_time) * (shake_scale and self.v_ots_shake_scale_y or 1)
  local curve_value_pos_z = self:evaluate_wave_data(shake_data.preset.posWaveData_Z, duration, shake_data.life_time) * (shake_scale and self.v_ots_shake_scale_z or 1)
  Util.VEC3_TEMP:Set(shake_data.preset.positionAmplitude[1], shake_data.preset.positionAmplitude[2], shake_data.preset.positionAmplitude[3])
  Util.VEC3_TEMP_1:Set(curve_value_pos_x, curve_value_pos_y, curve_value_pos_z)
  Vec3.ScaleA(Util.VEC3_TEMP, Util.VEC3_TEMP_1, Util.VEC3_TEMP)
  Util.VEC3_TEMP:Mul(shake_data.preset.positionStrength * time_envelope_factor)
  out_pos:SetA(Util.VEC3_TEMP)
  local curve_value_rot_x = self:evaluate_wave_data(shake_data.preset.rotWaveData_X, duration, shake_data.life_time)
  local curve_value_rot_y = self:evaluate_wave_data(shake_data.preset.rotWaveData_Y, duration, shake_data.life_time)
  local curve_value_rot_z = self:evaluate_wave_data(shake_data.preset.rotWaveData_Z, duration, shake_data.life_time)
  Util.VEC3_TEMP:Set(shake_data.preset.orientationAmplitude[1], shake_data.preset.orientationAmplitude[2], shake_data.preset.orientationAmplitude[3])
  Util.VEC3_TEMP_1:Set(curve_value_rot_x, curve_value_rot_y, curve_value_rot_z)
  Vec3.ScaleA(Util.VEC3_TEMP, Util.VEC3_TEMP_1, Util.VEC3_TEMP)
  Util.VEC3_TEMP:Mul(shake_data.preset.orientationStrength * time_envelope_factor)
  temp_vec2_00:Set(Util.VEC3_TEMP.x, Util.VEC3_TEMP.y)
  temp_vec2_00:SetRotate(shake_data.delta_angle)
  Util.VEC3_TEMP:Set(temp_vec2_00.x, temp_vec2_00.y, Util.VEC3_TEMP.z)
  out_rot:SetA(Util.VEC3_TEMP)
end

function M:get_new_pos_val(target, from, to, lerp_val)
  local new_x, new_y, new_z = Vec3.LerpB(from, to, lerp_val)
  if target then
    target.x = new_x
    target.y = new_y
    target.z = new_z
  end
  return new_x, new_y, new_z
end

function M:set_camera_focus_pos(is_clear, pos_key, speed)
  if is_clear then
    self.v_fixed_focus_pos = nil
    return
  end
  local _, cur_pos_y = self.v_focal_point:GetPositionA()
  local scene_logic = SceneMgr:get_scene_logic()
  local center_x, _, center_z = scene_logic:get_pos_key_position(pos_key)
  self.v_fixed_focus_pos = Vec3.New(center_x, cur_pos_y, center_z)
  self.v_fixed_lerp_speed = speed or 0.1
  self:_follow_target()
end

function M:set_npc_focus_pos(is_clear, npc_id, speed)
  if is_clear then
    self.v_fixed_focus_pos = nil
    self.v_is_face_npc = false
    return
  end
  local scene_logic = SceneMgr:get_scene_logic()
  local npc_obj = scene_logic:get_func_npc(npc_id)
  local pos = npc_obj:get_npc_face_pos()
  local npc_trans = npc_obj.transform
  self.v_npc_pos_x, self.v_npc_pos_y, self.v_npc_pos_z = npc_trans:GetPositionA()
  self.v_npc_target_pos = pos
  self.v_fixed_focus_pos = Vec3.New(self.v_npc_pos_x, self.v_npc_pos_y, self.v_npc_pos_z)
  self.v_fixed_lerp_speed = speed or 0.1
  self.v_is_face_npc = true
  self.v_is_reach_target_pos = false
  self:_follow_target()
end

function M:check_char_motion_pos()
  if not self.v_char.act_ctrl then
    return
  end
  return self.v_char.act_ctrl:check_motion_pos()
end

function M:_check_can_follow_target()
  if self:update_follow_type() then
    return
  end
  if self.v_stop_follow_tar then
    return
  end
  if not self.v_char then
    return
  end
  if not self.v_last_target_pos then
    return
  end
  if self.v_is_skill_indicator_pos then
    if self.v_skill_indicator_parms and 0 == self.v_skill_indicator_parms.dev_val then
      return true
    else
      return false
    end
  end
  return true
end

local tmp_target = Vec3.New()
local cur_focal_pos = Vec3.New()
local toffset = Vec3.New()

function M:_follow_target(is_hit, fixed_pos)
  if not self:_check_can_follow_target() then
    return
  end
  local is_motion_pos = self:check_char_motion_pos()
  if is_motion_pos and not fixed_pos then
    return
  end
  if self.v_camera_mode == CAMERA_VIEW_TYPE.SHOULDER and self.v_attach_point_transform and self.v_pinch_end_flag then
    self.v_target_offset.y = self.v_camera_lookpoint_offset_y
  end
  if self.v_camera_cfg and self.v_camera_cfg.OffsetReference == OffsetReference.Local then
    local local_offset_x, local_offset_y, local_offset_z = self.v_focal_point:GetTransformVector(self.v_target_offset.x, self.v_target_offset.y, self.v_target_offset.z)
    toffset:Set(local_offset_x, local_offset_y, local_offset_z)
  else
    toffset:SetA(self.v_target_offset)
  end
  local last_target_pos = self.v_last_target_pos
  cur_focal_pos.x, cur_focal_pos.y, cur_focal_pos.z = self.v_focal_point:GetPositionA()
  local target_focus_pos
  local cur_hero_pos = fixed_pos and fixed_pos or self.v_char:get_pos_vec3()
  if self.v_fixed_focus_pos then
    self:get_new_pos_val(last_target_pos, cur_focal_pos, self.v_fixed_focus_pos, self.v_fixed_lerp_speed)
    target_focus_pos = self.v_fixed_focus_pos
  elseif self.v_target_lerp and not self.v_target_nolerp_trigger then
    self:get_new_pos_val(self.v_current_offset, self.v_current_offset, toffset, 5 * Global.elapsed)
    local lerp_val = self.v_target_follow_speed or self.v_lerp_speed
    tmp_target.x = self.v_current_offset.x + cur_hero_pos.x
    tmp_target.y = self.v_current_offset.y + cur_hero_pos.y
    tmp_target.z = self.v_current_offset.z + cur_hero_pos.z
    self:get_new_pos_val(last_target_pos, cur_focal_pos, tmp_target, lerp_val * Global.elapsed)
    target_focus_pos = tmp_target
  else
    self:get_new_pos_val(self.v_current_offset, self.v_current_offset, toffset, 1)
    last_target_pos.x = self.v_current_offset.x + cur_hero_pos.x
    last_target_pos.y = self.v_current_offset.y + cur_hero_pos.y
    last_target_pos.z = self.v_current_offset.z + cur_hero_pos.z
    target_focus_pos = toffset
    self.v_target_nolerp_trigger = self.v_target_nolerp_trigger and false
  end
  if is_motion_pos then
    last_target_pos = target_focus_pos
  end
  if is_hit then
    _, _, last_target_pos.z = self.v_focal_point:GetPositionA()
  end
  if self.v_target_follow_speed and Vec3.SquareDistance(last_target_pos, target_focus_pos) < 0.01 then
    self.v_target_follow_speed = nil
  end
  self.v_focal_point:SetPositionA(last_target_pos.x, last_target_pos.y, last_target_pos.z)
  self:update_min_hight(last_target_pos.x, last_target_pos.z)
end

function M:change_follow_target2(follow_target_type, param)
  self.v_follow_target_type = follow_target_type
  if self.v_is_first_person_camera then
    self:set_camera_focal_in_fpc(follow_target_type, param)
    return
  end
  if self.v_camera_mode == CAMERA_VIEW_TYPE.SHOULDER then
    self:set_camera_focal_in_shoulder_mode(follow_target_type, param)
    return
  end
  if not self.v_follow_target_type or 0 == self.v_follow_target_type then
    self:clean_change_follow_target_data()
    return
  end
  self.camera_style = param and param[9]
  self.v_follow_target_pos = param and param[8]
  self:change_follow_target(follow_target_type, param and param[7], param, true)
end

function M:change_follow_target(follow_target_type, npc, param, is_from_editor)
  if not self.v_camera_cfg then
    return
  end
  if self.v_camera_mode == CAMERA_VIEW_TYPE.SHOULDER then
    return
  end
  self.v_follow_target_type = follow_target_type
  if not self.v_follow_target_type or 0 == self.v_follow_target_type then
    self:clean_change_follow_target_data()
    return
  elseif 1 == self.v_follow_target_type then
    local pre_camera_follow_level = self.v_follow_target_param and type(self.v_follow_target_param[7]) == "number" and self.v_follow_target_param[7] or default_camera_level
    local new_camera_follow_level = param and type(param[7]) == "number" and param[7] or default_camera_level
    if pre_camera_follow_level > new_camera_follow_level then
      return
    end
  elseif 3 == self.v_follow_target_type then
    if self.v_is_in_change_follow_target and self.v_is_cur_cfg_from_editor and not is_from_editor and not self.v_read_cache_flag then
      self.v_cache_follow_target_type = follow_target_type
      self.v_cache_follow_target_param = param
      self.v_cache_follow_target = npc
      self.v_cache_camera_style = 0
      self.v_cache_is_new_api = false
      return
    else
      self.v_default_follow_target = npc
      self.v_default_follow_target_param = param
    end
  elseif 4 == self.v_follow_target_type then
    if self.v_cache_follow_target or self.v_cache_follow_target_param then
      self.v_read_cache_flag = true
      if self.v_cache_is_new_api then
        self:change_follow_target_new(self.v_cache_follow_target_type, self.v_cache_follow_target, self.v_cache_follow_target_param)
      else
        self:change_follow_target(self.v_cache_follow_target_type, self.v_cache_follow_target, self.v_cache_follow_target_param)
      end
      self.v_read_cache_flag = false
      self.v_cache_follow_target_type = nil
      self.v_cache_follow_target = nil
      self.v_cache_follow_target_param = nil
      self.v_cache_camera_style = nil
      self.v_cache_is_new_api = nil
      self.v_is_cur_cfg_from_editor = false
      return
    elseif self.v_default_follow_target or self.v_default_follow_target_param then
      self.v_follow_target = self.v_default_follow_target
      self.v_follow_target_param = self.v_default_follow_target_param
    else
      Global.log.Debug("未设置默认焦点")
      self:clean_change_follow_target_data()
      return
    end
  end
  self.camera_style = is_from_editor and self.camera_style or 0
  self.v_is_cur_cfg_from_editor = is_from_editor
  self.v_is_in_change_follow_target = true
  self.v_correct_state = CORRECT_TYPE.CHANGE_FOCUS
  self.v_is_change_follow_target_new = false
  self.v_lerp_correct_val = self.v_pinch_distance
  if 4 ~= self.v_follow_target_type then
    self.v_follow_target = npc
    self.v_follow_target_param = param
  end
  local default_distance = self.v_camera_cfg.DefaultDistance
  local max_add_val = _min(self.v_follow_target_param[2], self.v_gear_distance_max_val - default_distance)
  local add_val = _floor(max_add_val / self.v_follow_target_param[5])
  self.v_char_to_focal_max_distance = (self.v_follow_target_param[1] + add_val * self.v_follow_target_param[4]) / 2
  self:_follow_target()
end

function M:change_follow_target_new(follow_target_type, npc, param)
  if not self.v_camera_cfg then
    return
  end
  if self.v_camera_mode == CAMERA_VIEW_TYPE.SHOULDER then
    return
  end
  self.v_follow_target_type = follow_target_type
  if not self.v_follow_target_type or 0 == self.v_follow_target_type then
    self:clean_change_follow_target_data()
    return
  elseif 1 == self.v_follow_target_type then
    local pre_camera_follow_level = self.v_follow_target_param and type(self.v_follow_target_param[7]) == "number" and self.v_follow_target_param[7] or default_camera_level
    local new_camera_follow_level = param and type(param[7]) == "number" and param[7] or default_camera_level
    if pre_camera_follow_level > new_camera_follow_level then
      return
    end
  elseif 3 == self.v_follow_target_type then
    if self.v_is_in_change_follow_target and self.v_is_cur_cfg_from_editor and not self.v_read_cache_flag then
      self.v_cache_follow_target_type = follow_target_type
      self.v_cache_follow_target_param = param
      self.v_cache_follow_target = npc
      self.v_cache_camera_style = 0
      self.v_cache_is_new_api = true
      return
    else
      self.v_default_follow_target = npc
      self.v_default_follow_target_param = param
    end
  elseif 4 == self.v_follow_target_type then
    if self.v_default_follow_target or self.v_default_follow_target_param then
      self.v_follow_target = self.v_default_follow_target
      self.v_follow_target_param = self.v_default_follow_target_param
    else
      Global.log.Debug("未设置默认焦点")
      self:clean_change_follow_target_data()
      return
    end
  end
  self.camera_style = 0
  self.v_follow_target_pos = param and param[10]
  self.v_correct_state = CORRECT_TYPE.CHANGE_FOCUS
  self.v_lerp_correct_val = self.v_pinch_distance
  self.v_is_in_change_follow_target = true
  self.v_is_change_follow_target_new = true
  if 4 ~= self.v_follow_target_type then
    self.v_follow_target = npc
    self.v_follow_target_param = param
  end
  local default_distance = self.v_camera_cfg.DefaultDistance
  local max_add_val = _min(self.v_follow_target_param[2], self.v_gear_distance_max_val - default_distance)
  local add_val = _floor(max_add_val / self.v_follow_target_param[5])
  self.v_char_to_focal_max_distance = (self.v_follow_target_param[1] + add_val * self.v_follow_target_param[4]) / 2
  self:_follow_target()
end

function M:keep_focus_pos_by_clear_target()
  if self.v_camera_mode == CAMERA_VIEW_TYPE.SHOULDER then
    return
  end
  self.v_follow_target = nil
  self.v_follow_target_pos = nil
  self.v_fixed_focus_pos = Vec3.New(self.v_focal_point:GetPositionA())
  self.v_follow_target_type = CAMERA_FOLLOW_TYPE.KEEP_FOCUS_POS
  self.v_fixed_lerp_speed = defaule_target_lerp_val
  if self.v_focus_offset_data then
    self.v_focus_offset_data.offset:Set(0, 0, 0)
  end
end

function M:clean_change_follow_target_data()
  if not self.v_camera_cfg then
    return
  end
  self.camera_style = 0
  self.v_target_val = self.v_camera_cfg.DefaultDistance
  self.v_target_height = self.v_camera_cfg.DefaultHeight or 0
  self.v_target_distance = self.v_camera_cfg.DefaultDistance
  self.v_follow_target = nil
  self.v_follow_target_pos = nil
  self.v_follow_target_type = nil
  self.v_follow_target_param = nil
  self.v_correct_state = CORRECT_TYPE.NONE
  self.v_fixed_focus_pos = nil
  self.v_focus_offset_data = nil
  self.v_is_cur_cfg_from_editor = nil
  self.v_is_in_change_follow_target = nil
  self.v_default_follow_target = nil
  self.v_default_follow_target_param = nil
  if self.v_focus_offset_data then
    self.v_focus_offset_data.start_offset:Set(0, 0, 0)
  end
end

function M:change_focus_follow_speed(speed)
  if self.v_camera_mode == CAMERA_VIEW_TYPE.SHOULDER then
    return
  end
  self.v_target_follow_speed = speed
end

function M:get_target_follow_speed()
  return self.v_target_follow_speed
end

function M:get_camera_follow_target()
  return self.v_follow_target_pos and self.v_follow_target_pos or self.v_follow_target
end

function M:update_follow_type()
  if not self.v_follow_target_type or 0 == self.v_follow_target_type then
    return
  end
  if self.v_follow_target_type == CAMERA_FOLLOW_TYPE.KEEP_FOCUS_POS then
    return
  end
  if self.v_follow_target_type == CAMERA_FOLLOW_TYPE.TARGET_POS or self.v_follow_target_type == CAMERA_FOLLOW_TYPE.SET_DEFAULT_FOCUS_POS or self.v_follow_target_type == CAMERA_FOLLOW_TYPE.BACK_TO_DEFAULT_FOCUS_POS then
    self:_follow_target_by_target_pos()
  end
  return true
end

local FOLLOW_TYPE = {MIDDLE = 1, POINT = 2}

function M:_follow_target_by_target_pos()
  if (not self.v_follow_target or self.v_follow_target:is_destroy() or not self.v_follow_target.transform) and not self.v_follow_target_pos then
    self:clean_change_follow_target_data()
    return
  end
  if not Global.hero then
    return
  end
  if not self.v_focus_offset_data then
    self.v_focus_offset_data = {
      start_offset = Vec3.New(),
      offset = Vec3.New(),
      tar_offset = Vec3.New()
    }
  end
  local offset_data = self.v_focus_offset_data
  local param = self.v_follow_target_param
  local check_distance = param[1]
  local max_add_val = param[2]
  local offset = param[3] or {}
  offset.x = offset.x or 0
  offset.y = offset.y or 0
  offset.z = offset.z or 0
  offset_data.tar_offset:Set(offset.x, offset.y, offset.z)
  local calculate_val = param[4] or defaule_target_lerp_val
  local param_add_val = param[5] or 0
  local lerp_val = param[6] or defaule_target_lerp_val
  local focus_type = param[8] or 0
  local arm_distance_offset = param[9] or 0
  if not self.v_focal_target_pos then
    self.v_focal_target_pos = Vec3.New()
  end
  if self.v_follow_target_pos then
    self.v_focal_target_pos.x = self.v_follow_target_pos.x
    self.v_focal_target_pos.y = self.v_follow_target_pos.y
    self.v_focal_target_pos.z = self.v_follow_target_pos.z
  else
    self.v_focal_target_pos.x, self.v_focal_target_pos.y, self.v_focal_target_pos.z = self.v_follow_target.transform:GetPositionA()
  end
  local target_pos = self.v_focal_target_pos
  local char_pos = Global.hero:get_pos_vec3()
  temp_vec3_01:SetA(target_pos)
  temp_vec3_00:SetA(char_pos)
  temp_vec3_01:Sub(temp_vec3_00)
  local follow_type
  if not self.camera_style or 0 == self.camera_style then
    if type(focus_type) == "number" then
      if 0 == focus_type then
        temp_vec3_01:Mul(0.5)
        temp_vec3_00:Add(temp_vec3_01)
        follow_type = FOLLOW_TYPE.MIDDLE
      elseif 1 == focus_type then
        temp_vec3_00:SetA(target_pos)
        follow_type = FOLLOW_TYPE.POINT
      end
    else
      temp_vec3_01:Mul(0.5)
      temp_vec3_00:Add(temp_vec3_01)
      follow_type = FOLLOW_TYPE.MIDDLE
    end
  else
    temp_vec3_00:SetA(target_pos)
    follow_type = FOLLOW_TYPE.POINT
  end
  local distance = Vec3.Distance(char_pos, target_pos)
  local defaule_distance = self.v_camera_cfg.DefaultDistance
  local defaule_height = self.v_camera_cfg.DefaultHeight or 0
  local max_distance = defaule_distance + max_add_val
  local max_height = defaule_height + max_add_val
  if check_distance < distance then
    local val = _floor((distance - check_distance) / calculate_val)
    local add_val = _min(val * param_add_val, max_add_val)
    self.v_target_val = _min(max_distance, defaule_distance + add_val)
    self.v_target_height = _min(max_height, defaule_height + add_val)
  else
    self.v_target_val = defaule_distance - arm_distance_offset
    self.v_target_height = defaule_height - arm_distance_offset
  end
  if self.v_gear_distance_max_val then
    self.v_target_val = Math.Clamp(self.v_target_val, self.v_gear_distance_min_val, self.v_gear_distance_max_val)
  end
  if follow_type == FOLLOW_TYPE.MIDDLE and self.v_gear_distance_max_val and self.v_target_val >= math.min(max_distance, self.v_gear_distance_max_val) then
    temp_vec3_00:SetA(char_pos)
    temp_vec3_00:Add(temp_vec3_01:ClampMagnitude(self.v_char_to_focal_max_distance or 100))
  end
  if not self.v_camera_cfg.DontAddDefaultOffset then
    temp_vec3_00.x = temp_vec3_00.x + (self.v_camera_cfg.DefaultXPOs or 0)
    temp_vec3_00.y = temp_vec3_00.y + (self.v_camera_cfg.DefaultYPOs or 0)
    temp_vec3_00.z = temp_vec3_00.z + (self.v_camera_cfg.DefaultZPOs or 0)
  end
  local last_target_pos = self.v_last_target_pos
  Vec3.LerpA(last_target_pos, temp_vec3_00, lerp_val, self.v_last_target_pos)
  self.v_focal_point:SetPositionA(last_target_pos.x, last_target_pos.y, last_target_pos.z)
  self.v_focal_point:LookAtA(target_pos.x, target_pos.y, target_pos.z)
  Vec3.LerpA(offset_data.start_offset, offset_data.tar_offset, lerp_val, offset_data.offset)
  if self.v_is_change_follow_target_new then
    offset_data.start_offset:SetA(offset_data.offset)
    lerp_val = 1
  end
  temp_vec3_01:Set(self.v_focal_point:GetTransformPoint(offset_data.offset.x, offset_data.offset.y, offset_data.offset.z))
  temp_vec3_02:Set(self.v_focal_point:GetPositionA())
  local pos_x = _lerp(temp_vec3_02.x, temp_vec3_01.x, lerp_val)
  local pos_y = _lerp(temp_vec3_02.y, temp_vec3_01.y, lerp_val)
  local pos_z = _lerp(temp_vec3_02.z, temp_vec3_01.z, lerp_val)
  self.v_focal_point:SetPositionA(pos_x, pos_y, pos_z)
  self:update_min_hight(last_target_pos.x, last_target_pos.z)
end

function M:set_camera_pos()
  self:_update_distance()
  self:stop_distance_correct()
  if self.v_camera_cfg then
    self:update_cache_camera_info(self.v_camera_cfg.DefaultHeight or 0, self.v_camera_cfg.DefaultDistance)
    self:init_camera_info()
  end
  local tmp_target = self.v_current_offset + self.v_char:get_pos_vec3()
  self.v_focal_point:SetPositionA(tmp_target.x, tmp_target.y, tmp_target.z)
  if self.v_camera_mode == CAMERA_VIEW_TYPE.SHOULDER then
    if self.v_swipe then
      self.v_ignore_cur_swipe = true
      self.v_swipe = false
    end
    self:set_camera_to_default_pos_in_shouldermode()
  else
    local posx, posy, posz = self:_get_base_pos()
    self:set_cam_postion(posx, posy, posz)
  end
  if self.v_camera_cfg and self.v_focus_hero_effect then
    self.v_focus_hero_effect:init_data(self.v_focal_point.position, self.v_camera_cfg.DefaultDistance)
  end
  self.v_temp_focal_pos_vec3:Set(self.v_focal_point:GetPositionA())
  self.v_temp_camera_pos_vec3:Set(self.v_camera_transform:GetPositionA())
  self.v_temp_focal_pos = self.v_temp_focal_pos_vec3
  self.v_temp_camera_pos = self.v_temp_camera_pos_vec3
end

function M:_update_distance()
  local cal_distance = self.v_target_distance
  local delta_distance = self.v_target_distance - self.v_cur_distance
  local move_distance = 0
  local is_collider = self.v_is_collider
  if self.v_is_collider then
    move_distance = delta_distance
    self.v_is_collider = false
  else
    move_distance = delta_distance * Global.elapsed * self.v_zoom_smoothing
  end
  cal_distance = self.v_cur_distance + move_distance
  self.v_cur_distance = cal_distance
  return is_collider
end

function M:remove_magic(msg)
  if not self.v_camera_magic_id then
    return
  end
  local remove_id = msg.mm_y
  if remove_id ~= self.v_camera_magic_id then
    return
  end
  local vcam = self.v_magic_vcam
  if not vcam.remove_correction then
    return
  end
  vcam.elapsed = vcam.ease_in
  vcam.duration = vcam.elapsed + vcam.ease_out + 0.01
  self.v_camera_magic_id = nil
end

function M:_update_magic_vcam()
  if not SceneMgr:can_update() then
    return
  end
  self:_update_now_fov()
  if self.v_magic_pos_prop < 0 and self.v_magic_trans_prop < 0 then
    return
  end
  local vcam = self.v_magic_vcam
  local ratio = 1
  local ease_in = vcam.ease_in
  local duration = vcam.duration
  local ease_out = vcam.ease_out
  local elapsed = vcam.elapsed
  local cordinate = vcam.cordinate
  local x = vcam.x
  local y = vcam.y
  local z = vcam.z
  local rx = vcam.rx or 0
  local ry = vcam.ry or 0
  local rz = vcam.rz or 0
  elapsed = elapsed + (not Util.is_destroy(Global.hero) and Global.hero.time_mgr:get_dt_time() or self:get_dt())
  vcam.elapsed = elapsed
  vcam.ease_out_ratio = false
  vcam.ease_in_ratio = false
  if vcam.elapsed > vcam.duration then
    self.v_magic_pos_prop = -1
    self.v_magic_trans_prop = -1
    vcam.offset:Set(0, 0, 0)
    return
  end
  if vcam.spline_cfg then
    vcam.spline:set_local_coordinate(0, 0, 0, 0)
    local segment_index, normalized_t = vcam.spline:get_bounding_index(vcam.elapsed)
    local x, y, z = vcam.spline:evaluate_position_in_worldspace(segment_index, normalized_t)
    local qx, qy, qz, qw = vcam.spline:evaluate_orientation_in_worldspace(segment_index, normalized_t)
    vcam.offset:Set(x, y, z)
    if 1 == vcam.orientation_type then
      vcam.quat:Set(qx, qy, qz, qw)
    end
    return
  end
  if ease_in > elapsed then
    ratio = elapsed / ease_in
    vcam.ease_in_ratio = ratio
  elseif duration < elapsed + ease_out then
    ratio = 1 - (elapsed - (duration - ease_out)) / ease_out
    vcam.ease_out_ratio = ratio
    vcam.start_offset:Set(0, 0, 0)
  end
  if cordinate == CORD_TYPE.POS_SELF_AND_RO_WORLD or cordinate == CORD_TYPE.SELF then
    local new_pos = self.v_camera_transform:TransformPoint(x, y, z)
    vcam.tar_pos:Set(new_pos.x, new_pos.y, new_pos.z)
    local cur_pos_x, cur_pos_y, cur_pos_z = self.v_camera_transform:GetPositionA()
    vcam.tar_offset:Set(new_pos.x - cur_pos_x, new_pos.y - cur_pos_y, new_pos.z - cur_pos_z)
  end
  if cordinate == CORD_TYPE.SELF or cordinate == CORD_TYPE.RO_SELF_AND_POS_WORLD or CORD_TYPE.RO_SELF_AND_POS_GLOBAL then
    vcam.tar_quat = self.v_cur_quat * Quat.Euler(rx, ry, rz)
  end
  Vec3.LerpA(vcam.start_offset, vcam.tar_offset, ratio, vcam.offset)
  if vcam.ease_out_ratio then
    Quat.LerpA(self.v_cur_quat, vcam.tar_quat, ratio, vcam.quat)
  else
    Quat.LerpA(vcam.start_quat, vcam.tar_quat, ratio, vcam.quat)
  end
end

local function help_init_timer(ease_in, duration, ease_out, vcam)
  duration = -1 == duration and 1.0E8 or duration + ease_out
  vcam.duration = duration
  vcam.ease_in = ease_in
  vcam.ease_out = ease_out
  vcam.elapsed = 0
end

function M:_limit_offset_distance(z)
  if not self.v_battle_cam_dist_limit_min or not self.v_battle_cam_dist_limit_max then
    return z
  end
  if self.v_battle_cam_dist_limit_min <= 0 or self.v_battle_cam_dist_limit_max <= 0 then
    return z
  end
  local cur_dis = self.v_cur_distance
  local tar_dis = cur_dis - z
  tar_dis = _clamp(tar_dis, self.v_battle_cam_dist_limit_min, self.v_battle_cam_dist_limit_max)
  return cur_dis - tar_dis
end

function M:start_pos_offset(parms_data, is_transform)
  if self.v_camera_shake_type == Config.CAMERA_SHAKE_TYPE.OTS then
    return
  end
  if parms_data.curve_file_name then
    self.v_camera_magic_id = parms_data.magic_id
    self.v_magic_pos_prop = 1
    self.v_magic_vcam.duration = parms_data.duration
    self.v_magic_vcam.elapsed = 0
    self.v_magic_vcam.remove_correction = parms_data.remove_correction
    self.v_magic_vcam.spline_cfg = ShareRes.get_spline_file(parms_data.curve_file_name)
    self.v_magic_vcam.orientation_type = parms_data.orientation_type
    self.v_magic_vcam.force_handle_rotation = parms_data.force_handle_rotation
    if not self.v_magic_vcam.spline then
      self.v_magic_vcam.spline = spline_bezier:new(self.v_magic_vcam.spline_cfg)
    else
      self.v_magic_vcam.spline:init_data(self.v_magic_vcam.spline_cfg)
    end
    self.v_magic_effect = true
    self:stop_distance_correct()
    return
  end
  local x = parms_data.px
  local y = parms_data.py
  local z = parms_data.pz
  local ease_in = parms_data.ease_in
  local ease_out = parms_data.ease_out
  local cordinate = parms_data.cordinate
  local move_by_target = parms_data.following_target
  local prop = parms_data.prop
  local remove_correction = parms_data.remove_correction
  local duration = parms_data.duration
  local magic_id = parms_data.magic_id
  if is_transform then
    prop = nil
  end
  local vcam = self.v_magic_vcam
  vcam.spline_cfg = nil
  vcam.orientation_type = 1
  vcam.force_handle_rotation = parms_data.force_handle_rotation
  local use_magic_pos = self.v_magic_pos_prop > 0 or self.v_magic_trans_prop > 0
  if use_magic_pos then
    vcam.start_offset.x = vcam.offset.x
    vcam.start_offset.y = vcam.offset.y
    vcam.start_offset.z = vcam.offset.z
  else
    vcam.start_offset:Set(0, 0, 0)
  end
  self.v_camera_magic_id = magic_id
  self.v_magic_pos_prop = 1
  self.v_magic_pos_prop = prop or 1
  vcam.start_pos:Set(self.v_camera_transform:GetPositionA())
  vcam.follow_tar = move_by_target
  vcam.start_quat = vcam.start_quat or self.v_cur_quat
  vcam.remove_correction = remove_correction
  vcam.cordinate = cordinate
  vcam.x = x
  vcam.y = y
  vcam.z = z
  if cordinate == CORD_TYPE.POS_SELF_AND_RO_WORLD or cordinate == CORD_TYPE.SELF then
    local new_pos = self.v_camera_transform:TransformPoint(x, y, z)
    vcam.tar_pos:Set(new_pos.x, new_pos.y, new_pos.z)
    local cur_pos_x, cur_pos_y, cur_pos_z = self.v_camera_transform:GetPositionA()
    vcam.tar_offset:Set(new_pos.x - cur_pos_x, new_pos.y - cur_pos_y, new_pos.z - cur_pos_z)
  elseif cordinate == CORD_TYPE.RO_SELF_AND_POS_GLOBAL then
    local camera_pos_x, camera_pos_y, camera_pos_z = self.v_camera_transform:GetPositionA()
    vcam.tar_pos.x = camera_pos_x + x
    vcam.tar_pos.y = camera_pos_y + y
    vcam.tar_pos.z = camera_pos_z + z
    vcam.tar_offset:Set(x, y, z)
  else
    local pos_x, pos_y, pos_z = self.v_camera_transform:GetPositionA()
    self.v_vcamera_pos.x = x
    self.v_vcamera_pos.y = y
    self.v_vcamera_pos.z = z
    vcam.tar_pos:SetA(self.v_vcamera_pos)
    vcam.tar_offset:Set(-pos_x + x, -pos_y + y, -pos_z + z)
  end
  help_init_timer(ease_in, duration, ease_out, vcam)
  self.v_magic_effect = true
  self:stop_distance_correct()
end

function M:stop_pos_offset()
  if self.v_magic_trans_prop > self.v_scene_cam_prop then
    return
  end
  local vcam = self.v_magic_vcam
  vcam.elapsed = vcam.duration - vcam.ease_out
end

function M:start_fov_offset(fov, ease_in, duration, ease_out, set_default_fov, program_lerp_fov)
  self.v_magic_fov = true
  self.v_start_fov = self.v_cur_fov or default_fov
  self.v_target_fov = fov
  self.v_cur_fov = self.v_start_fov
  self.v_fov_ease_in = ease_in
  self.v_fov_duration = -1 == duration and 1.0E8 or duration + ease_out
  self.v_fov_ease_out = ease_out
  self.v_fov_elapse = 0
  self.v_program_lerp_fov = program_lerp_fov
  if set_default_fov then
    default_fov = fov
  end
end

function M:_update_now_fov()
  if not self.v_magic_fov then
    return
  end
  local ratio = 1
  local ease_in = self.v_fov_ease_in
  local duration = self.v_fov_duration
  local ease_out = self.v_fov_ease_out
  local elapsed = self.v_fov_elapse
  local dt = GlobalTimeMgr:get_dt_time()
  elapsed = elapsed + dt
  self.v_fov_elapse = elapsed
  if duration < elapsed then
    self.v_magic_fov = false
    return
  end
  if self.v_fov_elapse < self.v_fov_ease_in then
    ratio = elapsed / ease_in
    self.v_cur_fov = Math.lerp_number(self.v_start_fov, self.v_target_fov, ratio)
  elseif duration < elapsed + ease_out and (not self.v_program_lerp_fov or 0 == self.v_program_lerp_fov) then
    ratio = 1 - (elapsed - (duration - ease_out)) / ease_out
    self.v_cur_fov = Math.lerp_number(default_fov, self.v_target_fov, ratio)
  end
  self.v_cinimachine_vc:SetFov(self.v_cur_fov)
end

function M:update_lerp_camera_fov()
  if self.v_magic_fov then
    return
  end
  if not self.v_program_lerp_fov or 0 == self.v_program_lerp_fov then
    return
  end
  if _abs(self.v_cur_fov - default_fov) <= 0.01 then
    self.v_program_lerp_fov = nil
    return
  end
  self.v_cur_fov = _lerp(self.v_cur_fov, default_fov, self.v_program_lerp_fov)
  self.v_cinimachine_vc:SetFov(self.v_cur_fov)
end

function M:simple_lerp_fov()
  if self.v_need_lerp_fov then
    if _abs(self.v_cur_fov - default_fov) <= 0.01 then
      self.v_need_lerp_fov = false
      self.v_cur_fov = default_fov
    end
    self.v_cur_fov = _lerp(self.v_cur_fov, default_fov, pinch_damping * self:get_dt())
    self.v_cinimachine_vc:SetFov(self.v_cur_fov)
  end
end

function M:get_camera_visible_effect_root()
  return self.v_visible_effect_root
end

function M:get_camera_effect_root()
  return self.v_effect_root
end

function M:set_camera_effect_root_active(active)
  if self.v_effect_root_active ~= active then
    if not Util.is_nil(self.v_effect_root.gameObject) then
      self.v_effect_root.gameObject:SetActive(active)
    end
    self.v_effect_root_active = active
  end
end

function M:get_child_transform(name)
  local obj = Util.get_child_gameobj(name, self.v_camera_transform)
  if obj and not obj:IsNull() then
    return obj.transform
  end
end

function M:get_fov()
  return self.v_cur_fov
end

function M:stop_fov_offset()
  if not self.v_fov_duration then
    return
  end
  self.v_fov_elapse = self.v_fov_duration - self.v_fov_ease_out
  self.v_target_fov = self.v_cur_fov
end

function M:start_pos_rotation_offset(parms_data)
  if self.v_camera_shake_type == Config.CAMERA_SHAKE_TYPE.OTS then
    return
  end
  if parms_data.curve_file_name then
    self.v_magic_trans_prop = parms_data.prop or 1
    self:start_pos_offset(parms_data, true)
    return
  end
  local x = parms_data.px
  local y = parms_data.py
  local z = parms_data.pz
  local rx = parms_data.rx
  local ry = parms_data.ry
  local rz = parms_data.rz
  local ease_in = parms_data.ease_in
  local ease_out = parms_data.ease_out
  local cordinate = parms_data.cordinate
  local move_by_target = parms_data.following_target
  local prop = parms_data.prop
  local remove_correction = parms_data.remove_correction
  local duration = parms_data.duration
  local magic_id = parms_data.magic_id
  local vcam = self.v_magic_vcam
  vcam.rx = rx
  vcam.ry = ry
  vcam.rz = rz
  self.v_magic_trans_prop = prop or 1
  self:start_pos_offset(parms_data, true)
  local base_euler = self.v_target_euler
  if vcam.ease_in_ratio then
    vcam.start_quat = vcam.quat
  else
    vcam.start_quat = self.v_cur_quat
  end
  if cordinate == CORD_TYPE.SELF or cordinate == CORD_TYPE.RO_SELF_AND_POS_WORLD or CORD_TYPE.RO_SELF_AND_POS_GLOBAL then
    vcam.tar_quat = self.v_cur_quat * Quat.Euler(rx, ry, rz)
  else
    vcam.tar_quat:SetEuler(rx, ry, rz)
  end
  help_init_timer(ease_in, duration, ease_out, vcam)
end

function M:stop_pos_rotation_offset()
  if self.v_magic_trans_prop > self.v_scene_cam_prop then
    return
  end
  local vcam = self.v_magic_vcam
  vcam.elapsed = vcam.duration - vcam.ease_out
  self:stop_pos_offset()
end

function M:set_angle(x, y, ease_in_speed, prop)
  self.v_target_euler.x = x or self.v_target_euler.x
  self.v_target_euler.y = y or self.v_target_euler.x
  ease_in_speed = ease_in_speed or 1
  ease_in_speed = ease_in_speed > 0 and ease_in_speed or 1
  self.v_ease_in_speed = ease_in_speed
  self.v_last_ease_in_speed = ease_in_speed
  self.v_last_target_euler = self.v_target_euler
  self.v_scene_cam_prop = prop or 1
end

function M:set_distance(dst)
  self.v_target_distance = dst or self.v_target_distance
end

local forward_vec3 = Vec3.New()

function M:_get_base_pos()
  local fpos_x, fpos_y, fpos_z = self.v_focal_point:GetPositionA()
  self.v_cur_quat:MulVec3_NoneAlloc(Vec3.forward, forward_vec3)
  local delta_pos = forward_vec3:Mul(self.v_cur_distance)
  local posx = fpos_x - delta_pos.x
  local posy = fpos_y - delta_pos.y
  local posz = fpos_z - delta_pos.z
  return posx, posy, posz
end

local last_camera_euler = vec3.New()

function M:_get_base_pos_in_shoulderMode()
  if self.v_swipe then
    return self:_get_base_pos()
  end
  local focal_pos_x, focal_pos_y, focal_pos_z = self.v_focal_point:GetPositionA()
  temp_vec3_00:Set1(self.v_camera_transform:GetEulerAnglesA3())
  temp_vec3_01:Set1(focal_pos_x, focal_pos_y, focal_pos_z)
  temp_vec3_02:Set1(self.v_camera_transform:GetPositionA())
  temp_vec3_01:Sub(temp_vec3_02)
  temp_vec3_01.y = 0
  local forward_x, _, forward_z = self.v_camera_transform:GetForwardA()
  temp_vec3_03:Set(forward_x, 0, forward_z)
  local euler_y = Vec3.AngleAroundAxis_NoneAlloc(temp_vec3_03, temp_vec3_01, Vec3.up)
  local temp_camera_euler_y = temp_vec3_00.y + euler_y
  temp_vec3_00.y = _lerp(temp_vec3_00.y, temp_camera_euler_y, 20 * self:get_dt())
  local min_eulery_val = 15
  local max_eulery_val = 65
  if self.v_camera_cfg then
    local drag_param_data = self.v_camera_cfg.DragParam
    min_eulery_val = drag_param_data[3]
    max_eulery_val = drag_param_data[4]
  end
  min_eulery_val = 360 + min_eulery_val
  if self.v_set_camera_pitch_angle_to_default then
    temp_vec3_00.x = default_init_angle_x
  end
  if temp_vec3_00.x < 180 and max_eulery_val < temp_vec3_00.x or temp_vec3_00.x > 180 and min_eulery_val > temp_vec3_00.x then
    temp_vec3_00.x = last_camera_euler.x
  else
    last_camera_euler.x, last_camera_euler.y, last_camera_euler.z = temp_vec3_00.x, temp_vec3_00.y, temp_vec3_00.z
  end
  if Global.hero and Global.joystick then
    if temp_vec3_00.x < 180 then
      temp_vec3_00.x = _lerp(temp_vec3_00.x, default_init_angle_x, self.v_move_correct_Lerp_y * self:get_dt())
    else
      local value = (360 - temp_vec3_00.x + default_init_angle_x) * self.v_move_correct_Lerp_y * self:get_dt()
      temp_vec3_00.x = temp_vec3_00.x + value
    end
  end
  temp_quat_00:SetEuler(temp_vec3_00:Get())
  temp_quat_00:MulVec3_NoneAlloc(Vec3.forward, temp_vec3_03)
  temp_vec3_03:Mul(self.v_cur_distance)
  local posx = focal_pos_x - temp_vec3_03.x
  local posy = focal_pos_y - temp_vec3_03.y
  local posz = focal_pos_z - temp_vec3_03.z
  return posx, posy, posz
end

function M:get_default_pos_in_shouldermode()
  local camera_euler_x, camera_euler_y, camera_euler_z = self.v_camera_transform:GetEulerAnglesA3()
  camera_euler_x = default_init_angle_x
  temp_quat_00:SetEuler(camera_euler_x, camera_euler_y, camera_euler_z)
  temp_quat_00:MulVec3_NoneAlloc(Vec3.forward, temp_vec3_00)
  temp_vec3_00:Mul(shoulder_camera_default_distance)
  local focal_pos_x, focal_pos_y, focal_pos_z = self.v_focal_point:GetPositionA()
  local posx = focal_pos_x - temp_vec3_00.x
  local posy = focal_pos_y - temp_vec3_00.y
  local posz = focal_pos_z - temp_vec3_00.z
  return posx, posy, posz
end

function M:set_camera_to_default_pos_in_shouldermode()
  if not self.v_char or not self.v_char.transform then
    return
  end
  local ry = self.v_char.transform:GetEulerY()
  Util.VEC3_TEMP:Set(default_init_angle_x, ry, 0)
  Util.QuatTemp:SetEuler(Util.VEC3_TEMP:Get())
  Util.QuatTemp:MulVec3_NoneAlloc(vec3.forward, Util.VEC3_TEMP)
  Util.VEC3_TEMP:SetNormalize()
  Util.VEC3_TEMP:Mul(shoulder_camera_default_distance)
  self.v_cur_distance = shoulder_camera_default_distance
  self.v_target_distance = shoulder_camera_default_distance
  local x, y, z = self.v_focal_point:GetPositionA()
  Util.VEC3_TEMP_1:Set(x, y, z)
  Util.VEC3_TEMP_1:Sub(Util.VEC3_TEMP)
  local posx, posy, posz = Util.VEC3_TEMP_1:Get()
  self:set_cam_postion(posx, posy, posz)
  self.v_camera_transform:LookAtA(x, y, z)
end

function M:get_default_pos_in_depression(camera_id, is_new_config)
  local camera_cfg = ShareRes.get_camera_cfg(camera_id, is_new_config)
  assert(camera_cfg, "No CameraId" .. self.v_camera_cfg_id)
  local camera_arm_distance = camera_cfg.DefaultDistance
  local fpos_x, fpos_y, fpos_z = self.v_focal_point:GetPositionA()
  local target_euler = Util.VEC2_TEMP
  target_euler.y = 0
  target_euler.x = 45 + (camera_cfg.DefaultXAngle or 0)
  if camera_cfg.CoordinateType == COORDINATETYPE.WORLD then
    target_euler.y = target_euler.y + (camera_cfg.DefaultYAngle or 0)
  elseif camera_cfg.CoordinateType == COORDINATETYPE.CHAR then
    target_euler.y = self.v_char_init_euler_y + (camera_cfg.DefaultYAngle or 0)
  elseif camera_cfg.CoordinateType == COORDINATETYPE.CHAR_DIR then
    target_euler.y = self.v_char_init_euler_y
  end
  self:_clamp_euler(target_euler)
  Util.QuatTemp:SetEuler(target_euler.x, target_euler.y, 0)
  Util.QuatTemp:MulVec3_NoneAlloc(Vec3.forward, forward_vec3)
  local delta_pos = forward_vec3:Mul(camera_arm_distance)
  local posx = fpos_x - delta_pos.x
  local posy = fpos_y - delta_pos.y
  local posz = fpos_z - delta_pos.z
  return posx, posy, posz
end

function M:_set_rotation(use_magic_vcam, x, y, z)
  if use_magic_vcam and 1 == self.v_magic_vcam.orientation_type then
    local qx, qy, qz, qw = self.v_magic_vcam.quat:Get()
    self.v_camera_transform:SetRotationA(qx, qy, qz, qw)
  else
    if self.v_focus_pos then
      x = self.v_focus_pos.x
      y = self.v_focus_pos.y
      z = self.v_focus_pos.z
    end
    self.v_camera_transform:LookAtA(x, y, z)
    local qx, qy, qz, qw = self.v_camera_transform:GetRotationA()
    temp_quat_00:Set(qx, qy, qz, qw)
    temp_quat_01:SetEuler(self.v_shake_rot:Get())
    Quat.Mul(temp_quat_00, temp_quat_01, temp_quat_00)
    self.v_camera_transform:SetRotationA(temp_quat_00:Get())
  end
end

function M:get_raw_shake_pos()
  return self.v_raw_shake_offset
end

function M:get_shake_pos(basex, basey, basez)
  if 0 ~= self.v_shake_pos.x or 0 ~= self.v_shake_pos.y or 0 ~= self.v_shake_pos.z then
    return basex + self.v_shake_pos.x, basey + self.v_shake_pos.y, basez + self.v_shake_pos.z, self.v_shake_pos.x, self.v_shake_pos.y, self.v_shake_pos.z
  else
    return basex, basey, basez, 0, 0, 0
  end
end

function M:_apply_rotation_and_distance(is_collider)
  if self.v_is_aimed then
    return
  end
  if self.v_is_face_npc then
    return
  end
  if self.v_camera_mode == CAMERA_VIEW_TYPE.SHOULDER then
    local ActiveVirtualCamera = self.v_cinemachinebrain.ActiveVirtualCamera
    if ActiveVirtualCamera then
      local name = ActiveVirtualCamera.gameObject.name
      if "vcamera" ~= name then
        if self.v_cinemachinebrain.IsBlending and "VirtualCamera" == name and self.v_camera_pos_before_enter_timeline then
          self:set_cam_postion(self.v_camera_pos_before_enter_timeline.x, self.v_camera_pos_before_enter_timeline.y, self.v_camera_pos_before_enter_timeline.z)
          self.v_camera_transform:SetRotationA(self.v_camera_rot_before_enter_timeline:Get())
        end
        if "VirtualCamera" == name then
          return
        end
      end
    else
      return
    end
    if self.v_should_blend_by_ourself then
      self:blend_by_ourself()
      return
    end
  end
  if self.v_is_camera_focusing_in_fpc then
    self:fpc_focusing()
    return
  end
  if self.v_is_camera_focusing_in_shoulder_mode then
    self:shoulder_camera_focusing()
    return
  end
  if self:new_blend_pass() then
    return
  end
  if self.v_focal_state == V_FOCAL_STATE.LOCK_TAR then
    if self.v_focus_effect then
      self.v_focus_effect:late_update()
    end
    return
  elseif self.v_focal_state == V_FOCAL_STATE.LOCK_HERO and self.v_camera_mode == CAMERA_VIEW_TYPE.DEPRESSION then
    self:update_focus_hero()
    return
  end
  local fpos_x, fpos_y, fpos_z = self.v_focal_point:GetPositionA()
  if not self.v_pinch_end_flag then
    self:_set_rotation(nil, fpos_x, fpos_y, fpos_z)
    Util.VEC3_TEMP:Set(self.v_camera_transform:GetPositionA())
    Util.VEC3_TEMP_1:Set(self.v_focal_point:GetPositionA())
    Util.VEC3_TEMP_1:Add(pinch_end_camera_offset)
    Vec3.LerpA(Util.VEC3_TEMP, Util.VEC3_TEMP_1, self:get_dt() * pinch_damping, Util.VEC3_TEMP)
    self:set_cam_postion(Util.VEC3_TEMP:Get())
    self.v_cur_fov = _lerp(self.v_cur_fov, self.v_pinch_fov_to or self.v_cur_fov, self:get_dt() * pinch_damping)
    self.v_cinimachine_vc:SetFov(self.v_cur_fov)
    return
  end
  local pos_offset
  local vcam = self.v_magic_vcam
  local use_magic_pos = self.v_camera_mode ~= CAMERA_VIEW_TYPE.SHOULDER and self.v_magic_pos_prop > 0 or false
  if use_magic_pos then
    pos_offset = vcam.offset
  end
  if self.v_magic_effect and not use_magic_pos and not self.v_stop_correct_time then
    self.v_stop_correct_time = STOP_CORRECT_TIME
    self.v_magic_effect = false
  end
  local posx, posy, posz
  if self.v_camera_mode == CAMERA_VIEW_TYPE.SHOULDER then
    posx, posy, posz = self:_get_base_pos_in_shoulderMode()
  elseif self.v_camera_mode == CAMERA_VIEW_TYPE.DEPRESSION then
    posx, posy, posz = self:_get_base_pos()
  end
  posy = posy + self.v_add_camera_pos_y
  if pos_offset then
    if vcam.follow_tar then
      if vcam.spline_cfg then
        vcam.spline:debug(posx, posy, posz)
      end
      posx, posy, posz = posx + pos_offset.x, posy + pos_offset.y, posz + pos_offset.z
    else
      local start_pos = vcam.start_pos
      if vcam.ease_out_ratio then
        self.v_magic_camera_pos.x = posx
        self.v_magic_camera_pos.y = posy
        self.v_magic_camera_pos.z = posz
        posx, posy, posz = self:get_new_pos_val(nil, self.v_magic_camera_pos, vcam.tar_pos, vcam.ease_out_ratio)
      else
        posx, posy, posz = start_pos.x + pos_offset.x, start_pos.y + pos_offset.y, start_pos.z + pos_offset.z
      end
    end
  end
  local use_magic_trans = self.v_camera_mode ~= CAMERA_VIEW_TYPE.SHOULDER and self.v_magic_trans_prop > self.v_scene_cam_prop or false
  if self.v_follow_target_type and 0 ~= self.v_follow_target_type and use_magic_trans then
    use_magic_trans = self.v_magic_vcam.force_handle_rotation
  end
  if not self.v_lerp_camera_pos_end and self.v_camera_cfg then
    local posx, posy, posz
    if self.v_camera_mode == CAMERA_VIEW_TYPE.DEPRESSION then
      posx, posy, posz = self:_get_base_pos()
    elseif self.v_camera_mode == CAMERA_VIEW_TYPE.SHOULDER then
      posx, posy, posz = self:_get_base_pos_in_shoulderMode()
    end
    self.v_vcamera_pos.x = posx
    self.v_vcamera_pos.y = posy
    self.v_vcamera_pos.z = posz
    local target_pos = self.v_vcamera_pos
    self:lerp_camera_pos_by_ordinary(target_pos, use_magic_trans, is_collider)
    return
  end
  if self.v_camera_mode == CAMERA_VIEW_TYPE.DEPRESSION and self.v_gear_height_max_val then
    local camera_height = posy - fpos_y
    local max_height = self.v_gear_height_max_val + self.v_battle_cam_height_limit_max
    local min_height = self.v_gear_height_min_val - self.v_battle_cam_height_limit_min
    local t = 1
    if camera_height > max_height then
      t = max_height / (camera_height + 1.0E-5)
    elseif camera_height < min_height then
      t = min_height / (camera_height + 1.0E-5)
    end
    local temp_x, temp_y, temp_z = Vec3.LerpD(fpos_x, fpos_y, fpos_z, posx, posy, posz, t)
    local max_distance = self.v_gear_distance_max_val + self.v_battle_cam_dist_limit_max
    local min_distance = self.v_gear_distance_min_val - self.v_battle_cam_dist_limit_min
    local camera_distance = Vec3.DistanceA(temp_x, temp_y, temp_z, fpos_x, fpos_y, fpos_z)
    t = 1
    if max_distance < camera_distance then
      t = max_distance / (camera_distance + 1.0E-5)
    elseif min_distance > camera_distance then
      t = min_distance / (camera_distance + 1.0E-5)
    end
    posx, posy, posz = Vec3.LerpD(fpos_x, fpos_y, fpos_z, temp_x, temp_y, temp_z, t)
  end
  local final_posx, final_posy, final_posz, dx, dy, dz = self:get_shake_pos(posx, posy, posz)
  self:set_cam_postion(final_posx, final_posy, final_posz)
  self:raw_set_pos(posx, posy, posz)
  self:_set_rotation(use_magic_trans, fpos_x + dx, fpos_y + dy, fpos_z + dz)
end

function M:check_camera_hit()
  if not self.v_camera_cfg then
    return {}
  end
  if not self.v_collision_effect then
    return {}
  end
  local hit_distance = self.v_collision_effect:get_camera_hit_distance()
  return hit_distance
end

function M:get_camera_collision_effect()
  return self.v_collision_effect
end

function M:update_min_hight(posx, posz)
  if Global.hero and self.v_camera_cfg and self.v_camera_mode ~= CAMERA_VIEW_TYPE.SHOULDER then
    local _, height = Util.raycast_by_role(Global.hero, posx, posz)
  end
end

function M:lerp_camera_pos_by_ordinary(target_pos, use_magic_trans, is_collider)
  local time = self:get_dt()
  self.v_lerp_camera_passed_time = self.v_lerp_camera_passed_time + time
  local lerp_val = 1
  if self.v_pinch_switch_cameramode_trigger then
    lerp_val = self.v_lerp_camera_passed_time / PINCH_SWITCH_CAMERAMODE_DURATION
  elseif (self.v_camera_cfg.SetCameraDuration or 0) > 0 then
    lerp_val = self.v_lerp_camera_passed_time / self.v_camera_cfg.SetCameraDuration
  end
  lerp_val = _min(lerp_val, 1)
  local focal_pos_x, focal_pos_y, focal_pos_z = self.v_focal_point:GetPositionA()
  temp_vec3_03:Set(focal_pos_x, focal_pos_y, focal_pos_z)
  if not self.v_temp_camera_pos then
    local camera_pos_x, camera_pos_y, camera_pos_z = self.v_camera_transform:GetPositionA()
    self.v_temp_camera_pos_vec3:Set(camera_pos_x, camera_pos_y, camera_pos_z)
    self.v_temp_camera_pos = self.v_temp_camera_pos_vec3
  end
  if not self.v_temp_focal_pos then
    self.v_temp_focal_pos_vec3:Set(focal_pos_x, focal_pos_y, focal_pos_z)
    self.v_temp_focal_pos = self.v_temp_focal_pos_vec3
  end
  if Vec3.SquareDistance(self.v_temp_camera_pos, target_pos) > 1.0E-4 then
    if not is_collider then
      Vec3.LerpA(self.v_temp_camera_pos, target_pos, lerp_val, self.v_temp_camera_pos)
      Vec3.LerpA(self.v_temp_focal_pos, temp_vec3_03, lerp_val, self.v_temp_focal_pos)
    else
      self.v_temp_camera_pos = target_pos
      self.v_temp_focal_pos:SetA(temp_vec3_03)
    end
    self.v_lerp_fov_start = Math.lerp_number(self.v_lerp_fov_start, self.v_camera_cfg.DefalutFOV, lerp_val)
    self.v_cur_fov = self.v_lerp_fov_start
    self.v_cinimachine_vc:SetFov(self.v_lerp_fov_start)
  else
    self.v_cinimachine_vc:SetFov(self.v_camera_cfg.DefalutFOV)
    self.v_cur_fov = self.v_camera_cfg.DefalutFOV
    self.v_lerp_camera_pos_end = true
  end
  local temp_focal_pos = self.v_temp_focal_pos
  local temp_camera_pos = self.v_temp_camera_pos
  local posx, posy, posz
  if self.v_camera_mode == CAMERA_VIEW_TYPE.SHOULDER then
    posx, posy, posz = temp_camera_pos.x, temp_camera_pos.y, temp_camera_pos.z
  else
    posx, posy, posz = temp_camera_pos.x, temp_camera_pos.y, temp_camera_pos.z
  end
  local final_posx, final_posy, final_posz, dx, dy, dz = self:get_shake_pos(posx, posy, posz)
  final_posy = final_posy + self.v_add_camera_pos_y
  self:set_cam_postion(final_posx, final_posy, final_posz)
  self.v_camera_transform:LookAtA(temp_focal_pos.x + dx, temp_focal_pos.y + dy, temp_focal_pos.z + dz)
  if self.v_lerp_camera_pos_end then
    self.v_focus_pos = nil
    self.v_temp_focal_pos = nil
    self.v_temp_camera_pos = nil
    if self.v_pinch_switch_cameramode_trigger then
      self.v_pinch_switch_cameramode_trigger = false
    end
    self.v_set_camera_pitch_angle_to_default = false
  end
end

function M:check_use_magic_pos(posx, posy, posz, is_follow)
  local pos_offset
  local vcam = self.v_magic_vcam
  local use_magic_pos = self.v_magic_pos_prop > 0
  if use_magic_pos then
    pos_offset = vcam.offset
  end
  if self.v_magic_effect and not use_magic_pos and not self.v_stop_correct_time then
    self.v_stop_correct_time = STOP_CORRECT_TIME
  end
  if pos_offset then
    if vcam.follow_tar and is_follow then
      posx, posy, posz = posx + pos_offset.x, posy + pos_offset.y, posz + pos_offset.z
    else
      local start_pos = vcam.start_pos
      if vcam.ease_out_ratio then
        self.v_magic_camera_pos.x = posx
        self.v_magic_camera_pos.y = posy
        self.v_magic_camera_pos.z = posz
        posx, posy, posz = self:get_new_pos_val(nil, self.v_magic_camera_pos, vcam.tar_pos, vcam.ease_out_ratio)
      else
        posx, posy, posz = start_pos.x + pos_offset.x, start_pos.y + pos_offset.y, start_pos.z + pos_offset.z
      end
    end
  end
  return posx, posy, posz, use_magic_pos
end

function M:_check_euler_val()
  if not self.v_camera_cfg then
    return
  end
  local pinch_type = self.v_camera_cfg.CameraPinchType
  if pinch_type ~= PINCH_TYPE.FREE then
    return
  end
  local pos_x = self.v_target_euler.x
  local target_x
  if pos_x < default_min_angle_x then
    target_x = default_min_angle_x
  elseif pos_x > default_max_angle_x then
    target_x = default_max_angle_x
  end
  if target_x then
    self.v_target_euler.x = _lerp(target_x, pos_x, 0.1)
  end
end

local temp_update_rotation_quat = Quat.New()

function M:_update_rotation()
  temp_update_rotation_quat:SetEuler(self.v_target_euler.x, self.v_target_euler.y, 0)
  local dt = GlobalTimeMgr:get_dt_time()
  local rotateSpeed = self.v_ease_in_speed
  if self.v_camera_mode == CAMERA_VIEW_TYPE.SHOULDER then
    if not self.v_swipe then
      rotateSpeed = self.v_cameraSpeed_on_characterMove
    elseif self.v_need_fix_rotation then
      self.v_cur_quat:Set(self.v_camera_transform:GetRotationA())
      self.v_need_fix_rotation = false
    end
  elseif self.v_camera_mode == CAMERA_VIEW_TYPE.DEPRESSION then
  end
  Quat.SlerpA(self.v_cur_quat, temp_update_rotation_quat, rotateSpeed * dt, self.v_cur_quat)
end

function M:_can_update_rotate()
  return true
end

function M:_is_in_swipe_protection()
  local time = self.v_swipe_protect_time
  if time and time > Global.real_time then
    return false
  end
  return true
end

function M:_calculate_rotate_speed(from_quat, to_quat)
  local angle = Quat.Angle(from_quat, to_quat)
  angle = _abs(self:_format_angle(angle))
  local speed = self:_get_speed_by_angle(angle)
  return speed
end

function M:_get_speed_by_angle(angle)
  angle = _clamp(_abs(angle), 0, 180)
  local min_angle, max_angle, min_speed, max_speed
  for i, ag in ipairs(self.v_angles) do
    if not min_angle or ag < angle then
      min_angle = ag
      min_speed = self.v_speeds[i]
    end
    if not max_angle or ag > angle then
      max_angle = ag
      max_speed = self.v_speeds[i]
    end
    if angle >= min_angle and angle <= max_angle then
      break
    end
  end
  if min_angle == max_angle then
    return min_angle
  end
  local value = _inverse_lerp(min_angle, max_angle, angle)
  local speed = _lerp(min_speed, max_speed, value)
  return speed
end

function M:on_touch_down()
  self.v_swipe_minus_distance = self.v_swipe_init_minus_distance
  self.v_click_time = Global.time
end

function M:on_touch_up()
  self.v_camera_move = false
  self.v_swipe_protect_time = Global.real_time + self.v_swipe_protect_duration
  if self.v_click_time then
    local click_time = Global.time - self.v_click_time
    local click_type = click_time > LONG_CLICK_TIME and OPERATION.POINT_CLICK or OPERATION.LONG_CLICK
    BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.ON_CAMERA_OPERATION, click_type, click_time)
  end
  if self.v_is_pinch then
    self.v_stop_correct_time = STOP_CORRECT_TIME
  end
  self.v_is_pinch = false
end

function M:check_click_time()
  if self.v_click_time then
    local click_time = Global.time - self.v_click_time
    if click_time > LONG_CLICK_TIME then
      BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.ON_CAMERA_OPERATION, OPERATION.LONG_CLICK, click_time)
    end
  end
end

function M:on_swipe(x, y)
  if not self.v_allow_rotation then
    return
  end
  self.v_target_euler.x = self.v_target_euler.x - y * self.v_swipe_rotation_y
  self.v_target_euler.y = self.v_target_euler.y + x * self.v_swipe_rotation_x
  self:_clamp_euler(self.v_target_euler)
  self.v_swipe = true
  self.v_swipe_protect_time = Global.real_time + self.v_swipe_protect_duration
  self:syncdata_to()
end

function M:check_camera_collider(hit_distance)
  if not self.v_camera_cfg then
    return
  end
  local check_collider = self.v_camera_cfg.CheckCollider
  if not check_collider or 0 == check_collider then
    return
  end
  if not Global.hero then
    return
  end
  local pinch_type = self.v_camera_cfg.CameraPinchType
  if pinch_type ~= PINCH_TYPE.FREE then
    return
  end
  self.v_last_camera_info[self.v_camera_cfg_id] = self.v_last_camera_info[self.v_camera_cfg_id] or {}
  local last_camera_info = self.v_last_camera_info[self.v_camera_cfg_id]
  local last_distance = last_camera_info and last_camera_info.camera_distance or self.v_camera_cfg.DefaultDistance
  if hit_distance <= 0 then
    self.v_correct_state = CORRECT_TYPE.COLLIDER
    last_distance = self.v_pinch_val and self.v_pinch_val or last_distance
    self.v_target_val = last_distance
    self.v_lerp_correct_val = self.v_pinch_distance
    return
  end
  self:stop_distance_correct()
  local target_distance = hit_distance
  if self.v_pinch_val then
    target_distance = math.min(target_distance, self.v_pinch_val)
  end
  self.v_is_collider = true
  self.v_target_distance = _clamp(target_distance - COLLIDER_DIS, 0.05, self.v_max_distance)
  self:update_cache_camera_info(nil, self.v_target_distance)
end

function M:on_pinch_start()
  self.v_begin_pinch = true
  self.v_pinch_switch_flag = false
  self.v_camera_pinch_switch_type_to = CAMERA_PINCH_SWITCH_TYPE_TO.NONE
  local min_distance, max_distance
  if self.v_camera_mode == CAMERA_VIEW_TYPE.SHOULDER then
    min_distance = self.v_min_distance
    max_distance = self.v_s2d_pinch_distance
  else
    min_distance = self.v_d2s_pinch_distance
    max_distance = self.v_max_distance
  end
  self.v_min_delta = min_distance - self.v_camera_cfg.DefaultDistance
  self.v_max_delta = max_distance - self.v_camera_cfg.DefaultDistance
  self.v_min_delta = 0 == self.v_min_delta and 0.01 or self.v_min_delta
  self.v_max_delta = 0 == self.v_max_delta and 0.01 or self.v_max_delta
  self.v_delta = 0
  local camera_pos_x, camera_pos_y, camera_pos_z = self.v_camera_transform:GetPositionA()
  local focal_pos_x, focal_pos_y, focal_pos_z = self.v_focal_point:GetPositionA()
  pinch_start_camera_offset:Set(camera_pos_x - focal_pos_x, camera_pos_y - focal_pos_y, camera_pos_z - focal_pos_z)
  MsgGame:mq_publish2(Const.MSG_ON_PINCH_SWITCH_CAMERA_BEGIN)
end

function M:on_pinch(delta)
  local can_pinch, message = self:check_camera_pinch()
  if not can_pinch then
    if message and Global.time - self.v_dbm_timestamp > dbm_interval then
      local ui_fight = UIMgr:try_get_ui("fight")
      if ui_fight then
        ui_fight:show_dbm_by_id(message, true)
        self.v_dbm_timestamp = Global.time
      end
    end
    return
  end
  if self.v_focal_state == V_FOCAL_STATE.LOCK_TAR then
    return
  end
  if self.v_pinch_end_flag then
    self.v_pinch_end_flag = false
    self:on_pinch_start()
  end
  delta = -delta
  local is_add = delta >= 0
  local camera_cfg = self.v_camera_cfg
  if not camera_cfg then
    return
  end
  local pinch_type = camera_cfg.CameraPinchType
  if pinch_type == PINCH_TYPE.GEAR then
    self:switch_camera_gear(is_add)
    return
  end
  self.v_stop_correct_time = nil
  self.v_is_pinch = true
  if 0 == delta then
    delta = 0
  elseif delta < self.v_pinch_limit_min and delta > -self.v_pinch_limit_min then
    delta = delta / _abs(delta) * self.v_pinch_limit_min
  elseif delta < self.v_pinch_limit_max and delta > -self.v_pinch_limit_max then
  else
    delta = delta / _abs(delta) * self.v_pinch_limit_max
  end
  self.v_delta = self.v_delta + delta * self.v_pinch_distance
  self.v_delta = _clamp(self.v_delta, self.v_min_delta, self.v_max_delta)
  local t
  if self.v_delta < 0 then
    t = self.v_delta / self.v_min_delta
    if t >= 1 then
      self.v_camera_pinch_switch_type_to = CAMERA_PINCH_SWITCH_TYPE_TO.SHOULDER
      MsgGame:mq_publish2(Const.MSG_ON_PINCH_SWITCH_CAMERA)
      local ui_fight = UIMgr:try_get_ui("fight")
      if ui_fight then
        ui_fight:show_dbm_by_id(28, true)
      end
    end
    local pos_x, pos_y, pos_z = self:get_default_pos_in_shouldermode()
    local focal_pos_x, focal_pos_y, focal_pos_z = self.v_focal_point:GetPositionA()
    Util.VEC3_TEMP:Set(pos_x - focal_pos_x, pos_y - focal_pos_y, pos_z - focal_pos_z)
    local camera_cfg = ShareRes.get_camera_cfg(CAMERA_SHOULDER_ID, false)
    self.v_pinch_fov_to = Math.lerp_number(self.v_cur_fov, camera_cfg.DefalutFOV, t)
    self.v_target_offset.y = Math.lerp_number(self.v_target_offset.y, self.v_camera_lookpoint_offset_y, t)
  else
    t = self.v_delta / self.v_max_delta
    if t >= 1 then
      self.v_camera_pinch_switch_type_to = CAMERA_PINCH_SWITCH_TYPE_TO.DEPRESSION
      MsgGame:mq_publish2(Const.MSG_ON_PINCH_SWITCH_CAMERA)
      local ui_fight = UIMgr:try_get_ui("fight")
      if ui_fight then
        ui_fight:show_dbm_by_id(27, true)
      end
    end
    local pos_x, pos_y, pos_z = self:get_default_pos_in_depression(self.v_last_camera_id, self.v_scene_camera_is_new_config)
    local focal_pos_x, focal_pos_y, focal_pos_z = self.v_focal_point:GetPositionA()
    Util.VEC3_TEMP:Set(pos_x - focal_pos_x, pos_y - focal_pos_y, pos_z - focal_pos_z)
    local camera_cfg = ShareRes.get_camera_cfg(self.v_last_camera_id, self.v_scene_camera_is_new_config)
    self.v_pinch_fov_to = Math.lerp_number(self.v_cur_fov, camera_cfg.DefalutFOV, t)
    self.v_target_offset.y = Math.lerp_number(self.v_target_offset.y, camera_cfg.DefaultYPOs or 0, t)
  end
  Vec3.LerpA(pinch_start_camera_offset, Util.VEC3_TEMP, t, pinch_end_camera_offset)
  Math.lerp_number(self.v_cur_fov, self.v_pinch_fov_to, t)
  self:update_cache_camera_info(nil, self.v_target_distance)
  if Global.env_mgr then
    Global.env_mgr:pinch_update()
  end
  self.v_check_pinch_time = CHECK_PINCH_TIME
  self:clear_focal()
  self:syncdata_to()
end

function M:on_pinch_end()
  if not self.v_begin_pinch then
    return
  end
  self.v_begin_pinch = false
  self.v_pinch_end_flag = true
  self.v_pinch_banner_tips_trigger = false
  self.v_lerp_camera_pos_end = false
  self.v_lerp_camera_passed_time = 0
  self.v_temp_camera_pos = nil
  self.v_temp_focal_pos = nil
  if self.v_camera_pinch_switch_type_to == CAMERA_PINCH_SWITCH_TYPE_TO.DEPRESSION then
    self:back_to_default_camera_id()
  elseif self.v_camera_pinch_switch_type_to == CAMERA_PINCH_SWITCH_TYPE_TO.SHOULDER then
    self:camera_switch_depression()
  end
  CSGameMgr.ResetCameraClipPlane(false)
  if self.v_camera_pinch_switch_type_to == CAMERA_PINCH_SWITCH_TYPE_TO.NONE then
    self.v_set_camera_pitch_angle_to_default = true
    self.v_target_offset.y = self.v_camera_cfg and self.v_camera_cfg.DefaultYPOs or 0
    self.v_need_lerp_fov = true
  else
    self.v_camera_pinch_switch_type_to = CAMERA_PINCH_SWITCH_TYPE_TO.NONE
  end
  MsgGame:mq_publish2(Const.MSG_ON_PINCH_SWITCH_CAMERA_END)
end

function M:_can_pinch_switch_cameramode()
  if self.v_lock_camera_mode then
    return
  end
  if not Util.is_client_only() and self.v_cur_room.room_cfg.IsBanShoulderCamera then
    return
  end
  return true
end

function M:refresh_room_state()
  if not TowerMgr then
    return
  end
  local tower = TowerMgr:get_tower()
  if not tower then
    return
  end
  local room = tower:get_room()
  if not room then
    return
  end
  self:check_switch_fight_camera()
end

function M:set_cam_pinch_switch(is_open)
  if is_open == self.v_is_in_fight and self.v_camera_mode == CAMERA_VIEW_TYPE.DEPRESSION then
    self:on_in_fight_state_changed(not is_open)
  end
  self.v_is_in_fight = not is_open
end

function M:on_in_fight_state_changed(is_in_fight)
  CSGameMgr.ResetCameraClipPlane(is_in_fight)
end

function M:set_camera_far_clip(value)
  CSGameMgr.SetCameraFarClipValue(value)
end

function M:reset_camera_far_clip()
  CSGameMgr.ResetCameraClipPlane(self.v_is_in_fight)
end

function M:check_switch_fight_camera()
  if Global.hero and not Global.hero:is_destroy() and Global.hero:can_update() then
    local is_scope_monster = Global.hero:check_scope_if_monster()
    if is_scope_monster then
      self:set_cam_pinch_switch(false)
    else
      self:set_cam_pinch_switch(true)
    end
  end
end

function M:camera_switch_depression()
  if self.v_is_in_fight then
    return
  end
  local depression_id = CAMERA_SHOULDER_ID
  if not depression_id or 0 == depression_id then
    return
  end
  if depression_id == self.v_camera_cfg_id then
    return
  end
  self.v_last_camera_info[depression_id] = nil
  self.v_target_val = nil
  self.v_pinch_val = nil
  self.v_temp_focal_pos = nil
  self.v_temp_camera_pos = nil
  self.v_pinch_switch_cameramode_trigger = true
  self.v_has_pinch_switch_cameramode = true
  self.v_camera_mode = CAMERA_VIEW_TYPE.SHOULDER
  CSGameMgr.IsOTS = true
  self:set_camera_id(depression_id, self.v_is_new_config, true)
  self.v_set_camera_pitch_angle_to_default = true
  self.v_target_distance = shoulder_camera_default_distance
  self.v_cur_distance = shoulder_camera_default_distance
  return true
end

function M:back_to_default_camera_id(is_force)
  local cur_scene_id = self.v_scene_camera_id
  if not cur_scene_id then
    return
  end
  if self.v_camera_cfg_id == cur_scene_id and not is_force then
    cur_scene_id = self.v_last_camera_id
    if self.v_camera_cfg_id == cur_scene_id then
      return
    end
  end
  self.v_pinch_switch_cameramode_trigger = true
  self.v_has_pinch_switch_cameramode = true
  self.v_temp_focal_pos = nil
  self.v_temp_camera_pos = nil
  self.v_last_camera_info[cur_scene_id] = nil
  self.v_camera_mode = CAMERA_VIEW_TYPE.DEPRESSION
  CSGameMgr.IsOTS = false
  self:set_camera_id(cur_scene_id, self.v_scene_camera_is_new_config, true)
  local camera_cfg = ShareRes.get_camera_cfg(cur_scene_id, self.v_scene_camera_is_new_config)
  assert(camera_cfg, "No CameraId" .. self.v_camera_cfg_id)
  self.v_target_distance = camera_cfg.DefaultDistance
  self.v_cur_distance = camera_cfg.DefaultDistance
  return true
end

function M:switch_camera_gear(is_add, is_init)
  if not is_init then
    self.v_camera_gear = is_add and self.v_camera_gear + 1 or self.v_camera_gear - 1
  end
  self.v_camera_gear = _clamp(self.v_camera_gear, CAMERA_GEAR.DOWN, CAMERA_GEAR.UP)
  self.v_correct_state = CORRECT_TYPE.GEAR
  self.v_lerp_correct_val = self.v_pinch_distance
  if self.v_camera_gear == CAMERA_GEAR.UP then
    self.v_target_val = self.v_gear_distance_max_val
    self.v_target_height = self.v_gear_height_max_val
  elseif self.v_camera_gear == CAMERA_GEAR.DEF then
    self.v_target_val = self.v_camera_cfg.DefaultDistance
    self.v_target_height = self.v_camera_cfg.DefaultHeight or 0
  elseif self.v_camera_gear == CAMERA_GEAR.DOWN then
    self.v_target_val = self.v_gear_distance_min_val
    self.v_target_height = self.v_gear_height_min_val
  end
  self:update_cache_camera_info(self.v_target_height, self.v_target_val)
end

local function set_old_shake_data(t, type, amplitude, atten, freq, now_time, duration, mutual)
  t.type = type
  t.amplitude = amplitude
  t.atten = atten
  t.freq = freq
  t.cycle = 1 / freq
  t.start_time = now_time
  t.end_time = duration + now_time
  t.mutual = mutual
  t.priority = 0
  t.life_time = duration
  t.duration = 0
end

local function copy_shake_preset_data(preset, cfg)
  for key, value in pairs(cfg) do
    if type(value) == "table" then
      for key2, param in pairs(value) do
        preset[key][key2] = param
      end
    else
      preset[key] = value
    end
  end
end

function M:shake(type, amplitude, atten, freq, duration, mutual)
  local now_time = GlobalTimeMgr:get_time()
  local data
  if self.v_shakes[mutual] and not self.v_shakes[mutual].preset then
    data = self.v_shakes[mutual]
    set_old_shake_data(data, type, amplitude, atten, freq, now_time, duration, mutual)
  else
    if self.v_shakes[mutual] then
      self:release_shake(self.v_shakes[mutual])
    end
    data = self:get_shake_data_from_pool(self.v_old_shake_data_stack)
    set_old_shake_data(data, type, amplitude, atten, freq, now_time, duration, mutual)
  end
  self.v_shakes[mutual] = data
end

function M:new_shake(preset_name, part, extend_param, mutual, source, priority, timescale_type)
  if (self.v_camera_mode == CAMERA_VIEW_TYPE.SHOULDER or self.v_camera_shake_type == Config.CAMERA_SHAKE_TYPE.OTS) and (2 == mutual or 3 == mutual) then
    return
  end
  local need_blend
  priority = priority or 0
  if self.v_shakes[mutual] then
    if priority < self.v_shakes[mutual].priority then
      return
    else
      need_blend = true
    end
  end
  local now_time = GlobalTimeMgr:get_time()
  local cfg = ShareRes.get_shake_preset_data(preset_name)
  assert(cfg, "缺少震屏配置:" .. preset_name)
  local data, preset, is_new
  if need_blend then
    data = self.v_shakes[mutual]
    if not data.preset then
      local temp_data, is_new = self:get_shake_data_from_pool(self.v_new_shake_data_stack)
      if is_new then
        preset = UtilTable.copy_table(cfg.presetPackages[part])
        temp_data.preset = preset
      end
      temp_data.shake_pos_x, temp_data.shake_pos_y, temp_data.shake_pos_z = data.shake_pos_x, data.shake_pos_y, data.shake_pos_z
      temp_data.shake_rot_x, temp_data.shake_rot_y, temp_data.shake_rot_z = data.shake_rot_x, data.shake_rot_y, data.shake_rot_z
      self:release_shake(data)
      self.v_shakes[mutual] = temp_data
      data = temp_data
    end
    preset = data.preset
  else
    data, is_new = self:get_shake_data_from_pool(self.v_new_shake_data_stack)
    if is_new then
      preset = UtilTable.copy_table(cfg.presetPackages[part])
      data.preset = preset
    else
      preset = data.preset
      copy_shake_preset_data(preset, cfg.presetPackages[part])
    end
  end
  if type(extend_param) == "table" then
    preset.positionStrength = extend_param[1]
    preset.orientationStrength = extend_param[2]
    preset.timeEnvelope.attack = extend_param[3]
    preset.timeEnvelope.sustain = extend_param[4]
    preset.timeEnvelope.decay = extend_param[5]
  end
  local is_scale_with_impact = preset.timeEnvelope.scaleWithImpact
  local duration, new_decay
  if is_scale_with_impact then
    Util.VEC3_TEMP:Set(preset.positionAmplitude[1], preset.positionAmplitude[2], preset.positionAmplitude[3])
    local pos_impact = Util.VEC3_TEMP:Magnitude() * preset.positionStrength
    Util.VEC3_TEMP:Set(preset.orientationAmplitude[1], preset.orientationAmplitude[2], preset.orientationAmplitude[3])
    local rot_impact = Util.VEC3_TEMP:Magnitude() * preset.orientationStrength
    new_decay = preset.timeEnvelope.decay * math.sqrt(math.max(pos_impact, rot_impact))
    duration = preset.timeEnvelope.attack + preset.timeEnvelope.sustain + new_decay
  else
    duration = preset.timeEnvelope.attack + preset.timeEnvelope.sustain + preset.timeEnvelope.decay
    new_decay = preset.timeEnvelope.decay
  end
  local char_euler_y = self:_format_angle(self.v_char.transform:GetEulerY())
  local camera_euler_y = self.v_camera_cfg and self.v_camera_cfg.DefaultYAngle or 0
  local delta_angle = 0
  if source then
    if source == Global.hero then
      delta_angle = camera_euler_y - char_euler_y
      delta_angle = delta_angle * deg2Rad
    else
      local source_pos_x, source_pos_z = source:get_pos2()
      local hero_pos_x, hero_pos_z = Global.hero:get_pos2()
      temp_vec2_00:Set(source_pos_x - hero_pos_x, source_pos_z - hero_pos_z)
      local euler_y = -Vec2.SignedAngleRaw(Vec2.up, temp_vec2_00:SetNormalize())
      delta_angle = (camera_euler_y - euler_y) * deg2Rad
    end
  end
  data.start_time = now_time
  data.end_time = duration + now_time
  data.duration = 0
  data.life_time = duration
  data.decay = new_decay
  data.source = source
  data.delta_angle = delta_angle
  data.priority = priority
  data.timescale_type = timescale_type
  data.mutual = mutual
  if need_blend then
    data.blend_flag = true
    data.blend_pos_x, data.blend_pos_y, data.blend_pos_z = self.v_shakes[mutual].shake_pos_x, self.v_shakes[mutual].shake_pos_y, self.v_shakes[mutual].shake_pos_z
    data.blend_rot_x, data.blend_rot_y, data.blend_rot_z = self.v_shakes[mutual].shake_rot_x, self.v_shakes[mutual].shake_rot_y, self.v_shakes[mutual].shake_rot_z
  else
    data.blend_flag = false
  end
  self.v_shakes[mutual] = data
end

function M:get_shake_data_from_pool(pool)
  local count = #pool
  local shake_data, is_new
  if count > 0 then
    shake_data = pool[count]
    table.remove(pool, count)
    is_new = false
  else
    shake_data = {}
    is_new = true
  end
  return shake_data, is_new
end

function M:release_shake(shake_data)
  if shake_data.preset then
    shake_data.ablation_flag = nil
    shake_data.blend_flag = nil
    table.insert(self.v_new_shake_data_stack, shake_data)
  else
    table.insert(self.v_old_shake_data_stack, shake_data)
  end
end

function M:stop_shake_by_mutual(mutual, need_fadeout)
  local shake_data = self.v_shakes[mutual]
  if not shake_data then
    return
  end
  if shake_data.preset and need_fadeout then
    shake_data.duration = 0
    shake_data.life_time = shake_data.preset.timeEnvelope.decay
    shake_data.ablation_flag = true
    shake_data.ablation_pos_x, shake_data.ablation_pos_y, shake_data.ablation_pos_z = self.v_shakes[mutual].shake_pos_x, self.v_shakes[mutual].shake_pos_y, self.v_shakes[mutual].shake_pos_z
    shake_data.ablation_rot_x, shake_data.ablation_rot_y, shake_data.ablation_rot_z = self.v_shakes[mutual].shake_rot_x, self.v_shakes[mutual].shake_rot_y, self.v_shakes[mutual].shake_rot_z
  else
    self:release_shake(shake_data)
    self.v_shakes[mutual] = nil
  end
end

function M:world_to_screen(x, y, z)
  return self.v_camera:WorldToScreenPointA(x, y, z)
end

function M:get_screen_wh()
  return self.v_camera.pixelWidth, self.v_camera.pixelHeight
end

function M:get_camera_obj()
  return self.v_camera_obj
end

function M:get_camera_trans()
  return self.v_camera_transform
end

function M:get_camera()
  return self.v_camera
end

local temp_forward = Vec3.Clone(Vec3.forward)
local temp_ret_vec3 = Vec3.New()

function M:camera_rotate(x, y, z)
  local camera_directionx, camera_directiony, camera_directionz = self.v_camera_transform:GetForwardA()
  if _abs(camera_directionx) <= 0.01 then
    camera_directionx = 0.01
  end
  camera_directiony = 0
  self.v_camera_rotate.x = camera_directionx
  self.v_camera_rotate.y = camera_directiony
  self.v_camera_rotate.z = camera_directionz
  temp_forward:SetA(Vec3.forward)
  temp_quat_00:SetFromToRotation(temp_forward, self.v_camera_rotate)
  self.v_joystick_pos.x = x
  self.v_joystick_pos.y = y
  self.v_joystick_pos.z = z
  temp_quat_00:MulVec3_NoneAlloc(self.v_joystick_pos, temp_ret_vec3)
  return temp_ret_vec3
end

function M:_clamp_euler(euler_angle)
  euler_angle.y = self:_format_angle(euler_angle.y)
  euler_angle.x = self:_format_angle(euler_angle.x)
end

function M:_format_angle(angle, min_val, max_val)
  min_val = min_val or -180
  max_val = max_val or 180
  while angle < min_val or angle > max_val do
    if angle < min_val then
      angle = angle + 360
    elseif max_val < angle then
      angle = angle - 360
    end
  end
  return angle
end

function M:_create_focal_point()
  local go = UnityGameObject()
  UnityGameObject.DontDestroyOnLoad(go)
  go.name = "_CameraFocalPoint"
  self.v_focal_point = go.transform
  self:_follow_target()
end

function M:raw_set_pos(x, y, z)
  self.v_posx = x
  self.v_posy = y
  self.v_posz = z
end

function M:reset_params()
  self.v_swipe_init_minus_distance = default_swipe_init_minus_distance
  self.v_swipe_rotation_x = default_swipe_rotation_x
  self.v_swipe_rotation_y = default_swipe_rotation_y
  self.v_angle_limit_to_y = default_angle_limit_to_y
  self.v_pinch_distance = default_pinch_distance
  self.v_min_angle_x = default_min_angle_x
  self.v_max_angle_x = default_max_angle_x
  self.v_init_angle_x = default_init_angle_x
  self.v_min_distance = default_min_distance
  self.v_max_distance = default_max_distance
  self.v_init_distance = default_init_distance
  self.v_zoom_smoothing = default_zoom_smoothing
  self.v_swipe_protect_duration = default_swipe_protect_duration
end

function M:get_forward()
  return Vec3.New(self.v_camera_transform:GetForwardA())
end

function M:get_forwardA()
  return self.v_camera_transform:GetForwardA()
end

function M:get_forward_xz()
  local x, _, z = self.v_camera_transform:GetForwardA()
  return Vec2.New(x, z):SetNormalize()
end

function M:get_right()
  return Vec3.New(self.v_camera_transform:getrightA())
end

function M:get_euler_angles()
  return self.v_camera_transform:GetEulerAnglesA3()
end

function M:get_min_angle_x()
  return self.v_min_angle_x
end

function M:get_max_angle_x()
  return self.v_max_angle_x
end

function M:syncdata_to()
  if not UNITY_EDITOR or not self.v_data_component then
    return
  end
  local data = {
    angle = self.v_target_euler,
    offset = self.v_target_offset,
    distance = self.v_target_distance,
    allowRotation = self.v_allow_rotation,
    allowZoom = self.v_allow_zoom
  }
  self.v_data_component:syncDataFromLua(data)
end

function M:syncdata_from(data)
  if not UNITY_EDITOR then
    return
  end
  if not data.allowZoom and not data.allowRotation then
    return
  end
  local angle = data.angle
  self.v_target_euler.x = angle.x
  self.v_target_euler.y = angle.y
  local offset = data.offset
  self.v_target_offset.x = offset.x
  self.v_target_offset.y = offset.y
  self.v_target_offset.z = offset.z
  self.v_allow_zoom = data.allowZoom
  self.v_allow_rotation = data.allowRotation
  self.v_target_distance = data.distance
end

function M:set_camera_id(camera_id, is_new_config, ban_set_cameramode, is_force_switch_cameramode, on_pre_set_camera_cfg)
  self.v_is_new_config = is_new_config
  if not ban_set_cameramode then
    if true == is_force_switch_cameramode then
      self.v_lock_camera_mode = is_force_switch_cameramode
      local camera_cfg = ShareRes.get_camera_cfg(camera_id, is_new_config)
      if 3 == camera_cfg.CameraViewType then
        self.v_camera_mode = CAMERA_VIEW_TYPE.DEPRESSION
        self.v_is_first_person_camera = true
      elseif not Util.is_client_only() and self.v_cur_room.room_cfg.IsBanShoulderCamera then
        self.v_camera_mode = CAMERA_VIEW_TYPE.DEPRESSION
      elseif 2 == camera_cfg.CameraViewType then
        self.v_camera_mode = CAMERA_VIEW_TYPE.SHOULDER
      elseif 1 == camera_cfg.CameraViewType then
        self.v_camera_mode = CAMERA_VIEW_TYPE.DEPRESSION
      end
    else
      self:set_cameramode_by_camera_id(camera_id, is_new_config)
    end
  end
  if self.v_camera_mode == CAMERA_VIEW_TYPE.SHOULDER then
    self.v_camera_cfg_id = CAMERA_SHOULDER_ID
    self.v_scene_camera_id = CAMERA_SHOULDER_ID
    self.v_camera_cfg = ShareRes.get_camera_cfg(CAMERA_SHOULDER_ID, false)
  else
    self.v_camera_cfg_id = camera_id
    self.v_scene_camera_id = camera_id
    self.v_camera_cfg = ShareRes.get_camera_cfg(camera_id, is_new_config)
  end
  self.v_lerp_camera_pos_end = false
  self.v_lerp_camera_passed_time = 0
  self:set_focus_hero_lerp_state()
  self.v_temp_focal_pos = nil
  self.v_temp_camera_pos = nil
  self.v_lerp_fov_start = self.v_cur_fov
  if TowerMgr then
    TowerMgr:cache_fight_camera_info(camera_id)
  end
  self:stop_distance_correct()
  self:init_camera_info(nil, on_pre_set_camera_cfg)
end

function M:get_view_type()
  return self.v_camera_mode
end

function M:set_camera_focal_state(state)
  self.v_focal_state = state
end

function M:set_camera_focal(npc, attach_name, force)
  if not self.v_focus_effect:set_camera_focal(npc, attach_name, force) then
    return false
  end
  self.v_force_locking = force
  self.v_focal_state = V_FOCAL_STATE.LOCK_TAR
  self:stop_distance_correct()
  local cur_euler_x, cur_euler_y, _ = self.v_camera_transform:GetEulerAnglesA3()
  self.v_target_euler.x = cur_euler_x
  self.v_target_euler.y = cur_euler_y
  self.v_cur_quat:SetEuler(cur_euler_x, cur_euler_y, 0)
  self:set_focus_hero_lerp_state(nil, true)
  self.v_temp_focal_pos = nil
  self.v_temp_camera_pos = nil
  return true
end

function M:set_camera_focal_by_pos(x, y, z)
  if not self.v_focus_effect:set_camera_focal_by_pos(x, y, z) then
    return false
  end
  self.v_force_locking = true
  self.v_focal_state = V_FOCAL_STATE.LOCK_TAR
  self:stop_distance_correct()
  local cur_euler_x, cur_euler_y, _ = self.v_camera_transform:GetEulerAnglesA3()
  self.v_target_euler.x = cur_euler_x
  self.v_target_euler.y = cur_euler_y
  self.v_cur_quat:SetEuler(cur_euler_x, cur_euler_y, 0)
  self:set_focus_hero_lerp_state(nil, true)
  self.v_temp_focal_pos = nil
  self.v_temp_camera_pos = nil
  return true
end

function M:set_camera_focal_in_shoulder_mode(follow_target_type, param)
  if 0 == follow_target_type or 4 == follow_target_type then
    self.v_is_camera_focusing_in_shoulder_mode = false
    self:trigger_new_blend_pass(self.v_shoulder_mode_focusing_duration)
  else
    local target = param[7]
    local pos = param[8]
    if not param[9] or 0 == param[9] then
      self.v_camera_focusing_mode = CAMERA_FOCUS_MODE.MIDDLE_OF_TARGET_AND_CHAR
    elseif 1 == param[9] then
      self.v_camera_focusing_mode = CAMERA_FOCUS_MODE.TARGET
    end
    if target or pos then
      self.v_is_camera_focusing_in_shoulder_mode = true
      self.v_is_camera_focusing_in_shoulder_mode_duration = 0.0
      self.v_camera_focusing_pos:Set(self.v_camera_transform:GetPositionA())
      self.v_camera_focusing_ort:Set(self.v_camera_transform:GetRotationA())
      if target then
        self.v_focusing_pos:Set(target:get_pos())
      else
        self.v_focusing_pos:Set(pos.x, pos.y, pos.z)
      end
    else
      Log.Error("target and pos are all nil")
    end
  end
end

function M:set_camera_focal_in_fpc(follow_target_type, param)
  if 0 == follow_target_type then
    self.v_is_camera_focusing_in_fpc = false
  else
    local target = param[7]
    local pos = param[8]
    self.v_fpc_focusing_pos = self.v_fpc_focusing_pos or Vec3.New()
    self.v_fpc_focusing_rot = self.v_fpc_focusing_rot or Quat.New()
    if target then
      self.v_fpc_focusing_pos:Set(target:get_pos())
    else
      self.v_fpc_focusing_pos:Set(pos.x, pos.y, pos.z)
    end
    self.v_fpc_cur_focusing_duration = 0
    self.v_is_camera_focusing_in_fpc = true
  end
end

local fpc_focusing_duration = ShareRes.get_comm_value("FPCFocusingDuration")

function M:fpc_focusing()
  local focal_point_raw_x, focal_point_raw_y, focal_point_raw_z = self.v_focal_point:GetPositionA()
  temp_vec3_00:SetA(self.v_fpc_focusing_pos)
  temp_vec3_01:Set(focal_point_raw_x, focal_point_raw_y, focal_point_raw_z)
  temp_vec3_00:Sub(temp_vec3_01)
  temp_vec3_01:Set(0, 1, 0)
  Quat.LookRotationA(temp_vec3_00, temp_vec3_01, temp_quat_00)
  temp_quat_00:ToEulerAngles2(temp_vec3_00)
  temp_quat_01:Set(self.v_camera_transform:GetRotationA())
  local t = 1
  if self.v_fpc_cur_focusing_duration < fpc_focusing_duration then
    t = ease_helper.ease_in_out_Cubic(self.v_fpc_cur_focusing_duration / fpc_focusing_duration)
    self.v_fpc_cur_focusing_duration = self.v_fpc_cur_focusing_duration + self:get_dt()
  end
  Quat.SlerpA(temp_quat_01, temp_quat_00, t, temp_quat_00)
  self.v_target_euler.x = temp_vec3_00.x
  self.v_target_euler.y = temp_vec3_00.y
  local posx, posy, posz = self:_get_base_pos()
  self:set_cam_postion(posx, posy, posz)
  self.v_camera_transform:SetRotationA(temp_quat_00:Get())
end

function M:clear_focal()
  if not self.v_focal_state or self.v_focal_state == V_FOCAL_STATE.LOCK_HERO then
    return
  end
  self.v_focus_effect:clear_focal()
  self.v_force_locking = nil
  self.v_focal_state = nil
  self.v_cache_len = nil
  if self.v_focus_hero_effect then
    self.v_focus_hero_effect:init_data(self.v_focus_pos)
  end
  self.v_lerp_camera_pos_end = false
  self.v_lerp_camera_passed_time = 0
  self:set_focus_hero_lerp_state()
end

function M:sync_camera_focus_pos(focus_pos)
  self.v_focus_pos = focus_pos
end

function M:check_use_magic_trans()
  return self.v_magic_trans_prop > 0 or self.v_magic_pos_prop > 0
end

function M:back_to_scene_camera(is_reduction, is_reconnect)
  if is_reconnect then
    return
  end
  self.v_camera_cfg_id = self.v_scene_camera_id or self.v_camera_cfg_id
  if TowerMgr then
    TowerMgr:clear_cache_fight_camera_info()
  end
  self:init_camera_info()
  self.v_ease_in_speed = self.v_last_ease_in_speed or 1
  self.v_focus_effect:clear_focal()
  self.v_focal_state = nil
  self:_follow_target()
  self.v_lerp_camera_pos_end = false
  self.v_lerp_camera_passed_time = 0
  self.v_cache_len = nil
  self.v_focus_pos = nil
  if not is_reduction then
    local cur_euler_x, cur_euler_y = self:get_euler_angles()
    self.v_target_euler.x = cur_euler_x
    self.v_target_euler.y = cur_euler_y
    self.v_cur_quat = Quat.Euler(cur_euler_x, cur_euler_y, 0)
  end
  local pos_x, pos_y, pos_z = self.v_camera_transform:GetPositionA()
  self.v_temp_focal_pos = self.v_temp_focal_pos or self.v_temp_focal_pos_vec3
  self.v_temp_camera_pos = self.v_temp_camera_pos or self.v_temp_camera_pos_vec3
  self.v_temp_focal_pos:Set(pos_x, pos_y, pos_z)
  self.v_temp_camera_pos:Set(pos_x, pos_y, pos_z)
end

function M:on_refresh_touch_effect(is_effect)
  self.v_touch_effect = is_effect
end

function M:set_click_swip_camera(is_swip)
  self.v_is_click_swip = is_swip
end

function M:check_click_swip()
  return self.v_is_click_swip
end

function M:stop_touch_swip(is_stop_swip)
  self.v_is_stop_swip = is_stop_swip
end

function M:check_touch_swipe()
  if not self.v_camera_cfg then
    return
  end
  if self.v_is_stop_swip or self.v_ignore_cur_swipe then
    return
  end
  if self.v_camera_mode == CAMERA_VIEW_TYPE.SHOULDER and self.v_force_locking then
    return
  end
  if StoryMgr and StoryMgr:is_playing_story() and not StoryMgr:check_cur_step_captions_talk() then
    return
  end
  if self.v_cinemachinebrain.IsBlending or self.v_should_blend_by_ourself then
    return
  end
  return true
end

function M:on_touch_swipe(x, y)
  if not self:check_touch_swipe() then
    return
  end
  if not self.v_swipe then
    self.v_need_fix_rotation = true
  end
  self.v_swipe = true
  if self.v_camera_mode == CAMERA_VIEW_TYPE.SHOULDER then
    self:camera_rotation(x, y)
  elseif self.v_camera_mode == CAMERA_VIEW_TYPE.DEPRESSION then
    if self.v_is_first_person_camera then
      self:camera_rotation(x, y)
    elseif BattleSettingMgr:get_depression_mode_rotate() == Config.SETTING.CAMERA_DEPRESSION_MODE_ROTATE.ON then
      self:camera_rotation(x, 0)
    end
  end
  self.v_click_time = nil
  BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.ON_CAMERA_OPERATION, OPERATION.SWIP)
end

function M:on_touch_swipe_end(swipe_direction)
  self.v_swipe = false
  self.v_need_fix_rotation = false
  self.v_ignore_cur_swipe = false
  local msg = MsgGame:mq_publish2(Const.MSG_ON_PINCH_SWIPE_CAMERA_END)
  msg.mm_x = swipe_direction
end

function M:camera_rotation(x, y)
  local drag_param_data = self.v_camera_cfg.DragParam
  if not drag_param_data or 0 == #drag_param_data then
    drag_param_data = default_DragParam
  end
  local horizontal_val = drag_param_data[1]
  local vertical_val = drag_param_data[2]
  local min_eulery_val = drag_param_data[3] or 15
  local max_eulery_val = drag_param_data[4] or 65
  self.v_ease_in_speed = drag_param_data[5] or 1
  local sensitivity = 1
  if not Util.is_client_only() then
    sensitivity = BattleSettingMgr:get_swipe_camera_sensitivity()
  end
  local rotation_x = y * horizontal_val * sensitivity
  local rotation_y = x * vertical_val * sensitivity
  if self.v_is_aimed then
    if not Global.hero then
      self:close_camera_aimed()
      return
    end
    local aimed_speed = self.v_camera_cfg.AimedSpeed or 0.5
    rotation_x = rotation_x * aimed_speed
    rotation_y = rotation_y * aimed_speed
    if self.v_aimed_effect then
      self.v_aimed_effect:update_aimed_pos(rotation_x, rotation_y)
    end
    return
  end
  if self.v_need_fix_rotation then
    local cur_euler_x, cur_euler_y = self.v_camera_transform:GetEulerAnglesA3()
    self.v_target_euler.x = cur_euler_x
    self.v_target_euler.y = cur_euler_y
  end
  self.v_target_euler.x = self.v_target_euler.x - rotation_x
  self.v_target_euler.y = self.v_target_euler.y + rotation_y
  self:_swipe_clamp_euler(self.v_target_euler, min_eulery_val, max_eulery_val)
end

function M:_swipe_clamp_euler(euler_angle, min_eulery_val, max_eulery_val)
  euler_angle.y = self:_format_angle(euler_angle.y)
  euler_angle.x = self:_format_angle(euler_angle.x)
  euler_angle.x = _clamp(euler_angle.x, min_eulery_val, max_eulery_val)
end

function M:camera_move(x, y)
  local drag_param_data = self.v_camera_cfg.DragParam
  local horizontal_val = drag_param_data[1]
  local vertical_val = drag_param_data[2]
  self.v_camera_move = true
  self.v_back_val = self.v_camera_cfg.DragParam[3]
  local add_x = horizontal_val * x
  local add_y = vertical_val * y
  add_x, add_y = self:_clamp_pos(add_x, add_y)
  self.v_cache_move_pos.x = self.v_cache_move_pos.x + add_x
  self.v_cache_move_pos.y = self.v_cache_move_pos.y + add_y
end

function M:_clamp_pos(add_x, add_y)
  local screen_width = CSScreen.width
  local screen_height = CSScreen.height
  local x, y, z = self.v_char.transform:GetPositionA()
  local camera_pos_x, camera_pos_y, camera_pos_z = self.v_camera_transform:GetPositionA()
  self:set_cam_postion(camera_pos_x + add_x, camera_pos_y, camera_pos_z + add_y)
  local point_pos = self:world_to_screen(x, y, z)
  if point_pos.x <= Diff_val or point_pos.x >= screen_width - Diff_val or point_pos.y <= Diff_val or point_pos.y >= screen_height - Diff_val then
    add_x = 0
    add_y = 0
  end
  return add_x, add_y
end

function M:update_focus_hero()
  if not self.v_focus_hero_effect then
    return
  end
  self.v_focus_hero_effect:update_focus_hero()
end

function M:apply_camera_pos(pos_x, pos_y, pos_z, focal_pos_x, focal_pos_y, focal_pos_z, is_lerp, is_lookat)
  local camera_pos_x, camera_pos_y, camera_pos_z = self.v_camera_transform:GetPositionA()
  local use_magic_pos = self.v_magic_pos_prop > 0
  local new_x, new_y, new_z = self:check_use_magic_pos(pos_x, pos_y, pos_z, true)
  if is_lerp then
    new_x = _lerp(camera_pos_x, new_x, 0.1)
    new_y = _lerp(camera_pos_y, new_y, 0.1)
    new_z = _lerp(camera_pos_z, new_z, 0.1)
  end
  self:set_cam_postion(new_x, new_y, new_z)
  if not is_lerp or is_lookat then
    if use_magic_vcam then
      self.v_camera_transform:SetRotationA(self.v_magic_vcam.quat:Get())
    else
      self.v_camera_transform:LookAtA(focal_pos_x, focal_pos_y, focal_pos_z)
    end
  end
end

function M:gm_print_info()
  Global.log.Debug("当前相机id是：", self.v_camera_cfg_id)
  local cur_dis = Vec3.Distance(self.v_focal_point.position, self.v_camera_transform.position)
  Global.log.Debug("当前相机到焦点的距离是：", cur_dis)
  Global.log.Debug("当前角色到焦点的距离是：" .. Vec3.Distance(self.v_focal_point.position, Global.hero:get_pos_vec3()))
  if self.v_focus_pos then
    cur_dis = Vec3.Distance(self.v_focal_point.position, self.v_focus_pos)
    Global.log.Debug("当前角色到焦点的距离是：", cur_dis)
  end
end

function M:get_magic_vcam()
  return self.v_magic_vcam
end

function M:get_camera_id()
  return self.v_camera_cfg_id
end

function M:set_blur_focus(radius, iteration, downScaling, time)
  if not self.v_blur_focus_effect then
    return
  end
  self.v_blur_focus_effect:set_blur_focus(radius, iteration, downScaling, time)
end

function M:stop_distance_correct()
  if self.v_correct_state == CORRECT_TYPE.CHANGE_FOCUS then
    return
  end
  self.v_correct_state = CORRECT_TYPE.NONE
  self.v_correct_time = 0
  self.v_stop_correct_time = nil
end

function M:check_camera_pinch()
  local camera_cfg = self.v_camera_cfg
  if not camera_cfg then
    return
  end
  if self.v_is_aimed then
    return
  end
  if StoryMgr and StoryMgr:is_playing_story() and not StoryMgr:check_cur_step_captions_talk() then
    return
  end
  if self.v_is_in_fight then
    return false, PINCH_FAIL_MESSAGE.PINCH_IN_FIGHT
  end
  if not self:_can_pinch_switch_cameramode() then
    return false, PINCH_FAIL_MESSAGE.PINCH_IN_PENALTY_AREA
  end
  if self.v_follow_target_type and 0 ~= self.v_follow_target_type or self.v_is_camera_focusing_in_shoulder_mode then
    return false, PINCH_FAIL_MESSAGE.PINCH_IN_FOCUS
  end
  if not self.v_lerp_camera_pos_end then
    return
  end
  if not Util.is_client_only() and BattleSettingMgr:get_camera_pinch_type() == Config.SETTING.CAMERA_PINCH_TYPE.CLOSE then
    return
  end
  return true
end

function M:atk_correct_distance()
  if not self:check_camera_pinch() then
    return
  end
  if not self.v_camera_cfg.IsCorrect then
    return
  end
  if self.v_camera_cfg.CameraPinchType ~= PINCH_TYPE.FREE then
    return
  end
  self.v_correct_start_time = os.time()
  self.v_correct_time = 0
  local correct_val = _max(_abs(self.v_atk_default_distacne - self.v_target_distance) * self.v_atk_correct_val, self.v_atk_correct_min_val)
  self.v_correct_state = CORRECT_TYPE.ATK
  local is_add = self.v_atk_default_distacne > self.v_target_distance
  local frame = self.v_atk_correct_time / Config.LOGIC_FRAME
  local lerp_val = correct_val / frame
  self.v_lerp_correct_val = lerp_val
  self.v_target_val = is_add and self.v_target_distance + correct_val or self.v_target_distance - correct_val
  self.v_target_val = _clamp(self.v_target_val, self.v_atk_correct_min_val, self.v_atk_default_distacne)
  self:correct_camera_distance()
end

function M:move_correct_distance()
  if not self:check_camera_pinch() then
    return
  end
  if self.v_correct_state == CORRECT_TYPE.MOVE then
    return
  end
  if not self.v_camera_cfg.IsCorrect then
    return
  end
  if self.v_camera_cfg.CameraPinchType ~= PINCH_TYPE.FREE then
    return
  end
  self.v_correct_state = CORRECT_TYPE.MOVE
  self:correct_camera_distance()
end

function M:move_correct_distance_on_shouldermode()
  if not self.v_camera_cfg then
    return
  end
  if not self.v_is_collider then
    self.v_target_distance = _lerp(self.v_target_distance, self.v_camera_cfg.DefaultDistance, 10.0 * self:get_dt())
  else
    self.v_target_distance = _min(self.v_target_distance, self.v_camera_cfg.DefaultDistance)
  end
end

function M:disable_camera_distance_correct(is_disable)
  self.v_disable_camera_distance_correct = is_disable
end

function M:correct_camera_distance()
  if self.v_camera_mode == CAMERA_VIEW_TYPE.SHOULDER then
    return
  end
  if self.v_disable_camera_distance_correct then
    return
  end
  if not self:check_camera_pinch() and (not self.v_follow_target_type or 0 == self.v_follow_target_type) then
    return
  end
  if not self.v_target_val or not self.v_lerp_correct_val then
    return
  end
  if not self.v_correct_state or self.v_correct_state == CORRECT_TYPE.NONE then
    return
  end
  if self.v_stop_correct_time and self.v_stop_correct_time > 0 then
    self.v_stop_correct_time = self.v_stop_correct_time - self:get_dt()
    return
  else
    self.v_stop_correct_time = nil
  end
  if self.v_target_height and _abs(self.v_camera_height - self.v_target_height) <= 0.01 and (self.v_target_val and _abs(self.v_target_distance - self.v_target_val)) <= 0.01 then
    return
  end
  if self.v_is_pinch then
    return
  end
  self.v_correct_time = self.v_correct_time + self:get_dt()
  if self.v_correct_state == CORRECT_TYPE.ATK and self.v_correct_time >= self.v_atk_correct_time then
    self:stop_distance_correct()
    return
  end
  self.v_target_distance = _lerp(self.v_target_distance, self.v_target_val, self.v_lerp_correct_val)
  if self.v_target_height then
    self.v_camera_height = _lerp(self.v_camera_height, self.v_target_height, self.v_lerp_correct_val)
  end
  self:update_cache_camera_info(self.v_camera_height, self.v_target_distance)
end

function M:update_cache_camera_info(camera_height, camera_distance)
  if not self.v_camera_cfg_id then
    return
  end
  self.v_last_camera_info[self.v_camera_cfg_id] = self.v_last_camera_info[self.v_camera_cfg_id] or {}
  local last_camera_info = self.v_last_camera_info[self.v_camera_cfg_id]
  last_camera_info.camera_height = camera_height or last_camera_info.camera_height
  last_camera_info.camera_distance = camera_distance or last_camera_info.camera_distance
end

function M:set_cam_postion(x, y, z)
  if x ~= x or y ~= y or z ~= z then
    Log.Error("x = ", x, y, z, debug.traceback())
    Global.log.Debug("self.v_cur_quat = ", self.v_cur_quat, self.v_target_euler)
    return
  end
  self.v_camera_transform:SetPositionA(x, y, z)
end

function M:get_dt()
  return GlobalTimeMgr:get_dt_time()
end

function M:check_camera_aimed()
  return self.v_is_aimed
end

function M:open_camera_aimed()
  if not self.v_camera_cfg then
    return
  end
  self.v_lerp_camera_pos_end = true
  self.v_lerp_camera_passed_time = 0
  self.v_is_aimed = true
  self.v_aimed_effect:open_camera_aimed()
end

function M:close_camera_aimed()
  if not self.v_is_aimed then
    return
  end
  if self.v_aimed_effect then
    self.v_aimed_effect:close_camera_aimed()
  end
  local pos = self.v_camera_transform.position
  self.v_temp_focal_pos = pos
  self.v_temp_camera_pos = pos
  self.v_focus_pos = pos + self.v_camera_transform.forward * 5
  self:set_cam_postion(pos.x, pos.y, pos.z)
  self.v_camera_transform:SetParent(nil)
  local cur_euler_x, cur_euler_y = self:get_euler_angles()
  self.v_target_euler.x = cur_euler_x
  self.v_target_euler.y = cur_euler_y
  self.v_cur_quat = Quat.Euler(cur_euler_x, cur_euler_y, 0)
  self.v_lerp_camera_pos_end = false
  self.v_lerp_camera_passed_time = 0
  self:set_focus_hero_lerp_state()
  self.v_is_aimed = false
end

function M:set_strength_ui_visible(is_show)
  if not self.v_aimed_effect then
    return
  end
  self.v_aimed_effect:set_strength_ui_visible(is_show)
end

function M:camera_aimed_follow_hero()
  if not self.v_camera_cfg then
    return
  end
  if not self.v_aimed_effect then
    return
  end
  self.v_aimed_effect:camera_aimed_follow_hero()
end

function M:get_camera_forward_pos()
  local camera_pos = Vec3.New(self.v_camera_transform:GetPositionA())
  local dx, dy, dz = self.v_camera_transform:GetForwardA()
  camera_pos:Add1(dx * 100, dy * 100, dz * 100)
end

function M:get_aimed_camera_angle()
  if not self.v_is_aimed then
    return
  end
  if not self.v_aimed_effect then
    return
  end
  local pos_x, pos_y = self.v_aimed_effect:get_aimed_pos()
  return _floor(pos_x)
end

function M:set_focal_point(tarpos_x, tarpos_y, tarpos_z)
  self.v_focal_point:SetPositionA(tarpos_x, tarpos_y, tarpos_z)
end

function M:get_camera_mode()
  return self.v_camera_mode
end

function M:get_camera_shake_type()
  return self.v_camera_shake_type
end

function M:lock_camera_mode(value)
  self.v_lock_camera_mode = value
end

function M:is_first_person_camera()
  return self.v_is_first_person_camera
end

function M:update_skill_indicator_pos(x, y, z)
  if not self.v_is_skill_indicator_pos then
    return
  end
  local cur_pos = self.v_start_skill_indic_pos
  x = x or 0
  y = y or 0
  z = z or 0
  if not self.v_target_test_pos then
    self.v_target_test_pos = Vec3.New(cur_pos.x, cur_pos.y, cur_pos.z)
  end
  local target_pos = self.v_target_test_pos
  local dev_val = self.v_skill_indicator_parms.dev_val
  local target_x = cur_pos.x + x * dev_val
  local target_y = cur_pos.y + y * dev_val
  local target_z = cur_pos.z + z * dev_val
  local speed = self.v_skill_indicator_parms.move_speed
  self.v_target_test_pos.x = _lerp(target_pos.x, target_x, speed)
  self.v_target_test_pos.y = _lerp(target_pos.y, target_y, speed)
  self.v_target_test_pos.z = _lerp(target_pos.z, target_z, speed)
  self.v_focal_point:SetPositionA(target_pos.x, target_pos.y, target_pos.z)
end

function M:close_skill_indicator_pos()
  self.v_is_skill_indicator_pos = false
  self.v_skill_indicator_parms = nil
  self.v_target_test_pos = nil
end

function M:set_skill_indicator_pos_info(parms)
  if not parms.is_open then
    self.v_target_follow_speed = parms.back_speed
    self:close_skill_indicator_pos()
    return
  end
  if not self.v_is_skill_indicator_pos then
    self.v_start_skill_indic_pos = self.v_focal_point.position
  end
  self.v_is_skill_indicator_pos = true
  self.v_skill_indicator_parms = parms
end

function M:face_npc()
  if not self.v_is_face_npc then
    return
  end
  local camera_position_x, camera_position_y, camera_position_z = self.v_camera_transform:GetPositionA()
  local camera_posx = camera_position_x
  local camera_posy = camera_position_y
  local camera_posz = camera_position_z
  local target_x = self.v_npc_target_pos.x
  local target_y = self.v_npc_target_pos.y
  local target_z = self.v_npc_target_pos.z
  local pos_x = Math.lerp_number(camera_posx, target_x, self.v_fixed_lerp_speed)
  local pos_y = Math.lerp_number(camera_posy, target_y, self.v_fixed_lerp_speed)
  local pos_z = Math.lerp_number(camera_posz, target_z, self.v_fixed_lerp_speed)
  self:set_cam_postion(pos_x, pos_y, pos_z)
  local npc_x = self.v_npc_pos_x
  local npc_y = self.v_npc_pos_y
  local npc_z = self.v_npc_pos_z
  self.v_camera_transform:LookAtA(npc_x, npc_y, npc_z)
  self:raw_set_pos(pos_x, pos_y, pos_z)
  local dis = Math.distance(camera_posx, camera_posy, camera_posz, target_x, target_y, target_z)
  if dis < 0.2 and not self.v_is_reach_target_pos then
    self.v_is_reach_target_pos = true
    MsgGame:mq_publish2(Const.MSG_ON_CAMERA_REACH_TARGET_POS)
  end
end

function M:get_camera_cfg()
  return self.v_camera_cfg
end

function M:set_camera_is_only_forward(is_only_forward)
  self.v_is_only_forward = is_only_forward
end

function M:start_ct_camera_dutch_offset(parms_data)
  if not self.v_dutch_effect then
    return
  end
  self.v_dutch_effect:start_dutch_effect(parms_data)
end

function M:stop_ct_camera_dutch_offset()
  if not self.v_dutch_effect then
    return
  end
  self.v_dutch_effect:stop_dutch_effect()
end

function M:set_focus_hero_lerp_state(is_lerp_camera, is_lerp_focus)
  if not self.v_focus_hero_effect then
    return
  end
  self.v_focus_hero_effect:set_lerp_camera_pos(is_lerp_camera)
  self.v_focus_hero_effect:set_lerp_focus_pos(is_lerp_focus)
end

function M:change_switch_scene_processing_bg(node_id)
  if Util.is_nil(self.v_camera_obj) then
    return
  end
  local fight = UIMgr:try_get_ui("fight")
  if not fight then
    return
  end
  local node_cfg = ShareRes.get_chapter_node_cfg(node_id)
  local path = node_cfg.CameraTexture or Config.DEFAULT_CAMERA_TEXTURE
  if self.v_default_texture_path == path then
    return
  end
  
  local function callback(image)
    if image.overrideSprite == nil then
      return
    end
    local comp = self.v_camera_obj:GetComponent(typeof(CS.SwitchSceneProcessing))
    comp.defaultTex = image.overrideSprite.texture
  end
  
  fight:load_temp_sprite(true, path, callback)
  self.v_default_texture_path = path
end

function M:check_change_switch_sp_bg_on_init()
  local progress = TowerMgr and TowerMgr:get_tower_progress()
  if progress and progress.challenge_type == Config.CommonDefine.CHALLENGE_TYPE.LONG_CHAPTER and Util.is_more_than_zero(progress.node_id) then
    self:change_switch_scene_processing_bg(progress.node_id)
  end
end

function M:blend_by_ourself()
  local curtime = GlobalTimeMgr:get_time()
  local timeduration = curtime - self.v_blend_begin_time
  if timeduration >= self.v_timeduration_default then
    if 0 == self.v_timeduration_default then
      self:set_camera_to_default_pos_in_shouldermode()
    else
    end
    self.v_should_blend_by_ourself = false
    self.v_temp_focal_pos = self.v_temp_focal_pos or self.v_temp_focal_pos_vec3
    self.v_temp_camera_pos = self.v_temp_camera_pos or self.v_temp_camera_pos_vec3
    self.v_temp_focal_pos:Set(self.v_focal_point:GetPositionA())
    self.v_temp_camera_pos:Set(self.v_camera_transform:GetPositionA())
    return
  end
  local t = ease_helper.ease_in_out_sine(timeduration / self.v_timeduration_default)
  temp_vec3_00:Set(self.v_camera_transform:GetEulerAnglesA3())
  temp_vec3_00.x = default_init_angle_x
  temp_vec3_00.z = 0
  temp_quat_00:SetEuler(temp_vec3_00:Get())
  temp_quat_01:Set(self.v_camera_transform:GetRotationA())
  Quat.SlerpA(temp_quat_01, temp_quat_00, t, temp_quat_01)
  temp_vec3_00:Set(self.v_camera_transform:GetForwardA())
  local camera_arm = temp_vec3_00:Mul(self.v_cur_distance)
  local focal_pos_x, focal_pos_y, focal_pos_z = self.v_focal_point:GetPositionA()
  local destination_x = focal_pos_x - camera_arm.x
  local destination_y = focal_pos_y - camera_arm.y
  local destination_z = focal_pos_z - camera_arm.z
  local cam_pos_x, cam_pos_y, cam_pos_z = self.v_camera_transform:GetPositionA()
  local posx = _lerp(cam_pos_x, destination_x, t)
  local posy = _lerp(cam_pos_y, destination_y, t)
  local posz = _lerp(cam_pos_z, destination_z, t)
  self:set_cam_postion(posx, posy, posz)
end

local focusing_offset = Vec3.New(0.5, 0.1, 1.5)
local focusing_offset_length = Vec3.Distance(focusing_offset, Vec3.zero)
local focusing_temp_vec3_x = Vec3.New()
local focusing_temp_vec2_x = Vec2.New()
local focusing_temp_vec3_y = Vec3.New(0, 1, 0)
local focusing_temp_vec3_z = Vec3.New()
local focusing_temp_vec2_z = Vec2.New()
local camera_orientation = Quat.New()
local temp_camera_orientation = Quat.New()

function M:shoulder_camera_focusing()
  local fpos_x, fpos_y, fpos_z = self.v_focal_point:GetPositionA()
  if self.v_camera_focusing_mode == CAMERA_FOCUS_MODE.TARGET then
    temp_vec3_00:Set(self.v_camera_transform:GetPositionA())
    temp_vec3_00:Sub(self.v_focusing_pos)
    temp_vec2_00:Set(temp_vec3_00.x, temp_vec3_00.z)
    temp_vec2_00:SetNormalize():Mul(3.5)
    temp_vec3_00:Set(self.v_focusing_pos.x + temp_vec2_00.x, self.v_focusing_pos.y + 2, self.v_focusing_pos.z + temp_vec2_00.y)
    focusing_temp_vec3_y:Set(0, 1, 0)
    temp_vec3_01:Set(self.v_focusing_pos.x - temp_vec3_00.x, self.v_focusing_pos.y - temp_vec3_00.y, self.v_focusing_pos.z - temp_vec3_00.z)
    Quat.LookRotationA(temp_vec3_01, focusing_temp_vec3_y, camera_orientation)
  elseif self.v_camera_focusing_mode == CAMERA_FOCUS_MODE.MIDDLE_OF_TARGET_AND_CHAR then
    focusing_temp_vec3_y:Set(0, 1, 0)
    focusing_temp_vec2_z:Set(fpos_x, fpos_z)
    focusing_temp_vec2_z:Set(fpos_x - self.v_focusing_pos.x, fpos_z - self.v_focusing_pos.z)
    focusing_temp_vec3_z:Set(focusing_temp_vec2_z.x, 0, focusing_temp_vec2_z.y)
    Vec3.CrossA(focusing_temp_vec3_z, Vec3.up, focusing_temp_vec3_x)
    focusing_temp_vec2_x:Set(focusing_temp_vec3_x.x, focusing_temp_vec3_x.z)
    focusing_temp_vec2_x:SetNormalize()
    focusing_temp_vec2_z:SetNormalize()
    Util.VEC3_TEMP:SetA(focusing_offset)
    Util.VEC3_TEMP:SetNormalize()
    Util.VEC3_TEMP:Mul(math.min(self.v_cur_distance, focusing_offset_length))
    focusing_temp_vec3_x:Set(Util.VEC3_TEMP.x * focusing_temp_vec2_x.x, 0, Util.VEC3_TEMP.x * focusing_temp_vec2_x.y)
    focusing_temp_vec3_y:Mul(Util.VEC3_TEMP.y)
    focusing_temp_vec3_z:Set(Util.VEC3_TEMP.z * focusing_temp_vec2_z.x, 0, Util.VEC3_TEMP.z * focusing_temp_vec2_z.y)
    temp_vec3_00:Set(fpos_x, fpos_y, fpos_z)
    temp_vec3_00:Add(focusing_temp_vec3_x)
    temp_vec3_00:Add(focusing_temp_vec3_y)
    temp_vec3_00:Add(focusing_temp_vec3_z)
    focusing_temp_vec3_y:Set(0, 1, 0)
    temp_vec3_01:Set(self.v_focusing_pos.x - temp_vec3_00.x, 0, self.v_focusing_pos.z - temp_vec3_00.z)
    Quat.LookRotationA(temp_vec3_01, focusing_temp_vec3_y, camera_orientation)
  end
  self.v_is_camera_focusing_in_shoulder_mode_duration = self.v_is_camera_focusing_in_shoulder_mode_duration + self:get_dt()
  if self.v_is_camera_focusing_in_shoulder_mode_duration < self.v_shoulder_mode_focusing_duration then
    local t = ease_helper.ease_in_out_Cubic(self.v_is_camera_focusing_in_shoulder_mode_duration / self.v_shoulder_mode_focusing_duration)
    Vec3.LerpA(self.v_camera_focusing_pos, temp_vec3_00, t, temp_vec3_00)
    Quat.SlerpA(self.v_camera_focusing_ort, camera_orientation, t, camera_orientation)
  end
  self:set_cam_postion(temp_vec3_00:Get())
  self.v_camera_transform:SetRotationA(camera_orientation:Get())
end

function M:new_blend_pass()
  if self.v_new_blend_trigger then
    self.v_new_blend_transition = self.v_new_blend_transition + self:get_dt()
    local t = self.v_new_blend_transition / self.v_new_blend_duration
    if t > 1 then
      self.v_new_blend_trigger = false
      return
    end
    t = ease_helper.ease_in_out_sine(t)
    self.v_cur_quat:Set(self.v_camera_transform:GetRotationA())
    temp_vec3_00:Set(self:_get_base_pos())
    temp_vec3_01:Set(self.v_focal_point:GetPositionA())
    temp_vec3_01:Sub(temp_vec3_00)
    temp_vec3_01:SetNormalize()
    focusing_temp_vec3_y:Set(0, 1, 0)
    Quat.LookRotationA(temp_vec3_01, focusing_temp_vec3_y, temp_camera_orientation)
    Quat.SlerpA(self.v_camera_focusing_ort, temp_camera_orientation, t, camera_orientation)
    self.v_camera_transform:SetRotationA(camera_orientation:Get())
    Vec3.LerpA(self.v_camera_focusing_pos, temp_vec3_00, t, temp_vec3_00)
    self:set_cam_postion(temp_vec3_00:Get())
    return true
  end
end

function M:set_camera_blend_flag()
  self.v_blend_cut_flag = true
end

function M:release_camera_blend_flag()
  self.v_blend_cut_flag = false
end

function M:trigger_new_blend_pass(duration)
  self.v_new_blend_trigger = true
  self.v_new_blend_duration = duration or 1
  self.v_new_blend_transition = 0.0
  self.v_temp_camera_pos = nil
  self.v_temp_focal_pos = nil
  self.v_camera_focusing_pos:Set(self.v_camera_transform:GetPositionA())
  self.v_camera_focusing_ort:Set(self.v_camera_transform:GetRotationA())
end

function M:get_camera_position()
  if not Util.is_nil(self.v_camera_transform) then
    local x, y, z = self.v_camera_transform:GetPositionA()
    Util.VEC3_TEMP:Set(x, y, z)
  else
    Util.VEC3_TEMP:Set(0, 0, 0)
  end
  return Util.VEC3_TEMP
end

function M:pinch_debug(pinch_limit_min, pinch_limit_max, d2s_distance, s2d_distance)
  self.v_pinch_limit_min = pinch_limit_min and pinch_limit_min or self.v_pinch_limit_min
  self.v_pinch_limit_max = pinch_limit_max and pinch_limit_max or self.v_pinch_limit_max
  self.v_d2s_pinch_distance = d2s_distance and d2s_distance or self.v_d2s_pinch_distance
  self.v_s2d_pinch_distance = s2d_distance and s2d_distance or self.v_s2d_pinch_distance
end

function M:add_role_effect_sign(role_uuid, effect_id)
  if nil == role_uuid then
    return
  end
  self.v_role_effect_sing_map = self.v_role_effect_sing_map or {}
  self.v_role_effect_sing_map[role_uuid] = self.v_role_effect_sing_map[role_uuid] or {}
  self.v_role_effect_sing_map[role_uuid][effect_id] = true
end

function M:remove_role_effect_sign(role_uuid, effect_id)
  if nil == role_uuid then
    return
  end
  if not self.v_role_effect_sing_map then
    return
  end
  if not self.v_role_effect_sing_map[role_uuid] then
    return
  end
  self.v_role_effect_sing_map[role_uuid][effect_id] = nil
end

function M:remove_role_effect_on_destroy()
  if not self.v_role_effect_sing_map then
    return
  end
  local role
  for role_uuid, effect_ids in pairs(self.v_role_effect_sing_map) do
    role = SceneMgr:pick_by_uuid(role_uuid)
    if not Util.is_destroy(role) then
      for effect_id in pairs(effect_ids) do
        role.act_effect_ctrl:stop_effect(effect_id)
      end
    end
  end
  self.v_role_effect_sing_map = nil
end

function M:on_activate_pov_camera(is_activated)
  if is_activated then
    self.v_camera_pos_before_enter_timeline:Set(self.v_camera_transform:GetPositionA())
    self.v_camera_rot_before_enter_timeline:Set(self.v_camera_transform:GetRotationA())
  else
    self:set_cam_postion(self.v_camera_pos_before_enter_timeline.x, self.v_camera_pos_before_enter_timeline.y, self.v_camera_pos_before_enter_timeline.z)
    self.v_camera_transform:SetRotationA(self.v_camera_rot_before_enter_timeline:Get())
  end
end

function M:enable_camera_occlusion_culling(is_enabled)
  if not self.v_camera then
    return
  end
  self.v_camera.useOcclusionCulling = is_enabled
end

return M
