local FightDefine = require("cs_share.fight_define")
local CommDefine = require("cs_share.common_define")
local ATTR_TYPE = FightDefine.ATTR_TYPE
local RES_TYPES = FightDefine.RES_ATTRS
local ATTR_MAX_TYPE = FightDefine.RES2MAX
local VALUE_TYPE = CommDefine.VALUE_TYPE
local ABNORMAL_STATUS = FightDefine.ABNORMAL_STATUS
local _min = math.min
local _max = math.max
local _init_attr = FightDefine.init_single_attr
local attr_is_res = FightDefine.attr_is_res
local char_abnormal_map = FightDefine.CHAR_ABNORMAL_MAP
local _mfloor = math.floor
local RATIO_IN = 10000
local ProxyEncryptTable = require("utils.proxy_encrypt_number_table")
local Base = require("obj.base_component")
local Math = require("base.mathx")
local MagicDef = require("cs_share.magic_def")
local MAGIC_TYPE = MagicDef.MAGIC_TYPE
local _clamp = Math.Clamp
local ACTIVATE_PHYSICS_COUNT = Config.ACTIVATE_PHYSICS_COUNT
local M = Util.create_child_mt(Base)
local RATIO_TYPE = Config.RATIO_TYPE
local SET_TYPE = Config.ATTR_SET_TYPE
local GROUP_TYPE = Config.ATTR_GROUP_TYPE
local DYING_PERCENT = 0.2
local DEFAULT_LISTENER_ATTR_MAP = {
  [ATTR_TYPE.CHAR_HP] = true,
  [ATTR_TYPE.CHAR_HP_MAX] = true
}
local MAX_LISTENER_COUNT = 5

function M:_init(char)
  Base._init(self)
  self.v_listener_attr_count = 0
  self.v_costom_listener_attr_map = {}
  self.v_char = char
  self.v_magic_attr_limit = {}
  self.camp = 0
  self.behitfly_count = 0
  self.v_attr_type_cfg = ShareRes.create("equip.attr_type")
  self:init_attr()
  self:init_abnormal_status()
  self.v_change_attrs = {}
end

function M:on_before_destroy()
  self.v_char = nil
  self.v_costom_listener_attr_map = nil
  self.v_magic_attr_limit = nil
  self.v_attr_type_cfg = nil
  self.v_change_attrs = nil
end

function M:inc_behitfly_count(count)
  if not count then
    return
  end
  self.behitfly_count = self.behitfly_count + count
end

function M:reset_behitfly_count()
  self.behitfly_count = 0
end

function M:can_beattack()
  return self.behitfly_count < self.v_char.character_cfg.Protect
end

local NO_MAX = -1

function M:init_res(res2max)
  local base_attr = self.v_base_attrs
  for res_type, max_type in pairs(res2max) do
    local value = max_type ~= NO_MAX and _clamp(base_attr[res_type].FIXED, 0, self:get_attr(max_type)) or 0
    self:on_attr_change(res_type, value)
    base_attr[res_type].FIXED = value
  end
end

function M:init_attr()
  self:release_all_single_attr()
  self.attrs = ProxyEncryptTable.create_encrypted_table()
  self.v_base_attrs = self.v_char:get_base_attrs()
  self.v_additive_attrs = FightDefine.get_empty_attrs()
  self.v_module_attrs = FightDefine.get_empty_attrs()
  self:update_module_attrs(true)
  self.v_attr_effect_link = {}
  for attr_type, attr in pairs(self.v_base_attrs) do
    if not attr_is_res(attr_type) then
      self.attrs[attr_type] = self:get_all_attr_value(attr_type)
    end
  end
  local res2max
  if self.v_char:is_hero() then
    res2max = FightDefine.HERO_RES2MAX
  else
    res2max = FightDefine.MONSTER_RES2MAX
  end
  self:init_res(res2max)
  self.v_tower_energy = {}
  self:init_tower_energy()
  self:check_char_dying()
end

function M:add_attr_link(tar_attr, source_attr)
  self.v_attr_effect_link[source_attr] = self.v_attr_effect_link[source_attr] or {}
  self.v_attr_effect_link[tar_attr] = self.v_attr_effect_link[tar_attr] or {}
  if self.v_attr_effect_link[tar_attr][source_attr] then
    print("Warmming!!! 出现套娃属性影响, 原属性, 影响属性", tar_attr, source_attr, debug.traceback())
    return
  end
  self.v_attr_effect_link[source_attr][tar_attr] = true
end

function M:remove_attr_link(tar_attr, source_attr)
  assert(self.v_attr_effect_link[source_attr])
  self.v_attr_effect_link[source_attr][tar_attr] = nil
end

local map_other_type = {}

function M:update_module_attrs(init)
  local module_attrs = self.v_char:get_module_attrs()
  if not module_attrs or not next(module_attrs) then
    return
  end
  for attr_type, attr in pairs(self.v_module_attrs) do
    local new_attr = module_attrs[attr_type]
    local fixed_value, ratio_value = 0, 0
    if new_attr then
      fixed_value, ratio_value = new_attr.FIXED, new_attr.RATIO
    end
    if fixed_value ~= attr.FIXED then
      if init then
        attr.FIXED = fixed_value
      else
        self:set_cur_attr(GROUP_TYPE.MODULE_ATTR, attr_type, fixed_value, VALUE_TYPE.FIXED, SET_TYPE.REPLACE)
      end
    end
    if ratio_value ~= attr.RATIO then
      if init then
        attr.RATIO = ratio_value / RATIO_IN
      else
        self:set_cur_attr(GROUP_TYPE.MODULE_ATTR, attr_type, ratio_value, VALUE_TYPE.RATIO, SET_TYPE.REPLACE)
      end
    end
    if init then
      UtilTable.clear_map(attr.OTHER_RATIO)
      if new_attr then
        for k, v in pairs(new_attr.OTHER_RATIO) do
          attr.OTHER_RATIO[k] = v / RATIO_IN
        end
      end
    else
      for t, _ in pairs(attr.OTHER_RATIO) do
        map_other_type[t] = true
      end
      if new_attr then
        for t, _ in pairs(new_attr.OTHER_RATIO) do
          map_other_type[t] = true
        end
      end
      for other_type, _ in pairs(map_other_type) do
        local new_value = new_attr and new_attr.OTHER_RATIO[other_type] or 0
        self:set_cur_attr(GROUP_TYPE.MODULE_ATTR, attr_type, new_value, VALUE_TYPE.RATIO, SET_TYPE.REPLACE, other_type)
        map_other_type[other_type] = nil
      end
    end
  end
  self.v_change_attrs = {}
end

local GET_SPECIAL_ATTR_FUNC = {
  [ATTR_TYPE.CHAR_HP_SHIELD] = function(char)
    if char:is_role() then
      return char:get_shield_num()
    else
      return 0
    end
  end
}

function M:get_attr(attr_type)
  if GET_SPECIAL_ATTR_FUNC[attr_type] then
    local special_func = GET_SPECIAL_ATTR_FUNC[attr_type]
    return special_func(self:get_char())
  else
    return self.attrs[attr_type]
  end
end

function M:get_fixed_attr(attr_type)
  if attr_is_res(attr_type) then
    return self.v_base_attrs[attr_type].FIXED
  end
  local base_attr = self.v_base_attrs[attr_type]
  local fixed_sum = base_attr.FIXED
  local add_ratio = base_attr.RATIO
  local value = fixed_sum * (1 + add_ratio)
  value = value + self:get_other_effect(base_attr.OTHER_RATIO)
  return value
end

function M:get_group_attrs(group_type)
  if group_type == GROUP_TYPE.BASE then
    return self.v_base_attrs
  elseif group_type == GROUP_TYPE.MODULE_ATTR then
    return self.v_module_attrs
  end
  return self.v_additive_attrs
end

function M:reset_group_attrs(group_type)
  local attrs = self:get_group_attrs(group_type)
  for attr_type, _ in pairs(attrs) do
    attrs[attr_type] = _init_attr()
  end
end

local AttrChangeFuncs = {
  [ATTR_TYPE.CHAR_SPEED] = function(self)
    local char = self.v_char
    if char and not char:is_destroy() then
      char:set_speed_ratio(self.attrs[ATTR_TYPE.CHAR_SPEED])
    end
  end
}
local AttrEmptyFuncs = {
  [ATTR_TYPE.CHAR_HP] = function(self, attacker, magic_id, missile)
    if self.v_char:is_die() then
      return
    end
    if self.v_char:is_hero() and magic_id then
      local magic_cfg = ShareRes.get_magic_cfg(magic_id)
      self.v_char:set_death_type(magic_cfg.BuddyDeadType)
    end
    local missile_id
    if missile then
      missile_id = missile.missile_id
      missile:add_kill_role_count(self.v_char.uuid)
    end
    BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.ON_BEFORE_NPC_HP_ZERO, self.v_char, attacker, magic_id, missile_id, missile)
    BehaviorMgr:call_behavior_fun(self.v_char, "on_self_before_npc_hp_zero", attacker, magic_id, missile_id, missile)
    BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.ON_NPC_HP_ZERO, self.v_char, attacker, magic_id, missile_id, missile)
    BehaviorMgr:call_behavior_fun(self.v_char, "on_self_npc_hp_zero", attacker, magic_id, missile_id, missile)
    if self.v_char:is_npc() then
      self.v_char:add_force_remove_timer()
    end
  end
}

function M:get_attr_max(attr_type)
  local max_type = ATTR_MAX_TYPE[attr_type]
  if not max_type then
    return
  end
  return self.attrs[max_type]
end

local ATTR_DEBUG = false
local DEBUG_ATTR = {}

local function calibrationValue(value, valueDecimalPlaces)
  local mult = 10 ^ (valueDecimalPlaces or 0)
  return _mfloor(value * mult + 0.5) / mult
end

local ATTR_FIXED_CHANGE_FUNC = {
  [SET_TYPE.REPLACE] = function(cur, value)
    cur.FIXED = value
  end,
  [SET_TYPE.CHANGE_BY_DELTA] = function(cur, value)
    cur.FIXED = calibrationValue((cur.FIXED or 0) + value, 2)
  end
}
local ATTR_RATIO_CHANGE_FUNC = {
  [true] = {
    [SET_TYPE.REPLACE] = function(cur, value, attr_type)
      if attr_is_res(attr_type) then
        cur.FIXED = cur.FIXED * value / RATIO_IN
      else
        cur.RATIO = value / RATIO_IN
      end
    end,
    [SET_TYPE.CHANGE_BY_DELTA] = function(cur, value, attr_type)
      if attr_is_res(attr_type) then
        cur.FIXED = cur.FIXED + cur.FIXED * value / RATIO_IN
      else
        cur.RATIO = cur.RATIO + value / RATIO_IN
      end
    end
  },
  [false] = {
    [SET_TYPE.REPLACE] = function(cur, value, attr_type, attr_ratio_type, self)
      if attr_is_res(attr_type) then
        cur.FIXED = self.attrs[attr_ratio_type] * value / RATIO_IN
      else
        cur.OTHER_RATIO[attr_ratio_type] = value / RATIO_IN
      end
    end,
    [SET_TYPE.CHANGE_BY_DELTA] = function(cur, value, attr_type, attr_ratio_type, self)
      if attr_is_res(attr_type) then
        cur.FIXED = cur.FIXED + self.attrs[attr_ratio_type] * value / RATIO_IN
      else
        local old = cur.OTHER_RATIO[attr_ratio_type] or 0
        cur.OTHER_RATIO[attr_ratio_type] = old + value / RATIO_IN
      end
    end
  }
}
local PASSIVE_ATTR = {
  [ATTR_TYPE.CHAR_HP_MAX] = ATTR_TYPE.CHAR_LOST_HP,
  [ATTR_TYPE.CHAR_HP] = ATTR_TYPE.CHAR_LOST_HP
}
local PASSIVE_ATTR_FUNC = {
  [ATTR_TYPE.CHAR_LOST_HP] = function(self)
    local cur_hp = self:get_attr(ATTR_TYPE.CHAR_HP)
    local max_hp = self:get_attr_max(ATTR_TYPE.CHAR_HP)
    self.v_base_attrs[ATTR_TYPE.CHAR_LOST_HP].FIXED = max_hp - cur_hp
  end
}

function M:try_change_passive_attr(attr_type)
  local passive_attr = PASSIVE_ATTR[attr_type]
  if not passive_attr then
    return
  end
  local func = PASSIVE_ATTR_FUNC[passive_attr]
  if not func then
    return
  end
  func(self)
  local new_value = self:get_all_attr_value(passive_attr)
  if self.attrs[passive_attr] == new_value then
    return
  end
  self:on_attr_change(passive_attr, new_value)
end

local CALIBRATION_ATTR = {
  [ATTR_TYPE.CHAR_HP_MAX] = ATTR_TYPE.CHAR_HP
}

function M:calibration_other_attr(attr_type, new_value)
  local calibration_attr = CALIBRATION_ATTR[attr_type]
  if not calibration_attr then
    return
  end
  local attr_value = self.attrs[calibration_attr]
  if attr_value and new_value < attr_value then
    self.attrs[calibration_attr] = new_value
    self:on_attr_change(calibration_attr, new_value)
    self:try_change_passive_attr(calibration_attr)
  end
end

local SET_CUR_ATTR_OTHER_ADD = {
  [ATTR_TYPE.CHAR_SP] = {
    [true] = ATTR_TYPE.GET_EXTRA_ENERGY_RATIO,
    [false] = ATTR_TYPE.USE_EXTRA_ENERGY_RATIO
  },
  [ATTR_TYPE.TEAM_SKILL_ENERGY] = {
    [true] = ATTR_TYPE.GET_EXTRA_EX_ENERGY_RATIO,
    [false] = ATTR_TYPE.USE_EXTRA_EX_ENERGY_RATIO
  },
  [ATTR_TYPE.COMBINE_ENERGY] = {
    [true] = ATTR_TYPE.ADD_COMBINE_ENERGY_RATIO
  }
}

function M:set_cur_attr(group_type, attr_type, value, value_type, set_type, attr_ratio_type, mArgs, is_can_deal, attacker, magic_id, missile)
  local is_change_hp_max = false
  local cur_hp, old_hp_percent
  if attr_type == ATTR_TYPE.CHAR_HP_MAX then
    is_change_hp_max = true
    cur_hp = self:get_attr(ATTR_TYPE.CHAR_HP)
    old_hp_percent = cur_hp / self:get_attr_max(ATTR_TYPE.CHAR_HP)
  end
  local ignoreDie = mArgs and mArgs.ignoreDie
  if not ignoreDie and self.v_char:is_die() then
    return
  end
  if ATTR_DEBUG and UtilTable.contains(DEBUG_ATTR, attr_type) then
    Log.Info(group_type, attr_type, value, value_type, set_type, attr_ratio_type, debug.traceback())
  end
  attr_ratio_type = attr_ratio_type or attr_type
  local attrs = self:get_group_attrs(group_type)
  local cur_attr = attrs[attr_type]
  Util.assert(cur_attr, "no such attr, group_type = ", group_type, " attr_type = ", attr_type)
  local value_type_is_fixed = value_type == VALUE_TYPE.FIXED
  local energy_ratio_type = SET_CUR_ATTR_OTHER_ADD[attr_type]
  if energy_ratio_type and value_type_is_fixed and set_type == SET_TYPE.CHANGE_BY_DELTA then
    local is_add = value > 0
    local ratio_type = energy_ratio_type[is_add]
    if ratio_type then
      value = value * (1 + self:get_attr(ratio_type) / RATIO_IN)
    end
  end
  if value_type_is_fixed then
    local func = ATTR_FIXED_CHANGE_FUNC[set_type]
    Util.assert(func, "ERROR NO FIXED_CHANGE_FUNC ATTR TYPE = ", attr_type, set_type)
    func(cur_attr, value)
  else
    local is_cur_attr_type = attr_type == attr_ratio_type
    local func = ATTR_RATIO_CHANGE_FUNC[is_cur_attr_type][set_type]
    Util.assert(func, "ERROR NO FIXED_CHANGE_FUNC ATTR TYPE = ", attr_type, set_type)
    func(cur_attr, value, attr_type, attr_ratio_type, self)
    if not is_cur_attr_type then
      local other_ratio = cur_attr.OTHER_RATIO
      for other_attr, value in pairs(other_ratio) do
        if 0 == value then
          other_ratio[other_attr] = nil
        end
        if self:check_other_ratio(attr_type, other_attr) then
          self:add_attr_link(attr_type, other_attr)
        else
          self:remove_attr_link(attr_type, other_attr)
        end
      end
    end
  end
  local max = self:get_attr_max(attr_type)
  if attr_is_res(attr_type) and max then
    cur_attr.FIXED = _clamp(cur_attr.FIXED, 0, max)
  end
  local magic_attr_limit_min, magic_attr_limit_max = self:get_magic_attr_limit(attr_type)
  if magic_attr_limit_min and magic_attr_limit_min > cur_attr.FIXED then
    cur_attr.FIXED = magic_attr_limit_min
  end
  if magic_attr_limit_max and magic_attr_limit_max < cur_attr.FIXED then
    cur_attr.FIXED = magic_attr_limit_max
  end
  local new_value = self:get_all_attr_value(attr_type)
  if self.attrs[attr_type] == new_value then
    return
  end
  if attr_type == ATTR_TYPE.CHAR_HP then
    local is_reduce = new_value < self.attrs[attr_type]
    self:check_play_reduce_hp_sound(is_reduce)
  end
  if is_can_deal and 1 == is_can_deal and new_value < 1 then
    new_value = 1
  end
  self:on_attr_change(attr_type, new_value, attacker, magic_id, missile)
  self:try_change_passive_attr(attr_type)
  self:calibration_other_attr(attr_type, new_value)
  if nil ~= attacker and attacker:is_monster() then
    self:check_char_dying()
  end
  if is_change_hp_max and not self.v_char:is_die() then
    self:after_hp_max_change(cur_hp, old_hp_percent)
  end
end

function M:after_hp_max_change(cur_hp, old_hp_percent)
  local new_hp_percent = cur_hp / self:get_attr_max(ATTR_TYPE.CHAR_HP)
  local change_value = (old_hp_percent - new_hp_percent) * self:get_attr_max(ATTR_TYPE.CHAR_HP)
  if 0 ~= change_value then
    self:set_cur_attr(Config.ATTR_GROUP_TYPE.BASE, ATTR_TYPE.CHAR_HP, change_value, CommDefine.VALUE_TYPE.FIXED, SET_TYPE.CHANGE_BY_DELTA)
  end
end

function M:check_char_dying()
  if not self.v_char:is_hero() then
    return
  end
  if self.v_is_dying_sound then
    return
  end
  local cur_hp = self:get_attr(ATTR_TYPE.CHAR_HP)
  local hp_max = self:get_attr(ATTR_TYPE.CHAR_HP_MAX)
  local precent = cur_hp / hp_max
  if precent <= DYING_PERCENT and Global.state_sound_mgr then
    Global.state_sound_mgr:trigger_char_state_by_id(self.v_char, Config.CHARACTER_STATE_TYPE.DYING)
    self.v_is_dying_sound = true
  end
end

function M:check_play_reduce_hp_sound(is_reduce)
  if not is_reduce then
    return
  end
  if not self.v_char:is_hero() then
    return
  end
  if Global.state_sound_mgr then
    Global.state_sound_mgr:trigger_fight_state_by_id(Config.FIGHT_STATE.CHAR_REDUCE_HP)
  end
end

function M:check_other_ratio(attr_type, other_attr)
  return self.v_base_attrs[attr_type].OTHER_RATIO[other_attr] or self.v_additive_attrs[attr_type].OTHER_RATIO[other_attr]
end

function M:set_attr_by_ratio(group_type, attr_type, attr_ratio_type, value, set_type)
  self:set_cur_attr(group_type, attr_type, value, VALUE_TYPE.RATIO, set_type, attr_ratio_type)
end

function M:check_dec_value(attr_type, value)
  return value
end

function M:get_other_effect(attr_types)
  local sum = 0
  for attr_type, ratio in pairs(attr_types) do
    if 0 ~= attr_type then
      sum = sum + self.attrs[attr_type] * ratio
    end
  end
  return sum
end

function M:get_all_attr_value(attr_type)
  local value = self.v_base_attrs[attr_type].FIXED
  if not attr_is_res(attr_type) then
    local base_attr, add_attr, module_attr = self.v_base_attrs[attr_type], self.v_additive_attrs[attr_type], self.v_module_attrs[attr_type]
    local fixed_sum = base_attr.FIXED + add_attr.FIXED + module_attr.FIXED
    local add_ratio = base_attr.RATIO + add_attr.RATIO + module_attr.RATIO
    value = fixed_sum * (1 + add_ratio)
    value = value + self:get_other_effect(base_attr.OTHER_RATIO)
    value = value + self:get_other_effect(add_attr.OTHER_RATIO)
    value = value + self:get_other_effect(module_attr.OTHER_RATIO)
  end
  return calibrationValue(value, 2)
end

function M:on_attr_change(attr_type, new_value, attacker, magic_id, missile)
  local value = new_value
  local max = self:get_attr_max(attr_type)
  if max then
    value = _min(value, max)
  end
  local attr_type_cfg = self.v_attr_type_cfg[attr_type]
  if ATTR_DEBUG and UtilTable.contains(DEBUG_ATTR, attr_type) then
    Log.Info("old new", self.attrs[attr_type], new_value)
  end
  local old_value = self.attrs[attr_type] or 0
  local value = _clamp(value, attr_type_cfg.Min, attr_type_cfg.Max)
  local magic_attr_limit_min, magic_attr_limit_max = self:get_magic_attr_limit(attr_type)
  if magic_attr_limit_min and value < magic_attr_limit_min then
    value = magic_attr_limit_min
  end
  if magic_attr_limit_max and magic_attr_limit_max < value then
    value = magic_attr_limit_max
  end
  value = calibrationValue(value, 2)
  self.attrs[attr_type] = value
  local is_msg = false
  if self.v_char:is_hero() then
    is_msg = true
  end
  local is_god = false
  if self.v_char:is_god() then
    is_msg = true
    is_god = true
  end
  if is_msg then
    if not is_god then
      local msg = MsgGame:mq_publish2(Const.MSG_HERO_ATTR_CHANGE)
      msg.mm_x = attr_type
      msg.mm_obj = self.v_char
    else
      local msg = MsgGame:mq_publish2(Const.MSG_GOD_ATTR_CHANGE)
      msg.mm_x = attr_type
    end
  end
  if DEFAULT_LISTENER_ATTR_MAP or self.v_costom_listener_attr_map[attr_type] then
    local msg = MsgGame:mq_publish2(Const.MSG_ON_ROLE_ATTR_CHANGE)
    msg.mm_x = self.v_char.uuid
    msg.mm_y = attr_type
    msg.mm_obj = (self.attrs[attr_type] or 0) - old_value
  end
  local effect_attrs = self.v_attr_effect_link[attr_type]
  if effect_attrs then
    for attr_type, _ in pairs(effect_attrs) do
      local effect_new_value = self:get_all_attr_value(attr_type)
      if self.attrs[attr_type] ~= effect_new_value then
        self:on_attr_change(attr_type, effect_new_value)
      end
    end
  end
  local attr_change_func = AttrChangeFuncs[attr_type]
  if attr_change_func then
    attr_change_func(self)
  end
  local is_building = MagicReporter:is_building_report()
  MagicReporter:push_action_start(is_building, CommDefine.MAGIC_ACTION_TYPE.attr_ept_func)
  local attr_ept_func = AttrEmptyFuncs[attr_type]
  if attr_ept_func and self.attrs[attr_type] <= 0 then
    attr_ept_func(self, attacker, magic_id, missile)
  end
  MagicReporter:push_action_end(is_building, CommDefine.MAGIC_ACTION_TYPE.attr_ept_func)
  if self.v_char:is_npc() and (attr_type == ATTR_TYPE.CHAR_HP or attr_type == ATTR_TYPE.CHAR_HP) then
    self.v_char:update_hp_val()
  end
  if self.v_char.fight_hud_mgr then
    self.v_char.fight_hud_mgr:refresh_attr(attr_type)
  end
end

function M:change_attr(group_type, attr_type, value, attacker, magic_id, missile)
  self:set_cur_attr(group_type, attr_type, value, VALUE_TYPE.FIXED, SET_TYPE.CHANGE_BY_DELTA, nil, nil, nil, attacker, magic_id, missile)
end

function M:low_update()
  self:update_tower_energy_val()
end

function M:get_hp()
  return self:get_attr(ATTR_TYPE.CHAR_HP)
end

function M:get_max_hp()
  return self:get_attr_max(ATTR_TYPE.CHAR_HP)
end

function M:get_hp_percent()
  return self:get_attr(ATTR_TYPE.CHAR_HP) / self:get_attr(ATTR_TYPE.CHAR_HP_MAX)
end

function M:pack_attr(attr_type, attr)
  local data = {
    attr_type = attr_type,
    attr_fixed_val = attr.FIXED,
    attr_ratio_val = attr.RATIO,
    other_attr = {}
  }
  for k, v in pairs(attr.OTHER_RATIO) do
    data.other_attr[k] = v
  end
  return data
end

function M:unpack_attr(data)
  local attr = FightDefine.init_single_attr()
  attr.FIXED = data.attr_fixed_val
  attr.RATIO = data.attr_ratio_val
  for k, v in pairs(data.other_attr) do
    attr.OTHER_RATIO[k] = v
  end
  return attr
end

function M:pack_attrs_data()
  local attr_data = {
    attr = {},
    base_attr = {},
    additive_attr = {},
    module_attr = {}
  }
  for k, v in pairs(self.attrs) do
    attr_data.attr[#attr_data.attr + 1] = {attr_type = k, attr_val = v}
  end
  for k, v in pairs(self.v_base_attrs) do
    if 0 ~= v.FIXED or 0 ~= v.RATIO or next(v.OTHER_RATIO) ~= nil then
      attr_data.base_attr[#attr_data.base_attr + 1] = self:pack_attr(k, v)
    end
  end
  for k, v in pairs(self.v_additive_attrs) do
    if 0 ~= v.FIXED or 0 ~= v.RATIO or next(v.OTHER_RATIO) ~= nil then
      attr_data.additive_attr[#attr_data.additive_attr + 1] = self:pack_attr(k, v)
    end
  end
  for k, v in pairs(self.v_module_attrs) do
    if 0 ~= v.FIXED or 0 ~= v.RATIO or next(v.OTHER_RATIO) ~= nil then
      attr_data.module_attr[#attr_data.module_attr + 1] = self:pack_attr(k, v)
    end
  end
  return attr_data
end

function M:restore_attrs(attr_data)
  self:release_all_single_attr()
  self.attrs = ProxyEncryptTable.create_encrypted_table()
  self.v_base_attrs = self.v_char:get_base_attrs()
  self.v_additive_attrs = FightDefine.get_empty_attrs()
  self.v_module_attrs = FightDefine.get_empty_attrs()
  self.v_attr_effect_link = {}
  for _, v in pairs(attr_data.attr) do
    self.attrs[v.attr_type] = calibrationValue(v.attr_val, 2)
  end
  for _, v in pairs(attr_data.base_attr) do
    FightDefine.push_single_attr_temp(self.v_base_attrs[v.attr_type])
    self.v_base_attrs[v.attr_type] = self:unpack_attr(v)
    for k, _ in pairs(v.other_attr) do
      self:add_attr_link(v.attr_type, k)
    end
  end
  for _, v in pairs(attr_data.additive_attr) do
    FightDefine.push_single_attr_temp(self.v_additive_attrs[v.attr_type])
    self.v_additive_attrs[v.attr_type] = self:unpack_attr(v)
    for k, _ in pairs(v.other_attr) do
      self:add_attr_link(v.attr_type, k)
    end
  end
  for _, v in pairs(attr_data.module_attr) do
    FightDefine.push_single_attr_temp(self.v_module_attrs[v.attr_type])
    self.v_module_attrs[v.attr_type] = self:unpack_attr(v)
    for k, _ in pairs(v.other_attr) do
      self:add_attr_link(v.attr_type, k)
    end
  end
end

function M:get_base_attrs()
  return self.v_base_attrs
end

function M:get_additive_attrs()
  return self.v_additive_attrs
end

function M:init_tower_energy()
  if not TowerMgr then
    return
  end
  local tower = TowerMgr:get_tower()
  if not tower then
    return
  end
  local tower_id = tower:get_tower_id()
  local tower_cfg = ShareRes.create("tower.tower", tower_id)
  local energy_id = tower_cfg.EnergyId
  if not energy_id or 0 == energy_id then
    return
  end
  local energy_cfg = ShareRes.get_tower_energy_cfg(energy_id)
  if not energy_cfg then
    return
  end
  for key, data in pairs(energy_cfg) do
    self.v_tower_energy[data.AttrId] = {
      fulle_magic_id = data.MagicId,
      energy_max_val = data.EnergyMax,
      change_time = data.ChangeTime,
      full_magic_id = data.MagicId,
      last_time = data.ChangeTime,
      attr_max_type = data.AttrMaxId
    }
  end
end

function M:update_tower_energy_val()
  local dt = Global.delta_time
  if not Global.hero then
    return
  end
  local magic_mgr = Global.hero.magic_mgr
  for attr_id, energy_data in pairs(self.v_tower_energy) do
    local cur_val = self:get_attr(attr_id)
    local max_val = self:get_attr(energy_data.attr_max_type)
    local full_magic_id = energy_data.full_magic_id
    if full_magic_id and 0 ~= full_magic_id and cur_val and max_val then
      if cur_val >= max_val and not energy_data.is_add_full_magic then
        magic_mgr:add_magic(Global.hero, full_magic_id, nil, nil, 1)
        energy_data.is_add_full_magic = true
      elseif cur_val < max_val and magic_mgr:get_magic_num(full_magic_id) > 0 then
        magic_mgr:remove_magic_by_id(full_magic_id)
        energy_data.is_add_full_magic = false
      end
    end
  end
end

function M:set_last_element_val(element_type, element_val)
  if not self.v_last_element_val_list then
    self.v_last_element_val_list = {}
  end
  self.v_last_element_val_list[element_type] = element_val
end

function M:get_last_element_val(element_type)
  if self.v_last_element_val_list and self.v_last_element_val_list[element_type] then
    return self.v_last_element_val_list[element_type]
  else
    return -1
  end
end

function M:reborn_init_res(res2max, attr_ratio_map)
  local base_attr = self.v_base_attrs
  for res_type, max_type in pairs(res2max) do
    local value = max_type ~= NO_MAX and _clamp(self:get_attr(max_type), 0, self:get_attr(max_type)) or 0
    local attr_ratio = attr_ratio_map[res_type]
    if value > 0 and attr_ratio then
      value = _mfloor(value * attr_ratio / 10000)
    end
    self:on_attr_change(res_type, value)
    base_attr[res_type].FIXED = value
  end
end

function M:reborn_set_attr(attr_ratio_map)
  self:reborn_update_module_attrs()
  local res2max = FightDefine.HERO_RES2MAX
  self:reborn_init_res(res2max, attr_ratio_map)
  self:check_char_dying()
end

function M:reborn_update_module_attrs()
  local module_attrs = self.v_char:get_module_attrs()
  if not module_attrs or not next(module_attrs) then
    return
  end
  local param = {ignoreDie = true}
  self.v_additive_attrs[ATTR_TYPE.CHAR_SPEED] = FightDefine.init_single_attr()
  for attr_type, attr in pairs(self.v_module_attrs) do
    local new_attr = module_attrs[attr_type]
    local fixed_value, ratio_value = 0, 0
    if new_attr then
      fixed_value, ratio_value = new_attr.FIXED, new_attr.RATIO
    end
    self:set_cur_attr(GROUP_TYPE.MODULE_ATTR, attr_type, fixed_value, VALUE_TYPE.FIXED, SET_TYPE.REPLACE, nil, param)
    self:set_cur_attr(GROUP_TYPE.MODULE_ATTR, attr_type, ratio_value, VALUE_TYPE.RATIO, SET_TYPE.REPLACE, nil, param)
    for t, _ in pairs(attr.OTHER_RATIO) do
      map_other_type[t] = true
    end
    if new_attr then
      for t, _ in pairs(new_attr.OTHER_RATIO) do
        map_other_type[t] = true
      end
    end
    for other_type, _ in pairs(map_other_type) do
      local new_value = new_attr and new_attr.OTHER_RATIO[other_type] or 0
      self:set_cur_attr(GROUP_TYPE.MODULE_ATTR, attr_type, new_value, VALUE_TYPE.RATIO, SET_TYPE.REPLACE, other_type, param)
      map_other_type[other_type] = nil
    end
  end
  self.v_change_attrs = {}
end

function M:init_abnormal_status()
  self.m_abnormal_status = {}
  local element_id
  for attr in pairs(char_abnormal_map) do
    if self:get_attr_max(attr) > 0 then
      element_id = FightDefine.AB_ATTR_TO_ELEMENT[attr]
      self.m_abnormal_status[attr] = FightDefine.ABNORMAL_DEFAULT_STATUS[element_id]
    else
      self.m_abnormal_status[attr] = FightDefine.ABNORMAL_STATUS.CLOSE
    end
  end
end

function M:get_abnormal_status(attr)
  return self.m_abnormal_status[attr]
end

function M:change_abnormal_status(attr, status)
  assert(self.m_abnormal_status[attr])
  if self.m_abnormal_status[attr] ~= status then
    local msg = MsgGame:mq_publish2(Const.MSG_ON_ELEMENT_STATE_CHANGE)
    msg.mm_obj = self.v_char.uuid
  end
  self.m_abnormal_status[attr] = status
end

function M:get_char()
  return self.v_char
end

function M:add_listener_attr(attr_id)
  if self.v_listener_attr_count >= MAX_LISTENER_COUNT then
    Log.Error("属性监听数量过多", debug.traceback())
    return
  end
  if self.v_costom_listener_attr_map[attr_id] or DEFAULT_LISTENER_ATTR_MAP[attr_id] then
    return
  end
  self.v_costom_listener_attr_map[attr_id] = true
  self.v_listener_attr_count = self.v_listener_attr_count + 1
end

function M:remove_listener_attr(attr_id)
  if not self.v_costom_listener_attr_map[attr_id] then
    return
  end
  self.v_listener_attr_count = self.v_listener_attr_count - 1
  self.v_costom_listener_attr_map[attr_id] = nil
end

function M:on_before_destroy()
  self.v_listener_attr_count = 0
  self.v_costom_listener_attr_map = {}
  self:release_all_single_attr()
end

local function release_single_attr(single_attrs)
  for _, single_attr in pairs(single_attrs) do
    FightDefine.push_single_attr_temp(single_attr)
  end
end

function M:release_all_single_attr()
  if self.v_additive_attrs then
    release_single_attr(self.v_additive_attrs)
    self.v_additive_attrs = nil
  end
  if self.v_module_attrs then
    release_single_attr(self.v_module_attrs)
    self.v_module_attrs = nil
  end
  if self.v_base_attrs then
    release_single_attr(self.v_base_attrs)
    self.v_base_attrs = nil
  end
end

function M:get_magic_attr_limit(attr_type)
  local attr_limit_map = self.v_magic_attr_limit[attr_type]
  if attr_limit_map then
    return attr_limit_map.min, attr_limit_map.max
  end
end

function M:set_magic_attr_limit(attr_type, attr_min, attr_max, magic_id)
  local attr_limit_map = self.v_magic_attr_limit[attr_type]
  if not attr_limit_map then
    attr_limit_map = {}
    self.v_magic_attr_limit[attr_type] = attr_limit_map
  end
  if attr_min and attr_min > self:get_attr(attr_type) then
    Log.Error(string.format("添加magic时属性超出锁定区间下限, id: %d, 目标npc: %d.%d, 当前值: %f, 下限: %f", magic_id, self.v_char:get_npc_id(), self.v_char.uuid, self:get_attr(attr_type), attr_min))
    return
  end
  if attr_max and attr_max < self:get_attr(attr_type) then
    Log.Error(string.format("添加magic时属性超出锁定区间上限, id: %d, 目标npc: %d.%d, 当前值: %f, 上限: %f", magic_id, self.v_char:get_npc_id(), self.v_char.uuid, self:get_attr(attr_type), attr_max))
    return
  end
  attr_limit_map.min = attr_min
  attr_limit_map.max = attr_max
end

return M
