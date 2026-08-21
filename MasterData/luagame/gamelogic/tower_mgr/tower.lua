local Room = require("gamelogic.tower_mgr.room")
local commonDef = require("cs_share.common_define")
local Behavior = require("manager.fight.behavior")
local Seri = require("seri")
local _max = math.max
local _min = math.min
local Coroutine = _ENV.Coroutine
local coroutine = _ENV.coroutine
local M = Util.create_class()
local ROOM_STATE_PASS = 1
local CHAPTER_CONFIG = require("uimodule.chapter.chapter_config")
local ROOM_TYPE = Config.ROOM_TYPE
local MAZE_DATA_STATE = Config.MAZE_DATA_STATE
local ROOM_CLASS = {
  [ROOM_TYPE.TREASURE] = require("gamelogic.tower_mgr.room_type.treasure_room"),
  [ROOM_TYPE.REST] = require("gamelogic.tower_mgr.room_type.restore_hp_room"),
  [ROOM_TYPE.NO_FIGHT_GAME] = require("gamelogic.tower_mgr.room_type.no_fight_game_room")
}
local ROOM_LOCK_STATE = Config.ROOM_LOCK_STATE
local SETTLE_UI_NAME = {
  NOT_PROGRESS_BATTLE_SUC_SETTLE = "not_progress_battle_suc_settle",
  NOT_PROGRESS_BATTLE_DEF_SETTLE = "not_progress_battle_def_settle",
  TOP_VER_SETTLEMENT = "top_ver_settlement",
  FIGHT_SETTLEMENT = "fight_settlement",
  CURSE_RING_SETTLEMENT = "fate_book_settle",
  UI_CHAPTER_DETAIL_INFO = "ui_chapter_detail_info",
  ENDLESS_SETTLE = "endless_settle",
  MINESWEEPER_SUC_SETTLE = "ui_minesweeper_battle_suc"
}
local SPECIAL_SETTLE = {
  [CHAPTER_CONFIG.POINTSTATE.complete] = SETTLE_UI_NAME.NOT_PROGRESS_BATTLE_SUC_SETTLE,
  [CHAPTER_CONFIG.POINTSTATE.quit] = SETTLE_UI_NAME.NOT_PROGRESS_BATTLE_SUC_SETTLE,
  [CHAPTER_CONFIG.POINTSTATE.all_die] = SETTLE_UI_NAME.NOT_PROGRESS_BATTLE_DEF_SETTLE
}
local INFO_SETTLE = {
  [CHAPTER_CONFIG.POINTSTATE.complete] = SETTLE_UI_NAME.UI_CHAPTER_DETAIL_INFO,
  [CHAPTER_CONFIG.POINTSTATE.quit] = SETTLE_UI_NAME.UI_CHAPTER_DETAIL_INFO,
  [CHAPTER_CONFIG.POINTSTATE.all_die] = SETTLE_UI_NAME.NOT_PROGRESS_BATTLE_DEF_SETTLE
}
local MINESWEEPER_SETTLE = {
  [CHAPTER_CONFIG.POINTSTATE.complete] = SETTLE_UI_NAME.MINESWEEPER_SUC_SETTLE,
  [CHAPTER_CONFIG.POINTSTATE.quit] = SETTLE_UI_NAME.NOT_PROGRESS_BATTLE_DEF_SETTLE,
  [CHAPTER_CONFIG.POINTSTATE.all_die] = SETTLE_UI_NAME.NOT_PROGRESS_BATTLE_DEF_SETTLE
}
local SPECIAL_SETTLE_LIST = {
  [commonDef.CHALLENGE_TYPE.BUDDY_TEACH] = SPECIAL_SETTLE,
  [commonDef.CHALLENGE_TYPE.CHAPTER] = INFO_SETTLE,
  [commonDef.CHALLENGE_TYPE.LONG_CHAPTER] = INFO_SETTLE,
  [commonDef.CHALLENGE_TYPE.NEW_MATERIAL] = SPECIAL_SETTLE,
  [commonDef.CHALLENGE_TYPE.INDEPENDENT] = SPECIAL_SETTLE,
  [commonDef.CHALLENGE_TYPE.LINEAR] = SPECIAL_SETTLE,
  [commonDef.CHALLENGE_TYPE.WEEK_ACTY_PERPARE_EPI] = SPECIAL_SETTLE,
  [commonDef.CHALLENGE_TYPE.WEEK_ACTY_PVP_EPI] = SPECIAL_SETTLE,
  [commonDef.CHALLENGE_TYPE.PROBATION_BUDDY] = SPECIAL_SETTLE,
  [commonDef.CHALLENGE_TYPE.BOSS] = SPECIAL_SETTLE,
  [commonDef.CHALLENGE_TYPE.CLIMBING_TOWER] = SPECIAL_SETTLE,
  [commonDef.CHALLENGE_TYPE.ACTIVITY_MINI_GAME] = SPECIAL_SETTLE,
  [commonDef.CHALLENGE_TYPE.ACTIVITY_MINESWEEPER] = MINESWEEPER_SETTLE,
  [commonDef.CHALLENGE_TYPE.VERSION_EPISODE] = SPECIAL_SETTLE,
  [commonDef.CHALLENGE_TYPE.ACTIVITY_PONDER] = SPECIAL_SETTLE
}
local Settlement_List = {
  [commonDef.CHALLENGE_TYPE.BEST_CONF] = SETTLE_UI_NAME.TOP_VER_SETTLEMENT,
  [commonDef.CHALLENGE_TYPE.CHALLENGE_RING] = SETTLE_UI_NAME.FIGHT_SETTLEMENT,
  [commonDef.CHALLENGE_TYPE.CURSE_CIRCLE] = SETTLE_UI_NAME.CURSE_RING_SETTLEMENT,
  [commonDef.CHALLENGE_TYPE.INFINITE] = SETTLE_UI_NAME.ENDLESS_SETTLE
}
local PLAY_FINISH_LOOP_ANIM_SETTLE = {
  [SETTLE_UI_NAME.NOT_PROGRESS_BATTLE_SUC_SETTLE] = true,
  [SETTLE_UI_NAME.UI_CHAPTER_DETAIL_INFO] = true
}
local FightDefine = require("cs_share.fight_define")
local ROOM_WAY_TYPE = FightDefine.ROOM_WAY_TYPE
local enter_time
local is_need_refresh_enter_time = false

function M:_init(tower_id, tower_info)
  self:refresh_enter_time(true)
  self.v_tower_id = tower_id
  self.v_tower_cfg = ShareRes.create("tower.tower", tower_id)
  assert(self.v_tower_cfg, "can't find tower config: " .. tower_id)
  self.v_room_num = 0
  self.floor_enter_count = 0
  self.v_tower_info = tower_info
  self.v_enter_room_num = 0
  self.v_tower_pass = false
  self.v_msg_handles = {}
  self.v_is_play_end_anim = false
  self.v_is_born_anim_end = false
  self.v_is_all_die = false
  self.v_play_pass_anim = false
  self.v_active_play_end_skill_done = false
  self.v_is_active_play_end_skill = false
  self.v_is_in_pass_tower_animation = false
  self.v_active_play_end_skill_cb = nil
  self.v_end_action_data = {}
  self:set_in_room_preload(false)
  self:register_event()
  SceneMgr:set_forbid_switch_hero_state(false)
  self.v_is_on_tp = false
  self.v_tp_room_finish_cb = nil
end

function M:register_event()
  Util.bind_msg(self, Const.MSG_TP_ROOM_FINISH, self.clear_load_scene_res, self)
  Util.bind_msg(self, Const.MSG_ON_BATTLE_LOADING_START, self.on_per_tp_room, self)
  Util.bind_msg(self, Const.MSG_ON_BATTLE_LOADING_END, self.on_per_tp_room_end, self)
  Util.bind_msg(self, Const.MSG_ON_HERO_BORN_ANIM_END, self.set_born_anim_end, self)
  Util.bind_msg(self, Const.MSG_ON_DROP_SHOW_ITEM_END, self.response_drop_show_end, self)
  Util.bind_msg(self, Const.MSG_ON_MAX_WAVE_END_ACTION_ZERO, self.on_max_wave_end_action_zero, self)
end

function M:on_enter()
  self:enter_base_logic()
  self:on_enter_floor(#self.v_tower_info.floor_list, true)
  if UIMgr then
    UIMgr:set_default_camera_obj_visible(false)
  end
end

function M:enter_base_logic()
  self.v_tower_pass = false
end

function M:on_exit()
  Behavior.clear_fight_ui_objs()
  self:release_tp_timer()
  self:on_exit_room()
  self.v_die_role = {}
  Util.unbind_all_msg(self)
  FightBagMgr:exit_tower()
  BattleTalentMgr:exit_tower()
  DropShowMgr:exit_tower()
  BattleSkillBookMgr:exit_tower()
  Rune2Mgr:exit_tower()
  BattleOrnamentMgr:exit_tower()
  TreasureChestMgr:exit_tower()
  ChapterMgr:exit_tower()
  FightDataMgr:exit_tower()
  BuildingMgr:on_exit_tower()
  SimpleTagMgr:exit_tower()
  UIEffectMgr:exit_tower()
  MineSweeperBattleMgr:exit_tower()
  local activity = ActivityMgr:get_top_version_act()
  if activity then
    activity:reset_state()
  end
  ChapterMgr:reset_inf_privilege_data()
  SceneMgr:set_player_control_on()
  if BuffMgr then
    BuffMgr:tower_exit()
  end
  if NewbieTowerMgr then
    NewbieTowerMgr:reset_newbie_tower_state()
  end
  StateReport = nil
  if Global.is_open_timer or JournalMgr:get_oepn_record_jiournal_info() then
    JournalMgr:oepn_record_jiournal_info(false)
  end
  Global.joystick_inverse = false
  TowerMgr:set_battle_team_info(nil)
  SceneMgr:clear_recreate_hero_count()
end

function M:is_first_enter()
  return 1 == self.floor_enter_count and 1 == self.v_enter_room_num
end

function M:enter_archive_room(archieve_resp, callback, check_node_story)
  local room_num = archieve_resp.room_num
  local tp_index = archieve_resp.src_tp_dir
  local room_info = self.v_floor_room_map[room_num]
  if not room_info then
    Log.Error("没有地图配置，请检查，房间号是：", room_num)
    return
  end
  if not self:_check_enter_room(room_num) then
    return
  end
  self.v_reborn_enter_room = true
  Log.Info("----enter_archive_room---->>: ", room_num, tp_index)
  ResPoolMgr:check_timer(true)
  Util.collectgarbage()
  MsgGame:mq_publish2(Const.MSG_BEGIN_SWITCH_ROOM)
  BehaviorShareMgr:reset()
  Network:call("c2gs_tp_room_by_revive", {
    tower_id = self.v_tower_id,
    floor_idx = self.v_floor_num,
    room_num = room_num,
    tp_dir = tp_index
  }, function(ok, resp)
    if not ok or 0 ~= resp.errcode then
      local msg = Util.get_error_code_msg(resp.errcode)
      Log.Error("进入场景时发生错误：", msg, resp.errcode, debug.traceback())
      return
    end
    local create_room_data = {check_node_story = check_node_story}
    self:_do_enter_room(room_num, room_info, tp_index, resp, false, false, nil, create_room_data)
    self:archieve_reborn_hero()
    local data = Seri.unpack(archieve_resp.pack_info)
    SceneMgr:sycn_saved_attrs(data)
    SceneMgr:set_attrs_data()
    local pos_list = resp.postion_list
    if pos_list and UtilTable.hash_lenth(pos_list) > 2 then
      local x, y, z = pos_list[1], pos_list[2], pos_list[3]
      local hero = Global.hero
      local collided = SceneMgr:check_wall_collision(hero, x, z, y)
      if not collided then
        hero:set_pos(x, y, z, true)
        hero:update_pos_height()
      end
    end
    if callback then
      callback()
    end
    Global.camera:set_camera_pos()
  end)
end

function M:on_enter_archive(resp, callback, check_node_story)
  if TowerMgr:is_long_chapter() then
    self:set_execute_node_continue_suc(false)
  end
  if not self:update_floor_info(resp.floor_idx) then
    Log.Error("floor: " .. resp.floor_idx .. "not exist")
    return
  end
  self:enter_archive_room(resp, callback, check_node_story)
end

function M:on_enter_floor(floor, is_first)
  if is_first then
    floor = _max(self.v_tower_info.cur_floor_idx, 1)
  end
  if not self:update_floor_info(floor) then
    return
  end
  self.floor_enter_count = self.floor_enter_count + 1
  local enter_room_num = 0
  if floor == self.v_tower_info.cur_floor_idx then
    enter_room_num = self.v_tower_info.cur_room_num or 0
  end
  if enter_room_num < 1 then
    enter_room_num = self:get_start_room_num()
  end
  self:enter_room(enter_room_num, 0, is_first)
  self.v_select_buddy = nil
end

function M:go_to_team_view(next_floor_num)
  local progress = TowerMgr:get_tower_progress()
  UIMgr:get_ui("team"):ui_show(progress.param, progress.episode_id, progress.challenge_type, nil, progress.node_id, next_floor_num)
end

function M:check_cache_story_data(room_num, is_first)
  self.v_play_story = false
  if is_first and TowerMgr:check_continue_tower() then
    return
  end
  local room_info = self.v_floor_room_map[room_num]
  if not room_info then
    return
  end
  local room_id = room_info.room_id
  local room_cfg = ShareRes.create("tower.tower_room", room_id)
  if not room_cfg then
    return
  end
  local story_id = room_cfg.StoryId
  if not story_id or 0 == story_id then
    return
  end
  StoryMgr:cache_tower_play_story(story_id, room_id)
  self.v_play_story = true
end

function M:check_play_prewar_story()
  return self.v_play_story
end

function M:check_play_story(cb, show_curtain)
  if not StoryMgr then
    return
  end
  local is_play_story = StoryMgr:check_play_tower_story()
  if is_play_story then
    if show_curtain then
      SceneMgr:set_curtain_show(true)
    end
    StoryMgr:play_tower_story(cb)
    return true
  end
end

function M:update_floor_info(floor, cur_room_num)
  local floor_info = self:get_floor_Info(floor)
  if not floor_info then
    Log.Error("层信息获取失败, 层:", floor, "全部层信息：", self.v_tower_info.floor_list, debug.traceback())
    return false
  end
  self.v_floor_num = floor
  self.v_cur_floor_drop_cfg = self:_get_tower_born_magic_list()
  self.v_floor_info = floor_info
  self.v_floor_status = floor_info.status
  self.v_floor_map_id = self.v_floor_info.map_id
  self.v_floor_map_cfg = ShareRes.create("tower.tower_map", self.v_floor_map_id)
  self.v_floor_cfg = ShareRes.create("tower.tower_floor", self.v_tower_cfg.FloorGroup[self.v_floor_num][1])
  local diff_ligh_idx = self.v_floor_cfg and self.v_floor_cfg.LightFxIdx or 0
  self.v_last_diff_light_idx = self.v_diff_light_idx == nil and diff_ligh_idx or self.v_diff_light_idx
  self.v_diff_light_idx = diff_ligh_idx
  self.v_diff_light_idx_ab = self.v_floor_cfg and self.v_floor_cfg.LightFxIdxAB
  self.v_floor_room_map = self.v_floor_info.room_tbl
  self.v_room_num = cur_room_num or 0
  self:init_room_status()
  local connect_cfg = ShareRes.create("tower.tower_map_connect." .. self.v_floor_map_id)
  assert(connect_cfg, "can't find connect config: " .. self.v_floor_map_id)
  self.v_room_connect_cfg = connect_cfg.RoomDic
  return true
end

function M:update_tower_info(tower_info)
  self.v_tower_info = tower_info
end

function M:update_room_info(data)
  local room_data = data.room_info
  local room_num = room_data.room_num
  local room_id = room_data.room_id
  local last_data = self.v_floor_room_map[room_num]
  self.v_floor_room_map[room_num] = room_data
  if self.v_room then
    self.v_room:update_maze_room_info(room_data)
  end
end

function M:get_floor_Info(floor)
  if not self.v_tower_info.floor_list then
    return
  end
  for k, v in ipairs(self.v_tower_info.floor_list) do
    if floor == k then
      return v
    end
  end
end

function M:get_floor_num()
  return self.v_floor_num
end

function M:get_room_num()
  return self.v_room_num
end

function M:get_towet_info()
  return self.v_tower_info
end

function M:get_start_room_num()
  if not self.v_room_connect_cfg then
    return 0
  end
  for k, v in pairs(self.v_room_connect_cfg) do
    if v.StartDir > 0 then
      return v.RoomNum
    end
  end
end

function M:get_room_connect(room_num)
  room_num = room_num or self.v_room_num
  local room_cfg = self.v_room_connect_cfg[room_num]
  if not room_cfg then
    return
  end
  return room_cfg.RoomConnectDic
end

function M:_check_enter_room(enter_room_num)
  if 0 == self.v_room_num then
    return true
  end
  local v_room_info = self.v_floor_room_map[self.v_room_num]
  if v_room_info.room_tp_open ~= nil then
    if not v_room_info.room_tp_open then
      Log.Error("房间：", enter_room_num, "tp点未开启")
    end
    return v_room_info.room_tp_open
  end
  if not v_room_info or v_room_info.status ~= ROOM_STATE_PASS then
    Log.Error("房间未通关：", enter_room_num)
    return false
  end
  return true
end

function M:is_end_room(src_tp_idx)
  if self:get_is_random_room(self.v_room_num) then
    return false
  end
  if not self.v_room_connect_cfg then
    return false
  end
  local room_cfg = self.v_room_connect_cfg[self.v_room_num]
  if not room_cfg then
    Log.Error("tp_room self.v_room_num cfg error", self.v_room_num)
    return
  end
  return nil ~= src_tp_idx and src_tp_idx == room_cfg.EndDir or room_cfg.EndDir > 0
end

local temp_scene_path = "Scene012_01_01"
local temp_cam_path = "LoadingSceneCam"

function M:ready_tp_next_floor()
  if self.v_ready then
    return
  end
  self.v_ready = true
  self.v_temp_scene_obj = ResMgr:load_gameobj(Path.get_res_path(temp_scene_path), nil, true)
  self.v_temp_cam_obj = ResMgr:load_gameobj(Path.get_res_path(temp_cam_path), nil, true)
  self.v_temp_scene_obj.transform:SetParent(self.v_temp_cam_obj.transform)
  self.v_temp_scene_obj.transform:SetLocalPositionA(0, -2, 0)
  self.v_temp_simp_rt = self.v_temp_cam_obj:GetComponent(typeof(CS.Game.SimpleRt))
  local cam_trans = Global.camera:get_camera_trans()
  local camera_cpt = cam_trans:GetComponent(typeof(UnityEngine.Camera))
  self.v_temp_simp_rt:SetCamAndTrans(camera_cpt, cam_trans)
end

function M:clear_load_scene_res()
  if not self.v_ready then
    return
  end
  self.v_ready = nil
  ResMgr:destroy_gameobj(self.v_temp_scene_obj)
  self.v_temp_scene_obj = nil
  ResMgr:destroy_gameobj(self.v_temp_cam_obj)
  self.v_temp_cam_obj = nil
  self.v_temp_simp_rt = nil
end

function M:set_loading_rt(rimg)
  self.v_temp_simp_rt:SetRTTex(rimg)
end

function M:on_tp_room(src_tp_index)
  local tp_room_num = 0
  local tp_index = 0
  local room_cfg = self:get_room_cfg()
  self.v_temp_floor_num = nil
  if src_tp_index == room_cfg.EndDir then
    if #self.v_tower_info.floor_list == self.v_floor_num then
      Log.Info("floor_list not add ", self.v_tower_info, self.v_room_num, self.v_floor_num)
      return
    end
    self:on_enter_floor(self.v_floor_num + 1, nil, true)
    return
  end
  for _, v in pairs(room_cfg.RoomConnectDic) do
    if v.SrcDir == src_tp_index then
      tp_room_num = v.TargetRoomNum
      tp_index = v.TargetDir
      break
    end
  end
  if tp_room_num > 0 then
    local function cb()
      self:enter_room(tp_room_num, tp_index)
    end
    
    self:check_tp_room_play_story(tp_room_num)
    if not self:check_play_story(cb, true) then
      cb()
    end
  else
    print(string.format("tp_room faild : tower %s floor %s roomNum %s map_connect %s src_tp_index %s", self.v_tower_id, self.v_floor_num, self.v_room_num, self.v_floor_map_id, src_tp_index))
  end
end

function M:check_tp_room_play_story(room_num, is_first)
  local room_info = self.v_floor_room_map[room_num]
  if not room_info then
    return
  end
  local room_id = room_info.room_id
  if not TowerMgr:check_play_story_by_room_id(room_id) then
    return
  end
  self:check_cache_story_data(room_num, is_first)
end

function M:enter_room(room_num, tp_index, is_first, by_map, callback)
  local room_info = self.v_floor_room_map[room_num]
  if not room_info then
    Log.Error("没有地图配置，请检查，房间号是：", room_num)
    return
  end
  if not self:_check_enter_room(room_num) then
    Log.Error("无法进入房间：", room_num)
    return
  end
  Log.Info("----enter_room---->>: ", room_num, tp_index, is_first and true or false)
  ResPoolMgr:check_timer(true)
  Util.collectgarbage()
  MsgGame:mq_publish2(Const.MSG_BEGIN_SWITCH_ROOM)
  BehaviorShareMgr:reset()
  self.v_enter_room_num = self.v_enter_room_num + 1
  if is_first then
    Network:protect_call("c2gs_enter_room", {
      tower_id = self.v_tower_id,
      floor_idx = self.v_floor_num,
      room_num = room_num,
      tp_dir = tp_index
    }, function(ok, resp)
      if 0 ~= resp.errcode then
        local msg = Util.get_error_code_msg(resp.errcode)
        Log.Error("进入场景时发生错误：", msg, resp.errcode, debug.traceback())
        if callback then
          callback(false)
        end
        return
      end
      if callback then
        callback(true)
      end
      local mask_tag_key = "c2gs_enter_room_cb"
      ScreenMaskMgr:open_one_tag(mask_tag_key, 5, nil, nil, true, true)
      
      local function login_cb(is_reconnect, errcode)
        ScreenMaskMgr:close_one_tag(mask_tag_key)
        if 0 ~= errcode then
          self:_re_enter_failed(errcode)
          return
        end
        if not is_reconnect then
          self:_do_enter_room(room_num, room_info, tp_index, resp, true, true, by_map)
        else
          Log.Info("MSG_NETWORK_FIGHT_RCT_SUC suc")
          Global.is_enter_room_failed = false
          MsgGame:mq_publish2(Const.MSG_NETWORK_FIGHT_RCT_SUC)
          SceneMgr:fight_reconnect()
          if BehaviorMgr then
            BehaviorMgr:on_reconnect()
          end
        end
      end
      
      local function reconnect_cb()
        ScreenMaskMgr:close_one_tag(mask_tag_key)
        if TowerMgr and TowerMgr:get_has_exist() then
          return false
        end
        Log.Info("reconnecting fight")
        UIMgr:get_ui("reconnecting"):ui_show(Config.CONNECT.FIGHT)
        if Global.camera then
          Global.camera:close_camera_aimed()
        end
        Network:lock_fs_call(false)
        return true
      end
      
      Network:login_fs(resp, login_cb, reconnect_cb)
    end)
  else
    local proto_name = by_map and "c2gs_tp_next_room_by_map" or "c2gs_tp_next_room"
    if GAME_DEBUG then
      Util.add_debug_msg(proto_name)
    end
    local send_data = {
      tower_id = self.v_tower_id,
      floor_idx = self.v_floor_num,
      room_num = room_num,
      tp_dir = tp_index,
      fight_team = not by_map and self.v_node_tp_next_floor_buddys
    }
    self:start_tp_timer()
    Util.wrap_xpcall_func(function()
      SceneMgr:before_enter_next_room()
    end)
    Network:call(proto_name, send_data, function(_, resp)
      if 0 ~= resp.errcode then
        local msg = Util.get_error_code_msg(resp.errcode)
        Log.Error("传送其他场景时发生错误：", msg, resp.errcode, room_num, room_info.room_id, self.v_tower_id)
        if callback then
          callback(false)
        end
        return
      end
      self:release_tp_timer()
      if callback then
        callback(true)
      end
      local is_new_floor = self.v_floor_num ~= self.v_tower_info.cur_floor_idx
      self:_do_enter_room(room_num, room_info, tp_index, resp, is_new_floor, nil, by_map)
    end)
  end
end

function M:start_tp_timer()
  self:release_tp_timer()
  self.tp_timer = Timer:add_timer("start_tp_timer", 6, function()
    local function cb()
      Global.scene_mgr:on_enter_main_scene()
      
      UIMgr:revert_cache_ui()
      Util.show_message_tip("传送超时，即将返回主界面")
    end
    
    if TowerMgr then
      TowerMgr:on_exit_tower(cb)
    end
  end)
end

function M:release_tp_timer()
  if self.tp_timer then
    Timer:remove_timer(self.tp_timer)
    self.tp_timer = nil
  end
end

function M:set_is_need_reload_scene(is_need_reload_scene)
  self.is_need_reload_scene = is_need_reload_scene
end

function M:_do_enter_room(room_num, room_info, tp_index, resp, is_new_floor, is_first_enter, by_map_enter, create_room_data)
  if GAME_DEBUG then
    Util.add_debug_msg("_do_enter_room ", {is_first_enter})
  end
  Global.is_enter_room_failed = false
  self.v_room_num = room_num
  if not self.v_room_num then
    Log.Error("self.v_room_num is nil", debug.traceback())
  end
  local way_type = by_map_enter and ROOM_WAY_TYPE.tp_enter or ROOM_WAY_TYPE.def_enter
  if self.v_reborn_enter_room then
    way_type = ROOM_WAY_TYPE.reborn_enter
    self.v_reborn_enter_room = false
  end
  self:set_enter_room_way(way_type)
  if self.v_room then
    self.v_room:release()
    FightDataMgr:clear_last_monster_dead_pos()
  end
  if self:is_maze_room(self.v_room_num) then
    room_info = self.v_floor_room_map[room_num]
  end
  local is_random = self:get_is_random_room(self.v_room_num)
  local room_cfg = ShareRes.create("tower.tower_room", room_info.room_id)
  local room_type = room_cfg.Type
  if is_random then
    local room_type_cfg = ShareRes.create("tower.tower_room_type", room_type)
    if room_type_cfg and room_type_cfg.relate_type then
      room_type = room_type_cfg.relate_type
    end
  end
  local need_reload_scene = is_new_floor and self.v_last_diff_light_idx ~= self.v_diff_light_idx
  if false == need_reload_scene and self.is_need_reload_scene == true then
    need_reload_scene = true
    self:set_is_need_reload_scene()
  end
  local room_class = ROOM_CLASS[room_type]
  local room_data = {
    room_info = room_info,
    tp_index = tp_index,
    tower = self,
    random_seed = resp.random_seed,
    is_new_floor = is_new_floor,
    room_num = room_num,
    is_first_enter = is_first_enter,
    need_reload_same_scene = need_reload_scene,
    create_room_data = create_room_data
  }
  if room_class then
    self.v_room = room_class:new(room_data)
  else
    self.v_room = Room:new(room_data)
  end
  local fight = UIMgr:try_get_visible_ui("fight")
  if fight then
    fight:on_up_all_code()
  end
  BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.ON_ROOM_CHANGE, Global.hero)
  local msg = MsgGame:mq_publish2(Const.MSG_ON_ENTER_ROOM)
  msg.mm_obj = self.v_room_num
  if Global.camera then
    Global.camera:clear_room_data()
  end
  local tower_id = self.v_tower_id
  local floor_id = self.v_floor_num
  local room_id = room_info.room_id
  SceneMgr:room_offset_shadow(tower_id, floor_id, room_id)
  BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.ON_ENTER_ROOM, room_info.room_id, is_first_enter)
  self:reset_end_action_data()
  if is_first_enter then
    self:on_enter_tower()
  end
  if is_new_floor and self.v_floor_num > 0 and SceneMgr then
    local scene_logic = SceneMgr:get_scene_logic()
    if scene_logic then
      scene_logic:reset_fog_params(true)
    end
  end
  local skill_link_mgr = SceneMgr:get_skill_link_mgr()
  if skill_link_mgr then
    skill_link_mgr:clear_all()
  end
end

function M:_re_enter_failed(errcode)
  UIMgr:try_hide_ui("reconnecting")
  Global.is_enter_room_failed = true
  TowerMgr:on_lost_battle()
end

function M:is_fight_room(room_num)
  local is_random_room = self:get_is_random_room(room_num)
  if not is_random_room then
    local room_cfg = self:get_cur_floor_room_list()[room_num]
    if not room_cfg or not Util.is_more_than_zero(room_cfg.RoomType) then
      Log.Error("get room_cfg failure, mapID:", self.v_floor_map_id(", rooom_num:"), room_num)
    end
    return Util.is_fight_room(room_cfg.RoomType)
  else
    local room_type = self:get_random_room_relate_type(room_num)
    if not room_type then
      return false
    end
    return Util.is_fight_room(room_type)
  end
end

function M:get_random_room_relate_type(room_num)
  local room_info = self.v_floor_room_map[room_num]
  if not room_info then
    Log.Error("get room info error:", room_num)
    return
  end
  local room_cfg = ShareRes.create("tower.tower_room", room_info.room_id)
  if not room_cfg then
    Log.Error("read tower_room error:", room_info.room_id)
    return
  end
  local room_type_cfg = ShareRes.create("tower.tower_room_type", room_cfg.Type)
  if not room_type_cfg then
    Log.Error("read tower_room_type error:", room_num, room_info.room_id, room_cfg.Type)
    return
  end
  return room_type_cfg.relate_type
end

function M:on_pass_room(is_win)
  local v_room_info = self.v_floor_room_map[self.v_room_num]
  self:set_room_pass_status(ROOM_STATE_PASS)
  local msg = MsgGame:mq_publish2(Const.MSG_ON_PASS_ROOM)
  msg.mm_obj = self.v_room_num
  if self:is_fight_room(v_room_info.room_num) and not self:is_curse_ring_tower() then
    local scene_item_mgr = SceneMgr:get_scene_item_mgr()
    scene_item_mgr:create_award_point(self.v_room_num)
  end
  if not self:check_pass_all_room() and TowerMgr:get_fight_type() == commonDef.CHALLENGE_TYPE.LONG_CHAPTER and not SceneMgr:global_hero_is_destroyed() then
    Global.hero:navigator_task_room(nil, true)
  end
  BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.ON_ROOM_PASS, v_room_info.room_id)
end

function M:check_pass_all_room(check_pass)
  local len = #self.v_tower_cfg.FloorGroup
  local max_floor = self.v_tower_cfg.FloorGroup[len][3]
  if max_floor > #self.v_tower_info.floor_list then
    return
  end
  if not self:is_pass_room() then
    return
  end
  local room_cfg = self.v_room_connect_cfg[self.v_room_num]
  if room_cfg.EndDir and room_cfg.EndDir > 0 and #self.v_tower_info.floor_list == self.v_floor_num then
    self.v_tower_pass = true
    local is_play_animation = self:is_pass_tower_animation()
    if is_play_animation and not check_pass then
      self:pass_tower_animation()
    end
    return true
  end
end

function M:is_pass_tower_animation()
  local chapter_id = ShareRes.get_comm_value("GuideTowerFightId")
  local chapter_cfg = ShareRes.create("chapter.chapter_point", chapter_id)
  local check_tower_id = chapter_cfg.FightId
  if check_tower_id == self.v_tower_id then
    return false
  end
  if self.v_is_settle then
    return false
  end
  return true
end

function M:record_die_role(uuid, death_type)
  self.v_die_role = self.v_die_role or {}
  self.v_die_role[uuid] = true
  self.v_last_role_death_type = death_type
end

function M:check_hero_is_all_die()
  local formation_num = UtilTable.hash_lenth(SceneMgr:get_hero_list())
  local die_num = UtilTable.hash_lenth(self.v_die_role)
  return formation_num <= die_num
end

function M:on_role_die_anima_end()
  if self:check_hero_is_all_die() then
    if StoryMgr then
      StoryMgr:stop_story()
    end
    self.v_is_all_die = true
    local _, has_match_event = BehaviorMgr:call_scene_logic_event_fun("custom_death_event", self.v_last_role_death_type)
    if not has_match_event then
      self:normal_death_event()
    end
  end
end

function M:normal_death_event()
  if DebugSetting and not DebugSetting:is_enter_chapter() then
    local function cb()
      Global.scene_mgr:on_enter_main_scene()
    end
    
    TowerMgr:on_exit_tower(cb)
    return
  end
  local progress = TowerMgr:get_tower_progress()
  if progress then
    local ui_name
    if SPECIAL_SETTLE_LIST[progress.challenge_type] then
      ui_name = SPECIAL_SETTLE_LIST[progress.challenge_type][CHAPTER_CONFIG.POINTSTATE.all_die]
    elseif progress.challenge_type == commonDef.CHALLENGE_TYPE.INFINITE and self.v_floor_num <= 1 and not self.v_room:is_fight_end() then
      ui_name = "not_progress_battle_def_settle"
    elseif progress.challenge_type == commonDef.CHALLENGE_TYPE.CURSE_CIRCLE then
      local point_id = progress.episode_id
      local ring_id = ShareRes.get_ring_id_by_point_id(point_id)
      local ring_cfg = ShareRes.get_curse_ring_config(ring_id)
      if not ring_cfg.IsQuickFight then
        ui_name = Settlement_List[progress.challenge_type]
      end
    else
      ui_name = Settlement_List[progress.challenge_type]
    end
    ui_name = ui_name or "not_progress_battle_suc_settle"
    
    local function cb()
      local param = self:build_settle_ui_show_data(ui_name, progress, CHAPTER_CONFIG.POINTSTATE.all_die)
      UIMgr:get_ui(ui_name):ui_show(table.unpack(param))
      SceneMgr:set_game_pause(true)
    end
    
    if self:check_weekly_fight(progress.challenge_type) then
      WeeklyMgr:request_weekly_prepare_score(cb)
    else
      cb()
    end
  end
end

function M:check_weekly_fight(fight_type)
  if fight_type == commonDef.CHALLENGE_TYPE.WEEK_ACTY_PERPARE_EPI or fight_type == commonDef.CHALLENGE_TYPE.WEEK_ACTY_PVP_EPI then
    return true
  end
  return false
end

function M:reborn_hero(reborn_hero_uuid)
  SceneMgr:reborn_npc_by_uuid(reborn_hero_uuid, true)
  self.v_die_role[reborn_hero_uuid] = nil
  self.v_is_all_die = false
  self.v_last_role_death_type = nil
end

function M:reborn_all_hero()
  if not self.v_die_role then
    return
  end
  for uuid, _ in pairs(self.v_die_role) do
    SceneMgr:reborn_npc_by_uuid(uuid, false)
    self.v_die_role[uuid] = nil
  end
  local hero_list = SceneMgr:get_hero_list()
  for key, hero in pairs(hero_list) do
    BehaviorMgr:call_event_fun("on_hero_reborn", hero)
  end
  self.v_is_all_die = false
  self.v_last_role_death_type = nil
end

function M:reborn_hero_by_uuid(uuid)
  if not self.v_die_role or not self.v_die_role[uuid] then
    return
  end
  SceneMgr:reborn_npc_by_uuid(uuid, true)
  self.v_die_role[uuid] = nil
  self.v_is_all_die = false
  self.v_last_role_death_type = nil
end

function M:reborn_npc_by_buff(uuid, attr_ratio_map)
  if not self.v_die_role or not self.v_die_role[uuid] then
    return
  end
  SceneMgr:reborn_npc_by_buff(uuid, attr_ratio_map)
  self.v_die_role[uuid] = nil
  self.v_is_all_die = false
  self.v_last_role_death_type = nil
end

function M:archieve_reborn_hero()
  if not self.v_die_role then
    return
  end
  for uuid, _ in pairs(self.v_die_role) do
    SceneMgr:archieve_reborn_npc_by_uuid(uuid)
    self.v_die_role[uuid] = nil
  end
  self.v_is_all_die = false
  self.v_last_role_death_type = nil
  MsgGame:mq_publish2(Const.MSG_ON_ALL_HERO_ARCHIEVE_REBORN_END)
end

function M:get_die_hero_num()
  return UtilTable.hash_lenth(self.v_die_role)
end

function M:is_pass_room(roomId, not_use_maze_room_status)
  roomId = roomId or self.v_room_num
  local v_room_info = self.v_floor_room_map[roomId]
  if not not_use_maze_room_status and self:is_maze_room(roomId) then
    return v_room_info.maze_room_status == ROOM_STATE_PASS
  end
  if not v_room_info or v_room_info.status ~= ROOM_STATE_PASS then
    return false
  end
  return true
end

function M:go_to_next_floor_with_newbie_tower()
  if self.v_floor_num < #self.v_tower_info.floor_list then
    self:on_enter_floor(self.v_floor_num + 1, nil)
  elseif self:check_pass_all_room() and not self:is_pass_tower_animation() then
    TowerMgr:tower_settle()
  end
end

function M:is_new_bie()
  local fight_type = TowerMgr:get_fight_type()
  return fight_type == commonDef.CHALLENGE_TYPE.NEWBIE_TOWER
end

function M:get_tower_id()
  return self.v_tower_id
end

function M:get_tower_floor_room_map()
  return self.v_floor_room_map
end

function M:get_tower_floor_room_info(room_num)
  if self.v_floor_room_map[room_num] == nil then
    return
  end
  return self.v_floor_room_map[room_num]
end

function M:on_exit_room()
  if self.v_room then
    self.v_room:release()
    self.v_room = nil
  end
end

function M:get_cur_floor_room_list()
  return self.v_room_connect_cfg
end

function M:get_room_custom_info(room_num)
  return self.v_floor_room_map[room_num].pack_custom_info
end

function M:init_room_status()
  local floor_map = self.v_floor_room_map
  local connect_list = {}
  for _, room_data in pairs(floor_map) do
    if room_data.random_room and room_data.random_room_connect then
      for _, connect in pairs(room_data.random_room_connect) do
        if not connect_list[connect.target_room_num] then
          connect_list[connect.target_room_num] = {}
        end
        table.insert(connect_list[connect.target_room_num], {
          src_dir = connect.target_dir,
          target_dir = connect.src_dir,
          target_room_num = room_data.room_num
        })
      end
    end
  end
  for _, room_data in pairs(floor_map) do
    local special_status = room_data.pack_special_status
    if not special_status then
    else
      local npc_status = special_status.npc_status
      local is_obtained = special_status.is_obtained
      local is_restore_hp = special_status.is_restore_hp
      room_data.npc_list = {}
      room_data.is_obtained = is_obtained
      room_data.is_restore_hp = is_restore_hp
      if nil ~= npc_status then
        for npc_id, data in pairs(npc_status) do
          local temp = {
            is_get = not data.is_allowed2_interact,
            npc_id = npc_id
          }
          room_data.npc_list[npc_id] = temp
        end
      end
      if connect_list[room_data.room_num] then
        room_data.random_room_connect = connect_list[room_data.room_num]
      end
    end
  end
end

function M:update_npc_list(room_num, npc_data)
  if self.v_floor_room_map[room_num] == nil then
    return
  end
  local npc_id = npc_data.npc_id
  local temp = {
    is_get = npc_data.is_get,
    npc_id = npc_id
  }
  local npc_list = self.v_floor_room_map[room_num].npc_list
  if not npc_list then
    return
  end
  npc_list[npc_id] = temp
end

function M:update_room_status(room_type, interact)
  local room_info = self.v_floor_room_map[self.v_room_num]
  if room_type == Config.ROOM_TYPE.REST then
    room_info.is_restore_hp = interact
  elseif room_type == Config.ROOM_TYPE.TREASURE then
    room_info.is_obtained = interact
  end
  MsgGame:mq_publish2(Const.MSG_ON_UPDATE_ACTIVE_ROOM)
end

function M:get_room_npc_list(room_num)
  if self.v_floor_room_map[room_num] == nil then
    return
  end
  return self.v_floor_room_map[room_num].npc_list
end

function M:get_room()
  return self.v_room
end

function M:get_tower_pass()
  return self.v_tower_pass
end

function M:pass_tower_animation()
  if self:check_active_play_end_skill() then
    return
  end
  self.v_is_in_pass_tower_animation = true
  Joystick.on_joystick("end")
  SceneMgr:set_player_control_off()
  self:_play_screen_black_ing()
end

function M:check_play_pass_anim()
  return self.v_play_pass_anim
end

function M:_play_screen_black_ing()
  local function callback()
    self:_play_screen_black_out()
  end
  
  local ui_fight = UIMgr:get_ui("fight")
  local SafeArea = ui_fight:get_child_gameobj("SafeArea")
  if SafeArea then
    SafeArea:SetActive(false)
  end
  self.v_play_pass_anim = true
  if self.v_is_play_end_anim then
    ui_fight:screen_fade(0, 1, 0.5, 1.5, 0, callback)
  else
    callback()
  end
end

function M:_do_after_play_screen_black_out()
  if DebugSetting and not DebugSetting:is_enter_chapter() then
    local function cb()
      Global.scene_mgr:on_enter_main_scene()
      
      UIMgr:revert_cache_ui()
    end
    
    if TowerMgr then
      TowerMgr:on_exit_tower(cb)
    end
    return
  end
  local progress = TowerMgr:get_tower_progress()
  if progress and not self.v_fight_end_node_data then
    local ui_name
    if SPECIAL_SETTLE_LIST[progress.challenge_type] then
      ui_name = SPECIAL_SETTLE_LIST[progress.challenge_type][CHAPTER_CONFIG.POINTSTATE.complete]
    else
      ui_name = Settlement_List[progress.challenge_type]
    end
    ui_name = ui_name or "fight_settlement"
    local param = self:build_settle_ui_show_data(ui_name, progress, CHAPTER_CONFIG.POINTSTATE.complete)
    if progress.challenge_type == commonDef.CHALLENGE_TYPE.LONG_CHAPTER then
      local settle_ui = UIMgr:get_ui(ui_name)
      if not settle_ui:visible() then
        settle_ui:ui_show(table.unpack(param))
      end
    else
      UIMgr:get_ui(ui_name):ui_show(table.unpack(param))
    end
    if Global.state_sound_mgr and self.v_is_play_end_anim then
      Global.state_sound_mgr:trigger_fight_state_by_id(Config.FIGHT_STATE.TOWER_WIN)
    end
  end
  self.v_is_play_end_anim = false
end

function M:_do_lens_offset(open_settle_cb)
  local ct = Cinemachine:get_ct_info()
  if ct then
    local ct_pos = ct.transform.position
    local buddy_id = Global.hero.buddy_cfg.Id
    local fashion_id
    if Global.hero.get_fashion_id then
      fashion_id = Global.hero:get_fashion_id()
    end
    local buddy_view_cfg = ShareRes.get_show_buddy_pos_info(buddy_id, fashion_id)
    local default_view_cfg = ShareRes.get_show_buddy_pos_info(0)
    local x, y, duration, use_view_cfg
    if buddy_view_cfg and buddy_view_cfg[6] then
      use_view_cfg = buddy_view_cfg[6]
    elseif default_view_cfg and default_view_cfg[6] then
      use_view_cfg = default_view_cfg[6]
    end
    x = use_view_cfg and use_view_cfg.LensOffset[1] or 0.5
    y = use_view_cfg and use_view_cfg.LensOffset[2] or 0.5
    duration = use_view_cfg and use_view_cfg.LensOffset[3] or 0.6
    ct_pos.x = ct_pos.x - x
    ct_pos.y = ct_pos.y + y
    local tween = ct.transform:DOMove(ct_pos, duration)
    tween:OnComplete(open_settle_cb)
  else
    open_settle_cb()
  end
end

function M:_get_skill_finish_cost_time()
  local cost_time
  local ct = Cinemachine:get_ct_info()
  if ct and ct.playable then
    cost_time = ct.playable.duration
  else
    cost_time = Global.hero.skill_mgr:get_fight_end_skill_finish_time()
  end
  cost_time = cost_time - 0.1
  local cfg = ShareRes.get_buddy_settle_param(Global.hero:get_npc_id())
  local delay_time = cfg and cfg.DelayTime or 0
  cost_time = cost_time + delay_time
  return cost_time
end

function M:_yield_wait_fight_end_skill_finish()
  Coroutine.start(function()
    local cost_time = self:_get_skill_finish_cost_time()
    coroutine.yield(UnityEngine.WaitForSeconds(cost_time))
    self:_do_after_play_screen_black_out()
  end)
end

function M:_play_screen_black_out()
  if self.v_is_play_end_anim and Global.hero and not Global.hero:is_die() then
    UIMgr:hide_other_uis("fight")
    local ui_fight = UIMgr:get_ui("fight")
    ui_fight:screen_fade(1, 0, 3, nil, 1)
  else
    self:_do_after_play_screen_black_out()
  end
  if not self.v_tower_pass or self.v_is_play_end_anim then
    local scene_logic = SceneMgr:get_scene_logic()
    scene_logic:set_hero_born_pos()
  end
  Global.camera:set_camera_pos()
  Global.hero.role_move_ctrl:stop_skill_joystick()
  Global.hero:set_target_dir(0, true)
  if self.v_is_play_end_anim then
    SceneMgr:clear_missile()
    SceneMgr:clear_hero_magic_on_settle()
    Global.hero.skill_mgr:play_fight_end_skill()
    self:_yield_wait_fight_end_skill_finish()
  end
  if Global.state_sound_mgr then
    Global.state_sound_mgr:trigger_fight_state_by_id(Config.FIGHT_STATE.FIGHT_END_PLAY_ANIM)
  end
end

function M:active_play_end_skill()
  local function done_cb()
    self.v_active_play_end_skill_done = true
    
    if self.v_active_play_end_skill_cb then
      self:v_active_play_end_skill_cb()
    end
  end
  
  local function callback()
    UIMgr:hide_other_uis("fight")
    local ui_fight = UIMgr:get_ui("fight")
    ui_fight:screen_fade(1, 0, 3, nil, 1)
    local scene_logic = SceneMgr:get_scene_logic()
    scene_logic:set_hero_born_pos()
    Global.camera:set_camera_pos()
    Global.hero.role_move_ctrl:stop_skill_joystick()
    Global.hero:set_target_dir(0, true)
    SceneMgr:clear_missile()
    SceneMgr:clear_hero_magic_on_settle()
    Global.hero.skill_mgr:play_fight_end_skill()
    if Global.state_sound_mgr then
      Global.state_sound_mgr:trigger_fight_state_by_id(Config.FIGHT_STATE.FIGHT_END_PLAY_ANIM)
    end
    local cost_time = self:_get_skill_finish_cost_time()
    if cost_time > 0 then
      Timer:add_timer("active_play_end_skill_timer", cost_time, done_cb)
    else
      done_cb()
    end
  end
  
  Joystick.on_joystick("end")
  SceneMgr:set_player_control_off()
  Behavior.set_ui_object_visible("fight", "Main", false)
  self.v_play_pass_anim = true
  local ui_fight = UIMgr:get_ui("fight")
  ui_fight:screen_fade(0, 1, 0.5, 1.5, 0, callback)
end

function M:play_fight_end_anim_state(is_play)
  self.v_is_play_end_anim = is_play
end

function M:response_drop_event(msg)
  if Util.is_client_only() then
    return
  end
  if nil == msg or nil == msg.mm_x then
    return
  end
  local is_drop_end = msg.mm_x
  if is_drop_end then
    self:check_pass_all_room()
  end
end

function M:set_is_settle(is_settle)
  self.v_is_settle = is_settle
end

function M:is_default_tower()
  return true
end

function M:is_challenge_ring_tower()
  return false
end

function M:get_tower_cur_floor_num()
  return self.v_tower_info.cur_floor_idx
end

function M:get_tower_curse_tower_data()
  return self.v_tower_info.curse_tower_data
end

function M:set_born_anim_end()
  self.v_is_born_anim_end = true
end

function M:set_born_anim_begin()
  self.v_is_born_anim_end = false
end

function M:get_born_anim_state()
  return self.v_is_born_anim_end
end

function M:response_drop_show_end(msg)
  if Util.is_client_only() then
    return
  end
  if nil == msg then
    return
  end
  self:check_pass_all_room()
end

local PRELOAD_RES = {
  "Fx_Baoshi",
  "Fx_Transmit3_idel"
}

function M:get_preload_res()
  return PRELOAD_RES
end

function M:on_update_lock_info(data)
  self:_set_room_lock_state(data.room_num, data.target_room_num, data.lock_status)
  self:_set_room_lock_state(data.target_room_num, data.room_num, data.lock_status)
  Global.hero:navigator_task_room()
end

function M:_set_room_lock_state(room_num, target_room_num, islock)
  local room = self.v_floor_room_map[room_num]
  if not room then
    Log.Error("get room info failure! room_id=", room_num)
    return
  end
  if not room.lock_list then
    Log.Error("get room lock list failure! room_id=", room)
    return
  end
  local lock_info = room.lock_list[target_room_num]
  if not lock_info then
    Log.Error("获取房间锁定数据失败！请检查配置！ room_id=", room_num, "target_room=", target_room_num)
    return
  end
  lock_info.locak_state = islock and ROOM_LOCK_STATE.UNLOCK or ROOM_LOCK_STATE.LOCK
  if islock and self.v_room_num == room_num then
    local connect_data = self:get_room_connect(room_num)
    if not connect_data then
      Log.Error("get room connect info failure! room_id=", room_num)
      return
    end
    local tp_id = 0
    for _, v in pairs(connect_data) do
      if v.TargetRoomNum == target_room_num then
        tp_id = v.SrcDir
        break
      end
    end
    if 0 == tp_id then
      Log.Error("get room connect info failure! room_id=", room_num, "target_room=", target_room_num)
      return
    end
    local logic = SceneMgr:get_scene_logic()
    local door = logic:get_tp(tp_id)
    if not door then
      return
    end
    door:set_tp_lock(false)
  end
end

function M:_get_tp_lock_data(room_num, tp_id)
  local room = self.v_floor_room_map[room_num]
  if not room then
    Log.Error("get room info failure! room_num=", room_num)
    return
  end
  local room_cfg = self.v_room_connect_cfg[room_num]
  if room_cfg and (room_cfg.EndDir == tp_id or room_cfg.StartDir == tp_id) then
    return
  end
  if not room.lock_list then
    return
  end
  local target_room_num = self:_get_tp_target_room(room_num, tp_id)
  local lock_data = room.lock_list[target_room_num]
  if not lock_data then
    Log.Error("get room lock info failure! room_num=", room_num, "tp_id=", tp_id, debug.traceback())
    return
  end
  return lock_data
end

function M:_get_tp_target_room(room_num, tp_id)
  local connect_list = self:get_room_connect(room_num)
  if not connect_list then
    Log.Error("没有该房间的连通配置! 房间id=", room_num, "出错配置=", self.v_floor_map_id, debug.traceback())
    return
  end
  local connect_data = connect_list[tp_id]
  if not connect_data then
    Log.Error("房间连通配置中没有该tp配置! 房间id=", room_num, "tp_id=", tp_id, "connect_list=", connect_list, "出错配置=", self.v_floor_map_id, debug.traceback())
    return
  end
  return connect_data.TargetRoomNum
end

function M:get_tp_is_locked(room_num, tp_id)
  if self:get_is_random_room(room_num) then
    return false
  end
  if self:is_maze_room(room_num) then
    return false
  end
  local lock_data = self:_get_tp_lock_data(room_num, tp_id)
  if not lock_data then
    return false
  end
  return lock_data.locak_state == ROOM_LOCK_STATE.LOCK
end

function M:get_tp_condition(room_num, tp_id)
  local room_data = self.v_room_connect_cfg[room_num]
  if not room_data then
    Log.Error("get room failure, room_id=", room_num)
    return
  end
  local connect_data = room_data.RoomConnectDic[tp_id]
  if not connect_data then
    Log.Error("get connect data failure, tp_id=", tp_id)
    return
  end
  return connect_data.UnlockCondition, connect_data.UnlockDesc
end

function M:unlock_tp_door(room_num, tp_id)
  local logic = SceneMgr:get_scene_logic()
  local door = logic:get_tp(tp_id)
  if not door then
    Log.Error("get tp point failure! tp_id=", tp_id)
    return
  end
  local list = self:get_tp_condition(room_num, tp_id)
  local unlock_index = 1
  for i, v in ipairs(list) do
    if Condition:check_condition(v) then
      unlock_index = i
      break
    end
  end
  Network:call("c2gs_unlock_next_room", {
    target_room_num = self:_get_tp_target_room(room_num, tp_id),
    unlock_index = unlock_index
  }, function(ok, resp)
    if ok then
      local lock_data = self:_get_tp_lock_data(room_num, tp_id)
      if lock_data then
        lock_data.locak_state = ROOM_LOCK_STATE.UNLOCK
        door:set_tp_lock(false)
        Util.show_message_tip(2097)
      end
    end
  end)
end

function M:show_tp_lock_notice(room_id, tp_id, notice_str)
  local logic = SceneMgr:get_scene_logic()
  local door = logic:get_tp(tp_id)
  if not door then
    Log.Error("get tp point failure! tp_id=", tp_id)
    return
  end
  door:show_tp_lock_notice(notice_str)
end

function M:get_is_random_room(room_num)
  local room_info = self:get_tower_floor_room_info(room_num)
  if not room_info then
    return false
  end
  return room_info.random_room
end

function M:get_random_room_list(room_num)
  room_num = room_num or self.v_room_num
  local room_info = self:get_tower_floor_room_info(room_num)
  if not room_info then
    Log.Error("get room info failure! room_num=", room_num)
    return {}
  end
  return room_info.random_room_connect or {}
end

function M:is_maze_room(room_num)
  room_num = room_num or self.v_room_num
  local room_info = self:get_tower_floor_room_info(room_num)
  if not room_info then
    return false
  end
  return room_info.maze_room
end

function M:get_maze_connect_room(room_num)
  room_num = room_num or self.v_room_num
  local room_info = self:get_tower_floor_room_info(room_num)
  if not room_info then
    Log.Error("get room info failure! room_num=", room_num)
    return {}
  end
  return room_info.maze_room_connect or {}
end

function M:on_open_floor_preview(data)
  local floor_idx = data.floor_idx
  if not self.v_tower_info.floor_list then
    return
  end
  for k, v in ipairs(self.v_tower_info.floor_list) do
    v.preview_status = k == floor_idx
  end
end

function M:get_cur_floor_info()
  return self.v_floor_info
end

function M:check_can_reborn()
  local reborn_num = TowerMgr:get_fight_reborn_num()
  local fight_info = TowerMgr:get_fight_info()
  local point_cfg = ShareRes.get_chapter_point_cfg(fight_info.point_id)
  local reborn_cfg = ShareRes.get_chapter_reborn_cfg(point_cfg.RebornId or 1)
  if reborn_num >= #reborn_cfg.RebornCostId then
    return false
  end
  reborn_num = reborn_num + 1
  return BagMgr:get_item_num(reborn_cfg.RebornCostId[reborn_num]) >= reborn_cfg.RebornCostNum[reborn_num]
end

function M:is_ready_tp()
  return self.v_ready
end

function M:get_tp_pos_rule_type()
  return self.v_tower_cfg.IsHakoniwa
end

function M:get_play_born_skill()
  return self.v_tower_cfg.PlayBornSkill
end

function M:get_enter_room_num()
  return self.v_enter_room_num
end

function M:get_diff_light_index()
  return self.v_diff_light_idx or 0
end

function M:get_diff_light_index_AB()
  return self.v_diff_light_idx_ab
end

function M:get_max_floor()
  return self.v_tower_cfg.FloorMax
end

function M:on_all_item_picked()
end

function M:can_archieve()
  return self.v_tower_cfg.IsHakoniwa and self.v_tower_cfg.IsHakoniwa > 0
end

function M:is_show_arrow()
  return self.v_tower_cfg.IsShowArrow and self.v_tower_cfg.IsShowArrow > 0
end

function M:set_continue_fight_time(fight_time)
end

function M:set_enter_room_way(way)
  self.v_enter_room_way = way
end

function M:get_enter_room_way()
  return self.v_enter_room_way
end

function M:get_tower_uuid()
  return self.v_tower_info.tower_uuid
end

function M:is_show_battle_task()
  if self.v_show_battke_task_all_tower then
    return true
  end
  return self.v_show_battle_task_rooms and self.v_show_battle_task_rooms[self.v_room_num]
end

function M:set_is_show_battle_task(is_show, is_all_tower)
  if not is_all_tower then
    self.v_show_battle_task_rooms = self.v_show_battle_task_rooms or {}
    self.v_show_battle_task_rooms[self.v_room_num] = is_show
  end
  self.v_show_battke_task_all_tower = is_all_tower
end

function M:update_maze_data(data)
  local room_info = self:get_cur_room_info()
  self.v_cur_maze_data = data
  local copy_data = UtilTable.copy_table(self.v_cur_maze_data)
  if not self.v_last_maze_data then
    if data.explore_cnt and 0 ~= data.explore_cnt and data.evacuate_cnt and 0 ~= data.evacuate_cnt then
      copy_data.state = MAZE_DATA_STATE.ALL_CNT_CHANGE
    elseif data.explore_cnt and 0 ~= data.explore_cnt then
      copy_data.state = MAZE_DATA_STATE.EXPLORE_CNT_CHANGE
    elseif data.evacuate_cnt and 0 ~= data.evacuate_cnt then
      copy_data.state = MAZE_DATA_STATE.EVACUATE_CNT_CHANGE
    end
  elseif data.explore_cnt and data.explore_cnt ~= self.v_last_maze_data.explore_cnt and data.evacuate_cnt and data.evacuate_cnt ~= self.v_last_maze_data.evacuate_cnt then
    copy_data.state = MAZE_DATA_STATE.ALL_CNT_CHANGE
  elseif data.explore_cnt and data.explore_cnt ~= self.v_last_maze_data.explore_cnt then
    copy_data.state = MAZE_DATA_STATE.EXPLORE_CNT_CHANGE
  elseif data.evacuate_cnt and data.evacuate_cnt ~= self.v_last_maze_data.evacuate_cnt then
    copy_data.state = MAZE_DATA_STATE.EVACUATE_CNT_CHANGE
  end
  self.v_copy_maze_data = copy_data
  self.v_last_maze_data = self.v_cur_maze_data
  if not self.v_is_on_tp then
    self:show_maze_data_tips()
  else
    function self:v_tp_room_finish_cb()
      self:show_maze_data_tips()
    end
  end
end

function M:show_maze_data_tips()
  local common_battle_tips = UIMgr:get_ui("common_battle_tips")
  if common_battle_tips:visible() then
    common_battle_tips:show_maze_data_tips(self.v_copy_maze_data)
  else
    local data = {
      maze_data = self.v_copy_maze_data
    }
    common_battle_tips:ui_show(data)
  end
end

function M:get_cur_room_info()
  return self:get_tower_floor_room_info(self.v_room_num)
end

function M:get_cur_room_id()
  if self.v_room then
    return self.v_room:get_room_id()
  end
end

function M:on_per_tp_room()
  self:set_tp_state(true)
end

function M:on_per_tp_room_end()
  if self.v_tp_room_finish_cb then
    self:v_tp_room_finish_cb()
    self.v_tp_room_finish_cb = nil
  end
  self:set_tp_state(false)
end

function M:set_tp_state(on_tp)
  self.v_is_on_tp = on_tp
end

function M:reset_maze_data()
  self.v_cur_maze_data = nil
  self.v_last_maze_data = nil
end

function M:get_cur_floor_id()
  return self.v_tower_cfg.FloorGroup[self.v_floor_num][1]
end

function M:record_temp_formation_data(floor_num)
  self.v_temp_floor_num = floor_num
end

function M:get_temp_formation_data()
  return self.v_temp_floor_num
end

function M:get_tower_type()
  return self.v_tower_cfg.Type
end

function M:is_curse_ring_tower()
  return self.v_tower_cfg.Type == Config.TOWER_TYPE.CURSE_RING
end

function M:check_is_in_tp()
  return self.v_is_on_tp
end

function M:record_node_save_data(data)
  self.v_node_save_data = data
end

function M:record_fight_end_node_data(data)
  self.v_fight_end_node_data = data
end

function M:get_fight_end_node_data()
  return self.v_fight_end_node_data
end

function M:check_show_recore_node_save()
  if self.v_fight_end_node_data then
    local progress = TowerMgr:get_tower_progress()
    local ui_name = SETTLE_UI_NAME.UI_CHAPTER_DETAIL_INFO
    local param = self:build_settle_ui_show_data(ui_name, progress, nil, self.v_fight_end_node_data)
    UIMgr:get_ui(ui_name):ui_show(table.unpack(param))
  end
end

function M:check_need_play_end_anim()
  return self.v_is_play_end_anim
end

function M:on_node_tp_next_floor(floor_num, buddy_id_list)
  MsgGame:mq_publish2(Const.MSG_ON_ENTER_NEW_FLOOR)
  MsgGame:mq_publish2(Const.MSG_PRE_TP_ROOM)
  self.v_node_tp_next_floor_buddys = buddy_id_list
  self.v_select_buddy = true
  self:on_enter_floor(floor_num, false, true, true)
  self.v_node_tp_next_floor_buddys = nil
end

function M:is_need_show_level_floor_win()
  if not self.v_floor_cfg then
    return false
  end
  if self.v_floor_cfg.IsShowLevelFloorWin then
    return 1 == self.v_floor_cfg.IsShowLevelFloorWin
  end
  return false
end

function M:get_room_cfg()
  local room_cfg
  if self:get_is_random_room(self.v_room_num) then
    local conect_list = self:get_random_room_list(self.v_room_num)
    room_cfg = {
      EndDir = 0,
      RoomConnectDic = {}
    }
    for _, v in pairs(conect_list) do
      room_cfg.RoomConnectDic[v.src_dir] = {
        SrcDir = v.src_dir,
        TargetDir = v.target_dir,
        TargetRoomNum = v.target_room_num
      }
    end
    self:reset_maze_data()
  elseif self:is_maze_room(self.v_room_num) then
    local connect_room_list = self:get_maze_connect_room(self.v_room_num)
    room_cfg = {
      EndDir = 0,
      RoomConnectDic = {}
    }
    for _, v in pairs(connect_room_list) do
      room_cfg.RoomConnectDic[v.src_dir] = {
        SrcDir = v.src_dir,
        TargetDir = v.target_dir,
        TargetRoomNum = v.target_room_num
      }
    end
  else
    room_cfg = self.v_room_connect_cfg[self.v_room_num]
    self:reset_maze_data()
  end
  if not room_cfg then
    Log.Error("tp_room self.v_room_num cfg error", self.v_room_num)
    return
  end
  return room_cfg
end

function M:get_tp_target_room_id(tp_id)
  if not self.v_floor_room_map or not tp_id then
    return
  end
  local room_cfg = self:get_room_cfg()
  local room_num
  if room_cfg and room_cfg.RoomConnectDic and room_cfg.RoomConnectDic[tp_id] then
    room_num = room_cfg.RoomConnectDic[tp_id].TargetRoomNum
  end
  if room_num and self.v_floor_room_map[room_num] then
    return self.v_floor_room_map[room_num].room_id
  end
end

function M:is_need_auto_tp_next_floor()
  return self.v_floor_cfg ~= nil and nil ~= self.v_floor_cfg.AutoTpNextFloor and self.v_floor_cfg.AutoTpNextFloor >= 1
end

function M:refresh_enter_time(is_clear)
  if is_clear then
    is_need_refresh_enter_time = true
    enter_time = nil
    return
  end
  if is_need_refresh_enter_time then
    enter_time = Global.real_time
    is_need_refresh_enter_time = false
    if Global.sound_mgr then
      Global.sound_mgr:refresh_switch_label_state(true)
    end
  end
end

function M:get_tower_enter_time()
  if not enter_time then
    return 0
  end
  return Global.real_time - enter_time
end

function M:build_settle_ui_show_data(ui_name, progress, state, data)
  local award_list, node_id
  if data then
    award_list = data.result_list
    node_id = data.node_id
  elseif self.v_node_save_data then
    award_list = self.v_node_save_data.result_list
    node_id = self.v_node_save_data.node_id
    self.v_node_save_data = nil
  elseif self.v_fight_end_node_data then
    award_list = self.v_fight_end_node_data.result_list
    node_id = self.v_fight_end_node_data.node_id
  else
    award_list = progress.award_list
    node_id = progress.node_id
  end
  local param
  if ui_name == SETTLE_UI_NAME.UI_CHAPTER_DETAIL_INFO then
    local module_type = Config.FIGHT_TYPE_TO_MODULE_TYPE[progress.challenge_type] or Config.AREA_POINT_MODULE_TYPE.CHAPTER_POINT
    local param2 = progress.challenge_type == commonDef.CHALLENGE_TYPE.LONG_CHAPTER and node_id or progress.episode_id
    local select_param = {result_list = award_list}
    param = table.pack(progress.param, param2, module_type, select_param)
  else
    param = table.pack(state)
  end
  return param
end

function M:on_max_wave_end_action_zero(msg)
  local magic_list = ShareRes.get_comm_string_value("FinishMagic")
  local magic_mgr = Global.hero.magic_mgr
  for key, magic_id in pairs(magic_list) do
    magic_mgr:add_magic(Global.hero, magic_id)
  end
end

function M:check_active_play_end_skill()
  if self.v_play_pass_anim and self.v_is_active_play_end_skill then
    if not self.v_active_play_end_skill_done then
      if not self.v_active_play_end_skill_cb then
        function self.v_active_play_end_skill_cb()
          self:_do_after_play_screen_black_out()
        end
      end
    else
      self:_do_after_play_screen_black_out()
    end
    return true
  end
  return false
end

function M:add_end_action_map(uuid, is_max_wave, event_key)
  if not self.v_end_action_data[event_key] then
    self.v_end_action_data[event_key] = {}
    self.v_end_action_data[event_key].map = {}
    self.v_end_action_data[event_key].is_max_wave = false
    self.v_end_action_data[event_key].count = 0
  end
  local end_action_data = self.v_end_action_data[event_key]
  end_action_data.map[uuid] = true
  end_action_data.count = end_action_data.count + 1
  if is_max_wave and not end_action_data.is_max_wave then
    end_action_data.is_max_wave = true
  end
end

function M:remove_end_action_map(uuid, event_key, is_destroy)
  local end_action_data = self.v_end_action_data[event_key]
  if not (end_action_data and end_action_data.map[uuid]) or end_action_data.count <= 0 then
    return
  end
  end_action_data.map[uuid] = nil
  end_action_data.count = end_action_data.count - 1
  if 0 == end_action_data.count and end_action_data.is_max_wave then
    if not is_destroy then
      MsgGame:mq_publish2(Const.MSG_ON_MAX_WAVE_END_ACTION_ZERO)
    end
    self.v_end_action_data[event_key] = nil
  end
end

function M:reset_end_action_data()
  UtilTable.clear_map(self.v_end_action_data)
end

function M:is_execute_node_continue_suc()
  local is_send = false
  if not self.v_execute_node_continue_suc then
    self:set_execute_node_continue_suc(true)
    is_send = true
  end
  return is_send
end

function M:set_execute_node_continue_suc(suc)
  self.v_execute_node_continue_suc = suc
end

function M:get_behavior_ai_param()
  local room_info = self:get_cur_room_info()
  if not room_info then
    return
  end
  local room_cfg = ShareRes.create("tower.tower_room", room_info.room_id)
  local AIGroup, AIDifficultyTag
  if room_cfg then
    AIGroup, AIDifficultyTag = room_cfg.AIGroup, room_cfg.AIDiffcultyTag
  end
  if not AIGroup or not AIDifficultyTag then
    local tower_floor_group = self.v_tower_cfg.FloorGroup
    if tower_floor_group then
      local floor_id
      for _, info in ipairs(tower_floor_group) do
        if info[2] <= self.v_floor_num and self.v_floor_num <= info[3] then
          floor_id = info[1]
          break
        end
      end
      if floor_id then
        local floorCfg = ShareRes.create("tower.tower_floor", floor_id)
        if floorCfg then
          AIGroup = AIGroup or floorCfg.AIGroup
          AIDifficultyTag = AIDifficultyTag or floorCfg.AIDiffcultyTag
        end
      end
    end
  end
  AIGroup = AIGroup or self.v_tower_cfg.AIGroup or ShareRes.get_comm_value("BaheviorAiId")
  AIDifficultyTag = AIDifficultyTag or self.v_tower_cfg.AIDiffcultyTag
  if not AIDifficultyTag then
    local fight_type = TowerMgr:get_fight_type()
    AIDifficultyTag = 1 == (fight_type == commonDef.CHALLENGE_TYPE.LONG_CHAPTER) or 0
  end
  return AIGroup, AIDifficultyTag
end

function M:get_floor_map_id()
  return self.v_floor_map_id
end

function M:get_pass_floor_num()
  return self:is_end_room() and self:is_pass_room() and self.v_floor_num or self.v_floor_num - 1
end

function M:is_in_room_preload()
  return self.v_in_room_preload
end

function M:set_in_room_preload(in_room_preload)
  self.v_in_room_preload = in_room_preload
end

function M:on_enter_tower()
  FightDataMgr:enter_tower()
  BuildingMgr:on_enter_tower()
  UIEffectMgr:enter_tower()
  if self:is_curse_ring_tower() then
    ChallengeRingPlusMgr:enter_tower()
  end
  TaskMgr:clear_cur_chapter_finish_task()
  BehaviorMgr:on_enter_tower()
  self:check_tower_task_data()
  local progress = TowerMgr:get_tower_progress()
  if progress.challenge_type == commonDef.CHALLENGE_TYPE.LONG_CHAPTER then
    ChapterMgr:record_chapter_max_save_node_id(progress.param)
    local node_cfg = ShareRes.get_chapter_node_cfg(progress.node_id)
    local cur_node_id = node_cfg.PreNodeId or progress.node_id
    ChapterMgr:record_suc_node(cur_node_id)
    TowerMgr:clear_long_chapter_award()
  elseif progress.challenge_type == commonDef.CHALLENGE_TYPE.ACTIVITY_MINESWEEPER then
    MineSweeperBattleMgr:enter_tower()
  end
end

function M:check_tower_task_data()
  local use_assist = TowerMgr:check_use_assist()
  if use_assist then
    TowerMgr:check_tower_task_update(commonDef.TOWER_TASK_TYPE.FIGHT_TIME_NOT_USE_HELP_BUDDY, false, 1)
  end
  local battle_team_info = TowerMgr and TowerMgr:get_battle_team_info()
  if battle_team_info then
    local hero_count = 0
    local hero_list = battle_team_info.hero_list
    for key, data in pairs(hero_list) do
      if data.type == commonDef.FORMATION_BUDDY_STATUS.MYSELF then
        hero_count = hero_count + 1
      end
    end
    TowerMgr:check_tower_task_update(commonDef.TOWER_TASK_TYPE.FORMAT_LIMIT, false, hero_count)
  end
  local floor_num = self:get_pass_floor_num()
  floor_num = math.max(0, floor_num)
  TowerMgr:check_tower_task_update(commonDef.TOWER_TASK_TYPE.PASS_FLOOR_NUM, false, floor_num)
end

function M:set_room_pass_status(status)
  local v_room_info = self.v_floor_room_map[self.v_room_num]
  local room_pass = status == ROOM_STATE_PASS
  if v_room_info then
    if not self:is_maze_room(self.v_room_num) then
      v_room_info.status = status
    else
      v_room_info.maze_room_status = status
    end
    v_room_info.room_tp_open = room_pass
  else
    Log.Error("获取房间信息失败！！房间号是：", self.v_room_num)
  end
  if self.v_room then
    self.v_room:set_fight_end(room_pass)
  end
end

function M:_get_tower_born_magic_list()
  local tower_drop_cfg
  local tower_drop_cfgs = ShareRes.get_tower_drop_cfg(self.v_tower_id)
  if tower_drop_cfgs then
    local length = #tower_drop_cfgs
    for index = 1, length do
      tower_drop_cfg = tower_drop_cfgs[index]
      if self.v_floor_num >= tower_drop_cfg.FloorNum then
        return tower_drop_cfg
      end
    end
  end
end

function M:get_born_magics(auto_level)
  if not auto_level then
    return
  end
  local list_name = "BornMagicList" .. auto_level
  return self.v_cur_floor_drop_cfg and self.v_cur_floor_drop_cfg[list_name]
end

return M
