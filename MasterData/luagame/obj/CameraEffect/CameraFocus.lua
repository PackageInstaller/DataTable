local Math = require("base.mathx")
local Layer = require("utils.layer")
local Vec2 = require("base.vec2")
local Vec3 = require("base.vec3")
local Quat = require("base.quat")
local CommDefine = require("cs_share.common_define")
local CSMathf = UnityEngine.Mathf
local CSDebug = UnityEngine.Debug
local Color = UnityEngine.Color
local rad2Deg = Math.Rad2Deg
local TypeAttachPoint = typeof(CS.AttachPoint)
local UnityQuat = UnityEngine.Quaternion
local FOCAL_DEFAULT_HEIGHT = 2
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
local deg2Rad = Math.Deg2Rad
local camera_min_height = 2
local camera_height_offset = 1
local default_init_angle_x = 20
local V_FOCAL_STATE = {
  LOCK_TAR = 1,
  LOCK_HERO = 2,
  AIMED = 3
}
local CAMERA_VIEW_TYPE = {DEPRESSION = 1, SHOULDER = 2}
local M = Util.create_class()
local temp_vec2_00 = Vec2.New()
local temp_vec2_01 = Vec2.New()
local temp_vec2_02 = Vec2.New()
local temp_vec2_03 = Vec2.New()
local temp_vec2_04 = Vec2.New()
local temp_vec3_00 = Vec3.New()
local temp_vec3_01 = Vec3.New()
local temp_quat_00 = Quat.New()
local final_cam_lookatpoint_pos = Vec3.New()
local final_cam_position = Vec3.New()

function M:_init(camera_lua)
  self.v_camera = camera_lua
  self.v_camera_obj = camera_lua.v_camera_obj
  self.v_camera_transform = camera_lua.v_camera_transform
  self.v_hit_temp = camera_lua.v_hit_temp
  self.v_focal_point = camera_lua.v_focal_point
  self.v_camera_cfg = camera_lua.v_camera_cfg
  self.v_focal_point_offset_y = ShareRes.get_comm_value("ShoulderModeCameraFocalPointOffsetY")
  self.v_max_pitch = ShareRes.get_comm_value("TPCMaxPitch")
  self.v_focal_cross1 = Vec2.New(0, 0)
  self.v_focal_cross2 = Vec2.New(0, 0)
  self.v_sector_pos1 = Vec3.New()
  self.v_sector_pos2 = Vec3.New()
  self.v_lookat_pos = Vec3.New()
  self.v_camera_arm = Vec3.New()
  self.v_lerp_cam_position = Vec3.New()
  self.v_lerp_cam_lookatpoint_pos = Vec3.New()
  self.v_camera_focus_pos = Vec3.New()
  self.v_focus_pos = Vec3.New()
end

function M:on_release()
end

function M:init_camera_cfg(cfg)
  self.v_camera_cfg = cfg
  if self.v_camera_cfg then
    self.v_default_angle = (self.v_camera_cfg.FocusMaxAngle or 0) / 2
    self.v_default_angle_between_xz = 20
    self.v_default_radius = self.v_camera_cfg.DefaultDistance
    self.v_focus_position_lerp = self.v_camera_cfg.FocusPositionLerp or 5
    self.v_focus_rotation_lerp = self.v_camera_cfg.FocusRotationLerp or 5
  end
end

function M:get_dt()
  return self.v_camera:get_dt()
end

function M:update()
end

function M:late_update()
  self:update_camer_focal_pos()
end

function M:check_camera_focus(target_pos, focal_pos, is_set_target, force)
  if not self.v_camera_cfg then
    return
  end
  if not force and not self.v_camera.v_force_locking and self.v_camera.v_swipe then
    return
  end
  if self.v_camera_cfg.CameraViewType == CAMERA_VIEW_TYPE.DEPRESSION then
    return
  end
  if not force and not self.v_camera.v_force_locking then
    local focal_pos_x, focal_pos_y, focal_pos_z = self.v_focal_point:GetPositionA()
    local distance = Vec3.DistanceA(focal_pos_x, focal_pos_y, focal_pos_z, target_pos:Get())
    local camera_cfg = self.v_camera_cfg
    local out_max_distance = camera_cfg.OutFocusMaxDistance or 0
    if 0 ~= out_max_distance and distance >= out_max_distance then
      return
    end
    local out_min_distance = camera_cfg.OutFocusMinDistance or 0
    if focal_pos then
      local cur_dis = Vec3.DistanceA(focal_pos_x, focal_pos_y, focal_pos_z, focal_pos:Get())
      if 0 ~= out_min_distance and out_min_distance >= cur_dis then
        return
      end
    end
  end
  local pitch = self.v_camera_transform:GetEulerAnglesA3()
  pitch = self.v_camera:_format_angle(pitch)
  if -pitch > self.v_max_pitch then
    self.v_camera.v_set_camera_pitch_angle_to_default = true
    return
  end
  if is_set_target then
    local char_pos_raw_x, char_pos_raw_y, char_pos_raw_z = self.v_focal_point:GetPositionA()
    local attach_transform = self.v_camera:get_attach_point_transform()
    if attach_transform then
      char_pos_raw_x, char_pos_raw_y, char_pos_raw_z = attach_transform:GetPositionA()
    end
    temp_vec3_00:SetA(target_pos)
    temp_vec3_01:Set(char_pos_raw_x, char_pos_raw_y, char_pos_raw_z)
    temp_vec3_00:Sub(temp_vec3_01)
    temp_vec3_00:SetNormalize()
    local angle_between_xz = math.asin(_clamp(temp_vec3_00.y, -1, 1)) * rad2Deg
    if angle_between_xz > self.v_max_pitch then
      return
    end
  end
  return true
end

function M:set_camera_focal_by_pos(x, y, z)
  temp_vec3_00:Set(x, y, z)
  if not self:check_camera_focus(temp_vec3_00, nil, true, true) then
    return
  end
  self.v_camera_focus_pos:Set(x, y, z)
  self.v_is_focusing_by_pos = true
  self.v_lerp_camera_end = false
  self.v_lerp_hero_end = true
  self.v_focus_cur_quat = self.v_camera.v_cur_quat
  self.v_target_distance = self.v_camera.v_target_distance
  local focus_pos = self.v_camera.v_focus_pos
  if focus_pos then
    self.v_focus_pos:Set(focus_pos.x, focus_pos.y, focus_pos.z)
  else
    self.v_focus_pos:Set(x, y, z)
  end
  self.v_default_radius = self.v_camera_cfg.DefaultDistance
  return true
end

function M:set_camera_focal(npc, attach_name, force)
  if not npc or npc:is_destroy() then
    return
  end
  if not force and self.v_focus_target and self.v_focus_target.uuid == npc.uuid then
    return
  end
  temp_vec3_00:Set(npc.transform:GetPositionA())
  self.attach_point = npc.transform:GetComponent(TypeAttachPoint)
  self.v_attach_name = attach_name or "camerapoint"
  if self.attach_point then
    local point = self.attach_point:GetPoint(self.v_attach_name)
    if point then
      self.v_point_trans = point.transform
      temp_vec3_00:Set(self.v_point_trans:GetPositionA())
    end
  end
  if not self:check_camera_focus(temp_vec3_00, nil, true, force) then
    return
  end
  self.v_focus_target = npc
  self.v_focus_target_trans = npc.transform
  self.v_lerp_camera_end = false
  self.v_lerp_hero_end = true
  self.v_focus_cur_quat = self.v_camera.v_cur_quat
  self.v_target_distance = self.v_camera.v_target_distance
  local focus_pos = self.v_camera.v_focus_pos
  if focus_pos then
    self.v_focus_pos:Set(focus_pos.x, focus_pos.y, focus_pos.z)
  else
    self.v_focus_pos:Set(self.v_focus_target_trans:GetPositionA())
  end
  local _, point_pos_y, _ = self.v_point_trans:GetPositionA()
  local _, focal_pos_y, _ = self.v_focal_point:GetPositionA()
  if self.v_point_trans and point_pos_y > focal_pos_y and npc.character_cfg.Kind == CommDefine.NPC_KIND.BOSS then
    self.v_default_radius = ShareRes.get_comm_value("ShoulderModeCameraDistance")
  else
    self.v_default_radius = self.v_camera_cfg.DefaultDistance
  end
  return true
end

function M:clear_focal()
  self.v_is_focusing_by_pos = nil
  self.v_focus_target = nil
  self.v_lerp_hero_end = false
  self.v_cache_len = nil
  self.v_point_trans = nil
  self.v_camera:sync_camera_focus_pos(self.v_focus_pos)
  self.attach_point = nil
  self.last_lookatpoint_pos = nil
  local x1, y1, z1 = self.v_focal_point:GetPositionA()
  local x2, y2, z2 = self.v_lookat_pos:Get()
  if Vec3.SquareDistanceA(x1, y1, z1, x2, y2, z2) < 10000 then
    self.v_camera.v_temp_focal_pos = self.v_lookat_pos
  end
end

function M:update_camer_focal_pos()
  if (not self.v_focus_target or not self.v_camera_cfg) and not self.v_is_focusing_by_pos then
    return
  end
  local camera_cfg = self.v_camera_cfg
  local char_pos_raw_x, char_pos_raw_y, char_pos_raw_z = self.v_focal_point:GetPositionA()
  local attach_transform = self.v_camera:get_attach_point_transform()
  if attach_transform then
    char_pos_raw_x, char_pos_raw_y, char_pos_raw_z = attach_transform:GetPositionA()
  end
  if not self.v_is_focusing_by_pos and self.v_focus_target:is_destroy() then
    local target = SceneMgr:search_target(Global.hero, 4, 100)
    if target and target:is_com_monster() then
      local success = Global.camera:set_camera_focal(target, "Bip001 Chest")
      if not success then
        self.v_camera:clear_focal()
      end
    else
      self.v_camera:clear_focal()
    end
    return
  end
  local target_pos_raw_x, target_pos_raw_y, target_pos_raw_z
  if self.v_is_focusing_by_pos then
    target_pos_raw_x, target_pos_raw_y, target_pos_raw_z = self.v_camera_focus_pos:Get()
  else
    target_pos_raw_x, target_pos_raw_y, target_pos_raw_z = self.v_focus_target_trans:GetPositionA()
  end
  if not self.v_is_focusing_by_pos and self.attach_point then
    if not self.v_point_trans then
      local point = self.attach_point:GetPoint(self.v_attach_name)
      self.v_point_trans = point.transform
    end
    target_pos_raw_x, target_pos_raw_y, target_pos_raw_z = self.v_point_trans:GetPositionA()
  end
  if target_pos_raw_y < 5000 then
    self.v_lookat_pos:SetA(self.v_lerp_cam_lookatpoint_pos)
  end
  local cam_pos_raw_x, cam_pos_raw_y, cam_pos_raw_z = self.v_camera_transform:GetPositionA()
  temp_vec2_02:Set(cam_pos_raw_x, cam_pos_raw_z)
  temp_vec2_03:Set(char_pos_raw_x, char_pos_raw_z)
  temp_vec2_04:Set(char_pos_raw_x, char_pos_raw_z)
  temp_vec2_03:Sub(temp_vec2_02)
  temp_vec2_02:Set(target_pos_raw_x, target_pos_raw_z)
  temp_vec2_02:Sub(temp_vec2_04)
  local angle = Vec2.SignedAngleRaw(temp_vec2_03:SetNormalize(), temp_vec2_02:SetNormalize())
  temp_vec3_00:Set(target_pos_raw_x, target_pos_raw_y, target_pos_raw_z)
  temp_vec3_01:Set(char_pos_raw_x, char_pos_raw_y, char_pos_raw_z)
  temp_vec3_00:Sub(temp_vec3_01)
  temp_vec3_00:SetNormalize()
  local angle_between_xz = math.asin(_clamp(temp_vec3_00.y, -1, 1)) * rad2Deg
  temp_vec2_01:Set(target_pos_raw_x, target_pos_raw_z)
  temp_vec2_02:Set(char_pos_raw_x, char_pos_raw_z)
  local distance = Vec2.Distance(temp_vec2_01, temp_vec2_02)
  local dis_factor = 0.4
  local lerp_factor = 0.02
  local angle_limit = self.v_default_angle_between_xz / (distance * dis_factor)
  local is_target_fly = false
  if angle_between_xz > angle_limit then
    is_target_fly = true
    temp_vec3_00:Set(char_pos_raw_x, char_pos_raw_y + self.v_focal_point_offset_y, char_pos_raw_z)
    temp_vec3_01:Set(target_pos_raw_x, target_pos_raw_y, target_pos_raw_z)
    Vec3.LerpA(temp_vec3_00, temp_vec3_01, (angle_between_xz - angle_limit) * lerp_factor, temp_vec3_01)
    final_cam_lookatpoint_pos:SetA(temp_vec3_01)
  else
    final_cam_lookatpoint_pos:Set(char_pos_raw_x, char_pos_raw_y + self.v_focal_point_offset_y, char_pos_raw_z)
  end
  final_cam_position:Set(0, 0, 0)
  if math.abs(angle) > self.v_default_angle then
    temp_vec2_00:Set(target_pos_raw_x, target_pos_raw_z)
    temp_vec2_01:Set(char_pos_raw_x, char_pos_raw_z)
    temp_vec2_00:Sub(temp_vec2_01)
    local sign = angle > 0 and -1 or 1
    local cos_value = math.cos(self.v_default_angle * deg2Rad * sign)
    local sin_value = math.sin(self.v_default_angle * deg2Rad * sign)
    local temp_x = temp_vec2_00.x * cos_value - temp_vec2_00.y * sin_value
    local temp_z = temp_vec2_00.x * sin_value + temp_vec2_00.y * cos_value
    temp_vec2_01:Set(temp_x, temp_z)
    temp_vec2_01:SetNormalize()
    temp_vec2_01:Mul(-self.v_default_radius)
    temp_vec2_00:SetA(temp_vec2_01)
  else
    temp_vec2_00:Set(cam_pos_raw_x, cam_pos_raw_z)
    temp_vec2_01:Set(char_pos_raw_x, char_pos_raw_z)
    temp_vec2_00:Sub(temp_vec2_01)
    temp_vec2_00:SetNormalize()
    temp_vec2_00:Mul(self.v_default_radius)
  end
  local camera_arm_angle_x = is_target_fly and default_init_angle_x - Math.Clamp(angle_between_xz - angle_limit, 0, 30) or default_init_angle_x
  self.v_camera_arm:Set(temp_vec2_00.x, 0, temp_vec2_00.y)
  Vec3.CrossA(self.v_camera_arm, Vec3.up, temp_vec3_00)
  Quat.AngleAxisA(camera_arm_angle_x, temp_vec3_00, temp_quat_00)
  temp_quat_00:MulVec3_NoneAlloc(self.v_camera_arm, temp_vec3_00)
  final_cam_position:Set(char_pos_raw_x, char_pos_raw_y + self.v_focal_point_offset_y, char_pos_raw_z)
  final_cam_position:Add(temp_vec3_00)
  if not self.last_lookatpoint_pos then
    self.last_lookatpoint_pos = Vec3.New(self.v_focal_point:GetPositionA())
  end
  local is_check_hit = 0 ~= camera_cfg.CheckFocusHit or camera_cfg.CheckFocusHit ~= false
  if is_check_hit then
    local camera_pos = temp_vec3_00:SetB(final_cam_position)
    local char_pos = temp_vec3_01:Set1(char_pos_raw_x, char_pos_raw_y, char_pos_raw_z)
    local len = Vec3.Distance(camera_pos, char_pos)
    local dir = camera_pos:Sub(char_pos):SetNormalize()
    local collision_effect = self.v_camera:get_camera_collision_effect()
    local collision_component = collision_effect:get_camera_collision_component()
    local hit_distance = collision_component:GetClosestCollidedDistance(char_pos.x, char_pos.y, char_pos.z, dir.x, dir.y, dir.z, len, SceneMgr:check_obstacle_missile() or false, self.v_camera.v_camera_mode == Config.CAMERA_VIEW_TYPE.SHOULDER)
    if len > hit_distance then
      dir:Mul(hit_distance)
      char_pos:Add(dir)
      final_cam_position:SetA(char_pos)
    end
  end
  temp_vec3_00:Set(target_pos_raw_x, target_pos_raw_y, target_pos_raw_z)
  if not self:check_camera_focus(temp_vec3_00, temp_vec3_00) then
    self.v_camera:clear_focal()
    return
  end
  self.v_lerp_cam_position:Set(cam_pos_raw_x, cam_pos_raw_y, cam_pos_raw_z)
  self.v_lerp_cam_lookatpoint_pos:Set(char_pos_raw_x, char_pos_raw_y, char_pos_raw_z)
  Vec3.LerpA(self.v_lerp_cam_position, final_cam_position, self.v_focus_position_lerp * self:get_dt(), self.v_lerp_cam_position)
  local last_lookatpoint_pos_x = _lerp(self.last_lookatpoint_pos.x, final_cam_lookatpoint_pos.x, self.v_focus_rotation_lerp * self:get_dt())
  local last_lookatpoint_pos_z = _lerp(self.last_lookatpoint_pos.z, final_cam_lookatpoint_pos.z, self.v_focus_rotation_lerp * self:get_dt())
  local factor = _clamp(_abs(self.last_lookatpoint_pos.y - final_cam_lookatpoint_pos.y) / 1, 0, 1)
  self.v_focus_rotation_lerp_y = 10 * factor
  local last_lookatpoint_pos_y = _lerp(self.last_lookatpoint_pos.y, final_cam_lookatpoint_pos.y, self.v_focus_rotation_lerp_y * self:get_dt())
  self.v_lerp_cam_lookatpoint_pos:Set(last_lookatpoint_pos_x, last_lookatpoint_pos_y, last_lookatpoint_pos_z)
  self.last_lookatpoint_pos:SetA(self.v_lerp_cam_lookatpoint_pos)
  local dx, dy, dz = 0, 0, 0
  local t1, t2, t3
  t1, t2, t3, dx, dy, dz = self.v_camera:get_shake_pos(self.v_lerp_cam_position.x, self.v_lerp_cam_position.y, self.v_lerp_cam_position.z)
  self.v_camera:set_cam_postion(self.v_lerp_cam_position.x, self.v_lerp_cam_position.y, self.v_lerp_cam_position.z)
  self.v_camera_transform:LookAtA(self.v_lerp_cam_lookatpoint_pos.x + dx, self.v_lerp_cam_lookatpoint_pos.y + dy, self.v_lerp_cam_lookatpoint_pos.z + dz)
  self.v_focus_pos:Set(char_pos_raw_x, char_pos_raw_y, char_pos_raw_z)
  self.v_focus_pos.y = self.v_focus_pos.y + self.v_focal_point_offset_y
end

function M:lerp_camera_pos_by_focal(pos, focal_pos)
  local time = self:get_dt()
  local lerp_val = time * (self.v_camera_cfg.DefaultToFocusDuration or 0)
  lerp_val = _min(lerp_val, 0.5)
  local forwardDir = focal_pos - pos
  local quat = UnityQuat.LookRotation(forwardDir)
  self.v_focus_cur_quat = Quat.Slerp(self.v_focus_cur_quat, quat, lerp_val)
  local angle = Quat.Angle(self.v_focus_cur_quat, quat)
  if not self.v_focus_pos then
    self.v_focus_pos = Vec3.New(self.v_focal_point:GetPositionA())
  end
  local camera_pos_x, camera_pos_y, camera_pos_z = self.v_camera_transform:GetPositionA()
  local new_pos = pos
  if Vec3.DistanceA(camera_pos_x, camera_pos_y, camera_pos_z, pos.x, pos.y, pos.z) > 0.01 or angle > 0.01 then
    Vec3.LerpA(self.v_focus_pos, focal_pos, lerp_val, self.v_focus_pos)
  else
    self.v_lerp_camera_end = true
  end
  local final_posx, final_posy, final_posz, dx, dy, dz = self.v_camera:get_shake_pos(new_pos.x, new_pos.y, new_pos.z)
  local focus_x = self.v_focus_pos.x + dx
  local focus_y = self.v_focus_pos.y + dy
  local focus_z = self.v_focus_pos.z + dz
  self.v_camera:sync_camera_focus_pos(self.v_focus_pos)
  self.v_camera:apply_camera_pos(final_posx, final_posy, final_posz, focus_x, focus_y, focus_z, false, true)
end

return M
