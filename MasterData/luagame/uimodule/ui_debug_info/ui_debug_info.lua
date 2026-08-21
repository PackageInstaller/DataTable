local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local LocalStorage = require("utils.localstorage")
local PathDefine = require("utils.path_define")
local CSUnityEngine = UnityEngine
local UnityCamera = typeof(UnityEngine.Camera)
local CSGameMgr = CS.Game.GameMgr
local Account = require("gamelogic.account.account")
local sampleTime = 1
local is_cull_ui = false
local BIND_TYPE = Config.BIND_TYPE
local TEMPLATEKEY = "DEBUGINFOTEXT"

function ui:ui_finish_load()
  if GAME_DEBUG then
    Global.is_open_writer_log = true
    self:save_int_writer_log()
  end
  self.v_text_frame = self:get_uiobject("Text_Frame_Rate", BIND_TYPE.TEXT)
  self.v_text_ram = self:get_uiobject("Text_RAM_Usage", BIND_TYPE.TEXT)
  self.v_text_server = self:get_uiobject("Text_Server_Info", BIND_TYPE.TEXT)
  self.v_text_android_power = self:get_uiobject("Text_Android_Power", BIND_TYPE.TEXT)
  if not UNITY_ANDROID then
    self.v_text_android_power.gameObject:SetActive(false)
  end
  self.v_debug_root = self:get_uiobject("DebugListRoot", BIND_TYPE.OBJECT)
  self.v_debug_item = self:get_uiobject("ValueTemp", BIND_TYPE.OBJECT)
  self.v_frame_count = 0
  self.v_timer = 0
  self:set_button("CallOutBtn", function()
    if PUBLISH_GM then
      self.v_uiobjects.TopPanel_Abroad:SetActive(true)
    else
      self.v_uiobjects.TopPanel:SetActive(true)
    end
  end)
  self:set_button("HideTopBtn", function()
    self.v_uiobjects.TopPanel:SetActive(false)
  end)
  self:set_button("HideTopBtn_Abroad", function()
    self.v_uiobjects.TopPanel_Abroad:SetActive(false)
  end)
  self:set_button("SkipPrologue_Abroad", function()
    if PlayerMgr then
      PlayerMgr:skip_newbie()
    end
  end)
  self:set_button("NoSdkLogin", function()
    self:_switch_sdk_login_config()
  end)
  self.v_uiobjects.NoSdkLogin:SetActive(SDKManager:is_enable_no_sdk_login_in_publish_gm())
  self:set_button("GmBtn", function()
    UIMgr:get_ui("uigm"):ui_show()
  end)
  self:set_button("SkillJournalBtn", function()
    UIMgr:get_ui("uiskilljournal"):ui_show()
  end)
  self:set_button("HurtJournalBtn", function()
    UIMgr:get_ui("uihurtjournal"):ui_show()
  end)
  self:set_button("MissileInfoBtn", function()
    UIMgr:get_ui("uidebugmissileinfo"):ui_show()
  end)
  self:set_button("AbnormalJournalBtn", function()
    UIMgr:get_ui("uiabnormaljournal"):ui_show()
  end)
  self:set_button("FightStateJournalBtn", function()
    UIMgr:get_ui("uifightstatejournal"):ui_show()
  end)
  self:set_button("FightDebugBtn", function()
    if Util.is_client_only() then
      UIMgr:get_ui("uifightdebug"):ui_show()
    end
  end)
  self:set_button("DebugSettingBtn", function()
    UIMgr:get_ui("uidebug_mode_setting"):ui_show()
  end)
  self:set_button("DebugMsgBtn", function()
    self:_switch_sdk_login_config()
  end)
  self:set_button("DebugScene", function()
    UIMgr:get_ui("uigm_scene"):ui_show()
  end)
  self:set_button("DebugSkill", function()
    UIMgr:get_ui("uidebug_skill"):ui_show()
  end)
  self:set_button("WriterLog", function()
    self:click_writer_log_btn()
  end)
  self:set_button("WriterLog_Abroad", function()
    self:click_writer_log_btn()
  end)
  self:set_button("UploadLog_Abroad", function()
    Log.upload_log()
  end)
  self:set_button("UploadLog_Inner", function()
    Log.upload_log()
  end)
  self:set_button("WriteRpcLog", function()
    self:click_rpc_log_btn()
  end)
  self:set_button("OpenTimerTopBtn", function()
    self:click_open_timer_btn()
  end)
  self:set_button("TrackLogBtn", function()
    self:_switch_enable_track()
  end)
  self:set_button("ShowCornerBtn", function()
    self:_switch_enable_corner_ui()
  end)
  self:set_button("ShowUIBtn_Abroad", function()
    self:_switch_enable_screen_ui()
  end)
  self:register_exist_auto_template(TEMPLATEKEY, self.v_debug_item, self.v_debug_root)
  self.debug_info = {}
  self.v_uiobjects.TopPanel:SetActive(false)
  self.v_uiobjects.TopPanel_Abroad:SetActive(false)
  self:update_btn_text()
  self:update_rpc_log_btn_text()
  self:_refresh_sdk_login_state()
  self:_refresh_timer_btn_state()
  self:_refresh_track_text()
  if PUBLISH_GM then
    LocalStorage:save_int("_ENABLE_CORNER_UI", 0)
  end
  self:_refresh_enable_corner_ui_text()
end

function ui:_switch_sdk_login_config()
  local is_use_sdk_login = LocalStorage:is_use_sdk_login()
  LocalStorage:save_int("_MINGZHOU_IS_USE_SDK_", is_use_sdk_login and 0 or 1)
  self:_refresh_sdk_login_state()
end

function ui:_refresh_sdk_login_state()
  if UNITY_EDITOR then
    return
  end
  local is_use_sdk_login = LocalStorage:is_use_sdk_login()
  local btn_txt = is_use_sdk_login and "No SDK Login" or "SDK Login"
  local text1 = Util.get_text("Text", self.v_uiobjects.DebugMsgBtn)
  local text2 = Util.get_text("Text", self.v_uiobjects.NoSdkLogin)
  text1.text = btn_txt
  text2.text = btn_txt
  SDKManager:set_is_use_sdk(is_use_sdk_login)
  local login_ui = UIMgr:try_get_visible_ui("uilogin")
  if login_ui then
    login_ui:refresh_use_sdk_login_state()
  end
end

function ui:_switch_enable_track()
  local v = LocalStorage:load_int("_ENABLE_TRACK", 1)
  v = Util.is_true(v) and 0 or 1
  LocalStorage:save_int("_ENABLE_TRACK", v)
  self:_refresh_track_text()
  SDKTrack:enable_td_analytics_log(Util.is_true(v))
end

function ui:_refresh_track_text()
  local v = LocalStorage:load_int("_ENABLE_TRACK", 1)
  local btn_txt = Util.is_true(v) and "关闭打点" or "开启打点"
  local text = Util.get_text("Text", self.v_uiobjects.TrackLogBtn)
  text.text = btn_txt
end

function ui:ui_on_show()
  self:show_server_info()
  self:register_event()
end

function ui:ui_on_hide()
end

function ui:register_event()
  self:bind_auto_mq(Const.MSG_ON_SHOW_UI, self.show_server_info, self)
  self:bind_auto_mq(Const.MSG_SELECT_SERVER, self.show_server_info, self)
end

function ui:show_server_info()
  local connect_info = Global.connect_info or ServerList:get_default_server()
  local str = ""
  if connect_info then
    str = string.format("服务器：%s服，UUID：%s", Util.get_subfix(connect_info.IP), Global.player_uuid)
  end
  self.v_text_server_str = str
end

function ui:ui_on_update(delta_time)
  self.v_timer = self.v_timer + delta_time
  self.v_frame_count = self.v_frame_count + 1
  if self.v_timer >= sampleTime then
    local ram_usage_kb = collectgarbage("count")
    if ram_usage_kb > 10240 then
      self.v_text_ram.text = string.format("%.1fMB", ram_usage_kb / 1024)
      self.v_max_lua_mem_mb = math.floor(math.max(self.v_max_lua_mem_mb or 0, ram_usage_kb / 1024))
    else
      self.v_text_ram.text = string.format("%.1fKB", ram_usage_kb)
    end
    self.v_text_frame.text = string.format("%.1fFPS", self.v_frame_count / self.v_timer)
    self.v_timer = 0
    self.v_frame_count = 0
    local date = Date.get_server_time_date()
    self.v_text_server.text = string.format("%s  %s/%s %02d:%02d:%02d", self.v_text_server_str, date.month, date.day, date.hour, date.min, date.sec) .. "  " .. CSGameMgr.CurResolutionWidth .. "x" .. CSGameMgr.CurResolutionHeight .. "  深度图: " .. tostring(CSGameMgr.GetDepthTexState())
    if UNITY_ANDROID and not UNITY_EDITOR then
      local power = CS.Game.PowerStats.power
      local power_str = string.format("%s: %.1fw", "功耗", power)
      self.v_text_android_power.text = power_str
      if Global.enable_log_power then
        Log.Info(power_str)
      end
    end
  end
  self:show_debug_value()
end

local function _set_str(go, key, value)
  local k = Util.get_text("k", go)
  local v = Util.get_text("v", go)
  k.text = key
  v.text = value
end

function ui:show_debug_value()
  self:give_back_auto_cache(TEMPLATEKEY)
  local i = 1
  for k, v in pairs(self.debug_info) do
    local item = self:get_auto_cache(TEMPLATEKEY)
    _set_str(item, k, v)
    i = i + 1
  end
end

function ui:click_writer_log_btn()
  Global.is_open_writer_log = not Global.is_open_writer_log
  self:save_int_writer_log()
end

function ui:click_rpc_log_btn()
  Global.is_open_rpc_log = not Global.is_open_rpc_log
  local idx = Global.is_open_rpc_log and 1 or 0
  LocalStorage:save_int(Config.WRITE_RPC_LOG_KEY, idx)
  self:update_rpc_log_btn_text()
end

function ui:click_open_timer_btn()
  if Util.is_client_only() then
    return
  end
  Global.is_open_timer = not Global.is_open_timer
  self:_refresh_timer_btn_state()
  if Global.is_open_timer then
    if TowerMgr and TowerMgr:get_tower() then
      TowerMgr:open_behavior_timer()
    end
  else
    JournalMgr:oepn_record_jiournal_info(false)
  end
end

function ui:_refresh_timer_btn_state()
  local btn_txt = Global.is_open_timer and "关闭计时" or "开启计时"
  local text = Util.get_text("Text", self.v_uiobjects.OpenTimerTopBtn)
  text.text = btn_txt
end

function ui:update_btn_text()
  local btn_txt, btn_obj
  if PUBLISH_GM then
    btn_txt = Global.is_open_writer_log and "Disable log writing" or "Enable log writing"
    btn_obj = self.v_uiobjects.WriterLog_Abroad
  else
    btn_txt = Global.is_open_writer_log and "关闭Log写入" or "开启Log写入"
    btn_obj = self.v_uiobjects.WriterLog
  end
  local text = Util.get_text("Text", btn_obj)
  text.text = btn_txt
end

function ui:update_rpc_log_btn_text()
  local btn_txt = Global.is_open_rpc_log and "关闭关卡Rpc Log写入" or "开启关卡Rpc Log写入"
  local text = Util.get_text("Text", self.v_uiobjects.WriteRpcLog)
  text.text = btn_txt
end

function ui:save_int_writer_log()
  local idx = Global.is_open_writer_log and 1 or 0
  LocalStorage:save_int(Config.WRITER_LOG_KEY, idx)
  self:update_btn_text()
  Log.check_filter()
end

function ui:_switch_enable_corner_ui()
  local v = LocalStorage:load_int("_ENABLE_CORNER_UI", 1)
  v = Util.is_true(v) and 0 or 1
  LocalStorage:save_int("_ENABLE_CORNER_UI", v)
  self:_refresh_enable_corner_ui_text()
end

function ui:_switch_enable_screen_ui()
  is_cull_ui = not is_cull_ui
  local ui_camera = Util.get_component(nil, UIMgr.root_camera_obj, UnityCamera)
  local mask = is_cull_ui and UnityEngine.LayerMask.GetMask("UI3D") or UnityEngine.LayerMask.GetMask("UI", "UI3D")
  ui_camera.cullingMask = mask
end

function ui:_refresh_enable_corner_ui_text()
  local v = LocalStorage:load_int("_ENABLE_CORNER_UI", 1)
  local btn_txt = Util.is_true(v) and "隐藏左下角调试UI" or "显示左下角调试UI"
  local text = Util.get_text("Text", self.v_uiobjects.ShowCornerBtn)
  text.text = btn_txt
  self.v_uiobjects.BtnPanel:SetActive(Util.is_true(v))
end

function ui:upload_log()
end

function ui:start_record_performance()
  if GAME_DEBUG and not Util.is_client_only() and not PUBLISH_GM then
    self.v_performance_monitor_go = ResMgr:create_emptygameobj("PerformanceMonitor", true)
    self.v_performance_monitor_go:AddComponent(typeof(CS.Game.PerformanceMonitor))
    local tower = TowerMgr and TowerMgr:get_tower()
    if not tower then
      return
    end
    local tower_id = tower:get_tower_id()
    local floor_id = tower:get_floor_num()
    local room_id = tower:get_room_num()
    self.v_tower_info_content = string.format("\"TowerID\":%s,\"FloorID\":%s,\"RoomID\":%s", tower_id, floor_id, room_id)
    self.v_max_lua_mem_mb = 0
  end
end

local QualityCfg = require("manager.render.quality_cfg")

function ui:end_record_performance()
  if not self.v_performance_monitor_go or not GAME_DEBUG then
    return
  end
  local monitor = self.v_performance_monitor_go:GetComponent(typeof(CS.Game.PerformanceMonitor))
  local content = monitor:PrintResults()
  if Util.is_empty(content) then
    return
  end
  local platform = (not UNITY_EDITOR or not "editor") and (not UNITY_ANDROID or not "android") and UNITY_IOS and "ios"
  local gpu_name = CSUnityEngine.SystemInfo.graphicsDeviceName
  local recommand_quality = Global.render_mgr:try_get_quality_level_from_config() or QualityCfg.QUALITY.VERY_HIGH
  local resolution_width, resolution_height = Global.render_mgr:get_cur_resolution()
  local cur_scene_name = SceneMgr and SceneMgr:get_scene_name()
  local uuid = Global.player_uuid
  local camera_type = BattleSettingMgr:get_camera_view_type()
  local device_model = CSUnityEngine.SystemInfo.deviceModel
  local team_data = self:get_hero_list_str()
  content = string.format("%s\"Platform\":\"%s\",\"GPU\":\"%s\",\"ResolutionWidth\":%s,\"ResolutionHeight\":%s,\"RecommandQuality\":%s,\"CurScene\":\"%s\",%s,\"MaxLuaMemMB\":%s,\"UUID\":\"%s\",\"CameraType\":%s,\"DeviceModel\":\"%s\",\"TeamData\":\"%s\"", content, platform, gpu_name, resolution_width, resolution_height, recommand_quality, cur_scene_name, self.v_tower_info_content, self.v_max_lua_mem_mb or 0, uuid, camera_type, device_model, team_data)
  local json_content = string.format("{%s}", content)
  CSHelper.PostJson(string.format("http://172.16.60.49:9200/%s/_doc?pipeline=add_timestamp_pipeline", platform), json_content, "elastic", "mz2022!")
  if self.v_performance_monitor_go then
    ResMgr:destroy_gameobj(self.v_performance_monitor_go)
    self.v_performance_monitor_go = nil
  end
end

function ui:get_hero_list_str()
  local str = ""
  local list = SceneMgr and SceneMgr:get_hero_list()
  if not list then
    return str
  end
  for _, hero in pairs(list) do
    local id = hero.buddy_cfg.Id
    str = string.format("%s_%s", str, id)
  end
  return str
end

return ui
