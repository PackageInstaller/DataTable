local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local Setting_Cfg = require("uimodule.battle_setting.battle_setting_cfg")
local Component_Type = Setting_Cfg.ComponentType
local Voice_Type = Setting_Cfg.VoiceType
local Voice_Toggle_List = Setting_Cfg.VoiceToggleList
local Single_Toggle_Type = Setting_Cfg.SingleToggleType
local Single_Toggle_List = Setting_Cfg.SingleToggleList
local Page_Tag = Setting_Cfg.PageTag
local Sub_Toggle_List = Setting_Cfg.SubToggleList
local Sub_Toggle_Name = Setting_Cfg.SubToggleName
local CommonDefine = require("cs_share.common_define")
local Quality_Cfg = require("manager.render.quality_cfg")
local Quality = Quality_Cfg.QUALITY
local Quality_Detail_Cfg = Quality_Cfg.CFG
local ToggleTabClass = require("ui.widget.widget_toggle_tab")
local LayoutRebuilder = UnityEngine.UI.LayoutRebuilder
local BIND_TYPE = Config.BIND_TYPE
local Math = require("base.mathx")
local GuiUtil = UnityEngine.GUIUtility
local TouchManager = CS.TouchManager
local MODEL = {
  v_toggle_voice = {
    "PageVoice",
    BIND_TYPE.TOGGLE
  },
  v_toggle_quality = {
    "PageQuality",
    BIND_TYPE.TOGGLE
  },
  v_toggle_other = {
    "PageOther",
    BIND_TYPE.TOGGLE
  },
  v_toggle_download = {
    "PageDownLoad",
    BIND_TYPE.TOGGLE
  },
  v_toggle_notification = {
    "PageNotification",
    BIND_TYPE.TOGGLE
  },
  v_toggle_account = {
    "PageAccount",
    BIND_TYPE.TOGGLE
  },
  v_toggle_pctouch = {
    "PagePCTouch",
    BIND_TYPE.TOGGLE
  },
  v_graphic_quality1 = {
    "GraphicQuality1",
    BIND_TYPE.TOGGLE
  },
  v_graphic_quality2 = {
    "GraphicQuality2",
    BIND_TYPE.TOGGLE
  },
  v_graphic_quality3 = {
    "GraphicQuality3",
    BIND_TYPE.TOGGLE
  },
  v_graphic_quality4 = {
    "GraphicQuality4",
    BIND_TYPE.TOGGLE
  },
  v_custom_quality = {
    "CustomQuality",
    BIND_TYPE.TOGGLE
  },
  v_control_btn = {
    "ControlBtn",
    BIND_TYPE.OBJECT
  },
  v_btn_main = {
    "BtnMain",
    BIND_TYPE.OBJECT
  }
}
local slider_btn_type = {add = 1, reduce = 2}
local FirstToggleSaveTipsText = "设置已保存"
local ThreeToggleSaveTipsText = "已保存，部分设置在重进关卡后生效"
local download_res_key = "download_res_key"
local cv_language_key = "cv_language_key"
local text_language_key = "text_language_key"
local story_cv_language_key = "story_cv_language_key"
local resolution_set_key = "resolution_set_key"

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("BtnReturn", function()
    self:close()
  end)
  self.v_control_btn:SetActive(true)
  self:set_button("ControlButton", function()
    self:refresh()
    UIMgr:get_ui("battle_btn_setting"):ui_show()
  end)
  self:set_button("BtnSave", function()
    if SDKManager:is_support_key_mouse() and not Global.gamemode:gmode_is_login() then
      BattleSettingMgr:save_keyboard_setting()
    end
    BattleSettingMgr:save_local_setting_info()
    self.v_is_change = false
    local init_toggle = SceneMgr:check_main_scene() and Page_Tag.Voice or Page_Tag.Other
    if not Global.gamemode:gmode_is_login() then
      BattleSettingMgr:save_online_setting_info()
    else
      init_toggle = Page_Tag.Voice
      BattleSettingMgr:set_is_login_saved(true)
    end
    local tipsText = init_toggle == Page_Tag.Voice and FirstToggleSaveTipsText or ThreeToggleSaveTipsText
    Util.show_banner_tip(tipsText)
  end)
  self:set_button("RestLocalSettingInfo", function()
    if self.v_select_sub_toggle == Page_Tag.PCTouch then
      local function confirm_fun()
        self:on_click_reset_to_default()
      end
      
      UIMgr:get_ui("uinotice_tips"):ui_show(confirm_fun, nil, "是否将当前键位设置恢复为默认状态？")
    else
      self:on_click_reset_to_default()
    end
  end)
  self:refresh_curr_cv_language_text()
  self:set_button("BtnSetCV", function()
    local visible = self.v_uiobjects.CVContent.activeSelf
    self:refresh_language_content_visible(CommonDefine.LANGUAGE_TYPE.Voice, not visible)
    self:refresh_cv_list()
  end)
  self:set_button("BtnSetResWin", function()
    local visible = self.v_uiobjects.ResContentWin.activeSelf
    if not visible then
      self:refresh_resolution_panle(not visible)
    else
      self.v_uiobjects.ResContentWin:SetActive(false)
      self.v_uiobjects.ResArrowWin:SetActive(false)
    end
  end)
  self.v_uicompents.TextNow_txt.text = LanguageMgr:get_code_text(CommonDefine.LANGUAGE_TEXT_ID[Global.curr_text_language])
  self:set_button("BtnSetText", function()
    local visible = self.v_uiobjects.TextContent.activeSelf
    self:refresh_language_content_visible(CommonDefine.LANGUAGE_TYPE.Text, not visible)
    self:refresh_text_list()
  end)
  self:refresh_curr_story_cv_language_text()
  self:set_button("BtnSetStoryCV", function()
    local visible = self.v_uiobjects.StoryCVContent.activeSelf
    self:refresh_language_content_visible(CommonDefine.LANGUAGE_TYPE.StoryVoice, not visible)
    self:refresh_story_cv_list()
  end)
  self:set_button("BtnSetCharLanguage", function()
    UIMgr:get_ui("character_voice_language"):ui_show()
  end)
  if UNITY_STANDALONE_WIN then
    local WINDOS_FRAME = {
      FRAME60 = 0,
      FRAME_NO_LIMIT = 1,
      FRAME_VSYNC = 2
    }
    local frame_set = Global.render_mgr:get_save_frame()
    if frame_set == WINDOS_FRAME.FRAME60 then
      self.v_uicompents.FrameNormalWin1_tog.isOn = true
    elseif frame_set == WINDOS_FRAME.FRAME_NO_LIMIT then
      self.v_uicompents.FrameNormalWin2_tog.isOn = true
    elseif frame_set == WINDOS_FRAME.FRAME_VSYNC then
      self.v_uicompents.FrameNormalWin3_tog.isOn = true
    end
    self:set_toggle("FrameNormalWin1", function(is_On)
      if is_On then
        Global.render_mgr:set_frame_60()
      end
    end)
    self:set_toggle("FrameNormalWin2", function(is_On)
      if is_On then
        Global.render_mgr:set_frame_nolimit()
      end
    end)
    self:set_toggle("FrameNormalWin3", function(is_On)
      if is_On then
        Global.render_mgr:set_vsynccount()
      end
    end)
  end
  self.v_init_quality = Global.render_mgr:get_initial_quality_level()
  self:init_list()
  self:init_ui_listener()
  self:init_toggle()
  local download_content = Util.get_child_gameobj("Viewport/Content", self.v_uiobjects.LoadingScroll)
  self:register_exist_auto_template(download_res_key, self.v_uiobjects.ResourceTem, download_content)
  self:register_exist_auto_template(cv_language_key, self.v_uiobjects.CVLanguageItem, self.v_uiobjects.CVContent)
  self:register_exist_auto_template(text_language_key, self.v_uiobjects.TextLanguageItem, self.v_uiobjects.TextContent)
  self:register_exist_auto_template(story_cv_language_key, self.v_uiobjects.StoryCVLanguageItem, self.v_uiobjects.StoryCVContent)
  self:register_exist_auto_template(resolution_set_key, self.v_uiobjects.ResItemWin, self.v_uiobjects.ResContentWin)
  self:init_account_page()
  if SDKManager:is_support_key_mouse() then
    self:init_gpg_page()
  end
end

function ui:refresh_language_content_visible(type, visible)
  self.v_uiobjects.CVContent:SetActive(type == CommonDefine.LANGUAGE_TYPE.Voice and visible)
  self.v_uiobjects.TextContent:SetActive(type == CommonDefine.LANGUAGE_TYPE.Text and visible)
  self.v_uiobjects.StoryCVContent:SetActive(type == CommonDefine.LANGUAGE_TYPE.StoryVoice and visible)
end

function ui:on_click_reset_to_default()
  local init_toggle = SceneMgr:check_main_scene() and Page_Tag.Voice or Page_Tag.Other
  BattleSettingMgr:reset_local_setting_info_to_default(init_toggle, self.v_select_sub_toggle)
  BattleSettingMgr:reset_setting_info_to_default(self.v_select_sub_toggle)
  self:refresh_view()
  self.v_is_change = true
  Util.show_message_tip(2127)
end

function ui:ui_on_show(page_index)
  self:init_view_info()
  self:refresh_view()
  self:refresh_download_info()
  self:register_events()
  if page_index and self.v_sub_toggle_tab then
    self.v_sub_toggle_tab:set_toggle_by_index(page_index)
  end
  self.v_uiobjects.SetCharLanguage:SetActive(not Global.gamemode:gmode_is_login())
  self:refresh_resolution_panle()
end

function ui:ui_on_hide()
  self.v_uiobjects.StoryCVContent:SetActive(false)
  self.v_uiobjects.CVContent:SetActive(false)
  self.v_uiobjects.TextContent:SetActive(false)
  MsgGame:mq_publish2(Const.MSG_ON_SPECIAL_SCREEN_CHANGE)
end

function ui:ui_on_destroy()
  self.v_sub_tab_list = nil
  self.v_sub_toggle_tab = nil
  self.v_voice_open_icon_list = nil
  self.v_voice_close_icon_list = nil
  self.v_on_obj_list = nil
  self.v_off_obj_list = nil
  self.v_graphic_quality_list = nil
  self.v_graphic_quality_tab = nil
end

function ui:init_view_info()
  local init_toggle = (SceneMgr:check_main_scene() or Global.gamemode:gmode_is_login()) and Page_Tag.Voice or Page_Tag.Other
  for _, index in pairs(Page_Tag) do
    self.v_uiobjects[Sub_Toggle_List[index]]:SetActive(init_toggle == index)
  end
  self.v_select_sub_toggle = init_toggle
  if self.v_select_sub_toggle == Page_Tag.Download or self.v_select_sub_toggle == Page_Tag.Notification or self.v_select_sub_toggle == Page_Tag.Account then
    self.v_uiobjects.RestLocalSettingInfo:SetActive(false)
  else
    self.v_uiobjects.RestLocalSettingInfo:SetActive(true)
  end
  self.v_uiobjects.BtnSave:SetActive(self.v_select_sub_toggle ~= Page_Tag.Download and self.v_select_sub_toggle ~= Page_Tag.Account)
  self.v_sub_toggle_tab:set_toggle_by_index(Page_Tag.Voice)
  self.v_sub_toggle_tab:set_toggle_by_index(init_toggle)
  self.v_is_change = false
  Util.get_scrollrect(nil, self.v_uiobjects.QualityScroll).verticalNormalizedPosition = 1
  Util.get_scrollrect(nil, self.v_uiobjects.OtherScroll).verticalNormalizedPosition = 1
  self.v_btn_main:SetActive(false)
end

function ui:init_list()
  self.v_voice_open_icon_list = {}
  self.v_voice_close_icon_list = {}
  for _, index in pairs(Voice_Type) do
    self.v_voice_open_icon_list[index] = self.v_uiobjects[Voice_Toggle_List[index]]:FindChild("VoiceOpen").gameObject
    self.v_voice_close_icon_list[index] = self.v_uiobjects[Voice_Toggle_List[index]]:FindChild("VoiceClose").gameObject
  end
  self.v_on_obj_list = {}
  self.v_off_obj_list = {}
  for _, index in pairs(Single_Toggle_Type) do
    self.v_on_obj_list[index] = self.v_uiobjects[Single_Toggle_List[index]]:FindChild("Panel/LayoutOn").gameObject
    self.v_off_obj_list[index] = self.v_uiobjects[Single_Toggle_List[index]]:FindChild("Panel/LayoutOff").gameObject
  end
end

function ui:init_toggle()
  local init_toggle = SceneMgr:check_main_scene() and Page_Tag.Voice or Page_Tag.Other
  self.v_sub_tab_list = {
    self.v_toggle_voice,
    self.v_toggle_quality,
    self.v_toggle_other,
    self.v_toggle_download,
    self.v_toggle_notification,
    self.v_toggle_account,
    self.v_toggle_pctouch
  }
  self.v_toggle_notification:SetActive(SDKManager:is_enable_notification_setting())
  self.v_toggle_account:SetActive(SDKManager:is_enable_account_setting())
  self.v_toggle_pctouch:SetActive(SDKManager:is_support_key_mouse())
  self.v_toggle_quality:SetActive(SceneMgr:check_main_scene())
  if Global.gamemode:gmode_is_login() then
    self.v_toggle_other:SetActive(false)
    self.v_toggle_pctouch:SetActive(false)
  end
  self.v_sub_toggle_tab = ToggleTabClass:new(self)
  self.v_sub_toggle_tab:init_by_toggles(self.v_sub_tab_list, function(cur_select, pre_select, cur_toggle, pre_toggle)
    self:select_sub_toggle(cur_select, pre_select, cur_toggle, pre_toggle)
  end, init_toggle)
  self.v_graphic_quality_list = {
    self.v_graphic_quality1,
    self.v_graphic_quality2,
    self.v_graphic_quality3,
    self.v_graphic_quality4,
    self.v_custom_quality
  }
  self:init_graphic_toggle_interactable()
  self.v_graphic_quality_tab = ToggleTabClass:new(self)
  self.v_graphic_quality_tab:init_by_toggles(self.v_graphic_quality_list, function(cur_select, pre_select, cur_toggle, pre_toggle)
    self:select_graphic_quality(cur_select, pre_select, cur_toggle, pre_toggle)
  end, Page_Tag.Voice)
end

function ui:refresh_cv_list()
  self:give_back_auto_cache(cv_language_key)
  local select_index = CommonDefine.LANGUAGE_INDEX[Global.curr_language]
  self.v_cv_language_index_list = BattleSettingMgr:get_show_language_list(Config.CommonDefine.LANGUAGE_TYPE.Voice)
  for i, language_index in pairs(self.v_cv_language_index_list) do
    local item_obj = self:get_auto_cache(cv_language_key)
    local select = self:get_child_gameobj("Select", item_obj)
    select:SetActive(select_index == language_index)
    local name = self:get_text("Name", item_obj)
    local language_id = CommonDefine.LANGUAGE_CV_ID[CommonDefine.INDEX_LANGUAGE[language_index]]
    name.text = LanguageMgr:get_code_text(language_id)
    local btn = self:get_button(nil, item_obj)
    self:set_button_listener(btn, function()
      if language_index == select_index then
        self.v_uiobjects.CVContent:SetActive(false)
        return
      end
      self:select_cv_language_toggle(language_index)
    end)
  end
end

function ui:refresh_curr_cv_language_text()
  self.v_uicompents.CVNow_txt.text = LanguageMgr:get_code_text(CommonDefine.LANGUAGE_CV_ID[Global.curr_language])
end

function ui:refresh_curr_story_cv_language_text()
  self.v_uicompents.StoryCVNow_txt.text = LanguageMgr:get_code_text(CommonDefine.LANGUAGE_CV_ID[Global.curr_story_cv_language])
end

function ui:select_cv_language_toggle(language_index)
  if self.ignore_chang_language then
    self.ignore_chang_language = nil
    return
  end
  Global.sound_mgr:remove_cache_voice_sound()
  local language = CommonDefine.INDEX_LANGUAGE[language_index]
  
  local function cb(is_need_tip)
    Global.curr_language = language
    if CharacterMgr then
      CharacterMgr:refresh_all_buddy_cv_language()
    end
    Global.sound_mgr:remove_cache_voice_sound()
    self.v_uiobjects.CVContent:SetActive(false)
    CS.GameToLua.CheckUpdate.SetSelectLanguage(language_index)
    if is_need_tip then
      self:refresh_curr_cv_language_text()
      Util.show_message_tip("切换成功")
    end
  end
  
  if Game_AssetBundle then
    local format_size = CS.VoiceCheckManager.Instance:GetNeedDownloadSoundSize(language)
    local tips = ""
    if "" == format_size then
      tips = "切换后将重置所有角色语音，是否切换？"
    else
      tips = Util.format_str("切换该语音需要下载{1}对应音频文件,切换后将重置所有角色语音，是否切换？", format_size)
    end
    Util.show_conform_tip(Util.format_str(tips, language), "取消", "确认", function()
      self.v_uiobjects.CVContent:SetActive(false)
    end, function()
      if "" == format_size then
        cb(true)
      else
        cb(false)
        Util.change_to_other_language(language, Config.CommonDefine.LANGUAGE_TYPE.Voice)
      end
    end)
  else
    cb(true)
  end
end

function ui:refresh_story_cv_list()
  self:give_back_auto_cache(story_cv_language_key)
  local select_index = CommonDefine.LANGUAGE_INDEX[Global.curr_story_cv_language]
  self.v_story_cv_language_index_list = BattleSettingMgr:get_show_language_list(Config.CommonDefine.LANGUAGE_TYPE.Story)
  for i, language_index in pairs(self.v_story_cv_language_index_list) do
    local item_obj = self:get_auto_cache(story_cv_language_key)
    local select = self:get_child_gameobj("Select", item_obj)
    select:SetActive(select_index == language_index)
    local name = self:get_text("Name", item_obj)
    local language_id = CommonDefine.LANGUAGE_CV_ID[CommonDefine.INDEX_LANGUAGE[language_index]]
    name.text = LanguageMgr:get_code_text(language_id)
    local btn = self:get_button(nil, item_obj)
    self:set_button_listener(btn, function()
      if language_index == select_index then
        self.v_uiobjects.StoryCVContent:SetActive(false)
        return
      end
      self:select_story_cv_language_toggle(language_index)
    end)
  end
end

function ui:select_story_cv_language_toggle(language_index)
  if self.ignore_chang_language then
    self.ignore_chang_language = nil
    return
  end
  local language = CommonDefine.INDEX_LANGUAGE[language_index]
  
  local function cb(is_need_tip)
    Global.curr_story_cv_language = language
    CS.GameToLua.CheckUpdate.SetSelectStoryVoiceLanguage(language_index)
    Global.sound_mgr:remove_cache_voice_sound()
    self.v_uiobjects.StoryCVContent:SetActive(false)
    if is_need_tip then
      self:refresh_curr_story_cv_language_text()
      Util.show_message_tip("切换成功")
    end
  end
  
  if Game_AssetBundle then
    local format_size = CS.VoiceCheckManager.Instance:GetNeedDownloadStorySoundSize(language)
    if "" == format_size then
      cb(true)
    else
      Util.show_conform_tip(Util.format_str("切换该语音需要下载{1}对应剧情音频文件,是否退出到登录界面？", format_size), "取消", "确认", function()
        self.v_uiobjects.StoryCVContent:SetActive(false)
      end, function()
        cb(false)
        Util.change_to_other_language(language, Config.CommonDefine.LANGUAGE_TYPE.Story)
      end)
    end
  else
    cb(true)
  end
end

function ui:refresh_text_list()
  self:give_back_auto_cache(text_language_key)
  local select_index = CommonDefine.LANGUAGE_INDEX[Global.curr_text_language]
  self.v_text_language_index_list = BattleSettingMgr:get_show_language_list(Config.CommonDefine.LANGUAGE_TYPE.Text)
  self.v_text_language_list = {}
  for i, language_index in pairs(self.v_text_language_index_list) do
    local item_obj = self:get_auto_cache(text_language_key)
    local select = self:get_child_gameobj("Select", item_obj)
    select:SetActive(select_index == language_index)
    local name = self:get_text("Name", item_obj)
    local language_id = CommonDefine.LANGUAGE_TEXT_ID[CommonDefine.INDEX_LANGUAGE[language_index]]
    name.text = LanguageMgr:get_code_text(language_id)
    local btn = self:get_button(nil, item_obj)
    self:set_button_listener(btn, function()
      if language_index == select_index then
        self.v_uiobjects.TextContent:SetActive(false)
        return
      end
      self:select_text_language_toggle(language_index)
    end)
  end
end

function ui:select_text_language_toggle(language_index)
  if self.ignore_chang_language then
    self.ignore_chang_language = nil
    return
  end
  local language = CommonDefine.INDEX_LANGUAGE[language_index]
  Util.show_conform_tip(Util.format_str("切换语言需要重新登录,是否退出到登录界面？", language), "取消", "确认", function()
    self.v_uiobjects.TextContent:SetActive(false)
  end, function()
    Global.curr_text_language = language
    CS.GameToLua.CheckUpdate.SetSelectTextLanguage(language_index)
    Util.change_to_other_language(language, Config.CommonDefine.LANGUAGE_TYPE.Text)
  end)
  ShareRes.clear()
end

function ui:init_graphic_toggle_interactable()
  local hard_ware_quality = Global.render_mgr:try_get_hard_ware_quality()
  if not hard_ware_quality or UNITY_EDITOR then
    return
  end
  if hard_ware_quality < Quality.MIDDLE then
    self:set_toggle_interactable(self.v_graphic_quality4, false)
  end
end

function ui:set_toggle_interactable(toggle, is_enable)
  if not toggle then
    return
  end
  toggle.interactable = is_enable
  local image = toggle.gameObject:GetComponent(TypeUnityUIImage)
  if not image then
    return
  end
  image.raycastTarget = is_enable
end

function ui:refresh_view()
  self.v_is_refresh = false
  local init_toggle = SceneMgr:check_main_scene() and Page_Tag.Voice or Page_Tag.Other
  if Global.gamemode:gmode_is_login() then
    init_toggle = Page_Tag.Voice
  end
  if init_toggle == Page_Tag.Voice then
    self:refresh_voice_view()
    self:refresh_graphic_view()
    self:refresh_other_view(true)
    self.v_uiobjects.Language:SetActive(true)
  else
    self:refresh_voice_view()
    self:refresh_graphic_view()
    self:refresh_other_view(false)
    self.v_uiobjects.Language:SetActive(false)
  end
  self:refresh_notification_view()
  if SDKManager:is_support_key_mouse() then
    self:refresh_gpg_page()
  end
  self.v_is_refresh = true
end

function ui:refresh_voice_view()
  local local_setting_info = BattleSettingMgr:get_local_setting_info()
  for key, data in pairs(self.v_voice_data) do
    self.v_uicompents[data.ui_list[1].slider_name .. "_sld"].value = local_setting_info[key]
    self.v_uicompents[data.ui_list[1].toggle_name .. "_tog"].isOn = local_setting_info[key] > 0
  end
end

function ui:refresh_graphic_view()
  local local_setting_info = BattleSettingMgr:get_local_setting_info()
  local local_graphic_quality = BattleSettingMgr:get_local_graphic_quality()
  if nil ~= local_graphic_quality then
    if self.v_graphic_quality_tab then
      self.v_graphic_quality_tab:set_toggle_by_index(local_graphic_quality)
    end
    if local_graphic_quality == Quality.LOW then
      self:refresh_select_quality_info(local_graphic_quality)
    elseif local_graphic_quality == Quality.ULTRA then
      for key, data in pairs(self.v_graphic_quality_data) do
        local index = local_setting_info[key]
        if data.type == "single_toggle" then
          self.v_uicompents[data.ui_list[1].ui_name .. "_tog"].isOn = 0 ~= index
        elseif data.type == "multi_toggle" then
          local ui_info = data.ui_list[index]
          if ui_info then
            local ui_name = ui_info.ui_name
            if ui_name then
              ui_name = ui_name .. "_tog"
              local toggle = self.v_uicompents[ui_name]
              if toggle then
                toggle.isOn = true
              else
                Log.Error("设置界面未找到toggle", ui_name)
              end
            end
          end
        end
      end
    end
  else
    local quality_index
    if self.v_init_quality == Quality.ULTRA then
      quality_index = Quality.VERY_HIGH
    else
      quality_index = self.v_init_quality
    end
    self.v_graphic_quality_tab:set_toggle_by_index(quality_index)
  end
end

function ui:refresh_other_view(is_in_main_scene)
  local local_setting_info = BattleSettingMgr:get_local_setting_info()
  local setting_info = BattleSettingMgr:get_setting_info()
  if not setting_info then
    return
  end
  for key, data in pairs(self.v_other_data) do
    local index = setting_info[key]
    if data.type == "slider" then
      if "safe_area" == key then
        self.v_uicompents[data.ui_list[1].ui_name .. "_sld"].value = local_setting_info[key]
      end
    elseif data.type == "single_toggle" then
      self.v_uicompents[data.ui_list[1].ui_name .. "_tog"].isOn = 0 ~= index
    elseif data.type == "multi_toggle" then
      for _, ui_list in pairs(data.ui_list) do
        if ui_list.value == index then
          local ui_toggle = self.v_uicompents[ui_list.ui_name .. "_tog"]
          if ui_toggle then
            ui_toggle.isOn = true
            break
          end
          Log.Error("设置界面未找到toggle", ui_list.ui_name)
          break
        end
      end
    elseif data.type == "slider_btn" then
      self.v_uicompents[data.ui_list[1].ui_name .. "_sld"].value = index
      if data.show_obj then
        local com_name = data.show_obj .. "_txt"
        if self.v_uicompents[com_name] then
          self.v_uicompents[com_name].text = index / 10
        end
      end
    end
  end
  self.v_uiobjects.CameraViewType:SetActiveEx(is_in_main_scene)
end

function ui:init_ui_listener()
  self.v_voice_data = {}
  self.v_graphic_quality_data = {}
  self.v_other_data = {}
  for key, data in pairs(Setting_Cfg.UI_CFG) do
    local type = data.type
    local fun = data.fun
    local ui_list = data.ui_list
    local reduce_obj_name = data.reduce_btn
    local add_obj_name = data.add_btn
    local min_value = data.min_num
    local max_value = data.max_num
    local show_obj = data.show_obj
    local voice_type = data.voice_type
    local single_toggle_type = data.single_toggle_type
    local enable_value = data.enable_value
    if data.page_tag ~= nil then
      if data.page_tag == Page_Tag.Voice then
        self.v_voice_data[key] = data
      elseif data.page_tag == Page_Tag.Quality then
        self.v_graphic_quality_data[key] = data
      elseif data.page_tag == Page_Tag.Other then
        self.v_other_data[key] = data
      elseif data.page_tag == Page_Tag.PCTouch and not SDKManager:is_support_key_mouse() then
        goto lbl_182
      end
    end
    if data.desc_obj then
      local desc_txt = Util.get_text(nil, self.v_uiobjects[data.desc_obj])
      if desc_txt then
        desc_txt.text = self:get_explain_content(key)
      end
    end
    if ui_list then
      for _, ui_data in pairs(ui_list) do
        local ui_name = ui_data.ui_name
        local value = ui_data.value
        local subtype = ui_data.subtype
        if "single_toggle" == type then
          if "ToggleHDR" == ui_name then
            local init_on = BattleSettingMgr:get_hdr()
            self.v_on_obj_list[single_toggle_type]:SetActive(init_on)
            self.v_off_obj_list[single_toggle_type]:SetActive(not init_on)
          end
          if "ToggleAntiAliasing" == ui_name then
            local init_on = BattleSettingMgr:get_anti_aliasing()
            self.v_on_obj_list[single_toggle_type]:SetActive(init_on)
            self.v_off_obj_list[single_toggle_type]:SetActive(not init_on)
          end
          self:set_toggle(ui_name, function(is_on)
            if single_toggle_type then
              self.v_on_obj_list[single_toggle_type]:SetActive(is_on)
              self.v_off_obj_list[single_toggle_type]:SetActive(not is_on)
            end
            if data.desc_obj then
              self.v_uiobjects[data.desc_obj]:SetActive(is_on)
            end
            BattleSettingMgr[fun](BattleSettingMgr, is_on)
            self:set_change_state()
            if data.page_tag ~= nil and data.page_tag == Page_Tag.Quality and nil ~= self.v_is_click_sub_quality and self.v_is_click_sub_quality == true then
              self.v_graphic_quality_tab:set_toggle_by_index(Quality.ULTRA)
              self.v_is_click_sub_quality = false
            end
          end)
        elseif "multi_toggle" == type then
          self:set_toggle(ui_name, function(is_on)
            if is_on then
              BattleSettingMgr[fun](BattleSettingMgr, value)
            end
            self.v_uicompents[ui_name .. "_tog"].interactable = not is_on
            self:set_change_state()
            if data.page_tag ~= nil and data.page_tag == Page_Tag.Quality and nil ~= self.v_is_click_sub_quality and self.v_is_click_sub_quality == true and is_on then
              self.v_graphic_quality_tab:set_toggle_by_index(Quality.ULTRA)
              self.v_is_click_sub_quality = false
            end
            if data.desc_obj and data.enable_value then
              self.v_uiobjects[data.desc_obj]:SetActive(enable_value == value)
            end
          end)
        elseif "slider" == type then
          local com_sld = self.v_uicompents[ui_name .. "_sld"]
          self:set_slider_listener(com_sld, function()
            self:set_change_state()
            BattleSettingMgr[fun](BattleSettingMgr, com_sld.value)
          end)
        elseif "slider_btn" == type then
          local com_sld = self.v_uicompents[ui_name .. "_sld"]
          self:set_slider_listener(com_sld, function()
            self:set_change_state()
            self.v_uicompents[show_obj .. "_txt"].text = com_sld.value / 10
            BattleSettingMgr[fun](BattleSettingMgr, com_sld.value)
          end)
          self:set_button(reduce_obj_name, function()
            self:click_silder_change_btn(slider_btn_type.reduce, com_sld, show_obj, fun, min_value, max_value)
          end)
          self:set_button(add_obj_name, function()
            self:click_silder_change_btn(slider_btn_type.add, com_sld, show_obj, fun, min_value, max_value)
          end)
        elseif "slider_toggle" == type then
          local com_sld = self.v_uicompents[ui_data.slider_name .. "_sld"]
          self:set_slider_listener(com_sld, function()
            self:set_change_state()
            self[fun](self, com_sld, Component_Type.Slider, fun, voice_type)
          end)
          self:set_toggle(ui_data.toggle_name, function(is_on)
            self:set_change_state()
            self[fun](self, com_sld, Component_Type.Toggle, fun, voice_type, is_on)
          end)
        end
      end
    end
    ::lbl_182::
  end
end

function ui:refresh()
end

function ui:select_sub_toggle(cur_select, pre_select, cur_toggle, pre_toggle)
  for idx, obj_name in pairs(Sub_Toggle_List) do
    self.v_uiobjects[obj_name]:SetActive(idx == cur_select)
  end
  self.v_select_sub_toggle = cur_select
  local curr_anim_out = self:get_child_gameobj("Ani_Out", cur_toggle.gameObject)
  curr_anim_out:SetActive(false)
  local last_anim_out = self:get_child_gameobj("Ani_Out", pre_toggle.gameObject)
  last_anim_out:SetActive(false)
  last_anim_out:SetActive(true)
  if cur_select == Page_Tag.Download or cur_select == Page_Tag.Notification or cur_select == Page_Tag.Account then
    self.v_uiobjects.RestLocalSettingInfo:SetActive(false)
  else
    self.v_uiobjects.RestLocalSettingInfo:SetActive(true)
  end
  self.v_uiobjects.BtnSave:SetActive(cur_select ~= Page_Tag.Download and cur_select ~= Page_Tag.Account)
end

function ui:select_graphic_quality(cur_select, pre_select, cur_toggle, pre_toggle)
  if self.v_last_quality_index == cur_select then
    return
  end
  self:refresh_select_quality_info(cur_select)
end

function ui:click_silder_change_btn(change_type, com_sld, show_obj, fun, min_val, max_val)
  self:set_change_state()
  local result = com_sld.value
  if change_type == slider_btn_type.add then
    result = result + 1
  else
    result = result - 1
  end
  result = Math.Clamp(result, min_val, max_val)
  self.v_uicompents[show_obj .. "_txt"].text = result / 10
  com_sld.value = result
  BattleSettingMgr[fun](BattleSettingMgr, result)
end

function ui:get_explain_content(key)
  local show_des
  if BattleSettingMgr.setting_tips == nil then
    return
  end
  for _, data in pairs(BattleSettingMgr.setting_tips) do
    if key == data.Name then
      show_des = data.Desc
      break
    end
  end
  return show_des
end

function ui:set_game_voice(com_sld, component_type, fun, voice_type, is_on)
  if component_type == Component_Type.Slider then
    self.v_voice_open_icon_list[voice_type]:SetActive(com_sld.value > 0)
    self.v_voice_close_icon_list[voice_type]:SetActive(0 == com_sld.value)
  elseif component_type == Component_Type.Toggle then
    self.v_voice_open_icon_list[voice_type]:SetActive(is_on)
    self.v_voice_close_icon_list[voice_type]:SetActive(not is_on)
    if self.v_is_refresh then
      if voice_type == Voice_Type.Main then
        com_sld.value = is_on and BattleSettingMgr:get_default_voice_main() or 0
      elseif voice_type == Voice_Type.BG then
        com_sld.value = is_on and BattleSettingMgr:get_default_voice_bg() or 0
      elseif voice_type == Voice_Type.SE then
        com_sld.value = is_on and BattleSettingMgr:get_default_voice_se() or 0
      elseif voice_type == Voice_Type.CV then
        com_sld.value = is_on and BattleSettingMgr:get_default_voice_cv() or 0
      end
    elseif voice_type == Voice_Type.Main then
      com_sld.value = BattleSettingMgr:get_voice_main()
    elseif voice_type == Voice_Type.BG then
      com_sld.value = BattleSettingMgr:get_voice_bg()
    elseif voice_type == Voice_Type.SE then
      com_sld.value = BattleSettingMgr:get_voice_se()
    elseif voice_type == Voice_Type.CV then
      com_sld.value = BattleSettingMgr:get_voice_cv()
    end
  end
  BattleSettingMgr[fun](BattleSettingMgr, com_sld.value, voice_type)
end

function ui:refresh_select_quality_info(cur_select)
  self.v_last_quality_index = cur_select
  BattleSettingMgr:set_local_graphic_quality_level(cur_select)
  if cur_select == Quality.VERY_HIGH then
    if self.v_init_quality == Quality.ULTRA then
      cur_select = Quality.ULTRA
    end
  elseif cur_select == Quality.ULTRA then
    return
  end
  BattleSettingMgr:set_local_graphic_quality(cur_select)
  if self.v_is_click_sub_quality ~= nil and self.v_is_click_sub_quality == true then
    self.v_is_click_sub_quality = false
  end
  local quality_cfg = Quality_Detail_Cfg[cur_select]
  local graphic_quality_data
  for key, data in pairs(quality_cfg) do
    if nil ~= self.v_graphic_quality_data[key] then
      graphic_quality_data = self.v_graphic_quality_data[key]
      if graphic_quality_data.type == "single_toggle" then
        self.v_uicompents[graphic_quality_data.ui_list[1].ui_name .. "_tog"].isOn = 0 ~= data and false ~= data
      elseif graphic_quality_data.type == "multi_toggle" then
        if nil == graphic_quality_data.ui_list[data] then
          Log.Error(data, "not exist!")
          Log.Error(graphic_quality_data.ui_list)
        end
        self.v_uicompents[graphic_quality_data.ui_list[data].ui_name .. "_tog"].isOn = true
      end
    end
  end
  self.v_is_click_sub_quality = true
end

function ui:set_change_state()
  if self.v_is_refresh then
    self.v_is_change = true
  end
end

function ui:get_change_state()
  return self.v_is_change
end

function ui:cache_ui()
  return true
end

function ui:register_events()
  self:bind_auto_mq(Const.MSG_ON_OTHER_RES_CHECK_FINISH, self.on_other_res_check_finish, self)
  self:bind_auto_mq(Const.MSG_ON_OTHER_RES_DOWNLOAD_PROGRESS_REFRESH, self.on_other_res_download_progress_refresh, self)
  self:bind_auto_mq(Const.MSG_ON_OTHER_RES_DOWNLOAD_FINISH, self.on_other_res_download_finish, self)
  self:bind_auto_mq(Const.MSG_ON_NOTIFICATION_SETTING_CHANGE, self.refresh_notification_view, self)
  if SDKManager:is_support_key_mouse() then
    self:bind_auto_mq(Const.MSG_CUSTOM_KEY_SETTING, self._response_custom_key_setting, self)
    self:bind_auto_mq(Const.MSG_CUSTOM_KEY_SETTING_END, self._response_ui_input_listener_hide, self)
  end
end

function ui:refresh_download_info()
  if SDKType ~= Config.SDK_TYPE.HIVE_SDK then
    self.v_uiobjects[Sub_Toggle_Name[Page_Tag.Download]]:SetActive(false)
    return
  end
  if not DownloadMgr then
    self.v_uiobjects[Sub_Toggle_Name[Page_Tag.Download]]:SetActive(false)
    return
  end
  if not Game_AssetBundle or DownloadMgr:check_res_is_integrity() then
    self.v_uiobjects[Sub_Toggle_Name[Page_Tag.Download]]:SetActive(false)
    return
  end
  self.v_uiobjects[Sub_Toggle_Name[Page_Tag.Download]]:SetActive(true)
  MsgGame:mq_publish2(Const.MSG_ON_OTHER_RES_CHECK_FINISH)
  if not DownloadMgr:check_res_is_integrity() and DownloadMgr:get_is_need_request_other_download_info() then
    DownloadMgr:download_other_res()
  end
  self:set_button("ControlButton", function()
    self:refresh()
    UIMgr:get_ui("battle_btn_setting"):ui_show()
  end)
end

function ui:on_other_res_check_finish(msg)
  self.res_infos = DownloadMgr:get_check_res_infos()
  if not self.res_infos then
    return false
  end
  local checkParams = DownloadMgr:get_check_params()
  if nil == checkParams then
    return
  end
  self:refresh_download_ui()
end

function ui:refresh_download_ui()
  if not self.res_infos then
    return
  end
  self.v_item_obj_list = {}
  self:give_back_auto_cache(download_res_key)
  for i, item_data in pairs(self.res_infos) do
    local item_obj = self:get_auto_cache(download_res_key)
    self:refresh_download_item(item_obj, item_data)
    self.v_item_obj_list[item_data.chapter_index] = item_obj
  end
  self:set_button("BtnAllDownLoad", function()
    DownloadMgr:on_begin_download(0)
  end)
end

function ui:refresh_download_item(item_obj, item_data)
  local res_name = Util.get_text("ResourceName_", item_obj)
  res_name.text = Util.format_str("第{1}章资源", item_data.chapter_index)
  local res_desc = Util.get_text("ResourceDesc_", item_obj)
  res_desc.text = Util.format_str("第{1}章资源{2}", item_data.chapter_index, item_data.max_size)
  local res_size = Util.get_text("ResourceStoreTitle_/ResourceStore_", item_obj)
  res_size.text = Util.format_str("{1}MB", item_data.max_size)
  local res_confirmBtn = Util.get_button("BtnDonwLoad_", item_obj)
  local res_pauseBtn = Util.get_button("BtnPause_", item_obj)
  local res_continueBtn = Util.get_button("BtnContinue_", item_obj)
  local res_progressBar = Util.get_slider("DownLoadBar_", item_obj)
  local res_finish_obj = Util.get_child_gameobj("DownLoadFinish_", item_obj)
  local res_downloading_progress = Util.get_text("DonwLoadingText_", item_obj)
  res_downloading_progress.text = ""
  local res_download_progress_image = Util.get_image("DownLoadBar/DownLoadFill_", item_obj)
  res_download_progress_image.fillAmount = 0
  res_confirmBtn.gameObject:SetActive(true)
  res_pauseBtn.gameObject:SetActive(false)
  res_continueBtn.gameObject:SetActive(false)
  res_progressBar.gameObject:SetActive(false)
  res_finish_obj.gameObject:SetActive(false)
  self:refresh_download_state(item_obj, item_data)
  self:set_button_listener(res_confirmBtn, function()
    DownloadMgr:on_begin_download_with_setting(item_data.chapter_index)
  end)
  self:set_button_listener(res_pauseBtn, function()
    DownloadMgr:on_pause_download(item_data.chapter_index)
  end)
  self:set_button_listener(res_continueBtn, function()
    DownloadMgr:on_continue_download(item_data.chapter_index)
  end)
end

function ui:refresh_download_item_progress(item_obj, item_data)
  local res_confirmBtn = Util.get_button("BtnDonwLoad_", item_obj)
  local res_pauseBtn = Util.get_button("BtnPause_", item_obj)
  local res_continueBtn = Util.get_button("BtnContinue_", item_obj)
  local res_download_bar = Util.get_child_gameobj("DownLoadBar", item_obj)
  local res_download_progress_image = Util.get_image("DownLoadBar/DownLoadFill_", item_obj)
  local res_finish_obj = Util.get_child_gameobj("DownLoadFinish_", item_obj)
  local res_desc = Util.get_text("ResourceDesc_", item_obj)
  local res_downloading_progress = Util.get_text("DonwLoadingText_", item_obj)
  res_confirmBtn.gameObject:SetActive(0 == item_data.download_type)
  res_pauseBtn.gameObject:SetActive(1 == item_data.download_type or 4 == item_data.download_type)
  res_download_bar:SetActive(1 == item_data.download_type or 2 == item_data.download_type)
  res_continueBtn.gameObject:SetActive(2 == item_data.download_type)
  res_finish_obj.gameObject:SetActive(3 == item_data.download_type)
  res_download_progress_image.fillAmount = item_data.progress
  self:refresh_download_state(item_obj, item_data)
  res_desc.text = Util.format_str("已下载:{1}/{2}", item_data.curr_size, item_data.max_size)
  if 1 == item_data.download_type and item_data.progress > 0 then
    res_downloading_progress.text = DownloadMgr:get_speed() .. item_data.speed
  else
    res_downloading_progress.text = ""
  end
end

function ui:refresh_download_state(item_obj, item_data)
  local no_download_obj = Util.get_child_gameobj("ResourceName_/State/StateNoDownLoad_", item_obj)
  local downloading_obj = Util.get_child_gameobj("ResourceName_/State/StateDownLoading_", item_obj)
  local wait_obj = Util.get_child_gameobj("ResourceName_/State/StateWaitting_", item_obj)
  local pause_obj = Util.get_child_gameobj("ResourceName_/State/StatePause_", item_obj)
  no_download_obj:SetActive(0 == item_data.download_type)
  downloading_obj:SetActive(1 == item_data.download_type and item_data.progress > 0)
  wait_obj:SetActive(4 == item_data.download_type)
  pause_obj:SetActive(2 == item_data.download_type)
end

function ui:on_other_res_download_progress_refresh(msg)
  local res_infos = msg.mm_obj
  if not res_infos or not self.v_item_obj_list then
    return
  end
  for i, res_info in pairs(res_infos) do
    local item_obj = self.v_item_obj_list[res_info.chapter_index]
    self:refresh_download_item_progress(item_obj, res_info)
  end
end

function ui:on_other_res_download_finish()
end

function ui:refresh_notification_view()
  local is_enable_all_notification_toggle = BattleSettingMgr:get_all_notification_enabled()
  if not UNITY_ANDROID then
    is_enable_all_notification_toggle = true
    self.v_uiobjects.ToggleAllNotification:SetActive(false)
  end
  local is_enable_notice_notification_toggle = BattleSettingMgr:get_notice_notification_enabled()
  local is_enable_night_notification_toggle = BattleSettingMgr:get_night_notification_enabled()
  self.v_uicompents.ToggleAllNotification_tog.isOn = BattleSettingMgr:get_all_notification_enabled()
  self.v_uicompents.ToggleNoticeNotification_tog.isOn = BattleSettingMgr:get_notice_notification_enabled()
  self.v_uicompents.ToggleNightNotification_tog.isOn = BattleSettingMgr:get_night_notification_enabled()
  self.v_uiobjects.ToggleNoticeNotification:SetActive(is_enable_all_notification_toggle)
  self.v_uiobjects.ToggleNightNotification:SetActive(is_enable_all_notification_toggle and is_enable_notice_notification_toggle and SDKManager:is_korea_user())
end

function ui:close()
  local function confirm_callback()
    BattleSettingMgr:save_local_setting_info()
    
    if not Global.gamemode:gmode_is_login() then
      BattleSettingMgr:save_online_setting_info()
    else
      BattleSettingMgr:set_is_login_saved(true)
    end
    if SDKManager:is_support_key_mouse() then
      if not Global.gamemode:gmode_is_login() then
        BattleSettingMgr:save_keyboard_setting()
      end
      local is_valid, btn_list = self:has_invalid_keycode()
      if is_valid then
        self:ui_hide()
      else
        UIMgr:get_ui("ui_custom_button_tip"):ui_show(btn_list)
      end
    else
      self:ui_hide()
    end
  end
  
  local function cancel_callback()
    BattleSettingMgr:reset_local_setting_info()
    if not Global.gamemode:gmode_is_login() then
      BattleSettingMgr:reset_setting_info()
    end
    self:refresh_view()
    self:ui_hide()
  end
  
  if self:get_change_state() then
    Util.show_notify_popup_message(confirm_callback, "是否保存修改", nil, nil, nil, cancel_callback, nil, nil)
  elseif SDKManager:is_support_key_mouse() then
    local is_valid, btn_list = self:has_invalid_keycode()
    if is_valid then
      self:ui_hide()
    else
      UIMgr:get_ui("ui_custom_button_tip"):ui_show(btn_list)
    end
  else
    self:ui_hide()
  end
end

local CSProviderType = CS.hive.AuthV4.ProviderType
local idp_type_to_button = {
  [CSProviderType.GOOGLE] = "Google_btn",
  [CSProviderType.FACEBOOK] = "Facebook_btn",
  [CSProviderType.SIGNIN_APPLE] = "Apple_btn",
  [CSProviderType.GOOGLE_PLAY_GAMES] = "GooglePlayGames_btn"
}

function ui:init_account_page()
  local v_uicompents = self.v_uicompents
  self:set_button_listener(v_uicompents.BtnCsCode_btn, function()
    CS.GoogleDeviceUtilities.CopyToClipboard(SDKManager:get_sdk_account())
    Util.show_message_tip("复制成功")
  end)
  self:set_button_listener(v_uicompents.BtnUID_btn, function()
    CS.GoogleDeviceUtilities.CopyToClipboard(Global.player_uuid)
    Util.show_message_tip("复制成功")
  end)
  self:set_button_listener(v_uicompents.BtnTermsOfService_btn, function()
    SDKManager:open_privacy_policy()
  end)
  self.v_uiobjects.BtnExchange:SetActiveEx(not IS_STAGING)
  self:set_button_listener(v_uicompents.BtnExchange_btn, function()
    SDKManager:open_exchange_code()
  end)
  self:set_button_listener(v_uicompents.BtnFeedback_btn, function()
    SDKManager:open_help_center()
  end)
  self:set_button_listener(v_uicompents.BtnCommunity_btn, function()
    SDKManager:open_community()
  end)
  self:set_button_listener(v_uicompents.BtnLogout_btn, function()
    PlayerMgr:logout()
  end)
  self:set_button_listener(v_uicompents.BtnDeleteAccount_btn, function()
    SDKManager:show_delete_account_popup()
  end)
  for idp_type, button_name in pairs(idp_type_to_button) do
    self:set_button_listener(v_uicompents[button_name], function()
      SDKManager:connect_idp(idp_type, function()
        self:refresh_account_page()
      end)
    end)
  end
  self:refresh_account_page()
end

function ui:refresh_account_page()
  if not SDKManager:is_enable_account_setting() then
    self.v_uiobjects[Sub_Toggle_List[Page_Tag.Account]]:SetActive(false)
  end
  local v_uicompents = self.v_uicompents
  v_uicompents.CsCodeId_txt.text = SDKManager:get_sdk_account()
  v_uicompents.UId_txt.text = Global.player_uuid
  v_uicompents.VersionId_txt.text = Util.get_version_str()
  for idp_type, button_name in pairs(idp_type_to_button) do
    local connected_gameobj = Util.get_child_gameobj("BgLinkComplete_", self.v_uicompents[button_name].gameObject)
    connected_gameobj:SetActive(SDKManager:is_idp_connected(idp_type))
  end
  self.v_uiobjects.Guest:SetActive(SDKManager:is_guest_account())
  self.v_uiobjects.GooglePlayGames:SetActive(UNITY_ANDROID)
end

function ui:init_gpg_page()
  local function btn_callback(btn_name, btn_key)
    local key_code = BattleSettingMgr:get_gpg_custom_button(btn_key)
    
    local key_name = BattleSettingMgr:keycode_to_string(key_code)
    UIMgr:get_ui("ui_input_listener"):ui_show(btn_name, key_name)
    local bg_set = Util.get_child_gameobj("BgSet", self.v_uiobjects[btn_name])
    bg_set:SetActiveEx(true)
  end
  
  local v_uicompents = self.v_uicompents
  for btn_name, t in pairs(Setting_Cfg.BTNNAME_INFO) do
    local key = t.key
    self:set_button_listener(v_uicompents[btn_name .. "_btn"], function()
      btn_callback(btn_name, key)
    end)
  end
  self:refresh_gpg_page(false)
end

function ui:refresh_gpg_page(is_refresh)
  self.v_is_refresh = is_refresh
  local local_setting_info = BattleSettingMgr:get_local_setting_info()
  local value = 1 == local_setting_info.gpg_button_show
  self.v_on_obj_list[Single_Toggle_Type.GPGButtonShow]:SetActiveEx(value)
  self.v_off_obj_list[Single_Toggle_Type.GPGButtonShow]:SetActiveEx(not value)
  self.v_uicompents.GPGButtonShow_tog.isOn = value
  for btn_name, t in pairs(Setting_Cfg.BTNNAME_INFO) do
    local btn_key = t.key
    local key_code = BattleSettingMgr:get_gpg_custom_button(btn_key)
    local is_mouse_key = Setting_Cfg.MOUSE_KEYCODE[key_code] ~= nil
    local touchicon_img = Util.get_image("PCTouch/TouchIcon", self.v_uiobjects[btn_name])
    local touchBg = Util.get_child_gameobj("PCTouch/TouchBg", self.v_uiobjects[btn_name])
    touchicon_img.gameObject:SetActiveEx(is_mouse_key)
    touchBg:SetActiveEx(not is_mouse_key)
    if is_mouse_key then
      ResMgr:load_set_icon(touchicon_img, Setting_Cfg.MOUSE_KEYCODE[key_code])
    else
      local btn_txt = Util.get_text("PCTouch/TouchBg/TouchTextDown", self.v_uiobjects[btn_name])
      btn_txt.text = 0 == key_code and "----" or BattleSettingMgr:keycode_to_string(key_code)
    end
  end
  self.v_is_refresh = true
end

function ui:_response_custom_key_setting(msg)
  local key_code = msg.mm_x
  local modify_btn_name = msg.mm_y
  BattleSettingMgr:set_gpg_custom_button(Setting_Cfg.BTNNAME_INFO[modify_btn_name].key, key_code)
  for btn_name, t in pairs(Setting_Cfg.BTNNAME_INFO) do
    local btn_key = t.key
    if modify_btn_name == btn_name then
    else
      local old_key_code = BattleSettingMgr:get_gpg_custom_button(btn_key)
      if key_code == old_key_code then
        BattleSettingMgr:set_gpg_custom_button(Setting_Cfg.BTNNAME_INFO[btn_name].key, 0)
      end
    end
  end
  local bg_set = Util.get_child_gameobj("BgSet", self.v_uiobjects[modify_btn_name])
  bg_set:SetActiveEx(false)
  self:refresh_gpg_page(true)
  self:set_change_state()
end

function ui:_response_ui_input_listener_hide(msg)
  local bg_set = Util.get_child_gameobj("BgSet", self.v_uiobjects[msg.mm_x])
  bg_set:SetActiveEx(false)
end

function ui:has_invalid_keycode()
  local is_valid = true
  local invalid_btn_list = {}
  for btn_name, t in pairs(Setting_Cfg.BTNNAME_INFO) do
    local btn_key = t.key
    local old_key_code = BattleSettingMgr:get_gpg_custom_button(btn_key)
    if 0 == old_key_code then
      is_valid = false
      table.insert(invalid_btn_list, btn_name)
    end
  end
  return is_valid, invalid_btn_list
end

local RESOLUTION_MODE_DESC = {
  [0] = "全屏",
  [1] = "窗口",
  [2] = "无边框"
}

function ui:refresh_resolution_panle(visible)
  if UNITY_STANDALONE_WIN then
    self.v_uiobjects.ResolutionLow:SetActive(false)
    self.v_uiobjects.ResolutionMid:SetActive(false)
    self.v_uiobjects.ResolutionHigh:SetActive(false)
    self.v_uiobjects.ResolutionVeryHigh:SetActive(false)
    self.v_uiobjects.SetQualityForWin:SetActive(true)
    self.v_uiobjects.FrameLow:SetActive(false)
    self.v_uiobjects.FrameNormal:SetActive(false)
    self.v_uiobjects.FrameNormalWin1:SetActive(true)
    self.v_uiobjects.FrameNormalWin2:SetActive(true)
    self.v_uiobjects.FrameNormalWin3:SetActive(true)
    if visible then
      self.v_uiobjects.ResContentWin:SetActive(true)
      self.v_uiobjects.ResArrowWin:SetActive(true)
    else
      self.v_uiobjects.ResContentWin:SetActive(false)
      self.v_uiobjects.ResArrowWin:SetActive(false)
    end
    local resolution_list = Global.render_mgr:get_resolution_by_windowssetting()
    local select_index = Global.render_mgr:get_resolution_use_index()
    local cur_data = resolution_list[select_index]
    self.v_uicompents.ResNowWin_txt.text = string.format("%sX%s %s", cur_data.width, cur_data.height, RESOLUTION_MODE_DESC[cur_data.mode])
    if resolution_list and next(resolution_list) then
      self:give_back_auto_cache(resolution_set_key)
      for i = #resolution_list, 1, -1 do
        local reso_data = resolution_list[i]
        local item_obj = self:get_auto_cache(resolution_set_key)
        local select = self:get_child_gameobj("Select", item_obj)
        select:SetActive(select_index == i)
        local name = self:get_text("Name", item_obj)
        name.text = string.format("%sX%s %s", reso_data.width, reso_data.height, RESOLUTION_MODE_DESC[reso_data.mode])
        local btn = self:get_button(nil, item_obj)
        self:set_button_listener(btn, function()
          self.v_uiobjects.ResContentWin:SetActive(false)
          self.v_uiobjects.ResArrowWin:SetActive(false)
          self.v_uicompents.ResNowWin_txt.text = string.format("%sX%s %s", reso_data.width, reso_data.height, RESOLUTION_MODE_DESC[reso_data.mode])
          if i == select_index then
            return
          end
          Global.render_mgr:set_resolution_by_windowssetting(reso_data.width, reso_data.height, reso_data.mode)
        end)
      end
    end
  else
    self.v_uiobjects.ResolutionLow:SetActive(true)
    self.v_uiobjects.ResolutionMid:SetActive(true)
    self.v_uiobjects.ResolutionHigh:SetActive(true)
    self.v_uiobjects.ResolutionVeryHigh:SetActive(true)
    self.v_uiobjects.SetQualityForWin:SetActive(false)
    self.v_uiobjects.FrameLow:SetActive(true)
    self.v_uiobjects.FrameNormal:SetActive(true)
    self.v_uiobjects.FrameNormalWin1:SetActive(false)
    self.v_uiobjects.FrameNormalWin2:SetActive(false)
    self.v_uiobjects.FrameNormalWin3:SetActive(false)
  end
end

return ui
