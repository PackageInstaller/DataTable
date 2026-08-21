local Const = require("const")
local ResMgr = Global.res_mgr
local Util = require("utils.util")
local MsgGame = Global.mq_game
local QualityCfg = require("manager.render.quality_cfg")
local Math = require("base.mathx")
local LocalStorage = require("utils.localstorage")
local RESOLUTION = QualityCfg.RESOLUTION
local SKIP_ORDER_UI = {ui_click_effect = true, ui_debug_info = true}
local COMMON_RETURN_BUTTON_NAME = {
  "BtnReturn",
  "BtnRet1",
  "BtnRetX",
  "BtnRet"
}
local UnityFind = _ENV.UnityFind
local UnityCamera = typeof(UnityEngine.Camera)
local CSUIGaussianBlur = typeof(CS.Game.UIGaussianBlur)
local CSScreen = UnityEngine.Screen
local GraphicRaycaster = typeof(UnityEngine.UI.GraphicRaycaster)
local _clamp = Math.Clamp
local type_cfg = Global.config.UI_VIEW_LEVEL
local SIGNBOARD_PARAM = Global.config.SIGNBOARD_PARAM
local M = Util.create_class()
local _tinsert = table.insert
local _tsort = table.sort
local _tremove = table.remove
M.RESPONCE_ESCAPE_TYPE = {AUTO_CALL = 1, ESCAPE_CUSTOM = 2}
M.FIGHT_UI_NAME = "fight"
M.ScreenSpaceOverlay = 0
M.ScreenSpaceCamera = 1
M.WorldSpace = 2
M.MODEL_VIEW_COUNT = 0
M.cache_ui_canvas_order = 0
M.SPINE_VIEW_COUNT = 0
M.UI_SORT_LIST_LAYER = {}
local BACK_BLUR_TYPE = Global.config.SCENE_BLUR_TYPE
local UI_FIGHT = "fight"
local HIDE_BY_DISTANCE = {
  [UI_FIGHT] = UI_FIGHT,
  uimain = "uimain"
}
local UI_STACK_TYPE = Global.config.UI_STACK_TYPE
local GUIDE_IGNORE_TIPS = {
  ui_guide = "ui_guide",
  uimessagetip = "uimessagetip",
  reconnecting = "reconnecting",
  novice_task = "novice_task",
  point_detail = "point_detail",
  uidynamic_canvas = "uidynamic_canvas",
  gecao_stage_info = "gecao_stage_info",
  uidrawcard = "uidrawcard",
  award_show_panel = "award_show_panel",
  common_battle_tips = "common_battle_tips",
  waiting = "waiting",
  sys_open_tips = "sys_open_tips",
  uinotice_tips = "uinotice_tips"
}
local RENDER_FRAME = QualityCfg.RENDER_FRAME
local DEBUG_UI_STACK = false
local is_notice_opened = false
local init_id = 0

function M:init()
  local easy_touch = ResMgr:load_gameobj(Path.get_res_path("EasyTouch"), nil, true)
  easy_touch.name = "EasyTouch"
  self.v_easy_touch = easy_touch
  local root_camera = ResMgr:load_gameobj(Path.get_res_path(Global.uiconfig.uiroot), nil, true)
  CSHelper.ResetGameObjectLocalAttr(root_camera.gameObject)
  if not Util.is_client_only() then
    root_camera:SetActive(false)
  end
  self.root_camera_obj = root_camera
  self.world_camera_obj = Util.get_child_gameobj("GroupWorld/UI3DCamera", root_camera)
  self.world_camera = self.world_camera_obj:GetComponent(UnityCamera)
  root_camera.name = "UIRootCamera"
  ResMgr:dont_destroy_on_load(root_camera)
  self.default_ui_obj = Util.get_child_gameobj("GroupNormal/DefaultUI", root_camera)
  self.cache_prefab_root = Util.get_child_gameobj("CachePrefab", root_camera).transform
  self.cache_prefab = {}
  self.v_default_ui_state = false
  self.default_ui_camera_obj = Util.get_child_gameobj("DefaultUICamera", root_camera)
  local start_camera = UnityFind("StartCamera")
  if start_camera then
    start_camera.gameObject:SetActive(false)
  end
  self.root_obj = root_camera
  self.v_blur_componet = self.root_obj:GetComponent(CSUIGaussianBlur)
  self.v_blur_source = self.v_blur_componet.RawImage
  self.v_group_roots = {}
  self.v_group_root_transforms = {}
  self.v_asset_bar_list = setmetatable({}, {__mode = "v"})
  self:_create_group_root()
  self.root_camera = root_camera:GetComponent(UnityCamera)
  CS.Game.GameMgr.UICamera = self.root_camera
  self.v_uis = {}
  self.v_dynamic_uis = {}
  self.v_fullscreen_ui = nil
  self.v_main_scene_after_load_ui = nil
  self.v_high_update_uis = {}
  self.v_normal_update_uis = {}
  self.v_loaded_mainui = {}
  self.v_has_fullscreen = false
  self.v_current_fullscreens = {}
  self.v_cache_ui_list = {}
  self.v_set_canvas_list = {}
  self.v_showing_reload_tips = false
  local UI_ORDER_MAP = Config.UI_SORT_ORDER
  for _, sort_val in pairs(UI_ORDER_MAP) do
    table.insert(M.UI_SORT_LIST_LAYER, sort_val)
  end
  table.sort(M.UI_SORT_LIST_LAYER, function(a, b)
    return a < b
  end)
  self.cache_ui_order = {}
  self.v_sorted_uis = {}
  for _, v in ipairs(M.UI_SORT_LIST_LAYER) do
    self.cache_ui_order[v] = 0
    self.v_sorted_uis[v] = {}
  end
  self.ui_res_mgr = require("ui.ui_res_mgr"):new()
  self.v_ui_stacks = {
    [UI_STACK_TYPE.MAIN_SCENE] = {},
    [UI_STACK_TYPE.FIGHT_SCENE] = {}
  }
  self.v_blur_stack = {
    [BACK_BLUR_TYPE.UI] = {},
    [BACK_BLUR_TYPE.SCENE] = {}
  }
  self.ui_queue_mgr = require("ui.ui_queue_mgr"):new()
  self.v_mark_destroy = {}
  self.v_disable_camera_count = 0
  self.v_set_game_pause_count = 0
  self.v_game_raw_img_active = false
  self.v_game_raw_img = Util.get_rawimage("Game/RawImage", root_camera)
end

function M:init_event_system()
  if self.v_event_system then
    return
  end
  local event_system = ResMgr:load_gameobj(Path.get_res_path("EventSystem"), nil, true)
  event_system.name = "EventSystem"
  self.v_event_system = event_system
end

function M:_on_destroy_mainui(name)
  if self.v_loaded_mainui[name] then
    self.v_loaded_mainui[name] = false
  end
end

function M:hide_group(group)
  self.v_group_roots[group]:SetActive(false)
  if "GroupNormal" == group then
    MsgGame:mq_publish2(Const.MSG_UI_NORMAL_GROUP_HIDE)
    self.v_is_normal_group_show = false
  end
end

function M:show_group(group)
  self.v_group_roots[group]:SetActive(true)
  if "GroupNormal" == group then
    self.v_is_normal_group_show = true
  end
end

function M:is_normal_group_show()
  return self.v_is_normal_group_show
end

function M:_create_group_root()
  local groups = Global.config.UI_GROUPS
  for _, group_name in pairs(groups) do
    local gameobj = self.root_obj:FindChild(group_name)
    if nil == gameobj then
      gameobj = UnityGameObject(group_name)
      gameobj.transform:SetParent(self.root_obj.transform, false)
    end
    self.v_group_roots[group_name] = gameobj
    self.v_group_root_transforms[group_name] = gameobj.transform
  end
  self.v_is_normal_group_show = true
end

function M:get_group_root(group_name)
  return self.v_group_roots[group_name]
end

function M:get_group_root_transform(group_name)
  return self.v_group_root_transforms[group_name]
end

function M:on_destroy()
  Util.wrap_xpcall_func(function()
    for _, ui in pairs(self.v_uis) do
      ui:ui_destroy()
    end
  end)
  ResMgr:destroy_gameobj(self.root_obj)
  self.root_obj = nil
  if self.v_event_system then
    ResMgr:destroy_gameobj(self.v_event_system)
    self.v_event_system = nil
  end
  ResMgr:destroy_gameobj(self.v_easy_touch)
  self.v_easy_touch = nil
  self.v_uis = {}
  self.v_dynamic_uis = {}
  self.v_set_canvas_list = {}
  self.v_main_scene_after_load_ui = nil
end

local ALIVE_ON_LOGIN_MODE = {loading = true}

function M:on_enter_login_mode()
  self:clear_ui_stack()
  for name, ui in pairs(self.v_uis) do
    if not ALIVE_ON_LOGIN_MODE[name] then
      ui:ui_hide()
    end
  end
end

function M:do_preload()
  local scene_type = Global.scene_mgr:get_scene_type()
  local ui_cfg = Global.uiconfig.ui
  for name, cfg in pairs(ui_cfg) do
    if cfg.preload_type and cfg.preload_type & 1 << scene_type > 0 then
      self:get_ui(name)
    end
  end
end

function M:is_preload_finish()
  local scene_type = Global.scene_mgr:get_scene_type()
  local ui_cfg = Global.uiconfig.ui
  for name, cfg in pairs(ui_cfg) do
    if cfg.preload_type and cfg.preload_type & 1 << scene_type > 0 then
      local ui = self.v_uis[name]
      if ui and not ui:has_inited() then
        return false
      end
    end
  end
  return true
end

function M:clear()
  self:reset()
end

function M:reset()
  self.v_main_scene_after_load_ui = nil
end

local function new_ui(self, cfg)
  local clz = require("uimodule." .. cfg.class)
  local ui = clz.ui_new(clz, cfg, nil, self.root_obj, self.root_camera)
  return ui
end

function M:new_dynamic_ui(name)
  local cfg = Global.uiconfig.dynamic_ui[name]
  if not cfg then
    Log.Info("dynamic ui not exist " .. name)
    return
  end
  cfg.name = name
  local clz = require("uimodule." .. cfg.class)
  local ui = clz.ui_new(clz, cfg, true)
  self.v_dynamic_uis[ui] = true
  return ui
end

function M:on_destroy_ui(name, ui)
  local ui = self.v_uis[name]
  self.v_uis[name] = nil
  self.v_normal_update_uis[name] = nil
  self.v_high_update_uis[name] = nil
  for index = #self.v_set_canvas_list, 1, -1 do
    local ui_obj = self.v_set_canvas_list[index]
    if ui_obj == ui then
      _tremove(self.v_set_canvas_list, index)
      break
    end
  end
  self:_on_destroy_mainui(name)
  if self.v_cur_show_ui == ui and not self:try_get_visible_ui("loading") then
    self:pop_ui(ui)
  end
  if name == UI_FIGHT then
    self.v_uis[name] = nil
    self.v_normal_update_uis[name] = nil
    self.v_high_update_uis[name] = nil
  end
end

function M:destroy_dynamic_ui(ui)
  self.v_dynamic_uis[ui] = nil
end

function M:try_get_ui(name)
  return self.v_uis[name]
end

function M:try_get_visible_ui(name)
  local ui = self.v_uis[name]
  if ui and ui:visible() then
    return ui
  end
end

function M:try_get_loaded_ui(name)
  local ui = self.v_uis[name]
  if ui and ui:is_ready() then
    return ui
  end
end

function M:try_hide_ui(name)
  local ui = self.v_uis[name]
  if ui and ui:visible() then
    ui:ui_hide()
  end
end

function M:try_destory_ui(name)
  local ui = self.v_uis[name]
  if ui then
    ui:ui_destroy()
  end
end

function M:try_call_ui_func(name, func_name, ...)
  local ui = self.v_uis[name]
  if ui and ui:has_inited() and ui:visible() then
    if ui[func_name] then
      return ui[func_name](ui, ...)
    else
      Log.Error("Failed to refresh the ui,", name, ", ui has no   ", func_name, "   functicon", debug.traceback())
    end
  end
end

function M:try_show_ui(name, refresh_func_name, ...)
  local ui = self:get_ui(name)
  if ui:visible() then
    refresh_func_name = refresh_func_name or "refresh_view"
    self:try_call_ui_func(name, refresh_func_name, ...)
  else
    ui:ui_show(...)
  end
end

function M:has_ui(name)
  return self.v_uis[name]
end

function M:get_ui(name, no_parent)
  if self.v_uis[name] then
    return self.v_uis[name]
  end
  local cfg = Global.uiconfig.ui[name]
  if not cfg then
    Log.Info("ui not exist " .. name)
    return
  end
  cfg.name = name
  local parent_ui
  if cfg.parent_ui ~= nil and not no_parent then
    parent_ui = self:get_ui(cfg.parent_ui)
    if parent_ui:visible() == false then
      parent_ui:ui_show()
    end
  end
  local ui = new_ui(self, cfg)
  if parent_ui then
    parent_ui:ui_add_sub_panels(ui)
  end
  self.v_uis[name] = ui
  ui.init_id = init_id
  init_id = init_id + 1
  if cfg.high_update then
    self.v_high_update_uis[name] = ui
  elseif cfg.normal_update then
    self.v_normal_update_uis[name] = ui
  end
  return ui
end

function M:refresh_ui_canvas_order(order_layer)
  local length = #M.UI_SORT_LIST_LAYER
  local cur_layer_idx = 0
  for i = 1, length do
    if i < length and order_layer >= M.UI_SORT_LIST_LAYER[i] and order_layer < M.UI_SORT_LIST_LAYER[i + 1] then
      cur_layer_idx = i
      break
    end
  end
  if 0 == cur_layer_idx then
    cur_layer_idx = length
  end
  local new_list = {}
  for _, ui_obj in pairs(self.v_uis) do
    local cfg = ui_obj:get_cfg()
    if not ui_obj:skip_sort_order() then
      local init_oreder = cfg.sort_order
      if ui_obj:visible() then
        local canvas = ui_obj:get_canvas()
        local canvas_oreder = canvas.sortingOrder
        local insert = false
        if length > cur_layer_idx then
          insert = init_oreder >= M.UI_SORT_LIST_LAYER[cur_layer_idx] and init_oreder < M.UI_SORT_LIST_LAYER[cur_layer_idx + 1]
        else
          insert = init_oreder >= M.UI_SORT_LIST_LAYER[cur_layer_idx]
        end
        local temp = {ui_obj = ui_obj, canvas_oreder = canvas_oreder}
        if insert then
          _tinsert(new_list, temp)
        end
      end
    end
  end
  _tsort(new_list, function(a, b)
    return a.canvas_oreder < b.canvas_oreder
  end)
  local layer = M.UI_SORT_LIST_LAYER[cur_layer_idx]
  self.cache_ui_order[layer] = 0
  local sort_val = self.cache_ui_order[layer]
  for _, ui_data in ipairs(new_list) do
    local ui_obj = ui_data.ui_obj
    local canvas = ui_obj:get_canvas()
    canvas.sortingOrder = sort_val + layer
    sort_val = sort_val + 1
  end
  self.cache_ui_order[layer] = sort_val
  self.v_sorted_uis[order_layer] = new_list
end

function M:set_canvas_plane_distance()
  local new_list = {}
  for _, ui_obj in pairs(self.v_uis) do
    local cfg = ui_obj:get_cfg()
    local view_level = cfg.view_level
    if view_level == type_cfg.MAIN_VIEW and ui_obj:visible() then
      local canvas = ui_obj:get_canvas()
      local canvas_oreder = canvas.sortingOrder
      _tinsert(new_list, {ui_obj = ui_obj, canvas_oreder = canvas_oreder})
    end
  end
  _tsort(new_list, function(a, b)
    return a.canvas_oreder > b.canvas_oreder
  end)
  self.v_set_canvas_list = {}
  for _, ui_data in ipairs(new_list) do
    local ui_obj = ui_data.ui_obj
    self:_set_plane_distance(ui_obj, false)
    _tinsert(self.v_set_canvas_list, ui_obj)
  end
  self:revert_canvas_plane_distance()
end

function M:revert_canvas_plane_distance()
  if not self.v_set_canvas_list or #self.v_set_canvas_list <= 0 then
    return
  end
  local ui_obj = self.v_set_canvas_list[1]
  self:_set_plane_distance(ui_obj, true)
end

function M:cache_hide_ui()
  if GuideMgr then
    GuideMgr:clear_guide()
  end
  self:open_default_ui(true)
  local now_time = Global.real_time
  self.v_is_cache = true
  for _, ui in pairs(self.v_uis) do
    if not ui:visible() and ui:ui_can_auto_destroy(now_time) then
      table.insert(self.v_mark_destroy, ui:ui_get_name())
    elseif ui:cache_hide_ui() and not ui:on_background_show() then
      ui:ui_hide(true, nil, true)
    end
  end
  self:_destroy_marked_uis()
  if GuideMgr then
    GuideMgr:open_guide()
  end
end

function M:revert_cache_ui()
  self._revert_async = true
end

function M:revert_cache_ui_after_load()
  if not Global.scene_mgr:check_main_scene() then
    self._revert_async = nil
    return
  end
  if not self._revert_async then
    return
  end
  self._revert_async = nil
  if self.v_main_scene_after_load_ui then
    self:open_main_scene_after_load_ui()
    return
  else
    TowerMgr:show_long_chapter_award()
  end
  self:pop_ui()
end

function M:set_main_scene_after_load_ui(ui_name, ...)
  local show_data = table.pack(...)
  self.v_main_scene_after_load_ui = {ui_name = ui_name, show_data = show_data}
end

function M:open_main_scene_after_load_ui()
  local ui_name = self.v_main_scene_after_load_ui.ui_name
  local show_data = self.v_main_scene_after_load_ui.show_data
  if not show_data[4] then
    TowerMgr:show_long_chapter_award()
  end
  self:remove_stace_by_ui_name(ui_name)
  UIMgr:get_ui(ui_name):ui_show(table.unpack(show_data))
  self:clear_main_scene_after_load_ui()
end

function M:clear_main_scene_after_load_ui()
  self.v_main_scene_after_load_ui = nil
end

function M:on_switch_to_login_mode()
  self:clear_main_scene_after_load_ui()
  self:clear_ui_stack()
  self:clear_all_ui_queue_group()
end

function M:hide_all_ui()
  for _, ui in pairs(self.v_uis) do
    ui:ui_hide(true)
  end
  self:_clean_fullscreen_data()
end

function M:test_ui(show)
  for _, ui in pairs(self.v_uis) do
    if show then
      ui:ui_show()
    else
      ui:ui_hide()
    end
  end
  self:get_ui("statics"):ui_show()
end

function M:high_update(delta_time)
  for _, ui in pairs(self.v_high_update_uis) do
    local visible = ui:visible()
    if visible then
      ui:ui_update(delta_time)
    end
  end
  for ui, _ in pairs(self.v_dynamic_uis) do
    if ui:visible() then
      ui:ui_update(delta_time)
    end
  end
  if self.v_wait_hide_time and self.v_wait_hide_time < Global.time then
    self.v_wait_hide_time = nil
    self.v_canvas_enabled = false
  end
end

function M:update(delta_time)
  local now_time = Global.real_time
  for _, ui in pairs(self.v_normal_update_uis) do
    local visible = ui:visible()
    if visible then
      ui:ui_update(delta_time)
    end
  end
  for _, ui in pairs(self.v_uis) do
    local visible = ui:visible()
    if not visible and ui:ui_can_auto_destroy(now_time) then
      self:_mark_ui_destroy(ui:ui_get_name())
    end
  end
  self.ui_queue_mgr:update(delta_time)
  self:_destroy_marked_uis()
  if self.v_set_render_frame then
    self:_do_set_render_frame()
    self.v_set_render_frame = false
  end
end

function M:has_opening_fullscreen_ui()
  return next(self.v_current_fullscreens) ~= nil
end

function M:set_current_fullscreen(ui_name, visible)
  if visible then
    self.v_current_fullscreens[ui_name] = ui_name
  else
    self.v_current_fullscreens[ui_name] = nil
  end
  local has_fullscreen = nil ~= next(self.v_current_fullscreens)
  if self.v_has_fullscreen == has_fullscreen then
    return
  end
  self.v_has_fullscreen = has_fullscreen
  local msg = MsgGame:mq_publish2(Const.MSG_SCREEN_UI_SHOW)
  msg.mm_x = self.v_has_fullscreen
end

function M:on_show_ui(ui)
end

function M:on_hide_ui(ui)
end

function M:SetUICanvasBlur(call_back)
  self.v_blur_componet:SetBlur(call_back)
end

function M:RemoveUICanvasBlur()
  self.v_blur_componet:RemoveRenderBuffer()
end

function M:GetBlurTexture()
  self.v_blur_componet:GetBlurTexture()
end

function M:set_showing_reload_tips(show)
  self.v_showing_reload_tips = show
end

function M:get_showing_reload_tips()
  return self.v_showing_reload_tips
end

function M:set_backgroud_blur(ui_name, callback, cbdata, target_blur_type)
  local blur_type = self:_get_blur_type()
  if target_blur_type then
    blur_type = target_blur_type
  end
  
  local function after_blur()
    local tex = self.v_blur_componet:GetBlurTexture()
    for _, v in ipairs(self.v_blur_stack[blur_type]) do
      if v.ui_name == ui_name then
        v.source_tex = tex
        break
      end
    end
    if callback then
      Util.wrap_xpcall_func(callback, cbdata, tex, blur_type == BACK_BLUR_TYPE.UI)
    else
      Log.Error("当前界面的模糊设置回调不存在！！", ui_name)
      self:remove_backgroud_blur(ui_name)
    end
  end
  
  table.insert(self.v_blur_stack[blur_type], {ui_name = ui_name, after_blur = after_blur})
  self:_set_blur(blur_type, after_blur, ui_name)
end

function M:_set_blur(blur_type, after_blur, ui_name)
  if blur_type == BACK_BLUR_TYPE.UI then
    self:SetUICanvasBlur(after_blur)
  elseif blur_type == BACK_BLUR_TYPE.SCENE then
    CSHelper.SetSceneGaussianBlur(1, 2, 2)
    after_blur()
  else
    after_blur()
  end
end

function M:_get_blur_type()
  return BACK_BLUR_TYPE.UI
end

function M:remove_backgroud_blur(ui_name)
  local cur_type, tex
  for blur_type, v in pairs(self.v_blur_stack) do
    for i, t in ipairs(v) do
      if t.ui_name == ui_name then
        table.remove(v, i)
        cur_type = blur_type
        tex = t.source_tex
        break
      end
    end
  end
  if cur_type == BACK_BLUR_TYPE.UI then
    self:RemoveUICanvasBlur()
    if tex then
      self.v_blur_componet:RecycleTexture(tex)
    end
  elseif cur_type == BACK_BLUR_TYPE.SCENE then
    CSHelper.SetSceneGaussianBlur(-1, 0, 0)
  end
end

function M:get_safe_area_offset()
  local anchored_offset = 0
  local safe_area_x_left = CSScreen.safeArea.x
  local safe_area_x_right = CSScreen.width - safe_area_x_left - CSScreen.safeArea.width
  local max_space = safe_area_x_left > safe_area_x_right and safe_area_x_left or safe_area_x_right
  local orign_val
  if UNITY_ANDROID then
    orign_val = LocalStorage:load_int("orign_safe_area_offset_zero", 0)
    if max_space > 0 then
      LocalStorage:save_int("orign_safe_area_offset_zero", max_space)
      orign_val = max_space
    end
  end
  max_space = orign_val or max_space
  if BattleSettingMgr then
    local user_set_value = BattleSettingMgr:get_safe_area() - 1
    if user_set_value > 0 then
      user_set_value = user_set_value / 2
    end
    if 0 ~= max_space then
      max_space = max_space + max_space * user_set_value
    else
      max_space = 70 * user_set_value
    end
  end
  anchored_offset = _clamp(max_space / CSScreen.width, 0, 1)
  return anchored_offset
end

function M:set_all_safe_area_offset()
  for name, ui in pairs(self.v_uis) do
    ui:set_safe_area_offset()
  end
end

function M:hide_other_uis(except_ui)
  if not except_ui then
    return
  end
  local waiting = "waiting"
  for name, ui in pairs(self.v_uis) do
    local parent_panel = ui:get_parent_panel()
    if name ~= except_ui and (not parent_panel or parent_panel:ui_get_name() ~= except_ui) and name ~= waiting then
      ui:ui_hide(nil, nil, true)
      self:_mark_ui_destroy(name)
    end
  end
  self:_destroy_marked_uis()
  self:clear_ui_stack(UI_STACK_TYPE.FIGHT_SCENE)
  if GAME_DEBUG or UNITY_EDITOR or PUBLISH_GM then
    UIMgr:get_ui("ui_debug_info"):ui_show()
  end
end

function M:push_ui(ui)
  self._debug_log("打开了新界面", ui:ui_get_name(), debug.traceback())
  if not self.v_cur_show_ui then
    self.v_cur_show_ui = ui
    return
  end
  if self.v_cur_show_ui:ui_get_name() == ui:ui_get_name() then
    self.v_cur_show_ui = ui
    return
  end
  if not self.v_cur_show_ui:visible() then
    self.v_cur_show_ui = ui
    return
  end
  local ui_name = self.v_cur_show_ui:ui_get_name()
  if HIDE_BY_DISTANCE[ui_name] then
    local ui_cfg = ui:get_cfg()
    if self:_get_is_full_screen_ui(ui_cfg) then
      self.v_pushing_ui = ui:ui_get_name()
      self:_set_plane_distance(self.v_cur_show_ui, false)
    end
  else
    self.v_pushing_ui = ui:ui_get_name()
    if not self.v_cur_show_ui:get_cfg().keep_stack_show then
      self.v_cur_show_ui:ui_hide(nil, nil, true)
    elseif self:_get_is_full_screen_ui(ui:get_cfg()) then
      local msg = MsgGame:mq_publish2(Const.MSG_ON_UI_BE_COVERED)
      msg.mm_obj = ui_name
      self:_set_plane_distance(self.v_cur_show_ui, false)
    end
  end
  local check_dis_stack
  if self.v_cur_show_ui:cache_ui() then
    local stack = self:_get_ui_stack()
    local stack_info = {
      ui_name = ui_name,
      param = table.pack(self.v_cur_show_ui:get_cache_data())
    }
    table.insert(stack, stack_info)
    self:_check_loop(stack, ui)
    check_dis_stack = stack
  end
  self.v_cur_show_ui = ui
  self:_check_hide(check_dis_stack)
  self._debug_log(ui_name, "界面入栈后", self.v_ui_stacks)
  self.v_pushing_ui = nil
  if self:_check_need_disable_camera(ui) then
    self.v_disable_camera_count = self.v_disable_camera_count + 1
    self:check_enable_camera()
  end
end

function M:_get_is_full_screen_ui(ui_cfg)
  if ui_cfg.background_blur then
    for _, v in pairs(self.v_blur_stack[BACK_BLUR_TYPE.UI]) do
      if v.ui_name == ui_cfg.name then
        return true
      end
    end
    return false
  end
  return not ui_cfg.not_full_screen
end

function M:_check_loop(stack, ui)
  local len = #stack
  local start_idx = 0
  for i = len, 1, -1 do
    if stack[i].ui_name == ui:ui_get_name() then
      if ui.v_cfg.run_ui_hide_during_cleanup then
        ui:ui_hide()
      end
      start_idx = i
      break
    end
  end
  if start_idx > 0 then
    local cfg = ui:get_cfg()
    if not cfg.no_remove_between_ui then
      for i = len, start_idx, -1 do
        table.remove(stack, i)
      end
    else
      table.remove(stack, start_idx)
    end
  end
end

function M:pop_ui(ui)
  if ui then
    self._debug_log("关闭了界面", ui:ui_get_name(), debug.traceback())
  else
    self._debug_log("关闭了界面", debug.traceback())
  end
  local stack = self:_get_ui_stack()
  if ui and ui.v_ui_name == UI_FIGHT then
    stack = self.v_ui_stacks[UI_STACK_TYPE.FIGHT_SCENE]
  end
  local len = #stack
  if 0 == len then
    self.v_disable_camera_count = 0
    self:check_enable_camera()
    return
  end
  local info = stack[len]
  self._debug_log("弹出的栈元素", info)
  if self.v_pushing_ui then
    self._debug_log("有界面正在打开中，就不需要再pop", self.v_pushing_ui)
    return
  end
  local curr_show_ui_name
  if self.v_cur_show_ui then
    curr_show_ui_name = self.v_cur_show_ui:ui_get_name()
  end
  if ui and ui.v_ui_name ~= curr_show_ui_name then
    Log.Error("触发pop的ui不是当前正在打开的ui, 请检查调用", ui.v_ui_name, curr_show_ui_name)
    return
  end
  if HIDE_BY_DISTANCE[info.ui_name] then
    local main_ui = self:try_get_visible_ui(info.ui_name)
    if not main_ui then
      self:get_ui(info.ui_name):ui_show()
    else
      self.v_cur_show_ui = main_ui
      self:_set_plane_distance(main_ui, true)
      if not Util.is_client_only() then
        GuideMgr:check_sys_guide(main_ui)
      end
    end
  else
    local target_ui = self:try_get_visible_ui(info.ui_name)
    if not target_ui then
      local param = info.param
      self:get_ui(info.ui_name):ui_show(table.unpack(param, 1, param.n))
    else
      self.v_cur_show_ui = target_ui
      self:_set_plane_distance(self.v_cur_show_ui, true)
    end
  end
  table.remove(stack, len)
  self._debug_log("界面出栈后", self.v_ui_stacks, debug.traceback(), info.ui_name)
  if self:_check_need_disable_camera(ui) then
    self.v_disable_camera_count = self.v_disable_camera_count - 1
    self:check_enable_camera()
  end
  if info and curr_show_ui_name and info.ui_name == curr_show_ui_name then
    self.v_cur_show_ui:ui_hide()
  end
end

function M:_check_need_disable_camera(ui)
  local cfg = ui and ui:get_cfg()
  if not cfg then
    return
  end
  return cfg.background_blur or cfg.disable_camera_on_show
end

function M:check_enable_camera()
  if SceneMgr:check_main_scene() then
    return
  end
  local camera = Global.camera
  if camera then
    camera:set_enable_camera(self.v_disable_camera_count <= 0)
  end
end

function M:_set_plane_distance(ui_obj, is_visible)
  ui_obj:set_visible_by_distance(is_visible)
end

function M:_get_ui_stack()
  return SceneMgr:check_main_scene() and self.v_ui_stacks[UI_STACK_TYPE.MAIN_SCENE] or self.v_ui_stacks[UI_STACK_TYPE.FIGHT_SCENE]
end

function M:remove_stace_by_ui_name(ui_name)
  local stack = self:_get_ui_stack()
  if not stack or #stack <= 0 then
    return
  end
  for index = #stack, 1, -1 do
    local stack_data = stack[index]
    if stack_data.ui_name == ui_name then
      _tremove(stack, index)
      break
    end
  end
end

function M:remove_cache_param_by_ui_name(ui_name, param_index)
  local stack = self:_get_ui_stack()
  if not stack or #stack <= 0 then
    return
  end
  for index = #stack, 1, -1 do
    local stack_data = stack[index]
    if stack_data.ui_name == ui_name then
      stack_data.param[param_index] = nil
      return
    end
  end
end

function M:_show_default_ui()
  if Global.gamemode:gmode_is_login() or Global.gamemode:gmode_is_loadscene() then
    return
  end
  if SceneMgr:check_main_scene() then
    if not self:try_get_visible_ui("uimain") then
      Log.Info("show defualt ui, uimian")
      self:get_ui("uimain"):ui_show()
    end
  else
    local ui = self:try_get_visible_ui(UI_FIGHT)
    Log.Info("show defualt ui, fight")
    if not ui then
      self:get_ui(UI_FIGHT):ui_show()
    else
      self:_set_plane_distance(ui, true)
    end
  end
end

function M:show_main_leave_tower()
  if #self.v_ui_stacks[UI_STACK_TYPE.MAIN_SCENE] > 0 then
    return
  end
  self:get_ui("uimain"):ui_show()
end

function M:clear_ui_stack(stack_type)
  if not stack_type or stack_type == UI_STACK_TYPE.FIGHT_SCENE then
    UIMgr.ui_queue_mgr:clear_target_group_queue(Config.UI_QUEUE_GROUP.Fight_Tips)
  end
  if not stack_type then
    self.v_ui_stacks = {
      [UI_STACK_TYPE.MAIN_SCENE] = {},
      [UI_STACK_TYPE.FIGHT_SCENE] = {}
    }
  else
    self.v_ui_stacks[stack_type] = {}
  end
  self.v_disable_camera_count = 0
end

function M:clear_all_ui_queue_group()
  for i, v in pairs(Config.UI_QUEUE_GROUP) do
    UIMgr.ui_queue_mgr:clear_target_group_queue(v)
  end
end

function M:get_main_last_ui()
  local length = #self.v_ui_stacks[UI_STACK_TYPE.MAIN_SCENE]
  return self.v_ui_stacks[UI_STACK_TYPE.MAIN_SCENE][length]
end

function M:get_fight_last_ui()
  local length = #self.v_ui_stacks[UI_STACK_TYPE.FIGHT_SCENE]
  return self.v_ui_stacks[UI_STACK_TYPE.FIGHT_SCENE][length], length
end

function M:get_top_ui_in_uis(filter_map)
  filter_map = filter_map or SKIP_ORDER_UI
  local top_ui
  local top_id = math.mininteger
  local ui_name
  for k, ui in pairs(self.v_uis) do
    ui_name = ui:ui_get_name()
    if ui:visible() and not filter_map[ui_name] and top_id < ui.init_id then
      top_ui = ui
      top_id = ui.init_id
    end
  end
  return top_ui
end

function M:get_top_ui_by_sorting_order(filter_map)
  filter_map = filter_map or SKIP_ORDER_UI
  local top_ui
  local max_order = math.mininteger
  local order, ui_name
  for k, ui in pairs(self.v_uis) do
    ui_name = ui:ui_get_name()
    if ui:visible() and not filter_map[ui_name] and ui.canvas then
      order = ui.canvas.sortingOrder
      if max_order <= order then
        top_ui = ui
        max_order = order
      end
    end
  end
  return top_ui
end

function M:get_has_tips()
  for k, v in pairs(self.v_uis) do
    local ui_name = v:ui_get_name()
    if v:visible() then
      local not_full = self:get_is_not_full_ui(v)
      if not_full and nil == GUIDE_IGNORE_TIPS[ui_name] then
        return ui_name
      end
    end
  end
end

function M:get_is_not_full_ui(ui)
  local ui_cfg = ui:get_cfg()
  if ui_cfg.sort_order == Config.UI_SORT_ORDER.Tip or ui_cfg.sort_order == Config.UI_SORT_ORDER.SeniorTip then
    return true
  end
  if ui_cfg.sort_order == Config.UI_SORT_ORDER.System and ui_cfg.not_full_screen then
    return true
  end
  return false
end

function M:get_is_guide_ignore_tips(ui_name)
  return nil ~= GUIDE_IGNORE_TIPS[ui_name]
end

function M:get_wcanvas()
  return self.v_group_roots[Config.UI_GROUPS.GROUP_WORLD]
end

function M:get_wcanvas_transform()
  return self.v_group_root_transforms[Config.UI_GROUPS.GROUP_WORLD]
end

function M:get_world_camera_obj()
  return self.world_camera_obj
end

function M:get_world_camera()
  return self.world_camera
end

function M:get_root_camera()
  return self.root_camera
end

function M:set_world_camera_visible_state(is_on)
  local camera_obj = self:get_world_camera_obj()
  camera_obj:SetActive(is_on)
  if self.v_game_raw_img then
    if is_on then
      self:force_close_game_raw_img()
    else
      self:revert_game_raw_img_active()
    end
  end
end

function M:add_ui_queue(group, ui_name, ...)
  self.ui_queue_mgr:push_ui(group, nil, ui_name, ...)
end

function M:add_ui_queue_no_repeat(group, ui_name, ...)
  self.ui_queue_mgr:push_ui(group, true, ui_name, ...)
end

function M:get_cur_show_ui()
  return self.v_cur_show_ui
end

function M:get_cur_show_ui_name()
  if self.v_cur_show_ui then
    return self.v_cur_show_ui:ui_get_name()
  end
end

function M:get_event_system()
  return self.v_event_system
end

function M:_mark_ui_destroy(ui_name)
  table.insert(self.v_mark_destroy, ui_name)
end

function M:_destroy_marked_uis()
  if #self.v_mark_destroy > 0 then
    for _, v in ipairs(self.v_mark_destroy) do
      if self.v_uis[v] then
        self.v_uis[v]:ui_destroy()
      end
    end
    self.v_mark_destroy = {}
  end
end

function M:_check_hide(check_dis_stack)
  if not check_dis_stack then
    return
  end
  local is_full = self:_get_is_full_screen_ui(self.v_cur_show_ui:get_cfg())
  if is_full then
    local length = #check_dis_stack
    local cfg = self.v_cur_show_ui:get_cfg()
    local len = cfg.keep_stack_show and length or length - 1
    for i = 1, len do
      local info = check_dis_stack[i]
      local uiobj = self:try_get_visible_ui(info.ui_name)
      if uiobj then
        if HIDE_BY_DISTANCE[info.ui_name] then
          self:_set_plane_distance(uiobj, false)
        else
          local uicfg = uiobj:get_cfg()
          if uicfg.keep_stack_show then
            self:_set_plane_distance(uiobj, false)
          else
            uiobj:ui_hide(nil, nil, true)
          end
        end
      end
    end
  end
end

function M:check_stack_has_ui(ui_name)
  for _, v in ipairs(self.v_ui_stacks[UI_STACK_TYPE.MAIN_SCENE]) do
    if v.ui_name == ui_name then
      return true
    end
  end
  return false
end

function M:go_to_main(after_show_callback)
  self:clear_ui_stack()
  self:hide_other_uis("uimain")
  local uimain = self:try_get_visible_ui("uimain")
  if uimain then
    self:_set_plane_distance(uimain, true)
    if not Util.is_client_only() then
      GuideMgr:check_sys_guide(uimain)
    end
  else
    self:get_ui("uimain"):ui_show()
  end
  self.v_cur_show_ui = self:try_get_visible_ui("uimain")
  self.v_cur_show_ui:change_model_view_param(SIGNBOARD_PARAM.NORMAL, true)
  self.v_cur_show_ui:set_after_show_cb(after_show_callback)
  self:get_ui("ui_click_effect"):ui_show()
end

function M:set_render_frame(ui, low)
  if Global.gamemode:gmode_is_login() or Global.gamemode:gmode_is_loadscene() then
    return
  end
  if SceneMgr:check_main_scene() then
    low = false
  end
  self.v_render_lv = low and RENDER_FRAME.LOW or RENDER_FRAME.NORMAL
  self.v_set_render_frame = true
end

function M:_do_set_render_frame()
  local cur = Global.render_mgr:get_render_frame()
  if cur ~= self.v_render_lv then
    Global.render_mgr:set_render_frame(self.v_render_lv)
  end
end

function M:set_3d_camera_msaa_on(is_on)
  self.world_camera.allowMSAA = is_on
end

function M:reset_disable_camera_count()
  if not SceneMgr:check_main_scene() and not Util.is_nil(self.world_camera_obj) and self.world_camera_obj.activeSelf then
    return
  end
  self.v_disable_camera_count = 0
  self:check_enable_camera()
  self.v_set_game_pause_count = 0
  self:check_set_game_pause()
end

function M:is_current_ui_can_pause_game()
  for k, v in pairs(self.v_uis) do
    if v:visible() and v:get_cfg().need_pause_game then
      return true
    end
  end
  return false
end

function M:open_default_ui(open)
  if self.default_ui_obj and self.v_default_ui_state ~= open then
    self.default_ui_obj:SetActive(open)
    if open then
      self.v_default_ui_state = true
    else
      self.v_default_ui_state = false
    end
  end
end

function M:insert_asset_bar_in_list(asset_bar)
  local in_list = false
  if #self.v_asset_bar_list > 0 then
    for index = #self.v_asset_bar_list, 1, -1 do
      local other_bar = self.v_asset_bar_list[index]
      if not other_bar then
        table.remove(self.v_asset_bar_list, index)
      elseif asset_bar == other_bar then
        in_list = true
      elseif other_bar:get_state() == Config.ASSET_BAR_STATE.ON_CREATE then
        other_bar:on_clear()
      end
    end
  end
  if not in_list then
    table.insert(self.v_asset_bar_list, asset_bar)
  end
end

function M:remove_asset_bar_on_list(asset_bar)
  local length = #self.v_asset_bar_list
  if length > 0 then
    for index = length, 1, -1 do
      local other_bar = self.v_asset_bar_list[index]
      if not other_bar or asset_bar == other_bar then
        table.remove(self.v_asset_bar_list, index)
        break
      end
    end
  end
  length = #self.v_asset_bar_list
  if length > 0 and self.v_asset_bar_list[length]:get_state() ~= Config.ASSET_BAR_STATE.ON_CREATE then
    self.v_asset_bar_list[length]:on_create()
  end
end

function M:on_collection_tip_close(item_id)
  if TowerMgr then
    local tower = TowerMgr:get_tower()
    if tower then
      BehaviorMgr:call_scene_logic_event_fun("on_collection_close", item_id)
    end
  end
end

function M:get_next_ui_name()
  local stack = self:_get_ui_stack()
  local len = #stack
  if len > 0 then
    return stack[len].ui_name
  end
end

function M:get_notice_opened()
  return is_notice_opened
end

function M:set_notice_opened()
  is_notice_opened = true
end

function M:try_hide_team_ui()
  self:try_hide_ui("team")
end

function M:set_default_camera_obj_visible(value)
  if not self.default_ui_camera_obj then
    return
  end
  self.default_ui_camera_obj:SetActive(value)
end

function M:get_game_raw_img()
  return self.v_game_raw_img
end

function M:set_game_raw_img_active(active)
  if self.v_game_raw_img_active ~= active then
    self.v_game_raw_img.gameObject:SetActive(active)
    self.v_game_raw_img_active = active
  end
end

function M:revert_game_raw_img_active()
  self.v_game_raw_img.gameObject:SetActive(self.v_game_raw_img_active)
end

function M:force_close_game_raw_img()
  self.v_game_raw_img.gameObject:SetActive(false)
end

function M:clear_all_cache_ui_custom_data()
  self.v_cache_data_for_ui = {}
end

function M:set_cache_ui_custom_data(key, val)
  self.v_cache_data_for_ui = self.v_cache_data_for_ui or {}
  self.v_cache_data_for_ui[key] = val
end

function M:get_cache_ui_custom_data(key)
  if self.v_cache_data_for_ui then
    return self.v_cache_data_for_ui[key]
  end
end

function M:refresh_barrage_alpha(is_open)
  local ui_barrage = self:try_get_visible_ui("ui_barrage")
  if not ui_barrage then
    return
  end
  ui_barrage:set_alpha_with_other_ui(is_open)
end

function M:add_set_game_pause_count(count)
  self.v_set_game_pause_count = self.v_set_game_pause_count + count
  self:check_set_game_pause()
end

function M:check_set_game_pause()
  local pause = self.v_set_game_pause_count > 0
  local is_pause = SceneMgr:get_game_pause()
  if pause ~= is_pause then
    SceneMgr:set_game_pause(pause)
  end
end

function M._debug_log(...)
  if DEBUG_UI_STACK then
    Log.Error(...)
  end
end

function M:close_cur_show_ui()
  local top_ui = self:get_top_ui_by_sorting_order()
  if not top_ui or top_ui:ui_get_name() == "uimain" then
    return false
  end
  local not_in_battle = SceneMgr:check_main_scene()
  local cfg = top_ui:get_cfg()
  local opeartion_ui = top_ui
  if cfg.parent_ui then
    local parent_ui = self:try_get_visible_ui(cfg.parent_ui)
    if parent_ui then
      opeartion_ui = parent_ui
    end
  end
  if opeartion_ui:on_exiting_pd() then
    return true
  end
  local result = opeartion_ui:response_click_escape()
  if result == M.RESPONCE_ESCAPE_TYPE.AUTO_CALL and not_in_battle then
    local return_btn_responce = false
    local btn
    for i = 1, #COMMON_RETURN_BUTTON_NAME do
      local btn_name = COMMON_RETURN_BUTTON_NAME[i]
      btn = opeartion_ui:get_uiobject(btn_name, TypeUnityUIButton)
      if btn and btn.activeInHierarchy then
        local root = opeartion_ui:get_lua_object()
        local btn_cb = Global.listener_mgr:get_listener(root, btn.onClick)
        if btn_cb then
          btn_cb()
          return_btn_responce = true
          break
        end
      end
    end
    if not return_btn_responce then
      self:try_hide_ui(opeartion_ui:ui_get_name())
    end
  end
  return true
end

function M:cache_ui_prefab(path, cache_obj)
  cache_obj:SetActive(false)
  cache_obj.transform:SetParent(self.cache_prefab_root)
  self.cache_prefab[path] = cache_obj
end

function M:get_cache_ui_prefab(path)
  local ret = self.cache_prefab[path]
  self.cache_prefab[path] = nil
  return ret
end

return M
