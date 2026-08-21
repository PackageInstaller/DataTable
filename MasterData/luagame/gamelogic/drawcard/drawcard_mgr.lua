local Base = require("gamelogic.base_system")
local TableUtil = require("utils.util_table")
local LocalStorage = require("utils.localstorage")
local Helper = require("uimodule.ui_draw_card.drawcard_helper")
local _tinsert = table.insert
local _tremove = table.remove
local _tsort = table.sort
local _os_time = os.time
local HISTORY_CNT = 10
local DRAW_CARD_ENTRY_RED_ID = 23
local MAX_LOCAL_SAVE_RED_SIZE = 50
local buddy_select_id_list
local system_open_time = 0
local RecvordVO = Util.create_class()

function RecvordVO:_init(id, cnt, time, sort_value)
  self.id = id
  self.cnt = cnt
  self.time = time
  self.sort_value = sort_value
end

local PoolVO = Util.create_class()

function PoolVO:_init(group_vo, data)
  self.id = data.id
  self.draw_cnt = data.draw_cnt
  self.free_cnts = data.free_cnts
  self.guarantee_cur = 0
  self.guarantee_max = 0
  self.day_limit_cnt = data.day_limit_cnt
  self.choose_id = data.choose_id or 0
  self.v_group_vo = group_vo
  self.v_config = ShareRes.get_drawcard_pool(self.id)
  self:_calc_guarantee_cnt()
end

function PoolVO:_calc_guarantee_cnt()
  local config = self.v_config
  if not config then
    Log.Error("卡池配置为空:" .. self.id)
    self.guarantee_max = 0
    self.guarantee_cur = 0
    return
  end
  local len = #config.Guarantee
  assert(len > 0, "lack guarantee config, pool id = " .. self.id)
  local target_guarantee_id
  for i = len, 1, -1 do
    if 0 ~= config.Guarantee[i] then
      target_guarantee_id = config.Guarantee[i]
      break
    end
  end
  assert(target_guarantee_id, "find guarantee fail, config error, pool id = " .. self.id)
  local trigger_count = ShareRes.get_drop_guarantee_limit(target_guarantee_id)
  self.guarantee_max = trigger_count or 0
  local search_id = target_guarantee_id
  self.guarantee_cur = self.v_group_vo:get_guarantee_cnt_by_id(search_id) or 0
end

function PoolVO:get_config()
  return self.v_config
end

local GroupVO = Util.create_class()

function GroupVO:_init(data)
  self.id = 0
  self.v_remove_pool_dic = {}
  self.v_pool_dic = {}
  self.v_guarantee_dic = {}
  self.v_history_record_list = {}
  self:_init_data(data)
end

function GroupVO:_init_data(data)
  self.id = data.id
  self:_refresh_guarantee(data.guarantee_list)
  self:_init_history_record(data.draw_record_list)
  if data.draw_pool_list then
    local pool_vo
    for _, pool_data in ipairs(data.draw_pool_list) do
      pool_vo = PoolVO:new(self, pool_data)
      self.v_pool_dic[pool_data.id] = pool_vo
    end
  end
end

function GroupVO:get_all_pool_vo()
  return self.v_pool_dic
end

function GroupVO:get_pool_vo(pool_id)
  return self.v_pool_dic[pool_id]
end

function GroupVO:get_record_limit()
  local group_config = ShareRes.get_draw_pool_group(self.id)
  return 1 == group_config.SaveType and group_config.Arg[1] or group_config.Arg[2]
end

function GroupVO:_check_is_cnt_limited(pool_vo)
  local config = pool_vo:get_config()
  local limit_cnt = config.Count
  if config.Type == Helper.POOL_TYPE.CNT_LIMIT and limit_cnt <= pool_vo.draw_cnt then
    return true
  end
  return false
end

local function _history_sorter(a, b)
  if a.time ~= b.time then
    return a.time < b.time
  end
  return a.sort_value < b.sort_value
end

local _resocrd_sort_cnt = 0

local function _next_sort_cnt()
  _resocrd_sort_cnt = _resocrd_sort_cnt + 1
  return _resocrd_sort_cnt
end

function GroupVO:_init_history_record(record_list)
  if nil == record_list then
    return
  end
  local vo
  for i, data in ipairs(record_list) do
    vo = RecvordVO:new(data.id, data.cnt, data.time, _next_sort_cnt())
    self.v_history_record_list[i] = vo
  end
  _tsort(self.v_history_record_list, _history_sorter)
end

function GroupVO:local_add_records(record_list, time)
  local vo
  for _, data in ipairs(record_list) do
    vo = RecvordVO:new(data.id, data.cnt, data.time or time, _next_sort_cnt())
    _tinsert(self.v_history_record_list, vo)
  end
  _tsort(self.v_history_record_list, _history_sorter)
  local len = #self.v_history_record_list
  local record_limit = self:get_record_limit()
  while len > record_limit do
    _tremove(self.v_history_record_list, 1)
    len = len - 1
  end
end

function GroupVO:get_history_record_list()
  return self.v_history_record_list
end

function GroupVO:get_guarantee_cnt_by_id(id)
  return self.v_guarantee_dic[id]
end

function GroupVO:_refresh_guarantee(guarantee_list)
  if nil == guarantee_list then
    return
  end
  for _, data in ipairs(guarantee_list) do
    self.v_guarantee_dic[data.id] = data.cnt
  end
  if self.v_pool_dic then
    for _, pool in pairs(self.v_pool_dic) do
      pool:_calc_guarantee_cnt()
    end
  end
end

function GroupVO:remove_pool(pool_id)
  self.v_remove_pool_dic[pool_id] = true
  self.v_pool_dic[pool_id] = nil
  local msg = MsgGame:mq_publish2(Const.MSG_DRAW_GROUP_UPDATE)
  msg.mm_obj = self.id
end

function GroupVO:update_pool(data)
  if self.v_remove_pool_dic[data.id] then
    return
  end
  local pool_vo = PoolVO:new(self, data)
  self.v_pool_dic[data.id] = pool_vo
  local msg = MsgGame:mq_publish2(Const.MSG_DRAW_GROUP_UPDATE)
  msg.mm_obj = self.id
end

function GroupVO:update_after_draw(draw_result_list, time, draw_pool, guarantee_list)
  self:_refresh_guarantee(guarantee_list)
  if draw_result_list and #draw_result_list > 0 then
    self:local_add_records(draw_result_list, time)
  end
  self:update_pool(draw_pool)
end

local M = Util.create_child_mt(Base)

function M:init_sys()
  Base.init_sys(self)
  self:_reset_data()
  self.v_history_red_dic = nil
  self.v_history_red_list = nil
  self:sys_mq_bind(Const.MSG_ON_DAILY_RESET, self._check_enable_red_all, self)
end

function M:_reset_data()
  self.v_group_list = {}
  self.v_group_dic = {}
  self.v_cache_refresh_list = false
end

function M:_reset_all_group(data_list)
  self:_reset_data()
  if data_list then
    for _, group_data in ipairs(data_list) do
      self:_add_group(group_data)
    end
  end
  MsgGame:mq_publish2(Const.MSG_DRAW_GROUP_LIST_UPDATE)
end

function M:_append_red_to_local(pool_id)
  self:_try_load_red_from_local()
  if self.v_history_red_dic[pool_id] then
    return
  end
  local len = #self.v_history_red_list
  if len >= MAX_LOCAL_SAVE_RED_SIZE then
    _tremove(self.v_history_red_list, 1)
    self.v_history_red_dic[pool_id] = nil
  end
  _tinsert(self.v_history_red_list, {
    id = pool_id,
    date = _os_time()
  })
  self.v_history_red_dic[pool_id] = true
  LocalStorage:save_table(self:_get_red_store_key(), self.v_history_red_list)
end

function M:_get_red_store_key()
  return Config.LOCAL_STORE_DRAW_KEY .. Global.player_uuid
end

function M:_try_load_red_from_local()
  if self.v_history_red_list == nil then
    self.v_history_red_dic = {}
    self.v_history_red_list = {}
    local data = LocalStorage:load_table(self:_get_red_store_key()) or {}
    for _, record in pairs(data) do
      self.v_history_red_dic[record.id] = true
      _tinsert(self.v_history_red_list, record)
    end
    _tsort(self.v_history_red_list, function(a, b)
      return a.date < b.date
    end)
  end
end

function M:_has_watch_red(pool_id)
  self:_try_load_red_from_local()
  return self.v_history_red_dic[pool_id]
end

function M:_check_enable_red_all()
  if self.v_group_dic then
    for k, group_vo in pairs(self.v_group_dic) do
      self:_check_enable_red_group(group_vo)
    end
  end
end

function M:_check_enable_red_group(group_vo)
  if nil == group_vo then
    return
  end
  local all_pool = group_vo:get_all_pool_vo()
  for id, pool_vo in pairs(all_pool) do
    self:_check_enable_red_pool(pool_vo, false)
  end
  MsgGame:mq_publish2(Const.MSG_DRAW_GROUP_RED_CHANGE)
end

function M:_check_enable_red_pool(pool_vo, send_msg)
  if nil == pool_vo then
    return
  end
  local id = pool_vo.id
  local is_red = false
  local pool_config = pool_vo:get_config()
  if pool_config.Type == Helper.POOL_TYPE.TIME_LIMIT then
    local has_watch_red = self:_has_watch_red(id)
    is_red = not has_watch_red
  end
  is_red = is_red or self:check_choose_pool_id_red(id)
  is_red = is_red or self:check_pool_has_free_draw(pool_config.LimitedTimeFreeId)
  RedPointMgr:enable_dynamic_redpoint(id, DRAW_CARD_ENTRY_RED_ID, is_red)
  if send_msg then
    MsgGame:mq_publish2(Const.MSG_DRAW_GROUP_RED_CHANGE)
  end
end

function M:_clear_group_red(group_vo)
  if nil == group_vo then
    return
  end
  local all_pool = group_vo:get_all_pool_vo()
  for id, pool_vo in pairs(all_pool) do
    RedPointMgr:enable_dynamic_redpoint(id, DRAW_CARD_ENTRY_RED_ID, false)
  end
end

function M:_clear_pool_red(pool_id)
  RedPointMgr:enable_dynamic_redpoint(pool_id, DRAW_CARD_ENTRY_RED_ID, false)
end

function M:_add_group(group_data)
  assert(self.v_group_dic[group_data.id] == nil, "already has group")
  local group_vo = GroupVO:new(group_data)
  self.v_group_dic[group_vo.id] = group_vo
  _tinsert(self.v_group_list, group_vo)
  self:_check_enable_red_group(group_vo)
end

function M:_remove_pool(group_id, pool_id)
  local group_vo = self:_get_group_vo(group_id)
  if nil == group_vo then
    return
  end
  group_vo:remove_pool(pool_id)
  self:_clear_pool_red(pool_id)
  MsgGame:mq_publish2(Const.MSG_DRAW_GROUP_LIST_UPDATE)
end

function M:_remove_group(group_id, is_emit_msg)
  local group_vo = self:_get_group_vo(group_id)
  if group_vo then
    self:_clear_group_red(group_vo)
    TableUtil.list_delete_by_value(self.v_group_list, group_vo)
  end
  self.v_group_dic[group_id] = nil
  if is_emit_msg then
    MsgGame:mq_publish2(Const.MSG_DRAW_GROUP_LIST_UPDATE)
  end
end

function M:_update_group(group_data)
  self:_remove_group(group_data.id, false)
  self:_add_group(group_data)
  MsgGame:mq_publish2(Const.MSG_DRAW_GROUP_LIST_UPDATE)
end

function M:_update_pool(group_id, pool_data)
  local group_vo = self:_get_group_vo(group_id)
  if group_vo then
    local add_new_pool = group_vo:get_pool_vo(pool_data.id) == nil
    group_vo:update_pool(pool_data)
    self:_check_enable_red_pool(add_new_pool, true)
    if add_new_pool then
      MsgGame:mq_publish2(Const.MSG_DRAW_GROUP_LIST_UPDATE)
    end
  end
end

function M:_get_group_vo(group_id)
  return self.v_group_dic[group_id]
end

function M:_update_free_draw_data(data)
  self.v_free_draw_data = {}
  for _, v in ipairs(data) do
    if not self.v_free_draw_data[v.id] then
      self.v_free_draw_data[v.id] = {}
    end
    self.v_free_draw_data[v.id][v.index] = v.count
  end
  if self.v_group_dic then
    for k, group_vo in pairs(self.v_group_dic) do
      self:_check_enable_red_group(group_vo)
    end
  end
  MsgGame:mq_publish2(Const.MSG_DRAW_FREE_DATA_UPDATE)
end

function M:get_free_draw_times(free_draw_id, btn_idx)
  if not free_draw_id then
    return 0
  end
  local cfg = ShareRes.get_drawcard_free_times_cfg(free_draw_id)
  if not cfg then
    return 0
  end
  local use_times = self.v_free_draw_data and self.v_free_draw_data[free_draw_id] and self.v_free_draw_data[free_draw_id][btn_idx] or 0
  local left_times = (cfg.FreeCount[btn_idx] or 0) - use_times
  left_times = left_times > 0 and left_times or 0
  if 0 ~= left_times then
    local server_time = Date.server_time()
    local start_time = cfg.StartTime and Date.get_time_stamp_by_scheme_id(cfg.StartTime)
    if start_time and server_time > start_time then
      local end_time = cfg.EndTime and Date.get_time_stamp_by_scheme_id(cfg.EndTime)
      if end_time and server_time < end_time then
        return left_times, cfg.DailyRefresh == true
      end
    end
  end
  return 0
end

function M:check_pool_has_free_draw(free_draw_id)
  return self:get_free_draw_times(free_draw_id, 1) > 0 or self:get_free_draw_times(free_draw_id, 2) > 0
end

function M:recv_draw_group_list(data)
  buddy_select_id_list = data.buddy_select_id_list
  system_open_time = data.system_open_time
  self:_reset_all_group(data.draw_group)
end

function M:recv_draw_group_update(data)
  self:_update_group(data.draw_group)
end

function M:recv_draw_pool_close(data)
  self:_remove_pool(data.draw_group_id, data.draw_pool_id)
end

function M:recv_draw_group_close(data)
  self:_remove_group(data.draw_group_id, true)
end

function M:recv_draw_pool_update(data)
  self:_update_pool(data.draw_group_id, data.draw_pool)
end

function M:recv_draw_pool_info(data)
end

function M:recv_free_draw_data(data)
  self:_update_free_draw_data(data.free_draw)
end

function M:send_draw(draw_group_id, draw_pool_id, cnt_index, callback, fail_callback)
  Network:call("c2gs_draw", {
    draw_group_id = draw_group_id,
    draw_pool_id = draw_pool_id,
    cnt_index = cnt_index
  }, function(ok, resp)
    if true == ok and 0 == resp.errcode then
      Log.Info("c2gs_draw-------", resp)
      local group_vo = self:_get_group_vo(draw_group_id)
      if group_vo then
        group_vo:update_after_draw(resp.draw_result, resp.time, resp.draw_pool, resp.guarantee_list)
      end
      self.v_draw_result_handle = resp
      if callback then
        callback(resp.draw_result, resp.extra_item_list)
      end
    elseif fail_callback then
      fail_callback()
    end
  end)
end

function M:send_draw_choose_id(draw_group_id, draw_pool_id, draw_popl_choose_id, callback)
  Network:protect_call("c2gs_set_choose_pool_draw_id", {
    draw_group_id = draw_group_id,
    draw_pool_id = draw_pool_id,
    draw_popl_choose_id = draw_popl_choose_id
  }, function(ok, resp)
    if true == ok and 0 == resp.errcode then
      local pool_vo = self:get_pool_vo(draw_group_id, draw_pool_id)
      if pool_vo then
        pool_vo.choose_id = draw_popl_choose_id
      end
      if callback then
        callback(draw_popl_choose_id)
      end
      MsgGame:mq_publish2(Const.MSG_DRAW_ON_SELECTABLE_POOL_UPDATE)
    end
  end)
end

function M:get_system_open_time()
  return system_open_time
end

function M:get_last_history_record(group_id)
  local group_vo = self:_get_group_vo(group_id)
  if group_vo then
    return group_vo:get_history_record_list()
  end
  return {}
end

function M:get_group_list()
  return self.v_group_list
end

function M:exist_group(group_id)
  return self:_get_group_vo(group_id) ~= nil
end

function M:get_pool_vo(group_id, pool_id)
  local group_vo = self:_get_group_vo(group_id)
  return nil ~= group_vo and group_vo:get_pool_vo(pool_id)
end

function M:watche_red(pool_id)
  local is_need_show_red = self:check_choose_pool_id_red(pool_id)
  if not is_need_show_red then
    local pool_config = ShareRes.get_drawcard_pool(pool_id)
    is_need_show_red = self:check_pool_has_free_draw(pool_config.LimitedTimeFreeId)
  end
  RedPointMgr:enable_dynamic_redpoint(pool_id, DRAW_CARD_ENTRY_RED_ID, is_need_show_red)
  self:_append_red_to_local(pool_id)
  MsgGame:mq_publish2(Const.MSG_DRAW_GROUP_RED_CHANGE)
end

function M:get_entry_red_id()
  return DRAW_CARD_ENTRY_RED_ID
end

function M:try_show_extra_item_list(data_list)
  if nil == data_list or #data_list <= 0 then
    return
  end
  local award_dic = {}
  local last_item
  for _, item in ipairs(data_list) do
    if item.has_extra then
      last_item = award_dic[item.extra_id]
      if last_item then
        last_item.count = last_item.count + item.extra_num
      else
        last_item = {
          id = item.extra_id,
          count = item.extra_num
        }
        award_dic[item.extra_id] = last_item
      end
    end
  end
  local award_list = {}
  for _, item in pairs(award_dic) do
    _tinsert(award_list, item)
  end
  if #award_list > 0 then
    UIMgr:get_ui("award_show_panel"):ui_show(award_list)
  end
end

function M:get_draw_result()
  if not self.v_draw_result_handle then
    return
  end
  local draw_result_list = self.v_draw_result_handle.draw_result
  if nil == draw_result_list or #draw_result_list <= 0 then
    return
  end
  return draw_result_list
end

function M:try_show_movie(do_skip)
  if not self.v_draw_result_handle then
    return
  end
  local draw_result_list = self.v_draw_result_handle.draw_result
  local extra_list = self.v_draw_result_handle.extra_item_list
  if nil == draw_result_list or #draw_result_list <= 0 then
    return
  end
  local data_list = {}
  local extra_dic = {}
  if extra_list then
    for _, item in ipairs(extra_list) do
      extra_dic[item.index] = item
    end
  end
  local new_items = {}
  local extra_id, extra_count, has_extra
  for i, result_item in ipairs(draw_result_list) do
    local is_new = result_item.new
    if is_new then
      if new_items[result_item.id] then
        is_new = false
      else
        new_items[result_item.id] = true
      end
    end
    has_extra = false
    extra_id = 0
    extra_count = 0
    if extra_dic[i] then
      has_extra = true
      extra_id = extra_dic[i].id
      extra_count = extra_dic[i].count
    end
    data_list[i] = {
      item_id = result_item.id,
      is_new = is_new,
      has_extra = has_extra,
      extra_id = extra_id,
      extra_num = extra_count,
      get_index = i
    }
  end
  local show_white_mask = not do_skip
  do_skip = do_skip and 1 ~= #data_list
  UIMgr:get_ui("uidrawcard_movie_panel"):ui_show(data_list, do_skip, nil, show_white_mask)
  self.v_draw_result_handle = nil
  return true
end

function M:get_next_choose_config(card_pool_id)
  local not_choose_configs = self:get_not_choose_configs(card_pool_id)
  if not not_choose_configs then
    return nil
  end
  table.sort(not_choose_configs, function(a, b)
    return a.Count < b.Count
  end)
  return not_choose_configs[1]
end

function M:is_choose_finish(choose_id)
  if not buddy_select_id_list then
    return false
  end
  for i, config_id in pairs(buddy_select_id_list) do
    if choose_id == config_id then
      return true
    end
  end
  return false
end

function M:get_not_choose_configs(card_pool_id)
  local configs = self:get_all_choose_configs()
  local not_choose_list = {}
  for _, config in pairs(configs) do
    local is_choose = self:is_choose_finish(config.Id)
    if is_choose then
    else
      for _, draw_pool_id in pairs(config.DrawPool) do
        if draw_pool_id == card_pool_id then
          table.insert(not_choose_list, config)
          break
        end
      end
    end
  end
  return not_choose_list
end

function M:get_all_choose_configs()
  return ShareRes.create("draw.draw_select_reward")
end

function M:get_curr_card_pool_draw_count(card_pool_id)
  local next_cfg = self:get_next_choose_config(card_pool_id)
  local group_list = self:get_group_list()
  local count = 0
  for _, draw_pool_id in pairs(next_cfg.DrawPool) do
    for i, group_data in pairs(group_list) do
      local pool_vo = group_data:get_pool_vo(draw_pool_id)
      if pool_vo then
        count = count + pool_vo.draw_cnt
      end
    end
  end
  return count
end

function M:check_choose_pool_id_red(card_pool_id)
  local next_choose_config = self:get_next_choose_config(card_pool_id)
  if not next_choose_config then
    return false
  end
  local draw_count = self:get_curr_card_pool_draw_count(card_pool_id)
  return draw_count >= next_choose_config.Count
end

function M:get_choose_award(choose_id, choose_buddy_id, cb)
  local send_data = {id = choose_id, select_buddy_id = choose_buddy_id}
  Network:call("c2gs_select_draw_buddy", send_data, function(ok, resp)
    if true == ok and 0 == resp.errcode then
      if nil == buddy_select_id_list then
        buddy_select_id_list = {}
      end
      table.insert(buddy_select_id_list, choose_id)
      if cb then
        cb()
      end
    end
  end)
end

local DRAW_SELECTABLE_ITEM_BEGIN_TIME_MARK = "DRAW_SELECTABLE_ITEM_BEGIN_TIME_MARK"

function M:check_selectable_item_any_new(pool_id)
  local pool_config = ShareRes.get_drawcard_pool(pool_id)
  local args = pool_config.Arg
  if 4 ~= pool_config.Type or not args then
    return false
  end
  for _, group in pairs(args) do
    if 0 ~= group then
      local choose_group_cfg = ShareRes.create("draw.draw_pool_choose_group")
      for _, cfg in pairs(choose_group_cfg) do
        local begin_time = cfg.BeginTime and Date.get_time_stamp_by_scheme_id(cfg.BeginTime)
        if group == cfg.Group and (not begin_time or begin_time < Date.server_time()) and self:check_selectable_item_new(cfg.ItemId, begin_time) then
          return true
        end
      end
    end
  end
  return false
end

function M:check_selectable_item_new(item_id, begin_time)
  if not item_id or not begin_time then
    return false
  end
  if not self.v_new_selectable_item_mark then
    self.v_new_selectable_item_mark = LocalStorage:load_table(DRAW_SELECTABLE_ITEM_BEGIN_TIME_MARK, true)
  end
  local data = self.v_new_selectable_item_mark
  if not data or not data[item_id] then
    return true
  end
  return begin_time > data[item_id]
end

function M:clear_selectable_item_new(item_id, begin_time)
  if not item_id or not begin_time then
    return
  end
  if not self.v_new_selectable_item_mark then
    self.v_new_selectable_item_mark = LocalStorage:load_table(DRAW_SELECTABLE_ITEM_BEGIN_TIME_MARK, true) or {}
  end
  local data = self.v_new_selectable_item_mark
  data[item_id] = begin_time
  LocalStorage:save_table(DRAW_SELECTABLE_ITEM_BEGIN_TIME_MARK, self.v_new_selectable_item_mark, true)
end

function M:get_selectable_pool_choose_tag_icon(group_id, pool_id)
  local pool_vo = self:get_pool_vo(group_id, pool_id)
  if nil == pool_vo then
    return
  end
  local choose_id = pool_vo.choose_id
  if not choose_id or 0 == choose_id then
    return
  end
  local choose_cfg = ShareRes.create("draw.draw_pool_choose_group", choose_id)
  if not choose_cfg then
    return
  end
  return choose_cfg.TagIcon
end

return M
