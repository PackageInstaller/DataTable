local Base = require("gamelogic.base_system")
local M = Util.create_child_mt(Base)
local CommonDef = require("cs_share.common_define")
local LocalStorage = require("utils.localstorage")
local climbing_tower_list, group_climbing_tower_list, finish_star_list, group_award_cfg_list
local ActivityCfg = require("gamelogic.activity.activity_config")
local ACTY_TYPE_TO_SYSID = ActivityCfg.ACTY_TYPE_TO_SYSID

function M:on_climbing_tower_list_refresh(data)
  climbing_tower_list = nil
  group_climbing_tower_list = nil
  finish_star_list = nil
  if not data or not data.climbing_towers then
    return
  end
  finish_star_list = data.finish_star_ids
  self:init_climbing_tower_list()
  for i, climbing_tower in pairs(data.climbing_towers) do
    self:on_climbing_tower_refresh(climbing_tower, true)
  end
  self:refresh_new_point()
end

function M:on_climbing_tower_refresh(server_data, ignore_refresh_new_point)
  self:init_climbing_tower_list()
  local data = server_data
  local info = climbing_tower_list[data.id]
  if not info then
    Log.Error("找不到爬塔玩法配置id", data.id)
    return
  end
  info.data = data
  if ignore_refresh_new_point then
    return
  end
  self:refresh_new_point()
end

function M:init_climbing_tower_list()
  if nil ~= climbing_tower_list then
    return
  end
  climbing_tower_list = {}
  group_climbing_tower_list = {}
  local linear_cfg_list = ShareRes.create("chapter.climbing_tower_point")
  for i, cfg in pairs(linear_cfg_list) do
    local info = {}
    info.cfg = cfg
    climbing_tower_list[cfg.Id] = info
    local group_list = group_climbing_tower_list[cfg.Group]
    if not group_list then
      group_list = {}
      group_climbing_tower_list[cfg.Group] = group_list
    end
    table.insert(group_list, info)
  end
  for i, group_list in pairs(group_climbing_tower_list) do
    table.sort(group_list, function(a, b)
      return a.cfg.Serial < b.cfg.Serial
    end)
  end
  group_award_cfg_list = {}
  local star_cfg_list = ShareRes.create("chapter.climbing_tower_star")
  for i, star_cfg in pairs(star_cfg_list) do
    local group_id = star_cfg.GroupId
    local award_cfg_list = group_award_cfg_list[group_id]
    if not award_cfg_list then
      award_cfg_list = {}
      group_award_cfg_list[group_id] = award_cfg_list
    end
    table.insert(award_cfg_list, star_cfg)
  end
  for i, award_cfg_list in pairs(group_award_cfg_list) do
    table.sort(award_cfg_list, function(a, b)
      return a.StarNum < b.StarNum
    end)
  end
end

function M:get_climbing_tower_list(group_id)
  if not group_id then
    return climbing_tower_list
  end
  return group_climbing_tower_list[group_id]
end

function M:get_climbing_tower_config(epi_id)
  local climbing_tower_cfg_list = ShareRes.create("chapter.climbing_tower_point")
  for i, cfg in pairs(climbing_tower_cfg_list) do
    if cfg.PointId == epi_id then
      return cfg
    end
  end
  return nil
end

function M:get_star(id)
  local info = climbing_tower_list[id]
  if info and info.data then
    return self:get_star_with_bit(info.data.star)
  end
  return 0
end

function M:get_star_with_epi_id(epi_id)
  if not climbing_tower_list then
    self:init_climbing_tower_list()
  end
  for i, info in pairs(climbing_tower_list) do
    if info.cfg.PointId == epi_id then
      return self:get_star(info.cfg.Id)
    end
  end
  return 0
end

function M:get_id_with_epi_id(epi_id)
  for i, info in pairs(climbing_tower_list) do
    if info.cfg.PointId == epi_id then
      return info.cfg.Id
    end
  end
  return nil
end

function M:get_next_linear_cfg_with_curr_epi_id(epi_id)
  local curr_cfg = self:get_climbing_tower_config(epi_id)
  local next_cfg
  local linear_cfg_list = ShareRes.create("chapter.climbing_tower_point")
  for i, cfg in pairs(linear_cfg_list) do
    if cfg.Group == curr_cfg.Group and cfg.Id > curr_cfg.Id then
      next_cfg = cfg
      break
    end
  end
  if not next_cfg then
    return nil
  else
    return next_cfg
  end
end

function M:get_is_reach_max_star_and_next_epi_id(epi_id)
  local star = self:get_star_with_epi_id(epi_id)
  local next_linear_cfg = self:get_next_linear_cfg_with_curr_epi_id(epi_id)
  if not next_linear_cfg then
    return star >= 3, 0, 0
  end
  return star >= 3, next_linear_cfg.PointId, next_linear_cfg.Id
end

function M:get_group_star(group_id)
  local list = group_climbing_tower_list[group_id]
  if not list then
    return 0
  end
  local star = 0
  for i, info in pairs(list) do
    star = star + self:get_star(info.cfg.Id)
  end
  return star
end

function M:get_group_max_star(group_id)
  local max_star = 0
  local star_cfg_list = ShareRes.create("chapter.climbing_tower_star")
  for i, star_cfg in pairs(star_cfg_list) do
    if star_cfg.GroupId == group_id and max_star < star_cfg.StarNum then
      max_star = star_cfg.StarNum
    end
  end
  if 0 == max_star then
    local point_cfg_list = ShareRes.create("chapter.climbing_tower_point")
    for i, star_cfg in pairs(point_cfg_list) do
      if star_cfg.Group == group_id then
        max_star = max_star + 3
      end
    end
  end
  return max_star
end

function M:get_star_with_bit(star_bit)
  local nBit = star_bit
  local nCount = 0
  while 0 ~= nBit do
    nBit = nBit & nBit - 1
    nCount = nCount + 1
  end
  return nCount
end

function M:get_passed_with_epi_id(epi_id)
  if not climbing_tower_list then
    return false
  end
  for _, info in pairs(climbing_tower_list) do
    if info.cfg.PointId == epi_id then
      return info.data.passed
    end
  end
  return false
end

function M:get_condition_is_finish(id, condition_index)
  local star = climbing_tower_list[id].data.star
  if 1 == condition_index then
    return 1 == star & 1
  elseif 2 == condition_index then
    return 1 == star >> 1 & 1
  else
    return 1 == star >> 2 & 1
  end
end

function M:get_condition_is_finish_with_point_id(point_id, condition_index)
  for i, info in pairs(climbing_tower_list) do
    if info.cfg.PointId == point_id then
      return self:get_condition_is_finish(info.cfg.Id, condition_index)
    end
  end
  return false
end

function M:get_group_award_finished(group_id, star_num)
  local is_received = false
  if not finish_star_list then
    return false
  end
  for i, id in pairs(finish_star_list) do
    local star_cfg = ShareRes.create("chapter.climbing_tower_star", id)
    if group_id == star_cfg.GroupId and star_cfg.StarNum == star_num then
      is_received = true
    end
  end
  return is_received
end

function M:get_group_award_cfg_list(group_id)
  return group_award_cfg_list[group_id]
end

function M:refresh_new_point()
  self.v_group_id = 0
  self.v_stage_id = 0
  self.v_serial = 0
  self.v_group_max_stage = {}
  for _, info in pairs(climbing_tower_list) do
    if not (info.data and info.data.front_open and info.data.condition_open) then
      break
    end
    if info.cfg.Group > self.v_group_id then
      self.v_group_id = info.cfg.Group
      self.v_stage_id = info.cfg.Id
      self.v_serial = info.cfg.Serial
      self.v_group_max_stage[self.v_group_id] = self.v_stage_id
    elseif info.cfg.Group == self.v_group_id and info.cfg.Serial > self.v_serial then
      self.v_stage_id = info.cfg.Id
      self.v_serial = info.cfg.Serial
      self.v_group_max_stage[self.v_group_id] = self.v_stage_id
    end
  end
end

function M:get_stage_serial(stage_id)
  return climbing_tower_list[stage_id].cfg.Serial
end

function M:get_new_group_id()
  return self.v_group_id
end

function M:get_new_stage_id(group_id)
  if group_id == self.v_group_id then
    return self.v_stage_id
  end
  return self.v_group_max_stage[group_id]
end

function M:get_climbing_tower_win_is_opened_key()
  return "IS_CLIMBING_TOWER_WIN_OPENED"
end

function M:get_is_need_show_red()
  if not self:is_sys_open() then
    return false
  end
  local is_need_show_red = 0 == LocalStorage:load_int(self:get_climbing_tower_win_is_opened_key(), 0, true)
  return is_need_show_red
end

function M:on_climbing_tower_opened()
  LocalStorage:save_int(self:get_climbing_tower_win_is_opened_key(), 1, true)
end

function M:get_climbing_tower_group_is_open(group_id)
  local list = self:get_climbing_tower_list(group_id)
  local first_cfg = list[1]
  if not first_cfg or not first_cfg.data then
    return false
  end
  return first_cfg.data.condition_open
end

function M:get_main_btn_info()
  local is_open = self:is_sys_open()
  if not is_open then
    return is_open
  end
  local curr = 0
  local max = 0
  local cfg_list = ShareRes.create("chapter.climbing_tower")
  for _, cfg in pairs(cfg_list) do
    curr = curr + self:get_group_star(cfg.Id)
    max = max + self:get_group_max_star(cfg.Id)
  end
  return is_open, curr, max
end

function M:is_sys_open()
  return SysOpenMgr:get_sys_is_open(ACTY_TYPE_TO_SYSID[Config.CommonDefine.ACTY_TYPE.CLIMBING_TOWER])
end

return M
