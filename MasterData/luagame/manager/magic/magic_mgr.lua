local _tremove = table.remove
local _tinsert = table.insert
local _max = math.max
local MagicActionType
if UNITY_EDITOR_WIN then
  MagicActionType = CS.Game.MagicActionType
end
local Base = require("obj.base_component")
local MagicEvent = require("manager.magic.magic_event.magic_event")
local MagicEffectFunc = require("manager.magic.magic_event.magic_effect_func")
local MagicDef = require("cs_share.magic_def")
local MAGIC_EFFECT_TYPE = MagicDef.MAGIC_EFFECT_TYPE
local CommonDef = require("cs_share.common_define")
local DLList = require("utils.doubly_linked_list")
local LuaObjPoolMgr = require("manager.res.lua_obj_pool_mgr")
local UPDATE_TYPE = MagicDef.UPDATE_TYPE
local IMMUNIT_TYPE = MagicDef.IMMUNIT_TYPE
local MAGIC_TYPE = MagicDef.MAGIC_TYPE
local BROARDCAST_TYPE = MagicDef.MAGIC_BROARDCAST_TYPE
local MAGIC_ACTION_TYPE = CommonDef.MAGIC_ACTION_TYPE
local ON_SELF_MAGIC_BEGIN_STR = "on_self_magic_begin"
local ON_SELF_MAGIC_END_STR = "on_self_magic_end"
local ON_TARGET_SELF_MAGIC_BEGIN_STR = "on_target_self_magic_begin"
local ON_TARGET_SELF_MAGIC_END_STR = "on_target_self_magic_end"
local ON_MAGIC_BEGIN_MSG_STR = "on_magic_begin_msg"
local ON_MAGIC_END_MSG_STR = "on_magic_end_msg"
local LUA_TBL_COUNT = 0
local LUA_TBLS = {}

local function pop_lua_tbl()
  if LUA_TBL_COUNT <= 0 then
    return {}
  end
  local tbl = LUA_TBLS[LUA_TBL_COUNT]
  LUA_TBLS[LUA_TBL_COUNT] = nil
  LUA_TBL_COUNT = LUA_TBL_COUNT - 1
  return tbl
end

local function push_lua_tbl(tbl)
  if LUA_TBL_COUNT >= 50 then
    return
  end
  LUA_TBL_COUNT = LUA_TBL_COUNT + 1
  LUA_TBLS[LUA_TBL_COUNT] = tbl
end

local default_remove_map = {}
local DelayMagic = require("manager.magic.delay_magic")
local MagicParam = require("manager.magic.magic_param")
local M = Util.create_child_mt(Base)

function M:_init(char)
  Base._init(self)
  self.v_char = char
  self.v_visible_magic_list = {}
  self.v_magic_id_map = {}
  self.v_update_magic_mark = {}
  self.v_magic_type_map = {}
  self.v_magic_kind_id_map = {}
  self.v_immunity_type_map = {}
  self.v_immunity_magic_map = {}
  self.v_magic_linked_list = {}
  self.v_magic_rtid_map = {}
  self.v_next_inteval = 0
  self.v_update_inteval = 0
  self.v_timescale_inteval = 0
  self.v_untimescale_inteval = 0
  self.v_need_remove_magics = {}
  self.v_remove_magic_update_type = {}
  self.v_magic_effect_info = {}
  self.v_immune_list = {}
  self.v_float_icon_map = {}
  self.v_magic_cd_map = {}
  self.v_skill_magic_id_map = {}
  self.v_dying_remove_magic_id_map = {}
  self.v_switch_abort_magic_id_map = {}
  self.v_delay_magic_pool = LuaObjPoolMgr.get_pool("delay_magic_pool") or LuaObjPoolMgr.register("delay_magic_pool", 50, DelayMagic)
  self.v_delay_magic_map = {}
  self.v_magic_param_pool = LuaObjPoolMgr.get_pool("magic_param_pool") or LuaObjPoolMgr.register("magic_param_pool", 50, MagicParam)
  self.v_magic_count_map = {}
end

function M:on_before_destroy()
  for _, magic_map in pairs(self.v_magic_id_map) do
    for _, magic in pairs(magic_map) do
      if magic.magic_type == MAGIC_TYPE.ShakeCamera then
        magic:on_remove(default_remove_map)
      elseif magic.magic_type == MAGIC_TYPE.AddBehavior then
        magic:on_remove(default_remove_map)
      end
      self.v_magic_param_pool:destroy_obj(magic.magic_info)
      Global.MagicPool:destroy_magic(magic)
    end
  end
  local dynamic_ui = Global.ui_dynamic_canvas
  if dynamic_ui then
    for index, float_icon in pairs(self.v_float_icon_map) do
      dynamic_ui:release_float_icon_item(float_icon)
      self.v_float_icon_map[index] = nil
    end
  end
  self.v_char = nil
  self.v_visible_magic_list = nil
  self.v_magic_id_map = nil
  self.v_update_magic_mark = nil
  self.v_magic_type_map = nil
  self.v_magic_kind_id_map = nil
  self.v_immunity_type_map = nil
  self.v_magic_linked_list = nil
  self.v_magic_rtid_map = nil
  self.v_need_remove_magics = nil
  self.v_remove_magic_update_type = nil
  self.v_magic_effect_info = nil
  self.v_immune_list = nil
  self.v_float_icon_map = nil
  self.v_magic_cd_map = nil
  self.v_skill_magic_id_map = nil
  self.v_dying_remove_magic_id_map = nil
  self.v_switch_abort_magic_id_map = nil
  self.v_delay_magic_map = nil
  self.v_magic_count_map = nil
end

local DEBUG_ALL_MAGIC = false
local DEBUG_TRACE_MAGIC = false
local DEBUG_MAGIC_IDS = {}

function M:trace_all_magic()
  if not is_debug_enviroment() then
    return
  end
  DEBUG_ALL_MAGIC = true
end

function M:trace_magic_id(id)
  if not is_debug_enviroment() then
    return
  end
  DEBUG_ALL_MAGIC = false
  DEBUG_TRACE_MAGIC = true
  table.insert(DEBUG_MAGIC_IDS, id)
end

function M:_add_sub_magic_id(attacker, magic_id, owner_missile, owner_skill, magic_level, part_id, ext_args)
  local sub_magic_list = FightDataMgr:get_magic_sub_list(magic_id)
  if sub_magic_list and sub_magic_list.magic_list then
    local len = #sub_magic_list.magic_list
    for i = 1, len do
      local sub_magic_id = sub_magic_list.magic_list[i]
      sub_magic_list:on_use_magic(sub_magic_id)
      self:add_magic(attacker, sub_magic_id, owner_missile, owner_skill, magic_level, part_id, ext_args)
    end
    FightDataMgr:remove_invalid_sub_magic(magic_id)
  end
end

function M:magic_transmitted_to_main_part(attacker, magic_id, owner_missile, owner_skill, magic_level, part_id, ext_args, single_add_count)
  local uuid = self.v_char:get_main_part()
  local main_npc = SceneMgr:pick_by_uuid(uuid)
  if not Util.is_destroy(main_npc) then
    local self_part_id = self.v_char:get_part_id()
    local self_part_info = main_npc:get_part_info_by_id(self_part_id)
    local new_ext_arg = ext_args
    local clear_on_used = false
    if not new_ext_arg then
      new_ext_arg = pop_lua_tbl()
      clear_on_used = true
    end
    new_ext_arg.attach_point = self_part_info.attach_point
    main_npc.magic_mgr:add_magic(attacker, magic_id, owner_missile, owner_skill, magic_level, part_id, new_ext_arg, single_add_count)
    if clear_on_used then
      push_lua_tbl(new_ext_arg)
    end
    new_ext_arg.attach_point = nil
  end
end

function M:add_magic(attacker, magic_id, owner_missile, owner_skill, magic_level, part_id, ext_args, single_add_count)
  if single_add_count and single_add_count <= 0 then
    return
  end
  if self.v_magic_cd_map[magic_id] then
    return
  end
  if not magic_level or magic_level <= 0 then
    local lv = attacker.skill_mgr and attacker.skill_mgr:get_magic_level(magic_id)
    magic_level = lv and lv > 0 and lv or 1
  end
  if 0 ~= magic_level % 1 then
    Log.Error("传入的magic_level不为整数, 传入值为：", magic_level, "magic_id为：", magic_id, debug.traceback())
    magic_level = math.floor(magic_level)
  end
  local magic_cfg = ShareRes.get_magic_cfg(magic_id)
  if not magic_cfg then
    Log.Error("no such magic, id ", magic_id, debug.traceback())
    return
  end
  if self.v_char:is_npc() and self.v_char:get_part_type() == Config.PART_NPC_TYPE.AFFILIATE and magic_cfg.PartEffectType == Config.PART_MAGIC_EFFECT_TYPE.ADD_TO_MAIN then
    self:magic_transmitted_to_main_part(attacker, magic_id, owner_missile, owner_skill, magic_level, part_id, ext_args, single_add_count)
    return
  end
  local logic_cfg = magic_cfg.logic
  if not logic_cfg then
    Log.Error("no such magic, id ", magic_id, debug.traceback())
    return
  end
  local magic_count = self:get_magic_count_by_magic_id(magic_id)
  local dif = logic_cfg.Limit - magic_count
  if magic_cfg.CanNotExceededLimit and dif <= 0 then
    return
  end
  if single_add_count then
    if dif <= 0 then
      single_add_count = 1
    else
      single_add_count = math.min(dif, single_add_count)
    end
  end
  self:_add_sub_magic_id(attacker, magic_id, owner_missile, owner_skill, magic_level, part_id, ext_args)
  local delay = logic_cfg.RealDelay and logic_cfg.RealDelay > 0 and logic_cfg.RealDelay or logic_cfg.Delay
  if Util.is_more_than_zero(magic_cfg.cd) then
    self.v_magic_cd_map[magic_id] = delay + magic_cfg.cd
  end
  if not Util.is_more_than_zero(delay) then
    return self:_add_magic_before(attacker, magic_id, owner_missile, owner_skill, magic_level, part_id, ext_args, single_add_count)
  else
    local is_real = logic_cfg.RealDelay ~= nil and logic_cfg.RealDelay > 0
    local start_time = is_real and Global.time or self.v_char.time_mgr:get_time()
    local magic_delay_info = self.v_delay_magic_pool:new_obj(attacker, magic_id, owner_missile, owner_skill, magic_level, part_id, ext_args, delay, start_time, is_real)
    self.v_delay_magic_map[magic_delay_info] = true
  end
end

function M:_add_magic_before(attacker, magic_id, owner_missile, owner_skill, magic_level, part_id, ext_args, single_add_count)
  if single_add_count then
    for i = 1, single_add_count do
      self:_add_magic(attacker, magic_id, owner_missile, owner_skill, magic_level, part_id, ext_args, i ~= single_add_count)
    end
    return
  end
  return self:_add_magic(attacker, magic_id, owner_missile, owner_skill, magic_level, part_id, ext_args)
end

function M:_add_magic(attacker, magic_id, owner_missile, owner_skill, magic_level, part_id, ext_args, not_send_msg)
  if self.v_char:is_destroy() then
    return
  end
  if self.v_char ~= attacker then
    self.v_char.attacker_kind = attacker.character_cfg.Kind
  end
  local magic_cfg = ShareRes.get_magic_cfg(magic_id)
  if not magic_cfg then
    Log.Error("no such magic, id ", magic_id, debug.traceback())
    return
  end
  local logic_cfg = magic_cfg.logic
  local magic_kind_list = logic_cfg.Kind
  local magic_type = logic_cfg.type
  local magic_limit = logic_cfg.Limit
  if UNITY_EDITOR then
    self:check_add_magic_inteval(magic_id, magic_type)
  end
  if DEBUG_ALL_MAGIC or DEBUG_TRACE_MAGIC and UtilTable.contains(DEBUG_MAGIC_IDS, magic_id) then
    Log.Info("DEBUGMAGIC ADD MAGIC", magic_id, logic_cfg, debug.traceback())
  end
  if self.v_immunity_magic_map[magic_id] then
    return false
  end
  if magic_kind_list then
    for magic_kind in pairs(magic_kind_list) do
      if self.v_immunity_type_map[magic_kind] then
        return false
      end
    end
  end
  if magic_limit > 0 and magic_limit <= self:get_magic_num(magic_id) then
    self:remove_first_magic(magic_id, true)
  end
  local magic_info = self.v_magic_param_pool:new_obj(magic_id, attacker, owner_missile, owner_skill, magic_level, logic_cfg, magic_cfg.effect, part_id, ext_args, not_send_msg)
  if Global.debug_magic_parpam_count then
    Log.Error("magic_param数量调试", "使用上限：", 500, "当前使用：", self.v_magic_param_pool:get_active_count(), "当前取用magic_param magic_id", magic_id)
  end
  if owner_skill then
    magic_info.owner_skill_id = owner_skill.skill_id
  end
  local is_receive = logic_cfg.IsReceive
  local effect_type, magic = Global.MagicPool:get_magic(self.v_char, magic_info)
  local rtid = SceneMgr:get_rtid()
  self:check_play_magic_sound(magic_cfg.sound_id)
  if UNITY_EDITOR_WIN and Global.CollectionMagicInfo then
    local owner_missile_id = owner_missile and owner_missile.missile_id or 0
    JournalMgr:collection_magic_info(owner_missile_id, magic_info.owner_skill_id, magic_id, magic_level, logic_cfg.Duration, rtid, self.v_char:get_npc_id(), self.v_char.uuid, MagicActionType.ADD)
  end
  if effect_type ~= MAGIC_EFFECT_TYPE.OBJECT then
    local report = MagicReporter:add_magic_start(self.v_char, attacker, magic_info, logic_cfg, ext_args, rtid, not_send_msg)
    if effect_type == MAGIC_EFFECT_TYPE.EVENT then
      MagicEvent.on_magic_fun(self.v_char, magic.fun, magic_info, report)
    elseif effect_type == MAGIC_EFFECT_TYPE.EFFECT_FUNC then
      self:use_magic_effect_func(magic_info, magic_cfg, report)
    end
    MagicReporter:add_magic_end(report, self.v_char, logic_cfg)
    return rtid
  end
  local skill_id = magic_info.owner_skill_id
  if skill_id and (not self.v_skill_magic_id_map[skill_id] or not self.v_skill_magic_id_map[skill_id][magic_id]) then
    self.v_skill_magic_id_map[skill_id] = self.v_skill_magic_id_map[skill_id] or {}
    self.v_skill_magic_id_map[skill_id][magic_id] = true
  end
  if magic_cfg.DyingRemove and not self.v_dying_remove_magic_id_map[magic_id] then
    self.v_dying_remove_magic_id_map[magic_id] = true
  end
  if magic_cfg.AbortBySwitch and not self.v_switch_abort_magic_id_map[magic_id] then
    self.v_switch_abort_magic_id_map[magic_id] = true
  end
  magic.rtid = rtid
  magic.type = magic_type
  self.v_next_inteval = -1
  self:update_magic(true)
  if 0 == self.v_next_inteval or logic_cfg.Duration < self.v_next_inteval then
    self.v_next_inteval = _max(logic_cfg.Duration, 0.01)
  end
  local uuid = magic.uuid
  local magic_map = self.v_magic_id_map[magic_id] or {}
  magic_map[uuid] = magic
  self.v_magic_count_map[magic_id] = (self.v_magic_count_map[magic_id] or 0) + 1
  self.v_magic_id_map[magic_id] = magic_map
  if not self.v_magic_linked_list[magic_id] then
    self.v_magic_linked_list[magic_id] = DLList:new()
  end
  local list_obj = self.v_magic_linked_list[magic_id]:insert_tail(magic)
  self.v_magic_rtid_map[rtid] = list_obj
  if logic_cfg.Duration >= 0 then
    self.v_update_magic_mark[magic_id] = true
  end
  local magic_type_map = self.v_magic_type_map[magic_type] or {}
  magic_type_map[uuid] = magic
  self.v_magic_type_map[magic_type] = magic_type_map
  self:add_magic_kind_id_map(magic_kind_list, magic_id)
  local report = MagicReporter:add_magic_start(self.v_char, attacker, magic_info, logic_cfg, ext_args, magic.rtid)
  MagicReporter:push_action_start(report, MAGIC_ACTION_TYPE.on_add_magic_effect_before)
  magic:on_effect_before()
  MagicReporter:push_action_end(report, MAGIC_ACTION_TYPE.on_add_magic_effect_before)
  magic:on_effect(magic_type_map)
  MagicReporter:push_action_start(report, MAGIC_ACTION_TYPE.on_add_magic_effect)
  magic:on_effect_after(magic_type_map)
  MagicReporter:push_action_end(report, MAGIC_ACTION_TYPE.on_add_magic_effect)
  local update_type = logic_cfg.UpdateType
  if update_type == UPDATE_TYPE.RTimeClearOne or update_type == UPDATE_TYPE.RTimeClearAll then
    self:_reset_magic_elapsed(magic_id)
  end
  MagicReporter:push_action_start(report, MAGIC_ACTION_TYPE.immunity_remove)
  if magic_kind_list then
    for magic_kind in pairs(magic_kind_list) do
      self:add_immunity_type(magic_kind)
    end
  end
  self:add_extra_immunity_type(logic_cfg.ImmunitType, logic_cfg.ImmunitKinds)
  self:add_immunity_magic(logic_cfg.ImmunitType, logic_cfg.Immunitions)
  MagicReporter:push_action_end(report, MAGIC_ACTION_TYPE.immunity_remove)
  if not not_send_msg and is_receive ~= BROARDCAST_TYPE.NONE and is_receive ~= BROARDCAST_TYPE.ONLY_END then
    local is_self
    if is_receive == BROARDCAST_TYPE.BEGIN_END then
      is_self = false
    elseif is_receive == BROARDCAST_TYPE.SELF_ACTION_END then
      is_self = true
    end
    MagicReporter:push_action_start(report, MAGIC_ACTION_TYPE.on_magic_begin)
    BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.ON_MAGIC_BEGIN, attacker, self.v_char, magic_id, is_self, magic_level, magic_kind_list, magic_type)
    BehaviorMgr:call_behavior_fun(attacker, ON_SELF_MAGIC_BEGIN_STR, self.v_char, magic_id, magic_level, magic_kind_list, magic_type)
    BehaviorMgr:call_behavior_fun(self.v_char, ON_TARGET_SELF_MAGIC_BEGIN_STR, attacker, magic_id, magic_level, magic_kind_list, magic_type)
    BehaviorMgr:call_event_fun(ON_MAGIC_BEGIN_MSG_STR, attacker, self.v_char, magic_id, magic_kind_list)
    MagicReporter:push_action_end(report, MAGIC_ACTION_TYPE.on_magic_begin)
  end
  MagicReporter:add_magic_end(report, self.v_char, logic_cfg)
  local is_visible = self:check_visible_magic(magic, logic_cfg, rtid)
  self:check_float_icon_param(magic_cfg, magic_id, rtid)
  local msg = MsgGame:mq_publish2(Const.MSG_ADD_MAGIC)
  msg.mm_x = self.v_char
  msg.mm_y = magic_id
  msg.mm_obj = is_visible
  if BattleOrnamentMgr then
    BattleOrnamentMgr:try_record_magic_level(magic_id, magic_level)
  end
  SceneMgr:add_to_magic_to_uuid_map(magic_id, self.v_char.uuid)
  return magic.rtid
end

function M:use_magic_effect_func(magic_info, magic_cfg, report)
  local logic_cfg = magic_info.logic_cfg
  local magic_kind_list = logic_cfg.Kind
  local magic_id = logic_cfg.Id
  local magic_level = magic_info.magic_level
  local is_receive = logic_cfg.IsReceive
  local magic_type = logic_cfg.type
  local attacker = magic_info.attacker
  self:add_magic_kind_id_map(magic_kind_list, magic_id)
  MagicEffectFunc.call_effect_func(self.v_char, magic_info)
  MagicReporter:push_action_start(report, MAGIC_ACTION_TYPE.immunity_remove)
  if magic_kind_list then
    for magic_kind in pairs(magic_kind_list) do
      self:add_immunity_type(magic_kind)
    end
  end
  self:add_extra_immunity_type(logic_cfg.ImmunitType, logic_cfg.ImmunitKinds)
  self:add_immunity_magic(logic_cfg.ImmunitType, logic_cfg.Immunitions)
  MagicReporter:push_action_end(report, MAGIC_ACTION_TYPE.immunity_remove)
  if is_receive == BROARDCAST_TYPE.ONLY_BEGIN then
    MagicReporter:push_action_start(report, MAGIC_ACTION_TYPE.on_magic_begin)
    BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.ON_MAGIC_BEGIN, attacker, self.v_char, magic_id, false, magic_level, magic_kind_list, magic_type)
    BehaviorMgr:call_behavior_fun(attacker, ON_SELF_MAGIC_BEGIN_STR, self.v_char, magic_id, magic_level, magic_kind_list, magic_type)
    BehaviorMgr:call_behavior_fun(self.v_char, ON_TARGET_SELF_MAGIC_BEGIN_STR, attacker, magic_id, magic_level, magic_kind_list, magic_type)
    BehaviorMgr:call_event_fun(ON_MAGIC_BEGIN_MSG_STR, attacker, self.v_char, magic_id, magic_kind_list)
    MagicReporter:push_action_end(report, MAGIC_ACTION_TYPE.on_magic_begin)
  end
  self:remove_extra_immunity_type(logic_cfg.ImmunitType, logic_cfg.ImmunitKinds)
  self:remove_magic_kind_id_map(magic_kind_list, magic_id)
  if logic_cfg.Immunitions and logic_cfg.ImmunitType ~= IMMUNIT_TYPE.ExceptAdd then
    self:remove_immunity_magics(logic_cfg.Immunitions)
  end
end

function M:add_magic_kind_id_map(magic_kind_list, magic_id)
  if magic_kind_list then
    for magic_kind in pairs(magic_kind_list) do
      self.v_magic_kind_id_map[magic_kind] = self.v_magic_kind_id_map[magic_kind] or {}
      self.v_magic_kind_id_map[magic_kind][magic_id] = true
    end
  end
end

function M:remove_magic_kind_id_map(magic_kind_list, magic_id)
  if magic_kind_list then
    for magic_kind in pairs(magic_kind_list) do
      if self.v_magic_kind_id_map[magic_kind] and self.v_magic_kind_id_map[magic_kind][magic_id] then
        self.v_magic_kind_id_map[magic_kind][magic_id] = nil
      end
    end
  end
end

function M:check_float_icon_param(magic_cfg, magic_id, rtid)
  local index = magic_cfg.OneLayerFloat and magic_id or rtid
  local param = magic_cfg.FloatingIconParam
  local check_pass = magic_cfg.FloatOnGround or not self.v_char:is_hero() or self.v_char:check_in_control()
  local need_show = param and check_pass
  if need_show and not self.v_float_icon_map[index] then
    local dynamic_ui = Global.ui_dynamic_canvas
    if dynamic_ui then
      local item = dynamic_ui:get_float_icon_item()
      item:init_char_info(self.v_char, magic_id)
      self.v_float_icon_map[index] = item
    end
  end
end

function M:check_visible_magic(magic, logic_cfg)
  if not magic or not magic.cfg then
    return false
  end
  local is_visible = false
  if not Util.is_empty(magic.cfg.Icon) then
    is_visible = true
    local _, insert_magic
    if magic.update_type ~= UPDATE_TYPE.SeparateTime then
      _, insert_magic = next(self.v_magic_id_map[magic.magic_id])
    else
      insert_magic = magic
    end
    self.v_visible_magic_list[magic.magic_id] = insert_magic
  end
  return is_visible
end

function M:check_play_magic_sound(sound_id)
  if not sound_id or "" == sound_id then
    return
  end
  Global.sound_mgr:play_sound_by_id(sound_id)
end

function M:get_magics_by_type(type)
  return self.v_magic_type_map[type]
end

function M:get_magic_by_id(magic_id)
  local magic_linked_list = self.v_magic_linked_list[magic_id]
  local target_magic
  if magic_linked_list then
    target_magic = magic_linked_list:get_node_val_by_idx(1)
  end
  return target_magic
end

function M:get_magic_by_rtid(magic_rtid)
  local node = self.v_magic_rtid_map[magic_rtid]
  return node and node.data
end

function M:remove_first_magic(magic_id, is_exceed_limit)
  local magic = self:get_magic_by_id(magic_id)
  if magic then
    self:remove_magic(magic, UPDATE_TYPE.RTimeClearOne, is_exceed_limit)
    self.v_next_inteval = -1
    self:update_magic(true)
  end
end

function M:remove_magic_by_rtid(rt_id)
  local list_obj = self.v_magic_rtid_map[rt_id]
  if list_obj then
    local magic = list_obj.data
    if magic then
      self:remove_magic(magic, UPDATE_TYPE.RTimeClearOne)
      self.v_next_inteval = -1
      self:update_magic(true)
    end
  end
end

function M:add_extra_immunity_type(immunity_type, immunit_kinds)
  if nil == immunit_kinds then
    return
  end
  immunity_type = immunity_type or IMMUNIT_TYPE.ImmunityAll
  self:add_immunity_type_info(immunity_type, immunit_kinds)
end

local ADD_IMMUNITY_TYPE_FUNC = {
  [IMMUNIT_TYPE.ImmunityAll] = function(self, list)
    for _, immunity_type in ipairs(list) do
      self:_remove_immunity_magic(immunity_type)
      local count = self.v_immunity_type_map[immunity_type] or 0
      self.v_immunity_type_map[immunity_type] = count + 1
    end
  end,
  [IMMUNIT_TYPE.ExceptHad] = function(self, list)
    for _, immunity_type in ipairs(list) do
      local count = self.v_immunity_type_map[immunity_type] or 0
      self.v_immunity_type_map[immunity_type] = count + 1
    end
  end,
  [IMMUNIT_TYPE.ExceptAdd] = function(self, list)
    for _, immunity_type in ipairs(list) do
      self:_remove_immunity_magic(immunity_type)
    end
  end
}

function M:add_immunity_type_info(immuty_mode, list)
  local func = ADD_IMMUNITY_TYPE_FUNC[immuty_mode]
  assert(func, immuty_mode)
  assert(list)
  func(self, list)
end

function M:add_immunity_type(magic_kind)
  local immunity_info = ShareRes.create("character.buff_type", magic_kind)
  if not immunity_info then
    return
  end
  if immunity_info.immu_all then
    self:add_immunity_type_info(IMMUNIT_TYPE.ImmunityAll, immunity_info.immu_all)
  elseif immunity_info.only_after then
    self:add_immunity_type_info(IMMUNIT_TYPE.ExceptHad, immunity_info.only_after)
  elseif immunity_info.only_had then
    self:add_immunity_type_info(IMMUNIT_TYPE.ExceptAdd, immunity_info.only_had)
  end
end

function M:remove_extra_immunity_type(immunity_type, immunit_kinds)
  if nil == immunit_kinds then
    return
  end
  immunity_type = immunity_type or IMMUNIT_TYPE.ImmunityAll
  if immunity_type ~= IMMUNIT_TYPE.ExceptAdd then
    self:_remove_immunity_type(immunit_kinds)
  end
end

function M:remove_immunity_type(magic_kind)
  local immunity_info = ShareRes.create("character.buff_type", magic_kind)
  if immunity_info then
    self:_remove_immunity_type(immunity_info.immu_all)
    self:_remove_immunity_type(immunity_info.only_after)
  end
end

function M:_remove_immunity_type(immunity_list)
  if not immunity_list then
    return
  end
  for _, immunity_type in ipairs(immunity_list) do
    if self.v_immunity_type_map[immunity_type] then
      self.v_immunity_type_map[immunity_type] = self.v_immunity_type_map[immunity_type] - 1
      if 0 == self.v_immunity_type_map[immunity_type] then
        self.v_immunity_type_map[immunity_type] = nil
      end
    end
  end
end

function M:add_immunity_magic(immunity_type, magic_list)
  if not magic_list then
    return
  end
  if immunity_type ~= IMMUNIT_TYPE.ExceptAdd then
    local count
    for _, magic_id in ipairs(magic_list) do
      count = self.v_immunity_magic_map[magic_id] or 0
      self.v_immunity_magic_map[magic_id] = count + 1
    end
  end
  if immunity_type ~= IMMUNIT_TYPE.ExceptHad then
    for _, magic_id in ipairs(magic_list) do
      self:remove_magic_by_id(magic_id)
    end
  end
end

function M:remove_immunity_magics(immunity_list)
  for _, magic_id in ipairs(immunity_list) do
    if self.v_immunity_magic_map[magic_id] then
      self.v_immunity_magic_map[magic_id] = self.v_immunity_magic_map[magic_id] - 1
      if 0 == self.v_immunity_magic_map[magic_id] then
        self.v_immunity_magic_map[magic_id] = nil
      end
    end
  end
end

function M:_remove_immunity_magic(immunity_type)
  for _, magic_map in pairs(self.v_magic_id_map) do
    for _, magic in pairs(magic_map) do
      if magic.magic_kind_list[immunity_type] then
        self:_mark_remove_magic(magic)
      end
    end
  end
  self:_update_remove_magics()
end

local STOP_SKILL_MAGIC_TYPE = {
  BY_STOP = 0,
  BY_BEHIT = 1,
  NEVER = 2
}

function M:remove_magics_by_skill_id(skill_id, is_behit_abort, stop_type_map)
  if not self.v_skill_magic_id_map[skill_id] then
    return
  end
  for magic_id in pairs(self.v_skill_magic_id_map[skill_id]) do
    local stop_type = stop_type_map and stop_type_map[magic_id] or STOP_SKILL_MAGIC_TYPE.BY_STOP
    if stop_type ~= STOP_SKILL_MAGIC_TYPE.NEVER and (stop_type ~= STOP_SKILL_MAGIC_TYPE.BY_BEHIT or is_behit_abort) then
      local magic_map = self.v_magic_id_map[magic_id]
      if magic_map then
        for _, magic in pairs(magic_map) do
          self:_mark_remove_magic(magic)
        end
      end
    end
  end
  self:_update_remove_magics()
end

function M:remove_abnormal_flag_magic(element_id, remove_count)
  local magic_map = self.v_magic_type_map[MAGIC_TYPE.Abnormal_Flag]
  if not magic_map or remove_count and remove_count <= 0 then
    return remove_count
  end
  local need_update = false
  for _, magic in pairs(magic_map) do
    if remove_count and remove_count <= 0 then
      break
    end
    if magic:get_element_id() == element_id then
      remove_count = remove_count and remove_count - magic:get_count()
      self:_mark_remove_magic(magic)
      need_update = true
    end
  end
  if need_update then
    self:_update_remove_magics()
  end
  return remove_count
end

function M:_remove_all_magic_by_id(magic_id)
  local magic_linked_list = self.v_magic_linked_list[magic_id]
  if magic_linked_list then
    local cur_num = magic_linked_list:get_length()
    for i = 1, cur_num do
      local magic = magic_linked_list:get_node_val_by_idx(i)
      if not magic then
        break
      end
      self:_mark_remove_magic(magic)
    end
  end
  self:_update_remove_magics()
end

function M:remove_magic_by_id(magic_id, remove_num)
  local magic_map = self.v_magic_id_map[magic_id]
  if not magic_id or not magic_map then
    return false
  end
  if nil == remove_num or remove_num <= 0 then
    self:_remove_all_magic_by_id(magic_id)
    return true
  end
  local magic_linked_list = self.v_magic_linked_list[magic_id]
  local cur_num = magic_linked_list:get_length()
  if remove_num >= cur_num then
    self:_remove_all_magic_by_id(magic_id)
    return true
  end
  local first_left_duration
  for i = 1, remove_num do
    local magic
    magic = magic_linked_list:get_node_val_by_idx(i)
    if magic then
      if not first_left_duration and magic.update_type == UPDATE_TYPE.RTimeClearALLAbortOne then
        first_left_duration = magic.left_duration
      end
      local update_type = magic.update_type == UPDATE_TYPE.RTimeClearALLAbortOne and UPDATE_TYPE.RTimeClearOne or magic.update_type
      self:_mark_remove_magic(magic, update_type)
    end
  end
  self:_update_remove_magics()
  if first_left_duration and self.v_magic_id_map[magic_id] then
    local first_magic = self:get_magic_by_id(magic_id)
    if first_magic then
      first_magic.left_duration = first_left_duration
    end
  end
  return true
end

function M:_update_remove_magics(not_break)
  if not next(self.v_need_remove_magics) then
    return
  end
  local need_remove_magics = self.v_need_remove_magics
  self.v_need_remove_magics = pop_lua_tbl()
  for magic in pairs(need_remove_magics) do
    need_remove_magics[magic] = nil
    local update_type = self.v_remove_magic_update_type[magic]
    self:remove_magic(magic, update_type, nil, not_break)
    self.v_remove_magic_update_type[magic] = nil
  end
  push_lua_tbl(need_remove_magics)
end

function M:remove_magic(magic, update_type, is_exceed_limit, not_break)
  update_type = update_type or magic.update_type
  local magic_id = magic.magic_id
  local magic_update_type = magic.update_type
  if DEBUG_TRACE_MAGIC and UtilTable.contains(DEBUG_MAGIC_IDS, magic_id) then
    Log.Info("DEBUGMAGIC REMOVE MAGIC", magic_id, debug.traceback())
  end
  local rtid = magic.rtid
  if update_type == UPDATE_TYPE.RTimeClearAll or update_type == UPDATE_TYPE.RTimeClearALLAbortOne then
    local linked_list = self.v_magic_linked_list[magic_id]
    self.v_magic_id_map[magic.magic_id] = nil
    self.v_magic_count_map[magic_id] = 0
    if linked_list then
      local cur_num = linked_list:get_length()
      for _ = 1, cur_num do
        local _magic = linked_list:get_node_val_by_idx(1)
        if _magic then
          self:_do_remove_magic(_magic)
        end
      end
    end
  else
    self:_do_remove_magic(magic, not_break)
  end
  local is_visible
  if self.v_visible_magic_list[magic_id] then
    if magic_update_type ~= UPDATE_TYPE.RTimeClearOne then
      if self.v_visible_magic_list[magic_id] == magic or magic_update_type == UPDATE_TYPE.RTimeClearAll then
        self.v_visible_magic_list[magic_id] = nil
      end
    else
      local next_magic = self:get_magic_by_id(magic_id)
      self.v_visible_magic_list[magic_id] = next_magic
    end
    is_visible = true
  end
  local magic_cfg = ShareRes.get_magic_cfg(magic_id)
  local index = magic_cfg.OneLayerFloat and magic_id or rtid
  if self.v_float_icon_map[index] and (not magic_cfg.OneLayerFloat or self:get_magic_num(index) <= 0) and not is_exceed_limit then
    self:release_float_icon(index)
  end
  local msg = MsgGame:mq_publish2(Const.MSG_REMOVE_MAGIC)
  msg.mm_x = self.v_char
  msg.mm_y = magic_id
  msg.mm_obj = is_visible
end

function M:_mark_remove_magic(magic, update_type)
  self.v_need_remove_magics[magic] = true
  if update_type then
    self.v_remove_magic_update_type[magic] = update_type
  end
end

function M:_do_remove_magic(magic, not_break)
  if magic.is_mark_remove then
    return
  end
  local logic_cfg = magic.cfg
  local magic_id = magic.magic_id
  local magic_kind_list = magic.magic_kind_list
  local magic_type = magic.magic_type
  local skill_id = magic.magic_info.owner_skill_id
  if DEBUG_TRACE_MAGIC and UtilTable.contains(DEBUG_MAGIC_IDS, magic_id) then
    Log.Info("DEBUGMAGIC DOREMOVE", magic_id, debug.traceback())
  end
  if magic_kind_list then
    for magic_kind in pairs(magic_kind_list) do
      self:remove_immunity_type(magic_kind)
    end
  end
  self:remove_extra_immunity_type(logic_cfg.ImmunitType, logic_cfg.ImmunitKinds)
  self:remove_magic_kind_id_map(magic_kind_list, magic_id)
  if logic_cfg.Immunitions and logic_cfg.ImmunitType ~= IMMUNIT_TYPE.ExceptAdd then
    self:remove_immunity_magics(logic_cfg.Immunitions)
  end
  magic:on_mark_remove()
  local now_uuid = magic.uuid
  local magic_type_map = self.v_magic_type_map[magic_type]
  if magic_type_map then
    magic_type_map[now_uuid] = nil
  end
  self.v_next_inteval = -1
  local report = MagicReporter:remove_magic_start(magic)
  self.v_char.skill_mgr:remove_effect_magic(magic_id)
  local magic_map = self.v_magic_id_map[magic_id]
  if magic_map then
    magic_map[magic.uuid] = nil
    if self.v_magic_count_map[magic_id] then
      self.v_magic_count_map[magic_id] = self.v_magic_count_map[magic_id] - 1
    end
  end
  local magic_map_empty = not magic_map or not next(magic_map)
  if magic_map_empty then
    self.v_update_magic_mark[magic_id] = nil
    self:remove_play_once_effect_info(magic_id)
    if skill_id and self.v_skill_magic_id_map[skill_id] then
      self.v_skill_magic_id_map[skill_id][magic_id] = nil
      if not next(self.v_skill_magic_id_map[skill_id]) then
        self.v_skill_magic_id_map[skill_id] = nil
      end
    end
    self.v_dying_remove_magic_id_map[magic_id] = nil
    self.v_switch_abort_magic_id_map[magic_id] = nil
    self.v_magic_id_map[magic_id] = nil
  end
  local magic_rtid = magic.rtid
  local list_obj = self.v_magic_rtid_map[magic_rtid]
  if list_obj then
    local linked_list = self.v_magic_linked_list[magic_id]
    if linked_list then
      linked_list:remove_node(list_obj)
      if linked_list:get_length() <= 0 then
        linked_list:on_clear()
        self.v_magic_linked_list[magic_id] = nil
      end
    end
    self.v_magic_rtid_map[magic_rtid] = nil
  end
  local magic_info = magic.magic_info
  local attacker = magic_info.attacker
  local is_receive = logic_cfg.IsReceive
  local not_send_msg = magic_info.not_send_msg
  if (not not_send_msg or magic.update_type == UPDATE_TYPE.RTimeClearOne) and is_receive ~= BROARDCAST_TYPE.NONE and is_receive ~= BROARDCAST_TYPE.ONLY_BEGIN then
    local is_self
    if is_receive == BROARDCAST_TYPE.BEGIN_END then
      is_self = false
    elseif is_receive == BROARDCAST_TYPE.SELF_ACTION_END then
      is_self = true
    end
    MagicReporter:push_action_start(report, MAGIC_ACTION_TYPE.on_magic_end)
    local is_break = not not_break
    BehaviorMgr:call_event_fun(ON_MAGIC_END_MSG_STR, attacker, self.v_char, magic_id, magic_kind_list, magic_type, is_break)
    BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.ON_MAGIC_END, attacker, self.v_char, magic_id, is_self, magic_kind_list, magic_type, is_break)
    BehaviorMgr:call_behavior_fun(attacker, ON_SELF_MAGIC_END_STR, self.v_char, magic_id, magic_kind_list, magic_type, is_break)
    BehaviorMgr:call_behavior_fun(self.v_char, ON_TARGET_SELF_MAGIC_END_STR, attacker, magic_id, magic_kind_list, magic_type, is_break)
    MagicReporter:push_action_end(report, MAGIC_ACTION_TYPE.on_magic_end)
  end
  if UNITY_EDITOR_WIN and Global.CollectionMagicInfo then
    local owner_skill_id = magic_info.owner_skill_id or 0
    local owner_missile_id = magic_info.owner_missil and magic_info.owner_missil.missile_id or 0
    JournalMgr:collection_magic_info(owner_missile_id, owner_skill_id, magic_id, magic_info.magic_level, 0, magic_rtid, self.v_char:get_npc_id(), self.v_char.uuid, MagicActionType.REMOVE)
  end
  magic:on_remove(magic_type_map or default_remove_map, true)
  self.v_magic_param_pool:destroy_obj(magic.magic_info)
  Global.MagicPool:destroy_magic(magic)
  MagicReporter:remove_magic_end(report)
  SceneMgr:remove_at_magic_to_uuid_map(magic_id, self.v_char.uuid)
end

function M:_reset_magic_elapsed(magic_id)
  local magic_map = self.v_magic_id_map[magic_id]
  if not magic_map then
    return
  end
  for _, magic in pairs(magic_map) do
    magic:reset_time()
  end
end

function M:update_magic_delay_add()
  if not next(self.v_delay_magic_map) then
    return
  end
  for info in pairs(self.v_delay_magic_map) do
    if self:_out_delay_time(info.start_time, info.delay_time, info.is_real) then
      self:_add_magic_before(info.attacker, info.magic_id, info.owner_missile, info.owner_skill, info.magic_level, info.part_id, info.ext_args, info.single_add_count)
      self.v_delay_magic_pool:destroy_obj(info)
      self.v_delay_magic_map[info] = nil
    end
  end
end

function M:update_magic_cd()
  for magic_id, magic_cd in pairs(self.v_magic_cd_map) do
    magic_cd = magic_cd - GlobalTimeMgr:get_dt_time()
    if magic_cd <= 0 then
      self.v_magic_cd_map[magic_id] = nil
    else
      self.v_magic_cd_map[magic_id] = magic_cd
    end
  end
end

function M:_out_delay_time(start_time, deyla_time, is_delta)
  local now_time = is_delta and Global.time or self.v_char.time_mgr:get_time()
  return deyla_time < now_time - start_time
end

local game_mode = Global.gamemode

function M:update()
  if not game_mode:gmode_is_game() then
    return
  end
  self:update_magic_delay_add()
  self:update_magic_cd()
  if 0 ~= self.v_next_inteval then
    self.v_untimescale_inteval = self.v_untimescale_inteval + Global.delta_time
    self.v_update_inteval = self.v_update_inteval + GlobalTimeMgr:get_dt_time()
    self.v_timescale_inteval = self.v_timescale_inteval + self.v_char:get_dt()
  end
  self:update_magic()
  self:update_float_icon_pos()
end

function M:on_role_dead()
  if self.v_char:is_destroy() then
    return
  end
  for magic_id in pairs(self.v_dying_remove_magic_id_map) do
    local magic_map = self.v_magic_id_map[magic_id]
    if magic_map then
      for _, magic in pairs(magic_map) do
        self:_mark_remove_magic(magic)
      end
    end
  end
  self:_update_remove_magics()
end

function M:on_role_exit_control()
  if self.v_char:is_destroy() then
    return
  end
  for magic_id in pairs(self.v_switch_abort_magic_id_map) do
    local magic_map = self.v_magic_id_map[magic_id]
    if magic_map then
      for _, magic in pairs(magic_map) do
        self:_mark_remove_magic(magic)
      end
    end
  end
  self:_update_remove_magics()
end

function M:on_settle()
  local magic_cfg
  for magic_id, magic_map in pairs(self.v_magic_id_map) do
    magic_cfg = ShareRes.get_magic_cfg(magic_id)
    if magic_cfg and magic_cfg.DeleteOnSettle then
      for _, magic in pairs(magic_map) do
        self:_mark_remove_magic(magic)
      end
    end
  end
  self:_update_remove_magics()
end

local function _get_update_inteval(self, magic)
  local time_scale_type = magic:get_timescale_type()
  if time_scale_type == MagicDef.TIME_SCELE_TYPE.UNSCALE then
    return self.v_untimescale_inteval
  elseif time_scale_type == MagicDef.TIME_SCELE_TYPE.NONE or time_scale_type == MagicDef.TIME_SCELE_TYPE.EXCEPT_LIFE then
    return self.v_update_inteval
  else
    return self.v_timescale_inteval
  end
end

local function _get_each_update_inteval(self, magic)
  local time_scale_type = magic:get_timescale_type()
  if time_scale_type == MagicDef.TIME_SCELE_TYPE.UNSCALE then
    return Global.delta_time
  elseif time_scale_type == MagicDef.TIME_SCELE_TYPE.NONE or time_scale_type == MagicDef.TIME_SCELE_TYPE.EXCEPT_LIFE then
    return GlobalTimeMgr:get_dt_time()
  else
    return self.v_char:get_dt()
  end
end

local function _update_magic_duration(self, magic, each_frame_update, is_refresh_duration, upadte_dura)
  if not each_frame_update and is_refresh_duration then
    local inteval = _get_update_inteval(self, magic)
    magic.left_duration = magic.left_duration - inteval
    if magic.left_duration >= 0 and not magic.is_mark_remove and (0 == self.v_next_inteval or magic.left_duration < self.v_next_inteval) then
      self.v_next_inteval = magic.left_duration
    end
  elseif each_frame_update and upadte_dura then
    local inteval = _get_each_update_inteval(self, magic)
    magic.left_duration = magic.left_duration - inteval
  end
end

local is_update_remove

local function _update_magic(self, magic, is_refresh_duration, upadte_dura)
  local cfg = magic.cfg
  if magic.duration >= 0 then
    _update_magic_duration(self, magic, cfg.each_frame_update, is_refresh_duration, upadte_dura)
    if magic.left_duration <= 0 then
      self:_mark_remove_magic(magic)
      is_update_remove = true
    end
  end
end

function M:update_magic(not_upadte_dura)
  local is_refresh_duration = false
  if 0 ~= self.v_next_inteval and (self.v_update_inteval >= self.v_next_inteval or self.v_timescale_inteval >= self.v_next_inteval or self.v_untimescale_inteval >= self.v_next_inteval) then
    is_refresh_duration = true
    self.v_next_inteval = 0
  end
  is_update_remove = false
  local upadte_dura = not not_upadte_dura
  for magic_id, _ in pairs(self.v_update_magic_mark) do
    local magic_cfg = ShareRes.get_magic_cfg(magic_id)
    if magic_cfg.logic.UpdateType == UPDATE_TYPE.SeparateTime then
      local magic_map = self.v_magic_id_map[magic_id]
      if magic_map then
        for _, magic in pairs(magic_map) do
          _update_magic(self, magic, is_refresh_duration, upadte_dura)
        end
      end
    else
      local linked_list = self.v_magic_linked_list[magic_id]
      local magic = linked_list and linked_list:get_node_val_by_idx(1)
      if magic then
        _update_magic(self, magic, is_refresh_duration, upadte_dura)
      end
    end
  end
  if is_update_remove then
    self:_update_remove_magics(true)
  end
  if is_refresh_duration then
    self.v_update_inteval = 0
    self.v_timescale_inteval = 0
    self.v_untimescale_inteval = 0
  end
end

function M:check_magic(magic_id)
  local magic_map = self.v_magic_id_map[magic_id]
  if not magic_map then
    return false
  end
  local _, magic = next(magic_map)
  if magic then
    local type = magic.type
    if type and type == MAGIC_TYPE.Trigger then
      self:remove_magic_by_id(magic_id)
    end
  end
  return nil ~= magic
end

function M:get_magic_num(magic_id, hero_cast_magic)
  local magic_linked_list = self.v_magic_linked_list[magic_id]
  if not magic_linked_list then
    return 0
  end
  if not hero_cast_magic then
    return magic_linked_list:get_length()
  else
    local count = 0
    magic_linked_list:begin_iterator()
    local magic
    repeat
      magic = magic_linked_list:iterator_run_and_get_val()
      if magic.magic_info.attacker and magic.magic_info.attacker:is_hero() then
        count = count + 1
      end
    until magic
    return count
  end
end

function M:get_magic_kind_num(magic_kind)
  local id_map = self.v_magic_kind_id_map[magic_kind]
  local count = id_map and UtilTable.hash_lenth(id_map) or 0
  return count
end

function M:remove_others_by_type(magic_type, last_magic)
  local magic_type_map = self.v_magic_type_map[magic_type]
  if not magic_type_map then
    return
  end
  for _, magic in pairs(magic_type_map) do
    if magic ~= last_magic then
      self:_mark_remove_magic(magic)
    end
  end
end

function M:on_trigger_effect(magic_type, ...)
  local class = Global.MagicPool:get_magic_class(magic_type)
  local magic_type_map = self.v_magic_type_map[magic_type]
  if class and magic_type_map then
    return class.on_trigger_effect(self, magic_type_map, ...)
  end
end

function M:remove_all_magic()
  for k, _ in pairs(self.v_magic_id_map) do
    self:remove_magic_by_id(k)
  end
end

function M:pack_msg_magic_data()
  local msg_data = {}
  for _, magic_map in pairs(self.v_magic_id_map) do
    for _, magic in pairs(magic_map) do
      local data = {
        magic_id = magic.magic_id,
        rtid = magic.rtid,
        magic_level = magic.magic_level,
        part_id = 0,
        caster_uuid = self.v_char.uuid
      }
      _tinsert(msg_data, data)
    end
  end
  return msg_data
end

function M:check_add_magic_inteval(magic_id, magic_type)
end

function M:get_magic_map()
  return self.v_magic_id_map
end

function M:get_magic_map_by_magic_id(magic_id)
  return self.v_magic_id_map[magic_id]
end

function M:get_magic_count_by_magic_id(magic_id)
  return self.v_magic_count_map[magic_id] or 0
end

local function _add_immune_magic_by_element_type(self, skill_type, element_type, magic_obj)
  local list = self.v_immune_list[skill_type]
  if not list[element_type] then
    list[element_type] = {}
  end
  local magic_list = list[element_type]
  local len = #magic_list
  local insert_index
  if len > 0 then
    for i = len, 1, -1 do
      local magic = magic_list[i]
      if magic.left_duration >= magic_obj.left_duration then
        insert_index = i
      end
    end
  end
  insert_index = insert_index or #magic_list + 1
  table.insert(magic_list, insert_index, magic_obj)
end

local function _add_immune_magic_by_skill_type(self, skill_type, param2, magic_obj)
  if not self.v_immune_list[skill_type] then
    self.v_immune_list[skill_type] = {}
  end
  if Util.is_table(param2) then
    for _, element_type in pairs(param2) do
      _add_immune_magic_by_element_type(self, skill_type, element_type, magic_obj)
    end
  elseif Util.is_number(param2) then
    _add_immune_magic_by_element_type(self, skill_type, param2, magic_obj)
  end
end

function M:add_immune_magic(magic_obj)
  local skill_type_list = magic_obj.cfg[1]
  local element_type_list = magic_obj.cfg[2]
  for skill_type_index = 1, #skill_type_list do
    local skill_type = skill_type_list[skill_type_index]
    local list = self.v_immune_list[skill_type]
    if not list then
      self.v_immune_list[skill_type] = {}
      list = self.v_immune_list[skill_type]
    end
    for element_type_index = 1, #element_type_list do
      local element_type = element_type_list[element_type_index]
      if not list[element_type] then
        list[element_type] = {}
      end
      local magic_list = list[element_type]
      local len = #magic_list + 1
      magic_list[len] = magic_obj
      if len > 0 then
        table.sort(magic_list, function(a, b)
          if a.left_duration ~= b.left_duration then
            return a.left_duration < b.left_duration
          elseif a.rtid ~= b.rtid then
            return a.rtid < b.rtid
          else
            return false
          end
        end)
      end
    end
  end
end

function M:remove_immune_magic(magic_obj)
  local skill_type_list = magic_obj.cfg[1]
  local element_type_list = magic_obj.cfg[2]
  for skill_type_index = 1, #skill_type_list do
    local skill_type = skill_type_list[skill_type_index]
    local list = self.v_immune_list[skill_type]
    if not list then
    else
      for element_type_index = 1, #element_type_list do
        local element_type = element_type_list[element_type_index]
        local magic_list = list[element_type]
        if not magic_list then
        else
          for magic_index = 1, #magic_list do
            if magic_list[magic_index].rtid == magic_obj.rtid then
              table.remove(magic_list, magic_index)
              break
            end
          end
          if 0 == #magic_list then
            list[element_type] = nil
          end
        end
      end
      if not next(self.v_immune_list[skill_type]) then
        self.v_immune_list[skill_type] = nil
      end
    end
  end
end

function M:check_immunity_damage_magic(skill_type, ele_type)
  local magic_map = self.v_magic_type_map[MAGIC_TYPE.DemageImmune]
  if not magic_map or next(magic_map) == nil then
    return false
  end
  if not self.v_immune_list[skill_type] and not self.v_immune_list[-1] then
    return false
  end
  local skill_type_list = self.v_immune_list[-1] or self.v_immune_list[skill_type]
  if not skill_type_list[ele_type] and not skill_type_list[-1] then
    return false
  end
  local magic_list = skill_type_list[-1] or skill_type_list[ele_type]
  local magic = magic_list[1]
  if not magic then
    return false
  end
  return magic:immune_damage()
end

function M:get_visible_magic_list()
  return self.v_visible_magic_list
end

function M:on_reset()
  self:on_destroy()
end

function M:update_float_icon_pos()
  if not self.v_char or self.v_char:is_destroy() then
    return
  end
  for index, float_icon in pairs(self.v_float_icon_map) do
    float_icon:follow_npc()
    if not float_icon.is_loading_obj and float_icon.obj_is_destory then
      self:release_float_icon(index)
    end
  end
end

function M:release_float_icon(index)
  local dynamic_ui = Global.ui_dynamic_canvas
  if dynamic_ui then
    dynamic_ui:release_float_icon_item(self.v_float_icon_map[index])
  end
  self.v_float_icon_map[index] = nil
end

function M:check_once_effect_play(magic_id)
  return self.v_magic_effect_info[magic_id] == nil
end

function M:record_play_once_effect_info(magic_id, effect_id_list)
  local effect_info = self.v_magic_effect_info[magic_id]
  if not effect_info then
    effect_info = {}
    effect_info.effect_id_list = {}
    for target_uuid, effect_id in pairs(effect_id_list) do
      effect_info.effect_id_list[target_uuid] = effect_id
    end
    self.v_magic_effect_info[magic_id] = effect_info
  end
end

function M:remove_play_once_effect_info(magic_id)
  local effect_info = self.v_magic_effect_info[magic_id]
  if not effect_info then
    return
  end
  if effect_info.effect_id_list then
    local owner
    for uuid, effect_id in pairs(effect_info.effect_id_list) do
      owner = SceneMgr:pick_by_uuid(uuid)
      if not Util.is_destroy(owner) then
        owner.act_effect_ctrl:stop_effect(effect_id)
      end
    end
  end
  self.v_magic_effect_info[magic_id] = nil
end

return M
