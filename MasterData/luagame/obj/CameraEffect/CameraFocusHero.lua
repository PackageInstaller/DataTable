local Math = require("base.mathx")
local Layer = require("utils.layer")
local Vec2 = require("base.vec2")
local Vec3 = require("base.vec3")
local Quat = require("base.quat")
local CSMathf = UnityEngine.Mathf
local CSDebug = UnityEngine.Debug
local Color = UnityEngine.Color
local rad2Deg = Math.Rad2Deg
local TypeAttachPoint = typeof(CS.AttachPoint)
local UnityQuat = UnityEngine.Quaternion
local _abs = math.abs
local _clamp = Math.Clamp
local _inverse_lerp = Math.inverse_lerp
local _lerp = Math.lerp_number
local _floor = math.floor
local _tan = math.tan
local deg2Rad = Math.Deg2Rad
local temp_vec3_00 = Vec3.New()
local M = Util.create_class()

function M:_init(camera_lua)
  self.v_camera = camera_lua
  self.v_camera_obj = camera_lua.v_camera_obj
  self.v_camera_transform = camera_lua.v_camera_transform
  self.v_focal_point = camera_lua.v_focal_point
  self.v_camera_cfg = camera_lua.v_camera_cfg
end

function M:init_camera_cfg(cfg)
  self.v_camera_cfg = cfg
end

function M:get_dt()
  return self.v_camera:get_dt()
end

function M:on_release()
end

function M:late_update()
end

function M:quat_focal2pos(quat, fpos, len)
  quat:MulVec3_NoneAlloc(Vec3.forward, temp_vec3_00)
  temp_vec3_00:Mul(len)
  local posx = fpos.x - temp_vec3_00.x
  local posy = fpos.y - temp_vec3_00.y
  local posz = fpos.z - temp_vec3_00.z
  return posx, posy, posz
end

function M:set_lerp_camera_pos(is_lerp)
  self.v_lerp_camera_pos = is_lerp
end

function M:set_lerp_focus_pos(is_lerp)
  self.v_lerp_focus_pos = is_lerp
end

function M:init_data(focus_pos, focus_len)
  self.v_focus_pos = focus_pos
  self.v_focal_hero_len = focus_len
end

function M:clear_data()
  self.v_focus_pos = nil
  self.v_focal_hero_len = nil
end

function M:update_focus_hero()
  local time = self:get_dt()
  local val = self.v_camera_cfg.FocusHeroLerpVal or 0.5
  local lerp_val = time * val
  local cur_distance = self.v_camera.v_cur_distance
  local cur_quat = self.v_camera.v_cur_quat
  self.v_focus_pos = self.v_focus_pos or self.v_focal_point.position
  self.v_focal_hero_len = self.v_focal_hero_len or cur_distance
  self.v_focal_hero_len = _lerp(self.v_focal_hero_len, cur_distance, lerp_val)
  if Vec3.Distance(self.v_focus_pos, self.v_focal_point.position) > 0.01 then
    self.v_focus_pos = Vec3.Lerp(self.v_focus_pos, self.v_focal_point.position, lerp_val)
  else
    self.v_lerp_focus_pos = true
  end
  if self.v_lerp_focus_pos then
    self.v_focus_pos = self.v_focal_point.position
    self.v_focal_hero_len = cur_distance
  end
  local camera_pos = self.v_camera_transform.position
  local x, y, z = self:quat_focal2pos(cur_quat, self.v_focus_pos, self.v_focal_hero_len)
  if not self.v_new_pos then
    self.v_new_pos = Vec3.New(x, y, z)
  else
    self.v_new_pos.x = x
    self.v_new_pos.y = y
    self.v_new_pos.z = z
  end
  local lerp = false
  if Vec3.Distance(camera_pos, self.v_new_pos) > 0.01 and not self.v_lerp_camera_pos then
    lerp = true
  else
    self.v_lerp_camera_pos = true
  end
  self.v_camera:sync_camera_focus_pos(self.v_focus_pos)
  local final_posx, final_posy, final_posz, dx, dy, dz = self.v_camera:get_shake_pos(x, y, z)
  self.v_camera:apply_camera_pos(final_posx, final_posy, final_posz, self.v_focus_pos.x + dx, self.v_focus_pos.y + dy, self.v_focus_pos.z + dz, lerp, true)
end

return M
