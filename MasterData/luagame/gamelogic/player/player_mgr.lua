local Base = require("gamelogic.base_system")
local M = Util.create_child_mt(Base)
local _tinsert = table.insert
local _tsort = table.sort
local TASK_STATE = {
  none = 2,
  receive = 3,
  received = 4
}
local CommDefine = require("cs_share.common_define")
local DEFAULT_BUDDY_ID = 1001001
local DEFAULT_FASHION_ID = 3001001
local DEFAULT_POS = {
  x = 387.0001,
  y = -14.99988,
  scale = 1
}
local LocalStorage = require("utils.localstorage")
local Seri = require("seri")

local function avatar_sort(a, b)
  local a_priority = a.avatar_cfg.Priority
  local b_priority = b.avatar_cfg.Priority
  local a_id = a.avatar_cfg.Id
  local b_id = b.avatar_cfg.Id
  if a_priority == b_priority then
    return a_id < b_id
  else
    return a_priority > b_priority
  end
end

function M:init_sys()
  Base.init_sys(self)
  self.v_player_data_list = {}
  self.v_role_base_info = {}
  self.v_exp_up_holder = nil
  self.v_role_info = {}
  self.v_login_time = 0
end

function M:_build_player_data_list(data)
  local player_data = {}
  player_data.avatar_data = {}
  player_data.base_info = self.v_role_base_info
  player_data.info_list = {
    birth_month = data.birth_month,
    birth_day = data.birth_day,
    quotation = data.quotation,
    Id = Global.player_uuid,
    avatar_id = data.face_id,
    rename_num = data.rename_cnt,
    board_id = data.board_id or DEFAULT_BUDDY_ID,
    del_player_timer = data.del_player_timer
  }
  BattleSettingMgr:use_player_setting_info(true)
  return player_data
end

function M:on_player_info(data)
  self.v_player_data_list = self:_build_player_data_list(data)
end

function M:get_player_head_id()
  return self.v_player_data_list.info_list.avatar_id
end

local EXP_UP_HANDLE_TYPE = {
  SHOW = 1,
  PUSH_IN_QUEUE = 2,
  HOLD_PARAM = 3,
  IGNORE = 4,
  PUSH_IN_QUEUE_NO_UPGRADE = 5
}
local EXP_UP_HANDLE_WAY = {
  [CommDefine.CHALLENGE_TYPE.WEEK_ACTY_PERPARE_EPI] = EXP_UP_HANDLE_TYPE.PUSH_IN_QUEUE_NO_UPGRADE,
  [CommDefine.CHALLENGE_TYPE.BUDDY_TEACH] = EXP_UP_HANDLE_TYPE.HOLD_PARAM,
  [CommDefine.CHALLENGE_TYPE.CHAPTER] = EXP_UP_HANDLE_TYPE.HOLD_PARAM,
  [CommDefine.CHALLENGE_TYPE.LONG_CHAPTER] = EXP_UP_HANDLE_TYPE.HOLD_PARAM,
  [CommDefine.CHALLENGE_TYPE.NEW_MATERIAL] = EXP_UP_HANDLE_TYPE.HOLD_PARAM,
  [CommDefine.CHALLENGE_TYPE.VERSION_EPISODE] = EXP_UP_HANDLE_TYPE.HOLD_PARAM
}

function M:on_get_role_base_info(base_info)
  local old_exp = (self.v_role_base_info or {}).exp
  self.v_role_base_info = base_info
  if base_info.time_zone then
    Date.set_time_zone(base_info.time_zone)
  end
  if base_info.time_scheme then
    Date.set_time_scheme(base_info.time_scheme)
  end
  self.v_player_data_list.base_info = self.v_role_base_info
  if self.v_need_send_enter_game then
    self.v_need_send_enter_game = nil
    SDKManager:enter_game()
  end
  MsgGame:mq_publish2(Const.MSG_ON_PLAYER_INFO_UPDATE)
  local old_lv = self.v_role_base_old_lv
  local new_lv = self.v_role_base_info.lv
  local new_exp = self.v_role_base_info.exp
  local is_upgrade = old_lv and old_lv < new_lv
  local handle
  if old_exp and (nil ~= old_lv and old_lv ~= new_lv or old_exp ~= new_exp) then
    self.v_role_base_old_lv = new_lv
    local param = {
      old_lv = old_lv,
      new_lv = new_lv,
      old_exp = old_exp,
      new_exp = new_exp
    }
    local in_fight = UIMgr:try_get_visible_ui("fight")
    if in_fight then
      local fight_type = TowerMgr:get_fight_type()
      handle = EXP_UP_HANDLE_WAY[fight_type]
    elseif not is_upgrade then
      handle = EXP_UP_HANDLE_TYPE.SHOW
      UIMgr:try_hide_ui("exp_up_tips")
    else
      handle = EXP_UP_HANDLE_TYPE.IGNORE
      return
    end
    if handle == EXP_UP_HANDLE_TYPE.SHOW then
      UIMgr:get_ui("exp_up_tips"):ui_show(param)
    elseif handle == EXP_UP_HANDLE_TYPE.PUSH_IN_QUEUE or handle == EXP_UP_HANDLE_TYPE.PUSH_IN_QUEUE_NO_UPGRADE and not is_upgrade then
      UIMgr.ui_queue_mgr:set_open_lock_state(true)
      UIMgr:add_ui_queue(Config.UI_QUEUE_GROUP.Upgrade_Notice, "exp_up_tips", param)
    elseif handle == EXP_UP_HANDLE_TYPE.HOLD_PARAM then
      self:hold_exp_up(param)
    end
  end
end

function M:hold_exp_up(param)
  if not self.v_exp_up_holder then
    self.v_exp_up_holder = param
  else
    self.v_exp_up_holder.old_lv = self.v_exp_up_holder.old_lv or param.old_lv
    self.v_exp_up_holder.new_lv = param.new_lv
    self.v_exp_up_holder.new_exp = param.new_exp
  end
  local battle_suc_settle = UIMgr:try_get_visible_ui("not_progress_battle_suc_settle")
  if battle_suc_settle then
    self:try_show_exp_up_tips()
  end
end

function M:try_show_exp_up_tips()
  if self.v_exp_up_holder then
    UIMgr:get_ui("exp_up_tips"):ui_show(self.v_exp_up_holder)
  end
  self.v_exp_up_holder = nil
end

function M:on_player_upgrade(data)
  UIMgr.ui_queue_mgr:set_open_lock_state(true)
  self:_player_upgrade_main(data)
  local char_name = self:get_player_name()
  local char_lv = self:get_role_lv()
  local trace_data = {
    role_id = Global.player_uuid,
    role_name = char_name,
    role_level = char_lv
  }
  SDKTrack:trace_upgrade(trace_data)
  self:check_track(char_lv)
  MsgGame:mq_publish2(Const.MSG_PLAYER_LVUP)
  MsgGame:mq_publish2(Const.MSG_ON_MAIN_MASCOT_RED_UPDATE)
end

function M:upgrade_player_name(new_name, cb, is_not_tip)
  Network:call("c2gs_rename", {new_name = new_name}, function(ok)
    if ok then
      if not is_not_tip then
        Util.show_message_tip(2089)
      end
      self.v_player_data_list.base_info.name = new_name
      self.v_role_base_info.name = new_name
      MsgGame:mq_publish2(Const.MSG_ON_PLAYER_INFO_UPDATE)
    end
    cb(ok)
  end)
end

function M:upgrade_player_name_by_story(new_name, cb, is_not_tip)
  Network:call("c2gs_play_story_rename", {new_name = new_name}, function(ok, resp)
    if ok then
      if not is_not_tip then
        Util.show_message_tip(2089)
      end
      self.v_player_data_list.base_info.name = resp.new_name
      self.v_role_base_info.name = resp.new_name
      MsgGame:mq_publish2(Const.MSG_ON_PLAYER_INFO_UPDATE)
      SDKManager:create_role()
    end
    cb(ok, resp)
  end)
end

function M:upgrade_birthday(birthday_data, cb)
  Network:call("c2gs_set_birthday", {
    birth_month = birthday_data.month,
    birth_day = birthday_data.day
  }, function(ok)
    if ok then
      Util.show_message_tip(2089)
      local info_list = self.v_player_data_list.info_list
      info_list.birth_month = birthday_data.month
      info_list.birth_day = birthday_data.day
      cb()
    end
  end)
end

function M:upgrade_quotation(quotation, cb)
  Network:call("c2gs_set_quotation", {quotation = quotation}, function(ok)
    if ok then
      Util.show_message_tip(2089)
      self.v_player_data_list.info_list.quotation = quotation
    end
    cb(ok)
  end)
end

function M:upgrade_face_id(face_id, cb)
  Network:call("c2gs_set_face_id", {face_id = face_id}, function(ok)
    if ok then
      Util.show_message_tip(2090)
      self.v_player_data_list.info_list.avatar_id = face_id
      cb()
    end
  end)
end

function M:use_cdkey(key)
  Network:call("c2gs_use_cdkey", {key = key})
end

function M:logout_game_server(cb)
  if Global.gamemode:gmode_is_login() then
    Network:close()
    Global.gamemode:gmode_set_mode(Const.MODE_CHECK_UPDATE)
  else
    Network:call("c2gs_logout", {}, function()
      if cb then
        cb()
      end
      Network:close()
      Global.gamemode:gmode_set_mode(Const.MODE_CHECK_UPDATE)
    end, 3)
  end
end

function M:logout()
  if UNITY_EDITOR or UNITY_STANDALONE_WIN then
    UIMgr:get_ui("ui_player_exit_tip"):ui_show()
    return
  end
  if not SDKManager:had_sdk_login() then
    Util.show_notify_popup_message(function()
      if UIMgr then
        UIMgr:open_default_ui(true)
      end
      self:logout_game_server()
    end, "退出登录", "登出", "确定", "取消", nil, false)
    return
  end
  SDKManager:logout()
end

function M:on_get_player_info_list()
  return self.v_player_data_list
end

function M:on_get_rename_card()
  local single_key_define_cfg = ShareRes.create("single_key_define")
  local cost_id = single_key_define_cfg.RenameCostId
  local rename_card_cfg = ShareRes.get_item_cfg(cost_id)
  local num = BagMgr:get_item_num(cost_id)
  local rename_card_data = {rename_card_cfg = rename_card_cfg, num = num}
  return rename_card_data
end

function M:on_get_avatar_list()
  local player_data = self.v_player_data_list
  local avatar_list = BagMgr:get_bag(11)
  local avatar_cfg = ShareRes.create("player.player_avatar")
  local use_num = player_data.info_list.avatar_id
  local avatar_tb = {}
  for idx, data in pairs(avatar_list) do
    avatar_tb[data.id] = idx
  end
  UtilTable.clear_list(player_data.avatar_data)
  for idx, data in pairs(avatar_cfg) do
    local buddy_id = data.BuddyID
    if not buddy_id or ShareRes.get_buddy_is_show(buddy_id) and CharacterMgr:check_buddy_release(buddy_id) then
      local temp = {
        avatar_cfg = data,
        is_use = idx == use_num,
        un_get = avatar_tb[data.Id] == nil
      }
      _tinsert(player_data.avatar_data, temp)
    end
  end
  _tsort(player_data.avatar_data, avatar_sort)
  return player_data.avatar_data
end

function M:enter_game()
  if self.v_role_base_info == nil then
    self.v_need_send_enter_game = true
  else
    SDKManager:enter_game()
  end
  SDKTrack:trace_login()
  self.v_login_time = Date.server_time()
end

function M:get_role_lv()
  return self.v_role_base_info and self.v_role_base_info.lv or 1
end

function M:get_player_quotation()
  return self.v_player_data_list.info_list.quotation
end

function M:get_player_base_info()
  return self.v_role_base_info
end

function M:get_player_name()
  return self.v_player_data_list.base_info and self.v_player_data_list.base_info.name or ""
end

function M:get_player_initial_number()
  return self.v_player_data_list.base_info and self.v_player_data_list.base_info.initial_number
end

function M:get_player_face_id()
  if not self.v_player_data_list.info_list then
    Log.Error("player data is nil")
    Log.Error("self.v_player_data_list", self.v_player_data_list)
  end
  return self.v_player_data_list.info_list.avatar_id
end

function M:get_player_rename_num()
  return self.v_player_data_list.info_list.rename_num or 0
end

function M:get_signboard_girl_id()
  return self.v_player_data_list.info_list.board_id
end

function M:set_signboard_girl_id(id)
  self.v_player_data_list.info_list.board_id = id
end

function M:get_player_uid()
  return self.v_player_data_list.info_list.Id
end

function M:player_lv_is_max()
  local player_level_cfg = ShareRes.create("player.player_upgrade")
  return self.v_role_base_info.lv == #player_level_cfg
end

function M:player_lv_need_exp()
  local player_level_cfg = ShareRes.create("player.player_upgrade", self.v_role_base_info.lv)
  return player_level_cfg.NeedEXP
end

function M:_player_upgrade_main(data)
  local player_level_cfg = ShareRes.create("player.player_upgrade")
  local last_level = self.v_role_base_info.lv
  local player_last_level_cfg = player_level_cfg[last_level]
  local last_rec_limit = player_last_level_cfg.RecLimit
  local next_level = data.new_level
  local player_next_level_cfg = player_level_cfg[next_level]
  local next_rec_limit = player_next_level_cfg.RecLimit
  self.v_role_base_old_lv = self.v_role_base_info.lv
  self.v_role_base_info.lv = next_level
  local rec_award = 0
  for i = last_level, next_level - 1 do
    rec_award = rec_award + player_level_cfg[i].RecAward
  end
  local msg = MsgGame:mq_publish2(Const.MSG_ON_PLAYER_INFO_UPDATE)
  msg.mm_obj = self.v_role_base_info
  local in_fight = UIMgr:try_get_visible_ui("fight")
  if in_fight then
    local fight_type = TowerMgr:get_fight_type()
    local handle = EXP_UP_HANDLE_WAY[fight_type]
    if handle ~= EXP_UP_HANDLE_TYPE.PUSH_IN_QUEUE_NO_UPGRADE then
      return
    end
  end
  UIMgr:add_ui_queue(Config.UI_QUEUE_GROUP.Upgrade_Notice, "uimid_tips", last_level, next_level, last_rec_limit, next_rec_limit, rec_award)
end

local EXP_UP_TRACK = {
  [2] = "22_1-1_Acc_lv2",
  [3] = "25_Acc_lv3",
  [4] = "26_Acc_lv4",
  [5] = "29_Acc_lv5",
  [6] = "32_Acc_lv6"
}

function M:check_track(level)
  local event_name = EXP_UP_TRACK[level]
  if event_name then
    SDKManager:track_adjust_event(event_name)
  end
end

function M:get_all_achievement_list_form_server(callback)
  if self.v_achievement_list then
    MsgGame:mq_publish2(Const.MSG_ON_GET_ACHIEVEMENT_GROUP)
    return
  end
  Network:call("c2gs_achievement_list", {}, function(ok, resp)
    if ok then
      local achievements = resp.achievements or {}
      self.v_achievement_list = {}
      for i = 1, #achievements do
        self.v_achievement_list[achievements[i].group_id] = achievements[i].progress_task
      end
      if callback then
        callback()
      end
      self:refresh_achievement_red_point()
      MsgGame:mq_publish2(Const.MSG_ON_GET_ACHIEVEMENT_GROUP)
    end
  end)
end

function M:get_achievement_complete_time_form_server(callback)
  if self.v_achievement_complete_time then
    MsgGame:mq_publish2(Const.MSG_ON_GET_ACHIEVEMENT_COMPLETE_TIME)
    return
  end
  Network:call("c2gs_achievement_complete_time", {}, function(ok, resp)
    if ok then
      local achievement_complete = resp.achievement_complete_time
      self.v_achievement_complete_time = {}
      for k, v in pairs(achievement_complete) do
        self.v_achievement_complete_time[v.task_id] = v.finish_time
      end
      if callback then
        callback()
      end
      MsgGame:mq_publish2(Const.MSG_ON_GET_ACHIEVEMENT_COMPLETE_TIME)
    end
  end)
end

function M:get_task_complete_time(task_id)
  local data = TaskMgr:get_task_by_id(task_id)
  if data.complete_time then
    return data.complete_time
  end
  if self.v_achievement_complete_time[task_id] then
    data.complete_time = Date.standard_data_y_m_d(self.v_achievement_complete_time[task_id])
  end
  return data.complete_time
end

function M:refresh_achievement_red_point()
  local ACHIEVEMENT_SYS_ID = 41
  local is_open = SysOpenMgr:get_sys_is_open(ACHIEVEMENT_SYS_ID)
  local ready_data = self:whether_get_achievement_list()
  if not is_open or not ready_data then
    RedPointMgr:enable_redpoint(RedEnum.ACHIEVEMENT, false)
    return
  end
  local all_achievements = ShareRes.get_achievements()
  local has_reward = false
  for k, v in pairs(all_achievements) do
    local task_data = TaskMgr:get_task_by_id(v.TaskId)
    if task_data and task_data.state == TASK_STATE.receive then
      has_reward = true
    end
  end
  for k1, v1 in pairs(self:get_achievement_list()) do
    for k2, v2 in pairs(v1) do
      if 1 == v2.state then
        has_reward = true
      end
    end
  end
  if self:get_achievement_red_point_state() then
    has_reward = true
  end
  RedPointMgr:enable_redpoint(RedEnum.ACHIEVEMENT, has_reward)
end

function M:whether_get_achievement_list()
  return self.v_achievement_list ~= nil
end

function M:whether_achievement_complete_time()
  return self.v_achievement_complete_time ~= nil
end

function M:get_achievement_list(group_id)
  if self.v_achievement_list then
    if group_id then
      return self.v_achievement_list[group_id]
    else
      return self.v_achievement_list
    end
  end
end

function M:update_achievement_group_unlock(data)
  if self.v_achievement_list then
    self.v_achievement_list[data.achievements.group_id] = data.achievements.progress_task
    self:refresh_achievement_red_point()
    MsgGame:mq_publish2(Const.MSG_ON_GET_NEW_ACHIEVEMENT_GROUP)
  end
end

function M:get_achievements_dict(group_id)
  local res = {}
  for k, v in pairs(ShareRes.get_achievement_map().GroupIdToAchievements[group_id] or {}) do
    _tinsert(res, ShareRes.get_achievements(v))
  end
  _tsort(res, function(a, b)
    if a.Priority == b.Priority then
      return a.Id < b.Id
    end
    return b.Priority < a.Priority
  end)
  return res
end

function M:get_achievements_complete_num(group_id)
  local complete_num = 0
  local all_achievements = {}
  if group_id then
    local all_achievements_id = ShareRes.get_achievement_map().GroupIdToAchievements[group_id]
    for achievement_id, _ in pair(all_achievements_id) do
      local achievement_cfg = ShareRes.get_achievements(achievement_id)
      _tinsert(all_achievements, achievement_cfg)
    end
  else
    all_achievements = ShareRes.get_achievements(id)
  end
  for _, achievement in pairs(all_achievements) do
    local task_data = TaskMgr:get_task_by_id(achievement.TaskId)
    if task_data and (task_data.state == TASK_STATE.receive or task_data.state == TASK_STATE.received) then
      complete_num = complete_num + 1
    end
  end
  return complete_num
end

function M:achievement_get_award(award_id, callback)
  Network:call("c2gs_achievement_get_award", {id = award_id}, function(ok)
    if ok then
      if callback then
        callback()
      end
      self:refresh_achievement_red_point()
      MsgGame:mq_publish2(Const.MSG_ON_GET_ACHIEVEMENT_GROUP_AWARD)
    end
  end)
end

function M:update_achievement_info(data)
  local location = ShareRes.get_progress_task_location(data.achievement.id)
  if self.v_achievement_list and self.v_achievement_list[location.GroupId] then
    self.v_achievement_list[location.GroupId][location.Col] = data.achievement
    self:refresh_achievement_red_point()
    MsgGame:mq_publish2(Const.MSG_ON_GET_NEW_ACHIEVEMENT_GROUP)
  end
end

function M:get_all_titles_form_server(callback)
  Network:call("c2gs_title_list", {}, function(ok, resp)
    if ok then
      local all_titles = resp.titles or {}
      self.v_all_titles = {}
      for i = 1, #all_titles do
        self.v_all_titles[all_titles[i].id] = all_titles[i]
        if 1 == all_titles[i].status then
          self.v_cur_wear = all_titles[i]
        end
      end
      if callback then
        callback()
      end
      MsgGame:mq_publish2(Const.MSG_ON_GET_ALL_TITLES)
    end
  end)
end

function M:whether_get_all_titles()
  return self.v_all_titles ~= nil
end

function M:get_title(title_id)
  if self.v_all_titles then
    if title_id then
      return self.v_all_titles[title_id]
    else
      return self.v_all_titles
    end
  end
end

function M:get_active_titles()
  if self.v_all_titles then
    local active_titles = {}
    for title_id, _ in pairs(self.v_all_titles) do
      _tinsert(active_titles, title_id)
    end
    return active_titles
  else
    return {}
  end
end

function M:get_wear_title()
  return self.v_cur_wear
end

function M:whether_wear_title()
  return self.v_cur_wear ~= nil
end

function M:wear_title(title_id, callback)
  Network:call("c2gs_title_wear", {title_id = title_id}, function(ok)
    if ok then
      if self.v_cur_wear then
        self.v_cur_wear.status = 0
      end
      self.v_all_titles[title_id].status = 1
      self.v_cur_wear = self.v_all_titles[title_id]
      if callback then
        callback()
      end
      MsgGame:mq_publish2(Const.MSG_ON_WEAR_TITLE)
    end
  end)
end

function M:take_off_title(callback)
  Network:call("c2gs_title_take_off", {}, function(ok)
    if ok then
      if self.v_cur_wear then
        self.v_cur_wear.status = 0
      end
      self.v_cur_wear = nil
      if callback then
        callback()
      end
      MsgGame:mq_publish2(Const.MSG_ON_WEAR_TITLE)
    end
  end)
end

function M:update_all_titles(data)
  if self.v_all_titles then
    local title = data.title
    local title_cfg = ShareRes.get_title(title.id)
    local title_group = title_cfg.GroupId
    local title_level = title_cfg.Level
    local delete_title_id = {}
    for cur_title_id, cur_title in pairs(self.v_all_titles) do
      local cur_title_cfg = ShareRes.get_title(cur_title_id)
      local cur_title_group = cur_title_cfg.GroupId
      local cur_title_level = cur_title_cfg.Level
      if cur_title_group == title_group and title_level > cur_title_level then
        _tinsert(delete_title_id, cur_title_id)
      end
    end
    for index, cur_delete_title_id in pairs(delete_title_id) do
      self.v_all_titles[cur_delete_title_id] = nil
    end
    self.v_all_titles[title.id] = title
    if 1 == title.status then
      if self.v_cur_wear then
        self.v_cur_wear.status = 0
      end
      self.v_cur_wear = title
    end
    MsgGame:mq_publish2(Const.MSG_TITLE_UI_GET_NEW)
  end
end

function M:update_ornament_list(data)
  self.v_ornament_list = {}
  local ornaments = data.ornaments
  for _, ornament_info in pairs(ornaments) do
    self.v_ornament_list[ornament_info.id] = ornament_info
  end
end

function M:update_single_ornament(data)
  local ornament_info = data.ornament
  if self.v_ornament_list then
    self.v_ornament_list[ornament_info.id] = ornament_info
  else
    self.v_ornament_list = {}
    self.v_ornament_list[ornament_info.id] = ornament_info
  end
  MsgGame:mq_publish2(Const.MSG_ON_ORNAMENT_RED_update)
end

function M:get_ornament_list()
  return self.v_ornament_list or {}
end

function M:get_ornament_unread_num()
  local ORNAMENT_TIP = {UNLOOK = 1, LOOKED = 2}
  if self.v_ornament_list then
    local res = 0
    for _, ornament_info in pairs(self.v_ornament_list) do
      if ornament_info.tip == ORNAMENT_TIP.UNLOOK then
        res = res + 1
      end
    end
    return res
  else
    return 0
  end
end

function M:ornament_remove_tip(send_id)
  Network:call("c2gs_ornament_remove_tip", {ornament_id = send_id}, function(ok)
    if ok then
      local ORNAMENT_TIP = {UNLOOK = 1, LOOKED = 2}
      if self.v_ornament_list then
        self.v_ornament_list[send_id].tip = ORNAMENT_TIP.LOOKED
      end
      MsgGame:mq_publish2(Const.MSG_ON_ORNAMENT_RED_update)
    end
  end)
end

function M:update_visiting_card(data)
  self.v_visiting_card = {}
  self.v_ware_visiting_card = nil
  for _, id in pairs(data.business_cards) do
    self.v_visiting_card[id] = false
    if id == data.using then
      self.v_visiting_card[id] = true
      self.v_ware_visiting_card = id
    end
  end
end

function M:update_single_visiting_card(data)
  if self.v_visiting_card then
    self.v_visiting_card[data.business_card] = data.state == CommDefine.USING
  end
end

function M:ware_visiting_card(ware_id)
  if self.v_visiting_card then
    Network:call("c2gs_business_card_wear", {business_card = ware_id}, function(ok)
      if ok then
        if self.v_ware_visiting_card then
          self.v_visiting_card[self.v_ware_visiting_card] = false
        end
        self.v_visiting_card[ware_id] = true
        self.v_ware_visiting_card = ware_id
        MsgGame:mq_publish2(Const.MSG_ON_VISITING_CARD_WARE)
      end
    end)
  end
end

function M:get_wear_visiting_card()
  return self.v_ware_visiting_card
end

function M:get_all_visiting_card()
  return self.v_visiting_card or {}
end

function M:take_off_visiting_card(take_off_id)
  if self.v_visiting_card then
    Network:call("c2gs_business_card_take_off", {business_card = take_off_id}, function(ok)
      if ok then
        self.v_visiting_card[take_off_id] = false
        self.v_ware_visiting_card = nil
        MsgGame:mq_publish2(Const.MSG_ON_VISITING_CARD_WARE)
      end
    end)
  end
end

function M:get_online_time()
  return Date.server_time() - self.v_login_time
end

local ACHIEVEMENT_LOCAL_KEY = "achievement_red_point"

function M:save_achievement_red_point(point_id)
  local save_tolocal = self:load_achievement_red_point()
  save_tolocal[point_id] = point_id
  LocalStorage:save_table(self:get_achievement_red_point_key(), save_tolocal)
end

function M:load_achievement_red_point()
  return LocalStorage:load_table(self:get_achievement_red_point_key()) or {}
end

function M:clear_achievement_red_point()
  LocalStorage:save_table(self:get_achievement_red_point_key(), {})
end

function M:get_achievement_red_point_key()
  return ACHIEVEMENT_LOCAL_KEY .. Global.player_uuid
end

function M:get_achievement_red_point_state()
  local achievement_groups = self:get_achievement_list()
  local save_table = self:load_achievement_red_point()
  local red_state = false
  if not achievement_groups then
    return red_state
  end
  for k, v in pairs(achievement_groups) do
    local group_cfg = ShareRes.get_achievement_group_cfg(k)
    if 1 == group_cfg.Classify and not save_table[group_cfg.Id] then
      red_state = true
    end
  end
  return red_state
end

function M:skip_new_player_flow()
  local uuid = Global.player_uuid
  if not uuid then
    Log.Error("uuid is nil")
    return
  end
  local args_map = {uuid = uuid}
  local request = {
    args_map = Seri.packstring(args_map)
  }
  local c2gs_execute_instruct = "c2gs_execute_instruct"
  GuideMgr:jump_all_guide()
  Network:call(c2gs_execute_instruct, request, function(ok, resp)
    Log.Info(ok, resp.result)
  end)
  request.instruct = "open_role_all_sys"
  Network:call(c2gs_execute_instruct, request, function(ok, resp)
    Log.Info(ok, resp.result)
  end)
  request.instruct = "skip_newbie_guide"
  Network:call(c2gs_execute_instruct, request, function(ok, resp)
    Log.Info(ok, resp.result)
  end)
  request.instruct = "complete_scene_journey"
  Network:call(c2gs_execute_instruct, request, function(ok, resp)
    Log.Info(ok, resp.result)
  end)
end

function M:skip_newbie()
  local uuid = Global.player_uuid
  if not uuid then
    Log.Error("uuid is nil")
    return
  end
  local args_map = {uuid = uuid}
  local request = {
    args_map = Seri.packstring(args_map)
  }
  local c2gs_execute_instruct = "c2gs_execute_instruct"
  request.instruct = "skip_newbie_guide"
  Network:call(c2gs_execute_instruct, request, function(ok, resp)
    Log.Info(ok, resp.result)
  end)
end

function M:set_cloth_buddy_cache(id, fashion_id)
  self.v_cloth_buddy_cache = id
  self.v_cloth_fashion_cache = fashion_id
end

function M:get_cloth_buddy_cache()
  return self.v_cloth_buddy_cache
end

function M:get_cloth_fashion_cache()
  return self.v_cloth_fashion_cache
end

function M:on_gs2c_buddy_spine_info(data)
  self.v_buddy_spine_info = self:_build_buddy_spine_info(data)
end

function M:get_buddy_spine_info()
  return self.v_buddy_spine_info
end

function M:get_buddy_role_id()
  return self.v_buddy_spine_info.buddy_id
end

function M:set_buddy_role_id(id)
  self.v_buddy_spine_info.buddy_id = id
end

function M:request_buddy_spine_info(info, is_refresh_spine, is_refresh_record)
  Network:protect_call("c2gs_set_buddy_spine_info", {buddy_spine_info = info}, function(ok)
    if true == ok then
      Util.show_message_tip(2092)
      local uipalyer_new = UIMgr:try_get_visible_ui("uiplayer_new")
      if uipalyer_new then
        if is_refresh_spine then
          uipalyer_new:refresh_spine_view(info.buddy_id, info.fashion_id, info.px, info.py, info.scale)
        end
        if is_refresh_record then
          uipalyer_new:refresh_record_view(info.infiniter_id, info.boss_fight_id)
        end
      end
    end
  end)
end

function M:_build_buddy_spine_info(data)
  data = data.buddy_spine_info
  local buddy_info = {
    fashion_id = data.fashion_id or DEFAULT_FASHION_ID,
    buddy_id = data.buddy_id or DEFAULT_BUDDY_ID,
    px = data.px or DEFAULT_POS.x,
    py = data.py or DEFAULT_POS.y,
    scale = data.scale or DEFAULT_POS.scale,
    infiniter_id = data.infiniter_id,
    boss_fight_id = data.boss_fight_id,
    is_break = data.is_break or false
  }
  return buddy_info
end

function M:get_del_player_timer()
  return self.v_player_data_list and self.v_player_data_list.info_list and self.v_player_data_list.info_list.del_player_timer
end

return M
