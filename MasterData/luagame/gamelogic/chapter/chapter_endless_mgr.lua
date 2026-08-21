local Base = require("gamelogic.base_system")
local _tinsert = table.insert
local M = Util.create_child_mt(Base)
local LocalStorage = require("utils.localstorage")

function M:exit_tower()
end

function M:init_sys()
  Base.init_sys(self)
  self:reset_data()
  self:register_events()
end

function M:on_reconnect()
  self:reset_data()
end

function M:reset_data()
  self.v_inf_chapter_map = {}
  self.v_cur_infinite_id_list = {}
  self:load_select_entry_info()
  self.v_endless_unlock_entry_map = {}
  self.v_endless_end_time = 0
  self.v_endless_award_bit = 0
end

function M:register_events()
end

function M:update_unlock_entry_list(entry_list)
  for key, entry_id in pairs(entry_list) do
    self.v_endless_unlock_entry_map[entry_id] = entry_id
  end
end

function M:update_unlock_entry(data)
  self.v_endless_unlock_entry_map[data.entry_id] = data.entry_id
end

function M:check_entry_is_unlock(entry_id)
  return self.v_endless_unlock_entry_map[entry_id] ~= nil
end

function M:update_endless_award_bit(award_bit)
  self.v_endless_award_bit = award_bit
end

function M:get_endless_award_bit()
  return self.v_endless_award_bit
end

function M:update_endless_end_time(end_time)
  self.v_endless_end_time = end_time
end

function M:get_endless_end_time()
  return self.v_endless_end_time
end

function M:get_endless_is_unlock(infinite_id)
  local data = ChapterMgr:get_inf_chapter_data(infinite_id)
  return nil ~= data
end

function M:get_endless_is_open(infinite_id)
  local data = ChapterMgr:get_inf_chapter_data(infinite_id)
  return data and data.is_open
end

function M:get_endless_score(infinite_id)
  local data = ChapterMgr:get_inf_chapter_data(infinite_id)
  return data and data.score
end

function M:get_endless_total_score()
  local map = ChapterMgr:get_inf_chapter_map()
  local socre = 0
  local cfg
  for key, data in pairs(map) do
    cfg = ShareRes.get_inf_chapter_cfg(data.id)
    if cfg and cfg.Type == Config.CommonDefine.INFINITE_EPISODE_TYPE.WEEK then
      socre = data.score + socre
    end
  end
  return socre
end

function M:record_infinite_select_entry(infinite_id, map)
  local old_map = self.v_endless_select_entry[infinite_id]
  if old_map then
    UtilTable.clear_map(old_map)
  else
    self.v_endless_select_entry[infinite_id] = {}
    old_map = self.v_endless_select_entry[infinite_id]
  end
  for group_id, entry_id in pairs(map) do
    old_map[group_id] = entry_id
  end
  self:save_select_entry_info()
end

function M:get_infinite_select_entry(infinite_id)
  return self.v_endless_select_entry[infinite_id]
end

function M:infinite_selected_entry_save(infinite_id, entry_map)
  self:record_infinite_select_entry(infinite_id, entry_map)
  local entry_list = {}
  for group_id, entry_id in pairs(entry_map) do
    entry_list[#entry_list + 1] = {group_id = group_id, entry_id = entry_id}
  end
  Network:call("c2gs_infinite_selected_entry_save", {entry_list = entry_list, infinite_id = infinite_id})
end

function M:infinite_sweep_episode(infinite_id, cb)
  Network:call("c2gs_infinite_sweep_episode", {infinite_id = infinite_id}, function(ok, resp)
    if ok and cb then
      cb(resp)
    end
  end)
end

local function sort_func(a, b)
  if a.Priority ~= b.Priority then
    return a.Priority < b.Priority
  else
    return false
  end
end

function M:get_infinite_list()
  local all_infinite_cfg = ShareRes.get_inf_chapter_cfg()
  local infinite_list = {}
  local map = ChapterMgr:get_inf_chapter_map()
  if not map or not all_infinite_cfg then
    Log.Error("获取无尽章节数据失败")
    return
  end
  local infinite_id, infinite_data
  for key, cfg in pairs(all_infinite_cfg) do
    infinite_id = cfg.Id
    infinite_data = map[infinite_id]
    if not infinite_data or infinite_data.is_open then
      infinite_list[#infinite_list + 1] = cfg
    end
  end
  table.sort(infinite_list, sort_func)
  return infinite_list, infinite_id, map
end

function M:get_endless_red_state()
  local infinite_list, infinite_id, map = ChapterEndlessMgr:get_infinite_list()
  local total_score = 0
  local score
  for key, cfg in ipairs(infinite_list) do
    infinite_id = cfg.Id
    if cfg.Type == Config.CommonDefine.INFINITE_EPISODE_TYPE.WEEK then
      score = ChapterEndlessMgr:get_endless_score(infinite_id)
      total_score = total_score + (score or 0)
    end
  end
  local is_need_show_red = false
  local all_cfg = ShareRes.get_infinite_score_award()
  local award_bit = ChapterEndlessMgr:get_endless_award_bit()
  local has_comp, has_get = false, false
  for key, cfg in pairs(all_cfg) do
    has_comp = total_score >= cfg.Score
    has_get = 1 == (award_bit >> cfg.Id - 1) % 2
    if has_comp and not has_get then
      is_need_show_red = true
      break
    end
  end
  if not is_need_show_red then
    local task_group_id = ShareRes.get_endless_progress_task_group()
    is_need_show_red = TaskMgr:get_task_group_red(task_group_id)
  end
  return is_need_show_red
end

function M:get_curr_period_endless_enter_finish()
  local is_enter_finish_time = PlayerPrefsMgr:get_curr_period_endless_enter_finish()
  if 0 == is_enter_finish_time or is_enter_finish_time < Date.server_time() then
    return true
  end
  return false
end

function M:refresh_endless_enter_finish()
  local is_enter_finish_time = PlayerPrefsMgr:get_curr_period_endless_enter_finish()
  if 0 == is_enter_finish_time or is_enter_finish_time < Date.server_time() then
    PlayerPrefsMgr:set_curr_period_endless_enter_finish(self.v_endless_end_time)
    MsgGame:mq_publish2(Const.MSG_ON_WEEKLY_ENDLESS_RED_REFRESH)
  end
end

local last_select_infinite_id

function M:set_last_select_infinite_id(select_infinite_id)
  last_select_infinite_id = select_infinite_id
end

function M:get_last_select_infinite_id()
  return last_select_infinite_id
end

function M:is_week_infinite_open()
  return false
end

function M:save_select_entry_info()
  LocalStorage:save_table(Config.ENDLESS_ENTRY_SELECT_KEY, self.v_endless_select_entry, true)
end

function M:load_select_entry_info()
  self.v_endless_select_entry = LocalStorage:load_table(Config.ENDLESS_ENTRY_SELECT_KEY, true)
  if not self.v_endless_select_entry then
    self.v_endless_select_entry = {}
    return
  end
  self:load_select_entry_info_check()
end

function M:load_select_entry_info_check()
  local INFINITE_ENTRY_TYPE = Config.CommonDefine.INFINITE_ENTRY_TYPE
  local gain_count, negative_count = 0, 0
  local gain_limit, negative_limit, point_cfg, entry_cfg, group_cfg, resave, group_map
  for infinite_id, select_entry_map in pairs(self.v_endless_select_entry) do
    point_cfg = ShareRes.get_inf_chapter_cfg(infinite_id)
    if point_cfg then
      if point_cfg.OptionGroup then
        group_map = {}
        for _, option_group in pairs(point_cfg.OptionGroup) do
          group_map[option_group] = true
        end
      else
        self.v_endless_select_entry[infinite_id] = nil
        resave = true
        goto lbl_97
      end
      gain_limit = point_cfg.GainEntryLimit
      negative_limit = point_cfg.NegativeEntryLimit
      for group_id, entry_id in pairs(select_entry_map) do
        group_cfg = ShareRes.get_infinite_entry_group_cfg(group_id)
        entry_cfg = ShareRes.get_infinite_entry_cfg(entry_id)
        if entry_cfg and group_cfg then
          if not group_map[group_cfg.OwnerOptionGroup] then
            self.v_endless_select_entry[infinite_id] = nil
            resave = true
            break
          end
          if entry_cfg.Type == INFINITE_ENTRY_TYPE.GAIN then
            gain_count = gain_count + 1
          elseif entry_cfg.Type == INFINITE_ENTRY_TYPE.NEGATIVE then
            negative_count = negative_count + 1
          end
        else
          select_entry_map[group_id] = nil
          resave = true
        end
      end
      if gain_limit < gain_count or negative_limit < negative_count then
        self.v_endless_select_entry[infinite_id] = nil
        resave = true
      else
      end
    else
      self.v_endless_select_entry[infinite_id] = nil
      resave = true
      goto lbl_97
    end
    ::lbl_97::
  end
  if resave then
    self:save_select_entry_info()
  end
end

return M
