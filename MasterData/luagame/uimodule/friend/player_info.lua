local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local CommonDef = require("cs_share.common_define")
local UNION_TITLE = CommonDef.GUILD_POSITION_TYPE
local ToggleTab = require("ui.widget.widget_toggle_tab")
local CHAR_ITEM_CLASS = require("uimodule.friend.char_item")
local HERO_CHAR_ITEM = "HERO_CHAR_ITEM"
local GuiUtil = UnityEngine.GUIUtility
local BLACK_MAX_NUM = ShareRes.get_system_comm_value("BlacklistNumLimit")
local player_card_path_prefix = "CardBG/%s"
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {
  v_title_obj = {
    "TitleObj",
    BIND_TYPE.OBJECT
  },
  v_member_title = {
    "MemberTitle",
    BIND_TYPE.OBJECT
  },
  v_course_title = {
    "CourseTitle",
    BIND_TYPE.OBJECT
  },
  v_no_title = {
    "NoTitle",
    BIND_TYPE.OBJECT
  },
  v_member_btn = {
    "MemberTitle",
    BIND_TYPE.BUTTON
  },
  v_course_btn = {
    "CourseTitle",
    BIND_TYPE.BUTTON
  },
  v_no_title_btn = {
    "NoTitle",
    BIND_TYPE.BUTTON
  },
  v_bg_member = {
    "MemberTitle",
    BIND_TYPE.IMAGE
  },
  v_bg_course = {
    "CourseTitle",
    BIND_TYPE.IMAGE
  },
  v_icon_member = {
    "MemberEyes",
    BIND_TYPE.IMAGE
  },
  v_icon_course = {
    "CourseIcon2",
    BIND_TYPE.IMAGE
  },
  v_lv_member = {
    "MemberLv",
    BIND_TYPE.TEXT
  },
  v_lv_course = {
    "CourseLv",
    BIND_TYPE.TEXT
  },
  v_quality_bg_member = {
    "QualityBg2",
    BIND_TYPE.IMAGE
  },
  v_quality_bg_course = {
    "QualityBg1",
    BIND_TYPE.IMAGE
  },
  v_name_member = {
    "MemberName",
    BIND_TYPE.TEXT
  },
  v_name_course = {
    "CourseName",
    BIND_TYPE.TEXT
  },
  v_achievement = {
    "Achievement",
    BIND_TYPE.OBJECT
  },
  v_guide = {
    "Guide",
    BIND_TYPE.OBJECT
  },
  v_card_icon = {
    "CardIcon",
    BIND_TYPE.IMAGE
  },
  v_default_card_icon = {
    "CardDefaultIcon",
    BIND_TYPE.OBJECT
  },
  v_char_num_now = {
    "CharNumNow",
    BIND_TYPE.TEXT
  },
  v_char_num_max = {
    "CharNumMax",
    BIND_TYPE.TEXT
  },
  v_show_char = {
    "ShowChar",
    BIND_TYPE.OBJECT
  }
}
local PAGE_TYPE = {CALLING_CARD = 1, SHOW_CHAR = 2}
local CommonDefind = require("cs_share.common_define")
local FRIEND_STATE = CommonDefind.FRIEND_STATE

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("BtnReturn", function()
    self:ui_hide()
    self:reset_data()
    FriendMgr:set_show_player_info()
  end)
  self:set_button("BtnSend", function()
    local function apply_callback()
      Util.show_message_tip(2194)
      
      self:update_btn_state()
    end
    
    FriendMgr:apply_add_friend(self.v_player_data.uuid, apply_callback)
  end)
  self:set_button("BtnFunction", function()
    self.v_uiobjects.FunctionList:SetActive(true)
  end)
  self:set_button("CloseFuncBtn", function()
    self.v_uiobjects.FunctionList:SetActive(false)
  end)
  self:set_button("BtnSetBlack", function()
  end)
  self:set_button("BtnDelBlack", function()
  end)
  self:set_button("CopyBtn", function()
    CS.GoogleDeviceUtilities.CopyToClipboard(self.v_player_data.uuid)
    Util.show_message_tip(2193)
  end)
  self:set_button("BtnChangeRemark", function()
    self.v_uiobjects.FunctionList:SetActive(false)
    UIMgr:get_ui("ui_remark_tip"):ui_show(self.v_player_data.uuid)
  end)
  self:set_button("BtnDeleteFriend", function()
    self.v_uiobjects.FunctionList:SetActive(false)
    
    local function conform_callback()
      FriendMgr:delete_friend(self.v_player_data.uuid)
    end
    
    local desc = Util.get_i18n("确认删除该好友")
    Util.show_conform_tip(desc, nil, nil, nil, conform_callback)
  end)
  self:register_exist_auto_template(HERO_CHAR_ITEM, self.v_uiobjects.CharTem, self.v_uiobjects.CharItemList)
  self.v_char_item_list = {}
end

function ui:ui_on_show(player_data)
  FriendMgr:request_get_friend_list()
  if next(player_data) then
    self.v_player_data = player_data
    FriendMgr:set_show_player_info(player_data)
  else
    self.v_player_data = FriendMgr:get_show_player_info()
  end
  self:init_event()
  self:update_player_info()
  self:update_char_list()
  self.v_uiobjects.BtnFunction:SetActive(not self.v_player_data.is_self)
  self.v_uiobjects.PlayerBtn:SetActive(not self.v_player_data.is_self)
  local uuid = self.v_player_data.uuid
  local is_friend = FriendMgr:is_in_friend(uuid)
  self.v_uiobjects.BtnFunction:SetActive(is_friend)
end

function ui:init_event()
  self:bind_auto_mq(Const.MSG_ON_CHANGE_FRIEND_NOTE, self.update_player_note, self)
  self:bind_auto_mq(Const.MSG_ON_CHANGE_FRIEND_LIST, self.update_player_info, self)
end

function ui:set_black()
  local function cb()
    self.v_uiobjects.FunctionList:SetActive(false)
    
    self:update_player_info()
    Util.show_message_tip(2197)
  end
  
  FriendMgr:add_friend_black_list(self.v_player_data.uuid, self.v_player_data, cb)
end

function ui:update_player_info()
  if not self.v_player_data then
    return
  end
  local player_data = self.v_player_data
  local ui_compents = self.v_uicompents
  ui_compents.PlayerName_txt.text = player_data.name
  local friend_info = FriendMgr:get_friend_info_by_id(player_data.uuid)
  if friend_info and friend_info.note and friend_info.note ~= "" then
    ui_compents.PlayerName_txt.text = friend_info.name .. "(" .. friend_info.note .. ")"
  end
  local tip = "" ~= player_data.quotation and player_data.quotation or Util.get_i18n("请多多指教")
  ui_compents.PlayerMessage_txt.text = Util.format_str(tip)
  ui_compents.PlayerLv_txt.text = player_data.lv
  ui_compents.PlayerLd_txt.text = player_data.uuid
  if player_data.birthday and 0 ~= player_data.birthday[1] then
    ui_compents.BornDay_txt.text = Util.format_str("{1}月{2}日", player_data.birthday[1], player_data.birthday[2])
  else
    ui_compents.BornDay_txt.text = Util.format_str("未知")
  end
  Util.load_char_head_icon(ui_compents.PlayerProfile_img, player_data.icon)
  self:update_btn_state()
  self.v_uiobjects.FunctionList:SetActive(false)
  local ware_id = self.v_player_data.bussiness_card
  if ware_id and 0 ~= ware_id then
    self.v_default_card_icon:SetActive(false)
    local path = ShareRes.get_visiting_card_bg(ware_id)
    local icon_path = string.format(player_card_path_prefix, path)
    ResMgr:load_set_icon(self.v_card_icon, icon_path, nil, true)
  else
    self.v_default_card_icon:SetActive(true)
  end
  self:set_title()
end

function ui:update_char_list()
  self:remove_wrap_list()
  self.v_char_list = self.v_player_data.buddy_show_info.appoint_buddys
  if not self.v_char_list then
    return
  end
  local char_list = {}
  local buddy_cfg = ShareRes.create("buddy.buddy")
  for _, info in pairs(self.v_char_list) do
    info.is_aid = self:is_aid(info.id)
    info.quality = buddy_cfg[info.id].Quality
    if 1 ~= buddy_cfg[info.id].IsShow and CharacterMgr:check_buddy_release(info.id) then
      table.insert(char_list, info)
    end
  end
  if self.v_player_data.buddy_show_info.show_all_buddy then
    self:sort_char_list(char_list)
  end
  self.v_char_item_list = {}
  self:give_back_auto_cache(HERO_CHAR_ITEM)
  for _, data in pairs(self.v_char_list) do
    local item = self:get_auto_cache(HERO_CHAR_ITEM)
    local char_item_obj = CHAR_ITEM_CLASS:ui_wrap_ex(self, item, true)
    char_item_obj:set_data(data, self.v_player_data.uuid, Config.CHAR_QUALITY_TYPE.SHORT)
    table.insert(self.v_char_item_list, char_item_obj)
  end
  Util.get_scrollrect(nil, self.v_show_char).verticalNormalizedPosition = 1
  local all_char_num = 0
  for _, data in pairs(buddy_cfg) do
    if 1 ~= data.IsShow and CharacterMgr:check_buddy_release(data.Id) then
      all_char_num = all_char_num + 1
    end
  end
  self.v_char_num_now.text = self.v_player_data.buddy_show_info.all_buddy_num or 0
  self.v_char_num_max.text = all_char_num
end

function ui:is_aid(buddy_id)
  local aid_list = self.v_player_data.buddy_show_info.assist_buddys
  for _, info in ipairs(aid_list) do
    if info.id == buddy_id then
      return true
    end
  end
  return false
end

function ui:sort_char_list(char_list)
  table.sort(char_list, function(a, b)
    if a.is_aid ~= b.is_aid then
      return a.is_aid and b.is_aid or a.is_aid
    end
    if a.quality ~= b.quality then
      return a.quality > b.quality
    end
    if a.break_lv ~= b.break_lv then
      return a.break_lv > b.break_lv
    end
    if a.lv ~= b.lv then
      return a.lv > b.lv
    end
    return a.id < b.id
  end)
  self.v_char_list = char_list
end

function ui:update_btn_state()
  local uuid = self.v_player_data.uuid
  local state = FriendMgr:get_friend_state(uuid)
  local friend_info = FriendMgr:get_friend_info_by_id(uuid)
  local is_blcak_friend = FriendMgr:is_in_friend_black(uuid)
  local is_friend = FriendMgr:is_in_friend(uuid)
  self.v_uiobjects.BtnApplied:SetActive(state == FRIEND_STATE.APPLIED and not is_blcak_friend)
  self.v_uiobjects.BtnSend:SetActive(state == FRIEND_STATE.APPLY and not is_blcak_friend)
  self.v_uiobjects.BtnChat:SetActive(false)
  self.v_uiobjects.BtnDelBlack:SetActive(is_blcak_friend)
  self.v_uiobjects.BtnSetBlack:SetActive(not is_blcak_friend)
  self.v_uiobjects.BtnDeleteFriend:SetActive(is_friend)
  self.v_uiobjects.BtnChangeRemark:SetActive(is_friend)
  self.v_uiobjects.BtnFunction:SetActive(is_friend)
  self.v_uiobjects.BtnDelBlack:SetActive(false)
  self.v_uiobjects.BtnSetBlack:SetActive(false)
end

function ui:update_player_note(msg)
  if not msg then
    return
  end
  local note = msg.mm_y
  local player_data = self.v_player_data
  self.v_uicompents.PlayerName_txt.text = player_data.name
  if note and "" ~= note then
    self.v_uicompents.PlayerName_txt.text = player_data.name .. "(" .. note .. ")"
  end
end

function ui:remove_wrap_list()
  for _, obj in pairs(self.v_char_item_list) do
    obj:ui_hide()
    obj:ui_destroy()
  end
  self.v_char_item_list = {}
end

function ui:reset_data()
  self.v_player_data = nil
  self:remove_wrap_list()
end

function ui:ui_on_hide()
end

function ui:cache_ui()
  return true
end

function ui:set_title()
  local active_titles = self.v_player_data.active_titles
  local achievement_num = self.v_player_data.achievement_num
  local title = self.v_player_data.title
  local title_cfg = ShareRes.get_title(title)
  Util.get_text("Progress", self.v_achievement).text = achievement_num
  local guild_name = self.v_player_data.guild_name
  local guild_position = self.v_player_data.guild_position == UNION_TITLE.CHAIRMAN and Util.get_i18n("会长") or Util.get_i18n("成员")
  if "" == guild_name or not guild_name then
    Util.get_text("Position", self.v_guide).text = ""
    Util.get_text("Name", self.v_guide).text = Util.get_i18n("未加入公会")
  else
    Util.get_text("Position", self.v_guide).text = guild_position
    Util.get_text("Name", self.v_guide).text = guild_name
  end
  self:set_button_listener(self.v_member_btn, function()
    self:get_panel("titles"):set_enable(true, {
      title = title,
      active_titles = active_titles,
      achievement_num = achievement_num
    })
  end)
  self:set_button_listener(self.v_course_btn, function()
    self:get_panel("titles"):set_enable(true, {
      title = title,
      active_titles = active_titles,
      achievement_num = achievement_num
    })
  end)
  self:set_button_listener(self.v_no_title_btn, function()
    self:get_panel("titles"):set_enable(true, {
      title = title,
      active_titles = active_titles,
      achievement_num = achievement_num
    })
  end)
  if 0 == title then
    self.v_no_title:SetActive(true)
    self.v_member_title:SetActive(false)
    self.v_course_title:SetActive(false)
    return
  else
    self.v_no_title:SetActive(false)
    self.v_member_title:SetActive(1 == title_cfg.Type)
    self.v_course_title:SetActive(2 == title_cfg.Type)
    local suffix
    local title_quality_path_cfg = ShareRes.get_title_quality_path(title_cfg.Quality)
    if 1 == title_cfg.Type then
      suffix = "_member"
    elseif 2 == title_cfg.Type then
      suffix = "_course"
    end
    ResMgr:load_set_icon(self["v_icon" .. suffix], title_cfg.BaseMapPreview)
    ResMgr:load_set_icon(self["v_bg" .. suffix], title_cfg.BaseMap)
    ResMgr:load_set_icon(self["v_quality_bg" .. suffix], title_quality_path_cfg.Qualitybox)
    self["v_lv" .. suffix].gameObject:SetActive(1 == title_cfg.ShowLevel)
    self["v_lv" .. suffix].text = title_cfg.Level
    self["v_name" .. suffix].text = Util.get_i18n(title_cfg.Name)
  end
end

return ui
