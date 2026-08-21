local Const = require("const")
local Base = require("obj.role")
local Math = require("base.mathx")
local FightDefine = require("cs_share.fight_define")
local NAVI_TP_NAME = "navigator_tp"
local mathx = require("base.mathx")
local NAME2ATTR = FightDefine.CONFIG_NAME_ATTR_ID
local Layer = require("utils.layer")
local FightConfig = require("uimodule.fight.fight_config")
local M = Util.create_child_mt(Base)
local ease_linear = CS.DG.Tweening.Ease.Linear
local Vec2 = require("base.vec2")
local Vec3 = require("base.vec3")
local CommonDefine = require("cs_share.common_define")
local ATTR_TYPE = FightDefine.ATTR_TYPE
local TEMP_PARAMS = {
  arrows_effect_color = Config.ARROWS_EFFECT_COLOR.RED
}
local CollidedMoveCoef = ShareRes.get_comm_value("CollidedMoveCoef")
local atan = math.atan
local deg = math.deg
local CHARGE_TYPE = {FULL = 0, EMPTY = 1}
local UI_POINT_NAME = "chargerpoint"
local CHARACTER_CONFIG = require("uimodule.character.character_config")
local NAVIGATOR_EFFECT_NAME = "Fx_Navigation_line"
local BUDDY_TYPE = Config.BUDDY_TYPE
local CommonDefine = require("cs_share.common_define")
local MODULE_ATTR_TYPE = CommonDefine.MODULE_ATTR_TYPE
local STATE_NAME = Global.config.STATE_NAME
local INDICATOR = {
  TP_POINT = 1,
  MONSTER = 2,
  DROP = 3,
  MONSTER_NEW = 4
}
local CSDynamicBone = CS.DynamicBone
local NORMAL_UPDATE_MODEL = CS.DynamicBone.UpdateMode.Normal
local DISABLE_DY_BONE_DIS = 8
local NAVIGATOR_TASK_CD = ShareRes.get_comm_value("NavigatorTaskCD")
local MAX_NAVIGATOR_TASK_CD = math.huge
local NAVIAGTOR_TYPE = {TASK = 1, POINT = 2}
local HERO_PATHFIND_INTERVAL = 0.5
local NEXT_WAYPOINT_INTERVAL = 7
local MONSTER_NEW_ARROWS_OFFSET_Y = 0.7
local SCOPE_VAL = ShareRes.get_comm_value("CheckScopeMonster")

function M:_init(...)
  Base._init(self, ...)
  self:set_ignore_sync(false)
  self.v_attackers = {}
  self.scope = {}
  self.can_show_up = true
  self.v_have_refresh_arrow = false
  self.v_betarget_map = {}
  self.v_betargeted_effect = {}
  self.v_monster_new_arrow_state = {}
  self.v_item_arrow = {}
  self.v_drop_to_room = {}
  self.v_tp_self_effect = {}
  self.v_module_attrs = {}
  self.v_loading = false
  self.v_cursor_enable = true
  self.v_navigator_effect_id_list = {}
  self.v_navigator_end_effect_id_list = {}
  self.v_type = BUDDY_TYPE.DEFAULT
  self.v_navi_arrows_info_list = {}
  self.v_arrow_colors = setmetatable({}, Config.KEY_WEAK_METATABLE)
  self.v_arrow_visibles = setmetatable({}, Config.KEY_WEAK_METATABLE)
  self.v_skill_indic_pos = Vec3.New()
  self.v_latest_pos = Vec3.New()
  self.v_use_latest_pos = false
  self.v_guid_arrow_visible = true
  self.v_recover_interval = ShareRes.get_comm_value("EnergyRecoveryInterval")
  self.v_recover_sp_timer = 0
  self.v_last_hero_nav_time = 0
  self:set_use_pos_type(Config.HERO_POS_CHANGE_TYPE.GLOBAL_POS)
  self.v_show_betargeted_arrow = true
end

function M:on_init_gameobj(cid, gameobj, transform)
  Base.on_init_gameobj(self, cid, gameobj, transform)
  if UNITY_EDITOR and self.uuid then
    self.gameobj.name = "Hero"
  end
  self.weapon_mgr:init_weapon()
  self:set_layer(Layer.Layer.Character)
  self.char_renderers:enable_effect(Config.CHAR_EFFECT.SHADOW, true)
  Util.bind_msg(self, Const.MSG_ADD_TRANSPARENT_OBJ, self._on_add_transparent_obj, self)
  Util.bind_msg(self, Const.MSG_DEL_TRANSPARENT_OBJ, self._on_del_transparent_obj, self)
  Util.bind_msg(self, Const.MSG_SCENE_SKILL_LV_UP, self._on_scene_skill_lv_up, self)
  Util.bind_msg(self, Const.MSG_ITEM_PICKED, self._on_item_picked, self)
  Util.bind_msg(self, Const.MSG_ITEM_PICK_COMPLETED, self.on_energy_ball_has_been_picked, self)
  Util.bind_msg(self, Const.MSG_SCENE_ITEM_CLEAR, self._on_scene_item_clear, self)
  Util.bind_msg(self, Const.MSG_ON_CHANGE_TRACK_BATTLE_TASK_ID, self.on_change_track_battle_task, self)
  Util.bind_msg(self, Const.MSG_ON_CHANGE_TRACK_BATTLE_TASK_PRO, self.on_change_track_battle_task, self)
  Util.bind_msg(self, Const.MSG_CG_TIMELINE_START, self.start_time_line, self)
  Util.bind_msg(self, Const.MSG_CG_TIMELINE_END, self.stop_time_line, self)
  Util.bind_msg(self, Const.MSG_SCENE_LOGIC_FINISH, self._set_dybone_distant, self)
  Util.bind_msg(self, Const.MSG_ON_HERO_BORN_ANIM_END, self._response_born_skill_finish, self)
  Util.bind_msg(self, Const.MSG_ENERGY_BALL_HAS_BEEN_PICKED, self.on_energy_ball_has_been_picked, self)
  Util.bind_msg(self, Const.MSG_ON_ROLE_HEAL, self.on_hero_heal, self)
  Util.bind_msg(self, Const.MSG_ON_MONSTER_BEGIN_ATTACK_HERO, self.on_monster_begin_attack, self)
  Util.bind_msg(self, Const.MSG_ON_MONSTER_END_ATTACK_HERO, self.on_monster_end_attack, self)
  Util.bind_msg(self, Const.MSG_ON_ENTER_ROOM, self.on_enter_room_clear_data, self)
  self.v_navigator_tp_show = false
  if self.v_finish_init_gameobj_cb then
    self.v_finish_init_gameobj_cb()
    self.v_finish_init_gameobj_cb = nil
  end
  if self.gameobj ~= nil then
    CSHelper.ForceLODGroup(self.gameobj.transform, self.in_background and 0 or -1)
  end
end

function M:init_ui_model_gameobj(gameobj, transform, parent, params)
  Base.init_ui_model_gameobj(self, gameobj, transform, parent, params)
  self.v_head_bone = transform:Find("Bip001/Bip001 Pelvis/Bip001 Spine/Bip001 Spine1/Bip001 Spine2/Bip001 Neck/Bip001 Head")
  local dy_bones = gameobj:GetComponentsInChildren(typeof(CSDynamicBone))
  for i = 0, dy_bones.Length - 1 do
    local bone = dy_bones[i]
    bone.m_UpdateMode = NORMAL_UPDATE_MODEL
    bone.m_UpdateRate = 1 / Config.LOW_UPDATE_INTERVAL
  end
  self.v_dy_bones = dy_bones
  self.v_has_dy_bone = dy_bones.Length > 0
end

function M:late_update()
  Base.late_update(self)
  self:update_head_angle()
end

function M:open_hero_head_follow(is_open)
  self.v_is_open_follow = is_open
end

function M:update_head_angle()
  if not Global.camera then
    return
  end
  if not self.v_is_open_follow then
    return
  end
  local is_aimed = Global.camera:check_camera_aimed()
  if is_aimed then
    local pos_x, pos_y, pos_z = self.v_head_bone:GetPositionA()
    local aimed_target_pos = Global.camera:get_camera_forward_pos()
    local deg = atan(aimed_target_pos.y - pos_y, Math.dist_vec2A(pos_x, pos_z, aimed_target_pos.x, aimed_target_pos.z)) * deg(1)
    local euler = self.v_head_bone:GetEulerAnglesA()
    self.v_head_bone:SetEuler(euler.x, euler.y, deg)
  end
end

function M:on_destroy_gameobj()
  Base.on_destroy_gameobj(self)
  if self.gameobj then
    self:set_layer(Layer.Layer.Default)
  end
  self:release_charged_res()
  self:clear_navigator_effect()
  self:clear_circle_effect()
end

function M:get_gameobj()
  return self.gameobj
end

function M:on_destroy()
  Base.on_destroy(self)
  Util.unbind_all_msg(self)
  self:release_charged_res()
  self:_set_dybone_distant(false)
  self.v_energy_ball_effect_id = nil
  self.v_fake_sp_data = nil
  self.v_monster_new_arrow_state = nil
end

function M:on_dead(...)
  Base.on_dead(self, ...)
  if TowerMgr then
    TowerMgr:record_die_role(self.uuid, self.v_death_type)
  end
end

function M:release_charged_res()
  if self.v_charged_obj then
    ResPoolMgr:release(self.v_charged_obj)
    self.v_charged_obj = nil
  end
  if self.v_charge_sequence then
    self.v_charge_sequence:Kill(false)
    self.v_charge_sequence = nil
  end
end

function M:presetup(sync_data)
  Base.presetup(self)
  self.v_sync_data = sync_data
  self:init_module_attr()
  self:add_component("state_manager", require("obj.state.manager.hero_state_manager"):new(self))
end

function M:init_character_cfg(data)
  if not data then
    return
  end
  local model_id, character_id
  if data.fashion then
    local fashion_cfg = ShareRes.get_fashion_cfg(data.fashion)
    if fashion_cfg then
      model_id = fashion_cfg.ModelId
      character_id = fashion_cfg.NpcId
    end
  end
  character_id = character_id or data.id
  local character_cfg = ShareRes.get_character_cfg(character_id)
  if not character_cfg then
    Log.Error("获取单位表配置失败，单位ID:", tostring(character_id), debug.traceback())
    return
  end
  model_id = model_id or character_cfg.ModelId
  self.model_cfg = ShareRes.get_character_model_cfg(model_id)
  if not self.model_cfg then
    assert(false, "can't find model config: " .. data.id)
  end
  self.character_cfg = character_cfg
  if not self.character_cfg then
    assert(false, "can't find character config: " .. data.id)
  end
end

function M:update()
  Base.update(self)
  if self.in_control and not SceneMgr:check_is_switching_hero() then
    FightDataMgr.latest_hero_pos:Set(self:get_pos())
    FightDataMgr.latest_hero_dir = self:get_dir()
  elseif self.in_background then
    local hero_pos = FightDataMgr.latest_hero_pos
    self:set_pos_vec(hero_pos, hero_pos, hero_pos)
  end
  if Util.is_show_all_arrow_fx() and not self:check_background() then
    self:update_drop_guid_arrow()
    self:update_betargeted_effect()
  end
  if self:is_real_finish_init() and not self:is_die() and not self:is_destroy() then
    self:update_sp_timer()
  end
end

function M:low_update()
  Base.low_update(self)
  if self.in_background then
    return
  end
  self:check_creat_charged_res()
  self:update_charged_obj_position()
  self:update_path_finding()
  self:update_navigator_pos_info()
  self:update_navigator_obj_visible()
end

function M:update_sp_timer()
  self:calcu_fake_sp_data()
  if self:check_sp_is_max() then
    return
  end
  self.v_recover_sp_timer = self.v_recover_sp_timer + self.time_mgr:get_dt_time()
  if self.v_recover_sp_timer >= self.v_recover_interval then
    self:recover_char_sp()
  end
end

function M:reset(reset_magic, attr_ratio_map)
  self.v_death_type = nil
  self.v_enable_count = 1
  self:on_enable()
  if self == Global.hero then
    self:set_obj_enable(true)
  else
    self:set_obj_enable(false)
  end
  self.attr_mgr:reborn_set_attr(attr_ratio_map)
  self.skill_mgr:reset_energy()
  if StateReport then
    self:check_module_attrs()
  end
  self.v_is_die = false
  self.v_is_after_behitfly_die = false
  self.v_is_anim_die_end = false
  self.state_manager:exit_die_state()
  self.state_manager:to_idle_state()
  self:clear_arrow_effect()
  self.can_show_up = true
  self.v_is_can_searched = true
  self:set_is_set_die_state(false)
end

function M:set_team_pos(pos)
  self.v_team_pos = pos
end

function M:get_team_pos()
  return self.v_team_pos
end

function M:clear_arrow_effect()
  self.v_betarget_map = {}
  for _, effect_id in pairs(self.v_betargeted_effect) do
    self:clear_arrow_record(effect_id)
    self.act_effect_ctrl:stop_effect(effect_id)
  end
  for _, effect_id in pairs(self.v_tp_self_effect) do
    self:clear_arrow_record(effect_id)
    self.act_effect_ctrl:stop_effect(effect_id)
  end
  for key, arrows_info in pairs(self.v_navi_arrows_info_list) do
    if arrows_info.effect_id then
      self:clear_arrow_record(arrows_info.effect_id)
      self.act_effect_ctrl:stop_effect(arrows_info.effect_id)
    end
    if arrows_info.navigation_hud then
      Global.ui_dynamic_canvas:release_navigation_hud_item(arrows_info.navigation_hud)
      arrows_info.navigation_hud = nil
    end
    self.v_navi_arrows_info_list[key] = nil
  end
  if self.v_navigator_effect_id then
    self:clear_arrow_record(self.v_navigator_effect_id)
    self.act_effect_ctrl:stop_effect(self.v_navigator_effect_id)
    self.v_navigator_effect_id = nil
  end
  self.v_navigator_tp_show = false
  self.v_betargeted_effect = {}
  self.v_tp_self_effect = {}
end

function M:is_air()
  return Base.is_air(self) or self.in_background
end

function M:is_ghost()
  return Base.is_ghost(self) or self.in_background
end

function M:is_super_ghost()
  return Base.is_super_ghost(self) or self.in_background
end

function M:set_is_ui_hero()
  self.v_is_ui_hero = true
end

function M:is_ui_hero()
  return self.v_is_ui_hero
end

function M:is_hero()
  return true
end

function M:is_hero_or_player()
  return true
end

function M:get_camp()
  return 1
end

function M:get_select_obj()
  return self.v_select_obj
end

function M:get_select_obj_uuid()
  if self.v_select_obj then
    return self.v_select_obj.uuid
  end
end

function M:on_scene_remove_obj(obj)
  local uuid = obj.uuid
  if self.v_select_obj then
    if uuid and self.v_select_obj.uuid == uuid then
      self:unselect_obj()
    elseif obj:is_npc() and self.v_select_obj:is_npc() and obj.npc_id == self.v_select_obj.npc_id then
      self:unselect_obj()
    end
  end
end

function M:unselect_obj()
  if self.v_select_obj then
    self.v_select_obj:unselected()
  end
  self.v_select_obj = nil
  MsgGame:mq_publish2(Const.MSG_HERO_UNSELECT_OBJ)
end

function M:move_to_dst(x, z, deviation)
  self.state_manager:move_to_dst(x, z, deviation)
end

function M:on_relive(...)
  Base.on_relive(self, ...)
  MsgGame:mq_publish2(Const.MSG_HERO_RELIVE)
end

function M:raw_set_pos(x, y, z)
  Base.raw_set_pos(self, x, y, z)
end

function M:set_pos(x, y, z, is_last_born_pos)
  if is_last_born_pos then
    local fight_type = TowerMgr:get_fight_type()
    if fight_type == CommonDefine.CHALLENGE_TYPE.CURSE_CIRCLE then
      return
    end
  end
  Base.set_pos(self, x, y, z)
end

function M:on_enter_gamemode()
  self:refresh_hero_pos()
end

function M:refresh_hero_pos()
  local x, y, z = self:get_pos()
  Util.set_role_pos(self, x, y, z)
end

function M:get_buddy_data()
  local id = self.character_cfg.NpcId
  local buddy_data
  if self.v_sync_data then
    buddy_data = self.v_sync_data
  elseif Util.is_client_only() then
    buddy_data = FixedBuddyMgr:get_gm_fight_or_client_only_buddy_info(id, true)
  elseif Util.is_gm_fight() then
    buddy_data = FixedBuddyMgr:get_gm_fight_or_client_only_buddy_info(id)
    if not buddy_data then
      buddy_data = CharacterMgr:get_buddy_by_id(id)
    end
  elseif AssistMgr:is_buddy_assist(id) then
    buddy_data = AssistMgr:get_assist_buddy_info()
  elseif not FixedBuddyMgr:check_is_not_robat(id) then
    local fixed_id = ChapterMgr:check_cur_fight_robot_id(id)
    if fixed_id then
      buddy_data = FixedBuddyMgr:get_fixed_buddy_info(fixed_id)
    end
  else
    buddy_data = CharacterMgr:get_buddy_by_id(id)
  end
  buddy_data = buddy_data or self:creat_buddy_data(id, 1)
  assert(buddy_data, "ERROR BUDDY NONE ID = " .. id)
  return buddy_data
end

function M:creat_buddy_data(id, level)
  local buddy_data = {
    id = id,
    break_lv = 1,
    advance = 1,
    lv = level
  }
  return buddy_data
end

function M:get_base_attrs()
  local id = self.character_cfg.NpcId
  local buddy_data = self:get_buddy_data()
  self:set_level(buddy_data.lv)
  self:set_buddy_data(buddy_data)
  local attrs = CHARACTER_CONFIG.get_buddy_base_attr(id, buddy_data)
  self:add_privilege_attr(attrs)
  self:add_equip_attr(attrs)
  self:add_puzzle_attr(attrs)
  return attrs
end

function M:init_module_attr()
  self:add_talent_attr_ratio()
  self:add_equip_advance_attr_ratio()
  self:add_puzzle_attr_ratio()
end

function M:add_privilege_attr(attrs)
  if not self.v_sync_data then
    return
  end
  if not ChapterMgr then
    return
  end
  local privilege_attr_list = ChapterMgr:get_hero_attr_list()
  if privilege_attr_list and next(privilege_attr_list) then
    for attr_id, attr_info in pairs(privilege_attr_list) do
      if attrs[attr_id] then
        attrs[attr_id].FIXED = attrs[attr_id].FIXED + attr_info.FIXED
        attrs[attr_id].RATIO = attrs[attr_id].RATIO + attr_info.RATIO
      end
    end
  end
end

function M:add_other_sys_attr(attrs, other_add_attrs)
  for attr_id, attr_info in pairs(other_add_attrs) do
    if attrs[attr_id] then
      attrs[attr_id].FIXED = attrs[attr_id].FIXED + attr_info.FIXED
    end
  end
end

function M:add_talent_attr_ratio()
  if not self.v_sync_data then
    return
  end
  local upgrade_talent_cfg = ShareRes.create("buddy.buddy_talent_new_attr")[self.v_sync_data.id]
  if not upgrade_talent_cfg or not self.v_sync_data.talent_lv then
    return
  end
  local attrs = FightDefine.get_empty_attrs()
  local talent_lv = self.v_sync_data.talent_lv
  for lv = 1, talent_lv do
    local talent_lv_cfg = upgrade_talent_cfg[lv]
    if talent_lv_cfg then
      local attr_id = talent_lv_cfg.AttrId
      if 1 == talent_lv_cfg.AttrType then
        attrs[attr_id].RATIO = attrs[attr_id].RATIO + talent_lv_cfg.AttrValue
      end
    end
  end
  self:update_module_attrs(MODULE_ATTR_TYPE.TALENT, attrs)
end

function M:add_equip_attr(attrs)
  if not self.v_sync_data then
    return
  end
  if not CharacterMgr then
    return
  end
  local equip_info = self.v_sync_data.equip_data
  if not equip_info then
    return
  end
  local last_attr = CharacterMgr.cal_equip_attr_no_floor(equip_info.id, equip_info.break_lv, equip_info.lv)
  for attr_key, attr_val in pairs(last_attr) do
    local attr_id = NAME2ATTR[attr_key]
    if attrs[attr_id] then
      attrs[attr_id].FIXED = attrs[attr_id].FIXED + attr_val
    end
  end
  local advance_add_attr_id, advance_add_attr_val = CharacterMgr.get_equip_advance_add_fixed_attr(equip_info.id, equip_info.advance_lv)
  if advance_add_attr_id and attrs[advance_add_attr_id] and advance_add_attr_val then
    attrs[advance_add_attr_id].FIXED = attrs[advance_add_attr_id].FIXED + advance_add_attr_val
  end
end

function M:add_equip_advance_attr_ratio()
  if not self.v_sync_data then
    return
  end
  if not CharacterMgr then
    return
  end
  local equip_info = self.v_sync_data.equip_data
  if not equip_info then
    return
  end
  local attrs = FightDefine.get_empty_attrs()
  local advance_add_attr_id, advance_add_attr_val, is_ratio = CharacterMgr.get_equip_advance_add_fixed_attr(equip_info.id, equip_info.advance_lv, true)
  if advance_add_attr_id and attrs[advance_add_attr_id] and advance_add_attr_val and is_ratio then
    attrs[advance_add_attr_id].RATIO = attrs[advance_add_attr_id].RATIO + advance_add_attr_val
  end
  self:update_module_attrs(MODULE_ATTR_TYPE.EQUIP, attrs)
end

function M:add_puzzle_attr(attrs)
  if not self.v_sync_data then
    return
  end
  local puzzle_graph = self.v_sync_data.puzzle_graph
  if not puzzle_graph or not puzzle_graph.puzzle_place_infos then
    return
  end
  for _, puzzle_place_info in ipairs(puzzle_graph.puzzle_place_infos) do
    if puzzle_place_info.attr_list then
      for _, attr_cfg_id in ipairs(puzzle_place_info.attr_list) do
        local attr_cfg = ShareRes.get_buddy_puzzle_attr_cfg(attr_cfg_id)
        local attr_id = attr_cfg.AttrId
        if attrs[attr_id] and 0 == attr_cfg.AttrType then
          attrs[attr_id].FIXED = attrs[attr_id].FIXED + attr_cfg.AttrValue
        end
      end
    end
  end
end

function M:add_puzzle_attr_ratio()
  if not self.v_sync_data then
    return
  end
  local puzzle_graph = self.v_sync_data.puzzle_graph
  if not puzzle_graph or not puzzle_graph.puzzle_place_infos then
    return
  end
  local attrs = FightDefine.get_empty_attrs()
  for _, puzzle_place_info in ipairs(puzzle_graph.puzzle_place_infos) do
    if puzzle_place_info.attr_list then
      for _, attr_cfg_id in ipairs(puzzle_place_info.attr_list) do
        local attr_cfg = ShareRes.get_buddy_puzzle_attr_cfg(attr_cfg_id)
        local attr_id = attr_cfg.AttrId
        if attrs[attr_id] and 1 == attr_cfg.AttrType then
          attrs[attr_id].RATIO = attrs[attr_id].RATIO + attr_cfg.AttrValue
        end
      end
    end
  end
  self:update_module_attrs(MODULE_ATTR_TYPE.PUZZLE, attrs)
end

function M:get_hero_name()
  return self.buddy_cfg.Name
end

function M:on_be_targeted(target_uuid)
  Base.on_be_targeted(self, target_uuid)
  self.v_betarget_map[target_uuid] = true
end

function M:on_cancel_targetd(target_uuid)
  if not target_uuid then
    return
  end
  Base.on_cancel_targetd(self, target_uuid)
  local effect_id = self.v_betargeted_effect[target_uuid]
  if effect_id and self.act_effect_ctrl then
    if Global.camera:get_camera_mode() == Config.CAMERA_VIEW_TYPE.DEPRESSION then
      self:clear_arrow_record(effect_id)
      self.act_effect_ctrl:stop_effect(effect_id)
    elseif Global.camera:get_camera_mode() == Config.CAMERA_VIEW_TYPE.SHOULDER or Global.camera:is_first_person_camera() then
      self:clear_arrow_record(effect_id)
      self.act_effect_ctrl:stop_effect(effect_id)
    end
  end
  self.v_betarget_map[target_uuid] = nil
  if self.v_monster_new_arrow_state then
    self.v_monster_new_arrow_state[target_uuid] = nil
  end
end

function M:get_betargetd_map()
  return self.v_betarget_map
end

function M:is_betargeted()
  return UtilTable.hash_lenth(self.v_betarget_map) > 0
end

function M:_on_scene_skill_lv_up()
  if self.in_background then
    return
  end
  local effect_param = self.act_effect_ctrl.create_effect_param()
  effect_param.prefab_name = "Fx_Hero_levelSkill_upgrade"
  effect_param.parent = self:get_setting_point(Config.BLOOD_ATTACH) or self.transform
end

function M:_on_item_picked(msg)
  local item = msg.mm_obj
  local effect_id = UtilTable.table_find(self.v_item_arrow, item)
  if effect_id then
    self:clear_arrow_record(effect_id)
    self.act_effect_ctrl:stop_effect(effect_id)
    self.v_item_arrow[effect_id] = nil
    self.v_drop_to_room[effect_id] = nil
  end
end

function M:_on_scene_item_clear()
  for effect_id, item in pairs(self.v_item_arrow) do
    self:clear_arrow_record(effect_id)
    self.act_effect_ctrl:stop_effect(effect_id)
    self.v_item_arrow[effect_id] = nil
    self.v_drop_to_room[effect_id] = nil
  end
end

function M:clear_arrow_record(effect_id)
  local gameobj = self.act_effect_ctrl:get_effect_gameobject(effect_id)
  if not gameobj then
    return
  end
  self.v_arrow_visibles[gameobj] = nil
  self.v_arrow_colors[gameobj] = nil
end

function M:update_betargeted_effect()
  if self.v_show_betargeted_arrow then
    for target_uuid, _ in pairs(self.v_betarget_map) do
      local target = SceneMgr:pick_by_uuid(target_uuid)
      local effect_id = self.v_betargeted_effect[target_uuid]
      if not target or target:is_destroy() then
        if effect_id then
          self:clear_arrow_record(effect_id)
          self.act_effect_ctrl:stop_effect(effect_id)
        end
        self.v_betarget_map[target_uuid] = nil
      else
        if not effect_id then
          if Global.camera:get_camera_mode() == Config.CAMERA_VIEW_TYPE.DEPRESSION then
            local effect_param = self.act_effect_ctrl.create_effect_param()
            effect_param.prefab_name = Config.ARROWS_EFFECT_NAME
            effect_param.parent = self.transform
            effect_id = self.act_effect_ctrl:play_effect(effect_param)
            self.v_betargeted_effect[target_uuid] = effect_id
            self.v_guid_arrow_visible = true
          elseif Global.camera:get_camera_mode() == Config.CAMERA_VIEW_TYPE.SHOULDER or Global.camera:is_first_person_camera() then
            local effect_param = self.act_effect_ctrl.create_effect_param()
            effect_param.prefab_name = Config.NEW_ARROWS_EFFECT_NAME
            effect_param.parent = self.transform
            effect_id = self.act_effect_ctrl:play_effect(effect_param)
            self.v_betargeted_effect[target_uuid] = effect_id
            self.v_guid_arrow_visible = true
            if not self.v_monster_new_arrow_state[target_uuid] then
              self.v_monster_new_arrow_state[target_uuid] = Config.ARROWS_EFFECT_COLOR.RED
            end
            TEMP_PARAMS.arrows_effect_color = self.v_monster_new_arrow_state[target_uuid]
          end
        end
        local is_in_screen = Util.is_obj_in_screen(target)
        local is_hide_effect = is_in_screen or not self.v_cursor_enable
        if not SceneMgr:is_show_footmark_state() then
          is_hide_effect = true
        end
        if Global.camera:get_camera_mode() == Config.CAMERA_VIEW_TYPE.DEPRESSION then
          local x, z = target:get_pos2()
          self:set_arrow_effect_pos(x, z, effect_id, is_hide_effect, INDICATOR.MONSTER)
        elseif Global.camera:get_camera_mode() == Config.CAMERA_VIEW_TYPE.SHOULDER or Global.camera:is_first_person_camera() then
          local x, z = target:get_pos2()
          TEMP_PARAMS.arrows_effect_color = self.v_monster_new_arrow_state[target_uuid]
          self:set_arrow_effect_pos(x, z, effect_id, is_hide_effect, INDICATOR.MONSTER_NEW, TEMP_PARAMS, MONSTER_NEW_ARROWS_OFFSET_Y)
        end
      end
    end
  end
  local scene_logic = SceneMgr:get_scene_logic()
  if scene_logic then
    local is_show_arrow = false
    if TowerMgr then
      local tower = TowerMgr:get_tower()
      if tower then
        is_show_arrow = tower:is_show_arrow()
      end
    end
    local tp_obj_pos = scene_logic:get_tp_obj_pos()
    if is_show_arrow then
      self:update_navigator_tp_mark()
      for name, tp_data in pairs(tp_obj_pos) do
        if not self:show_maze_tp_point_mark(tp_data.idx) then
        else
          local effect_id = self.v_tp_self_effect[name]
          if not effect_id then
            effect_id = self:get_new_tp_effect()
            self.v_tp_self_effect[name] = effect_id
          end
          TEMP_PARAMS.name = name
          TEMP_PARAMS.idx = tp_data.idx
          self:set_arrow_effect_pos(tp_data.x, tp_data.z, effect_id, false, INDICATOR.TP_POINT, TEMP_PARAMS)
        end
      end
    end
    for k, effect_id in pairs(self.v_tp_self_effect) do
      if not is_show_arrow or not tp_obj_pos[k] then
        self:clear_arrow_record(effect_id)
        self.act_effect_ctrl:stop_effect(effect_id)
        self.v_tp_self_effect[k] = nil
      end
    end
  end
end

local temp_target_pos_vec3 = Vec3.New()

function M:update_navi_list_arrows()
  local x, y, z
  for key_name, info in pairs(self.v_navi_arrows_info_list) do
    if info.is_show and (not info.room_id or not self:check_arrows_point_to_room(key_name, info)) and (not info.track_task_id or not self:check_arrows_task(key_name, info)) then
      if info.target_is_npc then
        local npc = SceneMgr:get_npc_by_name(key_name)
        x, y, z = npc:get_pos()
      else
        local scene_map = SceneMgr:get_scene_map()
        if not scene_map then
          return
        end
        local target_pos = scene_map:get_area_position(key_name)
        if target_pos then
          x, y, z = target_pos.X, target_pos.Y, target_pos.Z
        end
      end
      if x and z then
        if Global.camera:get_camera_mode() == Config.CAMERA_VIEW_TYPE.DEPRESSION then
          if not info.effect_id then
            info.effect_id = self:get_new_tp_effect()
          end
          TEMP_PARAMS.name = NAVI_TP_NAME
          TEMP_PARAMS.idx = self.v_navigator_tp_idx
          self:set_arrow_effect_pos(x, z, info.effect_id, false, INDICATOR.TP_POINT, TEMP_PARAMS)
          if info.navigation_hud then
            info.navigation_hud:set_visible(false)
          end
        elseif Global.camera:get_camera_mode() == Config.CAMERA_VIEW_TYPE.SHOULDER or Global.camera:is_first_person_camera() then
          self:set_arrow_effect_pos(x, z, info.effect_id, true, INDICATOR.TP_POINT, TEMP_PARAMS)
          if not info.navigation_hud then
            temp_target_pos_vec3:Set(x, y, z)
            info.navigation_hud = Global.ui_dynamic_canvas:get_navigation_hud_item(temp_target_pos_vec3, self:get_pos_vec3())
          end
          if StoryMgr then
            local is_play_story = StoryMgr:is_playing_full_screen_story()
            if is_play_story then
              info.navigation_hud:set_visible(false)
            else
              info.navigation_hud:set_visible(true)
              temp_target_pos_vec3:Set(x, y, z)
              info.navigation_hud:update(temp_target_pos_vec3, self:get_pos_vec3())
            end
          end
        end
        self.v_navigator_tp_show = true
      end
    end
  end
end

function M:check_arrows_point_to_room(key_name, info)
  local cur_room_id = TowerMgr:get_cur_room_id()
  if cur_room_id ~= info.room_id then
    self:set_navi_arrows_info(key_name, false)
    return true
  end
end

function M:check_arrows_task(key_name, info)
  if info.track_task_id ~= BattleTaskMgr:get_track_task_id() then
    self:set_navi_arrows_info(key_name, false)
    return true
  end
  local task_item = BattleTaskMgr:get_task(info.track_task_id)
  if task_item then
    if not task_item:get_is_processing() then
      self:set_navi_arrows_info(key_name, false)
      return true
    end
    if info.condition_id and task_item:check_condition_complete(info.condition_id) then
      self:set_navi_arrows_info(key_name, false)
      return true
    end
  end
end

local temp_pos_vec3 = Vec3.New()

function M:update_navigator_tp_mark()
  local is_clear, is_clear_list = true, true
  if self:show_navigator_tp_point_mark() then
    local x, y, z, pos
    local scene_logic = SceneMgr:get_scene_logic()
    if scene_logic:get_is_navigating_by_logic() then
      pos = self.v_task_navigator_pos
      x, y, z = pos.x, pos.y, pos.z
    elseif self.v_navigator_point_name then
      local scene_map = scene_logic:get_scene_map()
      pos = scene_map:get_area_position(self.v_navigator_point_name)
      x, y, z = pos.X, pos.Y, pos.Z
    elseif self.v_navigator_tp_idx then
      local scene_map = scene_logic:get_scene_map()
      pos = scene_map:get_area_position("tp" .. self.v_navigator_tp_idx)
      x, y, z = pos.X, pos.Y, pos.Z
    end
    if pos then
      if Global.camera:get_camera_mode() == Config.CAMERA_VIEW_TYPE.SHOULDER or Global.camera:is_first_person_camera() then
        local ui_navigation = not Global.ui_dynamic_canvas or Global.ui_dynamic_canvas:get_ui_navigation() or Global.ui_dynamic_canvas:create_hud_navigation()
        if StoryMgr and ui_navigation then
          local is_play_story = StoryMgr:is_playing_full_screen_story()
          if is_play_story then
            ui_navigation:set_visible(false)
          else
            local ui_fight = UIMgr:try_get_ui("fight")
            if ui_fight and ui_fight:check_show_ui_obj("Main") then
              ui_navigation:set_visible(true)
              temp_pos_vec3:Set(x, y, z)
              ui_navigation:update(temp_pos_vec3, self:get_pos_vec3())
              self.v_navigator_tp_show = true
            end
          end
        end
      elseif Global.camera:get_camera_mode() == Config.CAMERA_VIEW_TYPE.DEPRESSION then
        if Global.ui_dynamic_canvas and Global.ui_dynamic_canvas:get_ui_navigation() then
          Global.ui_dynamic_canvas:get_ui_navigation():set_visible(false)
        end
        if not self.v_navigator_effect_id then
          self.v_navigator_effect_id = self:get_new_tp_effect()
        end
        TEMP_PARAMS.name = NAVI_TP_NAME
        TEMP_PARAMS.idx = self.v_navigator_tp_idx
        if self.v_target_waypoint then
          x, z = self.v_target_waypoint.x, self.v_target_waypoint.z
        end
        if self.v_last_arrow_x and self.v_lerp_arrow then
          x = mathx.lerp_number(self.v_last_arrow_x, x, 5 * GlobalTimeMgr:get_dt_time())
          z = mathx.lerp_number(self.v_last_arrow_z, z, 5 * GlobalTimeMgr:get_dt_time())
        end
        self.v_lerp_arrow = true
        self.v_last_arrow_x = x
        self.v_last_arrow_z = z
        self:set_arrow_effect_pos(x, z, self.v_navigator_effect_id, false, INDICATOR.TP_POINT, TEMP_PARAMS)
        is_clear = false
      end
    else
      if Global.ui_dynamic_canvas and Global.ui_dynamic_canvas:get_ui_navigation() then
        Global.ui_dynamic_canvas:get_ui_navigation():set_visible(false)
      end
      self.v_navigator_tp_show = false
    end
    if next(self.v_navi_arrows_info_list) then
      self:update_navi_list_arrows()
      is_clear_list = false
    end
  else
    if Global.ui_dynamic_canvas and Global.ui_dynamic_canvas:get_ui_navigation() then
      Global.ui_dynamic_canvas:get_ui_navigation():set_visible(false)
    end
    self.v_navigator_tp_show = false
  end
  if is_clear and self.v_navigator_effect_id then
    self:clear_arrow_record(self.v_navigator_effect_id)
    self.act_effect_ctrl:stop_effect(self.v_navigator_effect_id)
    self.v_navigator_effect_id = nil
  end
  if is_clear_list then
    for key, info in pairs(self.v_navi_arrows_info_list) do
      if info.effect_id then
        self:clear_arrow_record(info.effect_id)
        self.act_effect_ctrl:stop_effect(info.effect_id)
        info.effect_id = nil
      end
      if info.navigation_hud then
        Global.ui_dynamic_canvas:release_navigation_hud_item(info.navigation_hud)
        info.navigation_hud = nil
      end
    end
  end
end

function M:get_new_tp_effect()
  local effect_param = self.act_effect_ctrl.create_effect_param()
  effect_param.prefab_name = Config.ARROWS_EFFECT_NAME
  effect_param.parent = self.transform
  local effect_id = self.act_effect_ctrl:play_effect(effect_param)
  return effect_id
end

function M:show_navigator_tp_point_mark()
  local fight_type = TowerMgr:get_fight_type()
  if not fight_type then
    return
  end
  if SceneMgr:check_our_camp_betarget() then
    return
  end
  local tower = TowerMgr:get_tower()
  if tower:is_maze_room() then
    return
  end
  return true
end

function M:show_maze_tp_point_mark(tp_idx)
  local fight_type = TowerMgr:get_fight_type()
  if not fight_type then
    return
  end
  if SceneMgr:check_our_camp_betarget() then
    return
  end
  local tower = TowerMgr:get_tower()
  if tower:is_maze_room() then
    return true
  end
end

function M:update_drop_guid_arrow()
  if not TowerMgr then
    return
  end
  local tower = TowerMgr:get_tower()
  if not tower then
    return
  end
  local room = tower:get_room()
  if not room then
    return
  end
  local room_num = room:get_room_num()
  for effect_id, item in pairs(self.v_item_arrow) do
    local tar = item.item_obj_list and item.item_obj_list[1]
    if tar and not tar:IsNull() then
      local x, _, z = tar.transform:GetPositionA()
      local is_in_screen = Util.is_gameobj_in_screen(tar)
      local drop_room_num = self.v_drop_to_room[effect_id]
      if drop_room_num and drop_room_num ~= room_num then
        is_in_screen = true
      end
      self:set_arrow_effect_pos(x, z, effect_id, is_in_screen or not tar.activeInHierarchy, INDICATOR.DROP)
    end
  end
end

function M:set_arrow_effect_pos(x, z, effect_id, is_in_screen, effect_type, params, offset_y)
  if not self.v_guid_arrow_visible then
    return
  end
  local gameobject = self.act_effect_ctrl:get_effect_gameobject(effect_id)
  if gameobject then
    local visible
    if not is_in_screen then
      local euler = Math.get_lookat_dir(self.v_position.x, self.v_position.z, x, z)
      gameobject.transform:SetEulerY(euler)
      if effect_type == INDICATOR.MONSTER_NEW and offset_y then
        gameobject.transform:SetLocalPositionA(0, offset_y, 0)
      end
      self:update_effect_color(gameobject, effect_type, params)
      visible = not self:is_hide_footmark(effect_type)
    else
      visible = false
    end
    local old_visible = self.v_arrow_visibles[gameobject]
    if params and params.name == NAVI_TP_NAME then
      self.v_navigator_tp_show = visible
    end
    if old_visible ~= visible then
      gameobject:SetActive(visible)
      self.v_arrow_visibles[gameobject] = visible
    end
  end
end

function M:is_hide_footmark(effect_type)
  if not TowerMgr then
    return false
  end
  local room = TowerMgr:get_cur_room()
  if not room then
    return false
  end
  return room:get_is_cancel_footmark() and effect_type == INDICATOR.TP_POINT
end

function M:update_effect_color(gameobj, effect_type, params)
  if not TowerMgr then
    return
  end
  local tower = TowerMgr:get_tower()
  if not tower then
    return
  end
  local color_name
  if effect_type == INDICATOR.TP_POINT then
    if not tower:is_maze_room() then
      color_name = Config.ARROWS_EFFECT_COLOR.ORANGE
    elseif params and params.idx then
      local is_use = TowerMgr:check_tp_use_by_idx(params.idx)
      color_name = is_use and Config.ARROWS_EFFECT_COLOR.WHITE or Config.ARROWS_EFFECT_COLOR.YELLOW
    end
  elseif effect_type == INDICATOR.MONSTER then
    color_name = Config.ARROWS_EFFECT_COLOR.RED
  elseif effect_type == INDICATOR.MONSTER_NEW then
    color_name = TEMP_PARAMS.arrows_effect_color
  end
  if not color_name then
    return
  end
  local old_color_name = self.v_arrow_colors[gameobj]
  if color_name ~= old_color_name then
    self.v_arrow_colors[gameobj] = color_name
    local tf = gameobj.transform
    local count = tf.childCount
    local child
    for index = 0, count - 1 do
      child = tf:GetChild(index)
      if child then
        child.transform:SetActive(child.name == color_name)
      end
    end
  end
end

function M:check_background()
  return self.in_background
end

function M:check_play_switch_sound()
  if not TowerMgr then
    return
  end
  local tower = TowerMgr:get_tower()
  if not tower then
    return
  end
  local is_pass = tower:is_pass_room()
  local state_id = is_pass and Config.FIGHT_STATE.LEISURE_SWITCH_CHAR or Config.FIGHT_STATE.FIGHT_SWITCH_CHAR
  if Global.state_sound_mgr then
    Global.state_sound_mgr:trigger_fight_state_by_id(state_id)
  end
end

function M:on_to_control_state(first_go_out)
  self:add_fake_sp_on_change(true)
  self:set_current_state(Config.HERO_STATE.IN_CONTROL)
  self.v_lerp_arrow = false
  if not first_go_out then
    local hero_pos
    if self.v_use_pos_type == Config.HERO_POS_CHANGE_TYPE.TRANSFER_POS then
      hero_pos = self.v_latest_pos
    elseif self.v_use_pos_type == Config.HERO_POS_CHANGE_TYPE.GLOBAL_POS then
      hero_pos = FightDataMgr.latest_hero_pos
    end
    if hero_pos then
      local dir = FightDataMgr.latest_hero_dir
      self:set_target_dir(dir, true)
      self:set_pos_vec(hero_pos)
      self.v_use_latest_pos = false
    end
    self:create_circle_effect()
  end
  self:set_use_pos_type(Config.HERO_POS_CHANGE_TYPE.GLOBAL_POS)
  Global.hero_uuid = self.uuid
  Global.hero = self
  local fight = UIMgr:try_get_ui("fight")
  if fight then
    local hero_head_view = fight:get_panel("hero_head_view")
    if first_go_out then
      hero_head_view:force_reset_head_info()
    end
    hero_head_view:response_hero_go_out()
  end
  self:set_obj_enable(true)
  self.v_is_can_searched = true
  self:refresh_anim_speed()
  BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.ON_HERO_SHOWUP_OR_BACK, self, true, self.by_ult_change)
  self:set_by_ult_change(false)
  if not first_go_out then
    self:check_play_switch_sound()
    self:refresh_task_condition_arrow()
    self:update_pos_height()
  end
  self:_reset_area_mask()
  if self.gameobj ~= nil then
    CSHelper.ForceLODGroup(self.gameobj.transform, -1)
  end
  local msg = MsgGame:mq_publish2(Const.MSG_HERO_GO_OUT)
  msg.mm_obj = self
  msg.mm_y = self.v_current_state
end

function M:on_to_ground_state(keycode)
  self:set_current_state(Config.HERO_STATE.IN_GROUND)
  if keycode then
    local fight = UIMgr:try_get_loaded_ui(UIMgr.FIGHT_UI_NAME)
    if fight then
      local hero_head_view = fight:get_panel("hero_head_view")
      hero_head_view:response_hero_go_background(self, keycode)
    end
    local msg = MsgGame:mq_publish2(Const.MSG_HERO_GO_BACKGORUND)
    msg.mm_obj = self
    msg.mm_x = keycode
    msg.mm_y = self.v_current_state
  end
  BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.ON_HERO_ENTER_GROUND_STATE, self)
  self:clear_arrow_effect()
  self:clear_circle_effect()
end

function M:on_to_background_state(keycode, first)
  self:add_fake_sp_on_change(true)
  self:set_current_state(Config.HERO_STATE.IN_BACKGROUND)
  if keycode then
    local fight = UIMgr:try_get_loaded_ui(UIMgr.FIGHT_UI_NAME)
    if fight then
      local hero_head_view = fight:get_panel("hero_head_view")
      hero_head_view:response_hero_go_background(self, keycode, first)
    end
    local msg = MsgGame:mq_publish2(Const.MSG_HERO_GO_BACKGORUND)
    msg.mm_obj = self
    msg.mm_x = keycode
    msg.mm_y = self.v_current_state
  end
  self.v_is_can_searched = false
  if self.weapon_mgr then
    self.weapon_mgr:on_hero_to_background()
  end
  BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.ON_HERO_SHOWUP_OR_BACK, self, false, self.by_ult_change)
  self:set_by_ult_change(false)
  self:set_obj_enable(false)
  self:clear_navigator_effect()
  self.skill_mgr:abort(Config.SKILL_ABORT_TYPE.FOECE | Config.SKILL_ABORT_TYPE.BREAK_ABORT)
  if self.gameobj ~= nil then
    CSHelper.ForceLODGroup(self.gameobj.transform, 0)
  end
end

function M:on_exit_control_state()
  self.magic_mgr:on_role_exit_control()
  self.time_mgr:on_role_exit_control()
end

function M:_on_add_transparent_obj()
  print("_on_add _transparent_obj")
end

function M:_on_del_transparent_obj()
  print("_on_del_transparent_obj")
end

function M:get_module_attrs()
  local newAttrs = {}
  for t, attrs in pairs(self.v_module_attrs) do
    for attrType, attr in pairs(attrs) do
      local total_attr = newAttrs[attrType]
      if not total_attr then
        total_attr = FightDefine.init_single_attr()
        newAttrs[attrType] = total_attr
      end
      FightDefine.single_attr_add(total_attr, attr)
    end
  end
  return newAttrs
end

function M:update_module_attrs(module_type, attrs, sync)
  if self.v_module_attrs[module_type] then
    for _, single_attr in pairs(self.v_module_attrs[module_type]) do
      FightDefine.push_single_attr_temp(single_attr)
    end
  end
  self.v_module_attrs[module_type] = attrs
  if CommonDefine.MODULE_FOLLOW_HP_MAX[module_type] and attrs[ATTR_TYPE.CHAR_HP_MAX] and not self.nLastMaxHp and self.attr_mgr then
    self.nLastMaxHp = self.attr_mgr:get_attr_max(ATTR_TYPE.CHAR_HP)
  end
  if sync then
    self:sync_module_attrs()
  end
end

function M:sync_module_attrs()
  self.attr_mgr:update_module_attrs()
  if StateReport then
    StateReport:sync_module_attrs(self.uuid)
  end
end

function M:on_enter_room()
  self.char_renderers:before_fight()
  if Util.is_client_only() then
    self:setup_born_behavior()
  end
  self:clear_arrow_effect()
  if not self:navigator_task_room() then
    self:navigator_task_room(nil, true, true)
  end
  if not self.v_have_refresh_arrow then
    self:refresh_task_condition_arrow()
  end
  self:_reset_area_mask()
  self:create_circle_effect()
  if self.gameobj ~= nil then
    CSHelper.ForceLODGroup(self.gameobj.transform, -1)
  end
end

function M:check_creat_charged_res()
  if self.v_loading or self.v_charged_obj then
    return
  end
  local id = self.character_cfg.AttribId
  local character_cfg = ShareRes.create("buddy.buddy", id)
  if not character_cfg or 1 ~= character_cfg.IsChargedRes then
    return
  end
  local prefab_name = "Charged_Res"
  local ui = UIMgr:get_ui("uidynamic_canvas")
  if not ui then
    return
  end
  self.v_loading = true
  local delta_x = Global.ui_dynamic_canvas:get_rect_size_delta_x()
  local delta_y = Global.ui_dynamic_canvas:get_rect_size_delta_y()
  self.v_canvas_scale_x = delta_x / Global.screen_width
  self.v_canvas_scale_y = delta_y / Global.screen_height
  self.v_camera = Global.camera:get_camera()
  ResPoolMgr:get_ui_effect_async(prefab_name, function(go)
    local attach_point = self:get_setting_point(UI_POINT_NAME)
    if not attach_point then
      self.v_loading = false
      ResPoolMgr:release(go)
      return
    end
    go.transform:SetParent(ui:get_object_transform())
    go:ResetAttr()
    self.v_charged_obj = go
    self.v_charged_content_rect = self.v_charged_obj:GetComponent(TypeUnityRectTransform)
    self.v_charged_effect = self.v_charged_obj:FindChild("Charge_Sign/Charge_Effect")
    self.v_fill_img = self.v_charged_obj:FindChild("Charge_Slider/Fill Area/Fill"):GetComponent(TypeUnityUIImage)
    self.v_charge_sign_rect = self.v_charged_obj:FindChild("Charge_Sign"):GetComponent(TypeUnityRectTransform)
    self.v_charge_slider = self.v_charged_obj:FindChild("Charge_Slider"):GetComponent(TypeUnityUISlider)
    self.v_praticle = self.v_charged_effect:GetComponent(TypeEffectStatus)
    self.v_charged_obj.gameObject:SetActive(false)
  end)
end

function M:update_charged_obj_position()
  if self.in_background then
    return
  end
  if not self.v_charged_obj or self.v_charged_obj:IsNull() or not Global.camera then
    return
  end
  local attach_point = self:get_setting_point(UI_POINT_NAME)
  if not attach_point then
    return
  end
  local x, y, z = attach_point.transform:GetPositionA()
  assert(self.v_canvas_scale_x, "canvas_scale_x error")
  assert(self.v_canvas_scale_y, "canvas_scale_y error")
  CompExtensions.SetToScreenPosInCanvas(self.v_camera, self.v_charged_obj.transform, self.v_canvas_scale_x, self.v_canvas_scale_y, x, y, z)
end

function M:set_charged_obj_visible(is_show)
  if not self.v_charged_obj then
    return
  end
  self.v_charged_obj.gameObject:SetActive(is_show)
end

function M:update_charge_view(charge_type, all_time, charge_time)
  if not self.v_charged_obj then
    return
  end
  if self.v_charge_sequence then
    self.v_charge_sequence:Kill(false)
    self.v_charge_sequence = nil
  end
  self.v_charged_obj.gameObject:SetActive(true)
  self.v_charged_effect.gameObject:SetActive(false)
  local is_charge = false
  local path = "UIFight/Battle_ChargeBar_2"
  local img = self.v_fill_img
  ResMgr:load_set_icon(img, path)
  local percent = charge_time / all_time
  local content_width = self.v_charged_content_rect:GetRectWH()
  local sign_rect = self.v_charge_sign_rect
  local img_width = sign_rect:GetRectWH()
  local pos_x = content_width * percent - img_width / 2
  if charge_type == CHARGE_TYPE.FULL then
    pos_x = content_width - pos_x
    percent = 1 - percent
  end
  sign_rect:SetAnchoredPositionA(pos_x, 0)
  local slider_obj = self.v_charge_slider
  slider_obj.value = charge_type == CHARGE_TYPE.FULL and 1 or 0
  self.v_charge_sequence = Util.create_sequence()
  self.v_charge_sequence:SetEase(ease_linear)
  if charge_type == CHARGE_TYPE.FULL then
    self.v_charge_sequence:Append(slider_obj:DOValue(0, all_time):SetEase(ease_linear))
  elseif charge_type == CHARGE_TYPE.EMPTY then
    self.v_charge_sequence:Append(slider_obj:DOValue(1, all_time):SetEase(ease_linear))
  end
  local path2 = "UIFight/Battle_ChargeBar_4"
  self.v_charge_sequence:OnUpdate(function()
    local cur_val = slider_obj.value
    if charge_type == CHARGE_TYPE.EMPTY and cur_val > percent or charge_type == CHARGE_TYPE.FULL and cur_val < percent then
      if not is_charge then
        ResMgr:load_set_icon(img, path2)
        self.v_charged_effect.gameObject:SetActive(true)
        self.v_praticle:RestartEffects()
      end
      is_charge = true
    end
  end)
  self.v_charge_sequence:AppendCallback(function()
    self.v_charged_obj.gameObject:SetActive(false)
    if self.v_charge_sequence then
      self.v_charge_sequence:Kill(false)
      self.v_charge_sequence = nil
    end
  end)
end

local ATTR_TYPE = FightDefine.ATTR_TYPE
local RES_TYPE2ATTR = {
  [3] = {
    ATTR_TYPE.CHAR_FIGHT_LINE_BAR,
    ATTR_TYPE.CHAR_FIGHT_LINE_BAR_MAX
  }
}

function M:get_energy()
  self.v_res_type = self.v_res_type or self.buddy_cfg.ShowFightResType
  local type = RES_TYPE2ATTR[self.v_res_type]
  if not type then
    return 0, self.v_res_type
  end
  local attr_mgr = self.attr_mgr
  local value = attr_mgr:get_attr(type[1]) / attr_mgr:get_attr(type[2])
  return value, self.v_res_type
end

function M:get_cur_energy()
  self.v_res_type = self.v_res_type or self.buddy_cfg.ShowFightResType
  local type = RES_TYPE2ATTR[self.v_res_type]
  if not type then
    return
  end
  return self.attr_mgr:get_attr(type[1])
end

local BOUNDARY_COLLISION_TYPE = FightConfig.BOUNDARY_COLLISION_TYPE

function M:on_collide_wall(dx, dz, collider_info, collider_type)
  if collider_info or collider_type then
    self:play_interact_effect(dx, dz, collider_info, collider_type)
  end
  if self.v_collided then
    self:get_collide_move_param(dx, dz, collider_info, collider_type)
  end
end

local function _on_collider_border(self, collider_type)
  local cur_dir = self:get_dir()
  local collider_x = 1 == collider_type % 2
  local dir = math.ceil(cur_dir)
  local range1, range2
  if collider_x then
    local fixed_dir1, fixed_dir2
    if collider_type == BOUNDARY_COLLISION_TYPE.RIGHT_X then
      range1, range2 = 0, 180
      fixed_dir1, fixed_dir2 = 180, 0
    else
      range1, range2 = 180, 360
      fixed_dir1, fixed_dir2 = 0, 180
    end
    if dir > range1 and dir < range2 then
      local cal_dir = dir % 180 - 90
      if Util.almost_zero(cal_dir) then
        self.collide_move_rate = 0
      elseif cal_dir > 0 then
        self.collide_fixed_dir = fixed_dir1
      else
        self.collide_fixed_dir = fixed_dir2
      end
      self.collide_move_rate = math.abs(cal_dir) / 90
    end
  elseif collider_type == BOUNDARY_COLLISION_TYPE.TOP_Z then
    if dir > 270 and dir < 360 then
      self.collide_move_rate = (90 - dir % 90) / 90
      self.collide_fixed_dir = 270
    elseif dir > 0 and dir < 90 then
      self.collide_move_rate = dir / 90
      self.collide_fixed_dir = 90
    elseif 360 == dir then
      self.collide_move_rate = 0
    end
  elseif collider_type == BOUNDARY_COLLISION_TYPE.BOTTOM_Z then
    if dir < 270 and dir > 90 then
      self.collide_move_rate = math.abs(2 - dir / 90)
    end
    local dif = dir - 180
    if Util.almost_zero(dif) then
      self.collide_move_rate = 0
    elseif dif > 0 then
      self.collide_fixed_dir = 270
    else
      self.collide_fixed_dir = 90
    end
  end
end

local function _on_collider_emptywall(self, collider_info)
  local cur_dir = self:get_dir()
  local box_transform = collider_info.box_collider.transform
  local x, _, z = box_transform:GetInverseTransformPointA(self:get_pos())
  local _, ey, _ = box_transform:GetEulerAnglesA3()
  local half_size_x = collider_info.box_half_size.x
  local half_size_z = collider_info.box_half_size.z
  local cal_dir
  ey = Math.get_positibe_angle(ey)
  if x > half_size_x then
    cal_dir = ey + 270
  elseif x < -half_size_x then
    cal_dir = ey + 90
  elseif z > half_size_z then
    cal_dir = ey + 180
  else
    cal_dir = ey
  end
  cal_dir = cal_dir % 360
  local angle = math.abs(cal_dir - cur_dir) % 360
  if angle > 180 then
    angle = 360 - angle
    self.collide_fixed_dir = ey - 90
  elseif 0 == angle then
    angle = 0
  else
    self.collide_fixed_dir = ey + 90
  end
  self.collide_move_rate = math.abs(angle / 90)
end

local function _on_collider_other(self)
  local cur_dir = self:get_dir()
  Vec3.GetRotatedVector(0, cur_dir, 0, Vec3.forward, Util.VEC3_TEMP)
  local x, y, z = self:get_pos()
  local dirx, diry, dirz = Util.VEC3_TEMP:Get()
  local suc, _, nx, _, nz = Util.raycast_with_normal(x, y + 0.5, z, dirx, diry, dirz, nil, self.radius + 2.5)
  if suc then
    local cross_product = Vec2.CrossA(dirx, dirz, nx, nz)
    if Util.almost_zero(cross_product) then
      self.collide_move_rate = 0
      return
    end
    local dot_product = Vec3.DotA(dirx, 0, dirz, -nx, 0, -nz)
    if Util.almost_zero(dot_product) or Util.almost_zero(dot_product - 1) then
      self.collide_move_rate = 0
    else
      local angle = math.acos(Math.Clamp(dot_product, -1, 1)) * Math.Rad2Deg
      local cal_angle = angle
      if angle < 90 then
        local comp_angle = 90 - math.abs(cal_angle % 90)
        if cross_product < 0 then
          cal_angle = cur_dir + comp_angle
        else
          cal_angle = cur_dir - comp_angle
        end
        self.collide_move_rate = angle / 90
        if Util.almost_zero(cal_angle) then
          cal_angle = cross_product < 0 and 180 or 90
        end
        self.collide_fixed_dir = Math.get_positibe_angle(cal_angle)
      end
    end
  end
end

function M:get_collide_move_param(dx, dz, collider_info, collider_type)
  if not self.in_control or self.v_is_overlap then
    return
  end
  if collider_type then
    _on_collider_border(self, collider_type)
  else
    _on_collider_other(self)
  end
  if self.collide_move_rate then
    local coef = self.skill_mgr:get_collide_move_coef() or CollidedMoveCoef
    self.collide_move_rate = Math.Clamp01(self.collide_move_rate) * coef
  end
  if self.collide_fixed_dir then
    self.collide_fixed_dir = Math.get_positibe_angle(self.collide_fixed_dir)
  end
end

function M:play_interact_effect(dx, dz, collider_info, collider_type)
  if self.v_play_wall_effect then
    return
  end
  
  local function create_callback(effect_info)
    if collider_type == BOUNDARY_COLLISION_TYPE.RIGHT_X or collider_type == BOUNDARY_COLLISION_TYPE.LEFT_X then
      local y = 90
      effect_info.gameobject.transform:SetEulerY(y)
    elseif collider_info then
      local box_transform = collider_info.box_collider.transform
      local pos_x, pos_y, pos_z = self:get_pos()
      local x, y = box_transform:GetInverseTransformPointA(pos_x, pos_y + 0.2, pos_z)
      local ex, ey, ez = box_transform:GetEulerAnglesA3()
      if math.abs(x) > collider_info.box_half_size.x then
        ey = ey + 90
      elseif math.abs(y) > collider_info.box_half_size.y then
        ex = ex + 90
      end
      effect_info.gameobject.transform:SetEuler(ex, ey, ez)
    end
  end
  
  local function remove_callback()
    self.v_play_wall_effect = nil
  end
  
  self.v_play_wall_effect = true
  local distance = 0.8
  local dir_pos = Vec2.Normalize(Vec2.New(dx, dz)) * distance
  local position = Vec3.New(self.v_position.x + dir_pos.x, self.v_position.y + 1.5, self.v_position.z + dir_pos.y)
  SceneMgr:create_scene_effect("Fx_Kongqiqiang", position, nil, nil, create_callback, remove_callback)
end

function M:play_interact_anim()
  local function pass_cb()
    self.act_ctrl:try_action(Config.ACT_DEFINE.Interact, 0, function()
      self.act_ctrl:try_action(Config.ACT_DEFINE.Idle2, 0, nil)
    end, nil, false)
  end
  
  self:check_motion_config(Config.ACT_DEFINE.Interact, pass_cb)
end

function M:play_finish_loop_anim()
  local function pass_cb()
    if SceneMgr then
      SceneMgr:set_player_control_off()
    end
    self.act_ctrl:try_action(Config.ACT_DEFINE.FinishLoop, 0, nil, nil, true)
  end
  
  self:check_motion_config(Config.ACT_DEFINE.FinishLoop, pass_cb)
end

function M:set_cursor_enable(bool)
  self.v_cursor_enable = bool
end

function M:get_res_type()
  return self.v_res_type or self.buddy_cfg.ShowFightResType
end

function M:get_hero_advance()
  return self:get_advance()
end

function M:is_can_heal()
  local attr_mgr = self.attr_mgr
  local now_hp = attr_mgr:get_attr(ATTR_TYPE.CHAR_HP)
  local max_hp = attr_mgr:get_attr(ATTR_TYPE.CHAR_HP_MAX)
  return now_hp < max_hp
end

function M:can_hurt_interrupt(interrupt_type)
  if self:is_destroy() then
    return
  end
  local state_manager = self.state_manager
  local state = state_manager:get_cur_beattack_state() or state_manager:get_cur_behitfly_state()
  if state then
    return state:can_interrupt(interrupt_type)
  end
  return true
end

function M:set_idle_stand_changing(v)
  self.v_is_idle_changing = v
end

function M:can_move_at_idle_switching()
  return not self.v_is_idle_changing
end

function M:navigator_task_room(msg, is_refresh, dont_show_effect)
  if not TowerMgr then
    return
  end
  self.v_navigator_tp_idx = nil
  self.v_navigator_point_name = nil
  if self.v_navigator_type and self.v_navigator_type == NAVIAGTOR_TYPE.POINT then
    return
  end
  self.is_navigator_suc = false
  if not BattleTaskMgr then
    return
  end
  local scene_logic = SceneMgr:get_scene_logic()
  if not scene_logic then
    return
  end
  local tower = TowerMgr:get_tower()
  if not tower or tower and tower:is_maze_room() then
    return
  end
  if scene_logic:get_is_navigating_by_logic() then
    self:on_navigating_by_logic(is_refresh)
    return
  end
  local task_item = BattleTaskMgr:get_track_task_item()
  if not task_item then
    return
  end
  local task_cfg = task_item:get_task_cfg()
  if not task_cfg then
    return
  end
  local condition_list = task_cfg.Condition
  local relation_room_list = task_cfg.RoomContace
  if not relation_room_list then
    self:clear_navigator_effect()
    return
  end
  local target_room_id, target_point_key
  local cur_room = TowerMgr:get_cur_room()
  local cur_room_id = cur_room and cur_room:get_room_id()
  for index, condition_id in ipairs(condition_list) do
    if 0 ~= condition_id and not task_item:check_condition_complete(condition_id) and not target_room_id and not target_point_key then
      local cfg_desc = relation_room_list[index]
      if not Util.is_empty(cfg_desc) then
        local room_list = Util.split_str(cfg_desc, "&")
        target_room_id = tonumber(room_list[1])
        target_point_key = room_list[2]
        break
      end
    end
  end
  if not target_room_id then
    local cfg_desc = relation_room_list[1]
    local room_list = Util.split_str(cfg_desc, "&")
    target_room_id = tonumber(room_list[1])
    target_point_key = room_list[2]
  end
  if not target_room_id or 0 == target_room_id then
    return
  end
  if tower:is_show_arrow() then
    self:refresh_task_condition_arrow(task_item)
  end
  self.v_have_refresh_arrow = true
  local path_list = BattleTaskMgr:get_task_relation_room_path(target_room_id)
  local key
  if not path_list or #path_list <= 0 then
    if not target_point_key or "" == target_point_key then
      self:clear_navigator_effect()
      return
    else
      key = target_point_key
    end
  else
    local target_point = path_list[1]
    local target_dir = target_point.tp_idx
    self.v_navigator_tp_idx = target_dir
    key = "tp" .. target_dir
  end
  if not BattleTaskMgr:is_track_main_task() then
    return
  end
  if not is_refresh and not task_cfg.RefreshNavigator then
    return
  end
  if cur_room and cur_room_id and cur_room_id == target_room_id and not Util.is_empty(target_point_key) then
    key = target_point_key
  end
  if Util.is_empty(key) then
    return
  end
  local pos_x, pos_y, pos_z = scene_logic:get_pos_key_position(key)
  if not (pos_x and pos_y) or not pos_z then
    self.v_navigator_suc = nil
    return
  end
  self.v_navigator_point_name = key
  self:navigate_to_pos(pos_x, pos_y, pos_z, is_refresh, dont_show_effect)
  return true
end

function M:refresh_task_condition_arrow(task_item)
  if not task_item then
    if not TowerMgr then
      return
    end
    if not BattleTaskMgr then
      return
    end
    task_item = BattleTaskMgr:get_track_task_item()
  end
  if not task_item then
    return
  end
  local task_cfg = task_item:get_task_cfg()
  if not task_cfg then
    return
  end
  local cur_room_id = TowerMgr:get_cur_room_id()
  if not cur_room_id then
    return
  end
  local condition_list = task_cfg.Condition
  local condition_cfg, temp, room_id, point_name
  for index, condition_id in ipairs(condition_list) do
    if 0 ~= condition_id and not task_item:check_condition_complete(condition_id) then
      condition_cfg = ShareRes.get_battle_task_condition_cfg(condition_id)
      if condition_cfg and not Util.is_empty(condition_cfg.TargetPoint) then
        temp = Util.split_str(condition_cfg.TargetPoint, "&")
        if temp[2] then
          room_id = tonumber(temp[1])
          point_name = temp[2]
        end
        if cur_room_id == room_id and point_name then
          self:set_navi_arrows_info(point_name, true, room_id, task_cfg.Id, condition_id)
        end
      end
    end
  end
  self.v_have_refresh_arrow = false
end

function M:on_navigating_by_logic(is_refresh)
  if not self.v_task_navigator_pos then
    self.v_task_navigator_pos = Vec3.New()
  end
  self:navigate_to_pos(self.v_task_navigator_pos.x, self.v_task_navigator_pos.y, self.v_task_navigator_pos.z, is_refresh)
end

function M:set_navigate_is_continue(is_continue)
  if true == is_continue then
    NAVIGATOR_TASK_CD = MAX_NAVIGATOR_TASK_CD
  else
    NAVIGATOR_TASK_CD = ShareRes.get_comm_value("NavigatorTaskCD")
  end
end

local function navigator_cb(self, is_success, points)
  if is_success then
    self:clear_navigator_effect()
    for _, data in pairs(points) do
      local effect_param = self.act_effect_ctrl.create_effect_param()
      effect_param.prefab_name = NAVIGATOR_EFFECT_NAME
      effect_param.is_world = true
      effect_param.world_pos = data
      effect_param.need_restart = true
      local effect_id = self.act_effect_ctrl:play_effect(effect_param)
      self.v_navigator_effect_id_list[effect_id] = effect_id
    end
  end
  self:change_navigator_effect_show_state(is_success)
end

local function no_effect_navigator_cb(self, is_success, points)
  self.v_path_finding_success = is_success
  self.v_vectorPath = points
  if not is_success then
    self.v_target_waypoint = nil
    self.v_navigator_suc = nil
    return
  end
  if #points < NEXT_WAYPOINT_INTERVAL then
    self.v_target_waypoint = points[#points]
  else
    self.v_target_waypoint = points[NEXT_WAYPOINT_INTERVAL]
  end
  self.v_navigator_suc = not UtilTable.is_empty(self.v_target_waypoint)
end

function M:navigate_to_pos(pos_x, pos_y, pos_z, is_refresh, dont_show_effect)
  if not self.v_task_navigator_pos then
    self.v_task_navigator_pos = Vec3.New()
  end
  self.v_task_navigator_pos.x = pos_x
  self.v_task_navigator_pos.y = pos_y
  self.v_task_navigator_pos.z = pos_z
  self.is_navigator_suc = true
  if not dont_show_effect then
    self:create_navigator_effect(nil, is_refresh)
  else
    local start_time = os.clock()
    self.navigator_ctrl:find_path(self.v_task_navigator_pos, 1.5, no_effect_navigator_cb, self, no_effect_navigator_cb)
  end
end

function M:update_path_finding()
  if not SceneMgr:global_hero_is_destroyed() and Global.hero:get_navigator_tp_show() and Global.camera:get_camera_mode() == Config.CAMERA_VIEW_TYPE.DEPRESSION then
    local cur_time = GlobalTimeMgr:get_time()
    local dt = cur_time - self.v_last_hero_nav_time
    if dt > HERO_PATHFIND_INTERVAL then
      local pos, x, y, z
      local scene_logic = SceneMgr:get_scene_logic()
      if scene_logic then
        if scene_logic:get_is_navigating_by_logic() then
          pos = self.v_task_navigator_pos
          x, y, z = pos.x, pos.y, pos.z
        elseif self.v_navigator_point_name then
          local scene_map = scene_logic:get_scene_map()
          pos = scene_map:get_area_position(self.v_navigator_point_name)
          x, y, z = pos.X, pos.Y, pos.Z
        elseif self.v_navigator_tp_idx then
          local scene_map = scene_logic:get_scene_map()
          pos = scene_map:get_area_position("tp" .. self.v_navigator_tp_idx)
          x, y, z = pos.X, pos.Y, pos.Z
        end
      end
      if pos then
        self:navigate_to_pos(x, y, z, nil, true)
        self.v_last_hero_nav_time = cur_time
      else
        self.v_navigator_suc = nil
      end
    end
  end
end

function M:update_navigator_pos_info()
  if UtilTable.is_empty(self.v_navigator_effect_id_list) then
    return
  end
  local now_time = Global.real_time
  if now_time - self.v_last_create_time > NAVIGATOR_TASK_CD then
    self:clear_navigator_effect(true)
  else
    self.v_refresh_navigator_time = self.v_refresh_navigator_time or now_time
    if self.state_manager:is_in_state(STATE_NAME.move) and now_time - self.v_refresh_navigator_time > 1 then
      self:create_navigator_effect(nil, true, true)
      self.v_refresh_navigator_time = now_time
    end
  end
end

function M:reset_navigator_time()
  if NAVIGATOR_TASK_CD == MAX_NAVIGATOR_TASK_CD then
    self:clear_navigator_effect(true)
    self:set_navigate_is_continue(false)
    return
  end
  self:set_navigate_is_continue(false)
  if UtilTable.is_empty(self.v_navigator_effect_id_list) then
    self.v_last_create_time = Global.real_time
    self:navigator_task_room(nil, true)
    if not self.v_have_refresh_arrow then
      self:refresh_task_condition_arrow()
    end
    return true
  else
    self:clear_navigator_effect(true)
    return false
  end
end

function M:check_create_navigator_effect()
  self.v_last_create_time = self.v_last_create_time or 0
  local now_time = Global.real_time
  if now_time - self.v_last_create_time < NAVIGATOR_TASK_CD then
    return
  end
  return true
end

function M:create_navigator_effect(is_clear, is_refreh, is_move)
  if not is_refreh and not self:check_create_navigator_effect() then
    return
  end
  if not is_move then
    self.v_last_create_time = Global.real_time
  end
  if self.in_background then
    return
  end
  if not self.is_navigator_suc then
    return
  end
  if StoryMgr then
    local is_play_story = StoryMgr:is_playing_full_screen_story()
    if is_play_story then
      return
    end
  end
  if is_clear then
    self:clear_navigator_effect()
  end
  self.navigator_ctrl:find_path(self.v_task_navigator_pos, 1.5, navigator_cb, self)
end

function M:clear_navigator_effect(need_fadeout)
  if self.act_effect_ctrl then
    for effect_id in pairs(self.v_navigator_end_effect_id_list) do
      self.act_effect_ctrl:stop_effect(effect_id, true)
      self.v_navigator_end_effect_id_list[effect_id] = nil
    end
    for effect_id in pairs(self.v_navigator_effect_id_list) do
      self.act_effect_ctrl:stop_effect(effect_id, not need_fadeout)
      self.v_navigator_effect_id_list[effect_id] = nil
      if need_fadeout then
        self.v_navigator_end_effect_id_list[effect_id] = effect_id
      end
    end
  end
  if self.v_navi_arrows_info_list then
    for _, info in pairs(self.v_navi_arrows_info_list) do
      if info.navigation_hud then
        if Global.ui_dynamic_canvas then
          Global.ui_dynamic_canvas:release_navigation_hud_item(info.navigation_hud)
        end
        info.navigation_hud = nil
      end
    end
  end
  self:change_navigator_effect_show_state(false)
end

function M:update_navigator_obj_visible()
end

function M:is_playing_time_line()
  return self.v_is_playing_timeline
end

function M:start_time_line()
  self:clear_navigator_effect()
  self.v_is_playing_timeline = true
end

function M:stop_time_line()
  self.v_is_playing_timeline = false
end

function M:buddy_type(type)
  self.v_type = type
end

function M:get_buddy_type()
  return self.v_type
end

function M:is_robot(type_id)
  return self.v_type == BUDDY_TYPE.ROBOT
end

function M:get_buddy_id()
  return self.character_cfg.AttribId
end

function M:_set_dybone_distant(need_check)
  if not self.v_has_dy_bone then
    return
  end
  if nil == need_check then
    need_check = true
  end
  for i = 0, self.v_dy_bones.Length - 1 do
    local bone = self.v_dy_bones[i]
    bone.m_DistantDisable = need_check
    if need_check then
      bone.m_DistanceToObject = DISABLE_DY_BONE_DIS
      bone.m_ReferenceObject = Global.camera:get_camera_trans()
    end
  end
end

function M:get_is_robot_hero()
  return self.v_is_robot or false
end

function M:set_is_robot_hero(is_robot)
  self.v_is_robot = is_robot
end

function M:set_face_pos_skill_indicator(parms)
  self.is_open_face_skill_indi_pos = parms.is_open
  Global.camera:set_skill_indicator_pos_info(parms)
  if parms.is_open then
    self.v_skill_indic_parms = parms
  end
end

function M:update_face_pos()
  if not self.is_open_face_skill_indi_pos then
    return
  end
  local ui_fight = UIMgr:try_get_visible_ui("fight")
  if not ui_fight then
    return
  end
  local down_skill_idx = ui_fight:get_down_skill_index()
  if not down_skill_idx or 0 == down_skill_idx then
    return
  end
  local x, z = ui_fight:get_indicator_pos(down_skill_idx)
  local pos = self:get_pos_vec3()
  if nil == x or nil == z then
    return
  end
  self.v_skill_indic_pos.x = x
  self.v_skill_indic_pos.y = pos.y
  self.v_skill_indic_pos.z = z
  local normal_pos = self.v_skill_indic_pos - pos
  normal_pos = normal_pos:SetNormalize()
  self:face_to_pos(x, z, false)
  Global.camera:update_skill_indicator_pos(normal_pos.x, nil, normal_pos.z)
end

function M:set_guid_arrow_visible(visible)
  for _, effect_id in pairs(self.v_tp_self_effect) do
    local gameobj = self.act_effect_ctrl:get_effect_gameobject(effect_id)
    if gameobj then
      gameobj:SetActive(visible)
      self.v_arrow_visibles[gameobj] = visible
    end
  end
  self.v_guid_arrow_visible = visible
end

function M:_response_born_skill_finish(msg)
  if not self.v_guid_arrow_visible then
    self:set_guid_arrow_visible(true)
  end
end

function M:check_scope_monster(npc)
  if not npc or npc:is_destroy() then
    return false
  end
  if not npc:is_can_searched() then
    return false
  end
  if npc:get_role_kind() == CommonDefine.NPC_KIND.TRAP then
    return false
  end
  if not npc:is_monster() then
    return false
  end
  return true
end

function M:check_scope_if_monster()
  local x, y, z = self.transform:GetPositionA()
  local npc_map = SceneMgr:get_all_npc()
  for _, npc in pairs(npc_map) do
    if not self:check_scope_monster(npc) then
    else
      local pos_x, pos_y, pos_z = npc:get_pos()
      local distance = Vec3.DistanceA(x, y, z, pos_x, pos_y, pos_z)
      if distance <= SCOPE_VAL then
        return true
      end
    end
  end
  return false
end

function M:can_show_navigator_effect()
  if not TowerMgr then
    return
  end
  if self.v_navigator_type and self.v_navigator_type == NAVIAGTOR_TYPE.POINT then
    return
  end
  local scene_logic = SceneMgr:get_scene_logic()
  if not scene_logic then
    return
  end
  if not BattleTaskMgr then
    return
  end
  local track_task_id = BattleTaskMgr:get_track_task_id()
  if not track_task_id or 0 == track_task_id then
    return
  end
  local task_item = BattleTaskMgr:get_task(track_task_id)
  local task_cfg = task_item.v_task_cfg
  if not task_cfg then
    return
  end
  local relation_room_list = task_cfg.RoomContace
  if not relation_room_list then
    return
  end
  local tower = TowerMgr:get_tower()
  if tower and tower:is_maze_room() then
    return
  end
  if not BattleTaskMgr:is_track_main_task() then
    return
  end
  if self.in_background then
    return
  end
  if not tower or not tower:is_pass_room() then
    return
  end
  if StoryMgr then
    local is_play_story = StoryMgr:is_playing_full_screen_story()
    if is_play_story then
      return
    end
  end
  return true
end

function M:is_show_navigator_effect()
  return self.is_showing_navigator_effect
end

function M:change_navigator_effect_show_state(state)
  self.is_showing_navigator_effect = state
  MsgGame:mq_publish2(Const.MSG_NAVIGATOR_EFFECT_SHOW_STATE_CHANGE)
end

function M:get_navigator_tp_show()
  return self.v_navigator_tp_show
end

function M:set_by_ult_change(by_utl)
  self.by_ult_change = by_utl
end

function M:check_module_attrs()
  for _, module_id in pairs(MODULE_ATTR_TYPE) do
    self:check_attrs(module_id)
  end
end

function M:set_finish_init_gameobj_cb(cb)
  self.v_finish_init_gameobj_cb = cb
end

function M:get_each_point_expend_value()
  local max_value = self.attr_mgr:get_attr(ATTR_TYPE.CHAR_SP_MAX)
  if self.buddy_cfg.ChargePointCount then
    return max_value / self.buddy_cfg.ChargePointCount
  else
    return max_value
  end
end

function M:get_show_point_count()
  local max_value = self.attr_mgr:get_attr(ATTR_TYPE.CHAR_SP_MAX)
  return max_value / Config.EACH_POINT_EXPEND_VALUE
end

function M:get_charged_point_count(value)
  local each_point_expend_value = Config.EACH_POINT_EXPEND_VALUE
  if not each_point_expend_value or 0 == each_point_expend_value then
    return 0, 0
  end
  value = value or self.attr_mgr:get_attr(ATTR_TYPE.CHAR_SP)
  local count = math.floor(value / each_point_expend_value)
  local differen = value - count * each_point_expend_value
  local max_value = self.attr_mgr:get_attr(ATTR_TYPE.CHAR_SP_MAX)
  if 0 ~= differen and Util.almost_zero(count * each_point_expend_value + differen - max_value) then
    differen = 0
    count = count + 1
  end
  return count, differen
end

function M:sp_2_point_count(value)
  local each_point_expend_value = Config.EACH_POINT_EXPEND_VALUE
  if not each_point_expend_value or 0 == each_point_expend_value then
    return 0
  end
  return math.ceil(value / each_point_expend_value)
end

function M:calcu_fake_sp_data(dt)
  self.v_fake_sp_data = self.v_fake_sp_data or {}
  self.v_fake_sp_data.last_count = self.v_fake_sp_data.count
  self.v_fake_sp_data.value = self.attr_mgr:get_attr(ATTR_TYPE.CHAR_SP) + self.v_recover_sp_timer * self:get_real_recover_value()
  self.v_fake_sp_data.count, self.v_fake_sp_data.differen = self:get_charged_point_count(self.v_fake_sp_data.value)
  if self.v_fake_sp_data.last_count ~= self.v_fake_sp_data.count then
    self:add_fake_sp_on_change()
    local msg = MsgGame:mq_publish2(Const.MSG_ON_HERO_SP_POINT_COUNT_CHANGE)
    msg.mm_x = self.uuid
    msg.mm_y = self.v_fake_sp_data.last_count
    msg.mm_obj = self.v_fake_sp_data.count
  end
end

function M:get_fake_sp_data()
  if not self.v_fake_sp_data then
    self:calcu_fake_sp_data()
  end
  return self.v_fake_sp_data
end

function M:get_fake_sp_value()
  return self:get_fake_sp_data().value
end

function M:get_fake_sp_count()
  return self:get_fake_sp_data().count
end

function M:get_recover_value()
  return self.in_background and self.attr_mgr:get_attr(ATTR_TYPE.CHAR_SP_BACK_GROUND_CV) or self.attr_mgr:get_attr(ATTR_TYPE.CHAR_SP_ON_GROUND_CV)
end

function M:get_real_recover_value()
  return self:get_recover_value() * (1 + self.attr_mgr:get_attr(ATTR_TYPE.GET_EXTRA_ENERGY_RATIO) / Config.RATIO_TO_NUM)
end

function M:get_recover_sp_timer()
  return self.v_recover_sp_timer
end

function M:add_fake_sp_on_change(reset_timer)
  if self:check_sp_is_max() then
    return
  end
  self:recover_char_sp()
  if reset_timer then
    self.v_recover_sp_timer = 0
  end
end

function M:check_sp_is_max()
  local cur_value = self.attr_mgr:get_attr(Config.CHAR_ATTR_TYPE.CHAR_SP)
  local max_value = self.attr_mgr:get_attr(Config.CHAR_ATTR_TYPE.CHAR_SP_MAX)
  if cur_value >= max_value then
    self.v_recover_sp_timer = 0
    return true
  end
end

function M:recover_char_sp()
  local recover_value, float = math.modf(self.v_recover_sp_timer * self:get_recover_value())
  if recover_value < 1 then
    return
  end
  local fixed_value = Math.Clamp(recover_value, 1, 300)
  self.magic_mgr:add_magic(self, Config.RECOVER_SP_MAGIC, nil, nil, fixed_value)
  self.v_recover_sp_timer = float / self:get_recover_value()
end

function M:on_energy_ball_has_been_picked()
  if not Util.is_destroy(self) and not self.in_background and not self.v_energy_ball_effect_id then
    local effect_data = self.act_effect_ctrl.create_effect_param()
    
    function effect_data.callback()
      if not Util.is_destroy(self) then
        self.v_energy_ball_effect_id = nil
      end
    end
    
    effect_data.prefab_name = Config.PICK_ENERGY_BALL_EFFECT
    effect_data.parent = self:get_setting_point(Config.BLOOD_ATTACH) or self.transform
    self.v_energy_ball_effect_id = self.act_effect_ctrl:play_effect(effect_data)
  end
end

function M:on_change_track_battle_task(msg)
  self:navigator_task_room(msg)
  if not self.v_have_refresh_arrow then
    self:refresh_task_condition_arrow()
  end
end

function M:change_navi_arrows_info(state_info_list)
  for key, state_info in pairs(state_info_list) do
    local key_name = state_info.KeyName
    self:set_navi_arrows_info(key_name, state_info.IsOpen)
  end
end

function M:set_navi_arrows_info(key_name, is_show, room_id, track_task_id, condition_id)
  local info = self.v_navi_arrows_info_list[key_name]
  if not is_show then
    if info then
      if info.effect_id then
        self:clear_arrow_record(info.effect_id)
        self.act_effect_ctrl:stop_effect(info.effect_id)
      end
      if info.navigation_hud then
        Global.ui_dynamic_canvas:release_navigation_hud_item(info.navigation_hud)
        info.navigation_hud = nil
      end
      info.is_show = is_show
      info.effect_id = nil
      info.room_id = nil
      info.track_task_id = nil
      info.condition_id = nil
    end
  else
    if not info then
      self.v_navi_arrows_info_list[key_name] = {}
      info = self.v_navi_arrows_info_list[key_name]
    end
    info.is_show = is_show
    info.target_is_npc = SceneMgr and nil ~= SceneMgr:get_npc_by_name(key_name) or false
    info.room_id = room_id
    info.track_task_id = track_task_id
    info.condition_id = condition_id
  end
end

function M:create_circle_effect()
  if self.circel_effect_id then
    return
  end
  local effect_param = self.act_effect_ctrl.create_effect_param()
  effect_param.prefab_name = Config.HERO_CIRCEL_EFFECT_NAME
  effect_param.parent = self.transform
  effect_param.effect_length = -1
  self.circel_effect_id = self.act_effect_ctrl:play_effect(effect_param)
end

function M:set_circle_effect_visible(is_visible)
  if self.circel_effect_id and self.act_effect_ctrl then
    local gameobject = self.act_effect_ctrl:get_effect_gameobject(self.circel_effect_id)
    if gameobject then
      gameobject:SetActive(is_visible)
    end
  end
end

function M:clear_circle_effect()
  if self.circel_effect_id and self.act_effect_ctrl then
    self.act_effect_ctrl:stop_effect(self.circel_effect_id)
    self.circel_effect_id = nil
  end
end

function M:on_hero_heal(msg)
  if not self.in_background and msg and msg.mm_x == self.uuid then
    local effect_param = self.act_effect_ctrl.create_effect_param()
    effect_param.prefab_name = Config.HERO_HEAL_EFFECT_NAME
    effect_param.parent = self.transform
    self.act_effect_ctrl:play_effect(effect_param)
  end
end

function M:on_monster_begin_attack(msg)
  local target_uuid = msg.mm_x
  local effect_id = self.v_betargeted_effect[target_uuid]
  local gameobject = self.act_effect_ctrl:get_effect_gameobject(effect_id)
  self.v_monster_new_arrow_state[target_uuid] = Config.ARROWS_EFFECT_COLOR.WARING
  if gameobject then
    TEMP_PARAMS.arrows_effect_color = Config.ARROWS_EFFECT_COLOR.WARING
    self:update_effect_color(gameobject, INDICATOR.MONSTER_NEW, TEMP_PARAMS)
  end
end

function M:on_enter_room_clear_data()
  self:set_by_ult_change(false)
end

function M:on_monster_end_attack(msg)
  local target_uuid = msg.mm_x
  local effect_id = self.v_betargeted_effect[target_uuid]
  local gameobject = self.act_effect_ctrl:get_effect_gameobject(effect_id)
  self.v_monster_new_arrow_state[target_uuid] = Config.ARROWS_EFFECT_COLOR.RED
  if gameobject then
    TEMP_PARAMS.arrows_effect_color = Config.ARROWS_EFFECT_COLOR.RED
    self:update_effect_color(gameobject, INDICATOR.MONSTER_NEW, TEMP_PARAMS)
  end
end

function M:set_current_state(new_state)
  self.v_current_state = new_state
  self:update_state_bool()
end

function M:get_current_state()
  return self.v_current_state
end

function M:update_state_bool()
  self.in_control = self.v_current_state == Config.HERO_STATE.IN_CONTROL
  self.in_background = self.v_current_state == Config.HERO_STATE.IN_BACKGROUND
  self.in_ground = self.v_current_state == Config.HERO_STATE.IN_GROUND
end

function M:check_in_control()
  return self.in_control
end

function M:check_in_ground()
  return self.in_ground
end

function M:set_latest_pos(x, y, z)
  self:set_use_pos_type(Config.HERO_POS_CHANGE_TYPE.TRANSFER_POS)
  self.v_latest_pos:Set(x, y, z)
end

function M:set_use_pos_type(pos_type)
  self.v_use_pos_type = pos_type
end

function M:set_show_betargeted_arrow(show)
  if self.v_show_betargeted_arrow ~= show and not show then
    for _, effect_id in pairs(self.v_betargeted_effect) do
      self:clear_arrow_record(effect_id)
      self.act_effect_ctrl:stop_effect(effect_id)
    end
  end
  self.v_show_betargeted_arrow = show
end

function M:set_death_type(death_type)
  self.v_death_type = death_type
end

function M:is_need_land_height()
  return self.in_control
end

function M:get_navigator_suc()
  return self.v_navigator_suc == true
end

return M
