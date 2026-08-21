local Base = require("ui.model_rt_view.model_rt_view_new")
local M = Util.create_child_mt(Base)
local Math = require("base.mathx")
local _abs = math.abs

function M:_init(...)
  self.v_gyro_speed = ShareRes.get_comm_value("BuildingSceneGyroParam1")
  self.v_gyro_range = ShareRes.get_comm_value("BuildingSceneGyroParam2")
  self.v_gyro_cold = ShareRes.get_comm_value("BuildingSceneGyroParam3")
  self.v_gyro_threshold = ShareRes.get_comm_value("BuildingSceneGyroParam4")
  self.v_gyro_reset_speed = ShareRes.get_comm_value("BuildingSceneGyroParam5")
  Base._init(self, ...)
  self:set_scene_load_done(false)
end

function M:update()
  self:_gyro_update()
end

function M:on_destroy()
  Base.on_destroy(self)
  self:set_scene_load_done(false)
end

function M:on_scene_load_on()
  self:set_scene_load_done(true)
  self:init_camera_pos()
end

function M:set_scene_load_done(done)
  self.v_scene_load_done = done
end

function M:get_content_root()
  return self.v_content_root
end

function M:init_camera_pos()
  if self.v_camera_root_transform then
    local camera = BuildingMgr:get_building_scene_obj("Camera")
    local transform = camera.transform
    self.v_camera_root_transform.position = transform.position
    self.v_camera_root_transform.localScale = transform.localScale
    self.v_camera_root_transform.rotation = transform.rotation
    self.v_need_reset_gyro_cache = true
    local x, y = transform:GetLocalEulerAnglesA3()
    self.v_cache_angle = {x = x, y = y}
  end
end

function M:_gyro_update()
  if GuideMgr:get_cur_guider() then
    return
  end
  if not self.v_camera_root_transform or not self.v_cache_angle then
    return
  end
  local att_x, att_y, att_z, att_w = CSHelper.GetGyroAttitudeA()
  if not (not self.v_need_reset_gyro_cache and self.v_gyro_cache_x) or not self.v_gyro_cache_x then
    self.v_gyro_cache_y = att_y
    self.v_gyro_cache_x = att_x
    self.v_need_reset_gyro_cache = false
  end
  local gyro_diff_y = att_y - self.v_gyro_cache_y
  local gyro_diff_x = att_x - self.v_gyro_cache_x
  self.v_gyro_cache_y = att_y
  self.v_gyro_cache_x = att_x
  if _abs(gyro_diff_x) > 0.5 or _abs(gyro_diff_y) > 0.5 then
    return
  end
  local do_shake = _abs(gyro_diff_x) > self.v_gyro_threshold or _abs(gyro_diff_y) > self.v_gyro_threshold
  if do_shake then
    self:_shake_camera(gyro_diff_x, gyro_diff_y)
    self.v_cold_down_timer = self.v_gyro_cold
  elseif self.v_cold_down_timer then
    if self.v_cold_down_timer > 0 then
      local dt_time = Global.delta_time
      self.v_cold_down_timer = self.v_cold_down_timer - dt_time
    else
      self:_recenter_camera()
      self.v_cold_down_timer = 0
    end
  end
end

function M:_shake_camera(diff_x, diff_y)
  local dt_time = Global.delta_time
  local trans = self.v_camera_root_transform
  local angle_x, angle_y, angle_z = trans:GetLocalEulerAnglesA3()
  local target_x = self:_clamp_angle(angle_x, diff_x * 10, self.v_cache_angle.x)
  local target_y = self:_clamp_angle(angle_y, diff_y * 10, self.v_cache_angle.y)
  local rot_x = Math.lerp_angle(angle_x, target_x, dt_time * self.v_gyro_speed)
  local rot_y = Math.lerp_angle(angle_y, target_y, dt_time * self.v_gyro_speed)
  local rot_z = angle_z
  trans:SetEuler(rot_x, rot_y, rot_z)
end

function M:_clamp_angle(value, diff, pivot)
  local max = pivot + self.v_gyro_range
  if value > max then
    value = value - 360
  end
  local result = value + diff
  local min = pivot - self.v_gyro_range
  if diff < 0 then
    if result < min then
      result = min or result
    end
  else
    result = max < result and max or result
  end
  result = result < 0 and 360 + result or result
  result = result > 360 and result - 360 or result
  return result
end

function M:_recenter_camera()
  local trans = self.v_camera_root_transform
  local angle_x, angle_y, angle_z = trans:GetLocalEulerAnglesA3()
  local target_x = self.v_cache_angle.x
  local target_y = self.v_cache_angle.y
  local do_recenter_x = _abs(angle_x - target_x) > 0.01
  local do_recenter_y = _abs(angle_y - target_y) > 0.01
  if not do_recenter_x and not do_recenter_y then
    return
  end
  local dt_time = Global.delta_time
  local rot_x = Math.lerp_angle(angle_x, target_x, dt_time * self.v_gyro_reset_speed)
  local rot_y = Math.lerp_angle(angle_y, target_y, dt_time * self.v_gyro_reset_speed)
  local rot_z = angle_z
  trans:SetEuler(rot_x, rot_y, rot_z)
end

return M
