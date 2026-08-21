local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local ASSIST_SELECT_CLASS = require("uimodule.character.Assist.assist_select_item")
local CommonDefine = require("cs_share.common_define")
local CharcterConfig = require("uimodule.character.character_config")
local TRIGGER_SOUND_TYPE = CharcterConfig.TRIGGER_SOUND_TYPE
local _insert = table.insert
local _tsort = table.sort
local CT_Timer = Global.ct_timer
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {
  v_btn_refresh = {
    "BtnRefresh",
    BIND_TYPE.BUTTON
  },
  v_btn_ret1 = {
    "BtnRet1",
    BIND_TYPE.BUTTON
  },
  v_can_refresh_txt = {
    "CanRefreshTxt",
    BIND_TYPE.TEXT
  },
  v_cd_txt = {
    "CdTxt",
    BIND_TYPE.TEXT
  },
  v_refresh_max = {
    "RefreshMax",
    BIND_TYPE.TEXT
  },
  v_refresh_now = {
    "RefreshNow",
    BIND_TYPE.TEXT
  },
  v_up_tips = {
    "UpTips",
    BIND_TYPE.TEXT
  }
}
local ASSIST_LEFT_TAB_KEY = "ASSIST_LEFT_TAB_KEY"
local ASSIST_CHAR_ITEM_KEY = "ASSIST_CHAR_ITEM_KEY"
local PAGE_LIST = {ELEMENT = 1, JOB = 2}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("BtnRet1", function()
    self.v_cur_tab = nil
    if self.v_is_from_team then
      self:setup_team_view()
    end
    self:ui_hide()
  end)
  self:set_button("BtnRefresh", function()
    self:on_click_refresh()
  end)
  self:set_toggle("TogOnlyFriend", function()
    self:refresh_item_visible(self.v_cur_page_select, self.v_cur_tab_select, self.v_cur_param)
  end)
  self:set_button("BtnScreenType", function()
    local select_page = PAGE_LIST.ELEMENT
    if self.v_cur_page_select == PAGE_LIST.ELEMENT then
      select_page = PAGE_LIST.JOB
    end
    self:switch_page(select_page, 1)
  end)
  self:register_exist_auto_template(ASSIST_CHAR_ITEM_KEY, self.v_uiobjects.CharTem, self.v_uiobjects.CharTemContent)
  self:register_exist_auto_template(ASSIST_LEFT_TAB_KEY, self.v_uiobjects.PageTem, self.v_uiobjects.PageContent)
  self.v_com_cfg = ShareRes.create("helpfight.help_fight_push")[1]
end

function ui:on_click_refresh()
  local function cb()
    self:refresh_countdown_timer()
  end
  
  AssistMgr:request_refresh_all_push_list(cb)
end

function ui:ui_on_show(team_data, is_from_team, ban_buddys, page_type, tab_idx, tab_param, only_friend, do_refresh)
  self.v_team_data = team_data
  self.v_is_from_team = is_from_team
  self.v_ban_buddys = ban_buddys
  self.v_cur_page_select = page_type or PAGE_LIST.ELEMENT
  self.v_cur_tab_select = tab_idx or 1
  self.v_cur_param = tab_param
  self.v_reset_scroll = nil == tab_idx
  self.v_uicompents.TogOnlyFriend_tog.isOn = true == only_friend
  self:refresh_buddy_content()
  self:switch_page(self.v_cur_page_select, self.v_cur_tab_select)
  self:register_event()
end

function ui:register_event()
  self:bind_auto_mq(Const.MSG_ON_ASSIST_DATA_UPDATE, self.on_assist_data_update, self)
end

function ui:on_assist_data_update()
  self:refresh_buddy_content()
  self:refresh_item_visible(self.v_cur_page_select, self.v_cur_tab_select, self.v_cur_param)
end

function ui:ui_on_hide()
  if self.v_ct_timer then
    CT_Timer:remove_timer(self.v_ct_timer)
    self.v_ct_timer = nil
  end
  self:clear_ui_wrap()
  self.v_is_from_team = nil
end

function ui:ui_on_destroy()
  if self.v_ct_timer then
    CT_Timer:remove_timer(self.v_ct_timer)
    self.v_ct_timer = nil
  end
  self.v_cur_tab = nil
  self.v_is_from_team = nil
end

function ui:cache_ui()
  return true
end

function ui:get_cache_data()
  return self.v_team_data, self.v_is_from_team, self.v_ban_buddys, self.v_cur_page_select, self.v_cur_tab_select, self.v_cur_param, self.v_uicompents.TogOnlyFriend_tog.isOn
end

function ui:switch_page(page_type, tab_idx)
  self.v_cur_page_select = page_type
  self.v_page_tog = self:refresh_page_tog(page_type)
  self.v_page_tog[tab_idx].isOn = false
  self.v_page_tog[tab_idx].isOn = true
  self.v_uiobjects.EleSelect:SetActive(page_type == PAGE_LIST.ELEMENT)
  self.v_uiobjects.JobSelect:SetActive(page_type == PAGE_LIST.JOB)
end

function ui:refresh_page_tog(page_type)
  local cfg_list = {}
  local ret_list = {}
  if page_type == PAGE_LIST.ELEMENT then
    cfg_list = ShareRes.create("buddy.buddy_element")
  elseif page_type == PAGE_LIST.JOB then
    cfg_list = ShareRes.create("buddy.buddy_job")
  end
  self:give_back_auto_cache(ASSIST_LEFT_TAB_KEY)
  local item_all = self:get_auto_cache(ASSIST_LEFT_TAB_KEY)
  local tog_all_tog = Util.get_toggle(nil, item_all)
  self:set_toggle_listener(tog_all_tog, function(isOn)
    if isOn then
      self:refresh_item_visible(page_type, 1, nil)
      tog_all_tog.interactable = false
    else
      tog_all_tog.interactable = true
    end
  end)
  _insert(ret_list, tog_all_tog)
  for idx, data in ipairs(cfg_list) do
    if 0 ~= data.SortId then
      local item = self:get_auto_cache(ASSIST_LEFT_TAB_KEY)
      local desc = Util.get_text("TagName", item)
      local element_icon = Util.get_image("Icon", item)
      local tog = Util.get_toggle(nil, item)
      tog.isOn = false
      if page_type == PAGE_LIST.ELEMENT then
        ResMgr:load_set_icon(element_icon, data.ElementIconPath)
        desc.text = data.ElementName
      elseif page_type == PAGE_LIST.JOB then
        ResMgr:load_set_icon(element_icon, data.IconPath)
        desc.text = data.Name
      end
      self:set_toggle_listener(tog, function(isOn)
        if isOn then
          self:refresh_item_visible(page_type, idx, data.Id)
          tog.interactable = false
        else
          tog.interactable = true
        end
      end)
      _insert(ret_list, tog)
    end
  end
  return ret_list
end

function ui:refresh_buddy_content(page_type, tab_idx, param)
  self.v_cur_page_select = page_type or self.v_cur_page_select or PAGE_LIST.ELEMENT
  self.v_cur_tab_select = tab_idx or self.v_cur_tab_select or 1
  self.v_cur_param = param or self.v_cur_param
  self.v_assist_list = AssistMgr:get_buddy_list()
  self:give_back_auto_cache(ASSIST_CHAR_ITEM_KEY)
  self:clear_ui_wrap()
  self.v_buddy_items = {}
  for idx, data in ipairs(self.v_assist_list) do
    local ui_item = self:get_auto_cache(ASSIST_CHAR_ITEM_KEY)
    local select_obj = ASSIST_SELECT_CLASS:ui_wrap_ex(self, ui_item, false)
    local is_ban = self:is_buddy_ban(data.id)
    self.v_buddy_items[idx] = select_obj
    select_obj.go = ui_item
    select_obj:set_data(data, self.v_team_data, is_ban)
  end
  self:refresh_assist_times()
  self:refresh_countdown_timer()
end

function ui:refresh_item_visible(page_type, tab_idx, param)
  self.v_cur_page_select = page_type
  self.v_cur_tab_select = tab_idx
  self.v_cur_param = param
  if not self.v_assist_list or not self.v_buddy_items then
    self.v_uiobjects.NoPlayer:SetActive(false)
    return
  end
  local only_friend = self.v_uicompents.TogOnlyFriend_tog.isOn
  local is_empty = true
  for idx, data in ipairs(self.v_assist_list) do
    local show = true
    if only_friend and data.type ~= CommonDefine.ASSIST_BUDDY_TYPE.FRIEND then
      show = false
    elseif param then
      if page_type == PAGE_LIST.ELEMENT then
        if param ~= data.element then
          show = false
        end
      elseif param ~= data.job then
        show = false
      end
    end
    if show then
      is_empty = false
    end
    self.v_buddy_items[idx].go:SetActiveEx(show)
  end
  self.v_uiobjects.NoPlayer:SetActive(is_empty)
  if self.v_reset_scroll then
    self.v_uicompents.CharTemContent_rect:SetLocalPositionA(0, 0, 0)
  else
    self.v_reset_scroll = true
  end
end

function ui:clear_ui_wrap()
  if self.v_buddy_items then
    self:remove_wrap_ui_list(self.v_buddy_items)
    self.v_buddy_items = nil
  end
end

local normal_color = Util.get_unity_color_by_hex(tonumber("B19F89", 16))
local max_color = Util.get_unity_color_by_hex(tonumber("FF5E5E", 16))

function ui:refresh_assist_times()
  local now = AssistMgr:get_stranger_help_cnt()
  local max = self.v_com_cfg.StrangerHelpCnt
  self.v_refresh_now.text = now
  self.v_refresh_max.text = max
  self.v_refresh_now.color = now >= max and max_color or normal_color
end

function ui:refresh_countdown_timer()
  if self.v_ct_timer then
    CT_Timer:remove_timer(self.v_ct_timer)
    self.v_ct_timer = nil
  end
  local remain_cd_time = AssistMgr:get_remain_cd_time()
  if remain_cd_time > 0 then
    self.v_cd_txt.text = Util.format_str("{1}秒", remain_cd_time)
    self:refresh_btn_view(true)
    self.v_ct_timer = CT_Timer:add_timer("char_assist:create_countdown_timer", remain_cd_time, function(remain_time)
      if remain_time > 0 then
        self.v_cd_txt.text = Util.format_str("{1}秒", remain_time)
        self:refresh_btn_view(true)
      else
        self:refresh_btn_view(false)
      end
    end)
  else
    self:refresh_btn_view(false)
  end
end

function ui:refresh_btn_view(in_cd)
  self.v_btn_refresh.interactable = not in_cd
  self.v_uiobjects.CanRefreshTxt:SetActiveEx(not in_cd)
  self.v_uiobjects.CdTxt:SetActiveEx(in_cd)
  Util.apply_grey_ex(self.v_uiobjects.BtnRefresh, in_cd)
end

function ui:setup_team_view()
  local team = UIMgr:try_get_visible_ui("team")
  if team then
    team:set_model_enable()
    team:refresh_view_with_char_enter_view_hide()
  end
end

function ui:on_select_buddy(buddy_info)
  local function succ_callback()
    AssistMgr:set_assist_buddy(buddy_info)
    
    self:change_team_info(buddy_info)
    AssistMgr:clear_assist_buddy_old_info()
    self.v_cur_tab = nil
    self:ui_hide()
  end
  
  if buddy_info then
    local point_id = self.v_team_data.point_id
    local pos = self.v_team_data.select_pos
    AssistMgr:request_set_fight_assist(point_id, buddy_info.element, buddy_info.index, pos, succ_callback)
  end
end

function ui:change_team_info(buddy_info, is_remove)
  local target_pos = self.v_team_data.select_pos
  local buddy_id = is_remove and 0 or buddy_info.id
  if not is_remove then
    CharacterMgr:trigger_buddy_sound(TRIGGER_SOUND_TYPE.GOTO_TEAM, buddy_id)
  end
  local team = UIMgr:try_get_visible_ui("team")
  if team then
    team:update_pos_hero(target_pos, buddy_id, nil, true)
    team:update_fight_val()
  end
  self:setup_team_view()
  UIMgr:remove_stace_by_ui_name("character_enter")
end

function ui:is_buddy_ban(buddy_id)
  if self.v_team_data and self.v_team_data.formation_type == CommonDefine.FORMATION_TYPE.WEEK_ACTY_PVP_TEAM then
    return WeeklyMgr:get_is_pvp_used(buddy_id)
  end
  if self.v_ban_buddys and self.v_ban_buddys[buddy_id] then
    return true
  end
end

return ui
