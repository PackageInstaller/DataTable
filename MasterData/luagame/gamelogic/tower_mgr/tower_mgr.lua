local Base = require("gamelogic.base_system")
local Tower = require("gamelogic.tower_mgr.tower")
local Seri = require("seri")
local M = Util.create_child_mt(Base)
local CommonDefine = require("cs_share.common_define")
local NPC_KIND = CommonDefine.NPC_KIND
local CHAPTER_CONFIG = require("uimodule.chapter.chapter_config")
local FightCalc = require("cs_share.fight_calc")
local _floor = math.floor
local _random = math.random
local _insert = table.insert
local _min = math.min
local TOWER_TYPE = Config.TOWER_TYPE
local NOT_PROGRESS_BATTLE_TYPE = Config.NOT_PROGRESS_BATTLE_TYPE
local TOWER_CLASS = {
  [TOWER_TYPE.DEFAULT] = require("gamelogic.tower_mgr.tower"),
  [TOWER_TYPE.CHALLENGE_RING] = require("gamelogic.tower_mgr.challenge_ring_tower"),
  [TOWER_TYPE.CURSE_RING] = require("gamelogic.tower_mgr.curse_ring_tower"),
  [TOWER_TYPE.CUT_GRASS] = require("gamelogic.tower_mgr.cut_grass_tower")
}
local CHALLENGE_TYPE = {
  [CommonDefine.CHALLENGE_TYPE.CHAPTER] = "困难模式",
  [CommonDefine.CHALLENGE_TYPE.LONG_CHAPTER] = "主线",
  [CommonDefine.CHALLENGE_TYPE.INFINITE] = "穷举模式",
  [CommonDefine.CHALLENGE_TYPE.CURSE_CIRCLE] = "命运之书",
  [CommonDefine.CHALLENGE_TYPE.CUT_GRASS] = "止境之行"
}

function M:init_sys()
  self.v_tower_map = {}
  self.v_tower_story_record = {}
  self.is_first_enter_node = false
  self.v_tower = nil
  self.v_is_enbale_god_skill = false
  Network:call("c2gs_towerlist", {}, function(ok, resp)
    for k, v in pairs(resp.tower_list) do
      self.v_tower_map[v.tower_id] = v.status
    end
    self:complete_sys()
  end)
  self.v_npc_drop = {}
  self.v_npc_drop[NPC_KIND.MONSTER] = {}
  self.v_npc_drop[NPC_KIND.ELITE] = {}
  self.v_npc_drop[NPC_KIND.BOSS] = {}
  self.v_teaching_fail_data = {}
  self.v_long_chapter_award = {}
  self:set_battle_team_info(nil)
  self:sys_mq_bind(Const.MSG_SCENE_LOAD_FINISH, self.on_scene_load_finish, self)
end

function M:on_create_battle_team(data)
  self:set_battle_team_info(data)
end

function M:set_battle_team_info(data)
  if data then
    self:set_recreate_hero(self.v_battle_team_info ~= nil)
    self:set_create_hero(true)
    self:set_hero_preload_res_done(nil)
    self.v_battle_team_info = data
  else
    self:set_recreate_hero()
    self:set_create_hero()
    self:set_hero_preload_res_done()
    self.v_battle_team_info = nil
  end
end

function M:get_battle_team_info()
  return self.v_battle_team_info
end

function M:get_role_fashion_id_by_battle_info(role_id)
  local fashion_id
  return fashion_id
end

function M:need_check_create_hero()
  return self.v_need_check_create_hero
end

function M:set_create_hero(is_need)
  self.v_need_check_create_hero = is_need
end

function M:check_recreate_hero()
  return self.v_need_recreate_hero
end

function M:set_recreate_hero(is_need)
  self.v_need_recreate_hero = is_need
end

function M:check_hero_preload_res_done()
  return self.v_check_hero_preload_res_done
end

function M:set_hero_preload_res_done(is_done)
  self.v_check_hero_preload_res_done = is_done
end

function M:on_gm_enter_tower(tower_id)
  local tower_floor_id = DebugSetting:get_tower_floor_id()
  local tower_room_id = DebugSetting:get_tower_room_id()
  if tower_floor_id and tower_floor_id > 0 then
    local uid = PlayerMgr:get_player_uid()
    local args_map = {}
    args_map.tower_id = tower_id
    args_map.room_id = tower_room_id
    args_map.target_floor = tower_floor_id
    args_map.uuid = uid
    local request = {
      instruct = "direct_to_target_room",
      args_map = Seri.packstring(args_map)
    }
    Network:call("c2gs_execute_instruct", request, function(ok, resp)
      if ok then
        self:req_gm_enter_tower(tower_id)
      end
    end)
  else
    self:req_gm_enter_tower(tower_id)
  end
end

function M:req_gm_enter_tower(tower_id)
  local role_list = DebugSetting:get_role_list()
  local fixed_buddy_list = DebugSetting:get_fixed_buddy_list()
  local challenge_type = DebugSetting:get_challenge_type()
  local is_open_skill = DebugSetting:is_open_skill()
  local temp = {}
  local temp_fixed = {}
  for i = 1, 3 do
    table.insert(temp, fixed_buddy_list[i] or role_list[i])
    table.insert(temp_fixed, fixed_buddy_list[i])
  end
  Network:call("c2gs_gm_enter_tower", {
    tower_id = tower_id,
    buddy_id = temp,
    unlock_normal_skill = is_open_skill,
    fixend_buddy = temp_fixed,
    challenge_type = challenge_type
  }, function(ok, resp)
    if ok then
      self:on_enter_tower(resp.tower_id)
    end
  end)
end

function M:on_enter_tower(tower_id, tower_type, is_need_reload_same_scene)
  if self.v_tower then
    return
  end
  
  local function cb(ok, resp)
    if ok then
      print("on_enter_tower ret ")
      local tower_info = resp.tower_info
      local tower_class
      if tower_type then
        tower_class = TOWER_CLASS[tower_type]
      else
        tower_class = TOWER_CLASS[TOWER_TYPE.DEFAULT]
      end
      local floor_list = tower_info.floor_list
      self:unpack_room_seri(floor_list)
      self.v_tower = tower_class:new(tower_id, resp.tower_info)
      if is_need_reload_same_scene then
        self.v_tower:set_is_need_reload_scene(true)
      end
      self.v_tower:on_enter(is_first)
      self.v_exist = false
      self.v_existing = false
      self.v_tower.v_is_first_enter_floor = true
    end
  end
  
  self:req_tower_info(tower_id, cb)
  return self.v_tower
end

function M:on_new_enter_tower(type, point_id, param, tower_type, fight_team, node_id, is_need_reload_same_scene, args)
  self:check_track(type, node_id)
  if self.v_is_send_challenge_episode then
    return
  end
  self.v_is_send_challenge_episode = true
  if type == CommonDefine.CHALLENGE_TYPE.LONG_CHAPTER then
    if node_id and node_id > 0 then
      self:record_is_first_enter_node(true)
      self:record_cur_node_id(node_id)
    end
  else
    node_id = nil
  end
  local body = {
    type = type,
    point_id = point_id,
    param = param,
    node_id = node_id,
    fight_team = fight_team,
    args = args
  }
  if type == CommonDefine.CHALLENGE_TYPE.NEW_MATERIAL then
    body.challenge_multiple = ChapterMaterialMgr:get_curr_multiple_num()
    body.ingore_multiple = ChapterMaterialMgr:get_ingore_multiple_num()
    local cfg = ShareRes.create("chapter.new_material_epi", param)
    local select_drop_id = cfg.SelectDropID
    if select_drop_id then
      local index = ChapterMaterialMgr:get_cur_drop_select_index()
      local select_drop_cfg = ShareRes.create("chapter.chapter_material_select_drop_id", cfg.SelectDropID)
      body.param = select_drop_cfg.DropID[index]
    else
      body.param = cfg.DropID
    end
  elseif type == CommonDefine.CHALLENGE_TYPE.CURSE_CIRCLE then
    local ring_id = ShareRes.get_ring_id_by_point_id(point_id)
    local ring_cfg = ShareRes.get_curse_ring_config(ring_id)
    if ring_cfg and not ring_cfg.FastChallengeId then
      body.challenge_multiple = FateBookMgr:get_quick_fight_challenge_multiple()
    end
  elseif type == CommonDefine.CHALLENGE_TYPE.VERSION_EPISODE then
    body.challenge_multiple = TimeLimitedActMgr:get_fight_challenge_multiple()
  end
  Network:protect_call("c2gs_challenge_episode", body, function(ok, resp)
    self.v_is_send_challenge_episode = false
    if ok then
      if type == CommonDefine.CHALLENGE_TYPE.NEW_MATERIAL then
        ChapterMaterialMgr:set_curr_multiple_num(1)
      end
      self:update_fight_info(true, type, point_id, param, node_id)
      self:set_temp_params(type, point_id, param, tower_type, fight_team, node_id, args)
      self:on_enter_tower(resp.tower_id, tower_type, is_need_reload_same_scene)
    end
  end, nil, true)
end

function M:check_track(type, node_id)
  if type == CommonDefine.CHALLENGE_TYPE.LONG_CHAPTER then
    local node_cfg = ShareRes.get_chapter_node_cfg(node_id)
    if not node_cfg then
      return
    end
    if node_cfg.TagNumName == "1-1" then
      SDKManager:track_adjust_event("20_1-1_Start")
    elseif node_cfg.TagNumName == "1-2" then
      SDKManager:track_adjust_event("23_1-2_Start")
    elseif node_cfg.TagNumName == "1-3" then
      SDKManager:track_adjust_event("27_1-3_Start")
    elseif node_cfg.TagNumName == "1-4" then
      SDKManager:track_adjust_event("30_1-4_start")
    end
  end
end

function M:before_restart_tower()
  SceneMgr:clear_scene_data(true)
end

function M:restart_tower(epi_id, param, is_need_refresh_red, node_id, not_clear_assist, is_continue)
  Global.sound_mgr:scene_switch_stop_sound()
  if not Util.is_more_than_zero(epi_id) then
    epi_id = self.temp_point_id
  end
  if not Util.is_more_than_zero(param) then
    param = self.temp_param
  end
  if not Util.is_more_than_zero(node_id) then
    node_id = self.temp_node_id
  end
  local args = self.temp_args
  local has_process
  if not self.temp_fight_team then
    self.temp_fight_team = FormationMgr:get_fight_team_send_data(nil, epi_id, not not_clear_assist)
    has_process = true
  elseif epi_id ~= self.temp_point_id then
    has_process = self:refresh_team_with_next_epi(epi_id, not not_clear_assist)
  end
  if not has_process and not not_clear_assist then
    local team_id = self.temp_fight_team.id
    self.temp_fight_team = FormationMgr:get_fight_team_send_data(team_id, epi_id, true)
  end
  self:before_restart_tower()
  BehaviorMgr:clear_all(true)
  if is_continue then
    local point_cfg = ShareRes.get_chapter_point_cfg(epi_id)
    local tower_id = point_cfg.FightId
    self:continue_challenge_tower(self.temp_type, epi_id, param, tower_id, node_id, true)
    return
  end
  self:on_new_enter_tower(self.temp_type, epi_id, param, self.temp_tower_type, self.temp_fight_team, node_id, true, args)
  if is_need_refresh_red then
    self:refresh_epi_red(self.temp_type, epi_id)
  end
end

function M:refresh_team_with_next_epi(epi_id, clear_assist)
  local epi_cfg = ShareRes.get_chapter_point_cfg(epi_id)
  if not epi_cfg then
    return false
  end
  local fixed_formation = epi_cfg.FixedFromation
  if not fixed_formation or 0 == #fixed_formation then
    return false
  end
  local pos_data = FormationMgr:get_correct_fight_team(epi_id)
  if not pos_data then
    return false
  end
  self.temp_fight_team = FormationMgr:get_fight_team_send_data(nil, epi_id, clear_assist)
  local buddys = {}
  for i, buddy_info in pairs(pos_data) do
    if 0 == buddy_info.buddy_id then
    else
      local data = {}
      data.pos = buddy_info.pos
      data.buddy_type = buddy_info.buddy_type
      data.buddy_id = buddy_info.buddy_id
      table.insert(buddys, data)
    end
  end
  self.temp_fight_team.buddys = buddys
  return true
end

function M:refresh_epi_red(epi_type, epi_id)
  if epi_type == CommonDefine.CHALLENGE_TYPE.LINEAR and LinearMgr then
    LinearMgr:request_remove_tips_with_epi_id(epi_id)
  end
end

function M:set_temp_params(type, point_id, param, tower_type, fight_team, node_id, args)
  self.temp_type = type
  self.temp_point_id = point_id
  self.temp_param = param
  self.temp_tower_type = tower_type
  self.temp_fight_team = fight_team
  self.temp_args = args
  if self.temp_type == CommonDefine.CHALLENGE_TYPE.LONG_CHAPTER then
    self.temp_node_id = node_id
  end
end

function M:reset_temp_params()
  self.temp_type = nil
  self.temp_point_id = nil
  self.temp_param = nil
  self.temp_tower_type = nil
  self.temp_fight_team = nil
  self.temp_node_id = nil
  self.temp_args = nil
end

function M:continue_challenge_tower(type, point_id, param, tower_id, node_id, is_need_reload_same_scene)
  local tower_type = TOWER_TYPE.DEFAULT
  if self:is_challenge_ring_tower(tower_id) then
    tower_type = TOWER_TYPE.CHALLENGE_RING
  elseif type == CommonDefine.CHALLENGE_TYPE.CURSE_CIRCLE then
    tower_type = TOWER_TYPE.CURSE_RING
  elseif type == CommonDefine.CHALLENGE_TYPE.CUT_GRASS then
    tower_type = TOWER_TYPE.CUT_GRASS
  elseif NOT_PROGRESS_BATTLE_TYPE[self.v_tower_progress.challenge_type] and self.v_tower_progress.tower_pass then
    UIMgr:get_ui("not_progress_battle_suc_settle"):ui_show()
    return
  end
  Network:call("c2gs_continue_challenge_tower", {tower_id = tower_id}, function(ok, resp)
    if ok then
      self:set_temp_params(type, point_id, param, tower_type, nil, node_id)
      self:on_enter_tower(resp.tower_id, tower_type, is_need_reload_same_scene)
      self:update_fight_info(false, type, point_id, param, node_id)
      self.is_continue_tower = true
    end
  end)
end

function M:on_tower_history_floor(data)
  self.v_tower_history_floor_map = self.v_tower_history_floor_map or {}
  local map = data.history_max_floor
  for _, info in pairs(map) do
    self.v_tower_history_floor_map[info.tower_id] = info.max_floor
  end
end

function M:get_tower_history_floor_num(tower_id)
  if not self.v_tower_history_floor_map then
    return 0
  end
  return self.v_tower_history_floor_map[tower_id] or 0
end

function M:on_battle_room_data(data)
  local is_restore = data.is_restore_hp
  local room_type = Config.ROOM_TYPE.REST
  self.v_tower:update_room_status(room_type, is_restore)
  MsgGame:mq_publish2(Const.MSG_ON_UPDATE_RESTORE_HP_OBJ)
  self.v_cur_room_use_tp_data = data.used_tp or {}
end

function M:check_tp_use_by_idx(idx)
  if not self.v_cur_room_use_tp_data then
    return
  end
  for _, val in pairs(self.v_cur_room_use_tp_data) do
    if val == idx then
      return true
    end
  end
  return false
end

function M:check_continue_tower()
  return self.is_continue_tower
end

function M:after_add_component()
end

function M:get_fight_info()
  return self.v_tower_fight_info
end

function M:get_fight_type()
  if not self.v_tower_fight_info then
    return
  end
  return self.v_tower_fight_info.type
end

function M:get_trace_mission_type()
  local fight_type = self:get_fight_type()
  local progress_type = self.v_tower_progress.challenge_type
  local tower_type = 0 ~= fight_type and fight_type or progress_type
  if not tower_type then
    return
  end
  local mission_type
  if tower_type == CommonDefine.CHALLENGE_TYPE.CHAPTER or tower_type == CommonDefine.CHALLENGE_TYPE.LONG_CHAPTER then
    mission_type = 1
  elseif tower_type == CommonDefine.CHALLENGE_TYPE.NEW_MATERIAL then
    mission_type = 2
  elseif tower_type == CommonDefine.CHALLENGE_TYPE.BUDDY_TEACH then
    mission_type = 3
  elseif tower_type == CommonDefine.CHALLENGE_TYPE.INFINITE then
    mission_type = 4
  elseif tower_type == CommonDefine.CHALLENGE_TYPE.CURSE_CIRCLE then
    mission_type = 5
  elseif tower_type == CommonDefine.CHALLENGE_TYPE.WEEK_ACTY_PERPARE_EPI then
    mission_type = 6
  elseif tower_type == CommonDefine.CHALLENGE_TYPE.NEWBIE_TOWER then
    mission_type = 7
  end
  return mission_type
end

function M:get_cur_point_id()
  if not self.v_tower_fight_info then
    return
  end
  return self.v_tower_fight_info.point_id
end

function M:get_cur_fight_info_param()
  if not self.v_tower_fight_info then
    return
  end
  return self.v_tower_fight_info.param
end

function M:cache_fight_camera_info(focal_id)
  self.v_cache_camera_focal_id = focal_id
end

function M:get_cache_fight_camera_info()
  return self.v_cache_camera_focal_id
end

function M:clear_cache_fight_camera_info()
  self.v_cache_camera_focal_id = nil
end

function M:update_tower_info(data)
  if not self.v_tower then
    return
  end
  local tower_info = data.tower_info
  local floor_list = tower_info.floor_list
  self:unpack_room_seri(floor_list)
  self.v_tower:update_tower_info(tower_info)
end

function M:update_room_info(data)
  if not self.v_tower then
    return
  end
  self.v_tower:update_room_info(data)
end

function M:clear_tower_data_on_exit()
  if self.v_tower then
    self.v_tower:on_exit()
    self.v_tower = nil
  end
  self.v_existing = true
  self:reset_node_result_list()
  self:_clear_tower()
end

function M:on_exit_tower(callback)
  if not self.v_tower then
    if callback then
      callback()
    end
    return
  end
  self:clear_tower_data_on_exit()
  Network:call("c2gs_quit_scene", {}, function(ok, resp)
    if callback then
      callback()
    end
    self:exit_tower_end()
  end)
  Network:lock_fs_call(true)
end

function M:reset_fog()
  if not SceneMgr then
    return
  end
  local scene_logic = SceneMgr:get_scene_logic()
  if scene_logic then
    scene_logic:reset_fog_params(true)
  end
end

function M:exit_tower_end()
  self.v_exist = true
  self.v_existing = false
  self.v_is_init = false
  BuffMgr:clear()
  Network:quit_fs()
end

function M:_clear_tower()
  self:exit_story_room()
  self:reset_fog()
  Global.need_clear_hero_list = true
  SceneMgr:clear_god_npc()
  SceneMgr:release_sound_state()
  BattleTaskMgr:clear_all_tasks()
  self:clear_cache_fight_camera_info()
  self.is_continue_tower = nil
  Global.sound_mgr:sound_abort(true)
  if self.v_tower_fight_info then
    self.v_last_enter_point_id = self.v_tower_fight_info.point_id
    self.v_last_enter_node_id = self.v_tower_fight_info.node_id
  end
  self.v_tower_fight_info = nil
  self.v_tower_story_record = {}
  if StoryMgr then
    StoryMgr:clear_cache_data()
  end
  self.v_is_enbale_god_skill = false
  self.v_scene_skill_data = nil
  self.v_cur_room_use_tp_data = nil
end

function M:get_tower()
  return self.v_tower
end

function M:get_tower_status(tower_id)
  return self.v_tower_map[tower_id]
end

function M:msg_update_tower_info(tower_info)
  if self.v_tower then
    self.v_tower:update_tower_info(tower_info)
  end
end

function M:update_fight_info(is_first_enter, challenge_type, episode_id, param, node_id)
  if is_first_enter then
    self.v_last_enter_point_id = nil
    self.v_last_enter_node_id = nil
  end
  self.v_tower_fight_info = {
    type = challenge_type,
    point_id = episode_id,
    param = param,
    node_id = node_id
  }
end

function M:update_tower_progress(data)
  self.v_tower_progress = data
  self.v_is_can_transmit = data.mapview_transmit
  self:update_fight_info(false, data.challenge_type, data.episode_id, data.param, data.node_id)
  self:update_tower_task()
  if data.week_acty_fraction then
    WeeklyMgr:set_weekly_score_info(data.week_acty_fraction)
  end
  MsgGame:mq_publish2(Const.MSG_ON_SYNC_FIGHT_PROGRESS)
  self.v_is_init = true
end

function M:check_init_ok()
  return self.v_is_init
end

function M:get_tower_progress()
  return self.v_tower_progress
end

function M:gm_set_enter_tower_character(character_id)
  self.v_gm_character_id = character_id
end

function M:get_gm_enter_tower_character()
  return self.v_gm_character_id
end

function M:get_flag_reward_list()
  return self.flag_reward_list
end

function M:destroy_flag_reward_list()
  self.flag_reward_list = nil
end

function M:get_fight_reward(callback, is_again_challenge, minesweeper_is_settlement)
  local function cb()
    if not self.v_tower then
      return
    end
    if self.v_tower then
      self.v_tower:on_exit()
      self.v_tower = nil
    end
    self:_clear_tower()
    if callback then
      callback()
    end
    self.v_exist = true
    self.v_existing = false
    Network:quit_fs()
  end
  
  self.v_existing = true
  ScreenMaskMgr:open_one_tag("c2gs_slated_settlement", math.huge)
  
  local function settle_func()
    Network:call("c2gs_tower_settlement", {is_again_challenge = is_again_challenge, minesweeper_is_settlement = minesweeper_is_settlement}, function(ok, resp)
      ScreenMaskMgr:close_one_tag("c2gs_slated_settlement")
      if ok then
        cb()
      end
    end)
  end
  
  if not SceneMgr:check_main_scene() then
    Network:call("c2gs_slated_settlement", {}, function(is_ok, _resp)
      if is_ok then
        settle_func()
      end
    end)
    Network:lock_fs_call(true)
  else
    settle_func()
  end
end

function M:long_chapter_exit(need_exit_tower, quit_cb, is_player_exit)
  is_player_exit = is_player_exit or false
  self:reset_node_result_list()
  ScreenMaskMgr:open_one_tag("c2gs_slated_settlement", math.huge)
  
  local function settle_func()
    local function cb(ok)
      ScreenMaskMgr:close_one_tag("c2gs_slated_settlement")
      
      if ok then
        if need_exit_tower and self.v_tower then
          self:on_long_chapter_exit_tower(quit_cb)
        elseif quit_cb then
          quit_cb()
        end
      end
    end
    
    if self.v_tower and not SceneMgr:check_main_scene() then
      Network:call("c2gs_chapter_quit", {is_player_exit = is_player_exit}, function(ok, resp)
        cb(ok)
      end)
    else
      cb(true)
    end
  end
  
  if not SceneMgr:check_main_scene() and self.v_tower then
    Network:call("c2gs_slated_settlement", {}, function(is_ok, _resp)
      if is_ok then
        settle_func()
      end
    end)
    Network:lock_fs_call(true)
  else
    settle_func()
  end
end

function M:on_long_chapter_exit_tower(callback)
  if not self.v_tower then
    if callback then
      callback()
    end
    return
  end
  self:clear_tower_data_on_exit()
  if callback then
    callback()
  end
  self:exit_tower_end()
end

function M:get_fight_reward_list()
  local award_list = self.v_tower_progress.award_list
  return award_list
end

function M:check_first_reward()
  local fight_progress = self:get_tower_progress()
  if not fight_progress then
    return
  end
  if not fight_progress.tower_pass then
    return
  end
  local fight_type = fight_progress.challenge_type
  if fight_type ~= CommonDefine.CHALLENGE_TYPE.CHAPTER then
    return
  end
  local point_id = fight_progress.episode_id
  local chapter_id = fight_progress.param
  local first_reward = self:get_first_reward_list(chapter_id, point_id)
  return first_reward
end

function M:get_first_reward_list(chapter_id, point_id)
  local first_fight = ChapterMgr:check_no_first_suc_by_point_id(chapter_id, point_id)
  if first_fight then
    local point_cfg = ShareRes.get_chapter_point_cfg(point_id)
    local first_award_id = point_cfg.AwardId[1]
    local first_award = ShareRes.get_award_item_data(first_award_id)
    return first_award
  end
end

function M:get_tower_floor_info()
  return self.v_tower_progress.floor_id, self.v_tower_progress.room_num
end

function M:get_pass_floor()
  return self.v_tower_progress.pass_floor_id
end

function M:get_fight_reborn_num()
  return self.v_tower_progress.revive_cnt
end

function M:get_reborn_id()
  if not self.v_tower_progress then
    return
  end
  local episode_id = self.v_tower_progress.episode_id
  local cfg = ShareRes.get_chapter_point_cfg(episode_id)
  if cfg then
    return cfg.RebornId
  end
end

function M:get_reborn_attr_ratio_map()
  local attr_id = Config.CHAR_ATTR_TYPE.CHAR_HP
  local attr_ratio_map = {
    [attr_id] = 10000
  }
  local reborn_id = self:get_reborn_id()
  if not reborn_id then
    return attr_ratio_map
  end
  local cfg = ShareRes.get_chapter_reborn_cfg(reborn_id)
  if cfg then
    local reborn_num = math.min(self:get_fight_reborn_num() + 1, #cfg.RebornHpRatio)
    attr_ratio_map[attr_id] = cfg.RebornHpRatio[reborn_num]
  end
  return attr_ratio_map
end

function M:is_show_reborn_btn()
  local tower_info = self:get_tower_progress()
  local fight_info = self:get_fight_info()
  if not fight_info and tower_info then
    fight_info = {
      type = tower_info.challenge_type,
      point_id = tower_info.episode_id,
      param = tower_info.param
    }
  end
  local point_id = fight_info.point_id
  local point_cfg = ShareRes.get_chapter_point_cfg(point_id)
  local reborn_id = point_cfg.RebornId
  local room = self.v_tower:get_room()
  local is_fight_end = room and room:is_fight_end()
  return reborn_id and is_fight_end
end

function M:get_reborn_cost(is_single)
  local tower_info = self:get_tower_progress()
  local fight_info = self:get_fight_info()
  if not fight_info and tower_info then
    fight_info = {
      type = tower_info.challenge_type,
      point_id = tower_info.episode_id,
      param = tower_info.param
    }
  end
  local point_id = fight_info.point_id
  local point_cfg = ShareRes.get_chapter_point_cfg(point_id)
  if not point_cfg then
    return
  end
  local reborn_id = point_cfg.RebornId
  if not reborn_id then
    return
  end
  local reborn_cfg = ShareRes.get_chapter_reborn_cfg(reborn_id)
  local now_reborn_num
  if fight_info.type == CommonDefine.CHALLENGE_TYPE.LONG_CHAPTER then
    now_reborn_num = 0
  else
    now_reborn_num = self:get_fight_reborn_num()
  end
  local reborn_cost_id
  local reborn_cost_num = 0
  if is_single then
    local next_reborn_num = now_reborn_num + 1
    next_reborn_num = _min(next_reborn_num, #reborn_cfg.RebornCostId)
    reborn_cost_num = reborn_cfg.RebornCostNum[next_reborn_num]
    reborn_cost_id = reborn_cfg.RebornCostId[next_reborn_num]
  else
    local end_reborn_num = now_reborn_num + self.v_tower:get_die_hero_num()
    local start_reborn_num = now_reborn_num + 1
    local reborn_length = #reborn_cfg.RebornCostId
    for i = start_reborn_num, end_reborn_num do
      local temp_reborn_num = _min(i, reborn_length)
      reborn_cost_num = reborn_cost_num + reborn_cfg.RebornCostNum[temp_reborn_num]
    end
    start_reborn_num = _min(start_reborn_num, reborn_length)
    reborn_cost_id = reborn_cfg.RebornCostId[start_reborn_num]
  end
  local icon_path
  if reborn_cost_id and 0 ~= reborn_cost_id then
    icon_path = ShareRes.get_item_icon_path(reborn_cost_id)
  end
  return icon_path, reborn_cost_num, reborn_cost_id
end

function M:force_exist_tower()
  if not self.v_tower then
    return
  end
  BehaviorMgr:clear_all(true)
  Log.Info("force_exist_tower!")
  if self.v_tower then
    self.v_tower:on_exit()
    self.v_tower = nil
  end
  self:exit_story_room()
  self:after_force_exit_tower()
end

function M:after_force_exit_tower()
  if SceneMgr then
    SceneMgr:clear_scene_data(true)
    SceneMgr:clear_hero_list()
    SceneMgr:clear_god_npc()
  end
  Global.res_pool_mgr:clear()
  self:clear_cache_fight_camera_info()
  self.is_continue_tower = nil
end

function M:set_fight_skill_btn_data(key_code, charged_type, param_cfg)
  self.v_skill_btn_charging_data[key_code] = {charged_type = charged_type, param_cfg = param_cfg}
end

function M:get_fight_skill_btn_data()
  return self.v_skill_btn_charging_data
end

function M:set_drop_show_list(data)
  self.cur_room_drops = {}
  self.breakable_map = {}
  for _, item in pairs(data.drop_list) do
    local breakable_id = item.breakable_id
    if not breakable_id then
      _insert(self.cur_room_drops, item)
    else
      if not self.breakable_map[breakable_id] then
        self.breakable_map[breakable_id] = {}
      end
      local item_info = {
        id = item.id,
        count = item.count,
        uuid = item.uuid,
        ran_ans_uuid = item.ran_ans_uuid,
        breakable_id = breakable_id
      }
      _insert(self.breakable_map[breakable_id], item_info)
    end
  end
  self.cur_breakable_list = data.breakable_list
  self.breaked_item_map = {}
  for _, breakable_id in pairs(self.cur_breakable_list) do
    self.breaked_item_map[breakable_id] = true
  end
end

function M:on_reconnect()
  self.v_tower_map = {}
  Network:call("c2gs_towerlist", {}, function(ok, resp)
    for k, v in pairs(resp.tower_list) do
      self.v_tower_map[v.tower_id] = v.status
    end
  end)
end

function M:update_scene_skill_data(data)
  local old_data = self.v_scene_skill_data
  local has_change = nil == old_data or old_data.id ~= data.id or old_data.lv ~= data.id
  self.v_scene_skill_data = data
  self:calculation_god_lv_attr()
  local msg = MsgGame:mq_publish2(Const.MSG_CHANGE_SCENE_SKILL)
  msg.mm_x = has_change
end

function M:on_ret_scene_skill(data)
  self:update_scene_skill_data(data)
end

function M:scene_skill_upgrade(upgrade_data)
  self:update_scene_skill_data(upgrade_data)
end

function M:calculation_god_lv_attr()
  local skill_lv = self.v_scene_skill_data.lv
  local skill_id = self.v_scene_skill_data.id
  if skill_lv <= 0 then
    return
  end
  local skill_lv_cfg = ShareRes.get_scene_skill_lv_cfg(skill_id)
  assert(skill_lv_cfg, "ERROR SKILL LV CFG ID = " .. skill_id)
  local fixed_entrys = {}
  for lv = 1, skill_lv do
    local lv_cfg = skill_lv_cfg[lv]
    if lv_cfg and 0 ~= lv_cfg.FixedEntry then
      _insert(fixed_entrys, lv_cfg.FixedEntry)
    end
  end
  local entry_attrs = FightCalc.GetEntryAttrs(fixed_entrys)
  self.v_entry_attrs = entry_attrs
  local god_npc = SceneMgr:get_god_npc()
  if god_npc then
    god_npc:refresh_scene_skill_info()
  end
end

function M:get_scene_skill_data()
  return self.v_scene_skill_data, self.v_entry_attrs
end

function M:check_play_node_story(is_enter, cb, show_curtain)
  if self.v_tower_fight_info.type ~= CommonDefine.CHALLENGE_TYPE.LONG_CHAPTER then
    return
  end
  local node_id = self.v_last_enter_node_id
  if self.v_tower_fight_info then
    node_id = self.v_tower_fight_info.node_id
    if self.v_last_enter_node_id == node_id then
      return
    end
    self.v_last_enter_node_id = node_id
  end
  if not node_id then
    return
  end
  if self.is_continue_tower and is_enter then
    return
  end
  local node_cfg = ShareRes.get_chapter_node_cfg(node_id)
  if not node_cfg then
    return
  end
  local story_id = node_cfg.ChapterNodeStory
  if Util.is_more_than_zero(story_id) then
    return story_id
  end
end

function M:check_play_fight_story(is_enter, cb, show_curtain)
  local point_id = self.v_last_enter_point_id
  if self.v_tower_fight_info then
    point_id = self.v_tower_fight_info.point_id
    if self.v_last_enter_point_id == point_id then
      return
    end
    self.v_last_enter_point_id = point_id
  end
  if not point_id then
    return
  end
  if self.is_continue_tower and is_enter then
    return
  end
  local point_cfg = ShareRes.get_chapter_point_cfg(point_id)
  if not point_cfg then
    return
  end
  local story_id = is_enter and point_cfg.FightStoryId[1] or point_cfg.FightStoryId[2]
  if not story_id or story_id <= 0 then
    return
  end
  local is_repeat_play = 0 ~= point_cfg.RepeatPlay
  if ChapterMgr:check_episode_complete(point_id) and not is_repeat_play then
    return
  end
  local tower = self:get_tower()
  if tower and not tower:check_pass_all_room() and not is_enter then
    return
  end
  if cb then
    StoryMgr:set_story_end_cb(story_id, cb)
  end
  StoryMgr:on_start(story_id)
  if show_curtain then
    SceneMgr:set_curtain_show(true)
  end
  return true
end

function M:on_lost_battle(error_info)
  if not Global.gamemode:gmode_is_game() and not Global.gamemode:gmode_is_loadscene() then
    return
  end
  local tips = error_info and error_info.tips or "网络已断开，请稍后再试"
  UIMgr:clear_ui_stack()
  Util.show_notify_popup_message(function()
    Global.gamemode:gmode_set_mode(Global.const.MODE_CHECK_UPDATE)
  end, tips, "", "确定", nil, nil, true)
end

function M:get_has_exist()
  return self.v_exist
end

function M:will_exit()
  return self.v_exist or self.v_existing
end

function M:is_challenge_ring_tower(tower_id)
  self.v_ring_list_cfg = ShareRes.create("activity.rings_of_challenge_ring_by_tower", tower_id)
  return self.v_ring_list_cfg
end

function M:check_fight_progress()
  local fight_progress = TowerMgr:get_tower_progress()
  if not fight_progress then
    return
  end
  local node_id = fight_progress.node_id
  local point_id = fight_progress.episode_id
  local tower_id = fight_progress.tower_id
  local floor_id = fight_progress.floor_id
  local room_num = fight_progress.room_num
  local param = fight_progress.param
  local tower_pass = fight_progress.tower_pass
  if 0 == point_id and 0 == tower_id then
    return
  end
  
  local function sure_callback()
    if TowerMgr then
      TowerMgr:continue_challenge_tower(fight_progress.challenge_type, point_id, fight_progress.param, tower_id, node_id)
    end
  end
  
  local ring_is_clear = false
  
  local function cancel_callback()
    if fight_progress and fight_progress.challenge_type == CommonDefine.CHALLENGE_TYPE.CHALLENGE_RING then
      UIMgr:get_ui("fight_settlement"):ui_show(CHAPTER_CONFIG.POINTSTATE.quit)
    elseif fight_progress and fight_progress.challenge_type == CommonDefine.CHALLENGE_TYPE.CUT_GRASS then
      self:entry_choose_award_new(true)
      UIMgr:try_hide_ui("gecao_stage_info")
    elseif fight_progress and fight_progress.challenge_type == CommonDefine.CHALLENGE_TYPE.CURSE_CIRCLE then
      local function cb(ok, resp)
        ChallengeRingPlusMgr:update_settlement_info(resp.tower_info)
        
        ChallengeRingPlusMgr:show_sellte_ui()
      end
      
      self:req_tower_info(tower_id, cb)
    elseif NOT_PROGRESS_BATTLE_TYPE[fight_progress.challenge_type] then
      if tower_pass then
        UIMgr:get_ui("not_progress_battle_suc_settle"):ui_show()
      else
        UIMgr:get_ui("not_progress_battle_def_settle"):ui_show()
      end
    elseif fight_progress and fight_progress.challenge_type == CommonDefine.CHALLENGE_TYPE.INFINITE then
      local function cb(ok, resp)
        UIMgr:get_ui("endless_settle"):ui_show(CHAPTER_CONFIG.POINTSTATE.quit)
      end
      
      self:req_tower_info(tower_id, cb)
    else
      UIMgr:get_ui("fight_settlement"):ui_show(CHAPTER_CONFIG.POINTSTATE.quit)
    end
  end
  
  local point_cfg = ShareRes.get_chapter_point_cfg(point_id)
  if not point_cfg then
    return
  end
  floor_id = floor_id <= 0 and 1 or floor_id
  room_num = room_num <= 0 and 1 or room_num
  local content = ""
  local sure_text = "继续"
  local cancel_text = "直接结算"
  if fight_progress.challenge_type == CommonDefine.CHALLENGE_TYPE.CHAPTER then
    content = Util.format_str("正在进行【{1}】【第{2}章】【第{3}关】, 期间无法进入其他关卡。是否继续上次的挑战？", CHALLENGE_TYPE[CommonDefine.CHALLENGE_TYPE.CHAPTER], ChapterMgr:get_chapter_num_by_episode(point_id), room_num)
  elseif fight_progress.challenge_type == CommonDefine.CHALLENGE_TYPE.INFINITE then
    local point_cfg = ShareRes.get_chapter_point_cfg(fight_progress.episode_id)
    content = Util.format_str("正在进行【{1}-{2}】, 期间无法进入其他关卡。是否继续上次的挑战？", CHALLENGE_TYPE[CommonDefine.CHALLENGE_TYPE.INFINITE], point_cfg.PointName)
  elseif fight_progress.challenge_type == CommonDefine.CHALLENGE_TYPE.CURSE_CIRCLE then
    local ring_id = ShareRes.get_ring_id_by_point_id(point_id)
    local ring_cfg = ShareRes.get_curse_ring_config(ring_id)
    if ring_cfg.IsQuickFight then
      return
    end
    content = Util.format_str("正在进行【{1}】【{2}】【第{3}环】, 期间无法进入其他关卡。是否继续上次的挑战？", CHALLENGE_TYPE[CommonDefine.CHALLENGE_TYPE.CURSE_CIRCLE], point_cfg.PointName, floor_id)
  elseif fight_progress.challenge_type == CommonDefine.CHALLENGE_TYPE.CUT_GRASS then
    content = Util.format_str("正在进行【{1}】【{2}】【第{3}层】, 期间无法进入其他关卡。是否继续上次的挑战？", CHALLENGE_TYPE[CommonDefine.CHALLENGE_TYPE.CUT_GRASS], ChapterMgr:get_cut_grass_epi_name_by_id(param), floor_id)
  elseif fight_progress.challenge_type == CommonDefine.CHALLENGE_TYPE.LONG_CHAPTER then
    content = Util.format_str("正在进行【{1}】【第{2}章】【节点{3}】, 期间无法进入其他关卡。是否继续上次的挑战？", CHALLENGE_TYPE[CommonDefine.CHALLENGE_TYPE.LONG_CHAPTER], ChapterMgr:get_chapter_num_by_episode(point_id), ShareRes.get_chapter_node_tag_num(node_id))
  end
  UIMgr:get_ui("uinotice_tips"):ui_show(sure_callback, cancel_callback, content, Util.format_str(sure_text), Util.format_str(cancel_text), nil, nil, nil, true, nil, nil, true)
  return true
end

function M:check_cur_point_play_timeline()
  if not DebugSetting:is_enter_chapter() then
    return
  end
  local tower = self:get_tower()
  if not tower then
    return
  end
  local room = tower:get_room()
  if not room then
    return
  end
  if room:is_fight_end() then
    return
  end
  local fight_progress = self:get_tower_progress()
  if not fight_progress then
    return
  end
  local point_id = fight_progress.episode_id
  local point_cfg = ShareRes.get_chapter_point_cfg(point_id)
  Util.assert(point_cfg, "找不到关卡配置 ", point_id)
  return point_cfg.IsPlayTimeline
end

function M:play_retreat_sound(buddy_id)
  if Global.state_sound_mgr then
    Global.state_sound_mgr:trigger_fight_state_by_id(Config.FIGHT_STATE.TOWER_FAIL, buddy_id)
  end
end

function M:unpack_room_seri(floor_list)
  if not floor_list then
    return
  end
  for _, floor in pairs(floor_list) do
    local room_tbl = floor.room_tbl
    for _, room_data in pairs(room_tbl) do
      local custom_info = room_data.pack_custom_info
      if custom_info then
        room_data.pack_custom_info = Seri.unpack(custom_info)
      end
      local special_status = room_data.pack_special_status
      if special_status then
        room_data.pack_special_status = Seri.unpack(special_status)
      end
    end
  end
  Log.Info("unpack_room_seri:", floor_list)
end

function M:open_fight_bag_panel()
  local tower = self:get_tower()
  local fight_info = self:get_fight_info()
  if tower and tower:is_challenge_ring_tower() then
    UIMgr:get_ui("ui_challenge_ring"):ui_show(true, true)
  elseif fight_info and fight_info.type == CommonDefine.CHALLENGE_TYPE.BUDDY_TEACH then
    UIMgr:get_ui("skill_teach_pause_main"):ui_show(fight_info.point_id)
  elseif fight_info and fight_info.type == CommonDefine.CHALLENGE_TYPE.CURSE_CIRCLE then
    UIMgr:get_ui("challenge_ring_plus"):ui_show()
  elseif fight_info and fight_info.type == CommonDefine.CHALLENGE_TYPE.CUT_GRASS then
    UIMgr:get_ui("gecao_pause"):ui_show()
  elseif not tower:can_archieve() then
    local ui = UIMgr:get_ui("fight_pause_common")
    ui:set_skip_sort_order(nil ~= fight_info)
    ui:ui_show()
    TowerMgr.v_is_cut_pnl = false
  end
end

function M:on_ret_tower_story_record(data)
  self.v_tower_story_record = {}
  for _, info in pairs(data.story_list) do
    self.v_tower_story_record[info.room_id] = info.story_id
  end
end

function M:add_story_record(room_id, story_id)
  Network:call("c2gs_add_story_record", {story_id = story_id, room_id = room_id}, function(ok, resp)
    if ok then
      self.v_tower_story_record[room_id] = story_id
    end
  end)
end

function M:check_play_story_by_room_id(room_id)
  if not self.v_tower_story_record[room_id] then
    return true
  end
end

function M:enable_god_skill(is_enable, not_show)
  self.v_is_enbale_god_skill = is_enable
  if not_show then
    return
  end
  local fight_obj = UIMgr:try_get_visible_ui("fight")
  if fight_obj then
    fight_obj:update_tower_skill(true)
  end
end

function M:check_enable_god_skill()
  return self.v_is_enbale_god_skill
end

function M:on_tower_mark_statuses(data)
  local skip_finish_anim = data.skip_finish_anim
  if not self.v_tower then
    return
  end
  self.v_tower:play_fight_end_anim_state(not skip_finish_anim)
end

function M:get_cur_room()
  local tower = self:get_tower()
  if not tower then
    return
  end
  local room = tower:get_room()
  return room
end

function M:get_cur_room_id()
  local room = self:get_cur_room()
  if not room then
    return
  end
  return room:get_room_id()
end

function M:get_cache_data_before_exit()
  local new_tower_progress = UtilTable.copy_table(self:get_tower_progress())
  local fight_info = self:get_fight_info()
  local new_fight_info
  if fight_info then
    new_fight_info = UtilTable.copy_table(fight_info)
  end
  if not new_fight_info and new_tower_progress then
    new_fight_info = {
      type = new_tower_progress.challenge_type,
      point_id = new_tower_progress.episode_id,
      param = new_tower_progress.param
    }
  end
  return {fight_info = new_fight_info, tower_progress = new_tower_progress}
end

function M:show_choose_award_view(is_fight, is_end_ring, choose_reward_list, new_tower_progress, new_fight_info)
  UIMgr:try_hide_ui("curse_ring_settlement")
  UIMgr:get_ui("challenge_ring_floor_settle"):ui_show(is_fight, is_end_ring, choose_reward_list, new_tower_progress, new_fight_info)
end

function M:request_entry_choose_award(callback)
  Network:call("c2gs_entry_choose_reward_state", {}, function(ok, resp)
    if ok then
      if self.v_tower_progress then
        self.v_tower_progress.is_choose_status = true
        self.v_tower_progress.choose_reward = resp.choose_reward_list
      end
      
      local function cb()
        if callback then
          callback(resp.choose_reward_list)
        end
      end
      
      if self.v_tower then
        self:on_exit_tower(cb)
      else
        cb()
      end
    end
  end)
end

function M:entry_choose_award_new(is_fight)
  SceneMgr:set_game_pause(true)
  local cache_data = self:get_cache_data_before_exit()
  local tower_progress = cache_data.tower_progress
  local fight_info = cache_data.fight_info
  
  local function cb(choose_reward_list)
    self:show_choose_award_view(is_fight, false, choose_reward_list, tower_progress, fight_info)
  end
  
  if not self.v_tower_progress or self.v_tower_progress.is_choose_status then
    cb(self.v_tower_progress.choose_reward)
  else
    self:request_entry_choose_award(cb)
  end
end

function M:choose_reward(data_list, choose_type, cb)
  if self.v_wait_choose_rewar then
    Util.show_message_tip(2045)
    return
  end
  self.wait_choose_reward = true
  Network:call("c2gs_choose_reward", {choose_list = data_list, choose_type = choose_type}, function(ok, resp)
    if ok then
      cb(resp)
      self.v_wait_choose_rewar = false
    end
  end)
end

function M:can_archieve()
  if self.v_tower then
    return self.v_tower:can_archieve()
  end
  return false
end

function M:record_die_role(uuid, death_type)
  if self.v_tower then
    self.v_tower:record_die_role(uuid, death_type)
  end
end

function M:check_hero_is_all_die()
  if self.v_tower then
    return self.v_tower:check_hero_is_all_die()
  end
end

function M:on_role_die_anima_end()
  if self.v_tower then
    return self.v_tower:on_role_die_anima_end()
  end
end

function M:add_hurt_record_val(target, attacker, hurt_val)
  local cur_room = self:get_cur_room()
  if not cur_room then
    return
  end
  local target_kind = target:get_role_kind()
  local attack_kind = attacker:get_role_kind()
  if target:is_hero() then
    cur_room:set_battle_data(nil, nil, hurt_val)
    if attack_kind == NPC_KIND.TRAP then
      cur_room:set_battle_data(nil, nil, nil, hurt_val)
    end
  elseif target:is_npc() then
    cur_room:set_battle_data(hurt_val)
  end
end

function M:add_dodge_num()
  local cur_room = self:get_cur_room()
  if not cur_room then
    return
  end
  cur_room:set_battle_data(nil, 1)
end

function M:trace_pick_item(item_id)
  if not self.v_tower then
    return
  end
  local tower_uuid = self.v_tower:get_tower_uuid()
  if not tower_uuid then
    return
  end
  local cur_room = self:get_cur_room()
  if not cur_room then
    return
  end
  local room_id = cur_room:get_room_id()
  local trace_data = {
    unique_id = tower_uuid,
    room_id = room_id,
    item_id = item_id
  }
  SDKTrack:trace_pick_item(trace_data)
end

local function get_str_key(id)
  return "key" .. id
end

function M:init_teaching_trace_data(point_id, teach_id)
  if not point_id then
    return
  end
  if not self.v_teaching_fail_data[point_id] then
    self.v_teaching_fail_data[point_id] = {}
  end
  local data = self.v_teaching_fail_data[point_id]
  local key = get_str_key(teach_id)
  if not data[key] then
    data[key] = {
      teaching_id = teach_id,
      failures = 0,
      is_true = 0
    }
  end
end

function M:add_teaching_fail_num(teach_id)
  local point_id = self:get_cur_point_id()
  self:init_teaching_trace_data(point_id, teach_id)
  local all_data = self.v_teaching_fail_data[point_id]
  if not all_data then
    return
  end
  local key = get_str_key(teach_id)
  local data = all_data[key]
  if not data then
    return
  end
  data.failures = data.failures + 1
end

function M:add_teaching_suc_state(teach_id)
  local point_id = self:get_cur_point_id()
  self:init_teaching_trace_data(point_id, teach_id)
  local all_data = self.v_teaching_fail_data[point_id]
  if not all_data then
    return
  end
  local key = get_str_key(teach_id)
  local data = all_data[key]
  if not data then
    return
  end
  data.is_true = 1
end

function M:get_teaching_trace_data(point_id)
  return self.v_teaching_fail_data[point_id]
end

function M:reset_teaching_trace_data()
  self.v_teaching_fail_data = {}
end

function M:req_tower_info(tower_id, cb)
  Network:call("c2gs_towerinfo", {tower_id = tower_id}, function(ok, resp)
    if ok and cb then
      cb(ok, resp)
    end
  end)
end

function M:send_node_save_req(node_id, cb)
  Network:call("c2gs_chapter_node_save", {node_id = node_id}, function(ok, resp)
    if cb then
      cb(ok, resp)
    end
  end)
end

function M:req_chapter_node_save(node_id, cb)
  local function req_cb(ok, resp)
    if ok then
      self:after_save_node(node_id, resp.result_list)
      
      if cb then
        cb(ok, resp)
      end
    end
  end
  
  self:send_node_save_req(node_id, req_cb)
end

function M:req_chapter_node_save_by_branch_task(node_id, cb)
  if node_id then
    self:send_node_save_req(node_id, cb)
  end
end

function M:enter_room(room_id, index)
  local tp_index = index or 0
  local tower = self:get_tower()
  if not tower then
    return
  end
  local room = tower:get_room()
  if not room then
    return
  end
  if not room:is_fight_end() then
    Util.show_message_tip(2098)
    return
  end
  tower:enter_room(room_id, tp_index, nil, true, function(is_success)
    if is_success then
      Util.show_message_tip(2329)
    else
      Util.show_message_tip(2330)
    end
  end)
end

function M:record_cur_node_id(node_id)
  self.v_cur_node_id = node_id
end

function M:get_record_node_id()
  return self.v_cur_node_id
end

function M:reset_record_node_id()
  self.v_cur_node_id = nil
end

function M:get_cur_node_id()
  if not self.v_tower_fight_info then
    return
  end
  return self.v_tower_fight_info.node_id
end

function M:get_node_result_list()
  return self.v_node_result_list
end

function M:record_node_result_list(result_list)
  self.v_node_result_list = result_list
end

function M:reset_node_result_list()
  self.v_node_result_list = nil
end

function M:after_save_node(node_id, result_list)
  local node_cfg = ShareRes.get_chapter_node_cfg(node_id)
  if node_cfg.NodeType == CommonDefine.CHAPTER_NODE_TYPE.MAIN_LINE then
    self:change_to_next_node_id(result_list, node_cfg)
  end
end

function M:change_to_next_node_id(result_list, node_cfg)
  if (not node_cfg.BehindNodeId or node_cfg.BehindNodeId <= 0) and ChapterMgr:check_node_is_first_save_suc(node_cfg.Id) then
    local not_progress_battle_suc_settle = UIMgr:get_ui("not_progress_battle_suc_settle")
    if not_progress_battle_suc_settle:visible() then
      not_progress_battle_suc_settle:refresh_view(false, result_list, node_cfg)
    else
      not_progress_battle_suc_settle:ui_show(false, result_list, node_cfg)
    end
  else
  end
end

function M:record_is_first_enter_node(is_first)
  self.is_first_enter_node = is_first
end

function M:get_is_first_enter_node()
  return self.is_first_enter_node
end

function M:update_maze_data(data)
  if not self.v_tower or not data then
    return
  end
  self.v_tower:update_maze_data(data)
end

function M:record_long_chapter_award(award_list)
  for key, award_data in pairs(award_list) do
    if not self.v_long_chapter_award[key] then
      self.v_long_chapter_award[key] = award_data
    else
      self.v_long_chapter_award[key].count = self.v_long_chapter_award[key].count + award_data.count
    end
  end
end

function M:show_long_chapter_award(force_show)
  if not self.v_long_chapter_award or next(self.v_long_chapter_award) == nil then
    return
  end
  local ui_name = "award_show_panel"
  if force_show then
    UIMgr:get_ui(ui_name):ui_show(self.v_long_chapter_award)
  else
    UIMgr:add_ui_queue(Config.UI_QUEUE_GROUP.Common_Reward, ui_name, self.v_long_chapter_award)
  end
end

function M:clear_long_chapter_award()
  UtilTable.clear_map(self.v_long_chapter_award)
end

function M:tower_settle()
  NewbieTowerMgr:set_newbie_tower_pass()
  local chapter_id = ShareRes.get_comm_value("GuideTowerFightId")
  local chapter_cfg = ShareRes.create("chapter.chapter_point", chapter_id)
  
  local function story_end_cb()
    local function cb()
      Global.scene_mgr:on_enter_main_scene()
    end
    
    if TowerMgr then
      TowerMgr:get_fight_reward(cb)
    end
  end
  
  local fight_end_story_id = chapter_cfg.FightStoryId[2]
  if Util.is_more_than_zero(fight_end_story_id) then
    StoryMgr:set_story_end_cb(fight_end_story_id, story_end_cb)
    StoryMgr:on_start(fight_end_story_id, nil, nil, true)
  else
    story_end_cb()
  end
end

function M:is_long_chapter()
  local fight_type = self:get_fight_type()
  return fight_type == CommonDefine.CHALLENGE_TYPE.LONG_CHAPTER
end

function M:on_scene_load_finish(msg)
  self:open_behavior_timer()
end

function M:open_behavior_timer()
  if not Util.is_client_only() and Global.is_open_timer then
    Network:call("c2gs_client_open_behavior_timer", {}, function(ok)
      if ok then
        JournalMgr:oepn_record_jiournal_info(true)
      end
    end)
  end
end

function M:is_need_report_player_blow_cnt()
  local fight_type = self:get_fight_type()
  if not fight_type then
    return false
  end
  if fight_type == CommonDefine.CHALLENGE_TYPE.CUT_GRASS or fight_type == CommonDefine.CHALLENGE_TYPE.NEW_MATERIAL or fight_type == CommonDefine.CHALLENGE_TYPE.LINEAR then
    return true
  end
  return false
end

function M:get_node_after_fight_story_id()
  local progress = self:get_tower_progress()
  if progress then
    local node_id = progress.node_id
    local after_fight_story_id = ShareRes.get_node_after_fight_story_id(node_id)
    return after_fight_story_id
  end
end

function M:buddy_teach_floor_settle(only_settle)
  Network:call("c2gs_buddy_teach_floor_settlement", {}, function(ok, resp)
    if ok then
      local ui_name = "not_progress_battle_suc_settle"
      self:record_node_result_list(resp.award_list)
      local settle_ui = UIMgr:try_get_ui(ui_name)
      if not only_settle then
        settle_ui = settle_ui or UIMgr:get_ui(ui_name)
        if not settle_ui:visible() then
          settle_ui:ui_show(CHAPTER_CONFIG.POINTSTATE.complete, nil, nil, true)
        else
          settle_ui:refresh_view(CHAPTER_CONFIG.POINTSTATE.complete, nil, nil, true)
        end
      elseif settle_ui and settle_ui:has_inited() then
        settle_ui:refresh_award(true)
      end
    end
  end)
end

function M:on_chapter_node_save(data)
  local result_list = data.result_list
  local node_id = data.node_id
  local node_cfg = ShareRes.get_chapter_node_cfg(node_id)
  if not SceneMgr:check_main_scene() then
    ChapterMgr:record_suc_node(node_id)
  end
  local ui_name = "ui_chapter_detail_info"
  
  local function cb()
    local chapter_cfg = ChapterMgr:get_chapter_by_node_id(node_id)
    local ui_chapter_detail_info = UIMgr:get_ui(ui_name)
    local settle_param = {result_list = result_list}
    if ui_chapter_detail_info:visible() then
      ui_chapter_detail_info:refresh_view(chapter_cfg.Id, node_id, Config.AREA_POINT_MODULE_TYPE.CHAPTER_NODE, settle_param)
    else
      ui_chapter_detail_info:ui_show(chapter_cfg.Id, node_id, Config.AREA_POINT_MODULE_TYPE.CHAPTER_NODE, settle_param)
    end
    if GuideMgr then
      GuideMgr:check_sys_guide(ui_chapter_detail_info)
    end
  end
  
  if self.v_tower then
    local room = self.v_tower:get_room()
    room:send_hero_born_pos(true)
  end
  if StoryMgr:is_playing_story() then
    local story_id = StoryMgr:get_cur_play_story_id()
    if node_cfg.NodeType == CommonDefine.CHAPTER_NODE_TYPE.STORY_LINE then
      StoryMgr:set_story_end_cb(node_cfg.Param, cb)
      return
    elseif StoryMgr:is_delay_destroy(story_id) then
      StoryMgr:set_story_end_cb(story_id, cb)
      return
    elseif StoryMgr:check_story_is_settle_story(story_id) then
      if self.v_tower then
        self.v_tower:record_fight_end_node_data(data)
        return
      end
    elseif not StoryMgr:check_cur_stroy_is_full() then
      StoryMgr:set_story_end_cb(story_id, cb)
      return
    end
  end
  if self.v_tower and self.v_tower:get_tower_pass() and self.v_tower:check_need_play_end_anim() then
    self.v_tower:record_node_save_data(data)
  else
    cb()
  end
end

function M:get_stage_info()
  local point_id = self:get_cur_point_id()
  local point_cfg = ShareRes.get_chapter_point_cfg(point_id)
  if point_cfg then
    return point_cfg
  else
    return {}
  end
end

function M:get_tower_use_time(ret_second)
  local gecao_battle = UIMgr:try_get_ui("gecao_battle")
  local use_time
  if gecao_battle then
    use_time = gecao_battle:get_use_time()
  end
  if not use_time then
    return
  end
  if ret_second then
    return use_time
  else
    local res
    local remain_hour = math.floor(use_time / 3600)
    local rest_time = use_time % 3600
    local remain_min = math.floor(rest_time / 60)
    local remain_sec = rest_time % 60
    if remain_hour > 0 then
      res = string.format("%02d:%02d:%02d", remain_hour, remain_min, remain_sec)
    else
      res = string.format("%02d:%02d", remain_min, remain_sec)
    end
    return res
  end
end

function M:get_tower_type()
  local fight_type = self:get_fight_type()
  local progress_type = self.v_tower_progress.challenge_type
  local tower_type = 0 ~= fight_type and fight_type or progress_type
  if not tower_type then
    return
  end
  return tower_type
end

function M:get_cur_tower_floor()
  local cur_tower = self:get_tower()
  if not cur_tower then
    return 1, 1
  end
  return cur_tower:get_floor_num(), cur_tower:get_max_floor()
end

function M:add_end_action_map(uuid, is_max_wave, event_key)
  if self.v_tower then
    self.v_tower:add_end_action_map(uuid, is_max_wave, event_key)
  end
end

function M:remove_end_action_map(uuid, event_key, is_destroy)
  if self.v_tower then
    self.v_tower:remove_end_action_map(uuid, event_key, is_destroy)
  end
end

function M:check_use_assist()
  local progress = self.v_tower_progress
  if not progress then
    return false
  end
  local battle_buddy_data = progress.battle_buddy_data
  for key, buddy_data in pairs(battle_buddy_data) do
    if buddy_data.status == CommonDefine.FORMATION_BUDDY_STATUS.HELP_FIGHT then
      return true
    end
  end
  return false
end

function M:update_tower_task()
  local progress = self.v_tower_progress
  if not progress then
    return
  end
  local tower_task = progress.tower_task
  self.v_tower_task_data_list = {}
  local task_type, data_list
  for key, data in pairs(tower_task) do
    task_type = data.task_type
    if not data.status then
      if not self.v_tower_task_data_list[task_type] then
        FightDataMgr:create_tower_task_data(data)
        self.v_tower_task_data_list[task_type] = {}
      end
      data_list = self.v_tower_task_data_list[task_type]
      data_list[#data_list + 1] = data
    end
  end
end

function M:check_tower_task_update(task_type, cover, ...)
  if not self.v_tower_task_data_list[task_type] then
    return
  end
  FightDataMgr:update_tower_task_data(task_type, cover, ...)
end

function M:is_need_default_fight_timer()
  local fight_info = self:get_fight_info()
  local is_need_open_ge_cao_ui = true
  if fight_info and (fight_info.type == CommonDefine.CHALLENGE_TYPE.WEEK_ACTY_PVP_EPI or fight_info.type == CommonDefine.CHALLENGE_TYPE.WEEK_ACTY_PERPARE_EPI) then
    is_need_open_ge_cao_ui = false
  end
  return is_need_open_ge_cao_ui
end

function M:is_fight_end()
  local room = self:get_cur_room()
  return room and room:is_fight_end()
end

function M:is_on_enter_room()
  local room = self:get_cur_room()
  return room and room:is_on_enter_room()
end

function M:on_destroy()
  self:set_battle_team_info(nil)
  self:force_exist_tower()
  Base.on_destroy(self)
end

function M:is_need_show_re_fight_btn(is_fail)
  local fight_type = self:get_fight_type()
  if not fight_type or not self.v_tower_progress then
    return false
  end
  if fight_type == CommonDefine.CHALLENGE_TYPE.CURSE_CIRCLE then
    return ChallengeRingPlusMgr:is_in_curse_fighting() and not ChallengeRingPlusMgr:is_quick_fight() and not SceneMgr:check_all_hero_hp_zero()
  end
  if fight_type == CommonDefine.CHALLENGE_TYPE.LONG_CHAPTER then
    return not is_fail
  elseif fight_type == CommonDefine.CHALLENGE_TYPE.WEEK_ACTY_PERPARE_EPI or fight_type == CommonDefine.CHALLENGE_TYPE.WEEK_ACTY_PVP_EPI or fight_type == CommonDefine.CHALLENGE_TYPE.NEW_MATERIAL or fight_type == CommonDefine.CHALLENGE_TYPE.INFINITE or fight_type == CommonDefine.CHALLENGE_TYPE.CHAPTER or fight_type == CommonDefine.CHALLENGE_TYPE.BOSS or fight_type == CommonDefine.CHALLENGE_TYPE.LINEAR or fight_type == CommonDefine.CHALLENGE_TYPE.CLIMBING_TOWER or fight_type == CommonDefine.CHALLENGE_TYPE.ACTIVITY_MINESWEEPER or fight_type == CommonDefine.CHALLENGE_TYPE.VERSION_EPISODE or fight_type == CommonDefine.CHALLENGE_TYPE.ACTIVITY_PONDER then
    return true
  end
  return false
end

function M:need_cancle_born_skill()
  local tower = self:get_tower()
  if tower then
    if tower:get_play_born_skill() then
      return self:check_continue_tower()
    else
      return true
    end
  else
    return false
  end
end

function M:enter_story_room(video_id)
  local room_data = {archive_video_id = video_id}
  self.v_story_room = require("gamelogic.tower_mgr.story_room"):new(room_data)
  self.v_story_room:setup(video_id)
end

function M:exit_story_room()
  if self.v_story_room then
    self.v_story_room:release()
    self.v_story_room = nil
    self:reset_fog()
    Global.scene_mgr:on_enter_main_scene()
    UIMgr:revert_cache_ui()
  end
end

function M:get_story_room()
  return self.v_story_room
end

function M:get_tower_gm_info()
  local tower = self:get_tower()
  local tower_id = tower:get_tower_id()
  local floor_num = tower:get_floor_num()
  local room_id = tower:get_cur_room_id()
  Log.Error(tower_id, floor_num, room_id)
end

return M
