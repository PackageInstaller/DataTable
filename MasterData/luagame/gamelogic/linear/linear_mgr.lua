local Base = require("gamelogic.base_system")
local M = Util.create_child_mt(Base)
local CommonDef = require("cs_share.common_define")
local linear_list, group_linear_list, finish_star_list, group_award_cfg_list

function M:on_linear_list_refresh(data)
  linear_list = nil
  group_linear_list = nil
  finish_star_list = nil
  if not data or not data.linears then
    return
  end
  finish_star_list = data.finish_star_ids
  self:init_linear_list()
  for i, linear in pairs(data.linears) do
    self:on_linear_refresh(linear, false)
  end
  self:refresh_red()
end

function M:on_linear_refresh(server_data, is_need_refresh_red)
  self:init_linear_list()
  local data = server_data
  local info = linear_list[data.id]
  if not info then
    Log.Error("找不到吊坠大师配置id", data.id)
    return
  end
  info.data = data
  if is_need_refresh_red then
    self:refresh_red()
  end
end

function M:init_linear_list()
  if nil ~= linear_list then
    return
  end
  linear_list = {}
  group_linear_list = {}
  local linear_cfg_list = ShareRes.create("chapter.linear_point")
  for i, cfg in pairs(linear_cfg_list) do
    local info = {}
    info.cfg = cfg
    linear_list[cfg.Id] = info
    local group_list = group_linear_list[cfg.Group]
    if not group_list then
      group_list = {}
      group_linear_list[cfg.Group] = group_list
    end
    table.insert(group_list, info)
  end
  for i, group_list in pairs(group_linear_list) do
    table.sort(group_list, function(a, b)
      return a.cfg.Serial < b.cfg.Serial
    end)
  end
  group_award_cfg_list = {}
  local star_cfg_list = ShareRes.create("chapter.linear_star")
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

function M:get_linear_list(group_id)
  if not group_id then
    return linear_list
  end
  return group_linear_list[group_id]
end

function M:get_linear_config(epi_id)
  local linear_cfg_list = ShareRes.create("chapter.linear_point")
  for i, cfg in pairs(linear_cfg_list) do
    if cfg.PointId == epi_id then
      return cfg
    end
  end
  return nil
end

function M:get_star(id)
  local info = linear_list[id]
  if info and info.data then
    return self:get_star_with_bit(info.data.star)
  end
  return 0
end

function M:get_star_with_epi_id(epi_id)
  for i, info in pairs(linear_list) do
    if info.cfg.PointId == epi_id then
      return self:get_star(info.cfg.Id)
    end
  end
  return 0
end

function M:get_id_with_epi_id(epi_id)
  for i, info in pairs(linear_list) do
    if info.cfg.PointId == epi_id then
      return info.cfg.Id
    end
  end
  return nil
end

function M:get_next_linear_cfg_with_curr_epi_id(epi_id)
  local curr_cfg = self:get_linear_config(epi_id)
  local next_cfg
  local linear_cfg_list = ShareRes.create("chapter.linear_point")
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
  local list = group_linear_list[group_id]
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
  local star_cfg_list = ShareRes.create("chapter.linear_star")
  for i, star_cfg in pairs(star_cfg_list) do
    if star_cfg.GroupId == group_id and max_star < star_cfg.StarNum then
      max_star = star_cfg.StarNum
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
  if not linear_list then
    return false
  end
  for _, info in pairs(linear_list) do
    if info.cfg.PointId == epi_id then
      return info.data.passed
    end
  end
  return false
end

function M:get_condition_is_finish(id, condition_index)
  local star = linear_list[id].data.star
  if 1 == condition_index then
    return 1 == star & 1
  elseif 2 == condition_index then
    return 1 == star >> 1 & 1
  else
    return 1 == star >> 2 & 1
  end
end

function M:get_condition_is_finish_with_point_id(point_id, condition_index)
  for i, info in pairs(linear_list) do
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
    local star_cfg = ShareRes.create("chapter.linear_star", id)
    if group_id == star_cfg.GroupId and star_cfg.StarNum == star_num then
      is_received = true
    end
  end
  return is_received
end

function M:get_group_award_cfg_list(group_id)
  return group_award_cfg_list[group_id]
end

function M:get_award_state(star_id)
  local star_cfg = ShareRes.create("chapter.linear_star", star_id)
  local group_id = star_cfg.GroupId
  local curr_star = self:get_group_star(group_id)
  local need_star = star_cfg.StarNum
  local is_finished = self:get_group_award_finished(group_id, need_star)
  if is_finished then
    return CommonDef.JOURNEY_STATE.GAINED
  end
  if curr_star >= need_star then
    return CommonDef.JOURNEY_STATE.COMPLETE
  end
  return CommonDef.JOURNEY_STATE.UNCOMPLETE
end

function M:is_need_show_red(linear_id)
  local info = linear_list[linear_id]
  if not info.data then
    return false
  end
  if info.data.condition_open and info.data.front_open and info.data.tip then
    return true
  end
  return false
end

function M:refresh_red()
  for group_id, list in pairs(group_linear_list) do
    local group_red = false
    local red_id = self:get_red_id(group_id)
    if not group_red then
      local award_star_list = group_award_cfg_list[group_id]
      if not award_star_list then
        Log.Error(Util.format_str("吊坠组星级表找不到组id:{1},请检查配置", group_id))
      end
      for i, award_star_cfg in pairs(award_star_list) do
        local award_red = self:get_award_state(award_star_cfg.Id) == CommonDef.JOURNEY_STATE.COMPLETE
        if award_red then
          group_red = award_red
          break
        end
      end
    end
    RedPointMgr:enable_dynamic_redpoint(red_id, Global.red_enum.FIGHT_LINEAR_RED, group_red)
  end
end

function M:get_red_id(id)
  return id + 10000
end

function M:request_linear_award(star_id, callback)
  local body = {star_id = star_id}
  Network:call("c2gs_linear_gain_star_award", body, function(ok, resp)
    if ok then
      if not finish_star_list then
        finish_star_list = {}
      end
      finish_star_list[#finish_star_list + 1] = star_id
      self:refresh_red()
      MsgGame:mq_publish2(Const.MSG_ON_LINEAR_STAR_AWARD_RECEIVE)
      if callback then
        callback(resp)
      end
    end
  end)
end

function M:request_remove_tips_with_epi_id(epi_id, callback)
  local id = self:get_id_with_epi_id(epi_id)
  self:request_remove_tips(id, callback)
end

function M:request_remove_tips(id, callback)
  local body = {id = id}
  Network:call("c2gs_linear_remove_tip", body, function(ok, resp)
    if ok and callback then
      linear_list[id].data.tip = false
      self:refresh_red()
      callback(resp)
    end
  end)
end

return M
