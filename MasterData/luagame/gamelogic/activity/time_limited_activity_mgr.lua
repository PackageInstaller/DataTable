local Base = require("gamelogic.base_system")
local M = Util.create_child_mt(Base)
local commonDef = require("cs_share.common_define")
local LocalStorage = require("utils.localstorage")
local VERSION_ACTIVITY_KEY = "VERSION_ACTIVITY"
local minigame_cfg = ShareRes.create("activity.activity_mini_game")
local time_limited_activity_detail = ShareRes.create("activity.time_limited_activity_detail")
local TASK_STATE = Config.TASK_STATE
M.Type = {
  MainLine = 1,
  CharTryout = 2,
  MiniGame = 3,
  MusicGame = 4,
  PuzzleGame = 5,
  FishGame = 6,
  BarbecueGame = 7,
  SummerFight = 8,
  SummerShop = 9,
  MainSceneFashion = 10,
  SummerActivity = 11,
  MazeGame = 12,
  MineSweeper = 13
}
M.MINIGAME_ACTIVITY_KEY = "MINIGAME_ACTIVITY"
M.redpoint = {
  RedEnum.TIME_LIMITED_ACTIVITY_BTN_1,
  RedEnum.TIME_LIMITED_ACTIVITY_BTN_2,
  RedEnum.TIME_LIMITED_ACTIVITY_BTN_3,
  RedEnum.TIME_LIMITED_ACTIVITY_BTN_4,
  RedEnum.TIME_LIMITED_ACTIVITY_BTN_5,
  RedEnum.TIME_LIMITED_ACTIVITY_BTN_6,
  RedEnum.TIME_LIMITED_ACTIVITY_BTN_7,
  RedEnum.TIME_LIMITED_ACTIVITY_BTN_8
}
M.summer_red_list = {
  RedEnum.SUMMER_ACTIVITY_BTN_1,
  RedEnum.SUMMER_ACTIVITY_BTN_2,
  RedEnum.SUMMER_ACTIVITY_BTN_3,
  RedEnum.SUMMER_ACTIVITY_BTN_4
}
local get_time_by_type = {
  [M.Type.MainLine] = function(cfg)
    local chapter_id = tonumber(cfg.Param[1])
    local chapter_cfg = ShareRes.get_chapter_cfg(chapter_id)
    local start_timestamp = chapter_cfg.PreOpenStartTime and Date.get_time_stamp_by_scheme_id(chapter_cfg.PreOpenStartTime)
    local end_timestamp = chapter_cfg.PreOpenEndTime and Date.get_time_stamp_by_scheme_id(chapter_cfg.PreOpenEndTime)
    return start_timestamp, end_timestamp
  end
}

local function tmp_fun(cfg)
  local activity_id = tonumber(cfg.Param[1])
  local activity_cfg = ShareRes.create("activity.routine_activity")[activity_id]
  local condition_id = activity_cfg.Condition
  local condition_check = Condition.check_condition(condition_id)
  local left_time = 0
  if condition_check then
    local valid, start_timestamp, end_timestamp
    local server_time = Date.server_time()
    if activity_cfg.TimeType == NoviceMgr.ACTIVITY_TIME_TYPE.UNLIMITEDTIME then
      valid = true
    else
      start_timestamp = Date.get_time_stamp_by_scheme_id(activity_cfg.OpenTime)
      end_timestamp = Date.get_time_stamp_by_scheme_id(activity_cfg.StopTime)
      valid = start_timestamp and server_time > start_timestamp and end_timestamp and server_time < end_timestamp
    end
    if valid then
      local tips
      if end_timestamp then
        left_time = end_timestamp - server_time
        tips = Date.get_time_format_7(left_time)
      end
      return true, tips, nil, nil, left_time
    else
      left_time = start_timestamp - server_time
      return false, Date.get_time_format_7(left_time), true, Date.get_time_formate_3_2(start_timestamp), left_time
    end
  else
    return false, ShareRes.get_condition_desc(condition_id), nil, nil, left_time
  end
end

local check_activity_open_fun = {
  [M.Type.MainLine] = function(cfg)
    local condition_check = Condition:check_condition(cfg.Condition)
    local left_time = 0
    if condition_check then
      local start_timestamp, end_timestamp = get_time_by_type[cfg.Type](cfg)
      local valid
      local server_time = Date.server_time()
      if start_timestamp then
        valid = start_timestamp < server_time and (end_timestamp and end_timestamp > server_time or not end_timestamp)
      else
        valid = true
      end
      if valid then
        local chapter_id = tonumber(cfg.Param[1])
        local is_open, tips = ChapterMgr:check_chapter_is_unlock(chapter_id)
        local time_check_false, open_time_tip
        if not is_open and end_timestamp then
          left_time = end_timestamp - server_time
          tips = Date.get_time_format_7(left_time)
          time_check_false = true
          open_time_tip = Date.get_time_formate_3_2(end_timestamp)
        end
        return is_open, tips, time_check_false, open_time_tip, left_time
      else
        left_time = start_timestamp - server_time
        return false, Date.get_time_format_7(left_time), true, Date.get_time_formate_3_2(start_timestamp), left_time
      end
    else
      return false, ShareRes.get_condition_desc(cfg.Condition), nil, nil, left_time
    end
  end,
  [M.Type.CharTryout] = function(cfg)
    local activity_id = tonumber(cfg.Param[1])
    local buddy_tryout_id = tonumber(cfg.Param[2])
    local activity_cfg = ShareRes.create("activity.routine_activity")[activity_id]
    local condition_id = activity_cfg.Condition
    local condition_check = Condition.check_condition(condition_id)
    local left_time = 0
    if condition_check then
      local valid, start_timestamp, end_timestamp
      local server_time = Date.server_time()
      if activity_cfg.TimeType == NoviceMgr.ACTIVITY_TIME_TYPE.UNLIMITEDTIME then
        valid = true
      else
        start_timestamp = Date.get_time_stamp_by_scheme_id(activity_cfg.OpenTime)
        end_timestamp = Date.get_time_stamp_by_scheme_id(activity_cfg.StopTime)
        valid = start_timestamp and server_time > start_timestamp and end_timestamp and server_time < end_timestamp
      end
      if valid then
        local tryout_cfg = ShareRes.get_buddy_tryout_cfg(buddy_tryout_id)
        start_timestamp = Date.get_time_stamp_by_scheme_id(tryout_cfg.StartTime)
        end_timestamp = Date.get_time_stamp_by_scheme_id(tryout_cfg.EndTime)
        valid = start_timestamp and server_time > start_timestamp and end_timestamp and server_time < end_timestamp
        if valid then
          local tips
          if end_timestamp then
            left_time = end_timestamp - server_time
            tips = Date.get_time_format_7(left_time)
          end
          return true, tips, nil, nil, left_time
        else
          left_time = start_timestamp - server_time
          return false, Date.get_time_format_7(left_time), true, Date.get_time_formate_3_2(start_timestamp), left_time
        end
      else
        left_time = start_timestamp - server_time
        return false, Date.get_time_format_7(left_time), true, Date.get_time_formate_3_2(start_timestamp), left_time
      end
    else
      return false, ShareRes.get_condition_desc(condition_id), nil, nil, left_time
    end
  end,
  [M.Type.MiniGame] = tmp_fun,
  [M.Type.MusicGame] = tmp_fun,
  [M.Type.PuzzleGame] = tmp_fun,
  [M.Type.SummerActivity] = tmp_fun,
  [M.Type.MineSweeper] = tmp_fun,
  [M.Type.MazeGame] = tmp_fun
}

local function activity_param_fun(param)
  Global.sound_mgr:play_ui_sound(Config.UI_SOUND_CFG.ui_activity_main_btn_UI_SOUND)
  local activity_id = tonumber(param[1])
  local activity_cfg = ShareRes.create("activity.routine_activity")[activity_id]
  UIMgr:get_ui(activity_cfg.UiName):ui_show(activity_id)
end

local function activity_no_param_fun(param)
  Global.sound_mgr:play_ui_sound(Config.UI_SOUND_CFG.ui_activity_main_btn_UI_SOUND)
  local activity_id = tonumber(param[1])
  local activity_cfg = ShareRes.create("activity.routine_activity")[activity_id]
  UIMgr:get_ui(activity_cfg.UiName):ui_show()
end

local function activity_shop_fun(param)
  Global.sound_mgr:play_ui_sound(Config.UI_SOUND_CFG.ui_activity_main_btn_UI_SOUND)
  local activity_id = tonumber(param[1])
  local shop_id = tonumber(param[2])
  local activity_cfg = ShareRes.create("activity.routine_activity")[activity_id]
  UIMgr:get_ui(activity_cfg.UiName):ui_show(activity_id, shop_id)
end

local jump_table = {
  [M.Type.MainLine] = function(param)
    local chapter_id = tonumber(param[1])
    UIMgr:get_ui("ui_chapter_detail"):ui_show(chapter_id)
  end,
  [M.Type.CharTryout] = function(param)
    Global.sound_mgr:play_ui_sound(Config.UI_SOUND_CFG.ui_activity_main_btn_UI_SOUND)
    local activity_id = tonumber(param[1])
    UIMgr:get_ui("ui_activity"):ui_show(activity_id, true)
  end,
  [M.Type.SummerShop] = activity_shop_fun,
  [M.Type.MusicGame] = activity_no_param_fun,
  [M.Type.PuzzleGame] = activity_no_param_fun
}

function M:get_btn_jump_fun(type)
  return jump_table[type] or activity_param_fun
end

function M:init_sys()
  Base.init_sys(self)
  self.v_activity_mini_game_info = {}
  self.v_start_time_table = {}
  self.v_end_time_table = {}
  self.v_version_activity_id = nil
  self.v_start_time_index = math.maxinteger
  self.v_end_time_index = math.maxinteger
  self.v_version_child_activity_type_list = nil
  self.v_version_child_activities_id = {}
  self.v_version_child_activities_cfg = {}
  self.v_summer_stage_state = nil
  self.v_summer_stage_activity_id = nil
  self:sys_mq_bind(Const.MSG_ON_TASK_UPDATE, self.on_task_group_update, self)
  self:sys_mq_bind(Const.MSG_ON_NOVICE_ACTIVITY_OPEN, self.on_novice_activity_update, self)
  self:sys_mq_bind(Const.MSG_ON_BUDDY_TRYOUT_DATA_UPDATE, self.on_buddytryout_activity_update, self)
  self:sys_mq_bind(Const.MSG_ON_EXCHANGE_GOODS_UPDATE, self.on_exchange_goods_update, self)
  self:sys_mq_bind(Const.MSG_ROLE_RES_CHANGE, self.on_exchange_goods_update, self)
  self:sys_mq_bind(Const.MSG_CHAPTER_NODE_COMPLETE, self.refresh_redpoint, self)
  self:sys_mq_bind(Const.MSG_ON_CHAPTER_UPDATE, self.refresh_redpoint, self)
end

function M:on_destroy()
end

function M:on_reconnect()
end

function M:on_gs2c_activity_mini_game_info(data)
  if not self.v_activity_mini_game_info[data.activity_id] then
    self.v_activity_mini_game_info[data.activity_id] = {}
  end
  local tmp = self.v_activity_mini_game_info[data.activity_id]
  for _, info in ipairs(data.mini_games) do
    tmp[info.id] = info
  end
  self:minigame_award_redpoint_update(data.activity_id)
end

function M:on_gs2c_activity_mini_game_update(data)
  if not self.v_activity_mini_game_info[data.activity_id] then
    self.v_activity_mini_game_info[data.activity_id] = {}
  end
  local tmp = self.v_activity_mini_game_info[data.activity_id]
  local new_minigame_cfg = data.mini_game
  tmp[new_minigame_cfg.id] = new_minigame_cfg
  self:minigame_award_redpoint_update(data.activity_id)
  MsgGame:mq_publish2(Const.MSG_ON_ACTIVITY_MINIGAME_UPDATE)
end

function M:get_mini_game_info()
  return self.v_activity_mini_game_info
end

function M:get_version_activity_detail_cfg()
  return self.v_version_activity_detail_cfg
end

function M:minigame_award_redpoint_update(activity_id)
  local function temp_fun(activity_id, pre_open_map)
    if not pre_open_map then
      RedPointMgr:enable_redpoint(RedEnum.MINIGAME_COMPILATION_MAIN_UI, true)
    else
      local cur_open_map = self:get_mini_game_info()[activity_id]
      local ui_redpoint = false
      for k, v in pairs(cur_open_map) do
        if v.time_open and not pre_open_map[k] then
          ui_redpoint = true
          break
        end
      end
      RedPointMgr:enable_redpoint(RedEnum.MINIGAME_COMPILATION_MAIN_UI, ui_redpoint)
    end
    local taskgroup_id = minigame_cfg[activity_id].TaskGroupId
    local task_list = ShareRes.get_task_group(taskgroup_id)
    for task_id, _ in pairs(task_list) do
      local state = TaskMgr:get_task_state(task_id)
      if state == TASK_STATE.COMPLETE then
        RedPointMgr:enable_redpoint(RedEnum.MINIGAME_COMPILATION_AWARD_UI, true)
        return
      end
    end
    RedPointMgr:enable_redpoint(RedEnum.MINIGAME_COMPILATION_AWARD_UI, false)
  end
  
  if activity_id then
    local t = self:get_store_state(self.MINIGAME_ACTIVITY_KEY)
    local pre_open_map = t and t[activity_id]
    temp_fun(activity_id, pre_open_map)
  else
    for activity_id, _ in pairs(self.v_activity_mini_game_info) do
      local t = self:get_store_state(self.MINIGAME_ACTIVITY_KEY)
      local pre_open_map = t and t[activity_id]
      temp_fun(activity_id, pre_open_map)
    end
  end
end

function M:get_store_state(key)
  return LocalStorage:load_table(key, true)
end

function M:set_store_state(key, t)
  LocalStorage:save_table(key, t, true)
end

function M:get_version_activity_id()
  return self.v_version_activity_id
end

function M:refresh_redpoint()
  if self.v_version_activity_id then
    local version_activity_detail_cfg = ShareRes.get_time_limited_activity_detail(self.v_version_activity_id)
    for _, cfg in pairs(version_activity_detail_cfg) do
      if cfg.Type == M.Type.MiniGame then
      elseif cfg.Type == M.Type.SummerActivity then
      else
        local is_open = self:is_activity_open(cfg.Id)
        if is_open then
          local t = LocalStorage:load_table(VERSION_ACTIVITY_KEY, true)
          local has_clicked = t and t[cfg.Id]
          local node = RedPointMgr:get_redpoint_node_by_id(self:get_red_point_id_list()[cfg.Node])
          if UtilTable.is_empty(node.children_nodes) then
            RedPointMgr:enable_redpoint(self:get_red_point_id_list()[cfg.Node], not has_clicked)
          end
        else
          local node = RedPointMgr:get_redpoint_node_by_id(self:get_red_point_id_list()[cfg.Node])
          if UtilTable.is_empty(node.children_nodes) then
            RedPointMgr:enable_redpoint(self:get_red_point_id_list()[cfg.Node], false)
          end
        end
      end
    end
  end
end

function M:storage_click_state(id_in_time_limited_activity)
  local t = LocalStorage:load_table(VERSION_ACTIVITY_KEY, true)
  t = t or {}
  local last_state = t[id_in_time_limited_activity]
  t[id_in_time_limited_activity] = 1
  LocalStorage:save_table(VERSION_ACTIVITY_KEY, t, true)
  if 1 ~= last_state then
    self:refresh_redpoint()
  end
end

function M:get_red_point_id_list()
  local cfg = ShareRes.create("activity.time_limited_activity")[self.v_version_activity_id]
  if not cfg then
    return self.redpoint
  end
  if not self.v_red_point_id_list then
    self.v_red_point_id_list = {}
  end
  if not cfg.FirstActRedId then
    Log.Error("版本活动主界面->版本活动的FirstActRedId配置为空,使用默认红点列表，活动id:", self.v_version_activity_id)
    return self.redpoint
  end
  if not self.v_red_point_id_list[self.v_version_activity_id] then
    local temp_table = {}
    for i = 1, 8 do
      temp_table[i] = cfg.FirstActRedId + i - 1
    end
    self.v_red_point_id_list[self.v_version_activity_id] = temp_table
  end
  return self.v_red_point_id_list[self.v_version_activity_id]
end

function M:get_activity_open_fun(cfg_type)
  local fun = check_activity_open_fun[cfg_type]
  fun = fun or tmp_fun
  return fun
end

function M:is_activity_open(id)
  local cfg = time_limited_activity_detail[id]
  if self.v_version_activity_id then
    return self:get_activity_open_fun(cfg.Type)(cfg)
  end
  return false
end

function M:get_version_activity_win_name(version_activity_id)
  local activity_cfg = ShareRes.create("activity.routine_activity")[version_activity_id or self.v_version_activity_id]
  return activity_cfg.UiName
end

function M:open_version_activity_win(version_activity_id)
  version_activity_id = version_activity_id or self.v_version_activity_id
  local is_active = NoviceMgr:get_novice_activity_active(version_activity_id)
  if not is_active then
    Log.Error("活动未开启")
    return
  end
  local ui_name = self:get_version_activity_win_name(version_activity_id)
  UIMgr:get_ui(ui_name):ui_show(version_activity_id or self.v_version_activity_id)
end

function M:on_task_group_update()
  self:minigame_award_redpoint_update()
end

function M:on_novice_activity_update()
  local version_activitys = NoviceMgr:get_novice_activity_map(commonDef.ROUTINE_ACTIVITY_TYPE.VERSION_ACTIVITY)
  local new_version_activity_id, cfg
  if version_activitys then
    new_version_activity_id, cfg = next(version_activitys)
  end
  if new_version_activity_id and self.v_version_activity_id ~= new_version_activity_id then
    UtilTable.clear_list(self.v_start_time_table)
    UtilTable.clear_list(self.v_end_time_table)
    local version_activity_detail_cfg = ShareRes.get_time_limited_activity_detail(new_version_activity_id)
    for _, value in pairs(version_activity_detail_cfg) do
      if get_time_by_type[value.Type] then
        local start_timestamp, end_timestamp = get_time_by_type[value.Type](value)
        local server_time = Date.server_time()
        if start_timestamp and start_timestamp > server_time then
          value.start_timestamp = start_timestamp
          table.insert(self.v_start_time_table, value)
        end
        if end_timestamp and end_timestamp > server_time then
          value.end_timestamp = end_timestamp
          table.insert(self.v_end_time_table, value)
        end
      end
    end
    self.v_version_activity_detail_cfg = version_activity_detail_cfg
    table.sort(self.v_start_time_table, function(a, b)
      return a.start_timestamp < b.start_timestamp
    end)
    table.sort(self.v_end_time_table, function(a, b)
      return a.end_timestamp < b.end_timestamp
    end)
    self.v_start_time_index = 1
    self.v_end_time_index = 1
  end
  if self.v_version_activity_id ~= new_version_activity_id then
    self.v_version_activity_id = new_version_activity_id
    self:refresh_redpoint()
    MsgGame:mq_publish2(Const.ON_VERSION_ACTIVITY_UPDATE)
  end
  if cfg and 1 == cfg.is_end then
    self.v_version_activity_id = nil
    MsgGame:mq_publish2(Const.ON_VERSION_ACTIVITY_UPDATE)
  end
  self:refresh_version_child_activity_type_list()
  self:refresh_version_child_activity()
  self:refresh_summer_shop_red()
  TaskMgr:refresh_maze_game_red_point()
end

function M:refresh_version_child_activity_type_list()
  self.v_version_child_activity_type_list = {}
  if not self.v_version_activity_id then
    return
  end
  local cfg = ShareRes.create("activity.time_limited_activity")[self.v_version_activity_id]
  if not cfg then
    return
  end
  for _, child_activity_id in ipairs(cfg.ChildActivityList) do
    local activity_cfg = ShareRes.create("activity.routine_activity")[child_activity_id]
    table.insert(self.v_version_child_activity_type_list, activity_cfg.Type)
  end
end

function M:on_buddytryout_activity_update()
  self.v_version_activity_detail_cfg = ShareRes.get_time_limited_activity_detail(self.v_version_activity_id)
  MsgGame:mq_publish2(Const.ON_VERSION_ACTIVITY_UPDATE)
  self:refresh_redpoint()
end

function M:get_activity_info_by_type(activity_type, target_activity_id)
  local activities = NoviceMgr:get_novice_activity_map(activity_type)
  local activity_id, cfg
  if activities then
    activity_id, cfg = next(activities)
  end
  if activity_id and activity_id ~= target_activity_id then
    local activities_detail_cfg = ShareRes.get_time_limited_activity_detail(activity_id)
    self.v_version_child_activities_id[activity_type] = activity_id
    return activity_id, activities_detail_cfg
  end
  return nil, nil
end

function M:refresh_version_child_activity()
  for _, activity_type in pairs(self.v_version_child_activity_type_list) do
    local id, cfg = self:get_activity_info_by_type(activity_type, self.v_version_child_activities_id[activity_type])
    if id and cfg then
      self.v_version_child_activities_cfg[id] = cfg
    end
  end
end

function M:get_summer_activity_id()
  return self.v_version_child_activities_id[commonDef.ROUTINE_ACTIVITY_TYPE.SUMMER_ACTIVITY]
end

function M:get_version_child_activities_detail_cfg(activity_id)
  return self.v_version_child_activities_cfg[activity_id]
end

function M:on_exchange_goods_update()
  self:refresh_summer_shop_red()
end

function M:refresh_summer_shop_red()
  local summer_activity_id = self:get_summer_activity_id()
  if not summer_activity_id then
    return
  end
  if not self.v_summer_shop_id then
    local activity_cfg = self:get_activity_cfg_with_activity_type(self.Type.SummerShop, summer_activity_id)
    if not activity_cfg then
      return
    end
    local shop_id = tonumber(activity_cfg.Param[2])
    self.v_summer_shop_id = shop_id
  end
  local is_can_buy = ShopMgr:on_limit_goods_can_buy(self.v_summer_shop_id)
  RedPointMgr:enable_redpoint(RedEnum.SUMMER_ACTIVITY_BTN_4, is_can_buy)
end

function M:on_summer_stage_info_init(data)
  self.v_summer_stage_activity_id = data.id
  self.v_summer_stage_state = data.status
  self.v_summer_stage_info_list = {}
  for _, info in pairs(data.episode_data) do
    self.v_summer_stage_info_list[info.id] = info
  end
  self.v_id_summer_stage_red = data.is_red
  self:on_summer_stage_red_refresh()
  self:refresh_summer_stage_task_group_id()
  TaskMgr:refresh_summer_epi_redpoint()
end

function M:on_summer_stage_info_update(data)
  self.v_summer_stage_info_list[data.episode_data.id] = data.episode_data
end

function M:get_summer_stage_list()
  if not self.v_summer_stage_info_list then
    Log.Error("服务器下发的信息列表为空，GM打开的界面去查看开启时间是否满足")
  end
  return self.v_summer_stage_info_list
end

function M:get_is_need_show_summer_stage_red()
  return self.v_id_summer_stage_red
end

function M:on_summer_stage_red_refresh()
  RedPointMgr:enable_redpoint(RedEnum.SUMMER_EPISODE_UPDATE_RED, self.v_id_summer_stage_red)
end

function M:hide_summer_stage_red()
  if not self.v_id_summer_stage_red then
    return
  end
  self.v_id_summer_stage_red = false
  self:on_summer_stage_red_refresh()
  Network:call("c2gs_version_episode_red_status_update", {})
end

function M:set_fight_challenge_multiple(multiple)
  self.v_fight_challenge_multiple = multiple
end

function M:get_fight_challenge_multiple()
  return self.v_fight_challenge_multiple or 1
end

function M:get_fight_cost(episode_id)
  local episode_cfg = ShareRes.get_chapter_point_cfg(episode_id)
  local cost = episode_cfg.FightCost[1] or episode_cfg.FightCost[2]
  local fight_multiple = TimeLimitedActMgr:get_fight_challenge_multiple()
  local fight_cost = fight_multiple * cost
  return fight_cost
end

function M:refresh_summer_stage_task_group_id()
  local cfg = ShareRes.create("activity.version_episode_activity_cfg", self.v_summer_stage_activity_id)
  self.v_task_group_id = cfg.TaskGroup
end

function M:get_summer_stage_task_group_id()
  return self.v_task_group_id
end

function M:get_is_can_fight(index, point_id)
  local cfg = self:get_activity_cfg_with_activity_type(M.Type.SummerFight, 34)
  if not cfg then
    return Config.BACK_TYPE.GO_TO_MAIN
  end
  local is_open = self:is_activity_open(cfg.Id)
  if not is_open then
    return Config.BACK_TYPE.GO_TO_MAIN
  end
  if not self.v_summer_stage_info_list then
    return Config.BACK_TYPE.GO_TO_MAIN
  end
  local info = self.v_summer_stage_info_list[index]
  if not info then
    return Config.BACK_TYPE.GO_TO_MAIN
  end
  if info.episode_id ~= point_id then
    return Config.BACK_TYPE.GO_TO_BACK
  end
  return Config.BACK_TYPE.NONE
end

function M:get_activity_cfg_with_activity_type(type, version_activity_id)
  version_activity_id = version_activity_id or self:get_version_activity_id()
  if not version_activity_id then
    return nil
  end
  for _, cfg in pairs(time_limited_activity_detail) do
    if cfg.ActivityId == version_activity_id and type == cfg.Type then
      return cfg
    end
  end
  return nil
end

return M
