local Base = require("obj.base_component")
local Math = require("base.mathx")
local Vec3 = require("base.vec3")
local FindPathTask = require("manager.role_mgr.find_path_task")
local LuaObjPoolMgr = require("manager.res.lua_obj_pool_mgr")
local MOVE_TYPE = Config.ROLE_MOVE_TYPE
local AstarHelper = CS.Game.AstarHelper
local TypeFindPathDebug = typeof(CS.Game.FindPathDebug)
local _cs_is_path_possible = CS.Pathfinding.PathUtilities.IsPathPossible
local _tinsert = table.insert
local STATE = {
  NONE = 0,
  WAITING = 1,
  PATHING = 2,
  ERROR = 3
}
local MAX_CNT_PER_SEC = 5
local REFRESH_NAV_TIME = 0.5
local IS_OPEN_NAV_FUC = true
local TmpPoint = Util.create_class()

function TmpPoint:_init(x, y, z)
  self.x, self.y, self.z = x, y, z
end

function TmpPoint:Get()
  return self.x, self.y, self.z
end

function TmpPoint:on_destroy()
end

local NearestPos = Util.create_class()

function NearestPos:_init(rlt, x, y, z)
  self.rlt, self.x, self.y, self.z = rlt, x, y, z
end

function NearestPos:on_destroy()
end

local M = Util.create_child_mt(Base)

function M:_init(char)
  Base._init(self)
  self.v_char = char
  self.v_game_obj = nil
  self.v_navigating = false
  self.v_state = STATE.NONE
  self.v_last_nav_time = 0
  self.v_tracing = false
  self.v_start_pos = Vec3.New(0, 0, 0)
  self.v_end_pos = Vec3.New(0, 0, 0)
  self.v_point_list = {n = 0}
  self.v_cur_task_idx = 0
  self.v_cur_task = nil
  self.v_task_pool = LuaObjPoolMgr.get_pool("find_path_task_pool") or LuaObjPoolMgr.register("find_path_task_pool", 50, FindPathTask)
  M.v_nearest_pool = LuaObjPoolMgr.get_pool("find_path_nearest_pool") or LuaObjPoolMgr.register("find_path_nearest_pool", 50, NearestPos)
  self.v_profile_last_time = 0
  self.v_profile_cnt = 0
  self.v_path_debuger = nil
end

function M:on_before_destroy()
  self.v_char = nil
  self.v_path_debuger = nil
  self.v_point_list = nil
end

function M:on_destroy_gameobj()
  self:_clear_nav()
  self:_clear_target_info()
  self:_clear_custom_find_path()
  self.v_game_obj = nil
end

local _nearest_pos_cache = {}
local _nearest_tmp_tb = {}

local function _add_to_cache(body_size, grid_idx, gg_idx, rlt, new_x, new_y, new_z)
  _nearest_tmp_tb[1], _nearest_tmp_tb[2] = body_size, gg_idx
  local t, k, v
  t = _nearest_pos_cache
  for i = 1, 2 do
    k = _nearest_tmp_tb[i]
    v = t[k] or {}
    t[k] = v
    t = v
  end
  t[grid_idx] = M.v_nearest_pool:new_obj(rlt, new_x, new_y, new_z)
end

local function _get_from_cache(body_size, grid_idx, gg_idx)
  _nearest_tmp_tb[1], _nearest_tmp_tb[2], _nearest_tmp_tb[3] = body_size, gg_idx, grid_idx
  local t, k, v
  t = _nearest_pos_cache
  for i = 1, 3 do
    k = _nearest_tmp_tb[i]
    v = t[k]
    if nil == v then
      return false
    end
    t = v
  end
  return true, t.rlt, t.x, t.y, t.z
end

local function _get_cache_nearest_grid_pos(body_size, x, y, z, gg)
  local grid = AstarHelper.GetNearestGrid1(x, y, z, gg, false, true)
  local is_success, new_rlt, new_grid, new_x, new_y, new_z
  if not grid then
    new_grid, new_x, new_y, new_z = AstarHelper.GetNearestGrid2(body_size, x, y, z, gg, true, true)
    return nil ~= new_grid, new_x, new_y, new_z
  end
  local grid_idx = grid.NodeInGridIndex
  local gg_idx = gg.graphIndex
  is_success, new_rlt, new_x, new_y, new_z = _get_from_cache(body_size, grid_idx, gg_idx)
  if not is_success then
    new_grid, new_x, new_y, new_z = AstarHelper.GetNearestGrid2(body_size, x, y, z, gg, true, true)
    new_rlt = nil ~= new_grid
    _add_to_cache(body_size, grid_idx, gg_idx, new_rlt, new_x, new_y, new_z)
  end
  return new_rlt, new_x, new_y, new_z
end

function M.clear_cache()
  if M.v_nearest_pool then
    M.v_nearest_pool:release_active_objs()
  end
  _nearest_pos_cache = {}
end

function M:_clear_nav()
  if not self.v_navigating then
    return
  end
  self:_clear_task()
  self:_clear_point_list()
  self.v_cur_way_point = nil
  self.v_state = STATE.NONE
  self.v_navigating = false
  self.v_tracing = false
end

function M:_clear_custom_find_path()
  if not self.v_custom_naving then
    return
  end
  self:_clear_task()
  self:_clear_point_list()
  self.v_find_path_cb = nil
  self.v_find_path_fail_cb = nil
  self.v_find_path_cb_self = nil
  self.v_custom_naving = false
end

function M:_clear_task()
  if self.v_cur_task then
    self.v_task_pool:destroy_obj(self.v_cur_task)
    self.v_cur_task = nil
  end
end

function M:_clear_point_list()
  if not self.v_point_list then
    return
  end
  if self.v_point_list.n >= 1 then
    for i = 1, self.v_point_list.n do
      local point = self.v_point_list[i]
      point:destroy()
    end
  end
  self.v_point_list.n = 0
end

function M:_clear_target_info()
  self.v_target = nil
  self.v_target_pos = nil
end

function M:_meter_per_cell()
  local logic = SceneMgr:get_scene_logic()
  local map = logic:get_scene_map()
  return map:get_meter_per_cell()
end

function M:_check_cnt()
  if is_debug_enviroment() then
    local cur_time = Global.real_time
    if cur_time - self.v_profile_last_time > 1 then
      if self.v_profile_cnt > MAX_CNT_PER_SEC then
        Log.Error("某个角色1秒内寻路次数过多，次数：", self.v_profile_cnt, self.v_char.character_cfg.NpcId, cur_time, self.v_profile_last_time)
      end
      self.v_profile_cnt = 0
      self.v_profile_last_time = cur_time
    end
  end
end

function M:_check_next_way_point()
  if self.v_point_list.n <= 0 then
    return
  end
  if self.v_way_point_index > self.v_point_list.n then
    return
  end
  local x, z = self.v_cur_way_point:get_world_pos_xz()
  local posx, posz = self.v_char:get_pos2()
  local sq_dis = Math.square_distance2(posx, posz, x, z)
  if sq_dis <= self.v_radius then
    self.v_way_point_index = self.v_way_point_index + 1
    if self.v_way_point_index <= self.v_point_list.n then
      self.v_cur_way_point = self.v_point_list[self.v_way_point_index]
    end
  end
end

function M:_check_refresh_nav()
  if self.v_target == nil then
    return
  end
  local cur_time = GlobalTimeMgr:get_time()
  local dt = cur_time - self.v_last_nav_time
  if dt >= REFRESH_NAV_TIME then
    self:move_to_target(self.v_target, true)
    self.v_tracing = true
  end
end

function M:_check_move_type()
  local is_nav_move_type = self:_is_nav_move_type()
  if self.v_navigating then
    if not is_nav_move_type then
      self:_clear_nav()
    end
  elseif is_nav_move_type then
    if self.v_target_pos then
      self:move_to_pos(self.v_target_pos)
    else
      self:move_to_target(self.v_target)
    end
  end
end

function M:_on_find_path_fail(...)
  self.v_state = STATE.ERROR
  self:_clear_point_list()
  self.v_cur_way_point = nil
  if self.v_find_path_fail_cb then
    self.v_find_path_fail_cb(self.v_find_path_cb_self)
  end
end

function M:_check_task()
  if self.v_state ~= STATE.WAITING or self.v_cur_task == nil then
    return
  end
  if not self.v_cur_task:is_calc_finished() then
    return
  end
  if not self.v_cur_task:is_valid_path() then
    self:_clear_task()
    self:_on_find_path_fail("all task no valid")
    if self.v_custom_naving then
      self:_process_custom_find_path(false)
    end
    return
  end
  self:_clear_point_list()
  self.v_cur_task:fill_points(self.v_point_list)
  self.v_way_point_index = 1
  self.v_cur_way_point = self.v_point_list[1]
  self.v_state = STATE.PATHING
  self:_clear_task()
  if self.v_custom_naving then
    self:_process_custom_find_path(true)
  end
end

do
  local rlt_list = {}
  
  function M:_process_custom_find_path(is_success)
    if Global.IS_DEBUG_FIND_PATH then
      return
    end
    if not is_success then
      self.v_find_path_cb(self.v_find_path_cb_self, false)
      self:_clear_custom_find_path()
      return
    end
    local pool = LuaObjPoolMgr.get_pool("custom_find_path_point_pool") or LuaObjPoolMgr.register("custom_find_path_point_pool", 50, TmpPoint)
    UtilTable.clear_list(rlt_list)
    local points = self.v_point_list
    local n = self.v_point_list.n
    local start_y = Global.hero:get_pos_vec3().y
    local pre_point
    for j = 1, n do
      local point = points[j]
      start_y = point:update_y(start_y)
      local x, y, z = point:get_world_pos()
      local p = pool:new_obj(x, y + 0.3, z)
      if pre_point then
        local dis = Vec3.Distance(p, pre_point)
        local gap_dis = self.v_custom_nav_gap_dis
        local cnt = math.floor(dis / gap_dis)
        if cnt >= 2 then
          for i = 1, cnt - 1 do
            local t = i * gap_dis / dis
            x, y, z = Vec3.LerpB(pre_point, p, t)
            local add_p = pool:new_obj(x, y, z)
            _tinsert(rlt_list, add_p)
          end
        end
      end
      _tinsert(rlt_list, p)
      pre_point = p
    end
    self.v_find_path_cb(self.v_find_path_cb_self, true, rlt_list)
    pool:release_active_objs()
    self:_clear_custom_find_path()
  end
  
  function M:_on_prepare_draw_path()
    if self.v_point_list.n > 0 then
      for i = 1, self.v_point_list.n do
        local point = self.v_point_list[i]
        local x, y, z = point:get_world_pos()
        self.v_path_debuger:PushPoint(x, y, z)
      end
    end
    if self.v_debug_start_grid then
      self.v_path_debuger.StartGrid = self.v_debug_start_grid
    end
    if self.v_debug_end_grid then
      self.v_path_debuger.EndGrid = self.v_debug_end_grid
    end
  end
  
  function M:_suitable_pos(body_size, pos, gg)
    if not AstarHelper.IsGridSuitableForBodyOfGraph(body_size, pos.x, pos.y, pos.z, gg) then
      local rlt, new_x, new_y, new_z = _get_cache_nearest_grid_pos(body_size, pos.x, pos.y, pos.z, gg)
      if rlt then
        pos.x, pos.y, pos.z = new_x, new_y, new_z
      else
        return false
      end
    end
    return true
  end
  
  function M:_start_single_region_nav()
    local map = SceneMgr:get_scene_map()
    local start_region = map:get_base_region()
    local body_size = self:get_body_size()
    local gg = start_region:get_gg()
    local start_pos, end_pos = self.v_start_pos, self.v_end_pos
    if not self:_suitable_pos(body_size, start_pos, gg) then
      self:_on_find_path_fail("start point no nearest suitable point")
      return
    end
    if not self:_suitable_pos(body_size, end_pos, gg) then
      self:_on_find_path_fail("end point no nearest suitable point")
      return
    end
    self.v_cur_task = self.v_task_pool:new_obj(self, start_pos, end_pos, true, start_region, start_region, nil, nil, self.v_radius, self.v_start_pos, self.v_end_pos)
  end
  
  function M:_suitable_pos2(body_size, pos, gg)
    if not AstarHelper.IsGridSuitableForBodyOfGraph(body_size, pos.x, pos.y, pos.z, gg) then
      local grid, new_x, new_y, new_z = AstarHelper.GetNearestGrid2(body_size, pos.x, pos.y, pos.z, gg, true, true)
      if grid then
        pos.x, pos.y, pos.z = new_x, new_y, new_z
        return true, grid
      else
        return false
      end
    else
      local grid = AstarHelper.GetNearestGrid1(pos.x, pos.y, pos.z, gg, true, true)
      if grid then
        return true, grid
      else
        return false
      end
    end
  end
  
  function M:_get_connect_dis(link_point, grid, grid_pos, region)
    local gg_point = link_point:get_gg_point()
    if gg_point and _cs_is_path_possible(gg_point, grid) then
      local x, _, z = link_point:get_pos_in_region(region)
      local dis = Math.square_distance2(x, z, grid_pos.x, grid_pos.z)
      return dis
    end
  end
  
  function M:_get_nearest_link_point(link_dic, link_list, pos, grid, region, check_connect_link_pt)
    local link_point
    local nearest_dis = math.huge
    local nearest_link_point
    for link in pairs(link_dic) do
      link_point = link:get_end_point()
      if not check_connect_link_pt or link_point:is_connect_to_link_pt(check_connect_link_pt) then
        local dis = self:_get_connect_dis(link_point, grid, pos, region)
        if dis and nearest_dis > dis then
          nearest_dis = dis
          nearest_link_point = link_point
        end
      end
    end
    for _, link in ipairs(link_list) do
      link_point = link:get_start_point()
      if not check_connect_link_pt or link_point:is_connect_to_link_pt(check_connect_link_pt) then
        local dis = self:_get_connect_dis(link_point, grid, pos, region)
        if dis and nearest_dis > dis then
          nearest_dis = dis
          nearest_link_point = link_point
        end
      end
    end
    return nearest_link_point
  end
  
  function M:_start_multi_region_nav()
    local body_size = self:get_body_size()
    local map = SceneMgr:get_scene_map()
    local start_pos, end_pos = self.v_start_pos, self.v_end_pos
    local start_region = map:get_region_at_pos(start_pos.x, start_pos.z, start_pos.y)
    local end_region = map:get_region_at_pos(end_pos.x, end_pos.z, end_pos.y)
    if nil == start_region or nil == end_region then
      self:_on_find_path_fail("start region or end region nil", self.v_start_pos, self.v_end_pos)
      return
    end
    local start_graph = start_region:get_gg()
    local end_graph = end_region:get_gg()
    self.v_debug_start_grid = nil
    self.v_debug_end_grid = nil
    start_pos.x, start_pos.z = start_region:transform_pos_for_gg(start_pos.x, start_pos.z)
    end_pos.x, end_pos.z = end_region:transform_pos_for_gg(end_pos.x, end_pos.z)
    local suitable_start, start_grid = self:_suitable_pos2(body_size, start_pos, start_graph)
    if not suitable_start then
      self:_on_find_path_fail("mulit, start point no nearest suitable point")
      return
    end
    local suitable_end, end_grid = self:_suitable_pos2(body_size, end_pos, end_graph)
    if not suitable_end then
      self:_on_find_path_fail("multi, end point no nearest suitable point")
      return
    end
    self.v_debug_start_grid = start_grid
    self.v_debug_end_grid = end_grid
    local is_inner_region = start_region == end_region
    if is_inner_region and _cs_is_path_possible(start_grid, end_grid) then
      self.v_cur_task = self.v_task_pool:new_obj(self, start_pos, end_pos, true, start_region, start_region, nil, nil, self.v_radius, self.v_start_pos, self.v_end_pos)
      return
    end
    local start_link_dic = start_region:get_temp_link_dic()
    local start_link_list = start_region.origin_link_list
    local end_link_dic = end_region:get_temp_link_dic()
    local end_link_list = end_region.origin_link_list
    if not next(start_link_dic) and #start_link_list <= 0 or not next(end_link_dic) and #end_link_list <= 0 then
      self:_on_find_path_fail("links num  zero")
      return
    end
    local start_link_point = self:_get_nearest_link_point(start_link_dic, start_link_list, start_pos, start_grid, start_region)
    if nil == start_link_point then
      self:_on_find_path_fail("none start link point")
      return
    end
    local end_link_point = self:_get_nearest_link_point(end_link_dic, end_link_list, end_pos, end_grid, end_region, start_link_point)
    if nil == end_link_point then
      self:_on_find_path_fail("none end link point")
      return
    end
    self.v_cur_task = self.v_task_pool:new_obj(self, start_pos, end_pos, false, start_region, end_region, start_link_point, end_link_point, self.v_radius, self.v_start_pos, self.v_end_pos)
  end
  
  function M:_start_nav(start_pos, end_pos)
    if Global.IS_DEBUG_FIND_PATH then
      Log.Info("【find path START, ", self.v_char.id, debug.traceback())
    end
    self.v_navigating = true
    self.v_profile_cnt = self.v_profile_cnt + 1
    self.v_last_nav_time = GlobalTimeMgr:get_time()
    if is_debug_enviroment() then
    end
    self:_clear_task()
    self.v_state = STATE.WAITING
    self.v_start_pos:SetA(start_pos)
    self.v_end_pos:SetA(end_pos)
    local map = SceneMgr:get_scene_map()
    if map:has_platforms() and not map:get_is_layer_grid() then
      self:_start_multi_region_nav()
    else
      self:_start_single_region_nav()
    end
  end
  
  function M:_is_similar_nav(target_pos)
    local last_pos = self.v_target_pos
    local dis = Math.distance2(last_pos.x, last_pos.z, target_pos.x, target_pos.z)
    if dis <= self:_meter_per_cell() then
      return true
    end
    return false
  end
  
  function M:_is_nav_move_type()
    local move_type = self.v_char:get_move_type()
    if move_type == MOVE_TYPE.forward or move_type == MOVE_TYPE.run then
      return true
    end
    return false
  end
  
  function M:_get_target_pos_xz()
    local target_pos = self:get_target_pos()
    if target_pos then
      return target_pos.x, target_pos.z
    end
  end
  
  function M:_has_next_wp()
    if self.v_state == STATE.WAITING or self.v_state == STATE.ERROR then
      return true
    end
    return self.v_way_point_index <= self.v_point_list.n
  end
  
  function M:_is_nav_arrive()
    local tx, tz = self:_get_target_pos_xz()
    local posx, posz = self.v_char:get_pos2()
    local dx, dz = posx - tx, posz - tz
    local len = (dx * dx + dz * dz) ^ 0.5
    self.v_collider_r = self.v_collider_r or self.v_char.collider:get_radius()
    local target_r = 0
    if self.v_target then
      target_r = self.v_target.collider and self.v_target.collider:get_radius() or 0
    end
    if len <= self.v_collider_r + target_r or len < 0.1 then
      return true
    end
    return false
  end
  
  function M:_is_target_arrive()
    local tx, tz = self:_get_target_pos_xz()
    local posx, posz = self.v_char:get_pos2()
    local dx, dz = posx - tx, posz - tz
    local len = dx * dx + dz * dz
    self.v_collider_r = self.v_collider_r or self.v_char.collider:get_radius()
    if len < self.v_collider_r or len < 0.1 then
      return true
    end
    return false
  end
  
  function M:_has_obstacle_between_target()
    return true
  end
  
  function M:_is_can_nav()
    return IS_OPEN_NAV_FUC
  end
end

function M:init_gameobj(gameobj)
  self.v_game_obj = gameobj
  self.v_radius = self.v_char.collider:get_radius()
  if UNITY_EDITOR then
    self.v_path_debuger = gameobj:TryAddComponent(TypeFindPathDebug)
    self.v_path_debuger:SetPrepareDrawCb(function()
      self:_on_prepare_draw_path()
    end)
  end
end

function M:get_nearest_walkable_pos(x, y, z)
  local map = SceneMgr:get_scene_map()
  local body_size = self:get_body_size()
  local region = map:get_region_at_pos(x, z)
  if nil == region then
    return false, x, y, z
  end
  local gg = region:get_gg()
  x, z = region:transform_pos_for_gg(x, z)
  if not AstarHelper.IsGridSuitableForBodyOfGraph(body_size, x, y, z, gg) then
    local grid, new_x, new_y, new_z = AstarHelper.GetNearestGrid2(body_size, x, y, z, gg, true, true)
    if grid then
      return true, new_x, new_y, new_z
    else
      return false, x, y, z
    end
  else
    return false, x, y, z
  end
end

function M:get_gameobj()
  return self.v_game_obj
end

function M:update()
  self:_check_cnt()
  if self.v_custom_naving then
    self:_check_task()
    return
  end
  if not self:_is_can_nav() then
    return
  end
  if not self:is_moving() then
    return
  end
  self:_check_move_type()
  if not self.v_navigating then
    return
  end
  self:_check_task()
  self:_check_refresh_nav()
  self:_check_next_way_point()
end

function M:get_body_size()
  if self.v_body_size then
    return self.v_body_size
  end
  local radius = self.v_char.collider:get_radius()
  local body_size = radius * 2
  body_size = math.max(1, body_size)
  self.v_body_size = body_size
  return body_size
end

function M:is_moving()
  return self.v_target_pos ~= nil or nil ~= self.v_target
end

function M:get_cur_step_pos()
  if self.v_navigating then
    if self.v_tracing and self.v_cur_way_point then
      return self.v_cur_way_point:get_world_pos_xz()
    end
    if self.v_state == STATE.WAITING or self.v_state == STATE.ERROR or self.v_cur_way_point == nil then
      return self:_get_target_pos_xz()
    end
    return self.v_cur_way_point:get_world_pos_xz()
  else
    return self:_get_target_pos_xz()
  end
end

function M:get_target_pos()
  return not self.v_target_pos and self.v_target and self.v_target:get_pos_vec3()
end

function M:is_arrive()
  if self.v_navigating then
    return self:_is_nav_arrive() or not self:_has_next_wp()
  else
    return self:_is_target_arrive()
  end
end

function M:find_path(target_pos, gap_dis, cb, cb_self, fail_cb)
  Util.assert(target_pos, "find_path to a nil pos")
  Util.assert(cb, "find_path cb nil")
  self:_clear_custom_find_path()
  self.v_custom_naving = true
  self.v_custom_nav_gap_dis = gap_dis or 2
  self.v_find_path_cb = cb
  self.v_find_path_fail_cb = fail_cb
  self.v_find_path_cb_self = cb_self
  self:_start_nav(self.v_char:get_pos_vec3(), target_pos)
end

function M:move_to_pos(target_pos)
  Util.assert(target_pos, "nav to a nil pos")
  local is_nav_move_type = self:_is_nav_move_type()
  if self.v_navigating then
    if not is_nav_move_type then
      self:_clear_nav()
      self.v_target = nil
      self.v_target_pos = target_pos
      return
    end
    if self.v_target_pos and self:_is_similar_nav(target_pos) then
      return
    end
  end
  self.v_target = nil
  self.v_target_pos = target_pos
  if not self:_is_can_nav() then
    return
  end
  local need_nav = is_nav_move_type
  if need_nav then
    self:_start_nav(self.v_char:get_pos_vec3(), target_pos)
  end
end

function M:move_to_target(target, force)
  Util.assert(target, "nav to a nil target")
  local is_nav_move_type = self:_is_nav_move_type()
  if self.v_navigating then
    if not is_nav_move_type then
      self:_clear_nav()
      self.v_target = target
      self.v_target_pos = nil
      return
    end
    if self.v_target == target and not force then
      return
    end
  end
  self.v_target_pos = nil
  self.v_target = target
  if not self:_is_can_nav() then
    return
  end
  local need_nav = is_nav_move_type
  if need_nav then
    local target_pos = target:get_pos_vec3()
    self:_start_nav(self.v_char:get_pos_vec3(), target_pos)
  end
end

function M:get_state()
  return self.v_state
end

function M:stop()
  if Global.IS_DEBUG_FIND_PATH then
    Log.Info("【find path STOP】, ", self.v_char.id, debug.traceback())
  end
  self:_clear_target_info()
  self:_clear_nav()
end

function M:get_target_uuid()
  return self.v_target and self.v_target.uuid
end

return M
