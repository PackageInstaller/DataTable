local LuaRequire = require
local MsgQueue = require("utils.msgqueue")
local AssetCache = require("manager.res.asset_cache")
local CommonDef = require("cs_share.common_define")
local CSUnityEngine = CS.UnityEngine
local CSUnityUI = CSUnityEngine.UI
local CSLuaService = CS.Game.LuaService
local CSService = CS.Game.Service
local UnityPhysics = CSUnityEngine.Physics
local UnityTime = CSUnityEngine.Time
local _slower = string.lower
local game_world = {}
game_world.debug_camera_data = {}

local function init_unity_type()
  _G.UnityEngine = CSUnityEngine
  _G.UnityAnimator = CSUnityEngine.Animator
  _G.TypeUnityAnimator = typeof(CSUnityEngine.Animator)
  _G.UnityMaterial = CSUnityEngine.Material
  _G.TypeUnityAnimatorOverrideController = typeof(CSUnityEngine.AnimatorOverrideController)
  _G.UnityAnimatorOverrideController = CSUnityEngine.AnimatorOverrideController
  _G.UnityAnimatorController = CSUnityEngine.RuntimeAnimatorController
  _G.UnityVector3 = CSUnityEngine.Vector3
  _G.UnityPhysics = CSUnityEngine.Physics
  _G.CompExtensions = CS.CompExtensions
  _G.UnitySpace = CS.UnityEngine.Space
  _G.UnityGameObject = CSUnityEngine.GameObject
  _G.TypeUnityGameObject = typeof(CSUnityEngine.GameObject)
  _G.UnityTransform = CSUnityEngine.Transform
  _G.TypeUnityTransform = typeof(CSUnityEngine.Transform)
  _G.UnityDestroy = CSUnityEngine.GameObject.Destroy
  _G.UnityFind = CSUnityEngine.GameObject.Find
  _G.UnityEngineUI = CSUnityUI
  _G.UnityUICanvas = CSUnityEngine.Canvas
  _G.UnityUICanvasGroup = CSUnityEngine.CanvasGroup
  _G.TypeCanvasGroup = typeof(CSUnityEngine.CanvasGroup)
  _G.UnityRectTransform = CSUnityEngine.RectTransform
  _G.TypeUnityRectTransform = typeof(CSUnityEngine.RectTransform)
  _G.TypeUnityUIImage = typeof(CSUnityUI.Image)
  _G.UnityUIImage = CSUnityUI.Image
  _G.UnitySprite = CSUnityEngine.Sprite
  _G.UnitySpriteAtlas = CSUnityEngine.U2D.SpriteAtlas
  _G.TypeUnityUIText = typeof(CSUnityUI.Text)
  _G.UnityUIText = CSUnityUI.Text
  _G.TypeUnityUIButton = typeof(CSUnityUI.Button)
  _G.UnityUIButton = CSUnityUI.Button
  _G.TypeUnityUIToggle = typeof(CSUnityUI.Toggle)
  _G.UnityUIToggle = CSUnityUI.Toggle
  _G.TypeUnityUIInputField = typeof(CSUnityUI.InputField)
  _G.UnityUIInputField = CSUnityUI.InputField
  _G.TypeUnityUIScrollRect = typeof(CSUnityUI.ScrollRect)
  _G.UnityUIScrollRect = CSUnityUI.ScrollRect
  _G.TypeUnityUIDropdown = typeof(CSUnityUI.Dropdown)
  _G.UnityUIDropdown = CSUnityUI.Dropdown
  _G.TypeUnityUISlider = typeof(CSUnityUI.Slider)
  _G.UnityUISlider = CSUnityUI.Slider
  _G.TypeUnityUIRawImage = typeof(CSUnityUI.RawImage)
  _G.UnityUIRawImage = CSUnityUI.RawImage
  _G.UnityUIToggleGroup = CSUnityUI.ToggleGroup
  _G.UnityUILayoutElement = CSUnityUI.LayoutElement
  _G.TypeCSScrollRectEx = typeof(CS.Game.ScrollRectEx)
  _G.TypeCSButtonEx = typeof(CS.Game.ButtonEx)
  _G.CSButtonEx = CS.Game.ButtonEx
  _G.CSEffectStatus = CS.EffectStatus
  _G.TypeEffectStatus = typeof(CS.EffectStatus)
  _G.TypeEffectStage = typeof(CS.Game.EffectStage)
  _G.TypeUIParticle = typeof(CS.UIParticleExtensions.UIParticle)
  _G.CSUIParticle = CS.UIParticleExtensions.UIParticle
  _G.TypePlayableDirector = typeof(UnityEngine.Playables.PlayableDirector)
  _G.UnityVector3 = UnityEngine.Vector3
  _G.UnityVector2 = UnityEngine.Vector2
  _G.TypeCinemaVirtalCamera = typeof(CS.Cinemachine.CinemachineVirtualCamera)
  _G.TypeCinemachineBrain = typeof(CS.Cinemachine.CinemachineBrain)
  _G.TypeRenderer = typeof(CS.UnityEngine.Renderer)
  _G.CSHelper = CS.Game.CSHelper
  _G.MD5Helper = CS.Game.MD5Helper
  _G.E = {}
  setmetatable(E, {
    __newindex = function()
      error("can not set table E")
    end
  })
end

function game_world:init()
  print("--------------------------Enter Game--------------------------------", os.date("!%Y-%m-%d %H:%M:%S"))
  math.randomseed(os.time())
  _G._LUA_SERVER_ENV = false
  if _G.GAME_RELEASE then
    _G.GAME_DEBUG = false
  end
  Path = require("utils.path")
  Global.uiconfig = require("ui.uiconfig")
  Global.timer = require("utils.timer"):new()
  Global.ct_timer = require("utils.ct_timer"):new()
  Global.util = require("utils.util")
  Global.util_table = require("utils.util_table")
  Global.util_ui = require("utils.util_ui")
  Global.util_fun = require("utils.util_fun"):new()
  Global.debug_setting = require("uimodule.debug_setting.debug_setting"):new()
  Global.share_res = require("utils.share_res")
  ShareRes = Global.share_res
  Log.load_log_flag()
  Log.check_filter()
  Global.real_time = UnityTime.realtimeSinceStartup
  Global.player_uuid = 0
  Global.stop_update = false
  Global.check_update_ing = false
  Global.joystick_origin_x = 0
  Global.joystick_origin_y = 0
  Global.joystick_time = 0
  Global.is_aimed_move = false
  Global.is_open_timer = false
  if Game_AssetBundle then
    Global.assetbundle_mgr = require("manager.res.assetbundle_mgr"):new()
    Global.res_mgr = require("manager.res.bundle_loader"):new()
    Global.scene_loader = require("manager.scene_loader.scene_loader_bundle"):new()
  else
    Global.unityres_mgr = require("manager.res.unityres_mgr"):new()
    Global.res_mgr = require("manager.res.res_loader"):new()
    Global.scene_loader = require("manager.scene_loader.scene_loader_resources"):new()
  end
  DebugSetting = Global.debug_setting
  Util = Global.util
  UtilTable = Global.util_table
  UtilUI = Global.util_ui
  LanguageMgr = require("manager.language.language_mgr"):new()
  Util.refresh_curr_language()
  Global.npc_pool_mgr = require("manager.scene.scene_npc_pool_mgr"):new()
  Global.res_pool_mgr = require("manager.res.resource_pool_mgr"):new()
  Global.mq_game = MsgQueue.mq_create_ex(Global.const.E_GAME_MSG, Global.const.E_GAME_MSG_NAMES)
  Global.ui_mgr = require("ui.uimanager")
  Global.lua_error = require("uimodule.hint.lua_error")
  Global.listener_mgr = require("manager.utility.listener_mgr"):new()
  Global.cache_mgr = require("manager.utility.cache_mgr"):new()
  Global.red_enum = require("utils.red_enum")
  Global.network = require("network.network")
  Global.date = require("utils.date")
  Global.profiler = require("utils.profiler")
  Timer = Global.timer
  MsgGame = Global.mq_game
  Const = Global.const
  ResMgr = Global.res_mgr
  ResPoolMgr = Global.res_pool_mgr
  CacheMgr = Global.cache_mgr
  RedEnum = Global.red_enum
  Network = Global.network
  SceneLoader = Global.scene_loader
  Date = Global.date
  InputMgr = require("manager.input.input_mgr"):new()
  Joystick = require("manager.input.joystick")
  UIMgr = Global.ui_mgr
  BehaviorMgr = require("manager.fight.behaviormgr")
  BehaviorShareMgr = require("manager.fight.behavior_share_mgr"):new()
  GlobalTimeMgr = require("manager.time.global_time_mgr")
  NextFrameMgr = require("manager.time.next_frame_mgr"):new()
  Global.scene_mgr = require("manager.scene.scenemanager"):new()
  SceneMgr = Global.scene_mgr
  LuaCfgFieldMgr = require("manager.lua_cfg_field.lua_cfg_field_mgr"):new()
  Condition = require("gamelogic.condition.condition_mgr"):new()
  MissileConfigHookMgr = require("manager.fight.missile_config_hook_mgr"):new()
  ScreenMaskMgr = require("ui.screen_mask_mgr"):new()
  if SDKType == Config.SDK_TYPE.HIVE_SDK then
    SDKManager = require("manager.sdk.gh_sdk_mgr"):new()
    SDKManager:track_adjust_event("01_first_open")
  elseif SDKType == Config.SDK_TYPE.UG_SDK then
    SDKManager = require("manager.sdk.ug_sdk_mgr"):new()
  else
    SDKManager = require("manager.sdk.tsi_sdk_mgr"):new()
  end
  ServerList = require("gamelogic.login.server_list"):new()
  MagicReporter = require("manager.magic.magic_reporter"):new()
  NetworkHelper = require("utils.net_work_helper"):new()
  TimeLineSeqPlayer = require("manager.utility.timeline_seq_player")
  SceneRoomPrefabLoader = require("manager.utility.scene_room_prefab_loader"):new()
  BehaviorMgr:init()
  require("manager.res.runtime_package").reset()
  AssetCache:init()
  if Game_AssetBundle then
    local asset = Global.res_mgr:load_res("assets/product/common/resourceconfig.asset", CS.ResourceDictionary)
    CS.ResourceDictionary.SetInstance(asset)
  end
  if Global.assetbundle_mgr then
    Global.assetbundle_mgr:init()
  end
  Global.ui_mgr:init()
  Cinemachine = require("manager.utility.cinemachine"):new()
  ScreenMgr = require("gamelogic.screen.screen_mgr"):new()
  Global.render_mgr = require("manager.render.render_mgr"):new()
  Global.sound_mgr = require("manager.sound.sound_mgr"):new()
  Global.state_sound_mgr = require("manager.sound.state_sound_mgr"):new()
  Global.repair_game = require("gamemode.repair_game")
  Global.gamemode:gmode_init()
  Global.gamemode:gmode_set_mode(Global.const.MODE_LOGIN)
  ResMgr:load_default_res()
  Global.video_mgr = require("manager.sound.video_mgr"):new()
  VideoMgr = Global.video_mgr
  local screen = CS.UnityEngine.Screen
  Global.screen_width = screen.width
  Global.screen_height = screen.height
  Global.screen_factor = math.max(Global.screen_width / 1920, Global.screen_height / 1080)
  Global.screen_ratio = Global.screen_width / Global.screen_height
  if GAME_DEBUG then
    Global.debug = true
    Global.spline_debug = false
    Global.debug_msg_list = require("utils.util_fifo"):new(1000)
  end
  Global.resume_time = os.time()
  Global.custom_checkupdate_ctx_id = 0
  Word_Censor = require("utils.word_censor")
  Global.redpoint_mgr = require("gamelogic.redpoint_mgr"):new()
  RedPointMgr = Global.redpoint_mgr
  Global.img_collector = require("utils.img_collector"):new()
  UnityTime.fixedDeltaTime = 0.03333333333333333
  local Layer = require("utils.layer")
  UnityPhysics.IgnoreLayerCollision(Layer.Layer.NPC, Layer.Layer.NPC)
  Global.gamemode:gmode_update_mode()
  Global.missile_movement_pool_mgr = require("manager.fight.movement.missile_movement_pool_mgr"):new()
  BattleSettingMgr = require("gamelogic.battle_setting.battle_setting_mgr"):new()
  BattleSettingMgr:use_player_setting_info()
  DownloadMgr = require("gamelogic.download.download_mgr"):new()
end

function game_world.on_update(elapsed)
  if NetworkHelper then
    NetworkHelper:update()
  end
  if SDKManager then
    SDKManager:update()
  end
  if InputMgr then
    InputMgr:touch_effect_show()
  end
  if Global.check_update_ing then
    Global.gamemode:gmode_update(elapsed)
    return
  end
  if Global.stop_update then
    return
  end
  Global.frame_id = Global.frame_id + 1
  Global.elapsed = elapsed
  Global.time = UnityTime.time
  Global.delta_time = UnityTime.deltaTime
  Global.real_time = UnityTime.realtimeSinceStartup
  Global.time_scale = UnityTime.timeScale
  Global.level_time = UnityTime.timeSinceLevelLoad
  Global.unscale_delta_time = UnityTime.unscaledDeltaTime
  Global.scaled_time = Global.scaled_time + GlobalTimeMgr:get_dt_time()
  if Global.real_time - Global.last_unload_asset_time > 2 then
    Global.last_unload_asset_time = Global.real_time
    AssetCache:collectgarbage()
  end
  if Global.vendor then
    Global.vendor.update()
  end
  if Global.timer then
    Global.timer:update(elapsed)
    Global.ct_timer:update(elapsed)
  end
  if Global.assetbundle_mgr then
    Global.assetbundle_mgr:update()
  end
  Global.res_pool_mgr:update()
  if Global.mq_game then
    Global.mq_game:mq_dispatch()
  end
  Global.gamemode:gmode_update(elapsed)
  game_world.low_update(elapsed)
  NextFrameMgr:update()
  Global.sound_mgr:update()
  for _, info in ipairs(Config.system_modules) do
    local class = _G[info.global_name]
    if class and class.update and class:can_update() then
      class:update(elapsed)
    end
  end
  if UNITY_EDITOR then
    Global.img_collector:update()
  end
  Global.video_mgr:update()
  Cinemachine:update()
end

local network_update_timer_on_stop = 0

function game_world.low_update(elapsed)
  if Global.stop_update then
    return
  elseif UNITY_EDITOR and 0 == elapsed then
    if Global.real_time - network_update_timer_on_stop >= Config.LOW_UPDATE_INTERVAL then
      network_update_timer_on_stop = Global.real_time
      Global.network:update()
    end
    return
  end
  Global.low_elapsed = Global.low_elapsed + elapsed
  Global.low_update = false
  Global.low_delta_time = 0
  if Global.low_elapsed >= Config.LOW_UPDATE_INTERVAL then
    local dt = elapsed > Config.LOW_UPDATE_INTERVAL and elapsed or Config.LOW_UPDATE_INTERVAL
    Global.low_update = true
    Global.low_delta_time = dt
    Global.low_elapsed = Global.low_elapsed - dt
    Global.gamemode:gmode_low_update(dt)
    Global.network:update()
  end
end

function game_world.on_lateupdate()
  if Global.stop_update then
    return false
  end
  Global.gamemode:gmode_late_update()
end

function game_world.on_fixedupdate()
  if Global.check_update_ing then
    return
  end
  if Global.stop_update then
    return
  end
  Global.fixed_delta_time = UnityTime.fixedDeltaTime
  Global.fixed_time = UnityTime.fixedTime
  Global.fixed_frame_id = Global.fixed_frame_id + 1
  Global.gamemode:gmode_fixed_update()
end

local _custom_check_update_ctx_id = 0

function game_world.on_custom_check_update_finish(has_new_patch)
  if _custom_check_update_ctx_id ~= Global.custom_checkupdate_ctx_id then
    return
  end
  if has_new_patch and (Global.gamemode:gmode_is_login() or Global.gamemode:gmode_is_main()) then
    Util.hide_notify_popup_message()
    Util.show_notify_popup_message(function()
      Network:close()
      Global.gamemode:gmode_set_mode(Const.MODE_CHECK_UPDATE)
    end, "有新的更新文件推送，请重新进入游戏拉取更新", "需要更新", "确定", nil, nil, true)
  end
end

function game_world.on_application_focus(is_focus)
  Global.application_focus = is_focus
end

function game_world.on_application_pause(is_pause)
  if not is_pause then
    local now = os.time()
    if (Global.gamemode:gmode_is_login() or Global.gamemode:gmode_is_main() and UIMgr:get_cur_show_ui_name() == "uimain") and now - Global.resume_time > 60 then
      local check_update_mode = require("gamemode.check_update_mode")
      Global.custom_checkupdate_ctx_id = Global.custom_checkupdate_ctx_id + 1
      _custom_check_update_ctx_id = Global.custom_checkupdate_ctx_id
      check_update_mode:do_check_update()
    end
    Global.resume_time = now
  end
  if Global.sound_mgr then
    Global.sound_mgr:application_pause_sound(is_pause)
  end
  if UIMgr and is_pause then
    local ui_fight = UIMgr:try_get_visible_ui(UIMgr.FIGHT_UI_NAME)
    if ui_fight then
      ui_fight:on_up_all_code(true, true)
    end
  end
  Global.application_pause = is_pause
  local msg = MsgGame:mq_publish2(Const.MSG_ON_APPLICATION_PAUSE)
  msg.mm_x = Global.application_pause
end

function game_world.pause_time(is_pause)
  if not UIMgr then
    return
  end
  if not TowerMgr then
    return
  end
  if not SceneMgr then
    return
  end
  local ui_fight_pause_common = UIMgr:try_get_visible_ui("fight_pause_common")
  if ui_fight_pause_common then
    return
  end
  local ui_fight = UIMgr:try_get_visible_ui(UIMgr.FIGHT_UI_NAME)
  if not ui_fight then
    return
  end
  local ui_gecao_battle = UIMgr:try_get_visible_ui("gecao_battle")
  if ui_gecao_battle then
    local msg = {}
    msg.mm_x = is_pause
    ui_gecao_battle:on_game_pause_state_changed(msg)
  end
  local ui_ct_timer = UIMgr:try_get_visible_ui("ui_ct_timer")
  if ui_ct_timer then
    local msg = {}
    msg.mm_x = is_pause
    ui_ct_timer:on_game_pause_state_changed(msg)
    if is_pause then
      SceneMgr:c2gs_call_scene("sync_scene_logic_action", SceneDef.SCENE_LOGIC_ACTION.PAUSE, Date.server_time(true))
    else
      SceneMgr:c2gs_call_scene("sync_scene_logic_action", SceneDef.SCENE_LOGIC_ACTION.CONTINUE, Date.server_time(true))
    end
  end
end

function game_world.on_destroy()
  if Global.network then
    Global.network:close()
  end
end

function game_world.on_err_report(err_msg)
  if not GAME_RELEASE then
    Global.lua_error.on_lua_error(err_msg, "客户端报错")
  end
end

local SAVE_POWER = false

function game_world.check_interaction(...)
  local is_too_long = false
  local time = GestureManager:get_last_interaction_time()
  if time and time + 180 < Date.now() then
    is_too_long = true
  end
  if is_too_long ~= SAVE_POWER then
    SAVE_POWER = not SAVE_POWER
    Util.toggle_close_all_ui(SAVE_POWER)
    Util.toggle_headbar(SAVE_POWER)
    Util.toggle_brightness(SAVE_POWER)
  end
  Global.save_power_mode = SAVE_POWER
end

function game_world.on_gesture(name, ...)
  if InputMgr then
    InputMgr.on_gesture(name, ...)
  end
end

function game_world.on_key(key)
  if InputMgr then
    InputMgr.on_key(key)
  end
end

function game_world.on_key_up(key)
  if InputMgr then
    InputMgr.on_key_up(key)
  end
end

function game_world.ani_key_frame_event(data)
  Global.sound_mgr:ani_key_frame_event(data)
end

function game_world.on_jump()
end

function game_world.on_joystick(name, i)
  Joystick.on_joystick(name, i)
end

function game_world.on_joystick_move(x, y)
  Joystick.on_joystick("move", x, y)
end

function game_world.on_collide(a, b)
  SceneMgr:on_collide(a, b)
end

function game_world.lua_gm(func, arg1, arg2)
  if "reload_lua" == func then
    local gm = require("uimodule.gm.gm")
    gm:reload_lua(arg1)
  elseif "reload" == func then
    local behavior_loader = require("utils.behavior_loader")
    if FightDataMgr then
      FightDataMgr:clear_cache_keyframe_cfg()
    end
    ShareRes.clear()
    SceneMgr:reload_all()
    behavior_loader:reload_all()
    BehaviorMgr:reload_all()
    if BattleSkillBookMgr then
      BattleSkillBookMgr:reload_all()
    end
    if SkillLinkMgr then
      SkillLinkMgr:reload_all()
    end
  elseif "play_story" == func then
    local story_data = Util.split_str(arg1, "/")
    local story_id = tonumber(story_data[1])
    local start_step_id
    if story_data[2] and tonumber(story_data[2]) >= 0 then
      start_step_id = tonumber(story_data[2]) + 1
    end
    local story_str = arg2
    local story_tbl = load(story_str)()
    UIMgr:get_ui("uistory"):ui_show(nil, story_tbl, start_step_id, story_id)
  elseif "mylua" == func then
    local v = require("my_lua")
    v:run(arg1, arg2)
  elseif "stop_story" == func then
    UIMgr:try_destory_ui("uistory")
    UIMgr:try_destory_ui("ui_blackfade")
  end
end

function game_world.lua_sync_operation(operation)
  if "sync_camera_data" == operation then
    Global.camera:syncdata_from(game_world.debug_camera_data)
  end
end

function game_world.traceback(str)
  print(str, debug.traceback())
end

function game_world.play_sound(base_params)
  if not Global.sound_mgr then
    Log.Error("音乐管理器未初始化完毕")
    return
  end
  Global.sound_mgr:play_sound_by_cscall(base_params)
end

function game_world.get_global_hero_trans()
  if not Global.hero then
    Log.Info("hero不存在")
    return
  end
  return Global.hero.transform
end

function game_world.joystick_drag(is_drag, joystick_index)
  if not UIMgr then
    return
  end
  local fight = UIMgr:try_get_loaded_ui(UIMgr.FIGHT_UI_NAME)
  if not fight then
    return
  end
  fight:set_button_drag_state(is_drag, joystick_index)
end

function game_world.on_hack_detected(error)
  local error_code, msg = string.match(error, "([^|]+)|([^|]+)")
  local req_body = {code = error_code, err_msg = msg}
  Network:call("c2gs_on_hack_detected", req_body, nil)
end

function game_world.on_low_memory()
end

local function _destroy_reload_camera()
  local root_obj = CS.UnityEngine.GameObject.Find("ReloadCamera")
  if root_obj then
    CS.UnityEngine.GameObject.Destroy(root_obj)
  end
end

function main()
  CSUnityEngine.Application.targetFrameRate = 60
  _destroy_reload_camera()
  init_unity_type()
  Global = require("global")
  Global.log = require("utils.log")
  Log = Global.log
  Global.config = require("config")
  Global.scaled_time = 0
  Config = Global.config
  SDKTrack = require("manager.sdk.sdk_track")
  SDKTrack:_init()
  Global.gamemode = require("gamemode.manager")
  Global.gamemode:init()
  Global.const = require("const")
  Coroutine = require("utils.coroutine")
  CS.UnityEngine.Screen.sleepTimeout = -2
  CS.GameToLua.CheckUpdate.OnLeave()
  game_world:init()
  Global.game_world = game_world
  if UNITY_EDITOR or UNITY_STANDALONE_WIN then
    UnityUIScrollRect.SCROLL_SENSITIVITY_MULTIPLIER = ShareRes.get_comm_value("WindowsScrollRectSensitivity")
  end
  return game_world
end
