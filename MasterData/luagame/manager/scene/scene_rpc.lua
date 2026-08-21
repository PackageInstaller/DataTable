local Behavior = require("manager.fight.behavior")
local CommonDefine = require("cs_share.common_define")
local Account = require("gamelogic.account.account")
local Vec3 = require("base.vec3")
local CommonDefind = require("cs_share.common_define")
local CAMPS = Global.config.CAMPS
local RELATIONSHIP = Global.config.RELATIONSHIP
local M = Util.create_class()

function M:_init(scene_mngr)
  self.v_scene_mngr = scene_mngr
end

function M:switch_gameobject_position(src_name, target_name)
  local scene_logic = self.v_scene_mngr:get_scene_logic()
  if scene_logic then
    scene_logic:switch_gameobject_position(src_name, target_name)
  else
    Log.Error("switch_gameobject_position with no scene logic：", Account:get_account())
  end
end

function M:remove_world_model(name)
  local scene_logic = self.v_scene_mngr:get_scene_logic()
  if scene_logic then
    scene_logic:remove_world_model(name)
  else
    Log.Error("remove_world_model with no scene logic：", Account:get_account())
  end
end

function M:create_world_model_on_position(object_name, name, pos_key, offset_y, face_pos_key, arg_map)
  local scene_logic = self.v_scene_mngr:get_scene_logic()
  if scene_logic then
    local euler_y
    if face_pos_key then
      euler_y = scene_logic:get_face_euler(pos_key, face_pos_key)
    end
    scene_logic:create_world_model_on_position(object_name, name, pos_key, offset_y, nil, euler_y, arg_map)
  else
    Log.Error("create_world_model_on_position with no scene logic：", Account:get_account(), object_name)
  end
end

function M:set_scene_tips(id, is_visible, param)
  Behavior.set_scene_tips(id, is_visible, param)
end

function M:set_ui_object_visible(ui_name, object_name, is_visible)
  Behavior.set_ui_object_visible(ui_name, object_name, is_visible)
  if is_visible then
    Behavior.remove_fight_ui_to_table(ui_name, object_name)
  else
    Behavior.add_fight_ui_to_table(ui_name, object_name)
  end
end

function M:lookat_position(npc_uuid, posx, posz, force)
  local npc = self.v_scene_mngr:pick_by_uuid(npc_uuid)
  if npc then
    npc:face_to_pos(posx, posz, force, true)
  else
    Log.Error("lookat_position with no scene npc：", Account:get_account(), npc_uuid)
  end
end

function M:draw_areas()
  local scene_logic = self.v_scene_mngr:get_scene_logic()
  if scene_logic then
    scene_logic:draw_areas()
  else
    Log.Error("draw_areas with no scene logic：", Account:get_account())
  end
end

function M:actvie_obstacle(key, tag, is_active)
  local scene_logic = self.v_scene_mngr:get_scene_logic()
  if scene_logic then
    scene_logic:actvie_obstacle(key, tag, is_active)
  else
    Log.Error("actvie_obstacle with no scene logic：", Account:get_account())
  end
end

function M:actvie_collider(obj_name, is_active, block_char, block_missile)
  local scene_logic = self.v_scene_mngr:get_scene_logic()
  if scene_logic then
    scene_logic:actvie_collider(obj_name, is_active, block_char, block_missile)
  else
    Log.Error("actvie_collider with no scene logic：", Account:get_account())
  end
end

function M:set_sceneobj_visible(path, is_visible, is_timeline_to_last_frame, is_save_state)
  if self.v_scene_mngr then
    local obj = self.v_scene_mngr:get_gameobject(path)
    self:set_save_state_scene_obj_component_visible(obj, is_save_state)
    self.v_scene_mngr:show_gameobject(path, is_visible)
  else
    Log.Error("set_sceneobj_visible with no v_scene_mngr：", Account:get_account())
  end
  if is_timeline_to_last_frame then
    local scene_logic = self.v_scene_mngr:get_scene_logic()
    if scene_logic then
      scene_logic:set_scene_timeline_to_last_frame(path)
    end
  end
end

function M:sync_save_sceneobj_visible_list(scene_obj_list)
  if not scene_obj_list then
    return
  end
  for path, info in pairs(scene_obj_list) do
    self:set_sceneobj_visible(path, info.visible, info.is_last_frame, true)
  end
end

function M:set_save_state_scene_obj_component_visible(obj, is_save_state)
  if Util.is_nil(obj) then
    return
  end
  local camera_timeline = obj:GetComponentInChildren(typeof(CS.CameraShakeTimeline))
  local timeline_track_audio = obj:GetComponentInChildren(typeof(CS.TimeLineTrackAudio))
  if not Util.is_nil(camera_timeline) then
    camera_timeline.enabled = not is_save_state
  end
  if not Util.is_nil(timeline_track_audio) then
    timeline_track_audio.enabled = not is_save_state
  end
end

function M:hide_scene_effect_status_obj(path)
  if self.v_scene_mngr then
    self.v_scene_mngr:hide_scene_effect_status_obj(path)
  else
    Log.Error("set_sceneobj_visible with no v_scene_mngr：", Account:get_account())
  end
end

function M:remove_area(key, tag)
  local scene_logic = self.v_scene_mngr:get_scene_logic()
  if scene_logic then
    scene_logic:remove_area(key, tag)
  else
    Log.Error("remove_area with no scene logic：", Account:get_account())
  end
end

function M:set_npc_level(npc_uuid, level, is_update_attr)
  local npc = self.v_scene_mngr:pick_by_uuid(npc_uuid)
  if npc then
    Behavior._set_npc_level(npc, level, is_update_attr)
  else
    Log.Error("set_npc_level with no scene npc：", Account:get_account(), npc_uuid)
  end
end

function M:cast_magic(npc_uuid, target_uuid, magic_id, level)
  local npc = self.v_scene_mngr:pick_by_uuid(npc_uuid)
  if not npc then
    Log.Error("cast_magic with no scene npc：", Account:get_account(), npc_uuid, magic_id, debug.traceback())
    return
  end
  local target = self.v_scene_mngr:pick_by_uuid(target_uuid)
  if not target then
    Log.Error("cast_magic with no scene target", Account:get_account(), target_uuid, magic_id, debug.traceback())
    return
  end
  target.magic_mgr:add_magic(npc, magic_id, nil, nil, level)
end

function M:cast_skill(npc_uuid, target_uuid, skill_id, targetx, targetz)
  local npc = self.v_scene_mngr:pick_by_uuid(npc_uuid)
  if not npc then
    Log.Error("cast_skill with no scene npc：", Account:get_account(), npc_uuid)
    return
  end
  local target = self.v_scene_mngr:pick_by_uuid(target_uuid)
  npc.skill_mgr:cast_skill(skill_id, target, targetx, nil, targetz)
end

function M:abort_magic_by_id(npc_uuid, magic_id)
  local npc = self.v_scene_mngr:pick_by_uuid(npc_uuid)
  if not npc then
    Log.Error("abort_magic_by_id with no scene npc：", Account:get_account(), npc_uuid, magic_id)
    return
  end
  npc.magic_mgr:remove_magic_by_id(magic_id)
end

function M:create_npc(npc_uuid, res_id, x, y, z, face_x, face_z, abs_camp, level, hp, npc_group, npc_name)
  local ext_args = {
    uuid = npc_uuid,
    cur_hp = hp,
    npc_group = npc_group,
    npc_name = npc_name
  }
  self.v_scene_mngr:create_npc(res_id, x, y, z, face_x, face_z, abs_camp, level, ext_args)
end

function M:create_npc_new(npc_uuid, res_id, x, y, z, dir, abs_camp, level, hp, npc_group, npc_name, params, magic_id, is_look_at_role, ai_group_id, ai_group, is_end_action, is_max_wave, event_key)
  local ext_args = {
    uuid = npc_uuid,
    cur_hp = hp,
    npc_group = npc_group,
    npc_name = npc_name,
    params = params,
    magic_id = magic_id,
    is_look_at_role = is_look_at_role,
    ai_group_id = ai_group_id,
    ai_group = ai_group,
    is_end_action = is_end_action,
    is_max_wave = is_max_wave,
    event_key = event_key
  }
  self.v_scene_mngr:create_npc_new(res_id, x, y, z, dir, abs_camp, level, ext_args)
end

function M:create_cd_npc(npc_uuid, res_id, x, y, z, dir, abs_camp, level, npc_name, npc_cd, hp, npc_group)
  local ext_args = {
    uuid = npc_uuid,
    cur_hp = hp,
    npc_group = npc_group,
    npc_name = npc_name
  }
  local npc = self.v_scene_mngr:create_npc_new(res_id, x, y, z, dir, Config.CAMPS.ENEMY, level, ext_args)
  npc.v_be_hit_cd = npc_cd
end

function M:add_npc_by_pos_key_old(uuid, self_camp, res_id, pos_key, arg_npc)
  local scene_map = SceneMgr:get_scene_map()
  if not scene_map then
    return
  end
  local position = scene_map:get_area_position(pos_key)
  local vec3_pos = Vec3.New(position.X + arg_npc.offset_x, position.Y, position.Z + arg_npc.offset_z)
  local tgt_position = scene_map:get_area_position(arg_npc.tgt_pos_key)
  local vec3_target = Vec3.New(tgt_position.X + arg_npc.tgt_offset_x, 0, tgt_position.Z + arg_npc.tgt_offset_z)
  local ext_args = {
    cur_hp = arg_npc.cur_hp,
    npc_group = arg_npc.npc_group,
    uuid = uuid
  }
  local abs_camp = self:get_camp(self_camp, arg_npc.camp)
  self.v_scene_mngr:create_npc(res_id, vec3_pos.x, vec3_pos.y, vec3_pos.z, vec3_target.x, vec3_target.z, abs_camp, arg_npc.level, ext_args)
end

function M:add_npc_by_pos_key(uuid, self_camp, res_id, pos_key, arg_npc)
  local scene_map = SceneMgr:get_scene_map()
  if not scene_map then
    return
  end
  local born_pos = arg_npc.born_pos
  local x, y, z = 0, 0, 0
  if born_pos and (0 ~= born_pos[1] or 0 ~= born_pos[2] or 0 ~= born_pos[3]) then
    x, y, z = born_pos[1], born_pos[2], born_pos[3]
  else
    local position = scene_map:get_area_position(pos_key)
    if nil == position then
      Log.Error("添加Npc失败！当前地图没有点位" .. pos_key)
    end
    x, y, z = position.X, position.Y, position.Z
  end
  local vec3_pos = Vec3.New(x + (arg_npc.offset_x or 0), y, z + (arg_npc.offset_z or 0))
  local ext_args = {
    cur_hp = arg_npc.cur_hp,
    npc_group = arg_npc.npc_group,
    uuid = uuid,
    params = arg_npc.npc_params,
    magic_id = arg_npc.magic_id,
    is_look_at_role = arg_npc.is_look_at_role,
    ai_group_id = arg_npc.ai_group_id,
    ai_group = arg_npc.ai_group,
    is_end_action = arg_npc.is_end_action,
    is_max_wave = arg_npc.is_max_wave,
    event_key = arg_npc.event_key
  }
  local abs_camp = self:get_camp(self_camp, arg_npc.camp)
  local npc = self.v_scene_mngr:create_npc_new(res_id, vec3_pos.x, vec3_pos.y, vec3_pos.z, arg_npc.rotation, abs_camp, arg_npc.level, ext_args)
  return npc
end

function M:add_cd_npc_by_pos_key(uuid, self_camp, res_id, pos_key, arg_npc)
  arg_npc.camp = RELATIONSHIP.OPPOSED
  local npc = self:add_npc_by_pos_key(uuid, self_camp, res_id, pos_key, arg_npc)
  if not npc then
    return
  end
  npc.v_be_hit_cd = arg_npc.npc_cd
  npc.v_npc_local_name = arg_npc.npc_name
end

function M:add_params_npc_by_pos_key(uuid, self_camp, res_id, pos_key, arg_npc)
  local npc = self:add_npc_by_pos_key(uuid, self_camp, res_id, pos_key, arg_npc)
  if not npc then
    return
  end
end

function M:get_camp(self_camp, relationship)
  local npc_camp
  if self_camp == CAMPS.FRIEND and relationship == RELATIONSHIP.SIMILAR or self_camp == CAMPS.ENEMY and relationship == RELATIONSHIP.OPPOSED then
    npc_camp = CAMPS.FRIEND
  elseif self_camp == CAMPS.FRIEND and relationship == RELATIONSHIP.OPPOSED or self_camp == CAMPS.ENEMY and relationship == RELATIONSHIP.SIMILAR then
    npc_camp = CAMPS.ENEMY
  end
  return npc_camp
end

function M:sync_scene_comm_info(npc_uuid, attr, npc_id)
  self.v_scene_mngr:set_god_npc_uuid(npc_uuid, attr, npc_id)
end

function M:remove_npc(npc_uuid)
  local npc = self.v_scene_mngr:pick_by_uuid(npc_uuid)
  if not npc then
    Log.Error("remove_npc with no scene npc：", Account:get_account(), npc_uuid)
    return
  end
  SceneMgr:remove_npc2(npc)
end

function M:on_npc_logic_stop(npc_uuid)
  local npc = self.v_scene_mngr:pick_by_uuid(npc_uuid)
  if not npc then
    Log.Error("remove_npc with no scene npc：", Account:get_account(), npc_uuid)
    return
  end
  npc.state_manager:stop_move()
end

function M:on_npc_logic_restart(npc_uuid)
  local npc = self.v_scene_mngr:pick_by_uuid(npc_uuid)
  if not npc then
    Log.Error("remove_npc with no scene npc：", Account:get_account(), npc_uuid)
    return
  end
  npc.state_manager:to_move_state()
end

function M:set_cam_default_angles(x, y, z, ease_in)
  Behavior.set_cam_default_angles(x, y, z, ease_in)
end

function M:set_cam_default_dist(dist)
  Behavior.set_cam_default_dist(dist)
end

function M:enter_main_scene()
  self.v_scene_mngr:on_enter_main_scene()
end

function M:enter_special_area(type)
  Global.log.Debug("enter special area ", type)
  local msg = MsgGame:mq_publish2(Const.MSG_TOG_SPECIAL_AREA)
  msg.mm_x = type
  msg.mm_y = true
end

function M:leave_special_area(type)
  local msg = MsgGame:mq_publish2(Const.MSG_TOG_SPECIAL_AREA)
  msg.mm_x = type
  msg.mm_y = false
end

function M:set_scene_camera(camera_id, not_clear_data, is_new_config, is_force_switch_cameramode, forbid_camera_blend)
  if Global.camera then
    Global.camera:set_scene_camera(camera_id, nil, true, not_clear_data, is_new_config, is_force_switch_cameramode, forbid_camera_blend)
  end
end

function M:set_cam_pinch_switch(is_open)
  if Global.camera then
    Global.camera:set_cam_pinch_switch(is_open)
  end
end

function M:enter_func_npc_area(type)
end

function M:leave_func_npc_area(type)
end

function M:add_functional_npc(npc_id, pos_key, face2_pos_key, is_get, mArgs)
  local rotation = face2_pos_key
  if type(rotation) == "string" then
    rotation = 0
  end
  local msg = MsgGame:mq_publish2(Const.MSG_CREATE_FUNCTIONAL_NPC)
  if not mArgs and not mArgs.name then
    mArgs.name = npc_id
  end
  msg.mm_obj = {
    npc_id = npc_id,
    pos_key = pos_key,
    rotation = rotation,
    is_get = is_get,
    mArgs = mArgs
  }
end

function M:create_notice_obstacle_effect(pos_key, effect_name, dir, euler_y)
  local scene_logic = self.v_scene_mngr:get_scene_logic()
  if scene_logic then
    scene_logic:create_notice_obstacle_effect(pos_key, effect_name, dir, euler_y)
  end
end

function M:clear_notice_obstacle_effect(pos_key)
  local scene_logic = self.v_scene_mngr:get_scene_logic()
  if scene_logic then
    scene_logic:clear_notice_obstacle_effect(pos_key)
  end
end

function M:on_hero_room_recover(is_new_floor)
  self.v_scene_mngr:on_hero_room_recover(is_new_floor)
end

function M:tower_settle()
  if TowerMgr then
    TowerMgr:tower_settle()
  end
end

function M:quit_scene()
  local function cb()
    Global.scene_mgr:on_enter_main_scene()
  end
  
  if TowerMgr then
    TowerMgr:on_exit_tower(cb)
  end
end

function M:moveto_npc(npc_uuid, target_uuid)
  local npc = self.v_scene_mngr:pick_by_uuid(npc_uuid)
  if not npc then
    Log.Error("moveto_npc with no scene npc：", Account:get_account(), npc_uuid)
    return
  end
  local target = self.v_scene_mngr:pick_by_uuid(target_uuid)
  if not target then
    Log.Error("moveto_npc with no scene target", Account:get_account(), target_uuid)
    return
  end
  npc.role_move_ctrl:move_to_target(target)
end

function M:move_to_pos(npc_uuid, pos)
  local npc = self.v_scene_mngr:pick_by_uuid(npc_uuid)
  if not npc then
    Log.Error("move_to_pos with no scene npc：", Account:get_account(), npc_uuid)
    return
  end
  npc.role_move_ctrl:move_to_postion(pos)
end

function M:move_by_dir(npc_uuid)
  local npc = self.v_scene_mngr:pick_by_uuid(npc_uuid)
  if not npc then
    Log.Error("move_by_dir with no scene npc：", Account:get_account(), npc_uuid)
    return
  end
  local vec_dir = npc:get_dir_vec()
  npc.state_manager:move_by_dir(vec_dir.x, vec_dir.z)
end

function M:switch_move_type(npc_uuid, move_type)
  local npc = self.v_scene_mngr:pick_by_uuid(npc_uuid)
  if not npc then
    Log.Error("switch_move_type with no scene npc：", Account:get_account(), npc_uuid)
    return
  end
  if npc:get_move_type() ~= move_type then
    npc:update_move_type(move_type)
    npc.state_manager:update_move_type()
  end
end

function M:stop_move(npc_uuid)
  local npc = self.v_scene_mngr:pick_by_uuid(npc_uuid)
  if not npc then
    Log.Error("stop_move with no scene npc：", Account:get_account(), npc_uuid)
    return
  end
  npc.state_manager:stop_move()
end

function M:clear_input(keycode)
  local msg = MsgGame:mq_publish2(Const.MSG_CLEAR_INPUT_KEY)
  msg.mm_x = keycode
end

function M:on_up_skill_btn(keycode, cancle)
  local msg = MsgGame:mq_publish2(Const.MSG_ON_UP_SKILL)
  msg.mm_x = keycode
  msg.mm_y = cancle
end

function M:start_guide(guide_id)
  if GuideMgr then
    GuideMgr:enter_guide(guide_id)
  end
end

function M:finish_guide(guide_id)
  if GuideMgr then
    GuideMgr:finish_guide(guide_id)
  end
end

function M:set_time_cut_tips(tips_id, is_start)
  local msg = MsgGame:mq_publish2(Const.MSG_ON_SET_TIME_CUT_TIPS)
  msg.mm_x = tips_id
  msg.mm_y = is_start
end

function M:remove_functional_npc(npcId)
  local scene_logic = SceneMgr:get_scene_logic()
  if not scene_logic then
    return
  end
  scene_logic:remove_functional_npc(npcId)
end

function M:set_functional_npc_visible(npcId, is_visible)
  local scene_logic = SceneMgr:get_scene_logic()
  if not scene_logic then
    return
  end
  scene_logic:set_func_npc_visible(npcId, is_visible)
end

function M:set_in_challenge(is_challenge)
  local fight_ui = UIMgr:try_get_visible_ui("fight")
  if fight_ui then
    fight_ui:set_map_visible(not is_challenge)
  end
end

function M:remove_tp(tp_name)
  local scene_logic = SceneMgr:get_scene_logic()
  if not scene_logic then
    return
  end
  scene_logic:remove_tp(tp_name)
end

function M:play_timeline(data)
  if not data then
    Log.Error("play_timeline's data param is nil!")
    return
  end
  TimeLineSeqPlayer.play_time_line_seq(data)
end

function M:play_simple_timeline(name, is_play)
  if is_play then
    SceneRoomPrefabLoader:load_prefab(name)
  else
    SceneRoomPrefabLoader:release_prefab(name)
  end
end

function M:play_video(data)
  if not data then
    Log.Error("play_video's data param is nil!")
    return
  end
  local video_data = {
    video_name = data.video,
    is_skip = data.is_can_skip,
    end_cb = function()
      SceneMgr:c2gs_call_scene("in_play_video_end", data.video)
      BehaviorMgr:call_scene_logic_event_fun("in_play_video_end", data.video)
    end
  }
  VideoMgr:on_play_video(video_data)
end

function M:stop_timeline(name)
  TimeLineSeqPlayer.stop()
end

function M:create_scene_effect(prefab_name, position, duration, obj_name)
  SceneMgr:create_scene_effect(prefab_name, position, duration, obj_name)
end

function M:remove_scene_effect(obj_name)
  SceneMgr:remove_scene_effect(obj_name)
end

function M:set_force_use_bag(can_use)
  FightBagMgr:set_force_use_bag(can_use)
end

function M:open_sync_api_id_map(api_type_tb)
  if api_type_tb[CommonDefine.SYNC_API_TYPE.on_skill_hit] then
    local tower = TowerMgr:get_tower()
    if tower then
      local room = tower:get_room()
      room:set_is_upload_skill_hit(true)
    end
  end
end

function M:set_sync_var(key, value)
  BehaviorShareMgr:sync_s2c(key, value)
end

function M:set_map_visible(visible)
  local fight_ui = UIMgr:try_get_visible_ui("fight")
  if fight_ui then
    fight_ui:set_map_visible(visible, true)
  end
end

function M:force_finish_cur_guide()
  if GuideMgr then
    GuideMgr:force_finish_cur_guide()
  end
end

function M:trigger_fight_story(story_id)
  UIMgr:get_ui("uifight_story"):ui_show(story_id)
end

function M:set_camera_focus_pos(is_clear, pos_key, speed)
  if Global.camera then
    Global.camera:set_camera_focus_pos(is_clear, pos_key, speed)
  end
end

function M:play_story(story_id, arg_params)
  Log.Info("play_story", story_id, arg_params)
  local is_settle_story = arg_params and arg_params.is_settle_story
  if is_settle_story then
    StoryMgr:set_settle_story(story_id)
  end
  if nil == arg_params or not arg_params.enable_black_fade then
    if StoryMgr then
      StoryMgr:on_start(story_id, nil, arg_params and arg_params.is_delay_destroy, nil, arg_params and arg_params.no_skip_story, nil, arg_params and arg_params.is_settle_story)
    end
  else
    local play_fade_in_time = arg_params.play_fade_in_time or 0
    local play_stay_time = arg_params.play_stay_time or 0
    local play_fade_out_time = arg_params.play_fade_out_time or 0
    local stop_fade_in_time = arg_params.stop_fade_in_time or 0
    local stop_stay_time = arg_params.stop_stay_time or 0
    local stop_fade_out_time = arg_params.stop_fade_out_time or 0
    local stop_arg_params = {}
    stop_arg_params.stop_fade_in_time = stop_fade_in_time
    stop_arg_params.stop_stay_time = stop_stay_time
    stop_arg_params.stop_fade_out_time = stop_fade_out_time
    StoryMgr:set_story_stop_arg_params(stop_arg_params)
    if play_fade_in_time > 0 or play_fade_out_time > 0 then
      UIMgr:get_ui("ui_blackfade"):ui_show(play_fade_in_time, play_stay_time, play_fade_out_time, function()
        if StoryMgr then
          StoryMgr:on_start(story_id, nil, arg_params.is_delay_destroy, nil, arg_params.no_skip_story, nil, arg_params.is_settle_story)
        end
      end)
    elseif StoryMgr then
      StoryMgr:on_start(story_id, nil, arg_params.is_delay_destroy, nil, arg_params.no_skip_story, nil, arg_params.is_settle_story)
    end
  end
end

function M:set_plat_active(name, is_active)
end

function M:move_plat_to_pos(name, pos_key, speed)
end

function M:update_plat_movement(name, is_move, anim)
  if SceneMgr then
    SceneMgr:get_plat_mgr():update_plat_movement(name, is_move, anim)
  end
end

function M:update_plat_moved(name, anim)
  if SceneMgr then
    SceneMgr:get_plat_mgr():update_plat_moved(name, anim)
  end
end

function M:create_random_room_out_door(object_name, name, pos_key, offset_y, face_pos_key)
  local scene_logic = self.v_scene_mngr:get_scene_logic()
  if scene_logic then
    scene_logic:create_random_room_out_door(object_name, name, pos_key, offset_y, face_pos_key)
  else
    Log.Error("create_world_model_on_position with no scene logic：", Account:get_account(), object_name)
  end
end

function M:start_texture_guide(group_id)
  if GraphicGuideMgr then
    GraphicGuideMgr:init(group_id)
  end
end

function M:hide_task_line(is_hide)
  if not Global.hero then
    return
  end
  if is_hide then
    Global.hero:clear_navigator_effect()
  else
    Global.hero:create_navigator_effect()
  end
end

function M:set_mapview_transmit(is_can_transmit)
  TowerMgr.v_is_can_transmit = is_can_transmit
end

function M:enable_god_skill(is_enable)
  TowerMgr:enable_god_skill(is_enable)
end

function M:appoint_char_appear()
end

function M:skip_finish_anim(is_skip)
  if not TowerMgr then
    return
  end
  local tower = TowerMgr:get_tower()
  if not tower then
    return
  end
  tower:play_fight_end_anim_state(not is_skip)
end

function M:transmit_npc(npc_uuid, target_pos_key, face_pos_key, transition)
  if not SceneMgr then
    return
  end
  local npc = SceneMgr:pick_by_uuid(npc_uuid)
  if not npc then
    return
  end
  npc:on_transmit_pos(target_pos_key, face_pos_key, transition)
end

function M:transmit_npc_new(npc_uuid, target_pos_key, face_angle, transition)
  if not SceneMgr then
    return
  end
  local npc = SceneMgr:pick_by_uuid(npc_uuid)
  if not npc then
    return
  end
  npc:on_transmit_pos_new(target_pos_key, face_angle, transition)
end

function M:switch_fight_bgm(bgm_name, volume, fadeout_time)
  if not Global.sound_mgr then
    return
  end
  Global.sound_mgr:switch_fight_bgm(bgm_name, volume, fadeout_time)
end

function M:set_source_volume(source_type, lerp_time, target_volume)
  if not Global.sound_mgr then
    return
  end
  Global.sound_mgr:set_source_volume(source_type, lerp_time, target_volume)
end

function M:play_common_sound(sound_name)
  if not Global.sound_mgr then
    return
  end
  Global.sound_mgr:play_common_sound(sound_name)
end

function M:start_play_bgm(change_time)
  if not Global.sound_mgr then
    return
  end
  Global.sound_mgr:start_play_bgm(change_time)
end

function M:stop_play_bgm(change_time)
  if not Global.sound_mgr then
    return
  end
  Global.sound_mgr:stop_play_bgm(change_time)
end

function M:switch_play_bgm(bgm_name)
  if not Global.sound_mgr then
    return
  end
  Global.sound_mgr:switch_play_bgm(bgm_name)
end

function M:start_environment_bgm(change_time)
  if not Global.sound_mgr then
    return
  end
  Global.sound_mgr:start_environment_bgm(change_time)
end

function M:stop_environment_bgm(change_time)
  if not Global.sound_mgr then
    return
  end
  Global.sound_mgr:stop_environment_bgm(change_time)
end

function M:switch_environment_bgm(change_time, bgm_name)
  if not Global.sound_mgr then
    return
  end
  Global.sound_mgr:switch_environment_bgm(change_time, bgm_name)
end

function M:play_desc_story(story_id)
  UIMgr:get_ui("desc_story"):ui_show(story_id)
end

function M:curse_time_start()
  if TowerMgr then
    local fight_info = TowerMgr:get_fight_info()
    if fight_info and fight_info.type == CommonDefine.CHALLENGE_TYPE.CURSE_CIRCLE then
      MsgGame:mq_publish2(Const.MSG_ON_CURSE_TIME_START)
    end
  end
end

function M:show_finger_scale_guide()
  if UIMgr then
    UIMgr:get_ui("ui_finger_guide"):ui_show()
  end
end

function M:cancel_footmark()
  if not TowerMgr then
    return
  end
  local room = TowerMgr:get_cur_room()
  if not room then
    return
  end
  room:cancel_footmark()
end

function M:hide_npc(npc_uuid)
  local npc = self.v_scene_mngr:pick_by_uuid(npc_uuid)
  if nil ~= npc then
    npc:set_obj_enable(false)
  end
end

function M:show_npc(npc_uuid)
  local npc = self.v_scene_mngr:pick_by_uuid(npc_uuid)
  if nil ~= npc then
    npc:set_obj_enable(true)
  end
end

function M:stop_story()
  if StoryMgr then
    StoryMgr:stop_story()
  end
end

function M:start_count_down(end_time)
  GeCaoBattleMgr:count_down_start(end_time)
end

function M:start_fight_timer(use_time)
  FightDataMgr:start_fight_timer(use_time)
  local is_need_open_ge_cao_ui = TowerMgr:is_need_default_fight_timer()
  if is_need_open_ge_cao_ui then
    GeCaoBattleMgr:start_timer(use_time)
  end
  local fight_type = TowerMgr:get_tower_type()
  if fight_type == CommonDefind.CHALLENGE_TYPE.ACTIVITY_MINESWEEPER then
    MineSweeperBattleMgr:start_timer(use_time)
  end
  SceneMgr:c2gs_call_scene("check_timing_start_time", Date.server_time())
end

function M:stop_fight_timer()
  FightDataMgr:stop_fight_timer()
  GeCaoBattleMgr:stop_timer()
end

function M:total_monster_wave(num)
  GeCaoBattleMgr:refresh_total_wave(num)
end

function M:current_monster_wave(num, ui_style_type)
  if 1 == ui_style_type then
    GeCaoBattleMgr:refresh_right_wave(num)
    WeeklyMgr:set_weekly_fight_wave_num(num)
  else
    GeCaoBattleMgr:refresh_current_wave(num)
  end
end

function M:broadcast_monster_count(total_count)
  GeCaoBattleMgr:refresh_right_wave(self.m_nMonsterCount, 1)
end

function M:add_text_collection(id)
  UIMgr:get_ui("collection_tip"):ui_show(id)
end

function M:update_functional_npc_data(npc_id, pos_key, face2_pos_key, is_get, mArgs)
  local scene_logic = self.v_scene_mngr:get_scene_logic()
  if scene_logic then
    scene_logic:update_functional_npc_data(npc_id, pos_key, face2_pos_key, is_get, mArgs)
  else
    Log.Error("update_functional_npc_data with no scene logic：", Account:get_account())
  end
end

function M:update_functional_npc_interaction_status(npc_id, is_get)
  local scene_logic = self.v_scene_mngr:get_scene_logic()
  if scene_logic then
    scene_logic:update_functional_npc_interaction_status(npc_id, is_get)
  else
    Log.Error("update_functional_npc_status with no scene logic：", Account:get_account())
  end
end

function M:play_reversible_scene_timeline(path, plat_names, rewind_time, to_last_frame)
  if not self.v_scene_mngr then
    return
  end
  local logic = self.v_scene_mngr:get_scene_logic()
  if not logic then
    return
  end
  logic:play_scene_time_line_back_foward(path, rewind_time, to_last_frame)
  if plat_names then
    local split = Util.split_str(plat_names, ",")
    for _, name in pairs(split) do
      self.v_scene_mngr:get_plat_mgr():set_is_moving(name)
    end
  end
end

function M:play_scene_timeline(path, plat_list)
  if not self.v_scene_mngr then
    return
  end
  local logic = self.v_scene_mngr:get_scene_logic()
  if not logic then
    return
  end
  logic:play_scene_timeline(path)
  if not plat_list or 0 == #plat_list then
    return
  end
  for i, plat_name in pairs(plat_list) do
    local split = Util.split_str(plat_name, ",")
    for _, name in pairs(split) do
      self.v_scene_mngr:get_plat_mgr():set_is_moving(name)
    end
  end
end

function M:tp_revive_room(floor_idx, room_num, src_tp_dir, pack_info, pos_key)
  if not ChapterMgr then
    return
  end
  local resp = {}
  resp.floor_idx = floor_idx
  resp.room_num = room_num
  resp.src_tp_dir = src_tp_dir
  resp.pack_info = pack_info
  resp.pos_key = pos_key
  ChapterMgr:tp_revive_room(resp)
end

function M:set_player_control_on()
  SceneMgr:set_player_control_on()
  local fight_ui = UIMgr:try_get_loaded_ui("fight")
  if fight_ui then
    fight_ui:set_main_interactable(true)
  end
end

function M:set_player_control_off()
  SceneMgr:set_player_control_off()
  local fight_ui = UIMgr:try_get_loaded_ui("fight")
  if fight_ui then
    fight_ui:set_main_interactable(false)
  end
end

function M:black_fade_anim(fade_in_time, hold_time, fade_out_time)
  UIMgr:get_ui("ui_blackfade"):ui_show(fade_in_time, hold_time, fade_out_time)
end

function M:set_camera_focus(name, is_open, camera_style, duration)
  if false == is_open then
    self:set_camera_no_focus()
    return
  end
  local npc = SceneMgr and SceneMgr:get_npc_by_name(name)
  local pos
  if not npc then
    local scene_map = SceneMgr:get_scene_map()
    if not scene_map then
      return
    end
    local target_pos = scene_map:get_area_position(name)
    pos = Vec3.New(target_pos.X, target_pos.Y, target_pos.Z)
  end
  local temp_table = self.v_scene_mngr:get_camera_focus_params()
  local param = {
    temp_table[1],
    temp_table[2],
    temp_table[3],
    temp_table[4],
    temp_table[5],
    nil,
    npc,
    pos,
    camera_style
  }
  if not pos and not npc then
    Log.Error("找不到命名为", name, "的点位或npc")
    return
  end
  if Global.camera then
    Global.camera:change_follow_target2(3, param)
    if duration and duration > 0 then
      Timer:add_timer("hide_camera_focus", duration, function()
        self:set_camera_no_focus()
      end)
    end
  end
end

function M:set_camera_no_focus()
  if Global.camera then
    Global.camera:change_follow_target2(0)
  end
end

function M:set_battle_task_show_state(is_visible, valid_in_tower)
  local fight_ui = UIMgr:try_get_visible_ui("fight")
  if fight_ui then
    local tower = TowerMgr and TowerMgr:get_tower()
    if tower then
      tower:set_is_show_battle_task(is_visible, valid_in_tower)
    end
    fight_ui:update_battle_task_visible(is_visible)
  end
end

function M:destroy_unit_group(group_id)
  if not SceneMgr then
    return
  end
  SceneMgr:remove_npc_npc_by_group_id(group_id)
end

function M:start_ct_timer(seconds, text)
  UIMgr:get_ui("ui_ct_timer"):ui_show(seconds, text)
end

function M:hide_ct_timer()
  UIMgr:try_hide_ui("ui_ct_timer")
end

function M:clear_all_monster()
  if not SceneMgr then
    return
  end
  SceneMgr:get_scene_logic():remove_all_monster_silently()
end

function M:create_navigator_effect(name, is_open, is_continue)
  if not SceneMgr then
    return
  end
  if false == is_open then
    self:clear_navigator_effect()
    return
  end
  local logic = SceneMgr:get_scene_logic()
  logic:create_navigator_effect(name, is_continue)
end

function M:clear_navigator_effect()
  if not SceneMgr then
    return
  end
  local logic = SceneMgr:get_scene_logic()
  logic:clear_navigator_effect()
end

function M:hide_tp_point_effect(tp_dir)
  if not SceneMgr then
    return
  end
  local logic = SceneMgr:get_scene_logic()
  logic:hide_tp_point_effect(tp_dir)
end

function M:show_tp_point_effect(tp_dir)
  if not SceneMgr then
    return
  end
  local logic = SceneMgr:get_scene_logic()
  logic:show_tp_point_effect(tp_dir)
end

function M:set_empty_wall_visible(tag, is_visible)
  local scene_map = self.v_scene_mngr:get_scene_map()
  if not scene_map then
    return
  end
  scene_map:set_empty_wall_visible(tag, is_visible)
  Log.Info("开启空气墙", tag, is_visible)
  scene_map:set_empty_wall_group_visible(tag, is_visible)
  Log.Info("关闭空气墙组", tag, is_visible)
end

function M:close_fight_air_wave_group(group_id)
  local scene_map = self.v_scene_mngr:get_scene_map()
  if not scene_map then
    return
  end
  scene_map:set_empty_wall_group_visible(group_id, false)
  Log.Info("关闭空气墙组", group_id, false)
end

function M:open_fight_air_wave_group(group_id)
  local scene_map = self.v_scene_mngr:get_scene_map()
  if not scene_map then
    return
  end
  scene_map:set_empty_wall_group_visible(group_id, true)
  Log.Info("关闭空气墙组", group_id, true)
end

function M:set_cd_npc_can_hit(npc_name, cant_be_hit)
  local npc = SceneMgr:get_npc_by_name(npc_name)
  Util.assert(npc)
  local collider = npc:get_collider()
  if not collider then
    Timer:add_timer("set_npc_hit_state" .. npc_name .. tostring(cant_be_hit), 0.2, function()
      collider = npc:get_collider()
      npc:set_can_searched(not cant_be_hit)
      if collider then
        collider.enabled = not cant_be_hit
      end
    end)
  else
    npc:set_can_searched(not cant_be_hit)
    collider.enabled = not cant_be_hit
  end
end

function M:set_room_collider_visible(index, is_visible, room_collider_name)
  local CSSceneIllumination = CS.SceneIllumination
  CSSceneIllumination.SetRoomColliderVisible(index, is_visible, room_collider_name)
end

function M:show_tips_banner(is_open, duration, tips)
  local ui_fight = UIMgr:try_get_ui("fight")
  if not ui_fight then
    return
  end
  if not is_open then
    ui_fight:hide_dbm_with_banner()
    return
  end
  ui_fight:show_dbm_with_banner(tips, duration, 1)
end

function M:set_scene_obj_state(contanier_name, name_list, state_list)
  if not name_list then
    return
  end
  if not state_list then
    return
  end
  local scene_logic = self.v_scene_mngr:get_scene_logic()
  scene_logic:set_scene_obj_state(contanier_name, name_list, state_list)
end

function M:set_navigator_state(state_info_list)
  if not state_info_list then
    return
  end
  if not SceneMgr or not SceneMgr:get_hero_list() then
    return
  end
  local hero_list = SceneMgr:get_hero_list()
  for key, hero in pairs(hero_list) do
    if not Util.is_destroy(hero) then
      hero:change_navi_arrows_info(state_info_list)
    end
  end
end

function M:change_functional_npc_action(npc_id, action_name)
  if FunctionalNpcMgr then
    FunctionalNpcMgr:change_functional_npc_action(npc_id, action_name)
  end
end

function M:set_fog_intensity(intensity)
  local scene_logic = self.v_scene_mngr:get_scene_logic()
  scene_logic:set_fog_intensity(intensity)
end

function M:add_scene_npc(obj_name, level_obj_name, npcid, status, abs_camp, level, penetrable, uuid)
  self.v_scene_mngr:add_scene_npc(level_obj_name, obj_name, npcid, abs_camp, level, status, penetrable, uuid)
end

function M:cast_custom_event_magic(uuid, event_type, arg)
  local ext_args = {
    arg = {type = event_type, arg = arg}
  }
  local hero = SceneMgr:get_hero_by_uuid(uuid)
  if hero then
    hero.magic_mgr:add_magic(hero, Config.CUSTOM_MAGIC, nil, nil, 1, nil, ext_args)
  end
end

function M:open_progress_display(init_value, curr_room__final_value, all_room_final_value, up_speed, is_need_anim, up_interval)
  if not Global.ui_dynamic_canvas then
    return
  end
  Global.ui_dynamic_canvas:on_progress_display_open(init_value, curr_room__final_value, all_room_final_value, up_speed, is_need_anim, up_interval)
end

function M:close_progress_display(is_need_anim)
  if not Global.ui_dynamic_canvas then
    return
  end
  Global.ui_dynamic_canvas:on_progress_display_close(is_need_anim)
end

function M:update_progress_display(up_value)
  if not Global.ui_dynamic_canvas then
    return
  end
  Global.ui_dynamic_canvas:on_progress_display_update(up_value)
end

function M:relive_hero_uuid(relive_uuid_list, remain_hp_percent)
  Global.log.Debug("reborn all ok")
  if TowerMgr then
    local tower = TowerMgr:get_tower()
    if tower then
      local attr_ratio_map = {
        [Config.CHAR_ATTR_TYPE.CHAR_HP] = remain_hp_percent
      }
      for key, relive_uuid in pairs(relive_uuid_list) do
        tower:reborn_npc_by_buff(relive_uuid, attr_ratio_map)
      end
      MsgGame:mq_publish2(Const.MSG_ON_ALL_HERO_REBORN_END)
    end
  end
end

function M:set_camera_far_clip_plane(value)
  if Global.camera then
    Global.camera:set_camera_far_clip(value)
  end
end

function M:set_camera_far_clip_plane_default()
  if Global.camera then
    Global.camera:reset_camera_far_clip()
  end
end

function M:behavior_data(data)
  local scene_logic_runner = SceneMgr and SceneMgr:get_scene_logic_runner()
  if scene_logic_runner then
    scene_logic_runner:load_variable(data)
  end
end

function M:sync_tower_var(data)
  local scene_logic_runner = SceneMgr and SceneMgr:get_scene_logic_runner()
  if scene_logic_runner then
    scene_logic_runner:sync_tower_var(data)
  end
end

function M:sync_remove_tp_point(data)
  local scene_logic_runner = SceneMgr and SceneMgr:get_scene_logic_runner()
  if scene_logic_runner then
    scene_logic_runner:sync_remove_tp_point(data)
  end
end

function M:sync_remove_area(data)
  local scene_logic_runner = SceneMgr and SceneMgr:get_scene_logic_runner()
  if scene_logic_runner then
    scene_logic_runner:sync_remove_area(data)
  end
end

function M:sync_update_plat_moved(data)
  local scene_logic_runner = SceneMgr and SceneMgr:get_scene_logic_runner()
  if scene_logic_runner then
    scene_logic_runner:sync_update_plat_moved(data)
  end
end

function M:sync_hide_scene_effect_status_obj(data)
  local scene_logic_runner = SceneMgr and SceneMgr:get_scene_logic_runner()
  if scene_logic_runner then
    scene_logic_runner:sync_hide_scene_effect_status_obj(data)
  end
end

function M:sync_server_save_npc_data(data)
  local scene_logic_runner = SceneMgr and SceneMgr:get_scene_logic_runner()
  if scene_logic_runner then
    scene_logic_runner:sync_server_save_npc_data(data)
  end
end

function M:sync_custom_variable(data)
  local scene_logic_runner = SceneMgr and SceneMgr:get_scene_logic_runner()
  if scene_logic_runner and scene_logic_runner.sync_custom_variable then
    scene_logic_runner:sync_custom_variable(data)
  end
end

function M:sync_forever_variable_list(data)
  local scene_logic_runner = SceneMgr and SceneMgr:get_scene_logic_runner()
  if scene_logic_runner and scene_logic_runner.sync_forever_variable then
    scene_logic_runner:sync_forever_variable(data)
  end
end

function M:on_pick_func_npc_all_reward(npc_id)
  local scene_logic_runner = SceneMgr and SceneMgr:get_scene_logic_runner()
  if scene_logic_runner and scene_logic_runner.on_pick_func_npc_all_reward then
    scene_logic_runner:on_pick_func_npc_all_reward(npc_id)
  end
end

function M:on_npc_show_end(npc_id, npc_type)
  local scene_logic_runner = SceneMgr and SceneMgr:get_scene_logic_runner()
  if scene_logic_runner and scene_logic_runner.on_npc_show_end then
    scene_logic_runner:on_npc_show_end(npc_id, npc_type)
  end
end

function M:on_nofight_game_start(npc_id)
  local scene_logic_runner = SceneMgr and SceneMgr:get_scene_logic_runner()
  if scene_logic_runner and scene_logic_runner.on_nofight_game_start then
    scene_logic_runner:on_nofight_game_start(npc_id)
  end
end

function M:on_quit_nofight_game(npc_id)
  local scene_logic_runner = SceneMgr and SceneMgr:get_scene_logic_runner()
  if scene_logic_runner and scene_logic_runner.on_quit_nofight_game then
    scene_logic_runner:on_quit_nofight_game(npc_id)
  end
end

function M:on_npc_choose(choose_index, server_event_path)
  local scene_logic_runner = SceneMgr and SceneMgr:get_scene_logic_runner()
  if scene_logic_runner and scene_logic_runner.on_npc_choose then
    scene_logic_runner:on_npc_choose(choose_index, server_event_path)
  end
end

function M:run_func_module(event_name)
  local scene_logic_runner = SceneMgr and SceneMgr:get_scene_logic_runner()
  if scene_logic_runner and scene_logic_runner.RunFuncModule then
    scene_logic_runner:RunFuncModule(event_name)
  end
end

function M:set_scene_timeline_speed(timeline_obj_path, speed)
  Behavior.set_scene_timeline_speed(timeline_obj_path, speed)
end

function M:set_scene_plat_speed(plat_name, speed, anim_name, is_move)
  Behavior.set_scene_plat_speed(plat_name, speed, anim_name, is_move)
end

function M:exhibition_npc_list(list)
  for key, data in pairs(list) do
    if not data then
    else
      data.npc_type = CommonDefind.FUNCTIONAL_NPC_TYPE.EXHIBITION
      data.is_new_interact_npc = true
      self:add_functional_npc(data.npc_name, data.pos_key, data.rotation, false, data)
    end
  end
end

function M:exhibition_npc_update(data)
  if not data then
    return
  end
  data.npc_type = CommonDefind.FUNCTIONAL_NPC_TYPE.EXHIBITION
  data.is_new_interact_npc = true
  local scene_logic = self.v_scene_mngr:get_scene_logic()
  if scene_logic:check_function_npc_is_added(data.npc_name) then
    scene_logic:update_functional_npc_data(data.npc_name, data.pos_key, data.rotation, true, data)
  else
    self:add_functional_npc(data.npc_name, data.pos_key, data.rotation, false, data)
  end
end

function M:exhibition_npc_remove(npc_name)
  if not npc_name then
    return
  end
  local scene_logic = self.v_scene_mngr:get_scene_logic()
  scene_logic:remove_functional_npc(npc_name, true)
end

function M:sync_restore_data(data)
  if not data then
    return
  end
  if data.blow_count then
    TowerMgr:check_tower_task_update(CommonDefine.TOWER_TASK_TYPE.TOWER_BLOW_CNT, true, data.blow_count)
  end
  if data.damage_count then
    TowerMgr:check_tower_task_update(CommonDefine.TOWER_TASK_TYPE.NO_SKILL, true, data.damage_count)
  end
end

function M:add_episode_box(body)
  if not body then
    return
  end
  if body.status == CommonDefine.BATTLE_EPISODE_BOX_STATE.ALREADY_INTERACTIVE then
    return
  end
  local msg = MsgGame:mq_publish2(Const.MSG_CREATE_TREASURE_CHEST)
  msg.mm_obj = {
    id = body.id,
    pos_key = body.pos_key,
    rotation = body.rotation,
    is_play_effect_and_audio = body.is_play_effect_and_audio,
    is_can_open = body.status == CommonDefine.BATTLE_EPISODE_BOX_STATE.OPEN_INTERACTIVE,
    custom_event_name = body.custom_event_name
  }
end

function M:update_episode_box_status(body, award_list)
  if not body then
    return
  end
  if award_list then
    local msg = MsgGame:mq_publish2(Const.MSG_ON_TREASURE_CHEST_AWARD_WIN_OPEN)
    msg.mm_x = body.id
    msg.mm_obj = award_list
  end
  if body.status == CommonDefine.BATTLE_EPISODE_BOX_STATE.ALREADY_INTERACTIVE then
    local scene_logic = self.v_scene_mngr:get_scene_logic()
    scene_logic:remove_treasure_chest(body.id)
    return
  end
  local msg = MsgGame:mq_publish2(Const.MSG_REFRESH_TREASURE_CHEST_STATE)
  msg.mm_obj = {
    id = body.id,
    is_can_open = body.status == CommonDefine.BATTLE_EPISODE_BOX_STATE.OPEN_INTERACTIVE
  }
end

function M:room_pass_status(status)
  local tower = TowerMgr:get_tower()
  if tower then
    tower:set_room_pass_status(status)
  end
end

return M
