local M = Util.create_class()
local UnityFind = _ENV.UnityFind
local UnityDestroy = _ENV.UnityDestroy
local CSResLoader = CS.ResLoader
local CSFollower = CS.Game.MoveFollower
local TypeReversibleTimeLinePlayer = typeof(CS.Game.ReversibleTimeLinePlayer)
local TypeNormalTimeLinePlayer = typeof(CS.Game.NormalTimeLinePlayer)
local TypePlayableDirector = typeof(UnityEngine.Playables.PlayableDirector)
local TypeSceneContainer = typeof(CS.Game.SceneContainer)
local TypeSpeedSceneTimeline = typeof(CS.Game.SpeedSceneTimeline)
local UPDATE_CONTACT_TIME_INTERVAL = 0.1
local REPORT_POS_INTERVAL = 2
local _insert = table.insert
local Math = require("base.mathx")
local Util = require("utils.util")
local CommonDefind = require("cs_share.common_define")
local TP_NEXT_UI_NAME = {
  [CommonDefind.CHALLENGE_TYPE.INFINITE] = "endless_tp_floor",
  other = "fight_pause_common"
}
local TP_POINT_CFG = require("manager.scene.tp_point_cfg")
local FUN_NPC_HELPER = require("gamelogic.functional_npc.functional_npc_helper")
local TP_EFFECT_TYPE = TP_POINT_CFG.TP_EFFECT_TYPE
local CENTER_POS_KEY = "center"
local TP_SERCH_RANGE = ShareRes.get_comm_value("TpSearchRange") or 4
local TP_POSKEY_TO_INDEX = {
  tp1 = 1,
  tp2 = 2,
  tp3 = 3,
  tp4 = 4
}
local IS_REMOVE_NPC_TYPE = {REMOVE = 1, NOT_REMOVE = 0}
local _deg2rad = math.rad(1)
local _sin = math.sin
local _cos = math.cos
local Vec3 = require("base.vec3")
local Quat = require("base.quat")
local RAY_HIT_MAX = 20
local NORMAL_INTERACT_DISTANCE = ShareRes.get_comm_value("NPCInteractRange")
local TREASURE_CHEST_INTERACT_DISTANCE = ShareRes.get_comm_value("TreasureChestInteractRange")
local CHAT_ROLE_NPC_INTERACT_DISTANCE = ShareRes.get_comm_value("NPCBubbleInteractRange")
local FUNCTIONL_NPC_TYPE = {
  [Config.FUNCTIONAL_NPC_SHOW_TYPE.Dialog] = "obj.functional_npc.functional_npc",
  [Config.FUNCTIONAL_NPC_SHOW_TYPE.Treasure] = "obj.functional_npc.treasure_npc",
  [Config.FUNCTIONAL_NPC_SHOW_TYPE.TASK] = "obj.functional_npc.functional_npc",
  [Config.FUNCTIONAL_NPC_SHOW_TYPE.Challenge] = "obj.functional_npc.challenge_npc",
  [Config.FUNCTIONAL_NPC_SHOW_TYPE.NoFightGame] = "obj.functional_npc.no_fight_game_npc",
  [Config.FUNCTIONAL_NPC_SHOW_TYPE.ChallengeRing] = "obj.functional_npc.no_fight_game_npc",
  [Config.FUNCTIONAL_NPC_SHOW_TYPE.Door] = "obj.functional_npc.random_door_npc",
  [Config.FUNCTIONAL_NPC_SHOW_TYPE.InitBox] = "obj.functional_npc.init_box_npc",
  [Config.FUNCTIONAL_NPC_SHOW_TYPE.NormalDrop] = "obj.functional_npc.normal_drop_npc",
  [CommonDefind.FUNCTIONAL_NPC_TYPE.RUNE_SHOP] = "obj.functional_npc.no_fight_game_npc",
  [CommonDefind.FUNCTIONAL_NPC_TYPE.ORNAMENTS_SHOP] = "obj.functional_npc.no_fight_game_npc",
  [CommonDefind.FUNCTIONAL_NPC_TYPE.ABILITY_REBUILD_NPC] = "obj.functional_npc.ability_rebuild_npc"
}
local CommonDefine = require("cs_share.common_define")

function M:_init(room, logic_id)
  if UNITY_EDITOR then
    Log.Info("current use logic_id :", logic_id)
  end
  self.v_room = room
  self.v_logic_id = logic_id
  self.v_tower = room:get_tower()
  self.v_scene_cfg = SceneMgr:get_scene_cfg()
  self.v_map_path = self:get_map_file_path()
  self.v_scene_map = require("manager.scene.scene_map"):new(self.v_map_path, self.v_room.room_cfg.MapInfo, self)
  self.v_enter_area_map = {}
  self.v_start_time = GlobalTimeMgr:get_unscaled_time()
  self.v_create_gameobj_map = {}
  self.v_tp_points = {}
  self.v_tp_name_points = {}
  self.v_tp_invisible_cache = {}
  self.v_tp_root = UnityGameObject("tp_fx_root")
  UnityGameObject.DontDestroyOnLoad(self.v_tp_root)
  self.v_msg_handles = {}
  self.v_func_npc_map = {}
  self.v_treasure_chest_map = {}
  self.v_npc_contact = {}
  self.v_chat_role_npc_contact = {}
  self.v_need_remove_entity_treasure_box = {}
  self.v_random_ctx = {
    random_seed = room:get_random_seed()
  }
  Global.last_room_random_ctx = self.v_random_ctx
  self.v_create_tp_pos = {}
  self:register_event()
  self.v_notice_pos_key_effect = {}
  self.v_hit_temp = CompExtensions.GetRaycastHitArray(RAY_HIT_MAX)
  self.v_random_connect = self.v_tower and self.v_tower:get_random_room_list() or {}
  self.v_has_random_room = self.v_random_connect and #self.v_random_connect > 0 or false
  self.v_door_npc_list = {}
  self.v_contact_distance = {}
  self.v_cache_timeline_speed = {}
  self.v_remove_box_timer = {}
  self.v_tping = false
  self.v_last_pos_ping_send = 0
  self.v_delay_fight_end_data = nil
  self.v_last_update_contact_time = Global.scaled_time
  if not Util.is_client_only() and not Util.is_empty(logic_id) then
    self:init_scene_logic_runner(logic_id)
  end
end

function M:init_scene_logic_runner(logic_id)
  local exist_logic_config = ShareRes.is_exist_config("scene_logic." .. logic_id)
  if exist_logic_config then
    self.v_scene_logic_runner = require("manager.scene.scene_logic_runner"):new(logic_id)
  else
    local BehaviorLoader = require("utils.scene_behavior_loader")
    self.v_scene_logic_runner = BehaviorLoader.load_scene_behavior("scene." .. logic_id)
  end
end

function M:get_scene_logic_runner()
  return self.v_scene_logic_runner
end

function M:release()
  self.v_scene_map:release()
  self.v_scene_map = nil
  self.v_enter_area_map = {}
  for k, v in pairs(self.v_tp_points) do
    v:on_destroy()
  end
  UtilTable.clear_map(self.v_tp_points)
  UnityDestroy(self.v_tp_root)
  self.v_tp_root = nil
  self.v_npc_contact = nil
  self.v_chat_role_npc_contact = nil
  for k, v in pairs(self.v_create_gameobj_map) do
    ResPoolMgr:release(v)
  end
  self.v_create_gameobj_map = {}
  if nil ~= self.v_interact_timer then
    Timer:remove_timer(self.v_interact_timer)
  end
  Util.unbind_all_msg(self)
  self.v_notice_pos_key_effect = {}
  for k, v in pairs(self.v_func_npc_map) do
    self:remove_functional_npc(k)
  end
  self.v_contact_distance = {}
  self.v_func_npc_map = {}
  for key, timer in pairs(self.v_remove_box_timer) do
    Timer:remove_timer(timer)
    self.v_remove_box_timer[key] = nil
  end
  for k, v in pairs(self.v_treasure_chest_map) do
    self:remove_treasure_chest(k)
  end
  self.v_treasure_chest_map = {}
  self.v_src_tp_index = nil
  self.v_door_npc_list = {}
  self.v_delay_fight_end_data = nil
  self:clear_tp_timer()
  if self.v_scene_logic_runner then
    self.v_scene_logic_runner:release()
  end
  Global.last_room_random_ctx = nil
end

function M:register_event()
  Util.bind_msg(self, Const.MSG_CREATE_FUNCTIONAL_NPC, self.create_functional_npc, self)
  Util.bind_msg(self, Const.MSG_CREATE_TREASURE_CHEST, self.create_treasure_chest, self)
  Util.bind_msg(self, Const.MSG_REFRESH_TREASURE_CHEST_STATE, self.refresh_treasure_chest_state, self)
  Util.bind_msg(self, Const.MSG_ON_INIT_BOX_DRAW_END, self.response_init_box_draw_end, self)
  Util.bind_msg(self, Const.MSG_ON_HIDE_UI, self.response_ui_hide, self)
  Util.bind_msg(self, Const.MSG_ON_NORMAL_DROP_NPC_CREATE_ITEM_END, self.response_npc_create_item_end, self)
  Util.bind_msg(self, Const.MSG_ON_INTERACT_NPC_SUCCESS, self._response_interact_succ_event, self)
  Util.bind_msg(self, Const.MSG_ON_STORY_END, self._on_story_end, self)
  Util.bind_msg(self, Const.MSG_TREASURE_CHEST_OPEN_FINISH, self.on_treasure_chest_open_finish, self)
end

local function reduce_distance_from_y_angle(x, y, y_angle)
  local distance = ShareRes.get_comm_value("TPReduceDistance")
  local dir_vec3 = Quat.AngleAxis(y_angle, Vec3.up) * Vec3.forward
  local offsetx, offsety = dir_vec3.x * distance, dir_vec3.z * distance
  return x + offsetx, y + offsety
end

local function reduce_distance_from_center(center_x, center_y, x, y)
  local distance = ShareRes.get_comm_value("TPReduceDistance")
  local dir_x, dir_y = center_x - x, center_y - y
  local len = math.sqrt(dir_x * dir_x + dir_y * dir_y)
  local offsetx, offsety = dir_x / len * distance, dir_y / len * distance
  return x + offsetx, y + offsety
end

function M:on_enter()
  self.v_scene_map:on_enter()
  if not Util.is_client_only() then
    self.v_room:setup()
  end
  self:set_hero_born_pos()
  self.v_scene_map:on_after_role_set_pos()
  if not Util.is_story_only() then
    local ui = UIMgr:get_ui("fight")
    if not ui:visible() then
      ui:ui_show()
    end
    local uidynamic_canvas = UIMgr:get_ui("uidynamic_canvas")
    uidynamic_canvas:ui_show()
    ui:try_ui_add_sub_panels(uidynamic_canvas)
    ui:set_safe_panel_hidden()
  end
  if Global.camera then
    Global.camera:on_enter_room(self.v_room)
    Global.camera:set_camera_pos()
  end
  if Util.is_client_only() then
    SceneMgr:set_scene_show(true, function()
      MsgGame:mq_publish2(Const.MSG_TP_ROOM_FINISH)
      MsgGame:mq_publish2(Const.MSG_SCENE_LOAD_FINISH)
    end)
    SceneMgr.v_is_show_fight_main = false
  end
end

function M:start_scene_logic(request)
  if self.v_scene_logic_runner then
    self.v_scene_logic_runner:on_scene_ready()
  end
end

function M:set_hero_born_pos()
  if self.v_tower then
    local pos_key, is_born = self:get_enter_tp_pos_key()
    local x, y, z = self:get_pos_key_position(pos_key)
    local tp_pos_rule = self.v_tower:get_tp_pos_rule_type()
    local hero = Global.hero
    local euler_angle = self:get_pos_euler_angle(pos_key)
    if not is_born then
      local is_tp_born, born_x, born_y, born_z = self:get_enter_tp_born_pos()
      if is_tp_born then
        x, y, z = born_x, born_y, born_z
      end
      if tp_pos_rule == Config.TP_POS_RULE.CENTER then
        local center_x, center_y, center_z = self:get_pos_key_position(CENTER_POS_KEY)
        if center_z and center_x and not is_tp_born then
          x, z = reduce_distance_from_center(center_x, center_z, x, z)
        end
        hero:set_pos(x, y, z)
      elseif euler_angle and not is_tp_born then
        x, z = reduce_distance_from_y_angle(x, z, euler_angle.y)
        hero:set_pos(x, y, z)
        hero:face_to_pos_by_angle(euler_angle.y, true)
        hero:update_pos_height()
      end
    else
      if euler_angle then
        hero:face_to_pos_by_angle(euler_angle.y, true)
      end
      hero:set_pos(x, y, z)
    end
  end
end

function M:update(delta_time)
  local t = self.v_tp_points
  for _, v in pairs(t) do
    v:update()
  end
  if not Util.is_client_only() then
    self.v_room:update()
  end
  if SceneMgr:can_update() and Global.hero and Global.scaled_time - self.v_last_update_contact_time >= UPDATE_CONTACT_TIME_INTERVAL then
    self:hero_contact_npc()
    self.v_last_update_contact_time = Global.scaled_time
  end
  self:_hero_contact_random_door()
  if not Util.is_client_only() and not Util.is_story_only() and Global.real_time - self.v_last_pos_ping_send >= REPORT_POS_INTERVAL then
    self.v_last_pos_ping_send = Global.real_time
    if self.v_room and not self.v_tower:is_ready_tp() and not self:is_tping() then
      self.v_room:send_hero_born_pos()
    end
  end
end

function M:late_update()
  self.v_scene_map:late_update()
end

function M:on_npc_remove(npc)
end

function M:get_logic_id()
  return self.v_logic_id
end

function M:get_map_file_path()
  local scene_name = self.v_scene_cfg.SceneName and self.v_scene_cfg.SceneName or self.v_scene_cfg.MapName
  return "map." .. scene_name .. "." .. self.v_room.room_cfg.MapInfo
end

function M:get_scene_map()
  return self.v_scene_map
end

function M:add_behavior(behavior)
end

function M:get_time()
  return GlobalTimeMgr:get_unscaled_time() - self.v_start_time
end

function M:send_check_area_event(char, position)
  if char:is_role() and not self:is_tping() then
    SceneMgr:c2gs_call_scene("check_area_event", char.uuid, position.x, position.y, position.z)
  end
end

function M:send_check_area_mask(char, mask)
  if char:is_role() and not self:is_tping() then
    SceneMgr:c2gs_call_scene("check_area_mask_event", char.uuid, mask)
  end
end

function M:check_area_mask(mask, position)
  return self.v_scene_map:check_area_mask(mask, position)
end

function M:trigger_area_event_on_path(baseobj, mask, start_pos, end_pos)
  self.v_scene_map:trigger_area_event_on_path(baseobj, mask, start_pos, end_pos)
end

function M:is_in_tp_area(mask, position)
  return self.v_scene_map:is_in_tp_area(mask, position)
end

function M:is_in_move_plat(x, z)
  return self.v_scene_map:is_in_move_plat(x, z)
end

function M:actvie_obstacle(key, tag, is_active)
  self.v_scene_map:actvie_obstacle(key, tag, is_active)
end

function M:actvie_collider(obj_name, is_active, block_char, block_missile)
  self.v_scene_map:actvie_collider(obj_name, is_active, block_char, block_missile)
end

function M:on_enter_area(npc, area)
end

function M:on_leave_area(npc, area)
end

function M:remove_area(key, tag)
  self.v_scene_map:remove_area(key, tag)
end

function M:draw_areas()
  self.v_scene_map:draw_areas()
end

function M:_on_story_end(msg)
  if self.v_delay_fight_end_data then
    self.v_room:on_fight_end(table.unpack(self.v_delay_fight_end_data))
    if self.v_scene_logic_runner then
      self.v_scene_logic_runner:on_fight_end(table.unpack(self.v_delay_fight_end_data))
    end
    self.v_delay_fight_end_data = nil
    if TowerMgr:is_long_chapter() then
      self.v_tower:check_show_recore_node_save()
    end
  end
end

function M:is_delay_fight_end()
  return self.v_delay_fight_end_data ~= nil
end

function M:fight_end(is_win)
  if false == is_win and self:is_need_open_fail_win() then
    UIMgr:get_ui("not_progress_battle_def_settle"):ui_show()
    return
  end
  local story_id = StoryMgr:get_cur_play_story_id()
  if story_id and StoryMgr:check_story_is_settle_story(story_id) then
    self.v_delay_fight_end_data = table.pack(is_win)
    return
  end
  self.v_room:on_fight_end(is_win)
  if self.v_scene_logic_runner then
    self.v_scene_logic_runner:on_fight_end(is_win)
  end
end

function M:is_need_open_fail_win()
  local fight_type = TowerMgr:get_fight_type()
  if fight_type == CommonDefine.CHALLENGE_TYPE.WEEK_ACTY_PERPARE_EPI or fight_type == CommonDefine.CHALLENGE_TYPE.WEEK_ACTY_PVP_EPI or fight_type == CommonDefine.CHALLENGE_TYPE.ACTIVITY_PONDER then
    return true
  end
  return false
end

function M:is_pass_room()
  return self.v_tower:is_pass_room()
end

function M:check_need_pause_tp(fight_info, tp_index)
  if fight_info.type == CommonDefine.CHALLENGE_TYPE.LONG_CHAPTER then
    local point_id = fight_info.point_id
    local tower = TowerMgr:get_tower()
    local room_id = tower:get_cur_room_id()
    local node_cfg = ShareRes.get_chapter_node_cfg_by_last_room_id(point_id, room_id, tp_index)
    return node_cfg and node_cfg.TpDir == tp_index and not ChapterMgr:is_node_has_been_comp(node_cfg.Id)
  elseif fight_info.type == CommonDefine.CHALLENGE_TYPE.BUDDY_TEACH then
    TowerMgr:buddy_teach_floor_settle()
    return true
  else
    return false
  end
end

function M:tp_room(src_tp_index)
  local tp_index = src_tp_index or self.v_src_tp_index
  if not tp_index then
    Log.Error("tp_index is nil")
    return
  end
  local tp_point = self.v_tp_points[tp_index]
  if not tp_point or not tp_point:get_can_tp() then
    Log.Info("传送门未开启")
    Log.Info("传送门调试 传送门未开启", debug.traceback())
    self.v_src_tp_index = src_tp_index
    return
  end
  self.v_test_tp = src_tp_index
  if self.v_tower:is_ready_tp() or self:is_tping() then
    Log.Info("正在传送中", self.v_tower:is_ready_tp(), self:is_tping())
    Log.Info("传送门调试 正在传送中", debug.traceback())
    return
  end
  self:create_tp_timer()
  local fight_info = TowerMgr:get_fight_info()
  local fight_type = fight_info.type
  if self:check_need_pause_tp(fight_info, tp_index) then
    SceneMgr:send_tp_befoce_req(tp_index)
    self.v_continue_tp_room_params = {
      tp_index,
      fight_type,
      tp_point
    }
    return
  end
  self:continue_tp_room(tp_index, fight_type, tp_point)
end

function M:stop_barrage()
  if StoryMgr then
    StoryMgr:stop_barrage()
  end
end

function M:continue_tp_room(tp_index, fight_type, tp_point)
  self:stop_barrage()
  if self.v_continue_tp_room_params then
    self.v_continue_tp_room_params = nil
  end
  if self.v_tower:is_end_room(tp_index) then
    local function callback()
      local effect_data = Global.hero.act_effect_ctrl.create_effect_param()
      
      effect_data.prefab_name = Path.get_res_path("Fx_Common_BianShen")
      effect_data.parent = Global.hero.transform
      
      function effect_data.callback()
        self.v_tping = false
        return self.v_tower:on_tp_room(tp_index)
      end
      
      Global.hero.act_effect_ctrl:play_effect(effect_data)
    end
    
    if self.v_tower:get_tower_pass() then
      callback()
    else
      local is_need_show_level_floor_win = false
      local tower = TowerMgr:get_tower()
      if tower then
        is_need_show_level_floor_win = TowerMgr:get_tower():is_need_show_level_floor_win()
      end
      if fight_type == CommonDefine.CHALLENGE_TYPE.CUT_GRASS then
        if tower then
          tower:enter_next_floor()
          callback()
        end
      elseif fight_type == CommonDefine.CHALLENGE_TYPE.INFINITE and false == is_need_show_level_floor_win then
        local wait_hero_list = SceneMgr:get_wait_hero()
        BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.ON_FLOOR_FINISHED, Global.hero, wait_hero_list[1], wait_hero_list[2], tower.v_floor_num)
        callback()
        MsgGame:mq_publish2(Const.MSG_ON_ENTER_NEW_FLOOR)
        MsgGame:mq_publish2(Const.MSG_PRE_TP_ROOM)
      elseif fight_type == CommonDefine.CHALLENGE_TYPE.BUDDY_TEACH then
        local wait_hero_list = SceneMgr:get_wait_hero()
        BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.ON_FLOOR_FINISHED, Global.hero, wait_hero_list[1], wait_hero_list[2], tower.v_floor_num)
        callback()
        MsgGame:mq_publish2(Const.MSG_ON_ENTER_NEW_FLOOR)
        MsgGame:mq_publish2(Const.MSG_PRE_TP_ROOM)
      elseif not SceneMgr:get_jump_floor_ui() and fight_type ~= CommonDefine.CHALLENGE_TYPE.LONG_CHAPTER then
        TowerMgr.v_is_cut_pnl = true
        local ui_name = TP_NEXT_UI_NAME[fight_type] or TP_NEXT_UI_NAME.other
        UIMgr:get_ui(ui_name):ui_show(true, callback, tp_point)
        if fight_type ~= CommonDefine.CHALLENGE_TYPE.INFINITE then
          MsgGame:mq_publish2(Const.MSG_ON_ENTER_NEW_FLOOR)
        end
        if Global.state_sound_mgr then
          Global.state_sound_mgr:trigger_fight_state_by_id(Config.FIGHT_STATE.TOWER_WIN)
        end
      else
        callback()
      end
    end
  else
    local function cb()
      SceneMgr:set_scene_show(false, function()
        SceneMgr:set_player_control_on()
        
        Log.Info("set_scene_show false end")
        return self.v_tower:on_tp_room(tp_index)
      end, 0)
    end
    
    SceneMgr:set_player_control_off()
    Joystick.on_joystick("end")
    Log.Info("tp point transmit")
    tp_point:transmit(cb)
    if Global.sound_mgr then
      Global.sound_mgr:play_transmit_sound(true)
    end
  end
  if fight_type ~= CommonDefine.CHALLENGE_TYPE.INFINITE then
    MsgGame:mq_publish2(Const.MSG_PRE_TP_ROOM)
  end
end

function M:cr_tp_room(tp_room_num)
  SceneMgr:set_scene_show(false, function()
    Log.Info("set_scene_show false end")
    return self.v_tower:on_tp_room(tp_room_num, 0)
  end, 0)
  MsgGame:mq_publish2(Const.MSG_PRE_TP_ROOM)
end

function M:get_enter_tp_index()
  return self.v_room:get_enter_tp_index()
end

function M:enter_floor(floor)
  self.v_tower:on_enter_floor(floor)
end

function M:get_enter_tp_pos_key()
  local index = self:get_enter_tp_index()
  if 0 == index then
    return "bornpoint", true
  end
  return "tp" .. index
end

function M:get_enter_tp_born_pos()
  local tp_index = self:get_enter_tp_index()
  if 0 == tp_index then
    return
  end
  local born_key = "born" .. tp_index
  local position = self.v_scene_map:get_area_position(born_key)
  if not position then
    return
  end
  return true, position.X, position.Y, position.Z
end

function M:get_pos_key_position(pos_key, is_gm_get)
  if not pos_key then
    return
  end
  if Util.is_client_only() and not is_gm_get then
    return
  end
  local position = self.v_scene_map:get_area_position(pos_key)
  if not position then
    Log.Info("can not find get_pos_key_position ", pos_key)
    return
  end
  return position.X, position.Y, position.Z
end

function M:get_pos_euler_angle(pos_key)
  local position = self.v_scene_map:get_area_position(pos_key)
  if not position then
    Log.Info("can not find get_pos_key_position " .. pos_key)
    return
  end
  local rotation = position.Trans.localEulerAngles
  return rotation
end

function M:switch_gameobject_position(src_name, target_name)
  local src_object = UnityFind(src_name)
  local target_object = UnityFind(target_name)
  if not src_object or not target_object then
    print("not find object")
    return
  end
  local temp_position = src_object.transform.position
  src_object.transform.position = target_object.transform.position
  target_object.transform.position = temp_position
end

function M:get_face_euler(pos_key, target_pos_key)
  local from_pos = self.v_scene_map:get_area_position(pos_key)
  local to_pos = self.v_scene_map:get_area_position(target_pos_key)
  if from_pos and to_pos then
    return Math.get_lookat_dir(from_pos.X, from_pos.Z, to_pos.X, to_pos.Z)
  end
end

function M:create_world_model_on_position(object_name, name, pos_key, offset_y, position, euler_y, arg_map)
  position = position or self.v_scene_map:get_area_position(pos_key)
  if not position then
    Log.Info("create_world_model_on_position position null ", pos_key)
    return
  end
  offset_y = offset_y or 0
  local height = position.Y + offset_y
  local tp_effect = TP_EFFECT_TYPE[object_name]
  if tp_effect then
    if not SceneMgr:check_create_tp_point() then
      return
    end
    local idx = TP_POSKEY_TO_INDEX[pos_key]
    if self.v_tp_points[idx] then
      return
    end
    self.v_create_tp_pos[name] = {
      x = position.X,
      y = height,
      z = position.Z,
      idx = idx
    }
    local look_dir
    if self.v_tower:can_archieve() then
      look_dir = position.Trans.transform.rotation.eulerAngles.y
    else
      local look_pos = self.v_scene_map:get_area_position(pos_key .. "look") or self.v_scene_map:get_area_position(CENTER_POS_KEY)
      if look_pos then
        look_dir = Util.get_eulery(look_pos.X - position.X, look_pos.Z - position.Z)
      end
    end
    local is_locked = self.v_room:get_tp_is_locked(idx)
    local prefab_name
    if arg_map and not Util.is_empty(arg_map.name) then
      prefab_name = arg_map.name
    else
      local target_room_id = self.v_tower:get_tp_target_room_id(idx)
      if target_room_id then
        local target_room_cfg = ShareRes.get_room_cfg(target_room_id)
        if target_room_cfg then
          local target_room_type_cfg = ShareRes.get_tower_room_type_cfg(target_room_cfg.Type)
          if target_room_type_cfg then
            prefab_name = target_room_type_cfg.TpEffect
          end
        end
      end
    end
    local tp_init_data = {
      name = name,
      height = height,
      idx = idx,
      position = position,
      range = TP_SERCH_RANGE,
      look_dir = look_dir,
      lock = is_locked,
      logic_type = tp_effect,
      prefab_name = prefab_name
    }
    local tp_point = require("manager.scene.scene_tp_point"):new(tp_init_data)
    self.v_tp_points[idx] = tp_point
    self.v_tp_name_points[name] = idx
    return
  end
  self:create_gameobj(object_name, name, position.X, height, position.Z, euler_y)
end

function M:create_gameobj(object_name, name, x, y, z, euler_y, callback)
  ResPoolMgr:get_world_model_async(object_name, function(game_object)
    game_object.name = name
    game_object.transform.position = Vec3.New(x, y, z)
    if euler_y then
      game_object.transform:SetEulerY(euler_y)
    end
    CSFollower.FollowOnce(game_object.gameObject)
    if callback then
      callback(game_object)
    end
    self.v_create_gameobj_map[name] = game_object
  end)
end

function M:get_tp_obj_pos()
  return self.v_create_tp_pos
end

function M:remove_world_model(name)
  local cache_obj = self.v_create_gameobj_map[name]
  if cache_obj then
    ResPoolMgr:release(cache_obj)
  end
  self.v_create_gameobj_map[name] = nil
end

function M:get_random_ctx()
  return self.v_random_ctx
end

function M:hero_contact_npc(force_check)
  self.v_clear_contact_flag = nil
  self.v_min_npc_dist = math.huge
  local last_id = self.v_min_dist_npc_id
  self.v_min_dist_npc_id = nil
  self.v_leave_npc_id = nil
  for _, npc in pairs(self.v_func_npc_map) do
    self:_contact_npc(npc)
  end
  for _, npc in pairs(self.v_treasure_chest_map) do
    self:_contact_treasure_chest(npc)
  end
  if (self.v_clear_contact_flag or force_check) and not next(self.v_npc_contact) then
    local msg = MsgGame:mq_publish2(Const.MSG_TOG_FUNCTIONAL_NPC)
    if self.v_leave_npc_id then
      local npc = self.v_func_npc_map[self.v_leave_npc_id]
      if npc then
        msg.mm_x = npc.data
      end
    end
    msg.mm_y = false
  elseif self.v_min_dist_npc_id and self.v_min_dist_npc_id ~= last_id and self.v_func_npc_map[self.v_min_dist_npc_id] then
    local npc = self.v_func_npc_map[self.v_min_dist_npc_id]
    local msg = MsgGame:mq_publish2(Const.MSG_TOG_FUNCTIONAL_NPC)
    msg.mm_x = npc.data
    msg.mm_y = true
  end
end

function M:_contact_npc(npc)
  local npc_data = npc.data
  local npc_id = npc_data.npc_id
  local contact_dis = self.v_contact_distance[npc_id] or NORMAL_INTERACT_DISTANCE
  local is_door_npc = false
  if npc:is_functional_npc() and npc:is_door_npc() then
    contact_dis = contact_dis * 0.3
    is_door_npc = true
  end
  if Global.hero == nil then
    return
  end
  local hero_pos = Global.hero:get_pos_vec3()
  local npc_pos = npc:get_pos_vec3()
  local distance = Math.distance(hero_pos.x, hero_pos.y, hero_pos.z, npc_pos.x, npc_pos.y, npc_pos.z)
  if is_door_npc then
    if distance > contact_dis * 2 then
      self.v_hero_in_tp = false
    end
    if self.v_hero_in_tp then
      return
    end
  end
  local is_in = contact_dis > distance
  if self.v_npc_contact[npc_id] ~= is_in then
    if not npc.data.is_get then
      if is_in and distance < self.v_min_npc_dist then
        self.v_min_dist_npc_id = npc_id
        self.v_min_npc_dist = distance
      end
      if is_in then
        self.v_npc_contact[npc_id] = is_in
      elseif self.v_npc_contact[npc_id] then
        self.v_clear_contact_flag = true
        self.v_npc_contact[npc_id] = nil
        self.v_leave_npc_id = npc_id
      end
    else
      self.v_npc_contact[npc_id] = nil
    end
  end
  local npc_cfg = npc_data.npc_cfg
  if npc_cfg and FUN_NPC_HELPER.is_need_show_bubble(npc_cfg) then
    local chat_dis_range = CHAT_ROLE_NPC_INTERACT_DISTANCE
    if npc_cfg.ChatRange and npc_cfg.ChatRange > 0 then
      chat_dis_range = npc_data.npc_cfg.ChatRange
    end
    local is_in_chat = distance < chat_dis_range
    if nil == self.v_chat_role_npc_contact[npc.data.npc_id] or self.v_chat_role_npc_contact[npc.data.npc_id] ~= is_in_chat then
      local msg = MsgGame:mq_publish2(Const.MSG_TOG_FUNCTIONAL_CHAT_ROLE_NPC)
      msg.mm_x = npc
      msg.mm_y = is_in_chat
      self.v_chat_role_npc_contact[npc.data.npc_id] = is_in_chat
    end
  end
end

function M:_contact_treasure_chest(npc)
  if Global.hero == nil then
    return
  end
  local cfg = npc.cfg
  if not cfg then
    return
  end
  local contact_dis = cfg.InteractRange or TREASURE_CHEST_INTERACT_DISTANCE
  local hero_pos = Global.hero:get_pos_vec3()
  local npc_pos = npc:get_pos_vec3()
  local distance = Math.distance(hero_pos.x, hero_pos.y, hero_pos.z, npc_pos.x, npc_pos.y, npc_pos.z)
  local is_in = contact_dis > distance
  if not self.v_npc_contact[npc.npc_contact_key] and not is_in then
    return
  end
  if self.v_npc_contact[npc.npc_contact_key] ~= is_in then
    local msg = MsgGame:mq_publish2(Const.MSG_TRIGGER_TREASURE_CHEST)
    msg.mm_x = npc
    msg.mm_y = is_in
    self.v_npc_contact[npc.npc_contact_key] = is_in
    if not is_in then
      self.v_npc_contact[npc.npc_contact_key] = nil
    end
  end
end

function M:is_contacting_func_npc(npc_id)
  return self.v_npc_contact[npc_id]
end

function M:remove_functional_npc(npc_id, is_not_send_msg)
  local npc = self:get_func_npc(npc_id)
  if not npc then
    return
  end
  self.v_npc_contact[npc.data.npc_id] = nil
  self.v_chat_role_npc_contact[npc.data.npc_id] = nil
  self.v_func_npc_map[npc_id] = nil
  self.v_contact_distance[npc_id] = nil
  local time = npc:get_play_end_effect_time()
  if time and time > 0 and npc.is_role_npc and not npc:is_role_npc() then
    npc:play_end_effect()
    Timer:add_timer("delay_remove_functional_npc", time + 0.1, function()
      self:remove_functional_npc_or_treasure_chest(npc_id, npc, is_not_send_msg)
    end)
  else
    self:remove_functional_npc_or_treasure_chest(npc_id, npc, is_not_send_msg)
  end
end

function M:remove_functional_npc_or_treasure_chest(npc_id, npc, is_not_send_msg)
  SceneMgr:remove_functional_npc(npc)
  if FunctionalNpcMgr then
    FunctionalNpcMgr:release_interaction_npc_hud(npc_id)
    FunctionalNpcMgr:release_role_npc_bubble_chat(npc_id)
  end
  self:recheck_hero_contact_npc()
end

function M:check_function_npc_is_added(npc_name)
  if self.v_func_npc_map[npc_name] then
    return true
  end
  return false
end

function M:create_functional_npc(msg)
  local data = msg.mm_obj
  local npc_id = data.npc_id
  local is_get = data.is_get
  if self.v_func_npc_map[npc_id] then
    Log.Info("无法创建ID相同的功能性Npc！", debug.traceback())
    return
  end
  local npc_cfg = ShareRes.create("npc.functional_npc", npc_id)
  if not npc_cfg then
    if not data.mArgs or not data.mArgs.npc_type then
      Log.Error("read functional_npc failure! npc_id=", npc_id)
      return
    end
    npc_cfg = {}
    if data.mArgs.npc_type == CommonDefind.FUNCTIONAL_NPC_TYPE.EXHIBITION then
      local cfg = data.mArgs
      npc_cfg.InteractRange = cfg.interaction_area
      npc_cfg.Type = CommonDefind.FUNCTIONAL_NPC_TYPE.EXHIBITION
      npc_cfg.ShowType = CommonDefind.FUNCTIONAL_NPC_TYPE.CHALLENGE
      npc_cfg.Effect = Util.split_str(cfg.use_effect, "|")
      if cfg.is_has_action then
        npc_cfg.IsPlayInteractAnima = 1
      else
        npc_cfg.IsPlayInteractAnima = 0
      end
      npc_cfg.LongPress = cfg.long_press
      npc_cfg.LongPressTime = cfg.long_press_time
      npc_cfg.LongPressStop = cfg.long_press_stop
      npc_cfg.LongPressPause = cfg.long_press_pause
      npc_cfg.ButtonIcon = "zjm_img_20"
      npc_cfg.Icon = "Battle_maps_icon_box"
      npc_cfg.ModelId = "H101004"
      npc_cfg.BodyRadius = 0.5
      npc_cfg.IsNewInteractNPC = cfg.is_new_interact_npc
      npc_cfg.NPCName = cfg.npc_name
      if npc_cfg.LongPress then
        npc_cfg.PlayInteractingSoundName = cfg.play_interact_sound_name
      else
        npc_cfg.PlayInteractSoundName = cfg.play_interact_sound_name
      end
    end
  else
    npc_cfg.LongPress = npc_cfg.LongPressTime and npc_cfg.LongPressTime > 0
    npc_cfg.LongPressStop = npc_cfg.LongPressState == nil or 0 == npc_cfg.LongPressState
    npc_cfg.LongPressPause = npc_cfg.LongPressState and npc_cfg.LongPressState > 0
  end
  local room_num = self.v_room:get_room_num()
  self.v_tower:update_npc_list(room_num, data)
  local x, y, z = self:get_pos_key_position(data.pos_key)
  Util.assert(x and y, "not exist pos key", data.pos_key)
  local rotation = data.rotation
  local src_path = FUNCTIONL_NPC_TYPE[npc_cfg.ShowType]
  data.npc_cfg = npc_cfg
  data.npc_name = data.mArgs.name
  local luaobj = SceneMgr:create_functional_npc(npc_id, x, y, z, rotation, data, src_path, function(npc_lua)
    if not data.npc_cfg.RoleActionType then
      npc_lua:player_anim("idle")
    else
      npc_lua:player_anim(data.npc_cfg.RoleActionType)
    end
    npc_lua:check_point_list()
  end)
  data.room_num = room_num
  data.pos = Vec3.New(x, y, z)
  self.v_func_npc_map[npc_id] = luaobj
  self.v_contact_distance[npc_id] = npc_cfg.InteractRange or NORMAL_INTERACT_DISTANCE
  if luaobj:is_get_award_npc() and is_get then
    luaobj:create_drop_item()
    if luaobj:is_normal_drop_npc() then
      self:remove_functional_npc(npc_id)
    end
  end
  MsgGame:mq_publish2(Const.MSG_ON_CREATE_NPC_FINISH)
end

function M:get_room()
  return self.v_room
end

function M:create_notice_obstacle_effect(pos_key, effect_name, dir, euler_y)
  if self.v_notice_pos_key_effect[pos_key] then
    return
  end
  local x, y, z = self:get_pos_key_position(pos_key)
  local effect_pos
  local pos_x, pos_z = Global.hero:get_pos2()
  if 1 == dir then
    effect_pos = {
      X = pos_x,
      Y = y,
      Z = z
    }
  else
    effect_pos = {
      X = x,
      Y = y,
      Z = pos_z
    }
  end
  self:create_world_model_on_position(effect_name, pos_key, pos_key, 1, effect_pos, euler_y)
  self.v_notice_pos_key_effect[pos_key] = pos_key
end

function M:clear_notice_obstacle_effect(pos_key)
  self:remove_world_model(pos_key)
  self.v_notice_pos_key_effect[pos_key] = nil
end

function M:get_func_npc(npc_id)
  if not npc_id then
    return
  end
  local npc = self.v_func_npc_map[npc_id]
  if npc then
    if npc:is_destroy() then
      self.v_func_npc_map[npc_id] = nil
    else
      return npc
    end
  end
end

function M:get_treasure_chest(id)
  if not id then
    return
  end
  local npc = self.v_treasure_chest_map[id]
  if npc then
    if npc:is_destroy() then
      self.v_treasure_chest_map[id] = nil
    else
      return npc
    end
  end
end

function M:set_func_npc_visible(npc_id, is_visible)
  if not npc_id then
    return
  end
  local npc = self.v_func_npc_map[npc_id]
  if npc then
    if npc:is_destroy() then
      self.v_func_npc_map[npc_id] = nil
    else
      npc:set_obj_enable(is_visible)
    end
  end
end

function M:get_func_npc_list()
  return self.v_func_npc_map
end

function M:remove_tp(tp_name)
  if self.v_tp_name_points[tp_name] then
    local idx = self.v_tp_name_points[tp_name]
    self.v_tp_points[idx]:on_destroy()
    self.v_tp_points[idx] = nil
    self.v_tp_name_points[tp_name] = nil
    self.v_create_tp_pos[tp_name] = nil
  end
end

function M:is_pass_tp_room(tp_name)
  local idx = self.v_tp_name_points[tp_name]
  if not idx then
    return
  end
  local cur_room_connect = self.v_tower:get_room_connect()
  local tp_info = cur_room_connect[idx]
  if not tp_info then
    return
  end
  local target_room = tp_info.TargetRoomNum
  local is_pass = self.v_tower:is_pass_room(target_room)
  return is_pass
end

function M:is_cache_src_tp_index()
  return self.v_src_tp_index
end

function M:show_scene_position()
  if not self.v_scene_map then
    return
  end
  self.v_scene_map:show_scene_position()
end

function M:get_tp(tp_id)
  return self.v_tp_points[tp_id]
end

function M:_hero_contact_random_door()
  if not self:_get_can_create_door_npc() then
    return
  end
  local hero_pos = Global.hero:get_pos_vec3()
  local min_distance = math.maxinteger
  local min_dir = 0
  local connect_data
  for _, v in pairs(self.v_random_connect) do
    local position = self.v_scene_map:get_edge_center_point(v.src_dir)
    local distance = Math.distance2(hero_pos.x, hero_pos.z, position.x, position.y)
    if min_distance > distance then
      min_distance = distance
      min_dir = v.src_dir
      connect_data = v
    end
  end
  if 0 == min_dir or self.v_door_npc_list[min_dir] ~= nil then
    return
  end
  if min_distance < NORMAL_INTERACT_DISTANCE then
    local transmit_data = {
      room_num = self.v_room:get_room_num(),
      connect = connect_data
    }
    self:_do_create_random_door(min_dir, transmit_data)
  end
end

function M:create_random_door()
  if not self:_get_can_create_door_npc() then
    return
  end
  for _, v in pairs(self.v_random_connect) do
    if self.v_tower:is_pass_room(v.target_room_num) then
      local transmit_data = {
        room_num = self.v_room:get_room_num(),
        connect = v
      }
      self:_do_create_random_door(v.src_dir, transmit_data)
    end
  end
end

function M:_get_can_create_door_npc()
  if not self.v_tower then
    return false
  end
  if self.v_tower:get_is_random_room(self.v_room:get_room_num()) then
    return false
  end
  if not self.v_has_random_room then
    return false
  end
  if not self.v_room:is_fight_end() then
    return false
  end
  return true
end

function M:_do_create_random_door(dir, transmit_data)
  local create_pos = self.v_scene_map:get_edge_center_point(dir)
  local crate_msg = {
    pos_x = create_pos.x,
    pos_y = create_pos.y,
    pos_z = create_pos.z,
    npc_id = 82000,
    transmit_data = transmit_data,
    dir = dir
  }
  self:_create_door_npc(crate_msg)
end

function M:_create_door_npc(create_data)
  local npc_id = create_data.npc_id
  local npc_cfg = ShareRes.create("npc.functional_npc", npc_id)
  if not npc_cfg then
    Log.Error("read functional_npc failure! npc_id=", npc_id)
    return
  end
  local room_num = self.v_room:get_room_num()
  self.v_tower:update_npc_list(room_num, create_data)
  local src_path = FUNCTIONL_NPC_TYPE[npc_cfg.ShowType]
  local luaobj = SceneMgr:create_functional_npc(npc_id, create_data.pos_x, create_data.pos_y, create_data.pos_z, 0, create_data, src_path, function(npc_lua)
    npc_lua:player_anim("idle")
  end)
  create_data.room_num = room_num
  create_data.npc_cfg = npc_cfg
  create_data.pos = Vec3.New(create_data.pos_x, create_data.pos_y, create_data.pos_z)
  self.v_func_npc_map[npc_id] = luaobj
  self.v_door_npc_list[create_data.dir] = luaobj
  MsgGame:mq_publish2(Const.MSG_ON_CREATE_NPC_FINISH)
end

function M:create_random_room_out_door(object_name, name, offset_y, face_pos_key)
  if not self.v_room:is_fight_end() then
    return
  end
  if not self.v_tower:get_is_random_room(self.v_room:get_room_num()) then
    return
  end
  for _, v in pairs(self.v_random_connect) do
    if self.v_tower:is_pass_room(v.target_room_num) then
      self:_do_create_door(object_name, name, "tp" .. v.src_dir, offset_y, face_pos_key)
    end
  end
end

function M:_do_create_door(object_name, name, pos_key, offset_y, face_pos_key)
  local euler_y
  if face_pos_key then
    euler_y = self:get_face_euler(pos_key, face_pos_key)
  end
  self:create_world_model_on_position(object_name, name, pos_key, offset_y, nil, euler_y)
end

function M:response_init_box_draw_end()
  for npc_id, lua_obj in pairs(self.v_func_npc_map) do
    local npc_cfg = ShareRes.create("npc.functional_npc", npc_id)
    local show_type = npc_cfg.ShowType
    if show_type == Config.FUNCTIONAL_NPC_SHOW_TYPE.InitBox then
      lua_obj:check_init_box_state()
    end
  end
end

function M:response_ui_hide(msg)
  if msg.mm_obj == "fight" then
    return
  end
  self:recheck_hero_contact_npc()
end

function M:response_npc_create_item_end(msg)
  if nil == msg then
    return
  end
  local npc_id = msg.mm_x
  self:remove_functional_npc(npc_id)
end

function M:is_fun_npc_have_drop()
  if self.v_func_npc_map and next(self.v_func_npc_map) then
    for _, luaobj in pairs(self.v_func_npc_map) do
      local data = luaobj.data
      local mArgs = data.mArgs
      if mArgs then
        local drop_list = mArgs.drop_list
        if drop_list and next(drop_list) then
          return true
        end
      end
    end
  end
  return false
end

function M:create_tp_timer()
  self:clear_tp_timer()
  self.v_tping = true
  self.v_tp_timer = Timer:add_timer("tping", 3, function()
    self.v_tping = false
  end)
end

function M:clear_tp_timer()
  if self.v_tp_timer then
    Timer:remove_timer(self.v_tp_timer)
    self.v_tp_timer = nil
  end
  self.v_tping = false
end

function M:is_tping()
  return self.v_tping
end

function M:_response_interact_succ_event(msg)
  if not msg then
    return
  end
  local npc_data = msg.mm_obj
  local npc_id = npc_data.npc_id
  local npc_cfg = npc_data.npc_cfg
  local is_remove = npc_cfg.IsRemove
  if is_remove == IS_REMOVE_NPC_TYPE.REMOVE and self.v_func_npc_map[npc_id] then
    self:remove_functional_npc(npc_id)
  end
end

function M:get_map_path()
  return self.v_map_path
end

function M:get_scene_prefab()
  local prefab_name = self.v_room.room_cfg.MapInfo
  return prefab_name
end

function M:stop_curse_countdown(time)
  local msg = MsgGame:mq_publish2(Const.MSG_ON_STOP_CURSE_COUNTDOWN)
  msg.mm_x = time
end

function M:update_functional_npc_data(npc_id, pos_key, face2_pos_key, is_get, mArgs)
  local npc = self:get_func_npc(npc_id)
  if not npc then
    return
  end
  if npc.data then
    npc.data.is_get = is_get
  end
  if npc:is_get_award_npc() and is_get then
    npc:create_drop_item()
    if npc:is_normal_drop_npc() then
      self:remove_functional_npc(npc_id)
    end
  end
end

function M:update_functional_npc_interaction_status(npc_id, is_get)
  local npc = self:get_func_npc(npc_id)
  if not npc then
    return
  end
  if npc.data then
    npc.data.is_get = is_get
  end
end

local function _find_scene_obj(root_name, object_name)
  local root = UnityFind(root_name)
  if not root or root:IsNull() then
    return
  end
  local object = root.transform:Find(object_name)
  if object and not object:IsNull() then
    return object
  end
end

function M:play_scene_time_line_back_foward(object_name, rewind_time, to_last_frame)
  local object = _find_scene_obj("GroupCtrlObj", object_name) or _find_scene_obj("Root", object_name)
  if not object then
    Log.Error("场景中找不到物体", object_name)
    return
  end
  object.gameObject:SetActive(true)
  local scene_timeline_player = object.gameObject:TryAddComponent(TypeReversibleTimeLinePlayer)
  local key = object.gameObject:GetInstanceID()
  SceneMgr:add_reversible_scene_timeline_dic(key, scene_timeline_player)
  if scene_timeline_player then
    if to_last_frame then
      scene_timeline_player:ToLastFrame(object_name)
    else
      if not self.v_scene_reversible_timeline_list then
        self.v_scene_reversible_timeline_list = {}
      end
      self.v_scene_reversible_timeline_list[object_name] = scene_timeline_player
      scene_timeline_player:FowardBackwardPlay(rewind_time, object_name, function(timeline_path)
        if not rewind_time or rewind_time <= 0 then
          self.v_scene_reversible_timeline_list[object_name] = nil
        end
        SceneMgr:c2gs_call_scene("on_reversible_timeline_end", timeline_path)
        BehaviorMgr:call_scene_logic_event_fun("on_reversible_timeline_end", timeline_path)
      end, function(timeline_path)
        self.v_scene_reversible_timeline_list[object_name] = nil
      end)
    end
  end
end

function M:play_scene_timeline(timeline_name)
  local object = _find_scene_obj("Root", timeline_name) or _find_scene_obj("GroupCtrlObj", timeline_name)
  if not object then
    Log.Error("not found, name = ", timeline_name)
    return
  end
  object.gameObject:SetActive(true)
  local scene_timeline_player = object.gameObject:TryAddComponent(TypeNormalTimeLinePlayer)
  if scene_timeline_player then
    if not self.v_scene_normal_timeline_list then
      self.v_scene_normal_timeline_list = {}
    end
    self.v_scene_normal_timeline_list[timeline_name] = scene_timeline_player
    scene_timeline_player:PlayTimeline(timeline_name, function(timeline_path)
      self.v_scene_normal_timeline_list[timeline_name] = nil
      if Network:is_can_c2gs_call_scene() then
        SceneMgr:c2gs_call_scene(BehaviorMgr.EVENTS.ON_TIMELINE_END, timeline_path)
      end
      BehaviorMgr:call_scene_logic_event_fun(BehaviorMgr.EVENTS.ON_TIMELINE_END, timeline_path)
    end)
    if self.v_cache_timeline_speed[timeline_name] then
      local speed = self.v_cache_timeline_speed[timeline_name]
      local pd = scene_timeline_player.director
      if pd and pd.playableGraph:IsValid() then
        pd.playableGraph:GetRootPlayable(0):SetSpeed(speed)
        self.v_cache_timeline_speed[timeline_name] = nil
      end
    end
  end
end

function M:set_scene_timeline_state(is_play)
  if self.v_scene_normal_timeline_list and next(self.v_scene_normal_timeline_list) then
    for _, timeline in pairs(self.v_scene_normal_timeline_list) do
      if is_play then
        timeline:ResumeTimeline()
      else
        timeline:PauseTimeline()
      end
    end
  end
  if self.v_scene_timeline_trans_list and next(self.v_scene_timeline_trans_list) then
    for _, trans in pairs(self.v_scene_timeline_trans_list) do
      if is_play then
        trans:SetTimeLinePause(false)
      else
        trans:SetTimeLinePause(true)
      end
    end
  end
  if self.v_scene_reversible_timeline_list and next(self.v_scene_reversible_timeline_list) then
    for _, reversible_timeline_player in pairs(self.v_scene_reversible_timeline_list) do
      if is_play then
        reversible_timeline_player:Resume()
      else
        reversible_timeline_player:Pause()
      end
    end
  end
end

function M:add_scene_timeline_trans(timeline_name, trans)
  if not self.v_scene_timeline_trans_list then
    self.v_scene_timeline_trans_list = {}
  end
  self.v_scene_timeline_trans_list[timeline_name] = trans
end

function M:remove_scene_timeline_trans(timeline_name)
  if self.v_scene_timeline_trans_list then
    self.v_scene_timeline_trans_list[timeline_name] = nil
  end
end

function M:remove_all_monster_silently()
  local scene_mgr = SceneMgr
  local all_npcs = scene_mgr:get_all_npc()
  for k, v in pairs(all_npcs) do
    if v.is_monster_with_kind and v:is_monster_with_kind() then
      scene_mgr:remove_npc_by_rpc(v, true)
    end
  end
end

function M:create_navigator_effect(name, is_continue)
  local npc = SceneMgr and SceneMgr:get_npc_by_name(name)
  if not npc then
    local scene_map = SceneMgr:get_scene_map()
    if not scene_map then
      return
    end
    local target_pos = scene_map:get_area_position(name)
    if target_pos then
      local hero_list = SceneMgr:get_hero_list()
      for _, hero in pairs(hero_list) do
        if hero and not hero:is_destroy() then
          hero:set_navigate_is_continue(is_continue)
          hero:navigate_to_pos(target_pos.X, target_pos.Y, target_pos.Z, true)
        end
      end
    else
      Log.Error("获取点位位置失败，点位名：", name)
      return
    end
  else
    local x, y, z = npc:get_pos()
    local hero_list = SceneMgr:get_hero_list()
    for _, hero in pairs(hero_list) do
      if hero and not hero:is_destroy() then
        hero:set_navigate_is_continue(is_continue)
        hero:navigate_to_pos(x, y, z, true)
      end
    end
  end
  self.v_is_show_navigator_fx = true
end

function M:clear_navigator_effect()
  self.v_is_show_navigator_fx = false
  Global.hero:clear_navigator_effect()
end

function M:get_is_navigating_by_logic()
  return self.v_is_show_navigator_fx
end

function M:get_continue_tp_room_params()
  return self.v_continue_tp_room_params
end

function M:hide_tp_point_effect(tp_dir)
  local tp_point = self.v_tp_points[tp_dir]
  if not tp_point then
    self.v_tp_invisible_cache[tp_dir] = true
    return
  end
  tp_point:set_visible(false)
end

function M:show_tp_point_effect(tp_dir)
  local tp_point = self.v_tp_points[tp_dir]
  if not tp_point then
    self.v_tp_invisible_cache[tp_dir] = nil
    return
  end
  tp_point:set_visible(true)
end

function M:set_scene_timeline_to_last_frame(path)
  local gameobj = _find_scene_obj("Root", path) or _find_scene_obj("GroupCtrlObj", path)
  local tl = gameobj:GetComponentInChildren(TypePlayableDirector)
  Util.assert(tl)
  tl.time = tl.duration
  tl:Evaluate()
end

function M:set_scene_obj_state(contanier_name, name_list, state_list)
  local container = SceneMgr:get_root_container()
  if not container then
    return
  end
  local interal_container_obj = container:Get(contanier_name)
  if not interal_container_obj or interal_container_obj:IsNull() then
    Log.Error("找不到物体", contanier_name)
    return
  end
  local internal_container = interal_container_obj:GetComponent(TypeSceneContainer)
  if not internal_container then
    Log.Error(contanier_name, "找不到SceneContainer")
    return
  end
  for index, name in ipairs(name_list) do
    internal_container:SetSceneObjState(name, state_list[index] or "0")
  end
end

function M:get_scene_ill()
  local effect = UnityFind("SceneEffect")
  if Util.is_nil(effect) then
    Log.Error("get SceneEffect failue!")
    return nil
  end
  local ill = effect:GetComponent(typeof(CS.SceneIllumination))
  if Util.is_nil(ill) then
    Log.Error("get SceneIllumination failue!")
    return nil
  end
  return ill
end

function M:set_fog_intensity(intensity)
  local ill = self:get_scene_ill()
  if not ill then
    return
  end
  ill:RecordFogParams()
  ill:SetFogIntensity(intensity)
end

function M:set_fog_start_height(start_height)
  local ill = self:get_scene_ill()
  if not ill then
    return
  end
  ill:RecordFogParams()
  ill:SetFogStartHeight(start_height)
end

function M:set_fog_start_distance(start_distance)
  local ill = self:get_scene_ill()
  if not ill then
    return
  end
  ill:RecordFogParams()
  ill:SetFogStartDistance(start_distance)
end

function M:reset_fog_params(is_clear_record)
  local ill = self:get_scene_ill()
  if not ill then
    return
  end
  ill:ResetFogParams(is_clear_record)
end

function M:set_scene_time_line_speed(path, speed)
  local object = _find_scene_obj("Root", path) or _find_scene_obj("GroupCtrlObj", path)
  if not object then
    Log.Error("not found, name = ", path)
    return
  end
  object.gameObject:SetActive(true)
  local pd = object:GetComponentInChildren(TypePlayableDirector)
  local scene_timeline = object.gameObject:TryAddComponent(TypeSpeedSceneTimeline)
  local time = pd.time
  scene_timeline:SetSpeed(speed, time)
  scene_timeline:PlaySceneTimeline(nil)
end

function M:get_scene_treasure_chest_logic()
  return "obj.functional_npc.challenge_npc"
end

function M:create_treasure_chest(msg)
  local data = msg.mm_obj
  local id = data.id
  local treasure_chest_cfg = ShareRes.create("episode_box.episode_box", id)
  if not treasure_chest_cfg then
    Log.Error("关卡宝箱表中找不到id", id)
    return
  end
  local x, y, z = self:get_pos_key_position(data.pos_key)
  Util.assert(x and y, "not exist pos key", data.pos_key)
  local rotation = self:get_pos_euler_angle(data.pos_key)
  if 0 == data.rotation then
    data.rotation = rotation.y
  end
  local create_sound = treasure_chest_cfg.BoxCreateSound
  if create_sound and "" ~= create_sound then
    Global.sound_mgr:play_sound_by_id(create_sound)
  end
  local luaobj = SceneMgr:create_treasure_chest(id, x, y, z, data.rotation, data, function(npc_lua)
    npc_lua:player_anim("idle")
  end)
  luaobj.cfg = treasure_chest_cfg
  luaobj.npc_contact_key = Util.format_str("treasure_chest_{1}", id)
  self.v_treasure_chest_map[id] = luaobj
end

function M:refresh_treasure_chest_state(msg)
  local data = msg.mm_obj
  if data.is_remove then
    self:remove_treasure_chest(data.id)
  else
    local npc = self:get_treasure_chest(data.id)
    npc.data.is_can_open = data.is_can_open
  end
end

function M:remove_treasure_chest(id)
  local npc = self:get_treasure_chest(id)
  if not npc then
    return
  end
  local treasure_chest_cfg = ShareRes.create("episode_box.episode_box", id)
  if treasure_chest_cfg and treasure_chest_cfg.TreasureChestType == CommonDefind.TREASURE_CHEST_TYPE.ENTITY then
    self.v_need_remove_entity_treasure_box[id] = npc
    return
  end
  SceneMgr:remove_functional_npc(npc)
  self.v_treasure_chest_map[id] = nil
end

function M:on_treasure_chest_open_finish(msg)
  local id = msg.mm_x
  local remove_npc = self.v_need_remove_entity_treasure_box[id]
  if not Util.is_destroy(remove_npc) then
    remove_npc:on_treasure_chest_close(function()
      local _remove_npc = self.v_need_remove_entity_treasure_box[id]
      if not Util.is_destroy(_remove_npc) then
        _remove_npc:get_gameobj():SetActive(false)
        self.v_remove_box_timer[id] = Timer:add_timer("on_treasure_chest_open_finish" .. tostring(id), 0.3, self.remove_entity_treasure_box, self, id)
      end
    end)
  end
end

function M:remove_entity_treasure_box(id)
  local remove_npc = self.v_need_remove_entity_treasure_box[id]
  self.v_need_remove_entity_treasure_box[id] = nil
  self.v_treasure_chest_map[id] = nil
  if Util.is_destroy(remove_npc) then
    return
  end
  SceneMgr:remove_functional_npc(remove_npc)
end

function M:get_tp_invisible_cache(tp_dir)
  local invisible = self.v_tp_invisible_cache[tp_dir]
  self.v_tp_invisible_cache[tp_dir] = nil
  return invisible
end

function M:recheck_hero_contact_npc()
  for id, _ in pairs(self.v_npc_contact) do
    self.v_npc_contact[id] = nil
  end
  self:hero_contact_npc(true)
end

return M
