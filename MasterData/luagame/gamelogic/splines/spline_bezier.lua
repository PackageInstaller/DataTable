local Base = require("gamelogic.splines.spline_base")
local spline_helper = require("utils.spline_helper")
local mathx = require("base.mathx")
local vec3 = require("base.vec3")
local quat = require("base.quat")
local util = require("utils.util")
local CSDebug = UnityEngine.Debug
local Color = UnityEngine.Color
local M = Util.create_child_mt(Base)
local temp_vec3_00 = vec3.New()
local temp_vec3_01 = vec3.New()
local temp_vec3_02 = vec3.New()
local temp_p0 = vec3.New()
local temp_p1 = vec3.New()
local temp_p2 = vec3.New()
local temp_p3 = vec3.New()
local quat_00 = quat.New()
local quat_01 = quat.New()
local quat_02 = quat.New()
local resolution = 20
local step = 1 / resolution

function M:_init(data)
  Base:_init()
  self:init_data(data)
  self.v_root_pos = vec3.New()
  self.v_root_orientation = quat.New()
  self.v_local_x = vec3.New()
  self.v_local_z = vec3.New()
  self.v_p0 = vec3.New()
  self.v_p1 = vec3.New()
  self.v_p2 = vec3.New()
  self.v_p3 = vec3.New()
end

function M:init_data(data)
  self.v_waypoints = data.waypoints
  self.v_segment_duration_list = data.segmentDuration
  self.v_stay_duration_list = data.stayDuration
  self.v_orientation_list = data.orientation
  self.v_cur_segment_index = -1
end

function M:get_bounding_index(progress)
  local segment_index = 0
  local duration = 0
  for i = 1, #self.v_segment_duration_list - 1 do
    if progress >= duration then
      progress = progress - duration
      duration = self.v_segment_duration_list[i]
      segment_index = segment_index + 1
    else
      break
    end
  end
  local normalized_t = progress / self.v_segment_duration_list[segment_index]
  mathx.Clamp01(normalized_t)
  return segment_index, normalized_t
end

function M:get_bounding_index2(progress)
  local segment_index = 0
  local duration = 0
  for i = 1, #self.v_segment_duration_list - 1 do
    if progress >= duration + self.v_stay_duration_list[i] then
      progress = progress - duration - self.v_stay_duration_list[i]
      duration = self.v_segment_duration_list[i]
      segment_index = segment_index + 1
    else
      break
    end
  end
  if 0 == segment_index then
    segment_index = 1
    local normalized_t = 0
    return segment_index, normalized_t
  end
  local normalized_t = progress / self.v_segment_duration_list[segment_index]
  mathx.Clamp01(normalized_t)
  return segment_index, normalized_t
end

function M:set_local_coordinate(root_x, root_y, root_z, euler_y)
  self.v_root_pos:Set(root_x, root_y, root_z)
  self.v_root_orientation:SetEuler(0, euler_y, 0)
  vec3.forward:Rotate2_NoneAlloc(math.rad(-euler_y), self.v_local_z)
  self.v_local_z:Rotate2_NoneAlloc(math.rad(-90), self.v_local_x)
end

function M:evaluate_position_in_worldspace(segment_index, normalized_t)
  if self.v_cur_segment_index ~= segment_index then
    self.v_cur_segment_index = segment_index
    self:transform_point_to_worldspace(segment_index)
    self.v_p0:SetA(temp_p0)
    self.v_p1:SetA(temp_p1)
    self.v_p2:SetA(temp_p2)
    self.v_p3:SetA(temp_p3)
  end
  local x, y, z = spline_helper.bezier3(self.v_p0, self.v_p1, self.v_p2, self.v_p3, normalized_t)
  return x, y, z
end

function M:evaluate_tangent_in_worldspace(segment_index, normalized_t)
  if self.v_cur_segment_index ~= segment_index then
    self.v_cur_segment_index = segment_index
    self:transform_point_to_worldspace(segment_index)
    self.v_p0:SetA(temp_p0)
    self.v_p1:SetA(temp_p1)
    self.v_p2:SetA(temp_p2)
    self.v_p3:SetA(temp_p3)
  end
  local x, y, z = spline_helper.bezier_tangent3(self.v_p0, self.v_p1, self.v_p2, self.v_p3, normalized_t)
  return x, y, z
end

function M:evaluate_orientation_in_worldspace(segment_index, normalized_t)
  local orientation_start = self.v_orientation_list[segment_index]
  quat_00:Set(orientation_start.x, orientation_start.y, orientation_start.z, orientation_start.w)
  local orientation_end = self.v_orientation_list[segment_index + 1]
  quat_01:Set(orientation_end.x, orientation_end.y, orientation_end.z, orientation_end.w)
  quat.Mul(self.v_root_orientation, quat_00, quat_00)
  quat.Mul(self.v_root_orientation, quat_01, quat_01)
  quat.SlerpA(quat_00, quat_01, normalized_t, quat_02)
  return quat_02:Get()
end

function M:transform_point_to_worldspace(segment_index)
  local knot_0 = self.v_waypoints[segment_index].knot
  temp_vec3_00:SetA(self.v_local_x)
  temp_vec3_00:Mul(knot_0[1])
  temp_vec3_01:SetA(vec3.up)
  temp_vec3_01:Mul(knot_0[2])
  temp_vec3_02:SetA(self.v_local_z)
  temp_vec3_02:Mul(knot_0[3])
  temp_vec3_00:Add(temp_vec3_01)
  temp_vec3_00:Add(temp_vec3_02)
  temp_p0:SetA(temp_vec3_00)
  temp_p0:Add(self.v_root_pos)
  local control_0 = self.v_waypoints[segment_index].control
  temp_vec3_00:SetA(self.v_local_x)
  temp_vec3_00:Mul(control_0[1])
  temp_vec3_01:SetA(vec3.up)
  temp_vec3_01:Mul(control_0[2])
  temp_vec3_02:SetA(self.v_local_z)
  temp_vec3_02:Mul(control_0[3])
  temp_vec3_00:Add(temp_vec3_01)
  temp_vec3_00:Add(temp_vec3_02)
  util.VEC3_TEMP:SetA(temp_p0)
  util.VEC3_TEMP:Add(temp_vec3_00)
  temp_p1:SetA(util.VEC3_TEMP)
  local knot_1 = self.v_waypoints[segment_index + 1].knot
  temp_vec3_00:SetA(self.v_local_x)
  temp_vec3_00:Mul(knot_1[1])
  temp_vec3_01:SetA(vec3.up)
  temp_vec3_01:Mul(knot_1[2])
  temp_vec3_02:SetA(self.v_local_z)
  temp_vec3_02:Mul(knot_1[3])
  temp_vec3_00:Add(temp_vec3_01)
  temp_vec3_00:Add(temp_vec3_02)
  temp_p3:SetA(temp_vec3_00)
  temp_p3:Add(self.v_root_pos)
  local control_1 = self.v_waypoints[segment_index + 1].control
  temp_vec3_00:SetA(self.v_local_x)
  temp_vec3_00:Mul(control_1[1])
  temp_vec3_01:SetA(vec3.up)
  temp_vec3_01:Mul(control_1[2])
  temp_vec3_02:SetA(self.v_local_z)
  temp_vec3_02:Mul(control_1[3])
  temp_vec3_00:Add(temp_vec3_01)
  temp_vec3_00:Add(temp_vec3_02)
  util.VEC3_TEMP:SetA(temp_p3)
  util.VEC3_TEMP:Sub(temp_vec3_00)
  temp_p2:SetA(util.VEC3_TEMP)
  return temp_p0:Get(), temp_p1:Get(), temp_p2:Get(), temp_p3:Get()
end

function M:get_displacement_over_time(start_time, end_time, cal_tangent)
  local start_index, end_index = 0, 0
  local start_duration, end_duration = 0, 0
  local get_start_suc, get_end_suc
  for i = 1, #self.v_segment_duration_list - 1 do
    if not get_start_suc then
      if start_time >= start_duration + self.v_stay_duration_list[i] then
        start_time = start_time - start_duration - self.v_stay_duration_list[i]
        start_duration = self.v_segment_duration_list[i]
        start_index = start_index + 1
      else
        get_start_suc = true
      end
    end
    if not get_end_suc then
      if end_time >= end_duration + self.v_stay_duration_list[i] then
        end_time = end_time - end_duration - self.v_stay_duration_list[i]
        end_duration = self.v_segment_duration_list[i]
        end_index = end_index + 1
      else
        get_end_suc = true
      end
    end
    if get_start_suc and get_end_suc then
      break
    end
  end
  local normalized_t
  if 0 == start_index then
    start_index = 1
    normalized_t = 0
  else
    normalized_t = start_time / self.v_segment_duration_list[start_index]
  end
  mathx.Clamp01(normalized_t)
  local sx, sy, sz = self:evaluate_position_in_worldspace(start_index, normalized_t)
  if 0 == end_index then
    end_index = 1
    normalized_t = 0
  else
    normalized_t = end_time / self.v_segment_duration_list[end_index]
  end
  mathx.Clamp01(normalized_t)
  local ex, ey, ez = self:evaluate_position_in_worldspace(end_index, normalized_t)
  local tx, ty, tz
  if cal_tangent then
    tx, ty, tz = self:evaluate_tangent_in_worldspace(end_index, normalized_t)
  end
  local dx, dy, dz = ex - sx, ey - sy, ez - sz
  return dx, dy, dz, tx, ty, tz
end

function M:debug(offset_x, offset_y, offset_z)
  if not UNITY_EDITOR or not Global.spline_debug then
    return
  end
  Base:debug()
  for i = 1, #self.v_waypoints - 1 do
    self:transform_point_to_worldspace(i)
    for j = 0, resolution - 1 do
      local t = j * step
      local start_x, start_y, start_z = spline_helper.bezier3(temp_p0, temp_p1, temp_p2, temp_p3, t)
      t = t + step
      local end_x, end_y, end_z = spline_helper.bezier3(temp_p0, temp_p1, temp_p2, temp_p3, t)
      if offset_x then
        start_x = start_x + offset_x
        start_y = start_y + offset_y
        start_z = start_z + offset_z
        end_x = end_x + offset_x
        end_y = end_y + offset_y
        end_z = end_z + offset_z
      end
      local startPoint = UnityVector3(start_x, start_y, start_z)
      local endPoint = UnityVector3(end_x, end_y, end_z)
      CSDebug.DrawLine(startPoint, endPoint, Color.green, 0)
    end
  end
end

return M
