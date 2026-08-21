local Base = require("ui.uibase")
local Account = require("gamelogic.account.account")
local GameLogin = require("gamelogic.login.game_login")
local Json = require("utils.json")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local UnityWebRequest = UnityEngine.Networking.UnityWebRequest
local SPINE_RT_VIEW = require("ui.model_rt_view.spine_rt_view")
local SpineHelper = require("ui.model_rt_view.spine_helper")
local spine_id = ShareRes.get_comm_value("LoginWinSpineId")
local is_notice_opened = false
local CommonDef = require("cs_share.common_define")
local CSSDKManager = CS.Game.TSISDKManager

function ui:ui_finish_load()
  self.v_uiobjects.BtnRepair:SetActive(true)
  self:set_button("LoginBtn", function()
    self:_on_click_login_btn()
  end)
  self:set_button("ComLogo", function()
    self:switch_mac_address()
  end)
  self:set_button("BtnRepair", function()
    Global.repair_game:on_start()
  end)
  self:set_button("BtnClientOnly", function()
    DebugSetting:set_client_only(true)
    Global.gamemode:gmode_set_mode(Const.MODE_LOGIN)
  end)
  self:set_button("BtnStartSetting", function()
    UIMgr:get_ui("uidebug_mode_setting"):ui_show()
  end)
  self:set_button("BtnChangeServer", function()
    UIMgr:get_ui("ui_server_list"):ui_show()
  end)
  self:set_button("BtnChooseServer", function()
    self:_on_click_choose_server_Btn()
  end)
  self:set_button("BtnNotice", function()
    self:open_notice_ui()
  end)
  self:set_button("BtnfeedBack", function()
    self:_onclick_feedback_btn()
  end)
  self.v_uiobjects.BtnfeedBack:SetActive(SDKManager:is_enable_feedback_in_login())
  self.v_uiobjects.BtnCode:SetActive(UNITY_STANDALONE_WIN and SDKManager:is_enable_qrcode_login() and SDKManager:is_use_sdk())
  self:set_button_listener(self.v_uicompents.BtnCode_btn, function()
    SDKManager:login()
  end)
  self:init_account_input()
  self.v_uiobjects.Info_Player:SetActive(false)
  self.v_player_id_txt = self:get_uiobject("Info_PlayerId", BIND_TYPE.TEXT)
  self.v_uiobjects.Info_Server:SetActive(false)
  self.v_server_name_text = self.v_uicompents.Info_ServerId_txt
  self.v_server_name_text_1 = self.v_uicompents.ServerId_txt
  local Version = Util.get_i18n("版本") .. " " .. Util.get_version_str()
  self.v_uicompents.EditionID_txt.text = Version
  self.v_uiobjects.MacInput:SetActiveEx(false)
  Log.Info("login view finish load -------------")
  SDKManager:track_adjust_event("05_titlescreen")
end

function ui:init_account_input()
  local components = self.v_uicompents
  self:set_button("Button_LogOut", function()
    self:_onclick_out_btn()
  end)
  self.v_uiobjects.Button_LogOut:SetActive(not SDKManager:is_use_sdk() or not SDKManager:is_auto_login_game_after_login_sdk())
  self:set_button("BtnLogin", function()
    local account = components.SetId_txt.text
    if not account or "" == account then
      Util.show_message_tip(2202)
      return
    end
    Account:set_tourist_account(account)
    self:_refresh_player_id_txt()
    self.v_uiobjects.LoginPopup:SetActive(false)
  end)
  self:set_button("BtnSetServer", function()
    self.v_uiobjects.LoginPopup:SetActive(false)
    self.v_server_name_text.text = self.v_server_name_text_1.text
    self.v_uiobjects.Info_Server:SetActive(true)
    if not SDKManager:is_use_sdk() then
      local account = Account:get_account()
      if not account then
        self.v_uiobjects.LoginPopup:SetActive(true)
        self.v_uiobjects.SetPlayerId:SetActive(true)
      end
    end
  end)
  self:set_button("CloseBtn", function()
    self.v_uiobjects.LoginPopup:SetActive(false)
  end)
  self:set_button("BtnRightAge", function()
    UIMgr:get_ui("right_age_tips"):ui_show()
  end)
  self:set_button("BtnSetting", function()
    UIMgr:get_ui("battle_setting"):ui_show()
  end)
end

function ui:ui_on_show(callback)
  SDKManager:enter_login()
  local is_assetbundle_and_hotupdate = Game_AssetBundle and GAME_HOTUPDATE
  if not is_assetbundle_and_hotupdate then
    local has_show = CS.Game.Service.Instance:GetEnterGameFlag()
    if not has_show then
      UIMgr:get_ui("uiloginlogo"):ui_show()
    end
  end
  local is_editor_or_debug = UNITY_EDITOR or GAME_DEBUG
  self.v_uiobjects.BtnClientOnly:SetActive(is_editor_or_debug and not PUBLISH_GM)
  self.v_uiobjects.BtnStartSetting:SetActive(is_editor_or_debug and not PUBLISH_GM)
  self.v_uiobjects.BtnChooseServer:SetActive(SDKManager:is_enable_select_server())
  if SDKType == Config.SDK_TYPE.HIVE_SDK then
    self.v_uiobjects.BtnRepair:SetActive(false)
  end
  self.v_callback = callback
  self:bind_auto_mq(Const.MSG_SELECT_SERVER, self._on_select_server, self)
  self:_update_server_name(self:_get_default_idx())
  self:_refresh_player_id_txt()
  if not account and not SDKManager:is_use_sdk() then
    self.v_uiobjects.LoginPopup:SetActive(true)
    self.v_uiobjects.SetServer:SetActive(true)
    self.v_uiobjects.SetPlayerId:SetActive(false)
  end
  if Global.sound_mgr then
    Global.sound_mgr:scene_switch_stop_sound()
    Global.sound_mgr:play_login_bgm()
  end
  ScreenMaskMgr:force_close()
  self:bind_auto_mq(Const.MSG_ON_SDK_LOGOUT, self._handle_sdk_logout, self)
  self:bind_auto_mq(Const.MSG_ON_SDK_LOGIN, self._handle_sdk_login, self)
  self:bind_auto_mq(Const.MSG_LOGIN_FINISHED, self._handle_login_finished, self)
  self:bind_auto_mq(Const.MSG_LOGIN_FAILED, self._handle_login_failed, self)
  self.v_uiobjects.Title_BB:SetActive(true)
  self.v_uiobjects.Title_LingBo:SetActive(false)
  self:_add_open_notice_timer()
  if UIMgr then
    UIMgr:open_default_ui(false)
  end
  self:update_spine()
  self:_download_server_list()
  self:check_download()
end

function ui:check_download()
  CS.VoiceCheckManager.Instance:Refresh()
  if SDKType == Config.SDK_TYPE.HIVE_SDK and Game_AssetBundle then
    DownloadMgr:download_other_res()
  end
end

function ui:_handle_sdk_logout()
  self:_refresh_player_id_txt()
end

function ui:_handle_sdk_login()
  self:_refresh_player_id_txt()
  if SDKManager:is_auto_login_game_after_login_sdk() then
    self:_on_click_login_btn()
  end
end

function ui:_handle_login_finished()
end

function ui:_handle_login_failed()
end

function ui:_refresh_player_id_txt()
  if SDKManager:is_use_sdk() and (not SDKManager:is_enable_player_id_txt_in_login() or not SDKManager:had_sdk_login()) then
    self.v_uiobjects.Info_Player:SetActiveEx(false)
  else
    local account = Account:get_account()
    self.v_player_id_txt.text = account
    self.v_uiobjects.Info_Player:SetActiveEx(not Util.is_empty(account))
  end
end

function ui:_on_click_choose_server_Btn()
  self.v_uiobjects.LoginPopup:SetActive(true)
  self.v_uiobjects.SetServer:SetActive(true)
  self.v_uiobjects.SetPlayerId:SetActive(false)
end

function ui:show_play_id_ui()
  self.v_uiobjects.LoginPopup:SetActive(true)
  self.v_uiobjects.SetServer:SetActive(false)
  self.v_uiobjects.SetPlayerId:SetActive(true)
end

function ui:_on_click_login_btn()
  local server_info = ServerList:get_default_server()
  if not server_info then
    self:_retry_download_server_list()
    return
  end
  SDKManager:track_adjust_event("07_start_game")
  if SDKManager:is_use_sdk() then
    if SDKManager:had_sdk_login() then
      if self.v_callback then
        self.v_callback()
      end
    else
      SDKManager:login()
    end
  elseif self.v_callback then
    self.v_callback()
  end
end

function ui:_onclick_out_btn()
  if UNITY_STANDALONE_WIN then
    UIMgr:get_ui("ui_player_exit_tip"):ui_show()
  elseif SDKManager:is_use_sdk() then
    SDKManager:logout()
  else
    self:show_logout_popup()
  end
end

function ui:_get_default_idx()
  return ServerList:get_default_server_id()
end

function ui:ui_on_hide()
  if Global.sound_mgr then
    Global.sound_mgr:bgm_stop()
  end
  self.v_callback = nil
  self:remove_feedback_timer()
  self:remove_open_notice_timer()
end

function ui:ui_on_destroy()
  if self.v_spine_rt then
    self.v_spine_rt:on_destroy()
    self.v_spine_rt = nil
  end
end

function ui:_on_select_server(msg)
  local idx = msg.mm_obj
  self:_update_server_name(idx)
end

function ui:_update_server_name(idx)
  local server_list = ServerList:get_server_list()
  if not server_list then
    return
  end
  local info = server_list[idx]
  local name = info.name
  local ip = info.IP
  local txt
  if GAME_RELEASE then
    txt = name
  else
    txt = name .. "(" .. Util.get_subfix(ip) .. ")"
  end
  self.v_server_name_text.text = txt
  self.v_server_name_text_1.text = txt
  self.v_uiobjects.Info_Server:SetActive(true)
end

function ui:_retry_download_server_list()
  Util.hide_notify_popup_message()
  Util.show_notify_popup_message(function()
    self:_download_server_list()
  end, "获取服务器列表失败", nil, "重试", nil, nil, true)
end

local server_list_mask_tag = "server_list_mask"

function ui:_download_server_list()
  if not UNITY_EDITOR and GAME_RELEASE and not PUBLISH_GM then
    ScreenMaskMgr:open_one_tag(server_list_mask_tag, nil, true, 1)
    local url = SDKManager:get_server_list_json_url()
    CSHelper.RequestContent(url, function(content)
      ScreenMaskMgr:close_one_tag(server_list_mask_tag)
      if not content or "" == content then
        Log.Error("request.error：", url)
        self:_retry_download_server_list()
        return
      end
      local data = Json.decode(content)
      if data then
        ServerList:init_server_list_by_net_data(data)
        local msg = MsgGame:mq_publish2(Const.MSG_SELECT_SERVER)
        msg.mm_obj = ServerList:get_default_server_id()
      end
    end)
  end
end

function ui:switch_mac_address()
  local input_obj = self.v_uiobjects.MacInput
  input_obj:SetActiveEx(not input_obj.activeSelf)
  if input_obj.activeSelf and (UNITY_EDITOR or UNITY_ANDROID) then
    local input = self:get_inputfield(nil, input_obj)
    input.text = UnityEngine.SystemInfo.deviceUniqueIdentifier
  end
end

function ui:show_change_account_ui()
  self.v_uiobjects.SetServer:SetActive(false)
  self.v_uiobjects.SetPlayerId:SetActive(true)
end

function ui:open_notice_tips()
  self:_onclick_notice_btn()
end

function ui:_onclick_notice_btn()
  self:check_notice_open_status()
end

function ui:check_notice_open_status()
  if UIMgr:get_notice_opened() then
    Log.Info("notice already opened")
    return
  end
  UIMgr:set_notice_opened()
  self:open_notice_ui()
end

local notice_mask_tag = "notice_mask"

function ui:open_notice_ui()
  ScreenMaskMgr:open_one_tag(notice_mask_tag, nil, true, 1)
  local url = SDKManager:get_notice_url()
  CSHelper.RequestContent(url, function(content)
    ScreenMaskMgr:close_one_tag(notice_mask_tag)
    if not content or "" == content then
      Log.Error("request.error：", url)
    else
      if not Global.gamemode:gmode_is_login() then
        return
      end
      local data = Json.decode(content)
      if data and "" ~= data and #data > 0 then
        UIMgr:get_ui("ui_notice_login"):ui_show(data)
      end
    end
  end)
end

function ui:_onclick_feedback_btn()
  SDKManager:open_help_center()
end

function ui:remove_feedback_timer()
  if self.v_feedback_timer then
    Timer:remove_timer(self.v_feedback_timer)
    self.v_feedback_timer = nil
  end
end

function ui:remove_open_notice_timer()
  if self.v_open_notice_timer then
    Timer:remove_timer(self.v_open_notice_timer)
    self.v_open_notice_timer = nil
  end
end

function ui:_add_open_notice_timer()
  self:remove_open_notice_timer()
  self.v_open_notice_timer = Timer:add_timer("open_notice_timer", 0, function()
    self:open_notice_tips()
    return true
  end)
end

function ui:_get_help_center_unread(success, data)
  if not self.v_uiobjects then
    return
  end
  local red_point = self:get_child_gameobj("RedPoint", self.v_uiobjects.BtnfeedBack)
  if success and data.unread == "1" then
    red_point:SetActiveEx("1" == data.scene)
  else
    red_point:SetActiveEx(false)
  end
end

function ui:update_spine()
  if not spine_id or spine_id <= 0 then
    return
  end
  self.v_spine_rt = self.v_spine_rt or SPINE_RT_VIEW:new(self, self.v_uiobjects.SpinePhoto)
  if self.v_spine_id ~= spine_id then
    self.v_spine_id = spine_id
    SpineHelper.load_char_spine_res(self.v_spine_rt, self.v_spine_id, self.v_uiobjects.SpinePhoto, true)
  else
    self.v_uiobjects.SpinePhoto:SetActive(true)
  end
end

function ui:cache_ui()
  return true
end

function ui:refresh_use_sdk_login_state()
  local is_use_sdk = SDKManager:is_use_sdk()
  if is_use_sdk then
    self.v_uiobjects.BtnCode:SetActive(UNITY_STANDALONE_WIN and SDKManager:is_enable_qrcode_login())
  else
    self.v_uiobjects.BtnCode:SetActive(false)
    self:_on_click_choose_server_Btn()
  end
  self:_refresh_player_id_txt()
end

function ui:show_logout_popup()
  local tip = Util.format_str("是否取消登录")
  local cancel_btn = Util.format_str("取消")
  local sure_btn = Util.format_str("确认")
  
  local function sure_callback()
    self.v_uiobjects.LoginPopup:SetActive(true)
    self.v_uiobjects.SetServer:SetActive(false)
    self.v_uiobjects.SetPlayerId:SetActive(true)
  end
  
  UIMgr:get_ui("uinotice_tips"):ui_show(sure_callback, nil, tip, sure_btn, cancel_btn)
end

return ui
