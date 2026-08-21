local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local TouchPhase = UnityEngine.TouchPhase
local Math = require("base.mathx")
local Input = UnityEngine.Input
local _clamp = Math.Clamp
local _tinsert = table.insert
local player_icon_path_prefix = "Icon/Profile/%s"
local player_card_path_prefix = "CardBG/%s"
local CharcterConfig = require("uimodule.character.character_config")
local PLAY_SET_TITLE = require("uimodule.player.player_set_title")
local LAST_SELECT_BUDDY_IDX_TYPE = CharcterConfig.LAST_SELECT_BUDDY_IDX_TYPE
local Char_Helper = require("uimodule.character.char_helper")
local CharacterConfig = require("uimodule.character.character_config")
local PanelType = CharacterConfig.PANEL_TYPE
local SPINE_RT_VIEW = require("ui.model_rt_view.spine_rt_view")
local SpineHelper = require("ui.model_rt_view.spine_helper")
local TASK_CONFIG = require("gamelogic.task.task_config")
local TASK_STATE = TASK_CONFIG.TASK_STATE
local TOG_TYPE = {
  ASSIST = 1,
  RECORD = 2,
  COLLECTION = 3
}
local DEFAULT_POS = {
  x = 387,
  y = -14,
  scale = 1
}

function ui:ui_finish_load()
  self.v_uiobjects.EditTitle:SetActive(false)
  self.v_uiobjects.PlayerFunctionList:SetActive(false)
  self.v_uiobjects.InfoFunctionList:SetActive(false)
  self.v_slider_control_area = self.v_uicompents.Slider_rect
  self.v_slider_control_area:SetActive(true)
  self.v_is_slider_interacting = false
  local slider = self.v_uicompents.Slider_sld
  self:set_slider_listener(slider, function()
    if not slider.gameObject.activeSelf then
      return
    end
    self:_set_scale_from_scrollbar(slider.value)
  end)
  Util.set_point_down(nil, self.v_uiobjects.Slider, self, function()
    self.v_is_slider_interacting = true
  end)
  Util.set_point_up(nil, self.v_uiobjects.Slider, self, function()
    self.v_is_slider_interacting = false
  end)
  self.v_player_data_list = PlayerMgr:on_get_player_info_list()
  self.v_spine_id = nil
  self.v_buddy_spine_info = PlayerMgr:get_buddy_spine_info()
  self.v_uicompents.PageAssist_tog.isOn = true
  self:on_click_tog(TOG_TYPE.ASSIST)
  self.v_is_birth = false
  self.v_is_moving_spine = false
  self:set_button("BtnPos", function()
    self:set_part_ui_visible(false)
    self:set_button_interactable(false)
    self.v_is_moving_spine = true
  end)
  self:set_button("BtnClose", function()
    local has_changed = self:spine_position_changed()
    if has_changed then
      local function cancel_cb()
        self.v_buddy_spine_info = PlayerMgr:get_buddy_spine_info()
        
        local buddy_id = self.v_buddy_spine_info.buddy_id
        local fashion_id = self.v_buddy_spine_info.fashion_id
        local px = self.v_buddy_spine_info.px
        local py = self.v_buddy_spine_info.py
        local scale = self.v_buddy_spine_info.scale
        self:refresh_spine_view(buddy_id, fashion_id, px, py, scale)
      end
      
      local function confirm_cb()
        self:save_position_data()
      end
      
      Util.show_notify_popup_message(confirm_cb, "直接退出将丢失未保存改动，\n是否确认退出？", nil, "保存后退出", "直接退出", cancel_cb, nil, nil, true)
    end
    self:set_part_ui_visible(true)
    self:set_button_interactable(true)
    self.v_is_moving_spine = false
  end)
  self:set_button("BtnPosReset", function()
    self:reset_position_data()
    self:_set_scale_from_scrollbar(slider.value)
  end)
  self:set_button("BtnSavePos", function()
    self:set_part_ui_visible(true)
    self:set_button_interactable(true)
    self:save_position_data()
    self.v_is_moving_spine = false
  end)
  self.v_uiobjects.PlayerFunctionList:SetActive(false)
  self:set_button("BtnReturn", function()
    self:ui_hide()
  end)
  self:set_button("BtnCloseTag", function()
    self:btn_ui_visible(true)
    self.v_uiobjects.PlayerFunctionList:SetActive(false)
  end)
  self:set_button("BtnFunction", function()
    self.v_uiobjects.PlayerFunctionList:SetActive(true)
    self.v_uiobjects.BtnCloseTag:SetActive(true)
  end)
  self:set_button("BtnChange", function()
    UIMgr:get_ui("uiplayer_new_spine_change"):ui_show()
  end)
  self:set_button("BtnHide", function()
    self:btn_ui_visible(false)
  end)
  self:set_button("BtnChangeProfile", function()
    local select_page = 1
    UIMgr:get_ui("player_avatar_choose"):ui_show(select_page, self.v_player_name)
    self.v_uiobjects.PlayerFunctionList:SetActive(false)
    self.v_uiobjects.BtnCloseTag:SetActive(false)
  end)
  self:set_button("BtnLogout", function()
    PlayerMgr:logout()
  end)
  self:set_button("BtnChangeName", function()
    UIMgr:get_ui("player_change_name"):ui_show(PlayerMgr:on_get_rename_card())
    self.v_uiobjects.PlayerFunctionList:SetActive(false)
    self.v_uiobjects.BtnCloseTag:SetActive(false)
  end)
  self:set_button("BtnSetBirth", function()
    if not self.v_is_birth then
      UIMgr:get_ui("player_change_born"):ui_show()
      self.v_uiobjects.PlayerFunctionList:SetActive(false)
      self.v_uiobjects.BtnCloseTag:SetActive(false)
    else
      Util.show_message_tip("生日已设置")
    end
  end)
  self:set_button("Copy", function()
    CS.GoogleDeviceUtilities.CopyToClipboard(self.v_player_data_list.info_list.Id)
    Util.show_message_tip(2193)
  end)
  self:set_button("AssistDetail", function()
    UIMgr:get_ui("assist_info"):ui_show()
  end)
  self.quotation_input_field = self:get_inputfield(nil, self.v_uiobjects.QuotationField)
  self.pre_text_content = self.quotation_input_field.text
  self:set_inputfield_listener(self.quotation_input_field, function()
    self:_quotation_listener()
  end, function()
    if self.pre_text_content == self.quotation_input_field.text then
      return
    else
      self.pre_text_content = self.quotation_input_field.text
    end
    self:_quotation_end_edit_listener()
  end)
  self:set_toggle("PageAssist", function(is_on)
    self:on_click_tog(TOG_TYPE.ASSIST, is_on)
  end, false)
  self:set_toggle("PageRecord", function(is_on)
    self:on_click_tog(TOG_TYPE.RECORD, is_on)
    self.v_buddy_spine_info = PlayerMgr:get_buddy_spine_info()
    self:refresh_bosschal_view(self.v_buddy_spine_info.boss_fight_id)
    self:refresh_stars()
  end, false)
  self:set_toggle("PageCollection", function(is_on)
    self:on_click_tog(TOG_TYPE.COLLECTION, is_on)
  end, false)
  self:set_button("BtnEndlessDetail", function()
    local infinite_id = PlayerMgr:get_buddy_spine_info().infiniter_id
    UIMgr:get_ui("uiplayer_new_endlesstips"):ui_show(infinite_id)
  end)
  self:set_button("BtnBossChalDetail", function()
    local boss_id = PlayerMgr:get_buddy_spine_info().boss_fight_id
    UIMgr:get_ui("uiplayer_new_bosschaltips"):ui_show(self.v_boss_data_list, boss_id)
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
  self.v_collection_info = {}
  self.v_icon_root_rect = self.v_uicompents.ShowHeroIcon_rect
end

function ui:ui_on_show()
  self.v_player_data_list = PlayerMgr:on_get_player_info_list()
  self.v_spine_id = nil
  self.v_buddy_spine_info = PlayerMgr:get_buddy_spine_info()
  self.v_uicompents.PageAssist_tog.isOn = true
  self:on_click_tog(TOG_TYPE.ASSIST)
  local buddy_id = self.v_buddy_spine_info.buddy_id
  local fashion_id = self.v_buddy_spine_info.fashion_id
  local px = self.v_buddy_spine_info.px
  local py = self.v_buddy_spine_info.py
  local scale = self.v_buddy_spine_info.scale
  local infinite_id = self.v_buddy_spine_info.infiniter_id
  local boss_id = self.v_buddy_spine_info.boss_fight_id
  self:refresh_view()
  self:set_part_ui_visible(true)
  self:refresh_record_view(infinite_id, boss_id)
  self:refresh_spine_view(buddy_id, fashion_id, px, py, scale)
  self:register_event()
  self:refresh_aid()
  if PlayerMgr:whether_get_all_titles() then
    self:set_title()
  else
    PlayerMgr:get_all_titles_form_server()
  end
  self:get_panel("titles"):set_enable(false)
  self:wear_visiting_card()
  self:refresh_bosschal_view(boss_id)
end

function ui:ui_on_update()
  if not self.v_is_break and self.v_is_moving_spine then
    self:_check_touch()
  end
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

function ui:ui_on_hide()
  self:remove_feedback_timer()
  self:clear_spine_rt()
end

function ui:ui_on_destroy()
  self:clear_spine_rt()
  self.v_player_data_list = nil
end

function ui:refresh_bosschal_view(boss_id)
  self.v_uiobjects.BossChalOn:SetActive(boss_id)
  self.v_uiobjects.BossChalOff:SetActive(not boss_id)
  self.v_select_boss_difficulty = 4
  local boss_cfg_list = ShareRes.create("chapter.boss_fight")
  local boss_ep_cfg_list = ShareRes.create("chapter.boss_fight_episode")
  assert(boss_cfg_list, "读取boss副本表失败")
  assert(boss_ep_cfg_list, "读取boss关卡表失败")
  if not self.v_boss_data_list then
    local boss_data_list = {}
    for i, v in pairs(boss_cfg_list) do
      if Condition:check_condition(v.UnlockCondition) then
        boss_data_list[i] = {}
        boss_data_list[i].Name = v.Name
        boss_data_list[i].is_unlock = true
        boss_data_list[i].boss_fight_id = v.Id
        boss_data_list[i].all_episode_list = boss_ep_cfg_list[i]
      end
    end
    local select_difficulty = self.v_select_boss_difficulty
    for idx, vtime in ipairs(boss_data_list) do
      for _, value in ipairs(boss_data_list[idx].all_episode_list) do
        if value.Difficulty == select_difficulty then
          local chapId = value.Id
          boss_data_list[idx].chapId = value.Id
          local pass_time = BossChallengeMgr:get_challenge_episode_pass_time(boss_data_list[idx].boss_fight_id, chapId)
          if pass_time and pass_time > 0 then
            boss_data_list[idx].Score = Util.format_str(Date.get_time_desc(pass_time))
          end
        end
      end
    end
    self.v_boss_data_list = boss_data_list
  else
    for idx, v in ipairs(self.v_boss_data_list) do
      if v.chapId == boss_id then
        local score = v.Score
        local name = v.Name
        if not score then
          self.v_uiobjects.BossChalOff:SetActive(true)
          self.v_uiobjects.BossChalOn:SetActive(false)
          goto lbl_146
        end
        self.v_uiobjects.BossChalOff:SetActive(false)
        self.v_uiobjects.BossChalOn:SetActive(true)
        self.v_uicompents.BossName_txt.text = name
        self.v_uicompents.BossChalTopTime_txt.text = score
        goto lbl_146
      end
    end
    ::lbl_146::
  end
end

function ui:refresh_view()
  local avatar_cfg = ShareRes.create("player.player_avatar")
  local ucom = self.v_uicompents
  local uobj = self.v_uiobjects
  local player_base_info = self.v_player_data_list.base_info
  local player_info_list = self.v_player_data_list.info_list
  local avatar_id = player_info_list.avatar_id
  local icon_name = nil == avatar_cfg[avatar_id] and avatar_cfg[700051].Icon or avatar_cfg[avatar_id].Icon
  local level = PlayerMgr:get_role_lv()
  local avatar_icon_path = string.format(player_icon_path_prefix, icon_name)
  local name = player_base_info.name
  local birth_month = player_info_list.birth_month
  local birth_day = player_info_list.birth_day
  local player_id = player_info_list.Id
  local quotation = player_info_list.quotation
  local now_exp = player_base_info.exp
  self.v_player_name = name
  ucom.PlayerName_txt.text = name
  if 0 == birth_month then
    ucom.BornDay_txt.text = Util.format_str("未录入")
    self.v_is_birth = false
  else
    ucom.BornDay_txt.text = Util.format_str("{1}月{2}日", birth_month, birth_day)
    self.v_is_birth = true
  end
  ucom.PlayerId_txt.text = player_id
  self.quotation_input_field.text = quotation
  ucom.PlayerLevel_txt.text = level
  ResMgr:load_set_icon(ucom.Profile_img, avatar_icon_path)
  uobj.LVObj:SetActive(true)
  if PlayerMgr:player_lv_is_max() then
    uobj.ExpMax:SetActive(true)
    uobj.ExpNeed:SetActive(false)
    ucom.ExpImage_img.fillAmount = 1
  else
    uobj.PlayerLVMax:SetActive(false)
    uobj.ExpMax:SetActive(false)
    uobj.ExpNeed:SetActive(true)
    local need_exp = PlayerMgr:player_lv_need_exp()
    ucom.ExpNeed_txt.text = need_exp
    ucom.ExpNow_txt.text = now_exp
    ucom.ExpImage_img.fillAmount = now_exp / need_exp
  end
  local collection_data = self:get_collection_data()
  self:refresh_collection_view(collection_data)
end

function ui:change_birthday(msg)
  if nil == msg or nil == msg.mm_obj then
    return
  end
  local month = msg.mm_obj.month
  local day = msg.mm_obj.day
  local birthday = Util.format_str("{1}月{2}日", month, day)
  self.v_uicompents.BornDay_txt.text = birthday
  self.v_uicompents.InsertIn_btn.interactable = false
  self.v_uiobjects.BornIcon:SetActive(false)
  self.v_is_birth = true
end

function ui:change_player_name(msg)
  if nil == msg or nil == msg.mm_obj then
    return
  end
  local name = msg.mm_obj
  self.v_uicompents.PlayerName_txt.text = name
  self.v_player_name = name
end

function ui:change_player_avatar(msg)
  if nil == msg or nil == msg.mm_obj then
    return
  end
  local avatar_icon_path = string.format(player_icon_path_prefix, msg.mm_obj.Icon)
  ResMgr:load_set_icon(self.v_uicompents.Profile_img, avatar_icon_path)
end

function ui:_quotation_listener()
  local len = Util.get_string_len(self.quotation_input_field.text)
  if len > 15 then
    Util.show_message_tip(2215)
    local old_str = self.quotation_input_field.text
    local new_str = Util.get_sub_string_utf8(old_str, 15)
    self.quotation_input_field.text = new_str
  end
end

function ui:_quotation_end_edit_listener()
  Word_Censor.check_has_sensitive(self:ui_get_name(), self.quotation_input_field.text, function(ok, lab)
    if ok then
      PlayerMgr:upgrade_quotation(self.quotation_input_field.text, function(ok)
        if not ok then
          self.quotation_input_field.text = ""
        end
      end)
    else
      self.quotation_input_field.text = ""
    end
  end, "player_set_quotation")
end

function ui:refresh_aid()
  self.v_uicompents.AssistNow_txt.text = AssistMgr:get_stranger_help_cnt()
  self.v_uicompents.AssistMax_txt.text = AssistMgr:get_max_assist_cnt()
  local aid_list = CharacterMgr:get_aid_hero()
  for pos, buddy_id in ipairs(aid_list) do
    local aid_item = self.v_uiobjects["Assist" .. pos]
    local btn = Util.get_button(nil, aid_item)
    local no_char_item = Util.get_child_gameobj("NoCharObj_", aid_item)
    local char_item = Util.get_child_gameobj("CharObj_", aid_item)
    local Bg1 = Util.get_child_gameobj("Bg1_", no_char_item)
    local Bg2 = Util.get_child_gameobj("Bg2_", no_char_item)
    Bg1:SetActive(true)
    Bg2:SetActive(false)
    no_char_item:SetActive(0 == buddy_id)
    char_item:SetActive(0 ~= buddy_id)
    if 0 ~= buddy_id then
      local data = CharacterMgr:get_buddy_by_id(buddy_id)
      self:set_player_aid_char_info(char_item, data)
    end
    if btn then
      self:set_button_listener(btn, function()
        self:on_click_aid_item(pos, buddy_id)
      end)
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
  local fashion_id = FashionMgr:get_fashion_wearing_id(data.id)
  local path = UtilUI.get_hero_images(data.id, Config.HERO_ICON_LV.HALF_IMG, fashion_id)
  ResMgr:load_set_icon(char_icon, path, nil, true, self)
  local ele_path = Char_Helper.get_char_element_icon(data.id)
  ResMgr:load_set_icon(element_icon, ele_path)
  local bg_path = Char_Helper.get_char_icon_quality(data.id, Config.CHAR_QUALITY_TYPE.LONG)
  ResMgr:load_set_icon(quality_bg, bg_path)
  char_lv.text = string.format("%.2d", data.lv)
  char_name.text = ShareRes.get_buddy_cfg(data.id).Name
  local job_path = Char_Helper.get_char_job_icon(data.id, false)
  ResMgr:load_set_icon(job, job_path)
  local btnDetail = Util.get_button("BtnDetail_", item)
  self:set_button_listener(btnDetail, function()
    UIMgr:get_ui("character"):ui_show(false, PanelType.ATTR_PANEL, nil, data.id)
  end)
end

function ui:on_click_aid_item(pos, buddy_id)
  local list = CharacterMgr:get_aid_hero()
  local aid_data = {
    select_pos = pos,
    select_buddy_id = buddy_id,
    select_list = list
  }
  CharacterMgr:set_aid_data(aid_data)
  UIMgr:get_ui("character_enter"):ui_show(nil, nil, LAST_SELECT_BUDDY_IDX_TYPE.AID)
end

function ui:register_event()
  self:bind_auto_mq(Const.MSG_ON_CHANGE_BIRTHDAY_SUCCESS, self.change_birthday, self)
  self:bind_auto_mq(Const.MSG_ON_CHANGE_NAME_SUCCESS, self.change_player_name, self)
  self:bind_auto_mq(Const.MSG_ON_CHANGE_AVATAR_SUCCESS, self.change_player_avatar, self)
  self:bind_auto_mq(Const.MSG_ON_GET_ALL_TITLES, self.set_title, self)
  self:bind_auto_mq(Const.MSG_ON_WEAR_TITLE, self.set_title, self)
  self:bind_auto_mq(Const.MSG_TITLE_UI_GET_NEW, self.set_title, self)
  self:bind_auto_mq(Const.MSG_ON_VISITING_CARD_WARE, self.wear_visiting_card, self)
  self:bind_auto_mq(Const.MSG_ON_BROWSE_PLAYER_SPINE, self.response_browse_player_spine, self)
  self:bind_auto_mq(Const.MSG_ON_PLAYER_SPINE_CHOOSE_HIDE, self.hide_ui_spine_refresh, self)
end

function ui:cache_ui()
  return true
end

function ui:remove_feedback_timer()
  if self.v_feedback_timer then
    Timer:remove_timer(self.v_feedback_timer)
    self.v_feedback_timer = nil
  end
end

function ui:_add_feeback_timer()
  self:remove_feedback_timer()
  SDKManager:get_help_center_unread(function(success, data)
    self:_get_help_center_unread(success, data)
  end)
  self.v_feedback_timer = Timer:add_timer("player_feedback_timer", 5, function()
    SDKManager:get_help_center_unread(function(success, data)
      self:_get_help_center_unread(success, data)
    end)
    return true
  end, nil, nil, 5)
end

function ui:_get_help_center_unread(success, data)
  local red_point = self:get_child_gameobj("RedPoint", self.v_uiobjects.BtnFeedback)
  if success and data.unread == "1" then
    red_point:SetActiveEx(data.scene == "3")
  else
    red_point:SetActiveEx(false)
  end
end

function ui:set_title()
  local have_wear_title = PlayerMgr:whether_wear_title()
  if self.v_set_title_obj then
    self.v_set_title_obj:ui_hide()
    self.v_set_title_obj:ui_destroy()
  end
  self.v_set_title_obj = PLAY_SET_TITLE:ui_wrap_ex(self, self.v_uiobjects.TitleObj, true)
  self.v_set_title_obj:set_btn(function()
    self:get_panel("titles"):set_enable(true)
  end)
  if have_wear_title then
    self.v_set_title_obj:set_data(PlayerMgr:get_wear_title().id)
  else
    self.v_set_title_obj:set_data(0)
  end
end

function ui:wear_visiting_card()
  local card_id = PlayerMgr:get_wear_visiting_card()
  if card_id then
    self.v_uiobjects.CardIcon:SetActive(true)
    self.v_uiobjects.NoCardIcon:SetActive(false)
    local cfg = ShareRes.get_visiting_card_cfg(card_id)
    local icon_path = string.format(player_card_path_prefix, cfg.Icon)
    ResMgr:load_set_icon(self.v_uicompents.CardIcon_img, icon_path, nil, true)
  else
    self.v_uiobjects.CardIcon:SetActive(false)
    self.v_uiobjects.NoCardIcon:SetActive(true)
  end
end

function ui:btn_ui_visible(is_visible)
  self.v_uiobjects.BtnLogout:SetActive(is_visible)
  self.v_uiobjects.BtnLayout:SetActive(is_visible)
  self.v_uiobjects.PlayerInfo:SetActive(is_visible)
  self.v_uiobjects.BtnReturn:SetActive(is_visible)
  self.v_uiobjects.BtnMain:SetActive(is_visible)
  self.v_uiobjects.BtnCloseTag:SetActive(not is_visible)
end

function ui:set_part_ui_visible(is_visible)
  self.v_uiobjects.BtnReturn:SetActive(is_visible)
  self.v_uiobjects.BtnMain:SetActive(is_visible)
  self.v_uiobjects.BtnLayout:SetActive(is_visible)
  self.v_uiobjects.BtnClose:SetActive(not is_visible)
  self.v_uiobjects.BtnSavePos:SetActive(not is_visible)
  self.v_uiobjects.BtnPosReset:SetActive(not is_visible)
  self.v_uiobjects.Slider:SetActive(not is_visible)
  self.v_uiobjects.EditTitle:SetActive(not is_visible)
end

function ui:set_button_interactable(is_interactable)
  self.v_uicompents.BtnFunction_btn.interactable = is_interactable
  self.v_uicompents.BtnEndlessDetail_btn.interactable = is_interactable
  self.v_uicompents.BtnBossChalDetail_btn.interactable = is_interactable
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

function ui:refresh_collection_view(data)
  if not data then
    self.v_uicompents.CollectAchieveNum_txt.text = 12
    self.v_uicompents.CollectWeaponNum_txt.text = 13
    self.v_uicompents.CollectCharNum_txt.text = 14
  else
    self.v_uicompents.CollectAchieveNum_txt.text = data.AchieveNum
    self.v_uicompents.CollectWeaponNum_txt.text = data.WeaponNum
    self.v_uicompents.CollectCharNum_txt.text = data.CharNum
  end
end

function ui:refresh_record_view(infinite_id, boss_id)
  self:refresh_bosschal_view(boss_id)
  self.v_uiobjects.EndlessRankOn:SetActive(infinite_id)
  self.v_uiobjects.EndlessRankOff:SetActive(not infinite_id)
  if not infinite_id then
    infinite_id = 1001
  else
    local infinite_cfg = ShareRes.get_inf_chapter_cfg(infinite_id)
    local infinite_list = ChapterMgr:get_inf_chapter_map()
    local StageName = infinite_cfg.Name
    local score
    for i, v in pairs(infinite_list) do
      if v.id == infinite_id then
        score = v.score
        self.v_uiobjects.EndlessRankOff:SetActive(0 == score or nil == score)
        self.v_uiobjects.EndlessRankOn:SetActive(0 ~= score)
        if nil ~= infinite_id and 0 ~= score then
          self.v_uicompents.EndlessTopScore_txt.text = score
          self.v_uicompents.EndlessStage_txt.text = StageName
        end
        break
      end
    end
  end
end

function ui:refresh_stars()
  local curr_star, total_star, num_text
  for i = 1, 2 do
    if not stage_data then
      curr_star = WeeklyMgr:get_pvp_curr_star(i)
      total_star = WeeklyMgr:get_pvp_total_star(i)
      num_text = "WeekactStarNum" .. i .. "_txt"
      if total_star > 0 then
        self.v_uicompents[num_text].text = string.format("%d/%d", curr_star, total_star)
      else
        self.v_uicompents[num_text].text = "未解锁"
      end
    end
  end
end

function ui:response_browse_player_spine(msg)
  if nil == msg then
    return
  end
  local buddy_id = msg.mm_x
  local fashion_id = msg.mm_y
  self:refresh_spine_view(buddy_id, fashion_id)
end

function ui:refresh_spine_view(buddy_id, fashion_id, px, py, scale)
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
  self:init_data()
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
  local fashion_spine_cfg = ShareRes.create("player.player_spine", fashion_id)
  if not px and fashion_spine_cfg then
    px = fashion_spine_cfg.PosX
  if not py and fashion_spine_cfg then
    py = fashion_spine_cfg.PosY
  scale = scale or DEFAULT_POS.scale
  self:_update_scrollbar(scale)
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

function ui:init_data()
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
      local buddy_info = CharacterMgr:get_buddy_by_id(self.v_buddy_id)
      if buddy_info and buddy_info.break_lv > 2 then
        self.v_breaked_up = true
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

local AXIS = "Mouse ScrollWheel"
local PARAM = ShareRes.get_comm_string_value("CharSpineDisplayParam")
local TOUCH_SCALE_SPEED = PARAM and PARAM[1] or 1
local TOUCH_SCALE_SPEED_M = PARAM and PARAM[2] or 3
local MIN_SCALE = PARAM and PARAM[3] or 0.8
local MAX_SCALE = PARAM and PARAM[4] or 2

function ui:_check_touch()
  if UNITY_EDITOR or UNITY_STANDALONE_WIN then
    local diff = Input.GetAxis(AXIS)
    if 0 ~= diff then
      self:_on_pinch(diff * TOUCH_SCALE_SPEED_M)
    elseif Input.GetMouseButton(0) then
      if not self.v_last_mouse_pos then
        self.v_last_mouse_pos = Input.mousePosition
        return
      end
      local cur_mouse_pos = Input.mousePosition
      local delta_x = cur_mouse_pos.x - self.v_last_mouse_pos.x
      local delta_y = cur_mouse_pos.y - self.v_last_mouse_pos.y
      if not self.v_is_slider_interacting then
        self:_on_drag(delta_x, delta_y)
      end
      self.v_last_mouse_pos = cur_mouse_pos
    else
      self.v_last_mouse_pos = nil
    end
  elseif 2 == Input.touchCount then
    local touch_1 = Input.GetTouch(0)
    local touch_2 = Input.GetTouch(1)
    local touch_1_pos = touch_1.position
    local touch_2_pos = touch_2.position
    if touch_2.phase == TouchPhase.Ended then
      self.v_touch_cache_distance = nil
      return
    end
    local cur_dis = UnityVector2.Distance(touch_1_pos, touch_2_pos)
    if not self.v_touch_cache_distance then
      self.v_touch_cache_distance = cur_dis
      return
    end
    local diff = cur_dis - self.v_touch_cache_distance
    self:_on_pinch(diff * TOUCH_SCALE_SPEED)
    self.v_touch_cache_distance = cur_dis
  elseif 1 == Input.touchCount then
    self.v_touch_cache_distance = nil
    local touch = Input.GetTouch(0)
    if touch.phase == TouchPhase.Moved then
      if not self.v_last_touch_pos then
        self.v_last_touch_pos = touch.position
        return
      end
      local delta_x = touch.position.x - self.v_last_touch_pos.x
      local delta_y = touch.position.y - self.v_last_touch_pos.y
      if not self.v_is_slider_interacting then
        self:_on_drag(delta_x, delta_y)
      end
      self.v_last_touch_pos = touch.position
    else
      self.v_last_touch_pos = nil
    end
  else
    self.v_touch_cache_distance = nil
  end
end

function ui:_on_pinch(diff)
  local scale = self.v_icon_root_rect:GetLocalScaleA3()
  scale = _clamp(scale + diff, MIN_SCALE, MAX_SCALE)
  self.v_icon_root_rect:SetLocalScaleA(scale, scale, scale)
  self:_update_scrollbar(scale)
end

function ui:_on_drag(delta_x, delta_y)
  local x, y = self.v_icon_root_rect:GetLocalPositionA3()
  x = _clamp(delta_x + x, -Global.screen_width / 2, Global.screen_width / 2)
  y = _clamp(delta_y + y, -Global.screen_height / 2, Global.screen_height / 2)
  self.v_icon_root_rect:SetLocalPositionA(x, y)
end

function ui:_update_scrollbar(scale)
  local scroll_value = (scale - MIN_SCALE) / (MAX_SCALE - MIN_SCALE)
  self.v_uicompents.Slider_sld.value = scroll_value
end

function ui:_set_scale_from_scrollbar(value)
  local scale = MIN_SCALE + value * (MAX_SCALE - MIN_SCALE)
  self.v_icon_root_rect:SetLocalScaleA(scale, scale, scale)
  self:_update_scrollbar(scale)
end

function ui:show_position_data()
  local x, y = self.v_icon_root_rect:GetLocalPositionA3()
  local scale = self.v_icon_root_rect:GetLocalScaleA3()
  print("x:", x, "y:", y, "scale:", scale)
end

function ui:save_position_data()
  local x, y = self.v_icon_root_rect:GetLocalPositionA3()
  local scale = self.v_icon_root_rect:GetLocalScaleA3()
  local data = PlayerMgr:get_buddy_spine_info()
  data.px = x
  data.py = y
  data.scale = scale
  data.is_break = self.v_breaked_up
  PlayerMgr:request_buddy_spine_info(data, true, true)
end

function ui:reset_position_data()
  local spine_info = PlayerMgr:get_buddy_spine_info()
  local fashion_spine_cfg = ShareRes.create("player.player_spine", spine_info.fashion_id)
  local px, py, scale
  if fashion_spine_cfg then
    px = fashion_spine_cfg.PosX or DEFAULT_POS.x
    py = fashion_spine_cfg.PosY or DEFAULT_POS.y
    scale = fashion_spine_cfg.Scale or DEFAULT_POS.scale
  else
    px = DEFAULT_POS.x
    py = DEFAULT_POS.y
    scale = DEFAULT_POS.scale
  end
  self.v_icon_root_rect:SetLocalPositionA(px, py)
  self.v_icon_root_rect:SetLocalScaleA(scale, scale, scale)
  self:_update_scrollbar(scale)
end

function ui:spine_position_changed()
  local x, y = self.v_icon_root_rect:GetLocalPositionA3()
  local scale = self.v_icon_root_rect:GetLocalScaleA3()
  self.v_buddy_spine_info = PlayerMgr:get_buddy_spine_info()
  local px = self.v_buddy_spine_info.px
  local py = self.v_buddy_spine_info.py
  local pscale = self.v_buddy_spine_info.scale
  return x ~= px or y ~= py or scale ~= pscale
end

function ui:get_collection_data()
  local data = {}
  local all_buddy_list = ShareRes.get_buddy_cfg()
  local own_buddy_list = UtilTable.copy_table(CharacterMgr:get_buddy_map())
  local count_all = 0
  local count_have = 0
  for id, cfg in pairs(all_buddy_list) do
    if 1 ~= cfg.IsShow and CharacterMgr:check_buddy_release(id) then
      local info = own_buddy_list[id]
      count_all = count_all + 1
      if info then
        count_have = count_have + 1
      end
    end
  end
  data.CharNum = count_have
  local original_weapon_info = ShareRes.get_equip()
  local temp = {}
  local get_num = 0
  local all_num = 0
  for id, cfg in pairs(original_weapon_info) do
    if not cfg.BuddyID then
    elseif ShareRes.get_buddy_is_show(cfg.BuddyID) and cfg.ShowInArchive and CharacterMgr:check_buddy_release(cfg.BuddyID) then
      local temp_insert = {}
      temp_insert.weapon_isunlock = ArchiveMgr:is_unlock_archive_equip(cfg.Id)
      _tinsert(temp, temp_insert)
      if temp_insert.weapon_isunlock then
        get_num = get_num + 1
      end
      all_num = all_num + 1
    end
  end
  data.WeaponNum = get_num
  local complete_num = 0
  local total_num = 0
  local all_achievements = ShareRes.get_achievements()
  for k, v in pairs(all_achievements) do
    local task_data = TaskMgr:get_task_by_id(v.TaskId)
    if task_data then
      if task_data.state == TASK_STATE.receive then
        complete_num = complete_num + 1
      elseif task_data.state == TASK_STATE.received then
        complete_num = complete_num + 1
      end
      total_num = total_num + 1
    end
  end
  data.AchieveNum = complete_num
  return data
end

function ui:hide_ui_spine_refresh()
  self.v_buddy_spine_info = PlayerMgr:get_buddy_spine_info()
  local buddy_id = self.v_buddy_spine_info.buddy_id
  local fashion_id = self.v_buddy_spine_info.fashion_id
  local px = self.v_buddy_spine_info.px
  local py = self.v_buddy_spine_info.py
  local scale = self.v_buddy_spine_info.scale
  self:refresh_spine_view(buddy_id, fashion_id, px, py, scale)
end

return ui
