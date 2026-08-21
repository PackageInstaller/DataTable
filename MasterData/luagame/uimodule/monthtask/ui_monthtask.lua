local Base = require("ui.uibase")
local mathx = require("base.mathx")
Global = require("global")
local ui = Util.create_child_mt(Base)
local ACTIVE_AWARD_TEM = "ACTIVE_AWARD_TEM"
local TASK_TEM = "TASK_TEM"
local TASK_AWARD_TEM = "TASK_AWARD_TEM"
local AWARD_PREVIEW_TEM = "AWARD_PREVIEW_TEM"
local ROLLING_PAGE_TEM = "ROLLING_PAGE_TEM"
local TASK_CONFIG = require("gamelogic.task.task_config")
local TASK_STATE = TASK_CONFIG.TASK_STATE
local PASSPORT_AWARD_TEM_LUACLASS_NEW = require("uimodule.monthtask.ui_award_tem_new")
local PASSPORT_FINAL_AWARD_TEM_LUACLASS = require("uimodule.monthtask.ui_final_award_tem")
local LoopListClass = require("ui.widget.infinite_loop_list")
local count_format = "x%u"
local AWARDTIPS_OFFSET_X = -104
local AWARDTIPS_OFFSET_Y = -150
local AWARD_TEM_WIDTH = 190
local SPACE = 10
local AWARD_Y_OFFSET = -284
local TOGTYPE = {PASSPORT = 1, TASK = 2}
local TASK_TYPE = {
  DAILY = 1,
  WEEKLY = 2,
  PASSPORT = 3
}
local SCORE_WORD_STRING = {
  "每日活跃",
  "每周活跃"
}
local color_type = {
  dark = "484243",
  bright = "f5ede2",
  black = "000000",
  tog_color = "ae9577",
  white = "ffffff"
}
local AWARD_TYPE = {
  none = 1,
  receive = 2,
  received = 3
}
local red_point_id_map = {
  [TASK_TYPE.DAILY] = RedEnum.PASSPORT_DAILY_TASK,
  [TASK_TYPE.WEEKLY] = RedEnum.PASSPORT_WEEKLY_TASK,
  [TASK_TYPE.PASSPORT] = RedEnum.PASSPORT_RANDOM_TASK
}
local icon_path_prefix = "Icon/item/%s"
local Quality_Img = {
  [1] = "UICommon/Common_pzk_01",
  [2] = "UICommon/Common_pzk_02",
  [3] = "UICommon/Common_pzk_02",
  [4] = "UICommon/Common_pzk_03",
  [5] = "UICommon/Common_pzk_04"
}
local ORDER_SELECT_KEY = "ORDER_SELECT"

function ui:ui_finish_load()
  self:set_button("BtnRet1", function()
    if 1 == UIMgr:get_cache_ui_custom_data(ORDER_SELECT_KEY) then
      UIMgr:set_cache_ui_custom_data(ORDER_SELECT_KEY, 2)
    end
    self:ui_destroy()
    UIMgr:try_hide_ui("ui_monthtask_buy")
  end)
  self:set_button("BtnMain", function()
    self:ui_destroy()
  end)
  self:set_button("BtnBuyLv", function()
    self:on_click_buy_level()
  end)
  self:set_button("BtnActivateOrder", function()
    self:on_click_buy_passport()
  end)
  self:set_button("SPOrder", function()
    self:on_click_buy_passport()
  end)
  self:set_button_listener(self.v_uicompents.BtnAllRecive_btn, function()
    self:on_click_receive_all()
  end)
  self:set_button_listener(self.v_uicompents.BtnCloseTips_btn, function()
    self:show_award_preview(false)
  end)
  self:set_toggle_listener(self.v_uicompents.PageAward_tog, function(is_on)
    if not is_on then
      return
    end
    self:on_click_top_tog(TOGTYPE.PASSPORT)
  end)
  self:set_toggle_listener(self.v_uicompents.PageTask_tog, function(is_on)
    if not is_on then
      return
    end
    Global.sound_mgr:play_ui_sound(Config.UI_SOUND_CFG.ui_monthtask_tog_UI_SOUND)
    self:on_click_top_tog(TOGTYPE.TASK)
  end)
  self.v_savearea_canvas_group = Util.get_canvas_group("SafeArea", self.v_object_transform)
  self.v_infinite_list = LoopListClass:new(self, self.v_uiobjects.ScrollView, PASSPORT_AWARD_TEM_LUACLASS_NEW)
  self.v_infinite_list:set_custom_move(true)
  self.v_is_set_infinite_data = false
  self.v_normal_award_got_map = {}
  self.v_senior_award_got_map = {}
  self.v_can_receive_task_id_list = {}
  self.v_timer_index_list = {}
  self.v_timer_index_list_2 = {}
  self.v_timer_index_list_3 = {}
  self.v_cur_task_type = TASK_TYPE.DAILY
  self.v_task_tog_obj_list = {
    self.v_uiobjects.TaskPageTem1,
    self.v_uiobjects.TaskPageTem2,
    self.v_uiobjects.TaskPageTem3
  }
  self.v_task_last_state_map = {}
  self.v_timer_click_passport = nil
  self.v_timer_click_task = nil
  self.v_canvas_rect = self.v_object:GetComponent(TypeUnityRectTransform)
  self:update_user_data(true)
  self.v_award_luaobj_list = {}
  self.v_key_award_index_list = {}
  self.v_award_choice_ui_cache = {}
  self.v_battle_passport_cfg = ShareRes.get_battle_passport_cfg(self.v_user_data.id)
  self.v_battle_passport_group = ShareRes.get_battle_passport_group_cfg(self.v_battle_passport_cfg.Group)
  self:register_exist_auto_template(ACTIVE_AWARD_TEM, self.v_uiobjects.ActiveAwardTem, self.v_uiobjects.ActiveAwardContent)
  self:register_exist_auto_template(TASK_TEM, self.v_uiobjects.TaskTem)
  local awarditem_obj = Util.get_child_gameobj("Group/CtRewardList_/Viewport/AwardContent_/AwardItem_", self.v_uiobjects.TaskTem)
  self:register_exist_auto_template(TASK_AWARD_TEM, awarditem_obj)
  self:register_exist_auto_template(AWARD_PREVIEW_TEM, Util.get_child_gameobj("AwardItem1_", self.v_uiobjects.AwardTips), self.v_uiobjects.AwardTips)
  self:register_exist_auto_template(ROLLING_PAGE_TEM, self.v_uiobjects.PageTem, self.v_uiobjects.PageContent)
  local redpoint1 = self:get_child_gameobj("RedPoint", self.v_uiobjects.TaskPageTem1)
  local redpoint2 = self:get_child_gameobj("RedPoint", self.v_uiobjects.TaskPageTem2)
  local redpoint3 = self:get_child_gameobj("RedPoint", self.v_uiobjects.TaskPageTem3)
  local redpoint4 = self:get_child_gameobj("Redpoint", self.v_uiobjects.PageAward)
  local redpoint5 = self:get_child_gameobj("Redpoint", self.v_uiobjects.PageTask)
  RedPointMgr:bind_redpoint(self, redpoint1, RedEnum.PASSPORT_DAILY_TASK, RedEnum.PASSPORT_TASK)
  RedPointMgr:bind_redpoint(self, redpoint2, RedEnum.PASSPORT_WEEKLY_TASK, RedEnum.PASSPORT_TASK)
  RedPointMgr:bind_redpoint(self, redpoint3, RedEnum.PASSPORT_RANDOM_TASK, RedEnum.PASSPORT_TASK)
  RedPointMgr:bind_redpoint(self, redpoint4, RedEnum.PASSPORT_AWARD, RedEnum.PASSPORT)
  RedPointMgr:bind_redpoint(self, redpoint5, RedEnum.PASSPORT_TASK, RedEnum.PASSPORT)
  self.v_canvas_rect = self:get_canvas():GetComponent(TypeUnityRectTransform)
  self:init_rolling_part()
  self:init_passport_panel()
  self:init_task_panel()
  self:on_click_task_tog(true, TASK_TYPE.DAILY)
  self.v_cur_tog_type = TOGTYPE.PASSPORT
  self.v_tasks_need_to_update_time = {}
end

function ui:ui_on_show(dont_play_anim, force_open_panel)
  if force_open_panel then
    self.v_cur_tog_type = force_open_panel
    if self.v_cur_tog_type == TOGTYPE.TASK then
      self.v_init = true
      self.v_uicompents.PageTask_tog.isOn = true
    end
  end
  self.v_uiobjects.Fx_UIOrder_OrderLevel:SetActive(false)
  self.v_rolling_duration = 0
  self:refresh()
  self.v_last_text_update_time = Global.time
  if not dont_play_anim then
    self.v_infinite_list:scroll_to_item(self.v_user_data.lv - 2)
    self:play_anim_on_show()
  end
  self:refresh_key_award_data()
  if not UtilTable.is_empty(self.v_award_choice_ui_cache) then
    UIMgr:get_ui("ui_monthtask_award_choice"):ui_show(self.v_award_choice_ui_cache.only_show, self.v_award_choice_ui_cache.award_group_id, self.v_award_choice_ui_cache.lv, self.v_award_choice_ui_cache.is_senior)
    UtilTable.clear_map(self.v_award_choice_ui_cache)
  end
  self:refresh_rolling_image()
  self:bind_auto_mq(Const.MSG_UPDATE_PASSPORT_EXP_LV, self.on_update_passport_exp_lv, self)
  self:bind_auto_mq(Const.MSG_UPDATE_PASSPORT_DATA, self.update_user_data, self)
  self:bind_auto_mq(Const.MSG_UPDATE_PASSPORT_TASK, self.on_update_random_task, self)
end

function ui:ui_on_update(delta_time)
  self:refresh_key_award_data()
  self:update_rolling_image(delta_time)
  if Global.time - self.v_last_text_update_time > 1 then
    local end_time = self.v_battle_passport_cfg.EndTime and Date.get_time_stamp_by_scheme_id(self.v_battle_passport_cfg.EndTime) or 0
    self.v_uicompents.Time_txt.text = Global.date.get_time_formate_2(math.max(end_time - Global.date.server_time(), 0))
    self.v_last_text_update_time = Global.time
  end
  if not UtilTable.is_empty(self.v_tasks_need_to_update_time) then
    for _, task in pairs(self.v_tasks_need_to_update_time) do
      task.time_txt.text = Global.date.get_time_formate_2(Date.get_time_stamp_by_scheme_id(task.ExpireTime) - Global.date.server_time())
    end
  end
end

function ui:ui_on_hide()
end

function ui:ui_on_destroy()
  self.v_award_luaobj_list = nil
  self.v_key_award_index_list = nil
  if self.v_task_timer_index then
    Timer:remove_timer(self.v_task_timer_index)
  end
  if self.v_duration2_timer_index then
    Timer:remove_timer(self.v_duration2_timer_index)
  end
  for index, value in pairs(self.v_timer_index_list) do
    Timer:remove_timer(value)
  end
  for index, value in pairs(self.v_timer_index_list_2) do
    Timer:remove_timer(value)
  end
  for index, value in pairs(self.v_timer_index_list_3) do
    Timer:remove_timer(value)
  end
  if self.v_scroll_timer_index then
    Timer:remove_timer(self.v_scroll_timer_index)
  end
  self.v_infinite_list:ui_on_destroy()
  PassPortMgr:clear_select_award_list()
end

function ui:cache_ui()
  return true
end

function ui:on_click_top_tog(type)
  if type == TOGTYPE.PASSPORT then
    self.v_cur_tog_type = type
    self:refresh()
    self:play_anim_on_click_award_panel()
  else
    self:play_anim_on_click_task_panel()
  end
end

function ui:on_click_buy_level()
  local param = {
    battle_passport_group = self.v_battle_passport_group,
    battle_passport_cfg = self.v_battle_passport_cfg,
    passport_lv = self.v_user_data.is_senior and 2 or 1,
    lv = self.v_user_data.lv
  }
  UIMgr:get_ui("ui_monthtask_buy_lv_tips"):ui_show(param, self)
end

function ui:on_click_buy_passport()
  RechargeMgr:request_product_info(function()
    UIMgr:get_ui("ui_monthtask_buy"):ui_show(self)
  end)
end

function ui:on_click_task_tog(is_on, type)
  local tog_obj = self.v_task_tog_obj_list[type]
  local select_obj = tog_obj.transform:GetChild(0)
  local name_txt = Util.get_text("PageName", tog_obj)
  select_obj:SetActive(is_on)
  if is_on and self.v_cur_task_type ~= type then
    self.v_cur_task_type = type
    self.v_uicompents.ShortList_rect:SetAnchoredPositionA(0, 0)
    self.v_uicompents.LongList_rect:SetAnchoredPositionA(0, 0)
    self:refresh_task_panel(type, false)
  end
  local color = is_on and color_type.white or color_type.tog_color
  Util.set_color(name_txt, color)
end

function ui:on_click_receive_all()
  if self.v_cur_tog_type == TOGTYPE.PASSPORT then
    PassPortMgr:request_get_all_passport_award(function()
      self:update_user_data()
      PassPortMgr:receive_all_select_award()
    end)
  elseif self.v_cur_task_type == TASK_TYPE.PASSPORT then
    PassPortMgr:request_receive_all(function()
      self:update_user_data()
      PassPortMgr:update_red_point_tree()
    end)
  else
    PassPortMgr:request_receive_all(function()
      PassPortMgr:update_red_point_tree()
      self:update_user_data()
      self.v_uiobjects.Fx_UIOrder_TaskObj_Level:SetActive(false)
      self.v_uiobjects.Fx_UIOrder_TaskObj_Level:SetActive(true)
    end)
  end
end

function ui:init_passport_panel()
  for index, param in ipairs(self.v_battle_passport_group) do
    if param.IsBigAward then
      table.insert(self.v_key_award_index_list, index)
    end
  end
  self.v_key_award_luaobj = PASSPORT_AWARD_TEM_LUACLASS_NEW:ui_wrap_ex(self, self.v_uiobjects.KeyAward, true)
  self.v_final_award_luaobj = PASSPORT_FINAL_AWARD_TEM_LUACLASS:ui_wrap_ex(self, self.v_uiobjects.FinalAward, true)
end

function ui:init_task_panel()
  self:set_toggle_listener(self.v_uicompents.TaskPageTem1_tog, function(is_on)
    if is_on then
      Global.sound_mgr:play_ui_sound(Config.UI_SOUND_CFG.ui_monthtask_switch_UI_SOUND)
    end
    self:on_click_task_tog(is_on, TASK_TYPE.DAILY)
  end)
  self:set_toggle_listener(self.v_uicompents.TaskPageTem2_tog, function(is_on)
    if is_on then
      Global.sound_mgr:play_ui_sound(Config.UI_SOUND_CFG.ui_monthtask_switch_UI_SOUND)
    end
    self:on_click_task_tog(is_on, TASK_TYPE.WEEKLY)
  end)
  self:set_toggle_listener(self.v_uicompents.TaskPageTem3_tog, function(is_on)
    if is_on then
      Global.sound_mgr:play_ui_sound(Config.UI_SOUND_CFG.ui_monthtask_switch_UI_SOUND)
    end
    self:on_click_task_tog(is_on, TASK_TYPE.PASSPORT)
  end)
end

function ui:init_rolling_part()
  self.v_rolling_image_path_list = self.v_battle_passport_cfg.ImagePath
  self.v_rolling_scroll_view_ex = Util.get_scrollrect_ex(nil, self.v_uiobjects.RollingIconScrollView)
  if #self.v_rolling_image_path_list < 2 then
    self.v_rolling_scroll_view_ex.enabled = false
    return
  end
  self.v_icon_lert_image = Util.get_image("Icon_left", self.v_uiobjects.ScrollContent)
  self.v_icon_middle_image = Util.get_image("Icon_middle", self.v_uiobjects.ScrollContent)
  self.v_icon_right_image = Util.get_image("Icon_right", self.v_uiobjects.ScrollContent)
  self.v_icon_middle_rect = Util.get_rect_transform("Icon_middle", self.v_uiobjects.ScrollContent)
  self.v_rolling_image_width = self.v_icon_middle_rect.sizeDelta.x
  self:set_scrollrect_ex_listener(self.v_rolling_scroll_view_ex, function()
    self.v_is_draging = true
  end, nil, function()
    self.v_is_draging = false
    local drag_delta = self.v_rolling_image_width / 4
    if drag_delta > math.abs(self.v_uicompents.ScrollContent_rect.anchoredPosition.x) then
      return
    end
    local right_swipe = drag_delta > self.v_uicompents.ScrollContent_rect.anchoredPosition.x
    self:rolling_operation(right_swipe)
  end, nil)
  self.v_rolling_interval = self.v_battle_passport_cfg.ShowInterval
  self.v_uicompents.RollingIconTitleText_txt.text = self.v_battle_passport_cfg.RollingImageDesc[self.v_rolling_index]
end

function ui:refresh_rolling_image()
  self.v_rolling_toggle_list = {}
  self:give_back_auto_cache(ROLLING_PAGE_TEM)
  for _, _ in ipairs(self.v_rolling_image_path_list) do
    local page_tem = self:get_auto_cache(ROLLING_PAGE_TEM)
    local toggle_com = Util.get_toggle(nil, page_tem)
    table.insert(self.v_rolling_toggle_list, toggle_com)
  end
  NextFrameMgr:add_next_update(function()
    self.v_rolling_toggle_list[1].isOn = true
  end)
  self.v_rolling_index = 1
  local rolling_left_index = #self.v_rolling_image_path_list
  local rolling_right_index = self.v_rolling_index + 1 > #self.v_rolling_image_path_list and 1 or self.v_rolling_index + 1
  self:set_rolling_image(self.v_rolling_image_path_list[rolling_left_index], self.v_rolling_image_path_list[self.v_rolling_index], self.v_rolling_image_path_list[rolling_right_index])
end

function ui:trigger_unlock_senior_anim(trigger)
  self.v_unlock_senior_trigger = trigger
end

function ui:refresh(play_ui_effect)
  self:refresh_level_exp_panel()
  self.v_uiobjects.AwardObj:SetActive(self.v_cur_tog_type == TOGTYPE.PASSPORT)
  self.v_uiobjects.TaskObj:SetActive(self.v_cur_tog_type == TOGTYPE.TASK)
  self.v_uiobjects.HintImage:SetActiveEx(not PassPortMgr:is_senior())
  if self.v_cur_tog_type == TOGTYPE.PASSPORT then
    self:refresh_passport_panel()
    if self.v_unlock_senior_trigger and UIMgr:get_cur_show_ui() == self then
      self:play_anim_unlock_senior()
      self.v_unlock_senior_trigger = false
      return
    end
    self.v_uicompents.Ani_UIOrder_Unlock_pd.time = self.v_user_data.is_senior and self.v_uicompents.Ani_UIOrder_Unlock_pd.duration or 0
    self.v_uicompents.Ani_UIOrder_Unlock_pd:Evaluate()
  elseif self.v_cur_tog_type == TOGTYPE.TASK then
    self:refresh_task_panel(self.v_cur_task_type, false)
  end
end

function ui:refresh_level_exp_panel()
  self.v_uicompents.LvNum_txt.text = self.v_user_data.lv
  local exp = self.v_user_data.lv == #self.v_battle_passport_group and self.v_battle_passport_cfg.GradeExp or self.v_user_data.exp
  self.v_uicompents.EXPNow_txt.text = exp
  self.v_uicompents.EXPMax_txt.text = self.v_battle_passport_cfg.GradeExp
  self.v_uicompents.WeekEXPNow_txt.text = self.v_user_data.exp_week_get
  self.v_uicompents.WeekEXPMax_txt.text = self.v_battle_passport_cfg.WeekGetMaxExp
  self.v_uiobjects.WeekEXPMax:SetActive(self.v_battle_passport_cfg.WeekGetMaxExp)
  local should_show_buy_btn = self.v_user_data.lv < self.v_battle_passport_cfg.BuyMaxGrade
  self.v_uiobjects.BtnBuyLv:SetActive(should_show_buy_btn)
  self.v_uiobjects.LvMax:SetActive(not should_show_buy_btn)
  local end_time = self.v_battle_passport_cfg.EndTime and Date.get_time_stamp_by_scheme_id(self.v_battle_passport_cfg.EndTime) or 0
  self.v_uicompents.Time_txt.text = Global.date.get_time_formate_2(math.max(end_time - Global.date.server_time(), 0))
  self.v_uicompents.ExpBar_sld.value = exp / self.v_battle_passport_cfg.GradeExp
end

function ui:refresh_passport_panel()
  local has_award
  local id = PassPortMgr:get_passport_data().id
  local battle_passport_cfg = ShareRes.get_battle_passport_cfg(id)
  local battle_passport_group = ShareRes.get_battle_passport_group_cfg(battle_passport_cfg.Group)
  local normal_award_got_map, senior_award_got_map = PassPortMgr:get_award_got_map()
  for i = 1, PassPortMgr:get_lv() do
    local cfg = battle_passport_group[i]
    if cfg.Award and not normal_award_got_map[i] then
      has_award = true
      break
    end
    if PassPortMgr:is_senior() and cfg.SeniorAward and not senior_award_got_map[i] then
      has_award = true
      break
    end
  end
  self.v_uiobjects.BtnAllRecive:SetActiveEx(has_award)
  local y = self.v_uicompents.KeyAward_rect.anchoredPosition.y
  self.v_uicompents.KeyAward_rect:SetAnchoredPositionA(-95, y)
  self.v_uicompents.FinalAward_rect:SetAnchoredPositionA(-95, y)
  if not self.v_is_set_infinite_data then
    self.v_infinite_list:refresh_data(self.v_battle_passport_group)
    local width = self.v_uicompents.Content_rect.sizeDelta.x
    width = width + AWARD_TEM_WIDTH / 2 + SPACE
    self.v_uicompents.Content_rect:SetSizeDeltaWidthA(width)
    self.v_is_set_infinite_data = true
  else
    self.v_infinite_list:reload_data()
  end
  self.v_award_luaobj_list = self.v_infinite_list:get_all_uis()
  self:refresh_key_award_data()
  local param = {
    lv = #self.v_battle_passport_group,
    exp = self.v_user_data.exp,
    max_exp = self.v_battle_passport_cfg.CirculateExp,
    award_id = self.v_battle_passport_cfg.CirculateAward
  }
  self.v_final_award_luaobj:set_data(param)
end

function ui:refresh_key_award_data()
  local max_index = -1
  for key, value in pairs(self.v_award_luaobj_list) do
    max_index = math.max(max_index, key)
  end
  local index = -1
  for i = #self.v_key_award_index_list, 1, -1 do
    if max_index < self.v_key_award_index_list[i] then
      index = self.v_key_award_index_list[i]
    else
      break
    end
  end
  if -1 ~= index and self.v_user_data.lv < #self.v_battle_passport_group then
    local param = self.v_battle_passport_group[index]
    param.is_key = true
    self.v_key_award_luaobj:set_data_old(param, self, true)
    self.v_uiobjects.KeyAward:SetActive(true)
    self.v_uiobjects.FinalAward:SetActive(false)
  else
    self.v_uiobjects.KeyAward:SetActive(false)
    self.v_uiobjects.FinalAward:SetActive(true)
  end
end

function ui:refresh_active_score(type)
  if type == TASK_TYPE.PASSPORT then
    self.v_uiobjects.active:SetActive(false)
    return
  else
    self.v_uiobjects.active:SetActive(true)
    self.v_uiobjects.Fx_UIOrder_TaskObj_Level:SetActive(false)
  end
  self:give_back_auto_cache(ACTIVE_AWARD_TEM)
  local word_string = SCORE_WORD_STRING[type]
  local active_award_list
  if type == TASK_TYPE.DAILY then
    active_award_list = ShareRes.create("task.daily_task_reward")
  else
    active_award_list = ShareRes.create("task.weekly_task_reward")
  end
  local task_config = ShareRes.create("condition.task")
  local condition_config = ShareRes.create("condition.condition")
  self.v_is_all_active_award_received = true
  local last_need_value = 0
  for index, config in ipairs(active_award_list) do
    local obj = self:get_auto_cache(ACTIVE_AWARD_TEM)
    local task_id = config.TaskId
    local task_item_config = task_config[task_id]
    local task_info = TaskMgr:get_task_by_id(task_id)
    local condition_id = task_item_config.Condition[1]
    local need_value = condition_config[condition_id].Value
    local fill_img = Util.get_image("Bar/BarFill_", obj)
    local temp_score = self.v_complete_active_score - last_need_value
    fill_img.fillAmount = mathx.Clamp(temp_score / (need_value - last_need_value), 0, 1)
    last_need_value = need_value
    local blockactive_obj = Util.get_image("Award_/Block/BlockActive_", obj).gameObject
    local complete_obj = Util.get_image("Award_/Complete_", obj).gameObject
    local check_obj = Util.get_image("Award_/Check_", obj).gameObject
    local Fx_UIOrder_AwardIcon = Util.get_child_gameobj("Award_/Complete_/Fx_UIOrder_AwardIcon", obj).gameObject
    local count_txt = Util.get_text("Award_/Text", obj)
    blockactive_obj:SetActive(task_info.state ~= TASK_STATE.none)
    complete_obj:SetActive(task_info.state == TASK_STATE.receive)
    if task_info.state == TASK_STATE.receive then
      table.insert(self.v_can_receive_task_id_list, task_id)
    end
    if task_info.state ~= TASK_STATE.received then
      self.v_is_all_active_award_received = false
    end
    check_obj:SetActive(task_info.state == TASK_STATE.received)
    Fx_UIOrder_AwardIcon:SetActive(task_info.state == TASK_STATE.receive and self.v_task_last_state_map[task_id] == TASK_STATE.none)
    self.v_task_last_state_map[task_id] = task_info.state
    count_txt.text = need_value
    local btn = Util.get_button("Award_", obj)
    self:remove_button_listener(btn)
    if task_info.state == TASK_STATE.receive then
      self:set_button_listener(btn, function()
        TaskMgr:submit_task(task_id, function()
          if not self:visible() or not self:has_inited() then
            return
          end
          PassPortMgr:update_red_point_tree()
          self:refresh(false)
        end)
      end)
    else
      self:set_button_listener(btn, function()
        self:show_award_preview(true, task_info, btn.transform)
      end)
    end
  end
  self.v_uicompents.ActivationName_txt.text = word_string
  self.v_uicompents.ActivationNum_txt.text = self.v_complete_active_score
end

function ui:refresh_task_panel(type, play_ui_effect)
  self:give_back_auto_cache(TASK_AWARD_TEM)
  self:give_back_auto_cache(TASK_TEM)
  self.v_can_receive_task_id_list = {}
  self.v_complete_active_score = 0
  local task_config = ShareRes.create("condition.task")
  local award_group = ShareRes.create("award.award_group")
  local award_config = ShareRes.create("award.award")
  local condition_config = ShareRes.create("condition.condition")
  self.v_uiobjects.ShortScorll:SetActive(type ~= TASK_TYPE.PASSPORT)
  self.v_uiobjects.LongScroll:SetActive(type == TASK_TYPE.PASSPORT)
  local task_list
  if type == TASK_TYPE.DAILY then
    task_list = UtilTable.copy_table(ShareRes.create("task.daily_task"))
    local random_task = PassPortMgr:get_passport_random_task_list().daily_task_ids
    for _, task_id in ipairs(random_task) do
      local temp = {
        Id = #task_list + 1,
        TaskId = task_id
      }
      table.insert(task_list, temp)
    end
  elseif type == TASK_TYPE.WEEKLY then
    task_list = UtilTable.copy_table(ShareRes.create("task.weekly_task"))
    local random_task = PassPortMgr:get_passport_random_task_list().week_task_ids
    for _, task_id in ipairs(random_task) do
      local temp = {
        Id = #task_list + 1,
        TaskId = task_id
      }
      table.insert(task_list, temp)
    end
  elseif type == TASK_TYPE.PASSPORT then
    local task_group_id = self.v_battle_passport_cfg.TaskGroup
    task_list = ShareRes.get_task_group_cfg(task_group_id)
  end
  local after_sort_task_list = {}
  for index, config in pairs(task_list) do
    local task_id, task_info
    if type == TASK_TYPE.PASSPORT then
      task_id = index
    else
      task_id = config.TaskId
    end
    task_info = TaskMgr:get_task_by_id(task_id)
    local state = task_info.state
    local sort_index = 1
    if state == TASK_STATE.receive then
      sort_index = 2
    elseif state == TASK_STATE.received then
      sort_index = 0
    end
    if type == TASK_TYPE.PASSPORT then
      local temp_config = {
        TaskId = task_id,
        sort_index = sort_index,
        Id = index
      }
      if state ~= TASK_STATE.expire and state ~= TASK_STATE.noactive then
        table.insert(after_sort_task_list, temp_config)
      end
    else
      config.sort_index = sort_index
      table.insert(after_sort_task_list, config)
    end
  end
  table.sort(after_sort_task_list, function(a, b)
    if a.sort_index == b.sort_index then
      return a.Id < b.Id
    end
    return a.sort_index > b.sort_index
  end)
  local temp_task_list = {}
  for index, config in ipairs(after_sort_task_list) do
    local task_item = self:get_auto_cache(TASK_TEM)
    table.insert(temp_task_list, task_item)
    if type == TASK_TYPE.PASSPORT then
      task_item.transform:SetParent(self.v_uiobjects.LongList.transform, false)
    else
      task_item.transform:SetParent(self.v_uiobjects.ShortList.transform, false)
    end
    task_item.transform:SetSiblingIndex(index - 1)
    local task_id = config.TaskId
    local task_item_config = task_config[task_id]
    local task_info = TaskMgr:get_task_by_id(task_id)
    local task_state = task_info.state
    local award_id = award_group[task_item_config.Award][1]
    local award_num = award_config[award_id].Num
    if task_state == TASK_STATE.received then
      self.v_complete_active_score = self.v_complete_active_score + award_num
    end
    if task_state == TASK_STATE.receive then
      table.insert(self.v_can_receive_task_id_list, task_id)
    end
    local time_obj = Util.get_child_gameobj("Time_", task_item)
    local ct_reward_list_obj = Util.get_child_gameobj("Group/CtRewardList_", task_item)
    local taskpoint_obj = Util.get_child_gameobj("Group/TaskPoint_", task_item)
    local bg_complete_obj = Util.get_child_gameobj("BgComplete_", task_item)
    local ctget_obj = Util.get_child_gameobj("CtGet_", task_item)
    local jump_obj = Util.get_child_gameobj("BtnJump_", task_item)
    local nowtext_obj = Util.get_child_gameobj("NowText_", task_item)
    local finishtext_obj = Util.get_child_gameobj("FinishText_", task_item)
    local taskpointGot_obj = Util.get_child_gameobj("Group/TaskPoint_/TaskPoint/TaskPointGot_", task_item)
    local title_txt = Util.get_text("Group/Decoration/CtContent_", task_item)
    local now_number_txt = Util.get_text("Group/Decoration/Now_", task_item)
    local split_txt = Util.get_text("Group/Decoration/Now_/split_", task_item)
    local need_number_txt = Util.get_text("Group/Decoration/Now_/split_/Need_", task_item)
    local award_count_txt = Util.get_text("Group/TaskPoint_/TaskPointNum_", task_item)
    local time_txt = Util.get_text("Time_/TimeNum_", task_item)
    local award_icon = Util.get_image("Group/TaskPoint_/TaskPoint/TaskPointIcon_", task_item)
    local cttaskdone_sld = Util.get_image("CtBar/CtTaskDone_", task_item)
    local ctget_btn = Util.get_button("CtGet_", task_item)
    local jump_btn = Util.get_button("BtnJump_", task_item)
    time_obj:SetActive(type == TASK_TYPE.PASSPORT)
    ct_reward_list_obj:SetActive(true)
    taskpoint_obj:SetActive(type ~= TASK_TYPE.PASSPORT)
    bg_complete_obj:SetActive(task_state == TASK_STATE.receive)
    ctget_obj:SetActive(task_state == TASK_STATE.receive)
    jump_obj:SetActive(task_state == TASK_STATE.none and 0 ~= task_item_config.Jump)
    nowtext_obj:SetActive(task_state == TASK_STATE.none and 0 == task_item_config.Jump)
    finishtext_obj:SetActive(task_state == TASK_STATE.received)
    taskpointGot_obj:SetActive(task_state == TASK_STATE.received)
    if ctget_obj.activeSelf then
      self:set_button_listener(ctget_btn, function()
        TaskMgr:submit_task(task_id, function()
          if not self:visible() or not self:has_inited() then
            return
          end
          self:update_user_data()
          PassPortMgr:update_red_point_tree()
          self.v_uiobjects.Fx_UIOrder_TaskObj_Level:SetActive(false)
          self.v_uiobjects.Fx_UIOrder_TaskObj_Level:SetActive(true)
        end)
      end)
    end
    if jump_obj.activeSelf then
      self:set_button_listener(jump_btn, function()
        SysOpenMgr:jump_to_sys(task_item_config.Jump, true)
      end)
    end
    title_txt.text = task_item_config.Name
    local now = task_info and task_info.progress and #task_info.progress > 0 and task_info.progress[1].progress or 0
    local need = condition_config[task_item_config.Condition[1]].Value
    now_number_txt.text = now
    need_number_txt.text = need
    award_count_txt.text = string.format(count_format, award_num)
    cttaskdone_sld.fillAmount = now / need
    local color
    if task_state ~= TASK_STATE.receive then
      color = color_type.bright
    else
      color = color_type.dark
    end
    Util.set_color(title_txt, color)
    Util.set_color(now_number_txt, color)
    Util.set_color(split_txt, color)
    Util.set_color(need_number_txt, color)
    local alpha = 1
    if task_state == TASK_STATE.none then
      color = color_type.bright
    elseif task_state == TASK_STATE.receive then
      color = color_type.dark
    else
      color = color_type.black
      alpha = 0.2
    end
    Util.set_color(award_icon, color, alpha)
    if type == TASK_TYPE.PASSPORT and task_item_config.ExpireTime then
      self.v_tasks_need_to_update_time[index] = {}
      self.v_tasks_need_to_update_time[index].time_txt = time_txt
      self.v_tasks_need_to_update_time[index].ExpireTime = task_item_config.ExpireTime
      time_txt.text = Global.date.get_time_formate_2(Date.get_time_stamp_by_scheme_id(task_item_config.ExpireTime) - Global.date.server_time())
    else
      self.v_tasks_need_to_update_time[index] = nil
      time_obj:SetActive(false)
    end
    local award_id_list = award_group[task_item_config.Award]
    for index, value in ipairs(award_id_list) do
      if 0 == value then
        break
      end
      if type ~= TASK_TYPE.PASSPORT and 2 ~= index then
      else
        local temp_config = award_config[value]
        local temp_award = self:get_auto_cache(TASK_AWARD_TEM)
        temp_award.transform:SetParent(Util.get_child_gameobj("Group/CtRewardList_/Viewport/AwardContent_", task_item).transform, false)
        local item_quality = Util.get_image("CiPz_", temp_award)
        local icon_img = Util.get_image("CiItemIcon_", temp_award)
        local item_txt = Util.get_text("AmoBg/CiItemAmount_", temp_award)
        local mask_obj = Util.get_child_gameobj("Mask_", temp_award)
        item_txt.text = temp_config.Num
        local item_id = temp_config.ItemId
        local item_cfg = ShareRes.get_item_cfg(item_id)
        local icon_path = string.format(icon_path_prefix, item_cfg.Icon)
        ResMgr:load_set_icon(item_quality, Quality_Img[item_cfg.Quality])
        ResMgr:load_set_icon(icon_img, icon_path)
        mask_obj:SetActive(task_state == TASK_STATE.received)
        local btn = temp_award:GetComponent(TypeUnityUIButton)
        self:set_button_listener(btn, function()
          UIMgr:get_ui("itemTip"):ui_show({item_id = item_id})
        end)
      end
    end
  end
  self:refresh_active_score(type)
  self.v_uiobjects.BtnAllRecive:SetActiveEx(PassPortMgr.has_award)
  if play_ui_effect then
    self.v_uicompents.TaskPageTem1_tog.interactable = false
    self.v_uicompents.TaskPageTem2_tog.interactable = false
    self.v_uicompents.TaskPageTem3_tog.interactable = false
    for index, task_item in ipairs(temp_task_list) do
      local canvas_group = task_item:GetComponent("CanvasGroup")
      canvas_group.alpha = 0
      local pd = Util.get_playabledirector("Ani_UIOrder_TaskTem_In", task_item)
      self.v_timer_index_list_3[index] = Timer:add_timer(nil, 0.15 * (index - 1), function()
        pd:Play()
        if index == #temp_task_list then
          self.v_uicompents.TaskPageTem1_tog.interactable = true
          self.v_uicompents.TaskPageTem2_tog.interactable = true
          self.v_uicompents.TaskPageTem3_tog.interactable = true
        end
      end)
    end
  end
end

function ui:show_award_preview(should_show, task_info, item_transform)
  self.v_uiobjects.AwardTips:SetActive(should_show)
  self.v_uiobjects.BtnCloseTips:SetActive(should_show)
  if not should_show then
    return
  end
  local pos = UIMgr.root_camera:WorldToViewportPoint(item_transform.position)
  pos.x = pos.x * self.v_canvas_rect.sizeDelta.x
  pos.y = pos.y * self.v_canvas_rect.sizeDelta.y
  pos.x = pos.x + AWARDTIPS_OFFSET_X
  pos.y = pos.y + AWARDTIPS_OFFSET_Y
  local awardtips_rect = self.v_uiobjects.AwardTips:GetComponent(TypeUnityRectTransform)
  awardtips_rect:SetAnchoredPositionA(pos.x, pos.y)
  self.v_uiobjects.BtnCloseTips:SetActive(true)
  self:give_back_auto_cache(AWARD_PREVIEW_TEM)
  local award_group_id = task_info.task_cfg.Award
  local award_group = ShareRes.create("award.award_group")
  local award_config = ShareRes.create("award.award")
  local award_id_list = award_group[award_group_id]
  for _, value in ipairs(award_id_list) do
    if 0 == value then
      break
    end
    local temp_award = self:get_auto_cache(AWARD_PREVIEW_TEM)
    local temp_config = award_config[value]
    local item_quality = Util.get_image("CiPz_", temp_award)
    local icon_img = Util.get_image("CiItemIcon_", temp_award)
    local item_txt = Util.get_text("AmoBg/CiItemAmount_", temp_award)
    local mask_obj = Util.get_child_gameobj("Mask_", temp_award)
    item_txt.text = temp_config.Num
    local item_id = temp_config.ItemId
    local item_cfg = ShareRes.get_item_cfg(item_id)
    local icon_path = string.format(icon_path_prefix, item_cfg.Icon)
    ResMgr:load_set_icon(item_quality, Quality_Img[item_cfg.Quality])
    ResMgr:load_set_icon(icon_img, icon_path)
    mask_obj:SetActive(task_info.state == TASK_STATE.received)
    local btn = Util.get_button(nil, temp_award)
    self:remove_button_listener(btn)
    self:set_button_listener(btn, function()
      UIMgr:get_ui("itemTip"):ui_show({item_id = item_id, is_exist_jump = false})
    end)
  end
end

function ui:update_user_data(dont_refresh)
  local last_passport_id = self.v_user_data and self.v_user_data.id or -1
  self.v_user_data = PassPortMgr:get_passport_data()
  self.v_normal_award_got_map, self.v_senior_award_got_map = PassPortMgr:get_award_got_map()
  self.v_battle_passport_cfg = ShareRes.get_battle_passport_cfg(self.v_user_data.id)
  self.v_battle_passport_group = ShareRes.get_battle_passport_group_cfg(self.v_battle_passport_cfg.Group)
  if self.v_user_data.id ~= last_passport_id then
    self.v_is_set_infinite_data = false
  end
  self.v_key_award_index_list = {}
  for index, param in ipairs(self.v_battle_passport_group) do
    if param.IsBigAward then
      table.insert(self.v_key_award_index_list, index)
    end
  end
  if true ~= dont_refresh then
    self:refresh()
  end
end

function ui:get_user_data()
  return self.v_user_data
end

function ui:on_update_passport_exp_lv()
  if self.v_uiobjects then
    self.v_uiobjects.Fx_UIOrder_OrderLevel:SetActive(false)
    self.v_uiobjects.Fx_UIOrder_OrderLevel:SetActive(true)
  end
end

function ui:on_update_random_task()
  if self.v_cur_tog_type == TOGTYPE.TASK and self.v_cur_task_type ~= TASK_TYPE.PASSPORT then
    self:refresh_task_panel(self.v_cur_task_type)
  end
end

function ui:play_anim_on_show()
end

function ui:play_anim_on_click_award_panel()
  self.v_savearea_canvas_group.blocksRaycasts = false
  local canvas_group = self.v_uiobjects.AwardObj:GetComponent("CanvasGroup")
  canvas_group.alpha = 1
  self.v_uicompents.Ani_UIOrder_AwardObj_pd:Play()
  self.v_scroll_timer_index = Timer:add_timer(nil, self.v_uicompents.Ani_UIOrder_AwardObj_pd.duration, function()
    self.v_savearea_canvas_group.blocksRaycasts = true
  end)
end

function ui:play_anim_on_click_task_panel()
  self.v_init = nil
  self.v_cur_tog_type = TOGTYPE.TASK
  self:refresh(true)
end

function ui:play_anim_unlock_senior()
  self.v_uicompents.Ani_UIOrder_Unlock_pd.time = 0
  self.v_uicompents.Ani_UIOrder_Unlock_pd:Play()
end

function ui:update_rolling_image(delta_time)
  if self.v_is_draging then
    self.v_rolling_duration = 0
  else
    self.v_rolling_duration = self.v_rolling_duration + delta_time
  end
  if self.v_rolling_duration > self.v_rolling_interval then
    self.v_rolling_duration = self.v_rolling_duration % self.v_rolling_interval
    self:rolling_operation(true)
  end
end

function ui:rolling_operation(right_swipe)
  local sign = right_swipe and 1 or -1
  self.v_rolling_index = 1 == sign and self.v_rolling_index + 1 or self.v_rolling_index - 1
  self.v_rolling_index = self.v_rolling_index > #self.v_rolling_image_path_list and 1 or self.v_rolling_index
  self.v_rolling_index = 0 == self.v_rolling_index and #self.v_rolling_image_path_list or self.v_rolling_index
  local rolling_left_index = 1 == self.v_rolling_index and #self.v_rolling_image_path_list or self.v_rolling_index - 1
  local rolling_right_index = self.v_rolling_index == #self.v_rolling_image_path_list and 1 or self.v_rolling_index + 1
  local origin_x = self.v_uicompents.ScrollContent_rect.anchoredPosition.x
  local origin_y = self.v_uicompents.ScrollContent_rect.anchoredPosition.y
  self.v_uicompents.ScrollContent_rect:SetAnchoredPositionA(origin_x + self.v_rolling_image_width * sign, origin_y)
  self:set_rolling_image(self.v_rolling_image_path_list[rolling_left_index], self.v_rolling_image_path_list[self.v_rolling_index], self.v_rolling_image_path_list[rolling_right_index])
  self.v_rolling_toggle_list[self.v_rolling_index].isOn = true
  self.v_uicompents.RollingIconTitleText_txt.text = self.v_battle_passport_cfg.RollingImageDesc[self.v_rolling_index]
end

function ui:set_rolling_image(left_image_path, middle_image_path, right_image_path)
  ResMgr:load_set_icon(self.v_icon_lert_image, left_image_path, nil, true)
  ResMgr:load_set_icon(self.v_icon_middle_image, middle_image_path, nil, true)
  ResMgr:load_set_icon(self.v_icon_right_image, right_image_path, nil, true)
end

function ui:cache_award_choice_ui_info(only_show, award_group_id, lv, is_senior)
  self.v_award_choice_ui_cache.only_show = only_show
  self.v_award_choice_ui_cache.award_group_id = award_group_id
  self.v_award_choice_ui_cache.lv = lv
  self.v_award_choice_ui_cache.is_senior = is_senior
end

return ui
