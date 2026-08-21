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
local Char_Helper = require("uimodule.character.char_helper")
local Player_Hero_Helper = require("uimodule.friend.player_hero_info.player_hero_helper")
local SPINE_RT_VIEW = require("ui.model_rt_view.spine_rt_view")
local SpineHelper = require("ui.model_rt_view.spine_helper")
local _tinsert = table.insert
local DEFAULT_POS = {
  x = 387,
  y = -14,
  scale = 1
}
local PAGE_TYPE = {CALLING_CARD = 1, SHOW_CHAR = 2}
local TOG_TYPE = {
  ASSIST = 1,
  RECORD = 2,
  COLLECTION = 3
}
local CommonDefind = require("cs_share.common_define")
local FRIEND_STATE = CommonDefind.FRIEND_STATE

function ui:ui_finish_load()
  self.v_uicompents.PageAssist_tog.isOn = true
  self:on_click_tog(TOG_TYPE.ASSIST)
  self.v_uiobjects.BtnLogout:SetActive(false)
  self.v_uiobjects.PlayerFunctionList:SetActive(false)
  self.v_uiobjects.InfoFunctionList:SetActive(false)
  self.quotation_input_field = self:get_inputfield(nil, self.v_uiobjects.QuotationField)
  self.v_uiobjects.BtnLayout:SetActive(false)
  self.v_uiobjects.Slider:SetActive(false)
  self.v_uiobjects.BtnClose:SetActive(false)
  self.v_uiobjects.BtnSavePos:SetActive(false)
  self.v_uiobjects.BtnPosReset:SetActive(false)
  self.v_uiobjects.EditTitle:SetActive(false)
  self:set_button("BtnReturn", function()
    self:ui_hide()
    self:reset_data()
    FriendMgr:set_show_player_info()
  end)
  self:set_button("BtnCloseTag", function()
    self.v_uiobjects.BtnCloseTag:SetActive(false)
    self.v_uiobjects.InfoFunctionList:SetActive(false)
  end)
  self:set_button("BtnAddFriend", function()
    local function apply_callback()
      Util.show_message_tip(2194)
      
      self:update_btn_state()
    end
    
    FriendMgr:apply_add_friend(self.v_player_data.uuid, apply_callback)
  end)
  self:set_button("BtnFunction", function()
    self.v_uiobjects.InfoFunctionList:SetActive(true)
    self.v_uiobjects.BtnCloseTag:SetActive(true)
  end)
  self:set_button("Copy", function()
    CS.GoogleDeviceUtilities.CopyToClipboard(self.v_player_data.uuid)
    Util.show_message_tip(2193)
  end)
  self:set_button("BtnChangeRemark", function()
    self.v_uiobjects.InfoFunctionList:SetActive(false)
    UIMgr:get_ui("ui_remark_tip"):ui_show(self.v_player_data.uuid)
  end)
  self:set_button("BtnDeleteFriend", function()
    self.v_uiobjects.InfoFunctionList:SetActive(false)
    
    local function conform_callback()
      FriendMgr:delete_friend(self.v_player_data.uuid)
    end
    
    local desc = Util.get_i18n("确认删除该好友")
    Util.show_conform_tip(desc, nil, nil, nil, conform_callback)
  end)
  self:set_button("BtnSpine", function()
    if self.v_anim_data.record_data.play_start then
      if self.v_anim_data.record_data.play_interrupt then
        SpineHelper.init_anim_info(self.v_spine_id, self.v_anim_data, SpineHelper.ANIM_TYPE.CLICK)
      end
    else
      SpineHelper.init_anim_info(self.v_spine_id, self.v_anim_data, SpineHelper.ANIM_TYPE.CLICK)
    end
  end)
  self:set_toggle("PageAssist", function(is_on)
    self:on_click_tog(TOG_TYPE.ASSIST, is_on)
  end, false)
  self:set_toggle("PageRecord", function(is_on)
    self:on_click_tog(TOG_TYPE.RECORD, is_on)
  end, false)
  self:set_toggle("PageCollection", function(is_on)
    self:on_click_tog(TOG_TYPE.COLLECTION, is_on)
  end, false)
  self.v_icon_root_rect = self.v_uicompents.ShowHeroIcon_rect
end

function ui:ui_on_show(player_data)
  self.v_uicompents.PageAssist_tog.isOn = true
  self:on_click_tog(TOG_TYPE.ASSIST)
  FriendMgr:request_get_friend_list()
  if next(player_data) then
    self.v_player_data = player_data
    self.v_uuid = player_data.uuid
    FriendMgr:set_show_player_info(player_data)
  else
    self.v_player_data = FriendMgr:get_show_player_info()
    self.v_uuid = self.v_player_data.uuid
  end
  self:init_event()
  self:update_player_info()
  self:refresh_aid(self.v_player_data.buddy_show_info)
  self.v_uiobjects.BtnFunction:SetActive(true)
  self:refresh_record_view(self.v_player_data)
  self:refresh_spine_view(self.v_player_data.buddy_spine_info)
  self:refresh_collection_view(self.v_player_data)
  local uuid = self.v_player_data.uuid
  local is_friend = FriendMgr:is_in_friend(uuid)
  self.v_uiobjects.BtnFunction:SetActive(is_friend)
end

function ui:ui_on_update()
  if not self.v_spine_id then
    return
  end
  if Global.real_time - self.v_low_update < SpineHelper.UPDATE_TIME then
    return
  end
  self.v_low_update = Global.real_time
  if self.v_anim_data.record_data.play_end then
    self.v_start_time = self.v_start_time or Global.real_time
    if self.v_anim_interval and Global.real_time - self.v_start_time > self.v_anim_interval then
      SpineHelper.init_anim_info(self.v_spine_id, self.v_anim_data, SpineHelper.ANIM_TYPE.INTERVAL)
    elseif self.v_single_anim_delay and Global.real_time - self.v_start_time > self.v_single_anim_delay then
      SpineHelper.init_anim_info(self.v_spine_id, self.v_anim_data, SpineHelper.ANIM_TYPE.SINGLE)
      self.v_single_anim_delay = nil
    end
  else
    self.v_start_time = Global.real_time
  end
  SpineHelper.check_play_anim(self.v_spine_rt, self.v_anim_data)
end

function ui:init_event()
  self:bind_auto_mq(Const.MSG_ON_CHANGE_FRIEND_NOTE, self.update_player_note, self)
  self:bind_auto_mq(Const.MSG_ON_CHANGE_FRIEND_LIST, self.update_player_info, self)
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
  self.quotation_input_field.text = Util.format_str(tip)
  self.quotation_input_field.interactable = false
  self.v_uiobjects.LVObj:SetActive(false)
  ui_compents.PlayerLevel_txt.text = player_data.lv
  ui_compents.PlayerId_txt.text = player_data.uuid
  if player_data.birthday and 0 ~= player_data.birthday[1] then
    ui_compents.BornDay_txt.text = Util.format_str("{1}月{2}日", player_data.birthday[1], player_data.birthday[2])
  else
    ui_compents.BornDay_txt.text = Util.format_str("未知")
  end
  Util.load_char_head_icon(ui_compents.Profile_img, player_data.icon)
  self:update_btn_state()
  self.v_uiobjects.InfoFunctionList:SetActive(false)
  local card_id = self.v_player_data.bussiness_card
  if card_id and 0 ~= card_id then
    self.v_uiobjects.CardIcon:SetActive(true)
    self.v_uiobjects.NoCardIcon:SetActive(false)
    local cfg = ShareRes.get_visiting_card_cfg(card_id)
    local icon_path = string.format(player_card_path_prefix, cfg.Icon)
    ResMgr:load_set_icon(self.v_uicompents.CardIcon_img, icon_path, nil, true)
  else
    self.v_uiobjects.CardIcon:SetActive(false)
    self.v_uiobjects.NoCardIcon:SetActive(true)
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
  local is_blcak_friend = FriendMgr:is_in_friend_black(uuid)
  local is_friend = FriendMgr:is_in_friend(uuid)
  self.v_uiobjects.BtnAddFriend:SetActive(state == FRIEND_STATE.APPLY and not is_blcak_friend)
  self.v_uiobjects.BtnDeleteFriend:SetActive(is_friend)
  self.v_uiobjects.BtnChangeRemark:SetActive(is_friend)
  self.v_uiobjects.BtnFunction:SetActive(is_friend)
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
end

function ui:ui_on_hide()
  self:clear_spine_rt()
end

function ui:ui_on_destroy()
  self:clear_spine_rt()
end

function ui:cache_ui()
  return true
end

function ui:set_title()
  local title = self.v_player_data.title
  self.v_member_title = Util.get_child_gameobj("MemberTitle_", self.v_uiobjects.TitleObj)
  self.v_course_title = Util.get_child_gameobj("CourseTitle_", self.v_uiobjects.TitleObj)
  self.v_no_title = Util.get_child_gameobj("NoTitle_", self.v_uiobjects.TitleObj)
  self.v_quality_bg_member = Util.get_image("MemberTitle_/QualityBg2_", self.v_uiobjects.TitleObj)
  self.v_quality_bg_course = Util.get_image("CourseTitle_/QualityBg1_", self.v_uiobjects.TitleObj)
  self.v_lv_course = Util.get_text("CourseTitle_/QualityBg1_/CourseLv_", self.v_uiobjects.TitleObj)
  self.v_lv_member = Util.get_text("MemberTitle_/QualityBg2_/MemberLv_", self.v_uiobjects.TitleObj)
  self.v_name_member = Util.get_text("MemberTitle_/MemberName_", self.v_uiobjects.TitleObj)
  self.v_name_course = Util.get_text("CourseTitle_/CourseName_", self.v_uiobjects.TitleObj)
  self.v_icon_member = Util.get_image("MemberTitle_/Member/MemberEyes_", self.v_uiobjects.TitleObj)
  self.v_icon_course = Util.get_image("CourseTitle_/Mask/CourseIcon2_", self.v_uiobjects.TitleObj)
  self.v_bg_member = Util.get_image("MemberTitle_", self.v_uiobjects.TitleObj)
  self.v_bg_course = Util.get_image("CourseTitle_", self.v_uiobjects.TitleObj)
  self.v_member_title:SetActive(false)
  self.v_course_title:SetActive(false)
  self.v_no_title:SetActive(false)
  local title_cfg = ShareRes.get_title(title)
  if 0 == title or 3 == title_cfg.Type then
    local text = Util.get_text("Text", self.v_no_title)
    self.v_no_title:SetActive(true)
    text.text = "暂无称号"
  else
    local suffix
    local title_quality_path_cfg = ShareRes.get_title_quality_path(title_cfg.Quality)
    if 1 == title_cfg.Type then
      self.v_member_title:SetActive(true)
      suffix = "_member"
    elseif 2 == title_cfg.Type then
      self.v_course_title:SetActive(true)
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

function ui:on_click_tog(tog_type, isOn)
  if tog_type == TOG_TYPE.ASSIST and isOn then
    self.v_uiobjects.AssistInfo:SetActive(true)
    self.v_uiobjects.Record:SetActive(false)
    self.v_uiobjects.Collection:SetActive(false)
  elseif tog_type == TOG_TYPE.RECORD and isOn then
    self.v_uiobjects.AssistInfo:SetActive(false)
    self.v_uiobjects.Record:SetActive(true)
    self.v_uiobjects.Collection:SetActive(false)
  elseif tog_type == TOG_TYPE.COLLECTION and isOn then
    self.v_uiobjects.AssistInfo:SetActive(false)
    self.v_uiobjects.Record:SetActive(false)
    self.v_uiobjects.Collection:SetActive(true)
  end
end

function ui:refresh_spine_view(info)
  local buddy_id, fashion_id, scale, py, px, is_break
  if nil ~= info then
    buddy_id = info.buddy_id
    fashion_id = info.fashion_id
    scale = info.scale
    py = info.py
    px = info.px
    is_break = info.is_break
  end
  if not buddy_id then
    buddy_id = 1001001
    fashion_id = 3001001
  end
  if buddy_id and not fashion_id then
    fashion_id = FashionMgr:get_fashion_wearing_id(buddy_id)
  end
  self.v_buddy_id = buddy_id
  self.v_fashion_id = fashion_id
  if fashion_id then
    local fashion_cfg = ShareRes.get_fashion_cfg(fashion_id)
    self.v_is_base_fashion = 1 == fashion_cfg.IsBase
  else
    self.v_is_base_fashion = true
  end
  self:init_data(is_break)
  local data = self.v_is_showing_big_spine and self.v_big_spine_data or self.v_simple_spine_data
  self.v_uiobjects.HeroIcon:SetActiveEx(false)
  self.v_uiobjects.HeroRawImg:SetActiveEx(false)
  self.v_uiobjects.HeroRawImg:SetActiveEx(true == data.is_spine)
  self.v_uiobjects.BtnSpine:SetActive(true == data.is_spine and not self.v_is_break)
  if not data.is_spine then
    local function cb(img)
      img.gameObject:SetActive(true)
    end
    
    ResMgr:load_set_icon(self.v_uicompents.HeroIcon_img, data.val, cb, true)
  end
  px = px or DEFAULT_POS.x
  py = py or DEFAULT_POS.y
  scale = scale or DEFAULT_POS.scale
  self.v_icon_root_rect:SetLocalPositionA(px, py)
  self.v_icon_root_rect:SetLocalScaleA(scale, scale, scale)
  self:init_spine_data()
  if data.is_spine then
    self:clear_spine_rt()
    self.v_spine_id = data.val
    self.v_anim_interval = SpineHelper.get_anim_interval(self.v_spine_id)
    self.v_single_anim_delay = SpineHelper.get_single_anim_delay(self.v_spine_id)
    self.v_spine_rt = self.v_spine_rt or SPINE_RT_VIEW:new(self, self.v_uiobjects.HeroRawImg)
    SpineHelper.load_char_spine_res(self.v_spine_rt, self.v_spine_id, self.v_uiobjects.HeroRawImg)
  end
end

local default_offset = {
  0,
  0,
  1
}

function ui:init_data(is_break)
  self.v_big_spine_data = nil
  self.v_simple_spine_data = nil
  self.v_is_showing_big_spine = false
  local spine_id, is_spine, offset = UtilUI.get_hero_display_big_spine(self.v_buddy_id, self.v_fashion_id)
  if spine_id then
    self.v_big_spine_data = {
      val = spine_id,
      is_spine = is_spine,
      offset = offset or default_offset,
      show_floor = false
    }
    if self.v_is_base_fashion then
      if is_break then
        self.v_is_showing_big_spine = true
      end
    else
      self.v_is_showing_big_spine = true
    end
  end
  if not self.v_is_break then
    spine_id, is_spine, offset = UtilUI.get_hero_display_simple_spine(self.v_buddy_id, self.v_fashion_id)
    if spine_id then
      self.v_simple_spine_data = {
        val = spine_id,
        is_spine = is_spine,
        offset = offset or default_offset,
        show_floor = true
      }
    end
  end
end

function ui:init_spine_data()
  self.v_spine_id = nil
  self.v_low_update = Global.real_time
  self.v_start_time = Global.real_time
  self.v_anim_data = SpineHelper.get_init_anim_info()
end

function ui:clear_spine_rt()
  if self.v_spine_rt then
    self.v_spine_rt:on_destroy()
    self.v_spine_rt = nil
  end
end

function ui:refresh_collection_view(player_data)
  if not player_data then
    return
  end
  self.v_uicompents.CollectAchieveNum_txt.text = player_data.achievement_num or 0
  self.v_uicompents.CollectWeaponNum_txt.text = player_data.equip_num or 0
  self.v_uicompents.CollectCharNum_txt.text = player_data.buddy_show_info.all_buddy_num or 0
end

function ui:refresh_aid(data)
  self.v_uiobjects.AssistDetail:SetActive(false)
  local assist_time = Util.get_child_gameobj("AssistTime", self.v_uiobjects.AssistInfo)
  assist_time:SetActive(false)
  for pos, buddy_info in ipairs(data.assist_buddys) do
    local aid_item = self.v_uiobjects["Assist" .. pos]
    local no_char_item = Util.get_child_gameobj("NoCharObj_", aid_item)
    local char_item = Util.get_child_gameobj("CharObj_", aid_item)
    local Bg1 = Util.get_child_gameobj("Bg1_", no_char_item)
    local Bg2 = Util.get_child_gameobj("Bg2_", no_char_item)
    Bg1:SetActive(false)
    Bg2:SetActive(true)
    local buddy_id = buddy_info.id
    no_char_item:SetActive(0 == buddy_id)
    char_item:SetActive(0 ~= buddy_id)
    if 0 ~= buddy_id then
      self:set_player_aid_char_info(char_item, buddy_info)
    end
  end
end

function ui:set_player_aid_char_info(item, data)
  local quality_bg = Util.get_image("QualityBg_", item)
  local char_icon = Util.get_image("Hero/HeroIcon_", item)
  local element_icon = Util.get_image("EleIcon_", item)
  local char_name = Util.get_text("CharName_", item)
  local char_lv = Util.get_text("LvLayout/LvNum_", item)
  local job = Util.get_image("Job_", item)
  local fashion_id = data.fashion
  local path = UtilUI.get_hero_images(data.id, Config.HERO_ICON_LV.HALF_IMG, fashion_id)
  ResMgr:load_set_icon(char_icon, path, nil, true, self)
  local ele_path = Char_Helper.get_char_element_icon(data.id)
  ResMgr:load_set_icon(element_icon, ele_path)
  local quality = ShareRes.get_buddy_cfg(data.id).Quality
  for index = 1, 5 do
    local star_obj = Util.get_child_gameobj("QualityStarLayout_/QualityStar" .. index, item)
    if star_obj then
      star_obj:SetActive(index <= quality)
    end
  end
  local bg_path = Char_Helper.get_char_icon_quality(data.id, Config.CHAR_QUALITY_TYPE.LONG)
  ResMgr:load_set_icon(quality_bg, bg_path)
  char_lv.text = string.format("%.2d", data.lv)
  char_name.text = ShareRes.get_buddy_cfg(data.id).Name
  local job_path = Char_Helper.get_char_job_icon(data.id, false)
  ResMgr:load_set_icon(job, job_path)
  local btnDetail = Util.get_button("BtnDetail_", item)
  self:set_button_listener(btnDetail, function()
    if self.v_uuid == PlayerMgr:get_player_uid() then
      local equip_info = CharacterMgr:get_equip_info(data.weapon)
      self.v_buddy_info.weapon_info = equip_info
      Player_Hero_Helper.set_hero_data(data, true)
      UIMgr:get_ui("player_hero"):ui_show()
      return
    end
    
    local function cb(cbdata)
      Player_Hero_Helper.set_hero_data(cbdata)
      UIMgr:get_ui("player_hero"):ui_show()
    end
    
    FriendMgr:c2gs_get_role_buddy_info(self.v_uuid, data.id, cb)
  end)
end

function ui:refresh_record_view(data)
  if not data then
    self.v_uicompents.WeekactStarNum1_txt.text = "未解锁"
    self.v_uicompents.WeekactStarNum2_txt.text = "未解锁"
    self.v_uiobjects.EndlessRankOn:SetActive(false)
    self.v_uiobjects.EndlessRankOff:SetActive(true)
    self.v_uiobjects.BossChalOn:SetActive(false)
    self.v_uiobjects.BossChalOff:SetActive(true)
    return
  end
  self.v_uiobjects.BtnBossChalDetail:SetActive(false)
  self.v_uiobjects.BtnEndlessDetail:SetActive(false)
  if not UtilTable.is_empty(data.week_pvp_data) then
    local curr_star, total_star, num_text
    for idx, v in pairs(data.week_pvp_data) do
      local id = v.area_id
      curr_star = v.all_star
      total_star = 18
      num_text = "WeekactStarNum" .. id .. "_txt"
      self.v_uicompents[num_text].text = string.format("%d/%d", curr_star, total_star)
    end
  else
    self.v_uicompents.WeekactStarNum1_txt.text = "未解锁"
    self.v_uicompents.WeekactStarNum2_txt.text = "未解锁"
  end
  local infinite_id
  if not UtilTable.is_empty(data.buddy_spine_info) then
    infinite_id = data.buddy_spine_info.infiniter_id
  else
    self.v_uiobjects.EndlessRankOn:SetActive(false)
    self.v_uiobjects.EndlessRankOff:SetActive(true)
  end
  if not UtilTable.is_empty(data.infinte_data) and nil ~= infinite_id then
    local infinite_data
    if #data.infinte_data > 0 then
      for i, v in pairs(data.infinte_data) do
        if v.id == infinite_id then
          infinite_data = v
          break
        end
      end
    end
    local infinite_cfg = ShareRes.get_inf_chapter_cfg(infinite_id)
    local StageName = infinite_cfg.Name
    self.v_uiobjects.EndlessRankOn:SetActive(infinite_id and infinite_data)
    self.v_uiobjects.EndlessRankOff:SetActive(not infinite_id or not infinite_data)
    if nil ~= infinite_data then
      local score = infinite_data.score
      if nil ~= infinite_id and nil ~= infinite_data and 0 ~= infinite_data.score then
        self.v_uicompents.EndlessTopScore_txt.text = infinite_data.score
        self.v_uicompents.EndlessStage_txt.text = StageName
      else
        self.v_uiobjects.EndlessRankOn:SetActive(0 ~= score)
        self.v_uiobjects.EndlessRankOff:SetActive(0 == score or nil == score)
      end
    end
  else
    self.v_uiobjects.EndlessRankOn:SetActive(false)
    self.v_uiobjects.EndlessRankOff:SetActive(true)
  end
  local boss_id, boss_fight_data
  if not UtilTable.is_empty(data.buddy_spine_info) then
    boss_id = data.buddy_spine_info.boss_fight_id
  end
  if not UtilTable.is_empty(data.boss_fight_data) and boss_id then
    local rank_name = Config.CommonDefine.RANK_NAME.BOSS_FIGHT
    local boss_cfg_list = ShareRes.create("chapter.boss_fight")
    local boss_ep_cfg_list = ShareRes.create("chapter.boss_fight_episode")
    local boss_data_list = {}
    for i, v in pairs(boss_cfg_list) do
      boss_data_list[i] = {}
      boss_data_list[i].Name = v.Name
    end
    local episode_id_list = {}
    local rank_cfg_list = {}
    for i, data in ipairs(boss_ep_cfg_list) do
      for idx, detail in ipairs(data) do
        if detail.IsOpenRank and 4 == detail.Difficulty then
          local info = RankMgr:get_new_rank_title(detail.EpisodeId, detail.DifficultyDesc, detail.ShowRankPlayer, detail.RankPlayer, detail.RankRefreshType, boss_data_list[i].Name)
          _tinsert(episode_id_list, detail.EpisodeId)
          _tinsert(rank_cfg_list, info)
          boss_data_list[i].Id = detail.Id
        end
      end
    end
    local name
    for _, value in ipairs(boss_data_list) do
      if value.Id == boss_id then
        name = value.Name
        goto lbl_294
      end
    end
    ::lbl_294::
    boss_fight_data = data.boss_fight_data
    for i, data in ipairs(boss_fight_data) do
      if data.id == boss_id then
        if data.time > 0 then
          do
            local score = Date.get_time_desc(data.time, false)
            self.v_uicompents.BossChalTopTime_txt.text = score
            self.v_uicompents.BossName_txt.text = name
            self.v_uiobjects.BossChalOn:SetActive(true)
            self.v_uiobjects.BossChalOff:SetActive(false)
          end
          goto lbl_353
        end
        self.v_uiobjects.BossChalOn:SetActive(false)
        self.v_uiobjects.BossChalOff:SetActive(true)
        goto lbl_353
      else
        self.v_uiobjects.BossChalOn:SetActive(false)
        self.v_uiobjects.BossChalOff:SetActive(true)
      end
    end
    ::lbl_353::
  else
    self.v_uiobjects.BossChalOn:SetActive(false)
    self.v_uiobjects.BossChalOff:SetActive(true)
  end
end

return ui
