local LuaObjPoolMgr = require("manager.res.lua_obj_pool_mgr")
local NextTimePoolClass = Util.create_class()
local _min = math.min

function NextTimePoolClass:_init(time, func, arg1, arg2, arg3, arg4)
  self.time = time
  self.func = func
  self.arg1 = arg1
  self.arg2 = arg2
  self.arg3 = arg3
  self.arg4 = arg4
end

function NextTimePoolClass:_on_destroy()
  self.time = nil
  self.func = nil
  self.arg1 = nil
  self.arg2 = nil
  self.arg3 = nil
  self.arg4 = nil
end

local UnityDontDestroyOnLoad = UnityGameObject.DontDestroyOnLoad
local UnityInstantiate = UnityGameObject.Instantiate
local Application = UnityEngine.Application
local RuntimePackage = require("manager.res.runtime_package")
local Layer = require("utils.layer")
local UnityFind = _ENV.UnityFind
local UnityDestroy = _ENV.UnityDestroy
local UnityTime = UnityEngine.Time
local UnityCurve = UnityEngine.AnimationCurve
local CSCriAtom = CS.CriWare.CriAtom
local CriAtomSource = CS.CriWare.CriAtomSource
local SOURCESTATUS = CriAtomSource.Status
local CSLipSync = typeof(CS.Game.AudioLipSyncRunner)
local TypeCriAtom = typeof(CS.CriWare.CriAtom)
local TypeCriAtomSource = typeof(CriAtomSource)
local TypeCriMovieUI = typeof(CS.CriWare.CriManaMovieControllerForUI)
local _os_time = os.time
local _tinsert = table.insert
local _tremove = table.remove
local _sformat = string.format
local UPDATE_INTERVAL = 10
local ENTRY_BGM_TIME = 3
local UPDATE_INTERVAL_MIDDLE = 1
local SWITCH_FIGHT_TRACK = 1
local SOURCE_CACHE_TIME = 50
local CLICK_SELECT_SOUND = ShareRes.get_sound_common_setting("ClickSound")
local CLICK_NOSELECT_SOUND = ShareRes.get_sound_common_setting("ClickSoundEmpty")
local LEVEL_UP_SOUND = ShareRes.get_sound_common_setting("LevelUp")
local WEAPON_LEVEL_UP = ShareRes.get_sound_common_setting("WeaponLevelUp")
local CHARACTER_LEVEL_UP = ShareRes.get_sound_common_setting("CharacterLevelUp")
local SIGN_IN_SUC = ShareRes.get_sound_common_setting("SignInSuc")
local REWARD_VICTORY = ShareRes.get_sound_common_setting("RewardVictory")
local LOGIN_BGM = ShareRes.get_sound_common_setting("LoginBgm")
local AllVolume = ShareRes.get_sound_common_setting("AllVolume")
local BgmVolume = ShareRes.get_sound_common_setting("BgmVolume")
local SfxVolume = ShareRes.get_sound_common_setting("SfxVolume")
local VoiceVolume = ShareRes.get_sound_common_setting("VoiceVolume")
local BgmFadeInOutVolume = ShareRes.get_sound_common_setting("BgmFadeInOutVolume")
local PauseVolume = ShareRes.get_sound_common_setting("PauseVolume")
local SkillVolume = ShareRes.get_sound_common_setting("SkillVolume")
local ULT_LTRFade = ShareRes.get_sound_common_setting("ULT_VoiceLTRFade")
local ULT_RTLFade = ShareRes.get_sound_common_setting("ULT_VoiceRTLFade")
local SpaceTimeChange = ShareRes.get_sound_common_setting("SpaceTimeChange")
local UISFXVolume = ShareRes.get_sound_common_setting("UISFXVolume")
local Bus1Reverb = "Bus1Reverb"
local SUC_SETTLE = "not_progress_battle_suc_settle"
local MAIN_BGM = "bgm_main"
local ACF_FILE = "CriWare.acf"
local Timer = Global.timer
local SOUND_STATUS = Config.SOUND_STATUS
local SOURCE_TYPE = Config.SOURCE_TYPE
local LOAD_STATE = {LOADING = 1, LOADED = 2}
local BusTable = {Bus1Reverb = 1, HallReverb = 2}
local Story_UI_Control = {ui_chapter_detail = true, not_progress_battle_suc_settle = true}
local NPC_KIND_STR = {
  [1] = "ROLE",
  [2] = "MONSTER",
  [3] = "ELITE",
  [4] = "BOSS",
  [5] = "TRAP",
  [6] = "OBSTRUCT",
  [7] = "SCENE_COMMON",
  [8] = "SUMMON_MONSTER",
  [9] = "EMPTY_MODEL_MONSTER"
}
local UI_BGM_SOUND_PRIORITY = {shop = 1, uidrawcard = 2}
local UI_BGM_PRIORITY = {storybgm_076 = 2, bgm_chapter_mainline = 1}
local UI_BGM_SOUND_PRIORITY_INGNORE = {award_show_panel = true}
local ANIM_EVENT_AVOID = {arder_switch = true}
local SOUND_EFFECT_OBJ_POOL_COLLECT_KEY = "SOUND_EFFECT_OBJ_POOL_COLLECT_KEY"
local SOUND_CSCALL_STOP = "loading"
local GEN_CRI_SOURCE_TYPE = {COMMON_AUDIO = 1, TIMELINE_AUDIO = 2}
local INIT_BGM_VOLUME = 1
local INIT_EFFECT_VOLUME = 1
local INIT_SPECIAL_VOLUME = 1
local INIT_VOICE_VOLUME = 1
local INIT_BGM_VOLUME_ASC = 1
local INIT_EFFECT_VOLUME_ASC = 1
local INIT_SPECIAL_VOLUME_ASC = 1
local INIT_VOICE_VOLUME_ASC = 1
local TYPE_TO_INIT_VOLUME_VAL = {
  [SOURCE_TYPE.BGM] = INIT_BGM_VOLUME,
  [SOURCE_TYPE.EFFECT] = INIT_EFFECT_VOLUME,
  [SOURCE_TYPE.SPECIAL] = INIT_SPECIAL_VOLUME,
  [SOURCE_TYPE.VOICE] = INIT_VOICE_VOLUME
}
local IMPACT_SOUND_TYPE = {
  NONE = 0,
  EFFECT = 1,
  ALL = 2
}
local COMMON_GRADIENT_SET_TYPE = {
  VOLUME = 1,
  AISAC = 2,
  BUS = 3
}
local FIGHT_BGM = {
  ENTRY = 1,
  IDLE = 2,
  BATTLE = 3
}
local SOUND_ABORT_TYPE = {
  NONE = 0,
  SELF_ABORT = 1,
  BEHIT_ABORT = 2,
  BOTH_ABORT = 3
}

local function get_resouce_path(file, is_not_lower, cue_name)
  if not is_not_lower then
    file = string.lower(file)
  end
  if not Game_AssetBundle then
    return Path.get_editor_sound_path(file, cue_name)
  else
    return RuntimePackage.get_sound_path(file, cue_name)
  end
end

local is_need_check_bgm_switch_label = false
local LOGIC_FRAME = Config.LOGIC_FRAME
local M = Util.create_class()

function M:_init()
  self.v_criware = UnityFind("CriWarePrefab")
  if not self.v_criware then
    local path = Path.get_res_path("CriWarePrefab")
    local asset, bundle = Global.res_mgr:load_raw_res(path)
    self.v_criware = UnityInstantiate(asset)
    UnityDontDestroyOnLoad(self.v_criware)
    self.v_criware.name = "CriWarePrefab"
    if bundle then
      bundle:Unload(false)
    end
    local cri_atom_obj = self.v_criware:FindChild("CriAtom")
    local cri_atom = cri_atom_obj:GetComponent(TypeCriAtom)
    cri_atom.acfFile = get_resouce_path("CriWare.acf", true)
    cri_atom:Setup()
  end
  local cri_ware_obj = self.v_criware:FindChild("CriWare")
  local atom_sources = cri_ware_obj:GetComponents(TypeCriAtomSource)
  self.v_source_bgm = atom_sources[0]
  self.v_bgm_cue_sheet = ""
  self.v_source_bgm.loop = false
  self.v_source_bgm.volume = INIT_BGM_VOLUME
  self.v_source_effect = atom_sources[1]
  self.v_source_effect.loop = false
  self.v_source_effect.volume = INIT_EFFECT_VOLUME
  self.v_source_special = atom_sources[2]
  self.v_source_special.loop = false
  self.v_source_special.volume = INIT_SPECIAL_VOLUME
  self.v_source_effect_loop = atom_sources[3]
  self.v_source_effect_loop.loop = false
  self.v_source_effect_loop.volume = INIT_EFFECT_VOLUME
  self.v_source_voice = atom_sources[4]
  self.v_source_voice.loop = false
  self.v_source_voice.volume = INIT_VOICE_VOLUME
  self.v_source_bgm2 = atom_sources[5]
  self.v_bgm2_cue_sheet = ""
  self.v_source_bgm2.loop = false
  self.v_source_bgm2.volume = INIT_BGM_VOLUME
  self.v_source_click = atom_sources[6]
  self.v_source_click.loop = false
  self.v_source_click.volume = INIT_EFFECT_VOLUME
  self.v_source_voice2 = atom_sources[7]
  self.v_source_voice2.loop = false
  self.v_source_voice2.volume = INIT_VOICE_VOLUME
  self.v_source_ui_sound = atom_sources[8]
  self.v_source_ui_sound.loop = false
  self.v_source_ui_sound.volume = INIT_EFFECT_VOLUME
  self.v_cache_sound_info = {}
  self.v_check_remove_time = _os_time()
  self.v_middle_low_update_time = self.v_check_remove_time
  self.v_change_volume = {}
  self.v_fade_sound_data = {}
  self.v_skill_sound_data = {}
  self.v_common_gradient_data = {}
  self.v_story_loop_sound = {}
  self.v_story_source = {}
  self.v_skill_sound_abort = {}
  self.v_object_source_list = {}
  self.v_object_source_cuesheet_list = {}
  self.v_delay_cb_list = {}
  self.v_delay_cb_list_high_update = {}
  self.v_sound_reverb_state = nil
  self.v_bus_level = {}
  self.v_switch_idle_track = 0
  self.v_criware_obj_list = {}
  self.v_criware_obj_list_fade = {}
  self.v_gen_criware_source = setmetatable({}, Global.config.KEY_WEAK_METATABLE)
  self.v_common_audio_active = true
  self:register_event()
  self:set_sound_reverb_state(false)
  self.v_fixed_source = {
    self.v_source_bgm,
    self.v_source_effect,
    self.v_source_special,
    self.v_source_effect_loop,
    self.v_source_voice,
    self.v_source_bgm2,
    self.v_source_click,
    self.v_source_voice2
  }
  self:clear_ui_sound_timer()
  self.v_effect_obj_pool_collect = {}
  self.v_effect_obj_pool_root = self.v_criware:FindChild("CriObjCache")
  self.v_effect_obj_pool_nodeTemp = self.v_criware:FindChild("CriObjCache/NodeTempParent/NodeTemp")
  self.v_effect_obj_pool_nodeParent = self.v_criware:FindChild("CriObjCache/NodeTempParent").transform
  CacheMgr:register_exist_template(SOUND_EFFECT_OBJ_POOL_COLLECT_KEY, self.v_effect_obj_pool_nodeTemp, self.v_effect_obj_pool_root, 20)
  self.v_is_story_sound = {}
end

function M:get_effect_criobj_cache()
  local cache = CacheMgr:pop_from_cache(SOUND_EFFECT_OBJ_POOL_COLLECT_KEY)
  local cache_id = cache:GetInstanceID()
  local cache_ref_info = self.v_effect_obj_pool_collect[cache_id]
  if nil == cache_ref_info then
    cache_ref_info = cache:GetComponents(TypeCriAtomSource)
    self.v_effect_obj_pool_collect[cache_id] = cache_ref_info
  end
  return cache, cache_ref_info
end

function M:release_effect_criobj_cache(obj)
  if Util.is_nil(obj) then
    return
  end
  self:stop_sound(obj)
  obj.transform:SetParent(self.v_effect_obj_pool_nodeParent)
  obj.transform:SetPositionA(0, 0, 0)
  CacheMgr:push_to_cache(SOUND_EFFECT_OBJ_POOL_COLLECT_KEY, obj.gameObject)
end

function M:register_event()
  Util.bind_msg(self, Const.MSG_ON_OPEN_SETTLE_UI, self.on_open_settle_ui, self)
  Util.bind_msg(self, Const.MSG_ON_CLOSE_SETTLE_UI, self.on_close_settle_ui, self)
  Util.bind_msg(self, Const.MSG_ON_SHOW_UI, self.switch_ui_on_show, self)
  Util.bind_msg(self, Const.MSG_ON_HIDE_UI, self.switch_ui_on_hide, self)
end

function M:creat_pool_mgr()
  if self.v_pool_mgr then
    return
  end
  self.v_pool_mgr = LuaObjPoolMgr.register("sound_mgr", 10, NextTimePoolClass)
end

function M:add(func, arg1, arg2, arg3, arg4)
  self:creat_pool_mgr()
  local time = GlobalTimeMgr:get_time() + LOGIC_FRAME
  self.v_pool_mgr:new_obj(time, func, arg1, arg2, arg3, arg4)
end

function M:update_pool_mgr_list()
  if not self.v_pool_mgr then
    return
  end
  local now_time = UnityTime.realtimeSinceStartup
  local active_objs = self.v_pool_mgr:get_active_objs()
  for obj in pairs(active_objs) do
    if now_time >= obj.time then
      local succ, msg = pcall(obj.func, obj.arg1, obj.arg2, obj.arg3, obj.arg4)
      if not succ then
        Log.Error(msg)
      end
      self.v_pool_mgr:destroy_obj(obj)
    end
  end
end

function M:update()
  self:update_pool_mgr_list()
  self:update_delay_task_cb_high_update()
  self:very_low_update()
  if self.v_is_fight then
    self:middle_low_update()
  end
  self:update_volume_val()
  self:switch_bgm()
  self:voice_up_or_down()
  self:update_fade_data()
  self:update_story_loop_sound()
  self:update_common_gradient()
end

function M:update_volume_val()
  local volume_num = UtilTable.hash_lenth(self.v_change_volume)
  if volume_num <= 0 then
    return
  end
  local end_list = {}
  for source_type, volume_data in pairs(self.v_change_volume) do
    local curve = volume_data.curve
    volume_data.time = volume_data.time or 0
    if volume_data.time < volume_data.end_time and curve then
      local val = curve:Evaluate(volume_data.time)
      self:set_source_volume_val(source_type, val)
      volume_data.time = volume_data.time + LOGIC_FRAME
    else
      end_list[source_type] = true
    end
  end
  for source_type, _ in pairs(end_list) do
    self.v_change_volume[source_type] = nil
  end
end

function M:set_source_volume_val(source_type, val)
  local sound_source
  local val_asc = val
  val = BattleSettingMgr:get_voice_main()
  if source_type == SOURCE_TYPE.BGM then
    self.v_source_bgm.volume = val
    self.v_init_bgm_volume = val
    self.v_source_bgm2.volume = val
    INIT_BGM_VOLUME = val
    INIT_BGM_VOLUME_ASC = val_asc
    self:set_source_asc(self.v_source_bgm)
    self:set_source_asc(self.v_source_bgm2)
  elseif source_type == SOURCE_TYPE.EFFECT then
    sound_source = self.v_source_effect
    self.v_source_click.volume = val
    self.v_init_effect_volume = val
    self.v_source_ui_sound.volume = val
    INIT_EFFECT_VOLUME = val
    INIT_EFFECT_VOLUME_ASC = val_asc
    self:set_source_asc(self.v_source_click)
    self:set_source_asc(self.v_source_ui_sound)
  elseif source_type == SOURCE_TYPE.SPECIAL then
    sound_source = self.v_source_special
    INIT_SPECIAL_VOLUME = val
    INIT_SPECIAL_VOLUME_ASC = val_asc
  elseif source_type == SOURCE_TYPE.VOICE then
    sound_source = self.v_source_voice
    self.v_source_voice2.volume = val
    INIT_VOICE_VOLUME = val
    INIT_VOICE_VOLUME_ASC = val_asc
    self:set_source_asc(self.v_source_voice2)
  end
  if not sound_source then
    return
  end
  sound_source.volume = val
end

function M:set_source_asc(sound_source)
  self:set_aisac_control(sound_source, BgmVolume, INIT_BGM_VOLUME_ASC)
  self:set_aisac_control(sound_source, SfxVolume, INIT_EFFECT_VOLUME_ASC)
  self:set_aisac_control(sound_source, VoiceVolume, INIT_VOICE_VOLUME_ASC)
  self:set_aisac_control(sound_source, UISFXVolume, 1 - INIT_EFFECT_VOLUME_ASC)
end

function M:switch_bgm()
  if not self.v_switch_bgm_data then
    return
  end
  local switch_data = self.v_switch_bgm_data
  switch_data.time = switch_data.time or 0
  if switch_data.time >= switch_data.end_time then
    self.v_switch_bgm_data = nil
    if switch_data.callback then
      switch_data.callback()
    end
    return
  end
  local curve = switch_data.curve
  local new_volume = curve:Evaluate(switch_data.time)
  switch_data.time = switch_data.time + LOGIC_FRAME
  if switch_data.source_type == SOURCE_TYPE.BGM then
    self.v_source_bgm.volume = new_volume
  end
end

function M:voice_up_or_down()
  if not self.v_voice_up_or_down_data then
    return
  end
  local switch_data = self.v_voice_up_or_down_data
  switch_data.time = switch_data.time or 0
  if switch_data.time >= switch_data.end_time then
    self.v_voice_up_or_down_data = nil
    if switch_data.callback then
      switch_data.callback()
    end
    return
  end
  local curve = switch_data.curve
  local new_volume = curve:Evaluate(switch_data.time)
  switch_data.time = switch_data.time + LOGIC_FRAME
  if switch_data.source_type == SOURCE_TYPE.VOICE then
    self.v_source_voice.volume = new_volume
  end
end

function M:very_low_update()
  local now_time = _os_time()
  if now_time < self.v_check_remove_time then
    return
  end
  self.v_check_remove_time = now_time + UPDATE_INTERVAL
  local remove_list = {}
  for cue_sheet, info in pairs(self.v_cache_sound_info) do
    if info.cache_time and now_time > info.cache_time then
      self:remove_cue_sheet(cue_sheet)
    end
  end
  self:update_delay_task_cb(now_time)
end

function M:update_delay_task_cb(now_time)
  for index = #self.v_delay_cb_list, 1, -1 do
    local data = self.v_delay_cb_list[index]
    if now_time >= data.delay_time then
      if data.cb then
        data.cb()
      end
      _tremove(self.v_delay_cb_list, index)
    end
  end
end

function M:set_delay_task(delay_time, cb)
  local cb_data = {
    delay_time = _os_time() + delay_time,
    cb = cb
  }
  _tinsert(self.v_delay_cb_list, cb_data)
end

function M:update_delay_task_cb_high_update()
  for index = #self.v_delay_cb_list_high_update, 1, -1 do
    local data = self.v_delay_cb_list_high_update[index]
    if data.cur_time >= data.delay_time then
      if data.cb then
        data.cb()
      end
      _tremove(self.v_delay_cb_list_high_update, index)
    elseif data.get_time_update and data.get_time_update() then
      data.cur_time = data.cur_time + data.get_time_update()
    else
      data.cur_time = _os_time()
    end
  end
end

function M:set_delay_task_high_update(delay_time, cb, get_time_update)
  local cb_data = {
    cur_time = _os_time(),
    delay_time = _os_time() + delay_time,
    cb = cb,
    get_time_update = get_time_update
  }
  _tinsert(self.v_delay_cb_list_high_update, cb_data)
end

function M:middle_low_update()
  if not Global.hero then
    return
  end
  if not self.v_fight_bgm then
    return
  end
  if self.v_fight_bgm ~= self.v_source_bgm.cueSheet then
    return
  end
  local now_time = _os_time()
  if now_time < self.v_middle_low_update_time then
    return
  end
  local cue_sheet = self.v_fight_bgm
  local cue_name = ShareRes.get_sound_cfg_by_index(cue_sheet, FIGHT_BGM.ENTRY)
  local cue_index = FIGHT_BGM.ENTRY
  local res_cue_name = ""
  if is_need_check_bgm_switch_label and TowerMgr and TowerMgr:get_tower() and TowerMgr:get_tower():get_tower_enter_time() < ENTRY_BGM_TIME then
    self:refresh_switch_label_state(false)
    self.v_pre_index = FIGHT_BGM.ENTRY
    self.v_middle_low_update_time = now_time + ENTRY_BGM_TIME
    self:switch_label_with_fight_bgm(cue_sheet, cue_name)
    return
  else
    self.v_middle_low_update_time = now_time + UPDATE_INTERVAL_MIDDLE
  end
  if not self.v_bgm_cue_sheet or "" == self.v_bgm_cue_sheet then
    return
  end
  if Global.hero and not Global.hero:is_destroy() and SceneMgr:check_our_camp_betarget() then
    res_cue_name = ShareRes.get_sound_cfg_by_index(cue_sheet, FIGHT_BGM.BATTLE)
    if "" == res_cue_name or nil == res_cue_name then
      return
    else
      cue_index = FIGHT_BGM.BATTLE
      cue_name = res_cue_name
    end
    if self.v_pre_index ~= cue_index then
      self.v_pre_index = cue_index
      self:switch_label_with_fight_bgm(cue_sheet, cue_name)
      self.v_switch_idle_track = 0
    end
  else
    res_cue_name = ShareRes.get_sound_cfg_by_index(cue_sheet, FIGHT_BGM.IDLE)
    if "" == res_cue_name or nil == res_cue_name then
      return
    else
      cue_index = FIGHT_BGM.IDLE
      cue_name = res_cue_name
    end
    if self.v_switch_idle_track > SWITCH_FIGHT_TRACK then
      if self.v_pre_index ~= cue_index then
        self.v_pre_index = cue_index
        self:switch_label_with_fight_bgm(cue_sheet, cue_name)
      end
      self.v_switch_idle_track = 0
    else
      self.v_switch_idle_track = self.v_switch_idle_track + 1
    end
  end
end

function M:switch_label_with_fight_bgm(cue_sheet, cue_name)
  self.v_source_bgm:SwitchLabel(cue_sheet, cue_name)
end

function M:enter_tower_flag()
  self.v_fight_bgm = nil
end

local sound_data_param = {}

function M:play_sound_by_id(id, cache_time, callback, is_story, fixed_source, loop_data, is_bgm2, cue_name, preload)
  local sound_acd, sound_name, sound_type, label_switch, is_stream, bgm_no_loop, bus_level = ShareRes.get_play_sound_info(id)
  if cue_name then
    sound_name = cue_name
  end
  if not sound_name or "" == sound_name then
    return
  end
  if is_bgm2 or sound_type == SOURCE_TYPE.BGM2 then
    sound_type = SOURCE_TYPE.BGM2
    cache_time = cache_time or -1
    self:start_environment_bgm(-1)
  end
  if sound_type == SOURCE_TYPE.BGM then
    if bgm_no_loop then
      loop_data = {}
      loop_data.loop = false
    else
      loop_data = {}
      loop_data.loop = true
    end
    cache_time = cache_time or -1
  end
  if sound_type == SOURCE_TYPE.BGM and not is_story then
    self.v_last_bgm_id = id
    self.v_is_fight = false
    if TowerMgr then
      local tower = TowerMgr:get_tower()
      if tower then
        self.v_fight_bgm = sound_acd
        if label_switch then
          self.v_is_fight = true
        end
      end
    end
  end
  if sound_type == SOURCE_TYPE.BGM then
    self.v_cur_bgm_id = id
  end
  self:reset_source_starttime(fixed_source, sound_type)
  sound_data_param.cue_sheet = sound_acd
  sound_data_param.cue_name = sound_name
  sound_data_param.source_type = sound_type
  sound_data_param.cache_time = cache_time
  sound_data_param.load_callback = callback
  sound_data_param.fixed_source = fixed_source
  sound_data_param.loop_data = loop_data
  sound_data_param.is_stream = is_stream
  sound_data_param.label_switch = label_switch
  sound_data_param.preload = preload
  sound_data_param.bus_level = bus_level
  self:play_sound(sound_data_param)
  return sound_type, sound_acd
end

function M:play_sound(data)
  if DebugSetting:is_no_play_sound() then
    return
  end
  local cue_sheet = data.cue_sheet
  local cue_name = data.cue_name
  local source_type = data.source_type
  local cache_time = data.cache_time
  local load_callback = data.load_callback
  local fixed_source = data.fixed_source
  local loop_data = data.loop_data
  local is_stream = data.is_stream
  local label_switch = data.label_switch
  local preload = data.preload
  local bus_level = data.bus_level or 0
  if not cue_sheet or not cue_name then
    return
  end
  local sound_info = self.v_cache_sound_info[cue_sheet]
  if sound_info and sound_info.load_state == LOAD_STATE.LOADING then
    self.v_loaded_callback_sound = self.v_loaded_callback_sound or {}
    local play_data = {}
    for key, value in pairs(data) do
      play_data[key] = value
    end
    
    local function sound_loaded_callback()
      if fixed_source and Util.is_nil(fixed_source) then
        return
      end
      self:play_sound(play_data)
    end
    
    self.v_loaded_callback_sound[cue_sheet] = self.v_loaded_callback_sound[cue_sheet] or {}
    _tinsert(self.v_loaded_callback_sound[cue_sheet], sound_loaded_callback)
    if #self.v_loaded_callback_sound[cue_sheet] > 1000 then
      self.v_loaded_callback_sound[cue_sheet] = nil
      Log.Error("Too many of loaded callback sound, check out the logic !!!")
    end
    return
  end
  source_type = source_type or SOURCE_TYPE.EFFECT
  if source_type == SOURCE_TYPE.BGM and not self:check_remove_bgm(cue_sheet, cue_name) then
    return
  end
  if source_type == SOURCE_TYPE.BGM2 and not self:check_remove_bgm2(cue_sheet, cue_name) then
    return
  end
  sound_info = sound_info or {
    cue_sheet = cue_sheet,
    load_state = LOAD_STATE.LOADING,
    source_type = source_type
  }
  cache_time = cache_time or SOURCE_CACHE_TIME
  sound_info.cache_time = _os_time() + cache_time
  if self.v_object_source_cuesheet_list[cue_sheet] and self.v_object_source_cuesheet_list[cue_sheet] > 0 then
    sound_info.cache_time = nil
  end
  if cache_time < 0 or sound_info.preload then
    sound_info.cache_time = nil
  end
  sound_info.cue_name = cue_name
  self.v_cache_sound_info[cue_sheet] = sound_info
  if sound_info.load_state == LOAD_STATE.LOADED then
    if load_callback then
      local time = CompExtensions.GetSoundLength(cue_sheet, cue_name)
      load_callback(time)
    end
    self:_play_sound(sound_info, source_type, fixed_source, loop_data, is_stream, label_switch, preload, bus_level)
    return
  end
  local cue_sheet_path = get_resouce_path(cue_sheet .. ".acb", nil, cue_name)
  local cue_awb_path = ""
  if is_stream then
    cue_awb_path = get_resouce_path(cue_sheet .. ".awb", nil, cue_name)
  end
  if not cue_sheet_path then
    return
  end
  
  local function callback()
    local cur_sheet = self.v_cache_sound_info[cue_sheet].cue_sheet
    if not self:check_play(self.v_cache_sound_info[cue_sheet].cue_sheet) then
      return
    end
    self.v_cache_sound_info[cue_sheet].load_state = LOAD_STATE.LOADED
    self:_play_sound(self.v_cache_sound_info[cue_sheet], source_type, fixed_source, loop_data, is_stream, label_switch, preload, bus_level)
    if load_callback then
      local time = CompExtensions.GetSoundLength(cue_sheet, cue_name)
      load_callback(time)
    end
    self:check_play_loading_sound(cur_sheet)
  end
  
  CompExtensions.LoadSound(callback, cue_sheet, cue_sheet_path, cue_name, cue_awb_path)
end

function M:pause_sound_by_id(id, is_pause, not_play)
  if not is_pause and not not_play then
    self:play_sound_by_id(id)
  end
  local sound_acd, sound_name, sound_type = ShareRes.get_play_sound_info(id)
  if not sound_type then
    return
  end
  local sound_source = self:get_sound_source_by_type(sound_type)
  sound_source:Pause(is_pause)
end

function M:check_play_loading_sound(cur_sheet)
  if not self.v_loaded_callback_sound or not self.v_loaded_callback_sound[cur_sheet] then
    return
  end
  local target_loaded = self.v_loaded_callback_sound[cur_sheet]
  for _, loaded_callback in pairs(target_loaded) do
    if loaded_callback then
      loaded_callback()
    end
  end
  self.v_loaded_callback_sound[cur_sheet] = nil
end

function M:check_remove_bgm(cue_sheet, cue_name)
  if self.v_bgm_cue_sheet == cue_sheet then
    if self.v_bgm_cue_name ~= cue_name then
      self.v_bgm_cue_name = cue_name
      self:stop_sound_by_type(SOURCE_TYPE.BGM)
      return true
    elseif self.v_has_stop_play_bgm then
      self.v_has_stop_play_bgm = nil
      return true
    end
    return
  end
  self:bgm_stop()
  self.v_bgm_cue_sheet = cue_sheet
  return true
end

function M:check_remove_bgm2(cue_sheet, cue_name)
  if self.v_bgm2_cue_sheet == cue_sheet then
    if self.v_bgm2_cue_name ~= cue_name then
      self.v_bgm2_cue_name = cue_name
      self:stop_sound_by_type(SOURCE_TYPE.BGM2)
      return true
    end
    return
  end
  self:bgm2_stop()
  self.v_bgm2_cue_sheet = cue_sheet
  return true
end

function M:check_play(sheet)
  if not sheet or not self.v_cache_sound_info[sheet] then
    return
  end
  return true
end

function M:reset_source_starttime(fixed_source, source_type)
  local sound_source
  if not fixed_source then
    sound_source = self:get_sound_source_by_type(source_type)
  elseif type(fixed_source) == "number" then
    sound_source = self:get_sound_source_by_type(fixed_source)
  else
    sound_source = fixed_source
  end
  if sound_source.startTime > 0.1 then
    sound_source.startTime = 0
  end
end

function M:_play_sound(sound_info, source_type, fixed_source, loop_data, is_stream, label_switch, preload, bus_level)
  if not self:check_play(sound_info.cue_sheet) then
    return
  end
  local sound_source
  if not fixed_source then
    sound_source = self:get_sound_source_by_type(source_type)
  elseif type(fixed_source) == "number" then
    sound_source = self:get_sound_source_by_type(fixed_source)
  else
    sound_source = fixed_source
  end
  if not self:check_source_is_need_play(sound_source, sound_info.cue_name) then
    return
  end
  if loop_data then
    sound_source.loop = loop_data.loop
  end
  sound_source.cueSheet = sound_info.cue_sheet
  sound_source.cueName = sound_info.cue_name
  if source_type == SOURCE_TYPE.BGM then
    self.v_cur_bgm_id = sound_info.cue_name
    self.v_bgm_cue_sheet = sound_info.cue_sheet
    self.v_bgm_cue_name = sound_info.cue_name
    self.v_has_stop_play_bgm = nil
    self:stop_sound_by_type(SOURCE_TYPE.BGM)
    if self.v_stop_bgm then
      self.v_source_bgm.volume = 0
    end
    if self.v_is_play_story_bgm then
      self.v_source_bgm.volume = INIT_BGM_VOLUME
    end
    sound_info.cache_time = nil
  end
  if source_type == SOURCE_TYPE.BGM2 then
    self.v_source_bgm2:Pause(false)
  end
  self:set_source_asc(sound_source)
  if not preload and not Util.is_nil(sound_source) then
    if is_stream then
      CSHelper.PlaySoundByCommon(sound_source)
    elseif self.v_is_story_sound[sound_info.cue_name] then
      CSHelper.PlaySound(sound_source)
    else
      CSHelper.PlaySoundByCustom(sound_source)
    end
  end
  if source_type == SOURCE_TYPE.BGM and label_switch then
    self:reset_fight_bgm_to_idle()
  end
  local set_bus
  for busname, _ in pairs(BusTable) do
    set_bus = self.v_bus_level[busname]
    if nil ~= set_bus then
      sound_source:SetBusSendLevel(busname, set_bus * bus_level)
    end
  end
end

function M:check_source_is_need_play(sound_source, cue_name, source_type)
  if source_type ~= SOURCE_TYPE.CLICK then
    return true
  end
  if sound_source.cueName == cue_name and sound_source.status == SOURCESTATUS.Playing then
    return false
  end
  return true
end

function M:get_sound_source_by_type(source_type)
  local sound_source
  if source_type == SOURCE_TYPE.EFFECT then
    sound_source = self.v_source_effect
  elseif source_type == SOURCE_TYPE.BGM then
    sound_source = self.v_source_bgm
  elseif source_type == SOURCE_TYPE.BGM2 then
    sound_source = self.v_source_bgm2
  elseif source_type == SOURCE_TYPE.SPECIAL then
    sound_source = self.v_source_special
  elseif source_type == SOURCE_TYPE.EFFECT_LOOP then
    sound_source = self.v_source_effect_loop
  elseif source_type == SOURCE_TYPE.VOICE then
    sound_source = self.v_source_voice
  elseif source_type == SOURCE_TYPE.CLICK then
    sound_source = self.v_source_click
  elseif source_type == SOURCE_TYPE.VOICE2 then
    sound_source = self.v_source_voice2
  elseif source_type == SOURCE_TYPE.UI_SOUND then
    sound_source = self.v_source_ui_sound
  end
  return sound_source
end

function M:get_source_state_by_sound_id(sound_id)
  local _, _, source_type = ShareRes.get_play_sound_info(sound_id)
  local sound_source = self:get_sound_source_by_type(source_type)
  return sound_source
end

function M:check_source_play_status(status, source_type, sound_id)
  local sound_source
  if source_type then
    sound_source = self:get_sound_source_by_type(source_type)
  elseif sound_id then
    sound_source = self:get_source_state_by_sound_id(sound_id)
  end
  if not sound_source then
    return
  end
  local cur_status = sound_source.status
  local check_state
  if status == SOUND_STATUS.PLAYING then
    check_state = SOURCESTATUS.Playing
  end
  return cur_status == check_state
end

function M:remove_cue_sheet(cue_sheet)
  self.v_cache_sound_info[cue_sheet] = nil
  CSCriAtom.RemoveCueSheet(cue_sheet)
end

function M:remove_cache_voice_sound()
  for sheet, info in pairs(self.v_cache_sound_info) do
    if info and (info.source_type == SOURCE_TYPE.EFFECT or info.source_type == SOURCE_TYPE.VOICE or info.source_type == SOURCE_TYPE.VOICE2) then
      self:remove_cue_sheet(sheet)
    end
  end
end

function M:remove_all_cue_sheet()
  for sheet, info in pairs(self.v_cache_sound_info) do
    if info then
      self:remove_cue_sheet(sheet)
    end
  end
end

function M:ani_key_frame_event(data)
  local list = Util.split_str(data, ",")
  local sound_id = list[1]
  if list[2] and not Util.is_empty(list[2]) then
    sound_id = tonumber(sound_id)
  end
  self:play_sound_by_id(sound_id)
end

function M:sound_abort(is_scene)
  self:effect_stop()
  if is_scene then
    self:bgm_stop()
  end
end

function M:effect_stop()
  self:stop_sound_by_type(SOURCE_TYPE.EFFECT)
end

function M:voice_stop()
  self:stop_sound_by_type(SOURCE_TYPE.VOICE)
end

function M:bgm_stop(force_remove)
  if self.v_sound_in_fade_out then
    force_remove = true
    self.v_sound_in_fade_out = nil
  end
  self:stop_sound_by_type(SOURCE_TYPE.BGM)
  if self.v_bgm_cue_sheet and self.v_bgm_cue_sheet ~= "" then
    if force_remove then
      self:remove_cue_sheet(self.v_bgm_cue_sheet)
    else
      local sound_info = self.v_cache_sound_info[self.v_bgm_cue_sheet]
      if sound_info then
        sound_info.cache_time = _os_time() + SOURCE_CACHE_TIME
      end
    end
    self.v_bgm_cue_sheet = ""
    self.v_source_bgm.loop = true
    self.v_cur_bgm_id = nil
  end
end

function M:bgm2_stop()
  self:stop_sound_by_type(SOURCE_TYPE.BGM2)
  if self.v_bgm2_cue_sheet and self.v_bgm2_cue_sheet ~= "" then
    local sound_info = self.v_cache_sound_info[self.v_bgm2_cue_sheet]
    if sound_info then
      sound_info.cache_time = _os_time() + SOURCE_CACHE_TIME
    end
    self.v_bgm2_cue_sheet = ""
  end
end

function M:stop_sound_by_type(source_type, is_pause)
  local sound_source
  if source_type == SOURCE_TYPE.EFFECT then
    sound_source = self.v_source_effect
  elseif source_type == SOURCE_TYPE.BGM then
    sound_source = self.v_source_bgm
  elseif source_type == SOURCE_TYPE.BGM2 then
    sound_source = self.v_source_bgm2
  elseif source_type == SOURCE_TYPE.SPECIAL then
    sound_source = self.v_source_special
  elseif source_type == SOURCE_TYPE.EFFECT_LOOP then
    sound_source = self.v_source_effect_loop
  elseif source_type == SOURCE_TYPE.VOICE then
    sound_source = self.v_source_voice
  elseif source_type == SOURCE_TYPE.CLICK then
    sound_source = self.v_source_click
  elseif source_type == SOURCE_TYPE.VOICE2 then
    sound_source = self.v_source_voice2
  elseif source_type == SOURCE_TYPE.UI_SOUND then
    sound_source = self.v_source_ui_sound
  end
  if nil ~= sound_source then
    sound_source:Stop()
  end
end

function M:change_sound_speed(speed, impact_sound_type, impact_sound_volume)
  local impact_effect = false
  local impact_bgm = false
  if impact_sound_type == IMPACT_SOUND_TYPE.EFFECT then
    impact_effect = true
  elseif impact_sound_type == IMPACT_SOUND_TYPE.ALL then
    impact_effect = true
    impact_bgm = true
  end
  speed = 0 ~= speed and speed or 1
  if speed >= 1 then
    impact_effect = true
    impact_bgm = true
  end
  if impact_effect then
    self.v_source_effect.player:SetDspTimeStretchRatio(1 / speed)
    self.v_source_effect.player:UpdateAll()
    local effect_volume = impact_sound_volume and impact_sound_volume or INIT_EFFECT_VOLUME
    self.v_source_effect.volume = speed < 1 and effect_volume or INIT_EFFECT_VOLUME
  end
  if impact_bgm then
    self.v_source_bgm.player:SetDspTimeStretchRatio(1 / speed)
    self.v_source_bgm.player:UpdateAll()
    local bgm_volume = impact_sound_volume and impact_sound_volume or INIT_BGM_VOLUME
    if not self.v_stop_bgm then
      self.v_source_bgm.volume = speed < 1 and bgm_volume or INIT_BGM_VOLUME
    end
  end
end

function M:change_story_sound_speed(speed, target_type)
  if target_type == SOURCE_TYPE.BGM or target_type == SOURCE_TYPE.BGM then
    return
  end
  local source = self:get_sound_source_by_type(target_type)
  source.player:SetDspTimeStretchRatio(1 / speed)
  source.player:UpdateAll()
end

function M:reset_story_sound_speed(target_type)
  if target_type == SOURCE_TYPE.BGM or target_type == SOURCE_TYPE.BGM then
    return
  end
  local source = self:get_sound_source_by_type(target_type)
  source.player:SetDspTimeStretchRatio(1)
  source.player:UpdateAll()
end

function M:application_pause_sound(is_pause)
  local bgm_cursheet = self.v_source_bgm.cueSheet
  if not bgm_cursheet or "" == bgm_cursheet then
    return
  end
  if is_pause then
    self.v_source_bgm:Pause(true)
  else
    self.v_source_bgm:Pause(false)
  end
end

function M:play_ui_movie(obj, file, callback)
  local path = get_resouce_path(file)
  local movie_controller = obj:GetComponent(TypeCriMovieUI)
  CompExtensions.SetPlayMovieFile(movie_controller, path, callback)
  self:add(function()
    movie_controller:Play()
  end)
end

function M:stop_ui_movie(obj)
  local movie_controller = obj:GetComponent(TypeCriMovieUI)
  movie_controller:Stop()
  local material = movie_controller.material
  if not material:IsNull() then
    UnityDestroy(material)
  end
end

function M:play_video(videoplayer, file)
  local path = get_resouce_path(file, true)
  if not Util.is_empty(path) then
    videoplayer.url = path
  else
    Log.Error("加载失败")
  end
end

function M:check_sound_name_file_exist(sound_name)
  local sound_acb = ShareRes.get_play_sound_info(sound_name)
  return get_resouce_path(sound_acb .. ".acb")
end

function M:switch_fight_bgm(bgm_id, volume, fadeout_time)
  local sound_acd, sound_name = ShareRes.get_play_sound_info(bgm_id)
  if not sound_acd or not sound_name then
    Log.Error("音效配置丢失 = ", bgm_id)
    return
  end
  
  local function callback()
    self.v_source_bgm.volume = INIT_BGM_VOLUME
    self:play_sound(sound_acd, sound_name, SOURCE_TYPE.BGM)
  end
  
  fadeout_time = fadeout_time or 1
  self.v_switch_bgm_data = {
    source_type = SOURCE_TYPE.BGM,
    end_time = fadeout_time,
    curve = UnityCurve.Linear(0, INIT_BGM_VOLUME, fadeout_time, 0),
    callback = callback
  }
  INIT_BGM_VOLUME = volume
end

function M:set_source_volume(source_type, lerp_time, target_volume)
  self.is_lerp = true
  local init_val = TYPE_TO_INIT_VOLUME_VAL[source_type]
  Util.assert(init_val, "ERRO SOURCE TYPE = " .. source_type)
  self.v_change_volume[source_type] = {
    source_type = source_type,
    end_time = lerp_time,
    curve = UnityCurve.Linear(0, init_val, lerp_time, target_volume)
  }
end

function M:play_common_sound(sound_id)
  self:play_sound_by_id(sound_id)
end

function M:missile_sound(missile, sound_id, npc_kind)
  local missile_owner = missile:get_owner()
  if missile_owner and missile_owner:is_role() then
    sound_id = ShareRes.get_sound_map_by_fashion_id(sound_id, missile_owner:get_fashion_id())
  end
  local gameobj = missile.gameobj
  if Util.is_nil(gameobj) then
    return
  end
  local cri_atom_source = gameobj:GetComponent(TypeCriAtomSource)
  cri_atom_source = cri_atom_source or gameobj:AddComponent(TypeCriAtomSource)
  cri_atom_source.volume = INIT_EFFECT_VOLUME
  if npc_kind then
    sound_id = self:rep_check_sound_id(sound_id, nil, npc_kind)
  end
  self:play_sound_by_id(sound_id, nil, nil, nil, cri_atom_source)
end

function M:skill_key_frame_play_sound(npc, sound_id, binding_obj, remove_time, abort_type)
  local instance_id = npc.transform:GetInstanceID()
  local char_id = npc.character_cfg.AttribId
  local cri_atom_source
  local source_data = self.v_skill_sound_data[instance_id]
  local go
  if not source_data then
    go = self:new_empty_obj()
    go.name = "KeyFrameSound" .. char_id
    self.v_skill_sound_data[instance_id] = {
      npc = npc,
      source_obj = go,
      start_time = UnityTime.realtimeSinceStartup,
      remove_time = remove_time
    }
  else
    go = source_data.source_obj
    source_data.remove_time = remove_time
    source_data.start_time = UnityTime.realtimeSinceStartup
    source_data.remove_parent = false
  end
  binding_obj = npc
  if not binding_obj then
    UnityGameObject.DontDestroyOnLoad(go)
    local pos_x, pos_y, pos_z = npc:get_pos()
    go.transform:SetPositionA(pos_x, pos_y, pos_z)
  else
    go.transform:SetParent(binding_obj.transform)
    go.transform:SetLocalPositionA(0, 0, 0)
  end
  cri_atom_source = go:GetComponent(TypeCriAtomSource)
  cri_atom_source.volume = INIT_EFFECT_VOLUME
  local cache_time = 5
  self.v_skill_sound_abort[instance_id] = self.v_skill_sound_abort[instance_id] or {}
  if abort_type and abort_type > SOUND_ABORT_TYPE.NONE then
    cache_time = -1
    local cue_sheet = ShareRes.get_play_sound_info(sound_id)
    local tb = {cue_sheet = cue_sheet, abort_type = abort_type}
    _tinsert(self.v_skill_sound_abort[instance_id], tb)
  else
    self:remove_fade_source_data(cri_atom_source)
  end
  self:set_aisac_control(cri_atom_source, SkillVolume, 1)
  self:play_sound_by_id(sound_id, cache_time, nil, nil, cri_atom_source)
end

function M:update_remove_binding_time()
  local now_time = UnityTime.realtimeSinceStartup
  for _, data in pairs(self.v_skill_sound_data) do
    local remove_time = data.remove_time
    if not data.remove_parent and remove_time <= now_time - data.start_time then
      local pos_x, pos_y, pos_z = data.npc:get_pos()
      data.source_obj.transform:SetPositionA(pos_x, pos_y, pos_z)
      data.remove_parent = true
    end
  end
end

function M:new_empty_obj()
  local go = UnityGameObject()
  go:AddComponent(TypeCriAtomSource)
  return go
end

function M:new_cri_obj(cri_name)
  local go = UnityGameObject()
  go.name = cri_name
  local cri = go:AddComponent(TypeCriAtomSource)
  return go, cri
end

function M:abort_skill_sound(lua_obj, fade_time, abort_type)
  local instance_id = lua_obj.transform:GetInstanceID()
  if not self.v_skill_sound_abort[instance_id] then
    return
  end
  local sound_data = self.v_skill_sound_data[instance_id]
  local source_obj
  if sound_data then
    source_obj = sound_data.source_obj
  end
  if source_obj and not source_obj:IsNull() then
    local cri_atom_source = source_obj:GetComponent(TypeCriAtomSource)
    if cri_atom_source then
      self:insert_fade_data(cri_atom_source, fade_time, nil, nil, nil, instance_id, abort_type)
    end
  end
  local char_cri_atom_source = lua_obj.gameobj:GetComponent(TypeCriAtomSource)
  if char_cri_atom_source then
    self:insert_fade_data(char_cri_atom_source, fade_time)
  end
end

function M:insert_fade_data(cri_atom_source, fade_time, start_val, target_val, suc_cb, instance_id, abort_type, aisac_control_name)
  local now_time = Global.real_time
  start_val = start_val or BattleSettingMgr:get_voice_main()
  if self.v_stop_bgm then
    start_val = cri_atom_source.volume
  end
  target_val = target_val or 0
  
  local function abort_func()
    if instance_id and self.v_skill_sound_abort[instance_id] then
      for _, sound_abort_info in pairs(self.v_skill_sound_abort[instance_id]) do
        if not Util.is_nil(cri_atom_source) then
          cri_atom_source:Stop()
        else
          self:remove_cue_sheet(sound_abort_info.cue_sheet)
        end
      end
      self.v_skill_sound_abort[instance_id] = nil
    end
  end
  
  if not fade_time or fade_time <= 0 then
    if abort_type and abort_type > 0 then
      cri_atom_source:Stop()
    end
    abort_func()
  else
    local last_val = self:remove_fade_source_data(cri_atom_source)
    start_val = last_val >= 0 and last_val or start_val
    
    local function suc_cb_addition()
      if suc_cb then
        suc_cb()
      end
      abort_func()
    end
    
    local fade_data = {
      cri_atom_source = cri_atom_source,
      end_time = fade_time,
      start_time = now_time,
      curve = UnityCurve.Linear(0, start_val, fade_time, target_val),
      suc_cb = suc_cb_addition
    }
    if aisac_control_name then
      local aisac_start_volume = 1 - self:get_aisac_value(cri_atom_source, aisac_control_name)
      fade_data.aisac_control_name = aisac_control_name
      fade_data.curve_aisac = UnityCurve.Linear(0, aisac_start_volume, fade_time, target_val)
    end
    _tinsert(self.v_fade_sound_data, fade_data)
  end
end

function M:remove_fade_source_data(source, exc_cb)
  local start_val = -1
  for i = #self.v_fade_sound_data, 1, -1 do
    local fade_data = self.v_fade_sound_data[i]
    if fade_data.cri_atom_source == source then
      start_val = source.volume
      if exc_cb and fade_data.suc_cb then
        fade_data.suc_cb()
      end
      _tremove(self.v_fade_sound_data, i)
      break
    end
  end
  return start_val
end

function M:update_fade_data()
  if #self.v_fade_sound_data <= 0 then
    return
  end
  local now_time = Global.real_time
  local num = #self.v_fade_sound_data
  for i = num, 1, -1 do
    local fade_data = self.v_fade_sound_data[i]
    local curve = fade_data.curve
    local curve_aisac = fade_data.curve_aisac
    local aisac_control_name = fade_data.aisac_control_name
    fade_data.time = fade_data.time or 0
    local cri_atom_source = fade_data.cri_atom_source
    if fade_data.time < fade_data.end_time and curve then
      if aisac_control_name then
        local aisac_volume = curve_aisac:Evaluate(fade_data.time)
        if not Util.is_nil(cri_atom_source) then
          self:set_aisac_control(cri_atom_source, aisac_control_name, aisac_volume)
        end
      else
        local val = curve:Evaluate(fade_data.time)
        if not Util.is_nil(cri_atom_source) then
          cri_atom_source.volume = val
        end
      end
      fade_data.time = now_time - fade_data.start_time
    else
      if fade_data.suc_cb then
        fade_data.suc_cb()
      end
      if fade_data ~= self.v_fade_sound_data[i] then
      else
        _tremove(self.v_fade_sound_data, i)
      end
    end
  end
end

function M:insert_common_gradient_data(bus_name, cri_atom_source, fade_time, target_val, val_init, val_setter)
  self:remove_common_gradient_data(cri_atom_source, set_type)
  local now_time = Global.real_time
  local start_val = val_init
  local fade_data = {
    cri_atom_source = cri_atom_source,
    end_time = fade_time,
    start_time = now_time,
    val_setter = val_setter,
    val_getter = val_getter,
    curve = UnityCurve.Linear(0, start_val, fade_time, target_val),
    set_type = bus_name
  }
  _tinsert(self.v_common_gradient_data, fade_data)
end

function M:remove_common_gradient_data(source, set_type)
  for i = #self.v_common_gradient_data, 1, -1 do
    local fade_data = self.v_common_gradient_data[i]
    if fade_data.cri_atom_source == source and fade_data.set_type == set_type then
      _tremove(self.v_common_gradient_data, i)
      break
    end
  end
end

function M:update_common_gradient()
  if #self.v_common_gradient_data <= 0 then
    return
  end
  local now_time = Global.real_time
  local num = #self.v_common_gradient_data
  for i = num, 1, -1 do
    local fade_data = self.v_common_gradient_data[i]
    local curve = fade_data.curve
    local set_value_func = fade_data.val_setter
    local bus_name = fade_data.set_type
    fade_data.time = fade_data.time or 0
    local cri_atom_source = fade_data.cri_atom_source
    if fade_data.time < fade_data.end_time and curve then
      local val = curve:Evaluate(fade_data.time)
      if not Util.is_nil(cri_atom_source) then
        set_value_func(cri_atom_source, bus_name, val)
      end
      fade_data.time = now_time - fade_data.start_time
    else
      _tremove(self.v_common_gradient_data, i)
    end
  end
end

function M:clear_sound_obj(lua_obj)
  if lua_obj and not Util.is_nil(lua_obj.transform) then
    local instance_id = lua_obj.transform:GetInstanceID()
    local sound_data = self.v_skill_sound_data[instance_id]
    if sound_data then
      local source_obj = sound_data.source_obj
      local cri_atom_source = source_obj:GetComponent(TypeCriAtomSource)
      cri_atom_source:Stop()
      UnityDestroy(source_obj)
      self.v_skill_sound_data[instance_id] = nil
    end
    return
  end
  for k, data in pairs(self.v_skill_sound_data) do
    local source_obj = data.source_obj
    if not source_obj:IsNull() then
      local cri_atom_source = source_obj:GetComponent(TypeCriAtomSource)
      cri_atom_source:Stop()
      UnityDestroy(source_obj)
    end
  end
  self.v_skill_sound_data = {}
end

function M:set_last_bgm_id(id)
  self.v_last_bgm_id = id
  self.is_play_story_sound = true
end

function M:storycontrol_ui_switch_bgm(flag)
  self.v_storycontrol_uibgm = flag
end

function M:set_is_story_sound(sound_res)
  local sound_acd, sound_name, sound_type, label_switch, is_stream, bgm_no_loop, bus_level = ShareRes.get_play_sound_info(sound_res)
  self.v_is_story_sound[sound_name] = true
end

function M:story_end(is_settle_story, not_reset_bgm)
  self.v_is_story_sound = {}
  if not self.is_play_story_sound then
    return
  end
  if not self.v_last_bgm_id then
    self:bgm_stop()
  end
  self:effect_stop()
  if SceneMgr:check_main_scene() then
    self.v_source_bgm.loop = false
  end
  self.v_switch_bgm_data = nil
  self.v_source_bgm.volume = INIT_BGM_VOLUME
  self.v_fade_sound_data = {}
  local TYPE_TO_SET_VOLUME_VAL = {
    [SOURCE_TYPE.BGM] = INIT_BGM_VOLUME,
    [SOURCE_TYPE.EFFECT] = INIT_EFFECT_VOLUME,
    [SOURCE_TYPE.SPECIAL] = INIT_SPECIAL_VOLUME,
    [SOURCE_TYPE.VOICE] = INIT_VOICE_VOLUME
  }
  for source, source_type in pairs(self.v_story_source) do
    source.loop = false
    if TYPE_TO_SET_VOLUME_VAL[source_type] then
      source.volume = TYPE_TO_SET_VOLUME_VAL[source_type]
    end
    source:Stop()
  end
  self.v_story_source = {}
  self.v_story_loop_sound = {}
  if self.v_is_fight and TowerMgr then
    local tower = TowerMgr:get_tower()
    if not tower then
      self.v_last_bgm_id = nil
    end
  end
  if self.v_last_bgm_id and self.v_last_bgm_id ~= self.v_cur_bgm_id and not is_settle_story and not not_reset_bgm then
    self:play_sound_by_id(self.v_last_bgm_id)
  end
  self.is_play_story_sound = false
  self.v_is_play_story_bgm = nil
  if self.v_stop_bgm then
    self.v_source_bgm.volume = 0
  end
  self:story_sound_volume_fade(self.v_source_bgm, 1, 1)
end

function M:play_story_bgm_sound(sound_id, is_loop, fade_in_time, sound_volume, cb)
  local source = self:get_sound_source_by_type(SOURCE_TYPE.BGM)
  self.v_is_play_story_bgm = true
  
  local function story_cb()
    self:remove_fade_source_data(source)
    self.v_source_bgm.loop = is_loop
    self:play_sound_by_id(sound_id, nil, cb, true)
  end
  
  if self.v_bgm_cue_sheet and self.v_bgm_cue_sheet ~= "" and self.v_bgm_cue_sheet ~= MAIN_BGM then
    local function cb()
      self:bgm_stop()
      
      story_cb()
      self:story_sound_volume_fade(source, fade_in_time, sound_volume)
    end
    
    cb()
  else
    story_cb()
    self:story_sound_volume_fade(source, fade_in_time, sound_volume)
  end
end

function M:story_sound_volume_fade(source, fade_in_time, sound_volume)
  if fade_in_time and fade_in_time > 0 then
    self:insert_fade_data(source, fade_in_time, source.volume, sound_volume, nil, nil, nil, BgmFadeInOutVolume)
  else
    self:set_aisac_control(source, BgmFadeInOutVolume, sound_volume)
  end
end

function M:play_story_sound(is_bgm, sound_res, is_loop, fade_in_time, sound_volume, fixed_start_time)
  sound_volume = BattleSettingMgr:get_voice_main() * sound_volume
  local sound_acd, sound_name, sound_type, label_switch, is_stream, bgm_no_loop, bus_level = ShareRes.get_play_sound_info(sound_res)
  self.v_is_story_sound[sound_name] = true
  if is_bgm or sound_type == SOURCE_TYPE.BGM then
    sound_volume = INIT_BGM_VOLUME * sound_volume
  end
  local source, cb
  if is_loop then
    is_loop = false
    
    function cb(lenght)
      self.v_story_loop_sound[sound_res] = {
        start_time = Global.real_time,
        length = (lenght - fixed_start_time) / 1000,
        is_bgm = is_bgm,
        fixed_start_time = fixed_start_time,
        sound_volume = sound_volume
      }
    end
  end
  local loop_data = {loop = is_loop}
  if not is_bgm then
    local source_type = self:play_sound_by_id(sound_res, nil, cb, nil, nil, loop_data)
    source = self:get_sound_source_by_type(source_type)
    self.v_story_source[source] = source_type
    if fade_in_time and fade_in_time > 0 then
      self:insert_fade_data(source, fade_in_time, 0, sound_volume)
    else
      source.volume = sound_volume
    end
  else
    if self.v_cur_bgm_id == sound_res then
      self:insert_fade_data(self.v_source_bgm, fade_in_time or 2, self.v_source_bgm.volume, sound_volume)
      return
    end
    self:play_story_bgm_sound(sound_res, is_loop, fade_in_time, sound_volume, cb)
    source = self.v_source_bgm
  end
  if self.v_story_loop_sound[sound_res] then
    self.v_story_loop_sound[sound_res].source = source
  end
  self:refresh_story_loop_data(is_bgm, sound_res)
  if fixed_start_time and fixed_start_time > 0 then
    source.startTime = fixed_start_time
  end
  self.is_play_story_sound = true
end

function M:refresh_story_loop_data(is_bgm, sound_res)
  for key, data in pairs(self.v_story_loop_sound) do
    if is_bgm and data.is_bgm and key ~= sound_res then
      self.v_story_loop_sound[key] = nil
      break
    end
  end
end

function M:stop_story_sound(is_bgm, sound_res, fade_out_time)
  local source
  if not is_bgm then
    local sound_acd, sound_name, source_type = ShareRes.get_play_sound_info(sound_res)
    source = self:get_sound_source_by_type(source_type)
    self.v_story_source[source] = source_type
  else
    source = self.v_source_bgm
  end
  self.v_story_loop_sound[sound_res] = nil
  
  local function cb()
    self.v_sound_in_fade_out = nil
    if is_bgm then
      if fade_out_time and fade_out_time > 0 then
        self:bgm_stop(true)
      else
        self:bgm_stop()
      end
    else
      source:Stop()
    end
  end
  
  if fade_out_time and fade_out_time > 0 then
    self.v_sound_in_fade_out = true
    if is_bgm then
      self:insert_fade_data(source, fade_out_time, source.volume, 0, cb, nil, nil, BgmFadeInOutVolume)
    else
      self:insert_fade_data(source, fade_out_time, source.volume, 0, cb)
    end
  else
    cb()
  end
end

function M:get_bgm_volume()
  if self.v_source_bgm then
    return self.v_source_bgm.volume
  end
end

function M:set_bgm_volume(start_vol, target_vol, fade_out_time)
  local source = self.v_source_bgm
  start_vol = start_vol or source.volume
  target_vol = target_vol or 0
  fade_out_time = fade_out_time or 0
  self:insert_fade_data(source, fade_out_time, start_vol, target_vol, nil, nil, nil, PauseVolume)
end

function M:update_story_loop_sound()
  if UtilTable.hash_lenth(self.v_story_loop_sound) <= 0 then
    return
  end
  local cur_time = Global.real_time
  for sound_res, data in pairs(self.v_story_loop_sound) do
    local start_time = data.start_time
    if cur_time - start_time >= data.length then
      if data.is_bgm then
        self:bgm_stop()
      end
      self:play_sound_by_id(sound_res, nil, nil, data.is_bgm)
      if data.source then
        data.source.startTime = data.fixed_start_time
      end
      data.start_time = cur_time
    end
  end
end

function M:reset_bgm_state()
  if self.v_stop_bgm then
    self:start_play_bgm(0)
  end
end

function M:clear_bgm_setting()
  self.v_switch_bgm = nil
  self.v_switch_bgm2 = nil
  self:set_aisac_control(self.v_source_bgm, PauseVolume, 1)
  self.v_bus_level = {}
  self:clear_bus_level()
  self.v_ui_bgm_priority = 0
  self.v_ui_switch_priority = 0
end

function M:clear_bus_level()
  if self.v_fixed_source ~= nil then
    for _, sound_source in pairs(self.v_fixed_source) do
      for busname, _ in pairs(BusTable) do
        sound_source:SetBusSendLevel(busname, 0)
      end
    end
  end
end

function M:clear_sound_pause_set()
  self:set_aisac_control(self.v_source_bgm, PauseVolume, 1)
end

function M:start_play_bgm(change_time)
  self.v_stop_bgm = false
  self.v_source_bgm.volume = INIT_BGM_VOLUME
  return
end

function M:stop_play_bgm()
  self.v_stop_bgm = true
  self.v_has_stop_play_bgm = true
  self:stop_sound_by_type(SOURCE_TYPE.BGM)
end

function M:switch_play_bgm(bgm_name)
  if UIMgr:try_get_visible_ui("ui_chapter_detail") then
    return
  end
  self:start_play_bgm(2)
  self:play_sound_by_id(bgm_name)
  self.v_switch_bgm = bgm_name
end

function M:start_environment_bgm(change_time)
  self.v_stop_environment_bgm = false
  if change_time <= 0 then
    self.v_source_bgm2.volume = INIT_EFFECT_VOLUME
    return
  end
  self.v_switch_bgm_data = {
    source_type = SOURCE_TYPE.BGM2,
    end_time = change_time,
    curve = UnityCurve.Linear(0, 0, change_time, INIT_EFFECT_VOLUME)
  }
end

function M:stop_environment_bgm(change_time)
  self.v_stop_environment_bgm = true
  if change_time <= 0 then
    self.v_source_bgm2.volume = 0
    return
  end
  self.v_switch_bgm_data = {
    source_type = SOURCE_TYPE.BGM2,
    end_time = change_time,
    curve = UnityCurve.Linear(0, INIT_EFFECT_VOLUME, change_time, 0)
  }
end

function M:switch_environment_bgm(change_time, bgm_name)
  self:start_environment_bgm(change_time)
  self:play_sound_by_id(bgm_name, nil, nil, nil, nil, nil, true)
  self.v_switch_bgm2 = bgm_name
end

function M:get_epi_switch_bgm()
  return self.v_switch_bgm
end

function M:get_epi_switch_bgm2()
  return self.v_switch_bgm2
end

function M:play_click_select_sound()
  self:play_sound_by_id(CLICK_SELECT_SOUND)
end

function M:play_click_noselect_sound()
  self:play_sound_by_id(CLICK_NOSELECT_SOUND)
end

function M:play_main_bgm()
  self.v_source_bgm.loop = false
  self:play_sound_by_id(MAIN_BGM)
end

function M:stop_main_bgm(change_time)
  self:bgm_stop()
end

M.is_need_play_transmit_sound = false

function M:play_transmit_sound(is_start)
  if is_start then
    self:play_sound_by_id("Sound_Tp1")
    self.is_need_play_transmit_sound = true
    return
  end
  if self.is_need_play_transmit_sound == true and false == is_start then
    self:play_sound_by_id("Sound_Tp2")
    self.is_need_play_transmit_sound = false
  end
end

function M:play_award_drop_init_sound(obj)
  local function cb()
    if Util.is_nil(obj) then
      return
    end
    if not Util.is_nil(self.v_dorp_loop_cri) then
      self.v_dorp_loop_cri.volume = 0
    end
    local gameobj = obj.gameObject
    local cri_atom_source = gameobj:GetComponent(TypeCriAtomSource)
    cri_atom_source = cri_atom_source or gameobj:AddComponent(TypeCriAtomSource)
    cri_atom_source.volume = INIT_EFFECT_VOLUME or 1
    cri_atom_source.loop = false
    self:play_sound_by_id("Sound_DropPoint_1", -1, nil, nil, cri_atom_source)
    self.v_dorp_loop_cri = cri_atom_source
  end
  
  self:play_sound_by_id("Sound_DropPoint", -1)
  cb()
end

function M:play_award_drop_touch_sound()
  if not Util.is_nil(self.v_dorp_loop_cri) then
    self.v_dorp_loop_cri.volume = 0
  end
  self:play_sound_by_id("Sound_DropTrigger")
end

function M:play_award_show_sound()
  self:play_sound_by_id("Sound_DropItme")
end

function M:play_pick_sound()
  self:play_sound_by_id("Sound_PickItem")
end

function M:play_event_change_sound()
  self:play_sound_by_id("Sound_suijishijian01")
end

function M:play_event_confirm_sound()
  self:play_sound_by_id("Sound_suijishijian02")
end

function M:play_event_result_sound()
  self:play_sound_by_id("Sound_suijishijian03")
end

function M:on_open_settle_ui()
end

function M:on_close_settle_ui()
  local time = ShareRes.get_comm_value("StartPlayBgmTime") or 0.5
  if not SceneMgr:check_main_scene() then
    if self.v_last_bgm_id and self.v_last_bgm_id ~= self.v_cur_bgm_id then
      self:play_sound_by_id(self.v_last_bgm_id)
    else
      local play_bgm_id = SceneMgr:get_tower_sound()
      if play_bgm_id and "" ~= play_bgm_id then
        self:play_sound_by_id(play_bgm_id)
      end
    end
  end
end

function M:voice_sound_down(out_time, callback)
  local fadeout_time = out_time or ShareRes.get_comm_value("VoiceFadeOutTime")
  local fadeout_value = ShareRes.get_comm_value("VoiceFadeValue")
  local cur_volume = self.v_source_voice.volume
  self.v_voice_up_or_down_data = {
    source_type = SOURCE_TYPE.VOICE,
    end_time = fadeout_time,
    curve = UnityCurve.Linear(0, cur_volume, fadeout_time, _min(fadeout_value, cur_volume)),
    callback = callback
  }
end

function M:voice_sound_up(callback)
  local fadeout_time = ShareRes.get_comm_value("VoiceFadeInTime")
  self.v_voice_up_or_down_data = {
    source_type = SOURCE_TYPE.VOICE,
    end_time = fadeout_time,
    curve = UnityCurve.Linear(0, self.v_source_voice.volume, fadeout_time, INIT_VOICE_VOLUME),
    callback = callback
  }
end

function M:switch_block(sound_name, block_num)
  local cfg = ShareRes.get_play_sound_info(sound_name, true)
  if cfg.BlockNum then
    local set_source = self:get_sound_source_by_type(cfg.SourceType)
    if set_source.cueName == cfg.PlaySoundName[1] then
      set_source:SwitchBlock(cfg.PlaySoundName[1], block_num)
    end
  end
end

function M:get_cur_bgm_id()
  return self.v_cur_bgm_id
end

function M:pause_scene_fade(pause, main_scene)
  if SceneMgr:check_main_scene_loaded() then
    self.v_source_effect:Pause(false)
    self:set_aisac_control(self.v_source_effect, SfxVolume, INIT_EFFECT_VOLUME_ASC)
    return
  end
  local sound_pause = false
  if pause then
    sound_pause = true
  end
  if not main_scene then
    if sound_pause then
      self:set_aisac_control(self.v_source_bgm, PauseVolume, 0.5)
    else
      self:set_aisac_control(self.v_source_bgm, PauseVolume, 1)
    end
  end
  for _, sound_data in pairs(self.v_skill_sound_data) do
    if not Util.is_nil(sound_data.source_obj) then
      local cri_atom_source = sound_data.source_obj:GetComponent(TypeCriAtomSource)
      self:remove_fade_source_data(cri_atom_source)
      
      local function callback()
        if not Util.is_nil(cri_atom_source) then
          cri_atom_source:Pause(sound_pause)
        end
      end
      
      if sound_pause then
        self:insert_fade_data(cri_atom_source, 0.5, cri_atom_source.volume, 0, callback, nil, nil, SkillVolume)
      else
        if not Util.is_nil(cri_atom_source) then
          cri_atom_source:Pause(sound_pause)
        end
        self:insert_fade_data(cri_atom_source, 1, 0, 1, nil, nil, nil, SkillVolume)
      end
    end
  end
  self:remove_fade_source_data(self.v_source_effect)
  
  local function callback()
    self.v_source_effect:Pause(sound_pause)
  end
  
  if sound_pause then
    self:insert_fade_data(self.v_source_effect, 0.5, INIT_EFFECT_VOLUME_ASC, 0, callback, nil, nil, SfxVolume)
  else
    self.v_source_effect:Pause(sound_pause)
    self:insert_fade_data(self.v_source_effect, 1, 0, INIT_EFFECT_VOLUME_ASC, nil, nil, nil, SfxVolume)
  end
  for _, sound_data in pairs(self.v_criware_obj_list) do
    local cri_obj = sound_data.cri_obj
    local cri_obj_loop = sound_data.cri_obj_loop
    local cri_obj_end = sound_data.cri_obj_end
    if not Util.is_nil(cri_obj) then
      cri_obj:Pause(sound_pause)
    end
    if not Util.is_nil(cri_obj_loop) then
      cri_obj_loop:Pause(sound_pause)
    end
    if not Util.is_nil(cri_obj_end) then
      cri_obj_end:Pause(sound_pause)
    end
  end
  local tower = TowerMgr:get_tower()
  if tower and not UIMgr:try_get_visible_ui("loading") then
    self:control_play_object_source(not pause, SceneMgr:get_scene_id())
  end
end

function M:scene_switch_stop_sound()
  self:bgm_stop()
  self:bgm2_stop()
  for _, sound_data in pairs(self.v_skill_sound_data) do
    if not Util.is_nil(sound_data.source_obj) then
      local cri_atom_source = sound_data.source_obj:GetComponent(TypeCriAtomSource)
      cri_atom_source:Stop()
    end
  end
  self.v_source_effect:Stop()
  for _, sound_data in pairs(self.v_criware_obj_list) do
    local cri_obj = sound_data.cri_obj
    if not Util.is_nil(cri_obj) then
      cri_obj:Stop()
    end
  end
end

function M:reset_fade_sound()
  self:remove_fade_source_data(SOURCE_TYPE.EFFECT)
  local eff_sound = self:get_sound_source_by_type(SOURCE_TYPE.EFFECT)
  eff_sound.volume = INIT_EFFECT_VOLUME
end

function M:stop_skill_sound()
  for _, sound_data in pairs(self.v_skill_sound_data) do
    local cri_atom_source = sound_data.source_obj:GetComponent(TypeCriAtomSource)
    if not Util.is_nil(cri_atom_source) then
      cri_atom_source:Stop()
    end
  end
end

function M:switch_ui_on_show(msg)
  if msg.mm_obj == "ui_click_effect" then
    return
  end
  self:switch_ui(msg.mm_obj)
  self:play_ui_sound(msg.mm_obj .. "_UI_SOUND")
end

function M:switch_ui_on_hide(msg)
  if msg.mm_obj == "ui_click_effect" or not SceneMgr:check_main_scene() then
    return
  end
  if JourneyEventMgr:get_is_need_run_force_journey_event() then
    return
  end
  local cur_ui = UIMgr:get_cur_show_ui()
  local cur_ui_name = cur_ui:ui_get_name()
  self:switch_ui(cur_ui_name, true, msg.mm_obj)
end

function M:set_stop_switch_ui_sound(set_value)
  self.v_stop_switch_ui_sound = set_value
end

function M:clear_bgm_on_story_play()
  self.v_switch_bgm_data = nil
  self.v_source_bgm.volume = INIT_BGM_VOLUME
end

function M:switch_ui(cur_ui_name, ishide, hideui)
  if Story_UI_Control[cur_ui_name] then
    if ishide then
      self:storycontrol_ui_switch_bgm(false)
    elseif self.v_storycontrol_uibgm then
      return
    end
  end
  if cur_ui_name == SUC_SETTLE then
    if ishide then
      return
    else
      local cfg = ShareRes.get_ui_sound_cfg(cur_ui_name)
      if not cfg then
        return
      else
        self:reset_bgm_state()
        self:play_sound_by_id(cfg.SoundName)
      end
    end
    return
  end
  if "ui_chapter_detail" == cur_ui_name and ishide then
    return
  end
  if "ui_chapter_detail" ~= cur_ui_name and SceneMgr and not SceneMgr:check_main_scene() then
    return
  end
  if ishide and "uistory" == hideui and not JourneyEventMgr:get_is_need_run_force_journey_event() and self.v_bgm2_cue_sheet and self.v_bgm2_cue_sheet ~= "" then
    self:bgm2_stop()
  end
  if self.v_stop_switch_ui_sound then
    return
  end
  if UIMgr and cur_ui_name then
    local cfg = ShareRes.get_ui_sound_cfg(cur_ui_name)
    if not cfg then
      return
    else
      self.v_ui_switch_priority = self.v_ui_switch_priority or 0
      if nil ~= UI_BGM_SOUND_PRIORITY[cur_ui_name] and UI_BGM_SOUND_PRIORITY[cur_ui_name] < self.v_ui_switch_priority then
        return
      end
      if cfg.SoundName == nil or cfg.SoundName == "" then
        return
      end
      if nil == UI_BGM_SOUND_PRIORITY_INGNORE[cur_ui_name] then
        self.v_ui_switch_priority = UI_BGM_SOUND_PRIORITY[cur_ui_name]
      end
      self.v_ui_bgm_priority = self.v_ui_bgm_priority or 0
      if UI_BGM_PRIORITY[cfg.SoundName] ~= nil and UI_BGM_PRIORITY[cfg.SoundName] < self.v_ui_bgm_priority then
        return
      end
      self.v_ui_bgm_priority = UI_BGM_PRIORITY[cfg.SoundName] or 0
      if cfg.Overlying then
        self:reset_bgm_state()
        self:play_sound_by_id(cfg.SoundName)
        return
      end
      if self.v_cur_bgm_id == cfg.SoundName then
        if cfg.Label and self.v_switch_ui_label ~= cfg.Label then
          self.v_source_bgm:SwitchLabel(cfg.SelectorName, cfg.Label)
          self.v_switch_ui_label = cfg.Label
        end
      else
        self:reset_bgm_state()
        self:play_sound_by_id(cfg.SoundName)
      end
    end
  end
end

function M:play_lvup_sound()
  self:play_sound_by_id(LEVEL_UP_SOUND)
end

function M:play_weapon_lv_up_sound()
  self:play_sound_by_id(WEAPON_LEVEL_UP)
end

function M:play_character_lv_up_sound()
  self:play_sound_by_id(CHARACTER_LEVEL_UP)
end

function M:play_sign_in_suc_sound()
  self:play_sound_by_id(SIGN_IN_SUC)
end

function M:play_reward_victory_sound()
  self:play_sound_by_id(REWARD_VICTORY)
end

function M:stop_sound_by_obj(source_obj)
  if Util.is_nil(source_obj) then
    return
  end
  local cri_atom_source = source_obj:GetComponent(TypeCriAtomSource)
  if not Util.is_nil(cri_atom_source) then
    cri_atom_source:Stop()
  end
end

function M:stop_sound_by_id(track_sound, cri_src)
  if not Util.is_nil(cri_src) then
    cri_src:Stop()
    return
  end
  local sound_acd, sound_name, sound_type = ShareRes.get_play_sound_info(track_sound)
  local source = self:get_sound_source_by_type(sound_type)
  if source and source.cueName == sound_name and source.cueSheet == sound_acd then
    self:stop_sound_by_type(sound_type)
  end
end

function M:stop_sound_by_id_ex(track_sound)
  local sound_acd, sound_name, sound_type = ShareRes.get_play_sound_info(track_sound)
  self:stop_sound_by_type(sound_type)
end

function M:refresh_switch_label_state(value)
  is_need_check_bgm_switch_label = value
end

function M:adjust_story_sound_volume(sound_volume, fade_out_time)
  sound_volume = BattleSettingMgr:get_voice_main() * sound_volume
  sound_volume = INIT_VOICE_VOLUME * sound_volume
  self.v_switch_bgm_data = {
    source_type = SOURCE_TYPE.BGM,
    end_time = fade_out_time,
    curve = UnityCurve.Linear(0, self.v_source_bgm.volume, fade_out_time, sound_volume),
    callback = callback
  }
end

function M:play_login_bgm()
  self:play_sound_by_id(LOGIN_BGM)
  self.v_last_bgm_id = nil
end

function M:sound_preload_timeline(res_name)
  if SceneMgr and SceneMgr:check_main_scene() then
    return
  end
  local preload_cfg = ShareRes.get_sound_preload_cfg()
  local sounds = preload_cfg[res_name]
  if sounds then
    for _, sound in pairs(sounds) do
      if nil ~= sound and "" ~= sound then
        self:play_sound_by_id(sound, nil, nil, nil, nil, nil, nil, nil, true)
      end
    end
  end
end

function M:sound_preload(npc_id)
end

function M:sound_preload_by_soundid(sound_id)
  self:play_sound_by_id(sound_id, nil, nil, nil, nil, nil, nil, nil, true)
end

function M:sound_release()
  if self.v_preload_sound_info then
    for _, data in pairs(self.v_preload_sound_info) do
      data.preload = false
      data.cache_time = _os_time() + SOURCE_CACHE_TIME
    end
    self.v_preload_sound_info = nil
    self.v_npc_id_sound = nil
  end
  self.v_pre_tl_src = nil
  self.v_pre_tl_asc = nil
  self.v_pre_tl_ts = nil
end

function M:set_sound_source_volume(sound_type, init_volume_type, volume)
  local sound_source = self:get_sound_source_by_type(sound_type)
  if volume then
    sound_source.volume = volume
  elseif "VOICE" == init_volume_type then
    sound_source.volume = INIT_VOICE_VOLUME
  elseif "BGM" == init_volume_type then
    sound_source.volume = INIT_BGM_VOLUME
  elseif "EFFECT" == init_volume_type then
    sound_source.volume = INIT_EFFECT_VOLUME
  elseif "SPECIAL" == init_volume_type then
    sound_source.volume = INIT_SPECIAL_VOLUME
  end
end

function M:reset_fight_bgm_to_idle()
  if not self.v_fight_bgm then
    return
  end
  if self.v_fight_bgm ~= self.v_source_bgm.cueSheet then
    return
  end
  local now_time = _os_time()
  local cue_sheet = self.v_fight_bgm
  local cue_name = ShareRes.get_sound_cfg_by_index(cue_sheet, FIGHT_BGM.ENTRY)
  local cue_index = FIGHT_BGM.ENTRY
  local res_cue_name = ""
  if is_need_check_bgm_switch_label and TowerMgr and TowerMgr:get_tower() and TowerMgr:get_tower():get_tower_enter_time() < ENTRY_BGM_TIME then
    self:refresh_switch_label_state(false)
    self.v_pre_index = FIGHT_BGM.ENTRY
    self.v_middle_low_update_time = now_time + ENTRY_BGM_TIME
    self:switch_label_with_fight_bgm(cue_sheet, cue_name)
    return
  end
  if not self.v_bgm_cue_sheet or "" == self.v_bgm_cue_sheet then
    return
  end
  res_cue_name = ShareRes.get_sound_cfg_by_index(cue_sheet, FIGHT_BGM.IDLE)
  if "" == res_cue_name or nil == res_cue_name then
    return
  else
    cue_index = FIGHT_BGM.IDLE
    cue_name = res_cue_name
  end
  self:switch_label_with_fight_bgm(cue_sheet, cue_name)
end

function M:set_space_time_aisac_control(volume, duration)
  if not duration or 0 == duration then
    self.v_source_bgm:CustomSetAisacControl(SpaceTimeChange, volume)
  else
    local start = self:get_aisac_value(self.v_source_bgm, SpaceTimeChange)
    
    local function value_func(value)
      self.v_source_bgm:CustomSetAisacControl(SpaceTimeChange, value)
    end
    
    CSHelper.WrapTweenTo(start, volume, 0.3, value_func)
  end
end

function M:set_bgm_aisac_control(control_name, volume)
  self:set_aisac_control(self.v_source_bgm, control_name, tonumber(volume))
end

function M:set_aisac_control(atomsource, control_name, volume)
  local set_aisac = 1 - volume
  if set_aisac < 0 then
    set_aisac = 0
  end
  if set_aisac > 1 then
    set_aisac = 1
  end
  atomsource:CustomSetAisacControl(control_name, set_aisac)
end

function M:get_aisac_value(atomsource, control_name)
  return atomsource:CustomGetAisacValue(control_name)
end

function M:play_step_lipsyc_sound(sound_name)
  if not Util.is_nil(self.v_timeLineLipsycBinder) then
    self:play_lipsync_data(sound_name, self.v_timeLineLipsycBinder.gameObject, true)
  end
end

function M:clear_step_lipsyc_sound()
  self.v_timeLineLipsycBinder = nil
end

function M:play_sound_by_cscall(base_params)
  local tower = TowerMgr and TowerMgr:get_tower()
  if 8 == base_params.IntParam3 then
    if Util.is_nil(base_params.targetObj) then
      self.v_timeLineLipsycBinder = nil
    else
      self.v_timeLineLipsycBinder = base_params.targetObj.gameObject
    end
    return
  end
  if 7 == base_params.IntParam3 then
    if 0 == base_params.IntParam4 then
      self:set_sound_reverb_val(base_params.StringParam1, base_params.FloatParam1)
      Log.Info("set_sound_reverb_state  false false")
    else
      self:set_sound_reverb_val(base_params.StringParam1, base_params.FloatParam1)
      Log.Info("set_sound_reverb_state  true true")
    end
    return
  end
  if Util.is_nil(base_params.targetObj) then
    return
  end
  local track_sound = base_params.StringParam3
  local track_state = base_params.IntParam3
  local play_on_main_scene = 1 == base_params.IntParam4
  local stop_on_skip = 1 == base_params.IntParam4
  if track_sound and "" ~= track_sound then
    if 2 == track_state then
      local cri_obj = self:creat_object_source(base_params.targetObj.gameObject, track_sound, {
        FadeTime = base_params.FloatParam1,
        IsLoop = base_params.FloatParam2,
        DoStop = base_params.FloatParam3
      })
      self:add_gen_cri_source(cri_obj, GEN_CRI_SOURCE_TYPE.COMMON_AUDIO)
      if self.v_pause_gen_source then
        cri_obj:Pause(true)
      end
      return
    elseif 3 == track_state then
      self:destory_object_source(base_params.targetObj.gameObject, nil, track_sound)
      return
    elseif 4 == track_state then
      self:destory_object_source(base_params.targetObj.gameObject, true, track_sound)
      return
    elseif 5 == track_state then
      if (Global.gamemode:gmode_is_loadscene() or tower and tower:is_in_room_preload()) and not SceneMgr:check_main_scene() then
        return
      end
      if play_on_main_scene and not SceneMgr:check_main_scene() then
        return
      end
      if ANIM_EVENT_AVOID[base_params.StringParam4] and not SceneMgr:check_main_scene() and (nil ~= UIMgr:try_get_ui("uistory") or nil ~= UIMgr:try_get_ui("ui_timeline")) then
        return
      end
      local list_temp, sound_id
      if string.match(track_sound, ",") then
        list_temp = Util.split_str(track_sound, ",")
        sound_id = list_temp[1]
        if list_temp[2] and not Util.is_empty(list_temp[2]) then
          sound_id = tonumber(sound_id)
        end
      else
        sound_id = track_sound
      end
      local cri_s = base_params.targetObj.gameObject:GetComponent(TypeCriAtomSource)
      cri_s.volume = INIT_EFFECT_VOLUME
      local terrain_sound = ShareRes.get_terrain_sound_cfg(sound_id)
      if terrain_sound then
        local cur_pos = base_params.targetObj.gameObject.transform.position
        local tar_sound = terrain_sound.BaseTerName
        local hit_obj_name
        local is_hit, hit_obj = CSHelper.RayCastGameObject(cur_pos.x, cur_pos.y + 0.2, cur_pos.z, 0, -1, 0, 3, Layer.LayerMask.Terrain)
        if is_hit then
          hit_obj_name = hit_obj.gameObject.name
          for terrain_name, real_sound in pairs(terrain_sound) do
            if string.match(hit_obj_name, terrain_name) then
              tar_sound = real_sound
              break
            end
          end
        end
        cri_s:SwitchLabel(tar_sound.SelectName, tar_sound.SelectLabel)
      end
      self:play_sound_by_id(sound_id, nil, nil, nil, cri_s)
      self:play_lipsync_data(sound_id, base_params.targetObj.gameObject)
      return
    end
    if (Global.gamemode:gmode_is_loadscene() or tower and tower:is_in_room_preload()) and not SceneMgr:check_main_scene() then
      return
    end
    local track_cri = base_params.targetObj.gameObject:GetComponent(TypeCriAtomSource)
    if track_cri then
      track_cri.volume = INIT_EFFECT_VOLUME
      self:add_gen_cri_source(track_cri, GEN_CRI_SOURCE_TYPE.TIMELINE_AUDIO)
    end
    if 1 == track_state then
      TimeLineMgr:register_track_play_sound(track_sound, stop_on_skip, track_cri)
      Global.sound_mgr:play_sound_by_id(track_sound, nil, nil, nil, track_cri)
      if not Util.is_nil(base_params.targetObj2) then
        self:play_lipsync_data(track_sound, base_params.targetObj2.gameObject, true)
      end
      if string.match(track_sound, "LTR", -3) then
        if not Util.is_nil(self.v_pre_tl_src) and self.v_pre_tl_ts ~= track_sound then
          local cir_src = self.v_pre_tl_src
          cir_src.transform:SetParent(nil)
          
          local function cb()
            self:set_delay_task(6, function()
              if not Util.is_nil(cir_src) then
                UnityDestroy(cir_src.gameObject)
              end
            end)
          end
          
          self:insert_fade_data(self.v_pre_tl_src, self.v_pre_fead_time or 0.5, 1, 0, cb, nil, nil, self.v_pre_tl_asc)
        end
        self.v_pre_tl_src = track_cri
        self.v_pre_tl_asc = ULT_LTRFade
        self.v_pre_tl_ts = track_sound
        self.v_pre_fead_time = base_params.FloatParam2
        self:remove_fade_source_data(track_cri, true)
        self:set_aisac_control(track_cri, ULT_LTRFade, 1)
        self:set_aisac_control(track_cri, ULT_RTLFade, 1)
      elseif string.match(track_sound, "RTL", -3) then
        if not Util.is_nil(self.v_pre_tl_src) and self.v_pre_tl_ts ~= track_sound then
          local cir_src = self.v_pre_tl_src
          cir_src.transform:SetParent(nil)
          
          local function cb()
            self:set_delay_task(6, function()
              if not Util.is_nil(cir_src) then
                UnityDestroy(cir_src.gameObject)
              end
            end)
          end
          
          self:insert_fade_data(self.v_pre_tl_src, self.v_pre_fead_time or 0.5, 1, 0, cb, nil, nil, self.v_pre_tl_asc)
        end
        self.v_pre_tl_src = track_cri
        self.v_pre_tl_asc = ULT_RTLFade
        self.v_pre_tl_ts = track_sound
        self.v_pre_fead_time = base_params.FloatParam2
        self:remove_fade_source_data(track_cri, true)
        self:set_aisac_control(track_cri, ULT_LTRFade, 1)
        self:set_aisac_control(track_cri, ULT_RTLFade, 1)
      end
      return
    elseif 0 == track_state then
      Global.sound_mgr:stop_sound_by_id(track_sound, track_cri)
      return
    elseif 6 == track_state then
      local delay_des_time = base_params.FloatParam1
      if not Util.is_nil(track_cri) and delay_des_time > 0 then
        local cri_trans = track_cri.transform
        self:set_delay_task(delay_des_time, function()
          if not Util.is_nil(cri_trans) then
            UnityDestroy(cri_trans.gameObject)
          end
        end)
      end
      return
    end
  end
  local ui_timeline = UIMgr:try_get_ui("ui_timeline")
  if ui_timeline and TimeLineMgr then
    TimeLineMgr:clear_curr_timelin_audio()
  end
  local timeline_name = base_params.StringParam1
  local audio_name = base_params.StringParam2
  if not Global.sound_mgr then
    Log.Error("音乐管理器未初始化完毕")
    return
  end
  local is_need_play = true
  if TimeLineMgr and nil ~= audio_name and "" ~= audio_name and 1 == base_params.IntParam1 then
    is_need_play = TimeLineMgr:get_is_need_play_timeline_audio(timeline_name)
  end
  if false == is_need_play then
    return
  end
  if nil ~= audio_name and "" ~= audio_name then
    Global.sound_mgr:play_sound_by_id(audio_name)
    TimeLineMgr:set_curr_timeline_audio(1, audio_name)
    return
  end
  local audio_id = base_params.IntParam2
  Global.sound_mgr:play_sound_by_id(audio_id)
  TimeLineMgr:set_curr_timeline_audio(2, audio_id)
end

function M:creat_object_source(traget_obj, sound_name, cs_cfg)
  local cfg = ShareRes.get_object_sound_cfg(sound_name)
  local fade_time = cfg.FadeTime
  local isLoop = cfg.IsLoop
  local doStop = cfg.DoStop
  local object_sound_name = cfg.ObjectSoundName
  if cfg.no_cfg and cs_cfg then
    fade_time = cs_cfg.FadeTime
    isLoop = cs_cfg.IsLoop > 0.1
    doStop = cs_cfg.DoStop > 0.1
  end
  local obj_instance_id = traget_obj:GetInstanceID() .. sound_name
  if self.v_object_source_list[obj_instance_id] then
    if not Util.is_nil(self.v_object_source_list[obj_instance_id].cri_obj) then
      local temp, cue_sheet = self:play_sound_by_id(object_sound_name, -1, nil, nil, self.v_object_source_list[obj_instance_id].cri_obj)
    end
    self:check_objectsource_cuesheet(cue_sheet, true)
    return
  end
  local obj = UnityGameObject()
  local temp_obj = UnityGameObject()
  temp_obj.transform:SetParent(obj.transform, false)
  local cri_obj = temp_obj:AddComponent(TypeCriAtomSource)
  cri_obj.volume = INIT_EFFECT_VOLUME
  if self.v_pause_gen_source then
    cri_obj.volume = 0
    cri_obj:Pause(true)
  end
  obj.name = sound_name
  temp_obj.name = sound_name
  obj.transform:SetParent(traget_obj.transform, false)
  if fade_time and fade_time > 0 then
    self.v_object_source_list[obj_instance_id] = {
      obj = obj,
      fade_time = fade_time,
      cri_obj = cri_obj,
      isLoop = isLoop,
      doStop = doStop
    }
  else
    self.v_object_source_list[obj_instance_id] = {obj = obj, cri_obj = cri_obj}
  end
  local temp, cue_sheet = self:play_sound_by_id(object_sound_name, -1, nil, nil, cri_obj)
  self:check_objectsource_cuesheet(cue_sheet, true)
  return cri_obj
end

function M:control_play_object_source(paly_or_stop, scene_id)
  local set_volume = INIT_EFFECT_VOLUME
  self.v_cur_scene_id = scene_id or SceneMgr:get_scene_id()
  for _, cfg in pairs(self.v_object_source_list) do
    if cfg and not Util.is_nil(cfg.cri_obj) then
      cfg.cri_obj.volume = set_volume
      cfg.cri_obj:Pause(not paly_or_stop)
    end
  end
  if paly_or_stop then
    self.v_pause_gen_source = false
  else
    self.v_pause_gen_source = true
  end
end

function M:destory_object_source(traget_obj, has_destory, sound_name)
  if Util.is_nil(traget_obj) then
    return
  end
  local obj_instance_id = traget_obj:GetInstanceID() .. sound_name
  local cfg = self.v_object_source_list[obj_instance_id]
  if not cfg then
    return
  end
  self:check_objectsource_cuesheet(cfg.cri_obj.cueSheet, false)
  if has_destory then
    self.v_object_source_list[obj_instance_id] = nil
    return
  end
  if not Util.is_nil(cfg.obj) then
    if cfg.fade_time and cfg.fade_time > 0 then
      if self.v_common_audio_active then
        cfg.cri_obj.gameObject.transform.parent = nil
      end
      UnityDestroy(cfg.obj)
      if cfg.isLoop or cfg.doStop then
        cfg.cri_obj:Stop()
      end
      self:set_delay_task(cfg.fade_time, function()
        if not Util.is_nil(cfg.cri_obj) then
          UnityDestroy(cfg.cri_obj.gameObject)
        end
      end)
    else
      cfg.cri_obj:Stop()
      UnityDestroy(cfg.obj)
    end
  end
  cfg.cri_obj = nil
  cfg.obj = nil
  self.v_object_source_list[obj_instance_id] = nil
end

function M:check_objectsource_cuesheet(cuesheet, add_or_remove)
  local sound_info = self.v_cache_sound_info[cuesheet]
  self.v_object_source_cuesheet_list[cuesheet] = self.v_object_source_cuesheet_list[cuesheet] or 0
  if add_or_remove then
    self.v_object_source_cuesheet_list[cuesheet] = self.v_object_source_cuesheet_list[cuesheet] + 1
  else
    self.v_object_source_cuesheet_list[cuesheet] = self.v_object_source_cuesheet_list[cuesheet] - 1
  end
  if self.v_object_source_cuesheet_list[cuesheet] <= 0 and sound_info then
    sound_info.cache_time = _os_time() + SOURCE_CACHE_TIME
  end
end

function M:set_bus_sendLevel_bgm(bus_name, send_level)
  self.v_source_bgm:SetBusSendLevel(bus_name, send_level)
end

function M:set_bus_sendLevel(cri, bus_name, send_level)
  self.v_cur_bus_level = self.v_cur_bus_level or {}
  self.v_cur_bus_level[bus_name] = send_level
  cri:SetBusSendLevel(bus_name, send_level)
end

function M:get_sound_reverb_state()
  return self.v_sound_reverb_state
end

function M:set_sound_reverb_state(state)
  self.v_sound_reverb_state = state
  local cir_source
  if state then
    self.v_bus_level[Bus1Reverb] = 1
  else
    self.v_bus_level[Bus1Reverb] = 0
  end
end

function M:set_sound_reverb_val(bus_name, bus_level)
  if bus_level < 0 then
    bus_level = 0
  end
  if bus_level > 1 then
    bus_level = 1
  end
  self.v_bus_level[bus_name] = bus_level
end

local EFFECT_SOUND_TYPE = {
  START = 1,
  LOOP = 2,
  END = 3,
  ANIM = 4
}
local LOOP_SOUND_TYPE = 4
local EFFECT_IDX_GO = 1
local EFFECT_IDX_STATUS = 4
local EFFECT_NAME = 14

function M:stop_sound_effect_sound(criware_obj)
  local sound_source = criware_obj:GetComponents(TypeCriAtomSource)
  if not sound_source then
    return
  end
  if sound_source.Length > 0 then
    for i = 0, sound_source.Length - 1 do
      sound_source[i]:Stop()
    end
  end
end

function M:play_effect_triple_sound(effect_data, play_type, npc)
  if play_type == EFFECT_SOUND_TYPE.LOOP and effect_data.is_loop_sound then
    return
  end
  local effect_status = effect_data[EFFECT_IDX_STATUS]
  local effect_name = effect_data[EFFECT_NAME]
  local effect_obj = effect_data[EFFECT_IDX_GO]
  local effect_sound_cfg = ShareRes.get_effect_sound_cfg(effect_name)
  if play_type == EFFECT_SOUND_TYPE.ANIM then
    if not effect_sound_cfg.AnimEnd then
      return
    end
    if effect_data.play_animend_cpl then
      return
    end
    if not CSHelper.CheckAnimIsPlaying(effect_obj.gameObject, "End") then
      return
    end
    effect_data.play_animend_cpl = true
  end
  if not effect_sound_cfg then
    return
  end
  self:creat_effect_criware_obj(effect_obj, effect_sound_cfg.FadeTime, effect_sound_cfg.IsLoop, effect_sound_cfg.IsTripleEffect, effect_name)
  local is_triple_effect = effect_sound_cfg.IsTripleEffect
  local sound_list = effect_sound_cfg.EffectSoundName
  if not is_triple_effect and not effect_data.is_play_sound then
    for index, sound_id in pairs(sound_list) do
      if sound_id and "" ~= sound_id then
        self:play_sound_by_id_effect_sound(sound_id, effect_obj, play_type, effect_sound_cfg, npc, effect_sound_cfg.DelayPlay[index], effect_sound_cfg.ByTimeScale[index])
      end
    end
    effect_data.is_play_sound = true
    return
  end
  local sound_id = sound_list[play_type]
  if play_type == EFFECT_SOUND_TYPE.ANIM then
    sound_id = effect_sound_cfg.AnimEnd
  end
  if not sound_id or "" == sound_id then
    local criware_obj = self.v_criware_obj_list[effect_obj].obj
    if not criware_obj then
      return
    end
    local data = self.v_criware_obj_list[effect_obj]
    local is_triple_effect = data.is_triple
    if is_triple_effect and (play_type == EFFECT_SOUND_TYPE.END or play_type == EFFECT_SOUND_TYPE.ANIM) and data.cri_obj ~= nil and nil ~= data.cri_obj_loop and nil ~= data.cri_obj_end then
      data.cri_obj:Stop()
      data.cri_obj_loop:Stop()
      data.cri_obj_end:Stop()
      effect_data.is_loop_sound = false
    end
    return
  end
  if play_type == EFFECT_SOUND_TYPE.LOOP and not effect_data.is_loop_sound then
    self:play_sound_by_id_effect_sound(sound_id, effect_obj, play_type, effect_sound_cfg, npc, effect_sound_cfg.DelayPlay[play_type], effect_sound_cfg.ByTimeScale[play_type])
    effect_data.is_loop_sound = true
  else
    self:play_sound_by_id_effect_sound(sound_id, effect_obj, play_type, effect_sound_cfg, npc, effect_sound_cfg.DelayPlay[play_type], effect_sound_cfg.ByTimeScale[play_type])
  end
end

function M:rep_check_sound_id(id, npc, npc_kind_id)
  local kind_id = npc_kind_id
  if npc then
    kind_id = npc:get_role_kind()
  end
  local new_id = _sformat("%s_%s", id, NPC_KIND_STR[kind_id])
  local sound_acd, sound_name, source_type = ShareRes.get_play_sound_info(new_id, nil, true)
  if sound_name and "" ~= sound_name then
    return new_id
  else
    return id
  end
end

function M:play_sound_by_id_effect_sound(id, obj_key, eff_sound_type, effect_sound_cfg, npc, DelayPlay, ByTimeScale)
  id = self:rep_check_sound_id(id, npc)
  local sound_acd, sound_name, source_type = ShareRes.get_play_sound_info(id)
  if not sound_name or "" == sound_name then
    return
  end
  if not self.v_criware_obj_list[obj_key] then
    return
  end
  if DelayPlay and DelayPlay > 0 then
    local function callback()
      if self.v_criware_obj_list[obj_key] or self.v_criware_obj_list_fade[obj_key] then
        self:play_sound_by_id_effect_sound(id, obj_key, eff_sound_type, effect_sound_cfg, npc)
      end
    end
    
    local by_time_scale = ByTimeScale
    local get_time_update
    if 1 == by_time_scale then
      function get_time_update()
        if npc and npc.time_mgr then
          return npc.time_mgr:get_dt_time()
        end
      end
    end
    self:set_delay_task_high_update(DelayPlay, callback, get_time_update)
    return
  end
  local criware_obj = self.v_criware_obj_list[obj_key].obj
  if not criware_obj then
    return
  end
  local data = self.v_criware_obj_list[obj_key]
  local is_triple_effect = data.is_triple
  local sound_source = data.cri_obj
  if is_triple_effect then
    if eff_sound_type == EFFECT_SOUND_TYPE.LOOP then
      sound_source = data.cri_obj_loop
    elseif eff_sound_type == EFFECT_SOUND_TYPE.END or eff_sound_type == EFFECT_SOUND_TYPE.ANIM then
      local sound_source_loop = data.cri_obj_loop
      sound_source:Stop()
      sound_source_loop:Stop()
      sound_source = data.cri_obj_end
    end
  end
  sound_source.volume = INIT_EFFECT_VOLUME
  sound_source.loop = false
  local cache_time
  if eff_sound_type == EFFECT_SOUND_TYPE.LOOP then
    cache_time = -1
  end
  self:play_sound_by_id(id, cache_time, nil, nil, sound_source)
end

function M:creat_effect_criware_obj(effect_obj, fade_time, isLoop, is_triple, effect_name)
  if self.v_criware_obj_list[effect_obj] then
    return
  end
  local obj, obj_ref_info = self:get_effect_criobj_cache()
  local cri_obj = obj_ref_info[0]
  local cri_obj_loop, cri_obj_end
  if is_triple then
    cri_obj_loop = obj_ref_info[1]
    cri_obj_end = obj_ref_info[2]
  end
  if fade_time and fade_time > 0 then
    obj.transform:SetParent(effect_obj.transform, false)
    obj.transform:SetLocalPositionA(0, 0, 0)
    self.v_criware_obj_list[effect_obj] = {
      obj = obj,
      fade_time = fade_time,
      cri_obj = cri_obj,
      cri_obj_loop = cri_obj_loop,
      cri_obj_end = cri_obj_end,
      isLoop = isLoop,
      is_triple = is_triple,
      effect_name = effect_name
    }
  else
    obj.transform:SetParent(effect_obj.transform, false)
    obj.transform:SetLocalPositionA(0, 0, 0)
    self.v_criware_obj_list[effect_obj] = {
      obj = obj,
      cri_obj = cri_obj,
      cri_obj_loop = cri_obj_loop,
      cri_obj_end = cri_obj_end,
      is_triple = is_triple,
      effect_name = effect_name
    }
  end
end

function M:remove_effect_obj(obj_key)
  local obj, fade_time, cri_obj, cri_obj_loop, cri_obj_end, isLoop, is_triple
  if self.v_criware_obj_list[obj_key] then
    obj = self.v_criware_obj_list[obj_key].obj
    cri_obj = self.v_criware_obj_list[obj_key].cri_obj
    cri_obj_loop = self.v_criware_obj_list[obj_key].cri_obj_loop
    cri_obj_end = self.v_criware_obj_list[obj_key].cri_obj_end
    fade_time = self.v_criware_obj_list[obj_key].fade_time
    isLoop = self.v_criware_obj_list[obj_key].isLoop
    is_triple = self.v_criware_obj_list[obj_key].is_triple
  end
  self.v_criware_obj_list_fade[obj_key] = self.v_criware_obj_list[obj_key]
  if obj and not obj:IsNull() then
    if fade_time and fade_time > 0 then
      obj.transform:SetParent(self.v_effect_obj_pool_nodeParent)
      
      local function callback()
        if obj and not obj:IsNull() then
          self:release_effect_criobj_cache(obj)
        end
        self.v_criware_obj_list_fade[obj_key] = nil
      end
      
      if isLoop and obj and not obj:IsNull() then
        cri_obj:Stop()
        if cri_obj_loop then
          cri_obj_loop:Stop()
        end
      end
      self:set_delay_task(fade_time, callback)
    else
      self:stop_sound_effect_sound(obj)
      self:release_effect_criobj_cache(obj)
      self.v_criware_obj_list_fade[obj_key] = nil
    end
  end
  self.v_criware_obj_list[obj_key] = nil
end

function M:stop_sound(criware_obj)
  local sound_source = criware_obj:GetComponents(TypeCriAtomSource)
  if not sound_source then
    return
  end
  if sound_source.Length > 0 then
    for i = 0, sound_source.Length - 1 do
      sound_source[i]:Stop()
      sound_source[i]:Pause(false)
    end
  end
end

function M:scene_switch_clear()
  for _, obj_table in pairs(self.v_criware_obj_list) do
    local obj = obj_table.obj
    local loop_obj = obj_table.cri_obj_loop
    if obj and not obj:IsNull() then
      self:release_effect_criobj_cache(obj)
    end
    if not Util.is_nil(loop_obj) and loop_obj.cueSheet then
      local sound_info = self.v_cache_sound_info[loop_obj.cueSheet]
      if sound_info then
        sound_info.cache_time = _os_time() + SOURCE_CACHE_TIME
      end
    end
  end
  self.v_skill_sound_abort = {}
  self.v_effect_obj_pool_collect = {}
  self.v_criware_obj_list = {}
  self.v_criware_obj_list_fade = {}
  self.v_gen_criware_source = setmetatable({}, Global.config.KEY_WEAK_METATABLE)
  self.v_object_source_cuesheet_list = {}
end

function M:start_snapshot_sound(snap_name, time_ms)
end

function M:stop_snap_shot_sound()
end

function M:add_gen_cri_source(src, src_type, src_obj)
  if not Util.is_nil(src) then
    self.v_gen_criware_source[src] = src_type
  end
end

function M:check_remove_gen_cri_source()
  self.v_gen_criware_source = setmetatable({}, Global.config.KEY_WEAK_METATABLE)
end

function M:pause_gen_source(pause_or_continue, target_type, delay_time, force_no_state)
  if not force_no_state and self.v_pause_gen_source == pause_or_continue then
    return
  end
  self:clear_pause_sound_timer()
  local target_type_param = target_type
  local pause_or_continue_param = pause_or_continue
  
  local function cb()
    if target_type_param then
      self:check_remove_gen_cri_source()
      for k, v in pairs(self.v_gen_criware_source) do
        if not Util.is_nil(k) and (nil == target_type_param or v == target_type_param) then
          k.volume = INIT_EFFECT_VOLUME
          k:Pause(pause_or_continue_param)
        end
      end
    else
      self:control_play_object_source(not pause_or_continue_param)
    end
  end
  
  if delay_time and delay_time > 0 then
    self.v_pause_sound_timer = Timer:add_timer("pause_sound_timer", delay_time, function()
      cb()
    end)
  else
    cb()
  end
end

function M:play_ui_sound(sound_id)
  if sound_id then
    local cfg = ShareRes.get_ui_sound_cfg(sound_id)
    if not cfg then
      return
    end
    if cfg.SoundName == "" then
      if UNITY_EDITOR then
        Log.Info("----------------------------- play_ui_sound222 未找到配置   SoundName  SoundName SoundName", sound_id)
      end
      return
    end
    if "ui_chapter_detail_UI_SOUND" == sound_id and UIMgr:try_get_visible_ui("uistory") then
      return
    end
    self.v_ui_sound_cd = self.v_ui_sound_cd or 0
    if Global.real_time - self.v_ui_sound_cd < 0.2 and self.v_pre_sound == cfg.SoundName then
      return
    end
    self.v_ui_sound_cd = Global.real_time
    self.v_pre_sound = cfg.SoundName
    if not cfg.GenSource then
      self:play_sound_by_id(cfg.SoundName)
    else
      local cri_obj, cri_cmp = self:new_cri_obj(sound_id)
      self:play_sound_by_id(cfg.SoundName, nil, nil, nil, cri_cmp)
      self:set_delay_task(10, function()
        if not Util.is_nil(cri_obj) then
          UnityDestroy(cri_obj)
        end
      end)
    end
    self.v_ui_sound_state = true
    self:clear_ui_sound_timer()
    self.v_ui_sound_timer = Timer:add_timer("ui_sound_timer", 0.5, function()
      self.v_ui_sound_state = false
    end)
  end
end

function M:clear_ui_sound_timer()
  if self.v_ui_sound_timer then
    Timer:remove_timer(self.v_ui_sound_timer)
    self.v_ui_sound_timer = nil
  end
end

function M:clear_pause_sound_timer()
  if self.v_pause_sound_timer then
    Timer:remove_timer(self.v_pause_sound_timer)
    self.v_pause_sound_timer = nil
  end
end

function M:get_ui_sound_state()
  if self.v_ui_sound_state then
    return true
  else
    return false
  end
end

function M:play_lipsync_data(sound_name, target_obj, is_story)
  if Util.is_nil(target_obj) then
    return
  end
  local sound_acd, cue_name = ShareRes.get_play_sound_info(sound_name)
  if nil == cue_name then
    return
  end
  local sound_cfg = ShareRes.get_sound_cfg(cue_name)
  local language = ""
  if sound_cfg then
    if sound_cfg.BuddyId and 0 ~= sound_cfg.BuddyId then
      language = CharacterMgr:get_buddy_cv_language(sound_cfg.BuddyId)
    end
    if is_story then
      language = Global.curr_story_cv_language
    end
  end
  if "EN" == language then
    sound_name = sound_name .. "_EN"
  elseif "JP" == language then
    sound_name = sound_name .. "_JP"
  end
  local cfg = ShareRes.get_lipsync_data(sound_name)
  if nil ~= cfg then
    local tar_cmp = target_obj.gameObject:GetComponent(CSLipSync)
    if nil == tar_cmp then
      tar_cmp = target_obj.gameObject:AddComponent(CSLipSync)
    end
    tar_cmp:SetDataAndPlay(cfg.lipSyncRes, cfg.lipSyncTime, cfg.moveTowardsSpeed, target_obj.gameObject, cfg.lipSyncResVal)
    self.v_lipsync_cmp = tar_cmp
    self.v_lipsync_obj = target_obj.gameObject
  end
end

function M:stop_lipsync_data()
  if Util.is_nil(self.v_lipsync_cmp) or Util.is_nil(self.v_lipsync_obj) then
    self.v_lipsync_cmp = nil
    self.v_lipsync_obj = nil
    return
  end
  self.v_lipsync_cmp:SetDataAndPlay("___", 0.1, 8, self.v_lipsync_obj)
  self.v_lipsync_cmp = nil
  self.v_lipsync_obj = nil
end

function M:set_audio_active(flag, tower_start, delay_time, force_no_state)
  self.v_common_audio_active = flag
  if flag then
    self:pause_gen_source(false, nil, delay_time, force_no_state)
    self.v_pause_gen_source = false
  else
    self:pause_gen_source(true, nil, delay_time, force_no_state)
    self.v_pause_gen_source = true
  end
end

function M:pause_effect_sound_by_effect_name(effect_name, pause_flag)
  if not self.v_criware_obj_list then
    return
  end
  for _, data in pairs(self.v_criware_obj_list) do
    if data.effect_name == effect_name then
      if not Util.is_nil(data.cri_obj) then
        data.cri_obj:Pause(pause_flag)
        data.cri_obj_loop:Pause(pause_flag)
        data.cri_obj_end:Pause(pause_flag)
      end
      break
    end
  end
end

function M:is_story_voice(file_name)
  if self:start_with(file_name, "storycast_chapter_") or self:start_with(file_name, "voice_sc") then
    return true
  end
  return false
end

function M:start_with(str, prefix)
  return string.sub(str, 1, string.len(prefix)) == prefix
end

return M
