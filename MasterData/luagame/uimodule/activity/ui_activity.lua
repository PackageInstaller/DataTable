local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local ACTIVITY_ITEM = require("uimodule.activity.activity_item")
local UI_ACTIVITY_PAGE_TEM_KEY = "UI_ACTIVITY_PAGE_TEM_KEY"
local VerticalLayoutGroup = UnityEngine.UI.VerticalLayoutGroup
local LayoutRebuilder = UnityEngine.UI.LayoutRebuilder
local _tinsert = table.insert
local _tsort = table.sort
local ACTIVITY_TIME_TYPE = {DESIGNATED_PERIOD = 1, DURATION = 2}
local TOGGLE_LIST = {}
local UI_NAME_TO_TOGGLE = {}
local UI_NAME_TO_REDPOINT = {
  ui_novice_task2 = RedEnum.NOVICE_DAILY_TASK,
  ui_novice_signin_0 = RedEnum.NOVICE_SIGN_IN,
  ui_novice_signin_1 = RedEnum.SEVEN_SIGN_IN_01,
  ui_novice_signin_2 = RedEnum.SEVEN_SIGN_IN_02,
  ui_novice_signin_3 = RedEnum.SEVEN_SIGN_IN_03,
  ui_novice_signin_4 = RedEnum.SEVEN_SIGN_IN_04,
  ui_novice_privilege = RedEnum.NOVICE_PRIVILEGE,
  ui_novice_course_award = RedEnum.NOVICE_COURSE_AWARD,
  ui_buddy_tryout = RedEnum.BUDDY_TRYOUT,
  ui_level_welfare = RedEnum.LEVEL_WELFARE,
  ui_task_activity_1 = RedEnum.FATE_BOOK_TASK,
  ui_task_activity_2 = RedEnum.WEEKLY_ACT_TASK,
  ui_catch_cat_activity = RedEnum.CATCA_CAT_ACT,
  ui_fatebook_double_activity = RedEnum.FATEBOOK_DOUBLE_CHALLENGE,
  ui_material_double_activity = RedEnum.MATERIAL_DOUBLE_CHALLENGE,
  ui_monkey_typer_activity = RedEnum.MONKEY_TYPER_ACT,
  ui_weapon_activity = RedEnum.WAEPON_ACTIVITY,
  ui_skin_tryout = RedEnum.SKIN_TRYOUT,
  ui_skin_tryout_1 = RedEnum.SKIN_TRYOUT_01,
  ui_skin_tryout_2 = RedEnum.SKIN_TRYOUT_02,
  ui_skin_tryout_3 = RedEnum.SKIN_TRYOUT_03,
  ui_compensate_activity = RedEnum.COMPENSATE_TASK,
  ui_task_activity3 = RedEnum.PUZZLE_ACT,
  ui_return_activity_main = RedEnum.RET_ACT_MAIN,
  ui_activity_daily1 = RedEnum.ACT_DAILY_01
}
local BUDDY_TRY_UI_NAME = "ui_buddy_tryout"
local BUDDY_DRAW_SELECT_UI_NAME = "ui_buddy_draw_activity"
local CUSTOM_CONDITION_ACT_TYPE = {
  SEVEN_SIGN = 1,
  COURSE_AWARD = 4,
  LEVEL_WELFARE = 7,
  TASK_ACT = 9,
  CATCH_CAT = 10
}
local COMPENSATE_TYPE = 18

function ui:on_newbie_receive_award()
  if not self.v_page_item_list[UI_NAME_TO_TOGGLE.ui_novice_signin_0] then
    return
  end
  self.v_page_item_list[UI_NAME_TO_TOGGLE.ui_novice_signin_0]:refresh()
end

function ui:on_newbie_task_update()
  if not self.v_page_item_list[UI_NAME_TO_TOGGLE.ui_novice_task2] then
    return
  end
  local get_all = NoviceMgr:is_get_all_seven_sign_award()
  if get_all then
    MsgGame:mq_publish2(Const.MSG_NOVICE_ACTIVITY_CLOSE)
  else
    self.v_page_item_list[UI_NAME_TO_TOGGLE.ui_novice_task2]:refresh()
  end
end

function ui:on_activity_close()
  if not self.v_select_index then
    self:refresh(nil, false)
  else
    self:refresh(nil, true)
    local original_ui_name = TOGGLE_LIST[self.v_select_index].ui_name
    if UI_NAME_TO_TOGGLE[original_ui_name] then
      self:_on_click_toggle(UI_NAME_TO_TOGGLE[original_ui_name], true)
    else
      self:_on_click_toggle(UI_NAME_TO_TOGGLE[TOGGLE_LIST[1].ui_name], true)
    end
  end
end

function ui:ui_finish_load()
  self:set_button("BtnRet1", function()
    self:ui_hide()
  end)
  self:set_button("BtnMain", function()
    self:ui_hide()
  end)
  self.v_scroll_rect = self:get_scrollrect(nil, self.v_uiobjects.PageList)
  self:set_scrollrect_listener(self.v_scroll_rect, function()
    self:refresh_notice_red()
  end)
  self.v_viewport_height = self.v_uicompents.Viewport_rect.rect.height
  self.v_page_content_trans = self.v_uicompents.PageContent_rect
  self.v_content_vertical_layout_group = Util.get_component(nil, self.v_uiobjects.PageContent, typeof(VerticalLayoutGroup))
  self:register_exist_auto_template(UI_ACTIVITY_PAGE_TEM_KEY, self.v_uiobjects.PageTem, self.v_uiobjects.PageContent)
end

function ui:refresh_by_close_msg()
  local selected_activity_id = self:get_cache_data()
  if selected_activity_id then
    local is_active = NoviceMgr:get_novice_activity_active(selected_activity_id)
    if not is_active then
      Util.show_message_tip("活动已结束")
    end
  end
  self:refresh_by_msg()
end

function ui:refresh_by_msg()
  local selected_activity_id, sub_param = self:get_cache_data()
  self:refresh(selected_activity_id, false, sub_param)
end

function ui:refresh(activiy_id, force, sub_param)
  self:remove_wrap_list()
  self:give_back_auto_cache(UI_ACTIVITY_PAGE_TEM_KEY)
  self:build_toggle_list()
  local default_index, first_index
  self.v_tog_list = {}
  local select_index
  for i, data in ipairs(TOGGLE_LIST) do
    local page_item = self:get_auto_cache(UI_ACTIVITY_PAGE_TEM_KEY)
    page_item.name = data.ui_name
    local page_item_tog = Util.get_toggle(nil, page_item)
    self.v_tog_list[i] = page_item_tog
    page_item_tog.isOn = false
    self:set_toggle_listener(page_item_tog, function(isOn)
      self:_on_click_toggle(i, isOn)
    end)
    self.v_page_item_list[i] = ACTIVITY_ITEM:ui_wrap(self, page_item, true)
    local time_limit = data.time_remaining
    self.v_page_item_list[i]:set_data(i, data, time_limit)
    if data.redpoint == RedEnum.NOVICE_COURSE_AWARD then
      RedPointMgr:enable_redpoint(RedEnum.NOVICE_COURSE_AWARD, NoviceMgr:check_activity_journey_award())
    end
    first_index = first_index or i
    if not default_index and RedPointMgr:get_redpoint_enable_by_id(data.redpoint) then
      default_index = i
    end
    if activiy_id and data.id == activiy_id then
      select_index = i
    end
  end
  if not first_index then
    Log.Error("全部新人活动未解锁？？")
    Util.show_message_tip(2104)
    self.v_uiobjects.NotAcitivity:SetActive(true)
    return
  end
  self.v_uiobjects.NotAcitivity:SetActive(false)
  local index = select_index or default_index or first_index
  self.v_page_item_list[index]:set_is_on(true)
  self:_on_click_toggle(select_index or default_index or first_index, true, sub_param)
  if force or not select_index then
    self:scroll_to_force(index)
  end
  LayoutRebuilder.ForceRebuildLayoutImmediate(self.v_page_content_trans)
  self:refresh_notice_red()
end

function ui:scroll_to_force(index)
  local viewport_height = self.v_uicompents.Viewport_rect.rect.height
  local item_height = self.v_uicompents.PageTem_rect.rect.height
  local spacing = self.v_content_vertical_layout_group.spacing
  local top_padding = self.v_content_vertical_layout_group.padding.top
  local offset = index * (item_height + spacing) - spacing - viewport_height + top_padding
  if offset > 0 then
    self.v_uicompents.PageContent_rect:SetLocalPositionA(0, offset, 0)
  else
    self.v_uicompents.PageContent_rect:SetLocalPositionA(0, 0, 0)
  end
end

function ui:ui_on_show(activiy_id, sub_param)
  self.v_tog_list = {}
  self:bind_auto_mq(Const.MSG_NOVICE_SIGN_UPDATE, self.on_newbie_receive_award, self)
  self:bind_auto_mq(Const.MSG_ON_TASK_UPDATE, self.on_newbie_task_update, self)
  self:bind_auto_mq(Const.MSG_ON_TASK_GROUP_UPDATE, self.on_newbie_task_update, self)
  self:bind_auto_mq(Const.MSG_ON_TASK_GROUP_AWARD_LIST_UPDATE, self.on_newbie_task_update, self)
  self:bind_auto_mq(Const.MSG_NOVICE_INFO_UPDATE, self.on_newbie_task_update, self)
  self:bind_auto_mq(Const.MSG_NOVICE_ACTIVITY_CLOSE, self.refresh_by_close_msg, self)
  self:bind_auto_mq(Const.MSG_ON_NOVICE_ACTIVITY_OPEN, self.refresh_by_msg, self)
  self:bind_auto_mq(Const.MSG_ON_BUDDY_TRYOUT_LIST_UPDATE, self.on_buddy_tryout_data_change, self)
  self:set_full_mask_active(false)
  self:refresh(activiy_id, true, sub_param)
end

function ui:ui_update()
  if self.v_page_item_list then
    for i, item in pairs(self.v_page_item_list) do
      item:refresh_time_limit()
    end
  end
end

function ui:ui_on_hide()
  for key, item in pairs(self.v_page_item_list) do
    item:set_activity_ui_show(false)
  end
  self:remove_wrap_list()
end

function ui:_on_click_toggle(index, is_select, sub_param)
  if not is_select then
    return
  end
  if not self.v_page_item_list[index] then
    return
  end
  for key, tog in pairs(self.v_tog_list) do
    if key == index then
      self.v_page_item_list[key]:on_select_state_change(true, TOGGLE_LIST[key].id, sub_param)
    else
      self.v_page_item_list[key]:on_select_state_change(false)
      tog.isOn = false
    end
  end
  self.v_select_index = index
end

function ui:refresh_button()
  for key, item in pairs(self.v_page_item_list) do
    item:refresh()
  end
end

function ui:close_all_activity_ui()
  for key, item in pairs(self.v_page_item_list) do
    item:set_activity_ui_show(false)
  end
end

function ui:cache_ui()
  return true
end

function ui:get_cache_data()
  if TOGGLE_LIST[self.v_select_index] then
    return TOGGLE_LIST[self.v_select_index].id, self.v_sub_param
  end
end

function ui:set_sub_param(sub_param)
  self.v_sub_param = sub_param
end

function ui:remove_wrap_list()
  if self.v_page_item_list then
    for _, obj in pairs(self.v_page_item_list) do
      obj:ui_hide()
      obj:ui_destroy()
    end
  end
  self.v_page_item_list = {}
end

function ui:build_toggle_list()
  local novice_activity_list = NoviceMgr:get_novice_activity_list()
  TOGGLE_LIST = {}
  UI_NAME_TO_TOGGLE = {}
  for index, activity in pairs(novice_activity_list) do
    local activity_cfg = ShareRes.get_activity_cfg(activity.id)
    if not activity_cfg then
      Log.Error("服务器下发数据在活动总表配置未找到,id", activity.id)
    elseif activity_cfg.Hide then
    elseif NoviceMgr:get_activity_ban(activity.id) then
    else
      local custom_cond_pass = true
      if activity_cfg.Type == CUSTOM_CONDITION_ACT_TYPE.COURSE_AWARD then
        custom_cond_pass = NoviceMgr:check_activity_journey_state()
      elseif activity_cfg.Type == CUSTOM_CONDITION_ACT_TYPE.TASK_ACT and activity_cfg.TimeType == NoviceMgr.ACTIVITY_TIME_TYPE.UNLIMITEDTIME then
        custom_cond_pass = not self:is_task_activity_award_all_received(activity.id)
      elseif activity_cfg.Type == CUSTOM_CONDITION_ACT_TYPE.LEVEL_WELFARE then
        custom_cond_pass = not NoviceMgr:is_get_all_award()
      elseif activity_cfg.Type == CUSTOM_CONDITION_ACT_TYPE.SEVEN_SIGN then
        custom_cond_pass = not NoviceMgr:is_get_all_seven_sign_award()
      end
      if 0 == activity.is_end and custom_cond_pass then
        local insert_activity = {}
        insert_activity.id = activity.id
        insert_activity.ui_name = activity_cfg.UiName
        insert_activity.redpoint = UI_NAME_TO_REDPOINT[activity_cfg.UiName]
        insert_activity.time_remaining = self:get_time_remaining(activity_cfg.TimeType, activity_cfg.StopTime, activity.open_time, activity_cfg.SustainTime)
        insert_activity.page_bg = activity_cfg.PageImage
        insert_activity.Priority = activity_cfg.Priority
        insert_activity.time_type = activity_cfg.TimeType
        insert_activity.stop_time = activity_cfg.StopTime
        insert_activity.open_time = activity.open_time
        insert_activity.sustain_time = activity_cfg.SustainTime
        _tinsert(TOGGLE_LIST, insert_activity)
      end
    end
  end
  local all_cfg = ShareRes.create("activity.routine_activity")
  for _, activity_cfg in pairs(all_cfg) do
    if NoviceMgr:get_activity_ban(activity_cfg.Id) then
    elseif 1 == activity_cfg.ClientOnly then
      local custom_cond_pass = true
      local custom_page_bg
      if activity_cfg.UiName == BUDDY_TRY_UI_NAME then
        custom_cond_pass = BuddyTryoutMgr:check_activity_open()
        custom_page_bg = BuddyTryoutMgr:get_current_page_bg()
      elseif activity_cfg.UiName == BUDDY_DRAW_SELECT_UI_NAME then
        local next_choose_config = DrawCardMgr:get_next_choose_config(2)
        custom_cond_pass = next_choose_config and 1 == next_choose_config.Id
      end
      if custom_cond_pass and Condition:check_condition(activity_cfg.Condition) then
        local insert_activity = {}
        insert_activity.id = activity_cfg.Id
        insert_activity.ui_name = activity_cfg.UiName
        insert_activity.redpoint = UI_NAME_TO_REDPOINT[activity_cfg.UiName]
        insert_activity.page_bg = custom_page_bg or activity_cfg.PageImage
        insert_activity.Priority = activity_cfg.Priority
        _tinsert(TOGGLE_LIST, insert_activity)
      end
      if 21 == activity_cfg.Type and NoviceMgr:get_ret_act_open() then
        local insert_activity = {}
        insert_activity.id = activity_cfg.Id
        insert_activity.ui_name = activity_cfg.UiName
        insert_activity.redpoint = UI_NAME_TO_REDPOINT[activity_cfg.UiName]
        insert_activity.page_bg = custom_page_bg or activity_cfg.PageImage
        insert_activity.Priority = activity_cfg.Priority
        insert_activity.time_remaining = NoviceMgr:get_time_remaining_for_ret_act()
        _tinsert(TOGGLE_LIST, insert_activity)
      end
    elseif 9 == activity_cfg.Type then
      local activity_data = NoviceMgr:get_novice_activity_data(activity_cfg.Id)
      if not activity_data and activity_cfg.TimeType == NoviceMgr.ACTIVITY_TIME_TYPE.UNLIMITEDTIME then
        local insert_activity = {}
        insert_activity.id = activity_cfg.Id
        insert_activity.ui_name = activity_cfg.UiName
        insert_activity.redpoint = UI_NAME_TO_REDPOINT[activity_cfg.UiName]
        insert_activity.page_bg = activity_cfg.PageImage
        insert_activity.Priority = activity_cfg.Priority
        _tinsert(TOGGLE_LIST, insert_activity)
      end
    end
  end
  self:check_activity_finish(TOGGLE_LIST)
  
  local function sort_func(a, b)
    return a.Priority < b.Priority
  end
  
  _tsort(TOGGLE_LIST, sort_func)
  for index, activity in pairs(TOGGLE_LIST) do
    UI_NAME_TO_TOGGLE[activity.ui_name] = index
  end
end

function ui:check_activity_finish(tog_list)
  for _, activity in pairs(tog_list) do
    local is_finish = false
    local activity_cfg = ShareRes.get_activity_cfg(activity.id)
    if activity_cfg.UiName == BUDDY_TRY_UI_NAME then
      is_finish = BuddyTryoutMgr:check_activity_finish()
    elseif 10 == activity_cfg.Type then
      is_finish = self:is_catch_cat_activity_award_all_received(activity.id)
    elseif 11 == activity_cfg.Type then
      is_finish = self:is_monkey_typer_activity_award_all_received(activity.id)
    elseif 13 == activity_cfg.Type then
      is_finish = NoviceMgr:check_waepon_activity_finish()
    elseif 9 == activity_cfg.Type then
      is_finish = self:is_task_activity_award_all_received(activity_cfg.Id)
    end
    if is_finish then
      activity.Priority = activity.Priority * 1000
    end
  end
end

function ui:get_time_remaining(time_type, stop_time, open_time, sustain_time)
  local time_length = NoviceMgr:get_time_remaining(time_type, stop_time, open_time, sustain_time)
  if time_length then
    return Date.get_time_format_7(time_length)
  end
end

function ui:on_buddy_tryout_data_change()
  if BuddyTryoutMgr:check_activity_open() then
    self:update_page_bg()
  end
end

function ui:update_page_bg()
  local bg_change = false
  local buddy_tryout_page_bg = BuddyTryoutMgr:get_current_page_bg()
  for _, data in ipairs(TOGGLE_LIST) do
    if data.ui_name == BUDDY_TRY_UI_NAME then
      if buddy_tryout_page_bg ~= data.page_bg then
        data.page_bg = buddy_tryout_page_bg
        bg_change = true
      end
      break
    end
  end
  if bg_change and self.v_page_item_list then
    for _, item in ipairs(self.v_page_item_list) do
      if item.name == BUDDY_TRY_UI_NAME then
        item:update_page_bg(buddy_tryout_page_bg)
      end
    end
  end
end

function ui:refresh_notice_red()
  local up_red, down_red = false, false
  if self.v_page_item_list then
    local item_y = 0
    local content_y = self.v_page_content_trans.localPosition.y
    for index, item in ipairs(self.v_page_item_list) do
      if item.v_uiobjects.RedPoint.activeSelf then
        item_y = item.v_object_transform.localPosition.y
        if content_y + item_y > 0 then
          up_red = true
          if down_red then
            break
          end
        elseif content_y + item_y < -self.v_viewport_height then
          down_red = true
          if up_red then
            break
          end
        end
      end
    end
  end
  self.v_uiobjects.NoticeRed_Up:SetActiveEx(up_red)
  self.v_uiobjects.NoticeRed_Down:SetActiveEx(down_red)
end

local Activity_Task_Cfg = ShareRes.create("activity.activity_task")
local Catch_cat_Task_Cfg = ShareRes.create("activity.kitten_escape_task")
local Monkey_Typer_Task_Cfg = ShareRes.create("activity.monkey_typewriter_misc")

function ui:is_task_activity_award_all_received(task_activity_id)
  local cfg = Activity_Task_Cfg[task_activity_id]
  if not cfg then
    return true
  end
  return TaskMgr:check_task_list_all_received(cfg.TaskGroup)
end

function ui:is_catch_cat_activity_award_all_received(activity_id)
  local cfg = Catch_cat_Task_Cfg[activity_id]
  if not cfg then
    return true
  end
  return TaskMgr:check_task_list_all_received(cfg.TaskGroup)
end

function ui:is_monkey_typer_activity_award_all_received(activity_id)
  local cfg = Monkey_Typer_Task_Cfg[activity_id]
  if not cfg then
    return true
  end
  return TaskMgr:check_task_list_all_received(cfg.TaskGroupId) and TaskMgr:check_task_list_all_received(cfg.ProgressTaskGroupId)
end

function ui:set_full_mask_active(active)
  self.v_uiobjects.FullMask:SetActive(active)
end

return ui
