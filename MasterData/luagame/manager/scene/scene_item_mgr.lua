local ResPool = Global.res_pool_mgr
local ccd = require("uimodule.stage_activity.challenge_ring_plus.curse_common_define")
local DROP_ITEM_EFFECT_NAME = ccd.DROP_ITEM_EFFECT_NAME
local Vec3 = require("base.vec3")
local Quat = require("base.quat")
local BURST_EFFECT_NAME = DROP_ITEM_EFFECT_NAME.FX_TREASURE_ITEM1
local ITEM_TO_EFFECT_NAME = {
  [500001] = DROP_ITEM_EFFECT_NAME.FX_DROP_JINBI
}
local AUTO_PICK_ITEM_MAP = {
  [541000] = true,
  [500001] = true
}
local _sin = math.sin
local DROP_MIN = 3
local DROP_MAX = 5
local TypeMeshRenderer = typeof(UnityEngine.MeshRenderer)
local FX_DROP2HERO = "Fx_drop_01"
local DROP_TYPE = Config.DROP_TYPE
local _insert = table.insert
local mathx = require("base.mathx")
local _drop_curvey = mathx.item_fly_curvey
local ANIM_SPEED = 1.8
local CommonDefine = require("cs_share.common_define")
local RUNE2_SOURCE = CommonDefine.RUNE2_SOURCE
local SCENE_ITEM_TYPE = {BREAKABLE = 1, ENERGY_BALL = 2}
local GET_ITEM_CB = {
  [SCENE_ITEM_TYPE.BREAKABLE] = "get_breakable_item",
  [SCENE_ITEM_TYPE.ENERGY_BALL] = "get_energy_ball"
}
local ALMOST_ZERO_CB = {
  [SCENE_ITEM_TYPE.BREAKABLE] = "on_breakable_item_almost_zero",
  [SCENE_ITEM_TYPE.ENERGY_BALL] = "on_energy_ball_almost_zero"
}
local SCENE_ITEM_DROP_TYPE = Config.SCENE_ITEM_DROP_TYPE
local drop_quality_light = {
  [1] = "Fx_UI_battle_treasure_light_wh",
  [2] = "Fx_UI_battle_treasure_light_gn",
  [3] = "Fx_UI_battle_treasure_light_bu",
  [4] = "Fx_UI_battle_treasure_light_vt",
  [5] = "Fx_UI_battle_treasure_light_gld"
}
local M = Util.create_class()
M.ITEM_STATE = {
  CREATED = 0,
  DROPING = 1,
  DROPED = 2,
  FLYING = 3,
  GETTING = 4,
  END = 5,
  PAUSE = 6
}
local ITEM_STATE = M.ITEM_STATE

local function set_to_state(item, state, force)
  if item.state + 1 == state or force then
    item.state = state
  end
  if state == ITEM_STATE.END and item.item_obj and not item.item_obj:IsNull() then
    item.item_obj:SetActive(false)
  end
end

local IDX = 0

local function get_idx()
  IDX = IDX + 1
  return IDX
end

function M:_init()
  self.v_is_release = false
  self.v_item_infos = {}
  self.v_need_pick_item_counts = {}
  self.v_drop_effect_id = {}
  self.v_scene_map = nil
  self.v_msg_handles = {}
  self.v_timer = {}
  self:register_event()
  self.v_drop_anim_sequence = {}
  self.award_points = {}
  self.npc_drop_points = {}
  self.breakable_drop_points = {}
  self.v_breakable_item_infos = {}
  self.v_energy_ball_list = {}
  self:init_ball_move_param()
  if not Util.is_client_only() then
    local tower = TowerMgr:get_tower()
    if tower then
      self.v_cur_room = tower:get_room_num()
    end
  end
end

function M:register_event()
  Util.bind_msg(self, Const.MSG_ON_ENTER_ROOM, self.on_enter_room, self)
  Util.bind_msg(self, Const.MSG_ON_LEAVE_ROOM, self.on_leave_room, self)
  Util.bind_msg(self, Const.MSG_ON_ENTER_NEW_FLOOR, self.clear_room_points, self)
  Util.bind_msg(self, Const.MSG_CHANGE_AUTO_PICK, self.on_change_auto_pick, self)
end

function M:remove_all_timer()
  for _, timer_idx in pairs(self.v_timer) do
    Timer:remove_timer(timer_idx)
  end
  self.v_timer = {}
end

function M:release()
  self.v_is_release = true
  Util.unbind_all_msg(self)
  self:clear_item_obj_list()
  self:remove_all_timer()
  self:clear_play_anim()
  self:clear_room_points()
  self:clear_energy_ball()
  self.v_is_get_breakable = false
end

function M:clear_award_points(clear_cur_room)
  if clear_cur_room then
    local point = self.award_points[self.v_cur_room]
    if point then
      point:on_destroy()
      self.award_points[self.v_cur_room] = nil
    end
    return
  end
  for _, point in pairs(self.award_points) do
    self:clear_item_obj_list(point.room_id)
    point:on_destroy()
  end
  self.award_points = {}
end

function M:clear_npc_drop_points()
  for _, point in pairs(self.npc_drop_points) do
    self:clear_npc_drop_list(point.room_id)
    point:on_destroy()
  end
  self.npc_drop_points = {}
end

function M:clear_breakable_drop_points()
  for _, point_list in pairs(self.breakable_drop_points) do
    for _, point in pairs(point_list) do
      self:clear_breakable_obj_list(point.room_id)
      point:on_destroy()
    end
  end
  self.breakable_drop_points = {}
end

function M:clear_room_points()
  MsgGame:mq_publish2(Const.MSG_SCENE_ITEM_CLEAR)
  self:clear_award_points()
  self:clear_npc_drop_points()
  self:clear_breakable_drop_points()
end

function M:clear_item_obj(room_num, uuid)
  for k, v in pairs(self.v_item_infos) do
    if (not room_num or v.room_num == room_num or not v.room_num) and v.uuid == uuid then
      self.v_item_infos[k] = nil
      self:remove_drop_item(v)
      break
    end
  end
end

function M:clear_item_obj_list(room_num)
  for k, v in pairs(self.v_item_infos) do
    if not room_num or v.room_num == room_num or not v.room_num then
      self.v_item_infos[k] = nil
      self:remove_drop_item(v)
    end
  end
end

function M:clear_npc_drop_list(room_num)
  for k, v in pairs(self.v_item_infos) do
    local npc_data = v.npc_data
    if (not room_num or v.room_num == room_num or not v.room_num) and npc_data then
      self.v_item_infos[k] = nil
      self:remove_drop_item(v)
    end
  end
end

function M:clear_breakable_obj_list(room_num)
  for k, v in pairs(self.v_breakable_item_infos) do
    if not room_num or v.room_num == room_num or not v.room_num then
      self:remove_drop_item(v)
      self.v_breakable_item_infos[k] = nil
    end
  end
end

function M:clear_energy_ball()
  if not self.v_energy_ball_list then
    return
  end
  for key, item_info in pairs(self.v_energy_ball_list) do
    item_info.item_obj:SetActive(false)
    ResPool:release(item_info.item_obj)
    local hero_list = SceneMgr:get_hero_list()
    if hero_list then
      for key, hero in pairs(hero_list) do
        if not hero:is_die() and item_info.state ~= ITEM_STATE.END then
          hero.magic_mgr:add_magic(hero, Config.PICK_ENERGY_BALL_MAGIC, nil, nil, item_info.magic_level or 1)
        end
      end
    end
    self.v_energy_ball_list[key] = nil
  end
end

function M:remove_drop_item(item)
  local drop_uuid = item.drop_uuid
  for index, item_obj in ipairs(item.item_obj_list) do
    ResPool:release(item_obj)
    if item.obj_info and item.obj_info[index] and item.obj_info[index].cur_effect_obj then
      ResPool:release(item.obj_info[index].cur_effect_obj)
    end
  end
  if item.effect_go then
    ResMgr:destroy_gameobj(item.effect_go)
    item.effect_go = nil
  end
  local msg = MsgGame:mq_publish2(Const.MSG_ON_REMOVE_DROP_ITEM)
  msg.mm_x = drop_uuid
  self:send_all_item_picked()
end

function M:on_change_auto_pick()
  if Util.get_auto_pick() then
    self:fly_to_hero_animation()
  end
end

function M:on_enter_room(msg)
  local room_num = msg.mm_obj
  for _, point in pairs(self.award_points) do
    point:on_enter_room(room_num)
  end
  self.v_cur_room = room_num
end

function M:on_leave_room(msg)
  local room_num = msg.mm_obj
  self:clear_npc_drop_list(room_num)
end

function M:create_award_point(room_num)
  local item_list = TowerMgr.cur_room_drops
  if UtilTable.is_empty(item_list) and not ChallengeRingPlusMgr:check_have_ability_drop() and not ChallengeRingPlusMgr:check_have_ornament_drop() then
    return
  end
  if self.award_points[room_num] then
    return
  end
  local data_list = self:create_scene_item(item_list, room_num)
  local last_monster_dead_pos = FightDataMgr:get_last_monster_dead_pos()
  local scene_logic = SceneMgr:get_scene_logic()
  local px, py, pz
  if last_monster_dead_pos then
    px, py, pz = last_monster_dead_pos:Get()
  else
    px, py, pz = scene_logic:get_pos_key_position("drop")
  end
  if not px then
    px, py, pz = scene_logic:get_pos_key_position("center")
  end
  local effect_name = last_monster_dead_pos and ccd.WORLD_EFFECT_NAME.FX_TREASURE_DROP or ccd.WORLD_EFFECT_NAME.FX_BAOSHI
  local param = {effect_name = effect_name}
  self.award_points[room_num] = require("manager.scene.scene_award_point"):new(px, py, pz, room_num, data_list, nil, param)
  if last_monster_dead_pos then
    self.award_points[room_num]:burst()
    ChallengeRingPlusMgr:check_drop_func(2)
  end
end

function M:create_scene_breakable_drop(item_list, room_num, breakable_id)
  local data_list = {}
  for _, item_data in pairs(item_list) do
    local item_id = item_data.id
    local item_obj = ResPool:get_drop_item_obj(DROP_ITEM_EFFECT_NAME.EQUIP_CUBE)
    item_obj.transform:SetEuler(45, 45, 45)
    local count = item_data.count
    local scene_drop_type = SCENE_ITEM_DROP_TYPE.BREAKABLE
    local transform = item_obj.transform
    transform:SetPositionA(-30000, -30000, -30000)
    local drop_uuid = get_idx()
    local item_info = {
      uuid = item_data.uuid,
      ran_ans_uuid = item_data.ran_ans_uuid,
      item_obj = item_obj,
      count = count,
      item_transform = transform,
      item_id = item_id,
      room_num = room_num,
      breakable_id = breakable_id,
      scene_drop_type = scene_drop_type,
      drop_uuid = drop_uuid
    }
    item_info.state = ITEM_STATE.CREATED
    self:check_item_type(item_obj, item_id, count)
    self:set_item_color(item_obj, item_id, item_info)
    ResMgr:load_set_itemobj_quality_icon(item_obj, UtilUI.get_battle_item_quality_icon(item_id))
    ResMgr:load_set_itemobj_icon(item_obj, UtilUI.get_battle_item_icon(item_id))
    self.v_breakable_item_infos[drop_uuid] = item_info
    _insert(data_list, item_info)
  end
  return data_list
end

function M:get_create_drop_count(item_count, divisor)
  return math.floor(item_count / divisor) + (item_count % divisor > 0 and 1 or 0)
end

function M:set_default_effect_show(item_info, obj_index)
  local item_id = item_info.item_id
  local effect_name
  local is_ornament = BattleOrnamentMgr:is_ornament(item_id)
  if is_ornament then
    effect_name = BattleOrnamentMgr:get_ornament_drop_effect_name(item_id)
  else
    effect_name = ITEM_TO_EFFECT_NAME[item_id]
  end
  self:set_only_effect_show(item_info, obj_index, effect_name, is_ornament)
end

function M:set_only_effect_show(item_info, obj_index, effect_name, force_set_mesh)
  local item_obj = item_info.item_obj_list[obj_index]
  local obj_info = item_info.obj_info[obj_index]
  local cur_effect_obj = obj_info.cur_effect_obj
  local mesh_enable
  if not Util.is_empty(effect_name) then
    if not cur_effect_obj or effect_name ~= cur_effect_obj.name then
      if not Util.is_nil(cur_effect_obj) then
        ResPoolMgr:release(cur_effect_obj)
      end
      cur_effect_obj = ResPool:get_drop_item_obj(effect_name)
      local transform = cur_effect_obj.transform
      transform:SetParent(item_obj.transform)
      transform:ResetAttr()
      transform:SetLocalScaleA(3)
      transform:SetLocalEuler(-60, -35, 0)
      cur_effect_obj.name = effect_name
      item_info.obj_info[obj_index].cur_effect_obj = cur_effect_obj
    end
    mesh_enable = false
  else
    mesh_enable = true
  end
  if nil ~= force_set_mesh then
    mesh_enable = force_set_mesh
  end
  if obj_info.mesh_enable ~= mesh_enable then
    item_obj:GetComponent(TypeMeshRenderer).enabled = mesh_enable
    obj_info.mesh_enable = mesh_enable
  end
end

function M:create_scene_item(item_list, room_num)
  local data_list = {}
  for _, item_data in pairs(item_list) do
    local item_id = item_data.id
    if ShareRes.check_can_exchange_item(item_id) or item_id == Config.CURSE_GOLD then
      self:requst_pick_up_drop(item_data.uuid)
    else
      local count = item_data.count
      local create_drop_count = 1
      if 500001 == item_id then
        create_drop_count = self:get_create_drop_count(count, 10)
      end
      local drop_uuid = get_idx()
      local item_info = self:_create_scene_item(item_data, room_num, drop_uuid, create_drop_count)
      self.v_item_infos[drop_uuid] = item_info
      self.v_need_pick_item_counts[drop_uuid] = {}
      _insert(data_list, item_info)
    end
  end
  local msg = MsgGame:mq_publish2(Const.MSG_ON_DROP_EVENT)
  msg.mm_x = false
  return data_list
end

function M:_create_scene_item(item_data, room_num, drop_uuid, create_drop_count)
  local item_obj_list = {}
  local item_id = item_data.id
  for index = 1, create_drop_count do
    local item_obj
    item_data.is_auto_pick_item = AUTO_PICK_ITEM_MAP[item_id]
    item_obj = ResPool:get_drop_item_obj(DROP_ITEM_EFFECT_NAME.EQUIP_CUBE)
    item_obj.transform:SetEuler(45, 45, 45)
    item_obj.transform:SetPositionA(-30000, -30000, -30000)
    table.insert(item_obj_list, item_obj)
  end
  local scene_drop_type = item_data.scene_drop_type or SCENE_ITEM_DROP_TYPE.BATTLE
  local npc_data = item_data.npc_data
  local count = item_data.count
  local item_info = {
    uuid = item_data.uuid,
    ran_ans_uuid = item_data.ran_ans_uuid,
    item_obj_list = item_obj_list,
    count = item_data.count,
    item_id = item_id,
    room_num = room_num,
    scene_drop_type = scene_drop_type,
    npc_data = npc_data,
    drop_uuid = drop_uuid,
    is_auto_pick_item = item_data.is_auto_pick_item,
    obj_info = {}
  }
  item_info.state = ITEM_STATE.CREATED
  for index, item_obj in ipairs(item_obj_list) do
    item_info.obj_info[index] = {}
    if not ITEM_TO_EFFECT_NAME[item_id] then
      self:check_item_type(item_obj)
      self:set_item_color(item_obj, item_id, item_info)
      ResMgr:load_set_itemobj_quality_icon(item_obj, UtilUI.get_battle_item_quality_icon(item_id))
      ResMgr:load_set_itemobj_icon(item_obj, UtilUI.get_battle_item_icon(item_id))
    end
    self:set_only_effect_show(item_info, index, BURST_EFFECT_NAME)
  end
  return item_info
end

function M:check_item_type(item_obj)
  local type_mesh_render = Util.get_component(nil, item_obj, TypeMeshRenderer)
  type_mesh_render.enabled = true
end

function M:set_item_color(item_obj, item_id, item_info)
  local quality = ShareRes.get_battle_item_quality(item_id)
  local prefab_name = drop_quality_light[quality]
  if prefab_name then
    local prefab_path = Path.get_res_path(prefab_name)
    local go = ResMgr:load_gameobj(prefab_path, nil, true)
    go:SetActive(true)
    go.transform:SetParent(item_obj.transform, false)
    item_info.effect_go = go
  end
end

function M:calc_drop_distance()
  return math.random(DROP_MIN, DROP_MAX) / 10
end

function M:fly_to_hero_animation(breakable_id)
  if not next(self.v_item_infos) then
    return
  end
  local tower = TowerMgr and TowerMgr:get_tower()
  if not tower then
    return
  end
  local cur_room_id = tower:get_room_num()
  for _, item_data in pairs(self.v_item_infos) do
    if cur_room_id == item_data.room_num or not item_data.room_num then
      self:pick_item(item_data)
    end
  end
end

function M:breakable_item_fly_to_hero(breakable_id)
  local tower = TowerMgr and TowerMgr:get_tower()
  if not tower then
    return
  end
  local cur_room_id = tower:get_room_num()
  for _, item_data in pairs(self.v_breakable_item_infos) do
    if (cur_room_id == item_data.room_num or not item_data.room_num) and breakable_id == item_data.breakable_id then
      self:pick_item(item_data)
    end
  end
  return
end

function M:is_all_drop_geted()
  return not self.v_is_release and (self.v_item_infos == nil or 0 == UtilTable.hash_lenth(self.v_item_infos))
end

function M:send_all_item_picked()
  if self:is_all_drop_geted() and TowerMgr and not TowerMgr:get_has_exist() then
    SceneMgr:c2gs_call_scene("on_all_item_picked")
    BehaviorMgr:call_scene_logic_event_fun("on_all_item_picked")
    local tower = TowerMgr and TowerMgr:get_tower()
    if tower then
      tower:on_all_item_picked()
    end
  end
end

function M:pick_item(item_data)
  local msg = MsgGame:mq_publish2(Const.MSG_ITEM_PICKED)
  msg.mm_obj = item_data
  local effect_name = BURST_EFFECT_NAME
  for index, item_obj in ipairs(item_data.item_obj_list) do
    if not item_data.is_auto_pick_item then
      self:set_only_effect_show(item_data, index, effect_name)
    end
    set_to_state(item_data, ITEM_STATE.FLYING)
    item_data.fly_st_x, item_data.fly_st_y, item_data.fly_st_z = item_obj.transform:GetPositionA()
    item_data.fly_t = 0
  end
end

function M:delete_item(drop_uuid)
  self:clear_item_by_drop_uuid(self.v_cur_room, drop_uuid)
end

function M:force_pick_up_all(complete_cb)
  local count = 0
  
  local function counter()
    count = count - 1
    if 0 == count then
      complete_cb()
    end
  end
  
  for _, data in pairs(self.v_item_infos) do
    if data.state <= ITEM_STATE.FLYING then
      count = count + 1
      self:get_item(data, counter)
    end
  end
  if 0 == count then
    complete_cb()
  end
end

function M:update()
  if SceneMgr:get_game_pause() or Util.is_story_only() then
    return
  end
  for _, point in pairs(self.award_points) do
    point:update()
  end
  for _, point in pairs(self.npc_drop_points) do
    point:update()
  end
  for _, point_list in pairs(self.breakable_drop_points) do
    for _, point in pairs(point_list) do
      point:update()
    end
  end
  local attach_point = Global.hero:get_setting_point(Config.BLOOD_ATTACH)
  if not attach_point then
    return
  end
  local target_x, target_y, target_z = attach_point:GetPositionA()
  local dt = GlobalTimeMgr:get_dt_time() * ANIM_SPEED
  local fly_all_end = true
  for k, v in pairs(self.v_item_infos) do
    if v.state ~= ITEM_STATE.END then
      fly_all_end = false
    end
    if v.state == ITEM_STATE.FLYING then
      local cal_once = true
      for index, item_obj in ipairs(v.item_obj_list) do
        if not Util.almost_zero(v.fly_t - 1) then
          if cal_once then
            v.fly_t = v.fly_t + dt
            v.fly_t = math.min(v.fly_t, 1)
            cal_once = false
          end
          local sx, sy, sz = item_obj.transform:GetPositionA()
          local px, py, pz = Vec3.LerpC(sx, sy, sz, target_x, target_y, target_z, v.fly_t * 0.2)
          item_obj.transform:SetPositionA(px, py, pz)
        else
          item_obj:SetActive(false)
          self.v_need_pick_item_counts[k][index] = index
        end
      end
      if #self.v_need_pick_item_counts[k] >= #v.item_obj_list then
        if v.uuid and v.scene_drop_type == SCENE_ITEM_DROP_TYPE.BATTLE then
          self:get_item(v)
        elseif v.scene_drop_type == SCENE_ITEM_DROP_TYPE.NPC then
          self:npc_get_item(v)
        else
          set_to_state(v, ITEM_STATE.END, true)
        end
        self.v_need_pick_item_counts[k] = {}
        for index, item_obj in ipairs(v.item_obj_list) do
          item_obj.gameObject:SetActive(false)
        end
      end
    end
  end
  self:breakable_fly_update(dt, target_x, target_y, target_z)
  self:energy_ball_update(dt, target_x, target_y, target_z)
  if fly_all_end and next(self.v_item_infos) and self.v_cur_room then
    self:on_item_obj_all_fly_end()
  end
end

function M:on_item_obj_all_fly_end()
  if not self.award_points[self.v_cur_room] then
    return
  end
  self:clear_item_obj_list(self.v_cur_room)
  self:clear_award_points(true)
  if TowerMgr and TowerMgr.is_pre_exit then
    return
  end
  if Util.get_auto_pick() then
    DropShowMgr:open_drop_show_state(false, DROP_TYPE.FIGHT_END)
  else
    DropShowMgr:open_drop_show_state(true, DROP_TYPE.FIGHT_END)
  end
  local msg = MsgGame:mq_publish2(Const.MSG_ON_DROP_EVENT)
  msg.mm_x = true
end

function M:energy_ball_update(dt, target_x, target_y, target_z)
  self:_item_update(self.v_energy_ball_list, SCENE_ITEM_TYPE.ENERGY_BALL, dt, target_x, target_y, target_z)
end

function M:breakable_fly_update(dt, target_x, target_y, target_z)
  self:_item_update(self.v_breakable_item_infos, SCENE_ITEM_TYPE.BREAKABLE, dt, target_x, target_y, target_z)
end

local temp_need_remove_list = {}

function M:_item_update(infos, scene_item_type, dt, target_x, target_y, target_z)
  if UtilTable.is_empty(infos) then
    return
  end
  UtilTable.clear_map(temp_need_remove_list)
  for _, v in pairs(infos) do
    local item_obj = v.item_obj
    if v.state == ITEM_STATE.END then
      table.insert(temp_need_remove_list, v)
    end
    if v.state == ITEM_STATE.FLYING then
      if scene_item_type == SCENE_ITEM_TYPE.ENERGY_BALL then
        if not v.can_get or not Util.almost_zero(v.fly_t - 1) then
          self:item_track_move(dt, v, target_x, target_y, target_z)
        elseif v.can_get then
          self[ALMOST_ZERO_CB[scene_item_type]](self, v)
        end
      elseif not Util.almost_zero(v.fly_t - 1) then
        v.fly_t = v.fly_t and v.fly_t + dt
        v.fly_t = math.min(v.fly_t, 1)
        local px, py, pz = _drop_curvey(v.fly_st_x, v.fly_st_y, v.fly_st_z, target_x, target_y, target_z, v.fly_t)
        item_obj.transform:SetPositionA(px, py, pz)
      else
        self[ALMOST_ZERO_CB[scene_item_type]](self, v)
      end
    elseif v.state == ITEM_STATE.PAUSE then
      v.pause_fly_timer = v.pause_fly_timer - dt
      if v.pause_fly_timer <= 0 then
        set_to_state(v, ITEM_STATE.FLYING, true)
        v.pause_fly_timer = nil
        v.break_pause = true
      end
    end
  end
  if next(temp_need_remove_list) and (Util.is_client_only() and true or self.v_cur_room) then
    self[GET_ITEM_CB[scene_item_type]](self, temp_need_remove_list)
  end
  UtilTable.clear_map(temp_need_remove_list)
end

function M:on_breakable_item_almost_zero(item)
  item.item_obj:SetActive(false)
  local hero = Global.hero
  set_to_state(item, ITEM_STATE.END, true)
  local effect_data = hero.act_effect_ctrl.create_effect_param()
  effect_data.prefab_name = FX_DROP2HERO
  effect_data.parent = hero.transform
  hero.act_effect_ctrl:play_effect(effect_data)
end

function M:on_energy_ball_almost_zero(item)
  item.item_obj:SetActive(false)
  set_to_state(item, ITEM_STATE.END, true)
end

function M:get_item(item, callback)
  set_to_state(item, ITEM_STATE.GETTING)
  
  local function cb()
    set_to_state(item, ITEM_STATE.END, true)
    if callback then
      callback()
    end
  end
  
  if item.need_sell then
    if item.is_ornament then
      local npc_data = item.npc_data
      local source_type = npc_data and RUNE2_SOURCE.NPC_DROP or RUNE2_SOURCE.DROP
      BattleOrnamentMgr:sell_ornaments(item, source_type, cb)
    elseif item.is_rune then
      local sell_param = {
        uuid = item.uuid
      }
      Rune2Mgr:sell_rune_item(sell_param, RUNE2_SOURCE.DROP, cb)
    end
    return
  end
  if item.is_equip then
    local send_data = {
      uuid = item.uuid
    }
    FightBagMgr:request_operate_equip_item("c2gs_pick_up_drop", send_data, item.is_need_equip, function()
      cb()
    end)
  elseif item.is_ornament then
    local npc_data = item.npc_data
    local source_type = npc_data and RUNE2_SOURCE.NPC_DROP or RUNE2_SOURCE.DROP
    BattleOrnamentMgr:inlaid_ornament(item, source_type, cb)
  else
    self:requst_pick_up_drop(item.uuid, cb)
    MsgGame:mq_publish2(Const.MSG_ITEM_PICK_COMPLETED)
  end
end

function M:requst_pick_up_drop(uuid, cb)
  local send_data = {uuid = uuid}
  Network:call("c2gs_pick_up_drop", send_data, function()
    if cb then
      cb()
    end
  end)
end

function M:npc_get_item(item, callback)
  set_to_state(item, ITEM_STATE.GETTING)
  
  local function cb()
    set_to_state(item, ITEM_STATE.END, true)
    if callback then
      callback()
    end
  end
  
  FunctionalNpcMgr:interact_reawrd_npc_item_get(item.npc_data, item.uuid, cb, item)
end

function M:peaceful_drop(pos, data_list, drop_point_list)
  local item_list = self:create_scene_item(data_list, self.v_cur_room)
  self.npc_drop_points[self.v_cur_room] = require("manager.scene.scene_award_point"):new(pos.x, pos.y, pos.z, self.v_cur_room, item_list, true)
  self.npc_drop_points[self.v_cur_room]:burst(drop_point_list)
end

function M:breakable_drop(pos, data_list, breakable_id)
  local item_list = self:create_scene_breakable_drop(data_list, self.v_cur_room, breakable_id)
  if not self.breakable_drop_points[self.v_cur_room] then
    self.breakable_drop_points[self.v_cur_room] = {}
  end
  local param = {award_type = 3, breakable_id = breakable_id}
  local breakable_point_obj = require("manager.scene.scene_award_point"):new(pos.x, pos.y, pos.z, self.v_cur_room, item_list, true, param)
  self.breakable_drop_points[self.v_cur_room][breakable_id] = breakable_point_obj
  breakable_point_obj:burst()
end

function M:check_have_drop_item()
  local point = self.award_points[self.v_cur_room]
  return FunctionalNpcMgr:is_get_thing() or point and point:not_all_item_picked()
end

function M:check_have_drop_point()
  return self.award_points[self.v_cur_room] ~= nil
end

function M:clear_play_anim()
  if next(self.v_drop_anim_sequence) then
    for _, sequence in pairs(self.v_drop_anim_sequence) do
      sequence:Kill(false)
    end
  end
  self.v_drop_anim_sequence = {}
end

function M:get_breakable_item()
  local tower = TowerMgr:get_tower()
  if tower then
    local room = tower:get_room()
    if room:is_fight_end() and next(self.v_breakable_item_infos) and not self.v_is_get_breakable then
      local breakable_map = TowerMgr.breakable_map
      local cache_breakable_id = {}
      local breakable_list = {}
      for _, v in pairs(self.v_breakable_item_infos) do
        set_to_state(v, ITEM_STATE.END, true)
        local breakable_id = v.breakable_id
        if not cache_breakable_id[breakable_id] then
          cache_breakable_id[breakable_id] = true
          _insert(breakable_list, breakable_id)
        end
      end
      self:clear_breakable_obj_list(self.v_cur_rooms)
      self.v_is_get_breakable = true
      Network:call("c2gs_mask_breakable_id", {breakable_list = breakable_list}, function(ok)
        if ok then
          for _, breakable_id in pairs(breakable_list) do
            local drop_item_list = breakable_map[breakable_id]
            for _, v in pairs(drop_item_list) do
              local send_data = {
                uuid = v.uuid
              }
              Network:call("c2gs_pick_up_drop", send_data, function(ok, resp)
                if ok then
                end
              end)
            end
          end
          self.v_is_get_breakable = false
        end
      end)
    end
  end
end

function M:get_energy_ball(need_remove_list)
  local item
  for key, remove_item in pairs(need_remove_list) do
    item = item or remove_item
    local item_info = self.v_energy_ball_list[remove_item.index]
    if item_info then
      ResPool:release(item_info.item_obj)
    end
    self.v_energy_ball_list[remove_item.index] = nil
    local hero_list = SceneMgr:get_hero_list()
    for key, hero in pairs(hero_list) do
      if not hero:is_die() then
        hero.magic_mgr:add_magic(hero, Config.PICK_ENERGY_BALL_MAGIC, nil, nil, item_info.magic_level or 1)
      end
    end
  end
  local msg = MsgGame:mq_publish2(Const.MSG_ENERGY_BALL_HAS_BEEN_PICKED)
  msg.mm_x = item.target_char
  msg.mm_y = item.from_char
end

function M:get_test_item_info()
  return self.v_item_infos
end

function M:clear_item_by_drop_uuid(room_num, drop_uuid)
  for k, v in pairs(self.v_item_infos) do
    if (not room_num or v.room_num == room_num or not v.room_num) and v.drop_uuid == drop_uuid then
      self.v_item_infos[k] = nil
      self:remove_drop_item(v)
      break
    end
  end
end

function M:get_item_id(drop_uuid)
  for k, v in pairs(self.v_item_infos) do
    if v.drop_uuid == drop_uuid then
      return v.item_id
    end
  end
end

function M:init_ball_move_param()
  local small_behit_offset = ShareRes.get_comm_value("EnergyBallParam9") or 0
  local big_behit_offset = ShareRes.get_comm_value("EnergyBallParam10") or 0
  local continuous_behit_offset = ShareRes.get_comm_value("EnergyBallParam11") or 0
  local pause_time_offet_max = ShareRes.get_comm_value("EnergyBallParam12") or 0
  local pause_time_offet_min = ShareRes.get_comm_value("EnergyBallParam13") or 0
  if pause_time_offet_max < pause_time_offet_min then
    pause_time_offet_min, pause_time_offet_max = pause_time_offet_max, pause_time_offet_min
  end
  self.v_ball_move_param = {
    init_speed = ShareRes.get_comm_value("EnergyBallParam1"),
    start_height = ShareRes.get_comm_value("EnergyBallParam2"),
    y_total_angle = ShareRes.get_comm_value("EnergyBallParam3"),
    x_offset_angle = ShareRes.get_comm_value("EnergyBallParam4"),
    init_fly_time = ShareRes.get_comm_value("EnergyBallParam5"),
    pause_time = ShareRes.get_comm_value("EnergyBallParam6"),
    follow_speed = ShareRes.get_comm_value("EnergyBallParam7"),
    follow_acc_speed = ShareRes.get_comm_value("EnergyBallParam8"),
    pick_up_magic = ShareRes.get_comm_value("PickEnergyBallMagic") or 0,
    behit_offset_param = {
      [Config.BEHIT_TYEP.LEFT_SMALL] = -small_behit_offset,
      [Config.BEHIT_TYEP.RIGHT_SMALL] = small_behit_offset,
      [Config.BEHIT_TYEP.LEFT_LARGE] = -big_behit_offset,
      [Config.BEHIT_TYEP.RIGHT_LARGE] = big_behit_offset,
      [Config.BEHIT_TYEP.COMBO_HIT_LEFT_START] = -continuous_behit_offset,
      [Config.BEHIT_TYEP.COMBO_HIT_RIGHT_START] = continuous_behit_offset
    },
    pause_time_offet_min = pause_time_offet_min,
    pause_time_offet_max = pause_time_offet_max,
    temp_tar_vec = Vec3.New(),
    temp_quat = Quat.New()
  }
end

function M:create_energy_ball(count, target_char, from_char, magic_level)
  local effect_name = magic_level >= Config.ENERGY_BALL_SIZE_RANGE and DROP_ITEM_EFFECT_NAME.BIG_ENERGY_BALL or DROP_ITEM_EFFECT_NAME.SMALL_ENERGY_BALL
  local move_param = self.v_ball_move_param
  local n = count - 1
  local avg_angle = move_param.y_total_angle / n
  local start_angle = 0 - move_param.y_total_angle / 2
  local px, py, pz = from_char:get_pos()
  py = move_param.start_height + py
  local dir
  local action_missile_id = from_char:get_cur_action_missile_id()
  local behit_offset = 0
  if action_missile_id then
    local missile = SceneMgr:get_missile_by_id(action_missile_id)
    if missile then
      local back_dir = missile:get_hit_back_dir(from_char)
      local offset_param = move_param.behit_offset_param
      local hit_type = missile.missile_cfg.Type
      if offset_param[hit_type] then
        behit_offset = offset_param[hit_type]
      end
      dir = Util.VEC3_TEMP:SetA(back_dir)
    end
  end
  dir = dir or target_char:get_dir_to_target(from_char)
  dir:SetNormalize()
  for index = 1, count do
    local ball_info = {
      item_obj = ResPool:get_drop_item_obj(effect_name),
      index = #self.v_energy_ball_list + 1,
      from_char = from_char,
      target_char = target_char,
      state = ITEM_STATE.DROPED,
      init_speed = move_param.init_speed,
      follow_speed = move_param.follow_speed,
      can_get = false,
      fly_t = 0,
      total_time = 0,
      offset_x = math.random(-30, 30) / 10,
      offset_y = math.random(0, 20) / 10,
      pause_time_offset = math.random(move_param.pause_time_offet_min, move_param.pause_time_offet_max) / 1000,
      magic_level = magic_level
    }
    local tf = ball_info.item_obj.transform
    if dir:Magnitude() >= 1.0E-6 then
      Util.VEC3_TEMP_1:SetA(dir)
    else
      Util.VEC3_TEMP_1:Set(0, 0, 1)
    end
    Quat.LookRotationA(Util.VEC3_TEMP_1, Util.VEC3_TEMP:Set1(0, 1, 0), Util.QuatTemp)
    Util.QuatTemp:ToEulerAngles2(Util.VEC3_TEMP)
    if n <= 0 then
      Util.VEC3_TEMP.y = Util.VEC3_TEMP.y + behit_offset
    else
      Util.VEC3_TEMP.y = avg_angle * (index - 1) + start_angle + Util.VEC3_TEMP.y + behit_offset
    end
    Util.VEC3_TEMP.x = move_param.x_offset_angle
    tf:SetLocalEuler(Util.VEC3_TEMP:Get())
    ball_info.item_obj.transform:SetPositionA(px, py, pz)
    set_to_state(ball_info, ITEM_STATE.FLYING)
    self.v_energy_ball_list[ball_info.index] = ball_info
  end
end

function M:item_track_move(dt, item, target_x, target_y, target_z)
  if not self.v_ball_move_param or SceneMgr:global_hero_is_destroyed() then
    return
  end
  local move_param = self.v_ball_move_param
  local obj = item.item_obj
  local transform = obj.transform
  local cur_pos = transform.position
  local total_time = item.total_time
  item.total_time = total_time + Global.time_scale * Global.delta_time
  if total_time < move_param.init_fly_time then
    local speed = item.init_speed
    local dir = transform.forward
    local move_dt = dt * speed * GlobalTimeMgr:get_time_scale()
    item.can_get = false
    transform:SetPositionA(cur_pos.x + dir.x * move_dt, cur_pos.y + dir.y * move_dt, cur_pos.z + dir.z * move_dt)
    return
  elseif total_time < move_param.init_fly_time + (move_param.pause_time + item.pause_time_offset) and total_time >= move_param.init_fly_time then
    return
  else
    item.can_get = true
  end
  if Util.almost_zero(item.fly_t - 1) then
    return
  end
  if not item.fly_st_x then
    local x, y, z = transform:GetPositionA()
    item.fly_st_x = x
    item.fly_st_y = y
    item.fly_st_z = z
  end
  local speed = item.follow_speed
  item.fly_t = item.fly_t and item.fly_t + dt * speed
  item.fly_t = math.min(item.fly_t, 1)
  local px, py, pz = _drop_curvey(item.fly_st_x, item.fly_st_y, item.fly_st_z, target_x, target_y, target_z, item.fly_t)
  if item.offset_x then
    local value = _sin(math.pi * item.fly_t)
    px = value * item.offset_x + px
    py = value * item.offset_y + py
  end
  transform:SetPositionA(px, py, pz)
  item.follow_speed = speed + move_param.follow_acc_speed * dt
end

return M
