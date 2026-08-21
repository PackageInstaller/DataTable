local M = Util.create_class()
local screen = UnityEngine.Screen
M.standard_width = 1920
M.standard_height = 1080
M.standard_screen = M.standard_width / M.standard_height
M.curr_Screen = screen.width / screen.height
local SETTING = Config.SETTING
local CSGameMgr = CS.Game.GameMgr
local QualityCfg = require("manager.render.quality_cfg")

function M:_init()
end

function M:get_normal_form_match()
  if self.curr_Screen > self.standard_screen then
    return 1
  end
  return 0
end

function M:get_full_form_match()
  return 1
end

function M:get_loading_form_match()
  if self.curr_Screen > self.standard_screen then
    return 0
  end
  return self.standard_screen - self.curr_Screen
end

function M:get_fight_ui_match()
  if self.curr_Screen > self.standard_screen then
    return 1
  end
  return 0
end

function M:get_screen_width()
  return screen.width
end

function M:get_screen_height()
  return screen.height
end

function M:get_max_resolution_height()
  if SDKManager:is_tablet() and not SDKManager:is_simulator() then
    return SETTING.MAX_RESOLUTION_HEIGHT
  end
  if UNITY_IOS and Global.render_mgr:is_low_memory_device() then
    return SETTING.MAX_LOW_MEMORY_DEVICE_RESOLUTION_HEIGHT
  end
  if UNITY_IOS or UNITY_ANDROID and not SDKManager:is_simulator() then
    return SETTING.MAX_MOBILE_RESOLUTION_HEIGHT
  end
  return self:get_screen_height()
end

function M:set_graphic_resolution(resolution_level)
  local local_resolution = BattleSettingMgr and BattleSettingMgr:get_resolution()
  local down_rate = QualityCfg.RESOLUTION.MIDDLE
  if resolution_level == SETTING.RESOLUTION.LOW then
    down_rate = QualityCfg.RESOLUTION.LOW
  elseif resolution_level == SETTING.RESOLUTION.MIDDLE then
    down_rate = QualityCfg.RESOLUTION.MIDDLE
  elseif resolution_level == SETTING.RESOLUTION.HIGH then
    down_rate = QualityCfg.RESOLUTION.HIGH
  elseif resolution_level == SETTING.RESOLUTION.VERY_HIGH then
    down_rate = QualityCfg.RESOLUTION.VERY_HIGH
  end
  local_resolution = local_resolution or QualityCfg.RESOLUTION.HIGH
  local max_height = self:get_max_resolution_height()
  local screen_width, screen_height = UnityEngine.Screen.width, UnityEngine.Screen.height
  local height = math.floor(math.min(screen_height, max_height) / down_rate)
  local org_down_rate = screen_height / height
  local width = math.floor(screen_width / org_down_rate)
  CSGameMgr.SetCurResolution(width, height, resolution_level or 0)
  self.v_cur_resolution_width = width
  self.v_cur_resolution_height = height
  if local_resolution ~= height then
    local msg = MsgGame:mq_publish2(Const.MSG_RESOLUTION_CHANGE)
    msg.mm_x = height
  end
  Log.Info("set_graphic_resolution", height, width)
end

function M:set_graphic_resolution_for_pc(width, height)
  CSGameMgr.SetCurResolution(width, height, 4)
  self.v_cur_resolution_width = width
  self.v_cur_resolution_height = height
  Global.screen_width = self.v_cur_resolution_width
  Global.screen_height = self.v_cur_resolution_height
  Global.screen_factor = math.max(Global.screen_width / 1920, Global.screen_height / 1080)
  Global.screen_ratio = Global.screen_width / Global.screen_height
  local target_ui = UIMgr:try_get_visible_ui("uimain")
  if target_ui then
    target_ui:bind_uimain_to_signboard_view()
  end
end

function M:get_cur_graphic_resolution()
  return self.v_cur_resolution_width, self.v_cur_resolution_height
end

return M
