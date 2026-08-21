local Base = require("obj.base_component")
local CommonDef = require("cs_share.common_define")
local TIME_SCALE_ID = 99887766
local FightDefine = Config.FightDefine
local ELEMENT_TYPE = FightDefine.ELEMENT_TYPE
local ELEMENT_TO_AB_ATTR = FightDefine.ELEMENT_TO_AB_ATTR
local ATTR_TYPE = FightDefine.ATTR_TYPE
local FightCalc = require("cs_share.fight_calc")
local THUNDER_TOTAL_TIME = ShareRes.get_comm_value("ThunderElementTotalTime")
local ATTR_GROUP_TYPE = Config.ATTR_GROUP_TYPE
local M = Util.create_child_mt(Base)
local FACTOR_RATIO_IN = 1.0E-4
local ABNORMAL_STATUS = FightDefine.ABNORMAL_STATUS
local DURATION_DAMAGE_CFG_INDEX = 2
local ELEMENT_ABNIRMAL_FLAG_MAGIC = {
  [ELEMENT_TYPE.WATER] = 1999980,
  [ELEMENT_TYPE.FIRE] = 1999981,
  [ELEMENT_TYPE.THUNDER] = 1999982,
  [ELEMENT_TYPE.LIGHT] = 1999983,
  [ELEMENT_TYPE.DARK] = 1999984,
  [ELEMENT_TYPE.BASE] = 1999985
}
local FightConfig = require("uimodule.fight.fight_config")
local VALUE_TYPE = FightConfig.VALUE_TYPE
local Math = require("base.mathx")

local function abnormal_attack_sort(a_uuid, b_uuid)
  local a = SceneMgr:pick_by_uuid(a_uuid)
  local b = SceneMgr:pick_by_uuid(b_uuid)
  local a_pure_essence = a:get_attr_value(ATTR_TYPE.ABNORMAL_PURE_ESSENCE)
  local b_pure_essence = b:get_attr_value(ATTR_TYPE.ABNORMAL_PURE_ESSENCE)
  local a_level_param = ShareRes.get_abnormal_level_param(a:get_break_level(), a:get_level())
  local b_level_param = ShareRes.get_abnormal_level_param(b:get_break_level(), b:get_level())
  if not a_level_param or not b_level_param then
    return false
  end
  if a_pure_essence ~= b_pure_essence then
    return a_pure_essence < b_pure_essence
  elseif a_level_param ~= b_level_param then
    return a_level_param < b_level_param
  else
    return false
  end
end

local function cal_light_damage(self, magic)
  local flag_count = magic:get_flag_count()
  local element_id, attacker, level_param, cfg_index, is_sustain = magic.element_id, magic.magic_info.attacker, magic.level_param, DURATION_DAMAGE_CFG_INDEX, true
  local abnor_pure_essen, new_attacker, new_level_param
  abnor_pure_essen, new_attacker, new_level_param = self:get_abnormal_attack_param(element_id)
  new_attacker = new_attacker or attacker
  if not new_attacker or new_attacker:is_destroy() then
    return
  end
  new_level_param = new_level_param or level_param
  return self:cal_abnormal_damage(element_id, new_attacker, new_level_param, abnor_pure_essen, cfg_index, is_sustain, flag_count)
end

local function cal_dark_damage(self, magic)
  local flag_count = magic:get_flag_count()
  local total_hurt = self.v_owner:get_dark_abnormal_total_hurt()
  local element_id, attacker, level_param = magic.element_id, magic.magic_info.attacker, magic.level_param
  local abnor_pure_essen, new_attacker, new_level_param
  abnor_pure_essen, new_attacker, new_level_param = self:get_abnormal_attack_param(element_id)
  new_attacker = new_attacker or attacker
  if not new_attacker or new_attacker:is_destroy() then
    return
  end
  new_level_param = new_level_param or level_param
  local atk_attrs = new_attacker.attr_mgr.attrs
  local def_attrs = self.v_owner.attr_mgr.attrs
  local dark_default_pure_essence_param = self:get_element_parameter(element_id, 2, abnor_pure_essen, flag_count)
  local pure_essence_param = self:get_element_parameter(element_id, 3, abnor_pure_essen, flag_count)
  local element_count = self:get_element_magic_count(element_id)
  local multiple = self:get_element_parameter(element_id, 4, abnor_pure_essen, flag_count)
  local limit = self:get_element_parameter(element_id, 5, abnor_pure_essen, flag_count) * new_level_param
  local cal_total_hurt = math.min(limit, -total_hurt)
  if self.v_owner.magic_mgr:check_immunity_damage_magic(FightDefine.DMG_TYPE.AB_SUS_DMG, element_id) then
    return 0
  end
  local hurt = FightCalc.CalcDarkSettleDamage(element_id, new_level_param, pure_essence_param, dark_default_pure_essence_param, cal_total_hurt, FightDefine.DMG_TYPE.AB_SUS_DMG, atk_attrs, def_attrs, element_count, multiple)
  return hurt
end

local EXECUTE_CHEKC_FUNC = {
  [ELEMENT_TYPE.LIGHT] = cal_light_damage,
  [ELEMENT_TYPE.DARK] = cal_dark_damage
}

function M:_on_role_hp_value_change(msg)
  local attr_type = msg.mm_y
  if not Config.HP_ATTR_TYPE[attr_type] then
    return
  end
  if self.v_owner:is_die() or self.v_owner:is_after_behitfly_die() then
    return
  end
  if msg.mm_x ~= self.v_owner.uuid or Util.is_destroy(self.v_owner) then
    return
  end
  self:can_execute_owner()
end

function M:_init(owner)
  Base._init(self)
  self.v_owner = owner
  self.v_duration_damage_data = {}
  self.v_abnor_magic_info = {}
  self.v_element_abnormal_flag_map = {}
  self.v_element_abnormal_caster_map = {}
  self.v_abnormal_effect_magic = {}
  self.v_additional_damage_data = nil
  self.v_element_delay_effect = {}
  self.v_effect_cfg = ShareRes.get_abnormal_damage_param()
  self.v_flag_max_count_map = ShareRes.get_comm_string_value("ElementAbnormalMaxFlagCount")
  self:init_abnormal_data()
  self:reset_data()
end

function M:on_before_destroy()
  self.v_owner = nil
  self.v_duration_damage_data = nil
  self.v_abnor_magic_info = nil
  self.v_element_abnormal_flag_map = nil
  self.v_element_abnormal_caster_map = nil
  self.v_abnormal_effect_magic = nil
  self.v_additional_damage_data = nil
  self.v_element_delay_effect = nil
  self.v_effect_cfg = nil
  self.v_flag_max_count_map = nil
end

local function get_abnor_magic_param(self, magic_rtid)
  local abnor_count, add_time, total_time
  local abnor_magic = self.v_owner.magic_mgr:get_magic_by_rtid(magic_rtid)
  if not abnor_magic then
    Log.Error("元素超载获取相关异常magic失败", debug.traceback())
    return false
  end
  abnor_count = abnor_magic:get_flag_count()
  total_time = abnor_magic.duration
  add_time = abnor_magic:get_add_time()
  return true, abnor_count, total_time, add_time
end

function M:update()
  if self.v_owner:is_die() or self.v_owner:is_after_behitfly_die() then
    return
  end
  local dt = GlobalTimeMgr:get_dt_time()
  self:update_add_abnormal_magic()
  self:update_duration_damage(dt)
  self:update_additional_damage(dt)
end

function M:low_update()
  if self.v_owner:is_die() or self.v_owner:is_after_behitfly_die() then
    return
  end
  self:update_abnormal_timer()
  self:update_element_delay_effect()
end

function M:set_element_abnormal_caster(element_id, caster_uuid)
  self.v_element_abnormal_caster_map[element_id] = caster_uuid
end

function M:get_element_abnormal_caster(element_id)
  return self.v_element_abnormal_caster_map[element_id]
end

function M:cache_abnor_magic(npc, skill_id, element_id)
  self.v_abnor_magic_info.element_id = element_id
  self.v_abnor_magic_info.skill_id = skill_id
  self.v_abnor_magic_info.npc = npc
end

function M:add_abnor_magic(element)
  if self.v_owner:is_die() or self.v_owner:is_after_behitfly_die() then
    return
  end
  if not self.v_abnor_magic_info or Util.is_destroy(self.v_abnor_magic_info.npc) or self:is_destroy() then
    return
  end
  local element_cfg = ShareRes.create("buddy.buddy_element", element)
  if not element_cfg or not Util.is_more_than_zero(element_cfg.AbnorMagicId) then
    return
  end
  local magic_id = element_cfg.AbnorMagicId
  local skill_id = self.v_abnor_magic_info.skill_id
  local attacker = self.v_abnor_magic_info.npc
  if attacker:is_hero() or attacker:is_summons() then
    self:set_element_abnormal_caster(element, attacker.uuid)
    BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.ON_ELEMENT_ABORN_START, self.v_owner, element, skill_id, attacker)
    BehaviorMgr:call_behavior_fun(self.v_owner, "on_target_self_element_aborn_start", attacker, element, skill_id)
    BehaviorMgr:call_behavior_fun(attacker, "on_self_element_aborn_start", self.v_owner, element, skill_id)
    local ext_args = {
      arg = {
        arg = {
          [1] = Date.server_time()
        }
      }
    }
    local rtid = self.v_owner.magic_mgr:add_magic(attacker, magic_id, nil, nil, 1, nil, ext_args)
    self:add_abnormal_magic_rtid(rtid)
    self.v_owner.magic_mgr:remove_abnormal_flag_magic(element)
  end
end

function M:add_abnor_physics_magic()
  if self.v_owner:is_die() or self.v_owner:is_after_behitfly_die() then
    return
  end
  if self:is_destroy() then
    return
  end
  local element = FightDefine.ELEMENT_TYPE.BASE
  local attacker = self:get_abnor_physics_attacker()
  if Util.is_destroy(attacker) then
    Log.Error("元素超载获取攻击者失败", debug.traceback())
    return
  end
  local element_cfg = ShareRes.create("buddy.buddy_element", element)
  if not element_cfg or not Util.is_more_than_zero(element_cfg.AbnorMagicId) then
    return
  end
  local skill_id = self.v_abnor_magic_info.skill_id
  BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.ON_ELEMENT_ABORN_START, self.v_owner, element, skill_id, attacker)
  BehaviorMgr:call_behavior_fun(self.v_owner, "on_target_self_element_aborn_start", attacker, element, skill_id)
  BehaviorMgr:call_behavior_fun(attacker, "on_self_element_aborn_start", self.v_owner, element, skill_id)
  local magic_id = element_cfg.AbnorMagicId
  local ext_args = {
    arg = {
      arg = {
        [1] = Date.server_time()
      }
    }
  }
  self.v_owner.magic_mgr:add_magic(attacker, magic_id, nil, nil, 1, nil, ext_args)
  self.v_owner.magic_mgr:remove_abnormal_flag_magic(element)
end

function M:after_add_abnor_magic()
  UtilTable.clear_map(self.v_abnor_magic_info)
end

function M:add_time_scale(duration)
  if not self.v_owner.time_mgr or duration <= 0 then
    return
  end
  local remain_time = self.v_owner.time_mgr:remove_time_scale(TIME_SCALE_ID)
  if Util.is_more_than_zero(remain_time) then
    duration = remain_time + duration
  end
  local scale_data = {
    magic_id = TIME_SCALE_ID,
    ignore_move = true,
    effect_type = Config.TIME_SCALE_EFFECT_TYPE.FREEZE
  }
  self.v_owner.time_mgr:add_time_scale(0, duration, scale_data)
  if not self.v_effect_id_map[ELEMENT_TYPE.WATER][DURATION_DAMAGE_CFG_INDEX] then
    local effect_id = self:play_effect(ELEMENT_TYPE.WATER, false, -1)
    self.v_effect_id_map[ELEMENT_TYPE.WATER][DURATION_DAMAGE_CFG_INDEX] = effect_id
    if self.v_effect_timer then
      Timer:remove_timer(self.v_effect_timer)
      self.v_effect_timer = nil
    end
    self.v_effect_timer = Timer:add_timer("element_abnormal_effect", duration, function()
      self.v_owner.act_effect_ctrl:stop_effect(effect_id)
      self.v_effect_id_map[ELEMENT_TYPE.WATER][DURATION_DAMAGE_CFG_INDEX] = nil
    end)
  end
end

function M:remove_time_scale()
  if not self.v_owner.time_mgr then
    return
  end
  self.v_owner.time_mgr:remove_time_scale(TIME_SCALE_ID)
end

function M:add_duration_damage(magic_id, magic_rtid, element_id, attacker, flag_count)
  local lv = attacker:get_level()
  local break_lv = attacker:get_break_level()
  local level_param = ShareRes.get_abnormal_level_param(break_lv, lv)
  if Util.is_destroy(attacker) or not level_param then
    return
  end
  local abnor_pure_essen = attacker:get_attr_value(ATTR_TYPE.ABNORMAL_PURE_ESSENCE)
  local duration = self:get_element_parameter(element_id, 3, abnor_pure_essen, flag_count)
  local effect_time = self:get_element_parameter(element_id, 4, abnor_pure_essen, flag_count)
  self.v_duration_damage_data[magic_rtid] = self.v_duration_damage_data[magic_rtid] or {}
  local damage_data = self.v_duration_damage_data[magic_rtid]
  damage_data.magic_id = magic_id
  damage_data.duration = duration
  damage_data.left_duration = duration
  damage_data.effect_time = effect_time
  damage_data.effect_cd = 0
  damage_data.element_id = element_id
  damage_data.attacker_uuid = attacker.uuid
  damage_data.flag_count = flag_count
end

function M:duration_damage_effect(magic_rtid)
  if self:is_destroy() then
    return
  end
  local data = self.v_duration_damage_data[magic_rtid]
  local magic_mgr = self.v_owner.magic_mgr
  local magic = self.v_owner.magic_mgr:get_magic_by_rtid(magic_rtid)
  local abnor_pure_essen, attacker, level_param = self:get_abnormal_attack_param(data.element_id)
  if magic and not Util.is_destroy(attacker) then
    BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.BEFORE_ABNORMAL_DAMAGE, magic.magic_info.attacker, attacker, self.v_owner, magic.magic_id)
    local hurt = self:cal_abnormal_damage(data.element_id, attacker, level_param, abnor_pure_essen, 2, true, data.flag_count)
    self:play_effect(data.element_id, false)
    local ext_args = {
      arg = {
        type = Config.MagicDefine.MAGIC_CUSTOM_EVENTS_DEFINE_TYPE.DEDUCT_HP,
        arg = {
          [1] = hurt,
          [2] = data.element_id
        }
      }
    }
    if JournalMgr then
      Util.insert_abhurt_info_to_journal(attacker, self.v_owner, hurt, magic, 2, true)
    end
    magic_mgr:add_magic(attacker, Config.CUSTOM_MAGIC, nil, nil, 1, nil, ext_args)
    BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.AFTER_ABNORMAL_DAMAGE, magic.magic_info.attacker, attacker, self.v_owner, magic.magic_id)
    return
  else
    if not magic then
      Log.Error("获取异常magic失败, 火异常将移除, magic_id", data.magic_id)
    end
    if Util.is_destroy(attacker) then
      Log.Error("获取异常攻击者失败, 火异常将移除")
    end
    self:remove_duration_damage(magic_rtid)
    return
  end
end

function M:remove_duration_damage(magic_rtid)
  if self.v_duration_damage_data[magic_rtid] then
    self.v_duration_damage_data[magic_rtid] = nil
    self.v_owner.magic_mgr:remove_magic_by_rtid(magic_rtid)
  end
end

function M:get_duration_damage()
  return self.v_duration_damage_data
end

function M:update_duration_damage(dt)
  for magic_rtid, data in pairs(self.v_duration_damage_data) do
    local magic = self.v_owner.magic_mgr:get_magic_by_rtid(magic_rtid)
    if magic then
      data.effect_cd = data.effect_cd + dt
      local time = math.floor(data.effect_cd / data.effect_time)
      if time > 0 then
        for _ = 1, time do
          self:duration_damage_effect(magic_rtid)
          data.effect_cd = data.effect_cd - data.effect_time
        end
      end
      data.duration = data.duration - dt
      if data.duration <= 0 then
        self:remove_duration_damage(magic_rtid)
      end
    else
      self:remove_duration_damage(magic_rtid)
    end
  end
end

function M:add_additional_damage(magic_id, element_id, attacker, magic_rtid, flag_count)
  if Util.is_destroy(attacker) then
    return
  end
  local lv = attacker:get_level()
  local break_lv = attacker:get_break_level()
  local level_param = ShareRes.get_abnormal_level_param(break_lv, lv)
  if not level_param then
    local _element_id = self.v_abnor_magic_info.element_id
    local skill_id = self.v_abnor_magic_info.skill_id
    local npc = self.v_abnor_magic_info.npc
    Log.Error("添加异常失败， 攻击者id：", magic_id, attacker.id, self.v_owner.id, _element_id, skill_id, npc and npc.id)
    return
  end
  self.v_additional_damage_data = self.v_additional_damage_data or {}
  local data = self.v_additional_damage_data
  data.active = true
  local abnor_pure_essen = attacker:get_attr_value(ATTR_TYPE.ABNORMAL_PURE_ESSENCE)
  local refresh_time = self:get_element_parameter(element_id, 3, abnor_pure_essen, flag_count)
  data.refersh_time = refresh_time
  data.refersh_cd = 0
  data.magic_id = magic_id
  data.element_id = element_id
  data.magic_rtid = magic_rtid
  local magic_cfg = ShareRes.get_magic_cfg(magic_id)
  local duration = data.duration or 0
  data.duration = math.min(duration + magic_cfg.logic.Duration, THUNDER_TOTAL_TIME)
  data.left_duration = data.duration
  data.flag_count = flag_count
end

function M:additional_damage_effect()
  if self:is_destroy() then
    return
  end
  local data = self.v_additional_damage_data
  local magic = self.v_owner.magic_mgr:get_magic_by_rtid(data.magic_rtid)
  local abnor_pure_essen, attacker, level_param = self:get_abnormal_attack_param(data.element_id)
  if magic and not Util.is_destroy(attacker) then
    BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.BEFORE_ABNORMAL_DAMAGE, magic.magic_info.attacker, attacker, self.v_owner, magic.magic_id)
    local hurt = self:cal_additional_damage(data.element_id, attacker, level_param, abnor_pure_essen, 2, true, data.flag_count)
    self:play_effect(data.element_id, false)
    local ext_args = {
      arg = {
        type = Config.MagicDefine.MAGIC_CUSTOM_EVENTS_DEFINE_TYPE.DEDUCT_HP,
        arg = {
          [1] = hurt,
          [2] = data.element_id
        }
      }
    }
    if JournalMgr then
      Util.insert_abhurt_info_to_journal(attacker, self.v_owner, hurt, magic, 2, true)
    end
    self.v_owner.magic_mgr:add_magic(attacker, Config.CUSTOM_MAGIC, nil, nil, 1, nil, ext_args)
    BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.AFTER_ABNORMAL_DAMAGE, magic.magic_info.attacker, attacker, self.v_owner, magic.magic_id)
    data.active = false
    data.refersh_cd = 0
  else
    if not magic then
      Log.Error("获取异常magic失败, 雷异常将移除, magic_id", data.magic_id)
    end
    if Util.is_destroy(attacker) then
      Log.Error("获取异常攻击者失败, 雷异常将移除")
    end
    self:remove_additional_damage()
  end
end

function M:remove_additional_damage()
  if self.v_additional_damage_data then
    self.v_additional_damage_data = nil
  end
end

function M:get_additional_damage()
  return self.v_additional_damage_data
end

function M:update_additional_damage(dt)
  if not self.v_additional_damage_data then
    return
  end
  local data = self.v_additional_damage_data
  data.refersh_cd = data.refersh_cd + dt
  if not data.active and data.refersh_cd >= data.refersh_time then
    data.active = true
    data.refersh_cd = 0
  end
  data.duration = data.duration - dt
  if data.duration <= 0 then
    self:remove_additional_damage()
  end
end

function M:check_additional_damage()
  local data = self.v_additional_damage_data
  if data and data.active then
    self:additional_damage_effect()
  end
end

function M:record_first_trigger_dark_magic_rtid(magic_rtid)
  if not self.v_first_trigger_dark_magic_rtid then
    self.v_first_trigger_dark_magic_rtid = magic_rtid
  end
end

function M:get_first_trigger_dark_magic_rtid()
  return self.v_first_trigger_dark_magic_rtid
end

function M:play_effect(element_id, is_trigger, len, play_delay, bind_type)
  local element_cfg = ShareRes.get_element_cfg(element_id)
  local effect_id
  if nil ~= is_trigger then
    local prefab_name = is_trigger and element_cfg.TriggerEffect or element_cfg.DamageEffect
    if not Util.is_empty(prefab_name) then
      local attach_point = is_trigger and element_cfg.TriggerEffectJoint or element_cfg.DamageEffectJoint
      local act_effect_ctrl = self.v_owner.act_effect_ctrl
      local param = act_effect_ctrl.create_effect_param()
      param.attach_point = attach_point
      param.prefab_name = prefab_name
      param.effect_length = len
      param.not_time_scale = true
      param.effect_bind_type = bind_type
      effect_id = act_effect_ctrl:play_attach_effect(param, self.v_owner)
    end
  end
  if play_delay and element_cfg.DelayEffect and #element_cfg.DelayEffect >= 2 then
    self:add_element_delay_effect(element_id, bind_type)
  end
  return effect_id
end

function M:trigger_damage(element_id, attacker, level_param, magic, cfg_index, is_sustain, flag_count)
  local abnor_pure_essen, new_attacker, new_level_param
  if element_id == ELEMENT_TYPE.BASE then
    new_attacker = attacker
    local lv = new_attacker:get_level()
    local break_lv = new_attacker:get_break_level()
    abnor_pure_essen = new_attacker:get_attr_value(ATTR_TYPE.ABNORMAL_PURE_ESSENCE)
    new_level_param = ShareRes.get_abnormal_level_param(break_lv, lv)
  else
    abnor_pure_essen, new_attacker, new_level_param = self:get_abnormal_attack_param(element_id)
    new_attacker = new_attacker or attacker
    new_level_param = new_level_param or level_param
  end
  if not new_attacker or new_attacker:is_destroy() then
    return
  end
  local is_building = MagicReporter:is_building_report()
  MagicReporter:push_action_start(is_building, CommonDef.MAGIC_ACTION_TYPE.on_before_element_abnormal_effect)
  local magic_info = magic.magic_info
  BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.BEFORE_ABNORMAL_DAMAGE, magic_info.attacker, new_attacker, self.v_owner, magic.magic_id)
  MagicReporter:push_action_end(is_building, CommonDef.MAGIC_ACTION_TYPE.on_before_element_abnormal_effect)
  local hurt
  local damage_type = is_sustain and FightDefine.DMG_TYPE.AB_SUS_DMG or FightDefine.DMG_TYPE.AB_TRI_DMG
  if self.v_owner.magic_mgr:check_immunity_damage_magic(damage_type, element_id) then
    hurt = 0
  else
    hurt = self:cal_abnormal_damage(element_id, new_attacker, new_level_param, abnor_pure_essen, cfg_index, is_sustain, flag_count)
  end
  if JournalMgr then
    Util.insert_abhurt_info_to_journal(new_attacker, self.v_owner, hurt, magic, cfg_index, is_sustain)
  end
  self.v_owner.attr_mgr:change_attr(ATTR_GROUP_TYPE.BASE, Config.CHAR_ATTR_TYPE.CHAR_HP, hurt)
  MagicReporter:push_action_start(is_building, CommonDef.MAGIC_ACTION_TYPE.on_after_element_abnormal_effect)
  BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.AFTER_ABNORMAL_DAMAGE, magic_info.attacker, new_attacker, self.v_owner, magic.magic_id)
  MagicReporter:push_action_end(is_building, CommonDef.MAGIC_ACTION_TYPE.on_after_element_abnormal_effect)
  if is_sustain then
    Global.BloodHelper.play_abnor_hurt_dmg(self.v_owner, -hurt, element_id)
  else
    Global.BloodHelper.play_abnor_trigger_hurt_dmg(self.v_owner, -hurt, element_id)
    if element_id == FightDefine.ELEMENT_TYPE.BASE then
      Global.BloodHelper.play_abnor_font(self.v_owner, element_id)
    end
  end
end

function M:trigger_dark_remove_damage(attacker, element_id, level_param, total_hurt, magic, flag_count)
  local abnor_pure_essen, new_attacker, new_level_param
  abnor_pure_essen, new_attacker, new_level_param = self:get_abnormal_attack_param(element_id)
  new_attacker = new_attacker or attacker
  if not new_attacker or new_attacker:is_destroy() then
    return
  end
  new_level_param = new_level_param or level_param
  local atk_attrs = new_attacker.attr_mgr.attrs
  local def_attrs = self.v_owner.attr_mgr.attrs
  local dark_default_pure_essence_param = self:get_element_parameter(element_id, 2, abnor_pure_essen, flag_count)
  local pure_essence_param = self:get_element_parameter(element_id, 3, abnor_pure_essen, flag_count)
  local element_count = self:get_element_magic_count(element_id)
  local multiple = self:get_element_parameter(element_id, 4, abnor_pure_essen, flag_count)
  local is_building = MagicReporter:is_building_report()
  MagicReporter:push_action_start(is_building, CommonDef.MAGIC_ACTION_TYPE.on_before_element_abnormal_effect)
  local magic_info = magic.magic_info
  BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.BEFORE_ABNORMAL_DAMAGE, magic_info.attacker, new_attacker, self.v_owner, magic.magic_id)
  MagicReporter:push_action_end(is_building, CommonDef.MAGIC_ACTION_TYPE.on_before_element_abnormal_effect)
  local limit = self:get_element_parameter(element_id, 5, abnor_pure_essen, flag_count) * new_level_param
  local cal_total_hurt = math.min(limit, -total_hurt)
  local hurt
  if self.v_owner.magic_mgr:check_immunity_damage_magic(FightDefine.DMG_TYPE.AB_SUS_DMG, element_id) then
    hurt = 0
  else
    hurt = FightCalc.CalcDarkSettleDamage(element_id, new_level_param, pure_essence_param, dark_default_pure_essence_param, cal_total_hurt, FightDefine.DMG_TYPE.AB_SUS_DMG, atk_attrs, def_attrs, element_count, multiple)
  end
  if JournalMgr then
    Util.insert_abhurt_info_to_journal(new_attacker, self.v_owner, hurt, magic, 2, true)
  end
  self.v_owner.attr_mgr:change_attr(Config.ATTR_GROUP_TYPE.BASE, Config.CHAR_ATTR_TYPE.CHAR_HP, hurt)
  MagicReporter:push_action_start(is_building, CommonDef.MAGIC_ACTION_TYPE.on_after_element_abnormal_effect)
  BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.AFTER_ABNORMAL_DAMAGE, magic_info.attacker, new_attacker, self.v_owner, magic.magic_id)
  MagicReporter:push_action_end(is_building, CommonDef.MAGIC_ACTION_TYPE.on_after_element_abnormal_effect)
  Global.BloodHelper.play_abnor_hurt_dmg(self.v_owner, -hurt, element_id)
end

function M:cal_abnormal_damage(element_id, attacker, level_param, abnor_pure_essen, cfg_index, is_sustain, flag_count, calc_abnormal_max)
  local atk_attrs = attacker.attr_mgr.attrs
  local def_attrs = self.v_owner.attr_mgr.attrs
  local damage_type = is_sustain and FightDefine.DMG_TYPE.AB_SUS_DMG or FightDefine.DMG_TYPE.AB_TRI_DMG
  local pure_essence_param = self:get_element_parameter(element_id, cfg_index, abnor_pure_essen, flag_count)
  if self.v_owner.magic_mgr:check_immunity_damage_magic(damage_type, element_id) then
    return 0
  end
  if element_id == FightDefine.ELEMENT_TYPE.BASE then
    return self:cal_overload_damage(element_id, level_param, pure_essence_param, damage_type, atk_attrs, def_attrs)
  else
    return FightCalc.CalcAbnormalEffectDamage(element_id, level_param, pure_essence_param, damage_type, atk_attrs, def_attrs, calc_abnormal_max)
  end
end

function M:cal_overload_damage(element_id, level_param, pure_essence_param, damage_type, atk_attrs, def_attrs)
  local abnor_count1, remain_time1, total_time1, abnor_count2, remain_time2, total_time2 = 0, 0, 0, 0, 0, 0
  local magic_rtid, add_time1, add_time2, get_magic_suc
  local magic_count = #self.v_abnormal_effect_magic
  if magic_count < 2 then
    Log.Error("元素超载获取相关异常magic失败, 元素超载无法生效", debug.traceback())
    return 0
  end
  for index = magic_count, magic_count - 1, -1 do
    magic_rtid = self.v_abnormal_effect_magic[index]
    if index == magic_count then
      get_magic_suc, abnor_count2, total_time2, add_time2 = get_abnor_magic_param(self, magic_rtid)
      remain_time2 = total_time2
      if not get_magic_suc then
        break
      end
    else
      get_magic_suc, abnor_count1, total_time1, add_time1 = get_abnor_magic_param(self, magic_rtid)
      remain_time1 = total_time1 + add_time1 - add_time2
      break
    end
  end
  if not get_magic_suc then
    Log.Error("元素超载获取相关异常magic失败, 元素超载无法生效", debug.traceback())
    return 0
  end
  local layer_param = self.v_effect_cfg[ELEMENT_TYPE.BASE][1].LayerParam
  if not layer_param or 0 == layer_param then
    Log.Error("专精参数 101 配置的LayerParam不可为空或0", debug.traceback())
    layer_param = 1
  end
  local intget1 = math.ceil(remain_time1 / layer_param)
  remain_time1 = math.min(intget1 * layer_param, total_time1)
  local intget2 = math.ceil(remain_time2 / layer_param)
  remain_time2 = math.min(intget2 * layer_param, total_time2)
  return FightCalc.CalcElementOverLoadDamage(element_id, level_param, pure_essence_param, damage_type, atk_attrs, def_attrs, nil, abnor_count1, remain_time1, total_time1, abnor_count2, remain_time2, total_time2)
end

function M:cal_additional_damage(element_id, attacker, level_param, abnor_pure_essen, cfg_index, is_sustain, flag_count)
  local atk_attrs = attacker.attr_mgr.attrs
  local def_attrs = self.v_owner.attr_mgr.attrs
  local damage_type = is_sustain and FightDefine.DMG_TYPE.AB_SUS_DMG or FightDefine.DMG_TYPE.AB_TRI_DMG
  local multiple = self:get_element_parameter(element_id, 4, abnor_pure_essen, flag_count)
  local pure_essence_param = self:get_element_parameter(element_id, cfg_index, abnor_pure_essen, flag_count)
  local element_count = self:get_element_magic_count(element_id)
  if self.v_owner.magic_mgr:check_immunity_damage_magic(damage_type, element_id) then
    return 0
  end
  return FightCalc.CalcThunderAdditionalDamage(element_id, level_param, pure_essence_param, damage_type, atk_attrs, def_attrs, nil, element_count, multiple)
end

function M:get_element_parameter(element_id, index, abnor_pure_essen, flag_count)
  if not self.v_effect_cfg[element_id] or not self.v_effect_cfg[element_id][index] then
    Log.Error("获取异常专精参数配置失败，请检查配置,异常专精索引值为：", element_id * 100 + index, debug.traceback())
    return 0
  end
  local element_effect_cfg = self.v_effect_cfg[element_id]
  if element_effect_cfg[index].IsConst and element_effect_cfg[index].IsConst > 0 then
    return element_effect_cfg[index].EffectParam
  else
    local layer_cal_value = 1
    local layer_param = element_effect_cfg[index].LayerParam
    if layer_param and layer_param > 0 and element_id ~= ELEMENT_TYPE.BASE then
      if not flag_count then
        Log.Error("标记层数为空，需检查逻辑", debug.traceback())
        flag_count = 0
      end
      layer_cal_value = 1 + layer_param * flag_count
    end
    local effect_param = element_effect_cfg[index].EffectParam
    local f1 = element_effect_cfg[index].Factor1
    local f2 = element_effect_cfg[index].Factor2
    local f3 = element_effect_cfg[index].Factor3
    return effect_param * FACTOR_RATIO_IN * (math.log(f1 * abnor_pure_essen + f2) + f3) * layer_cal_value
  end
end

function M:get_element_magic_count(element_id)
  return self.v_abnormal_count[element_id]
end

function M:on_element_magic_begin(element_id, magic_rtid, magic_id, owner_uuid)
  if not self.v_element_magic_map[element_id] or self.v_element_magic_map[element_id][magic_rtid] then
    return
  end
  self.v_element_magic_map[element_id][magic_rtid] = true
  self.v_abnormal_count[element_id] = self.v_abnormal_count[element_id] + 1
  if EXECUTE_CHEKC_FUNC[element_id] and not self.v_hp_change_msg_handle then
    self.v_hp_change_msg_handle = self:mgr_bind_auto_mq(Const.MSG_ON_ROLE_ATTR_CHANGE, self._on_role_hp_value_change, self)
  end
end

function M:on_element_magic_end(element_id, magic_rtid, magic_id, owner_uuid)
  if not self.v_element_magic_map[element_id] or not self.v_element_magic_map[element_id][magic_rtid] then
    return
  end
  self.v_element_magic_map[element_id][magic_rtid] = nil
  if not next(self.v_element_magic_map[element_id]) then
    self.v_abnormal_count[element_id] = 0
    if self.v_hp_change_msg_handle then
      self:check_hp_change_msg_handle_remove()
    end
  end
  if self.v_first_trigger_dark_magic_rtid == magic_rtid then
    self.v_first_trigger_dark_magic_rtid = nil
  end
  if element_id == ELEMENT_TYPE.THUNDER and self.v_additional_damage_data and self.v_additional_damage_data.magic_rtid == magic_rtid then
    self:remove_additional_damage()
  end
  self:remove_abnormal_magic_rtid(magic_rtid)
end

function M:add_abnormal_attr_uuid(attr_type, attacker)
  if not attacker then
    return
  end
  local uuid = attacker.uuid
  local element_id = FightDefine.AB_ATTR_TO_ELEMENT[attr_type]
  local is_trigger = self:check_abnormal_on_timer(element_id)
  local uuid_map = is_trigger and self.v_abnor_trigger_uuid_map or self.v_abnormal_uuid_map
  local uuid_list = is_trigger and self.v_abnor_trigger_uuid_list or self.v_abnormal_uuid_list
  local need_sort = nil == uuid_map[attr_type][uuid]
  uuid_map[attr_type][uuid] = true
  if need_sort then
    local list = uuid_list[attr_type]
    UtilTable.clear_list(list)
    local record_attacker
    for uuid in pairs(uuid_map[attr_type]) do
      record_attacker = SceneMgr:pick_by_uuid(uuid)
      if not Util.is_destroy(record_attacker) then
        list[#list + 1] = uuid
      else
        uuid_map[attr_type][uuid] = nil
      end
    end
    table.sort(list, abnormal_attack_sort)
  end
end

function M:get_abnormal_attack_param(element_id)
  local attr_id = ELEMENT_TO_AB_ATTR[element_id]
  local attacker
  local abnormal_pure_essence = 0
  local use_attacker
  local level_param = 0
  local length = #self.v_abnormal_uuid_list[attr_id]
  local attacker_uuid
  for index = length, 1, -1 do
    attacker_uuid = self.v_abnormal_uuid_list[attr_id][index]
    attacker = SceneMgr:pick_by_uuid(attacker_uuid)
    if not Util.is_destroy(attacker) then
      use_attacker = attacker
      break
    else
      self.v_abnormal_uuid_list[attr_id][index] = nil
      self.v_abnormal_uuid_map[attr_id][attacker_uuid] = nil
    end
  end
  if use_attacker then
    local lv = use_attacker:get_level()
    local break_lv = use_attacker:get_break_level()
    abnormal_pure_essence = use_attacker:get_attr_value(ATTR_TYPE.ABNORMAL_PURE_ESSENCE)
    level_param = ShareRes.get_abnormal_level_param(break_lv, lv)
    self.v_abnromal_attacker_map[element_id] = use_attacker.uuid
  else
    Log.Error("元素异常获取攻击者失败", self.v_abnormal_uuid_list, debug.traceback())
  end
  return abnormal_pure_essence, use_attacker, level_param
end

function M:get_abnor_physics_attacker()
  local magic_rtid, magic, _, attacker
  local attacker_list = {}
  local count = 2
  for i = 1, #self.v_abnormal_effect_magic do
    magic_rtid = self.v_abnormal_effect_magic[i]
    magic = self.v_owner.magic_mgr:get_magic_by_rtid(magic_rtid)
    if magic and magic.element_id then
      attacker = magic.magic_info.attacker
      if not Util.is_destroy(attacker) then
        count = count - 1
        attacker_list[#attacker_list + 1] = attacker.uuid
      end
    end
    if count <= 0 then
      break
    end
  end
  if #attacker_list > 0 then
    local attacker_uuid
    table.sort(attacker_list, abnormal_attack_sort)
    attacker_uuid = attacker_list[#attacker_list]
    attacker = SceneMgr:pick_by_uuid(attacker_uuid)
  else
    local attacker_elemnt = self.v_abnor_magic_info.element_id
    attacker = self:get_abnormal_attack_param(attacker_elemnt)
  end
  attacker = attacker or self.v_abnor_magic_info.npc
  return attacker
end

function M:get_element_data(magic_rtid)
  local element_data = self.v_duration_damage_data[magic_rtid]
  if not element_data and self.v_additional_damage_data and self.v_additional_damage_data.magic_rtid == magic_rtid then
    element_data = self.v_additional_damage_data
  end
  return element_data
end

function M:get_element_duration_per(magic_rtid)
  local element_data = self:get_element_data(magic_rtid)
  if not element_data then
    return
  end
  local percent = element_data.duration / element_data.left_duration
  return percent
end

function M:add_element_abnormal_flag(element_id, magic_rtid)
  self.v_element_abnormal_flag_map[element_id] = self.v_element_abnormal_flag_map[element_id] or {}
  self.v_element_abnormal_flag_map[element_id][magic_rtid] = true
end

function M:remove_element_abnormal_flag(element_id, magic_rtid)
  if self.v_element_abnormal_flag_map[element_id] and self.v_element_abnormal_flag_map[element_id][magic_rtid] then
    self.v_element_abnormal_flag_map[element_id][magic_rtid] = nil
  end
  if not next(self.v_element_abnormal_flag_map[element_id]) then
    self.v_element_abnormal_flag_map[element_id] = nil
  end
end

function M:get_element_abnormal_flag_count(element_id)
  local flag_count = 0
  if self.v_element_abnormal_flag_map[element_id] then
    local magic
    for magic_rtid in pairs(self.v_element_abnormal_flag_map[element_id]) do
      magic = self.v_owner.magic_mgr:get_magic_by_rtid(magic_rtid)
      if magic then
        flag_count = flag_count + magic:get_count()
      end
    end
  end
  return Math.Clamp(flag_count, 0, self.v_flag_max_count_map[element_id] or 0)
end

local function _can_execute_owner(self, element_id, cal_func)
  local magic
  if self.v_element_magic_map[element_id] then
    for magic_rtid in pairs(self.v_element_magic_map[element_id]) do
      magic = self.v_owner.magic_mgr:get_magic_by_rtid(magic_rtid)
      if magic then
        local cur_hp = self.v_owner.attr_mgr:get_hp()
        if cur_hp <= -cal_func(self, magic) then
          self.v_owner.magic_mgr:remove_magic_by_rtid(magic.rtid)
          self:on_abnormal_clock_down_done(element_id)
        end
      else
        self.v_element_magic_map[element_id][magic_rtid] = nil
      end
    end
  end
end

function M:can_execute_owner()
  for element_id, cal_func in pairs(EXECUTE_CHEKC_FUNC) do
    if not self:check_before_abnormal_effect() then
      return
    end
    _can_execute_owner(self, element_id, cal_func)
  end
end

function M:check_hp_change_msg_handle_remove()
  local remove_handle = true
  for target_element, value in pairs(EXECUTE_CHEKC_FUNC) do
    if not UtilTable.is_empty(self.v_element_magic_map[target_element]) then
      remove_handle = false
    end
  end
  if remove_handle then
    self:mgr_unbind_auto_mq(self.v_hp_change_msg_handle)
    self.v_hp_change_msg_handle = nil
  end
end

function M:add_abnormal_magic_rtid(rtid)
  self.v_abnormal_effect_magic[#self.v_abnormal_effect_magic + 1] = rtid
end

function M:remove_abnormal_magic_rtid(rtid)
  local length = #self.v_abnormal_effect_magic
  local uuid, remain_length
  for i = 1, length do
    uuid = self.v_abnormal_effect_magic[i]
    if uuid == rtid then
      self.v_abnormal_effect_magic[i] = nil
      remain_length = length - 1
      if i <= remain_length then
        for j = i, remain_length do
          self.v_abnormal_effect_magic[j] = self.v_abnormal_effect_magic[j + 1]
        end
        self.v_abnormal_effect_magic[length] = nil
      end
      break
    end
  end
end

function M:get_display_abnormal_value(element_id)
  return self.v_abnormal_timer_map[element_id] and self.v_abnormal_flag_value_map[element_id] or self.v_abnormal_value_map[element_id]
end

function M:get_abnormal_value(element_id)
  return self.v_abnormal_value_map[element_id]
end

function M:get_abnormal_max_value(element_id)
  return self.v_abnormal_max_value_map[element_id]
end

function M:check_abnormal_on_timer(element_id)
  if element_id then
    return self.v_abnormal_timer_map[element_id]
  else
    return next(self.v_abnormal_timer_map)
  end
end

function M:publish_abnormal_event(event_id, element_id)
  local msg = MsgGame:mq_publish2(event_id)
  msg.mm_x = element_id
  msg.mm_obj = self.v_owner.uuid
end

function M:change_abnormal_value(attacker, element_id, change_value)
  local trigger = false
  if ELEMENT_TO_AB_ATTR[element_id] and attacker and (attacker:is_hero() or attacker:is_summons()) then
    self:add_abnormal_attr_uuid(ELEMENT_TO_AB_ATTR[element_id], attacker)
  end
  if self.v_abnormal_timer_map[element_id] then
    self:change_abnormal_flag_value(element_id, change_value)
    if self.v_trigger_value_change_event then
      self:publish_abnormal_event(Const.MSG_NPC_ELEMENT_VALUE_CHANGE, element_id)
      self.v_trigger_value_change_event = nil
    end
    return trigger
  end
  local current_value = self.v_abnormal_value_map[element_id]
  local max_value = self.v_abnormal_max_value_map[element_id]
  local new_value = current_value + change_value
  self.v_abnormal_value_map[element_id] = math.min(math.max(new_value, 0), max_value)
  if self.v_abnormal_value_map[element_id] ~= current_value or 0 ~= change_value and 0 == self.v_abnormal_value_map[element_id] then
    self.v_trigger_value_change_event = true
    if self.v_abnormal_value_map[element_id] <= 0 then
      local change_flag_value
      local abnormal_status = self.v_owner.attr_mgr:get_abnormal_status(ELEMENT_TO_AB_ATTR[element_id])
      if abnormal_status == ABNORMAL_STATUS.OPEN then
        trigger = true
        self:on_abnormal_trigger(element_id)
        if element_id ~= ELEMENT_TYPE.BASE and self:get_timer_count() >= Config.ACTIVATE_PHYSICS_COUNT then
          self:on_abnormal_trigger(ELEMENT_TYPE.BASE)
        end
        self:publish_abnormal_event(Const.MSG_ON_ELEMENT_TIMER_START, element_id)
        change_flag_value = new_value
      elseif abnormal_status == ABNORMAL_STATUS.IMMUNITY then
        change_flag_value = new_value + self.v_abnormal_value_map[element_id] - max_value
        self.v_abnormal_value_map[element_id] = max_value
      else
        change_flag_value = new_value
      end
      if change_flag_value < 0 then
        self:change_abnormal_flag_value(element_id, change_flag_value)
      end
    end
  end
  if self.v_trigger_value_change_event then
    self:publish_abnormal_event(Const.MSG_NPC_ELEMENT_VALUE_CHANGE, element_id)
    self.v_trigger_value_change_event = nil
  end
  return trigger
end

function M:change_abnormal_flag_value(element_id, change_value)
  if 0 == change_value then
    return
  end
  local current_value = self.v_abnormal_flag_value_map[element_id]
  local new_value
  local max_value = self.v_abnormal_max_value_map[element_id]
  local is_dec = change_value < 0
  if is_dec then
    change_value = change_value + current_value
    if change_value <= 0 then
      local count = 1
      local abs_change_value = math.abs(change_value)
      local extra_count = math.floor(abs_change_value / max_value)
      local total_count = count + extra_count
      self.v_add_abnormal_flag_map[element_id] = (self.v_add_abnormal_flag_map[element_id] or 0) + total_count
      self.v_add_abnormal_magic_count = self.v_add_abnormal_magic_count + 1
      new_value = max_value - abs_change_value + extra_count * max_value
    else
      new_value = change_value
    end
  else
    new_value = current_value + change_value
  end
  if new_value ~= current_value then
    self.v_trigger_value_change_event = true
  end
  self.v_abnormal_flag_value_map[element_id] = math.min(math.max(new_value, 0), max_value)
end

function M:change_abnormal_flag_count(element_id, change_count)
  if 0 == change_count then
    return
  end
  local cur_count = self:get_element_abnormal_flag_count(element_id)
  local max_count = self.v_flag_max_count_map[element_id]
  local dif_value = max_count - cur_count
  if dif_value <= 0 and change_count > 0 then
    return
  end
  local flag_magic_id = ELEMENT_ABNIRMAL_FLAG_MAGIC[element_id]
  if change_count < 0 then
    change_count = -self.v_owner.magic_mgr:remove_abnormal_flag_magic(element_id, -change_count)
  end
  local first_magic = self.v_owner.magic_mgr:get_magic_by_id(flag_magic_id)
  if first_magic then
    change_count = change_count + first_magic:get_count()
  end
  local magic_level = math.min(max_count, change_count)
  if magic_level <= 0 then
    return
  end
  self.v_owner.magic_mgr:add_magic(self.v_owner, flag_magic_id, nil, nil, magic_level)
end

function M:on_abnormal_trigger(element_id)
  self.v_add_abnormal_magic_map[#self.v_add_abnormal_magic_map + 1] = element_id
  self.v_add_abnormal_magic_count = self.v_add_abnormal_magic_count + 1
  if element_id ~= ELEMENT_TYPE.BASE then
    local time_attr_id = FightDefine.AB_ATTR_TO_TIME[element_id]
    local cd_time = self.v_owner:get_attr_value(time_attr_id)
    self.v_abnormal_timer_map[element_id] = cd_time
  end
end

function M:update_add_abnormal_magic()
  if self.v_add_abnormal_magic_count <= 0 then
    return
  end
  for i = 1, #self.v_add_abnormal_magic_map do
    local element_id = self.v_add_abnormal_magic_map[i]
    if element_id == ELEMENT_TYPE.BASE then
      self:add_abnor_physics_magic()
    else
      self:add_abnor_magic(element_id)
    end
    self.v_add_abnormal_magic_map[i] = nil
  end
  for element_id, change_count in pairs(self.v_add_abnormal_flag_map) do
    self:change_abnormal_flag_count(element_id, change_count)
    self.v_add_abnormal_flag_map[element_id] = nil
  end
  self.v_add_abnormal_magic_count = 0
end

function M:update_abnormal_timer()
  local element_list
  for element_id, timer in pairs(self.v_abnormal_timer_map) do
    self.v_abnormal_timer_map[element_id] = timer - Global.low_delta_time
    if self.v_abnormal_timer_map[element_id] <= 0 then
      if not element_list then
        element_list = {element_id}
      else
        element_list[#element_list + 1] = element_id
      end
      self:on_abnormal_clock_down_done(element_id)
    end
  end
  if element_list then
    SceneMgr:c2gs_call_scene("call_attr_timer_funcs", self.v_owner.uuid, element_list)
  end
end

function M:on_abnormal_clock_down_done(element_id)
  self:reset_abnormal_state(element_id)
end

function M:get_timer_count()
  local count = 0
  for element_id in pairs(self.v_abnormal_timer_map) do
    if element_id ~= ELEMENT_TYPE.BASE then
      count = count + 1
    end
  end
  return count
end

function M:set_element_value(attacker, element_id, value, value_type, change_type)
  local cur_value = self.v_abnormal_value_map[element_id]
  local max_value = self.v_abnormal_max_value_map[element_id]
  local change_value
  if value_type == VALUE_TYPE.CURRENT_VALUE_RATIO then
    change_value = cur_value * value / (Config.RATIO_TO_NUM or 10000)
  elseif value_type == VALUE_TYPE.MAX_VALUE_RATIO then
    change_value = max_value * value / (Config.RATIO_TO_NUM or 10000)
  elseif value_type == VALUE_TYPE.FIXED_VALUE then
    change_value = value
  end
  if change_type == Config.ATTR_SET_TYPE.REPLACE then
    change_value = change_value - cur_value
  end
  self:change_abnormal_value(attacker, element_id, change_value)
end

function M:reset_abnormal_state(element_id)
  self:reset_abnromal_value(element_id)
  self:clear_abnormal_timer(element_id)
end

function M:reset_abnromal_value(element_id, reset_flag)
  local max_value = self.v_abnormal_max_value_map[element_id]
  local flag_cur_value = self.v_abnormal_flag_value_map[element_id]
  self.v_abnormal_value_map[element_id] = reset_flag and max_value or flag_cur_value
  self.v_abnormal_flag_value_map[element_id] = max_value
  self:publish_abnormal_event(Const.MSG_NPC_ELEMENT_VALUE_CHANGE, element_id)
end

function M:clear_abnormal_timer(element_id)
  if self.v_abnormal_timer_map[element_id] then
    self.v_abnormal_timer_map[element_id] = nil
    self:clear_abnormal_magic(element_id)
    local attacker_uuid = self.v_abnromal_attacker_map[element_id]
    self.v_abnromal_attacker_map[element_id] = nil
    local attacker = attacker_uuid and SceneMgr:pick_by_uuid(attacker_uuid)
    BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.ON_ELEMENT_ABORN_END, self.v_owner, element_id, attacker)
    BehaviorMgr:call_behavior_fun(self.v_owner, "on_target_self_element_aborn_end", attacker, element_id)
    BehaviorMgr:call_behavior_fun(attacker, "on_self_element_aborn_end", self.v_owner, element_id)
    self:publish_abnormal_event(Const.MSG_ON_ELEMENT_TIMER_REMOVE, element_id)
    local attr_id = ELEMENT_TO_AB_ATTR[element_id]
    UtilTable.clear_map(self.v_abnormal_uuid_map[attr_id])
    UtilTable.clear_list(self.v_abnormal_uuid_list[attr_id])
    self.v_abnormal_uuid_map[attr_id] = self.v_abnor_trigger_uuid_map[attr_id]
    self.v_abnormal_uuid_list[attr_id] = self.v_abnor_trigger_uuid_list[attr_id]
  end
end

function M:clear_abnormal_magic(element_id)
  if self.v_element_magic_map[element_id] then
    for rtid in pairs(self.v_element_magic_map[element_id]) do
      self.v_owner.magic_mgr:remove_magic_by_rtid(rtid)
      self.v_element_magic_map[element_id][rtid] = nil
    end
  end
end

function M:add_element_delay_effect(element_id, bind_type)
  local element_cfg = ShareRes.get_element_cfg(element_id)
  if element_cfg and element_cfg.DelayEffect and #element_cfg.DelayEffect >= 2 then
    local effect_param = element_cfg.DelayEffect
    local delay = tonumber(effect_param[2])
    if not delay then
      Log.Error("角色元素表配置DelayEffect的参数2不为数字，Id:", element_id, "需检查配置", debug.traceback())
      return
    end
    local effect_data = self.v_element_delay_effect[element_id]
    if not effect_data then
      effect_data = {}
      self.v_element_delay_effect[element_id] = effect_data
    end
    effect_data.attach_point = element_cfg.DelayEffectJoint
    effect_data.prefab_name = effect_param[1]
    effect_data.delay = delay
    effect_data.effect_bind_type = bind_type
  end
end

function M:update_element_delay_effect()
  for element_id, effect_data in pairs(self.v_element_delay_effect) do
    effect_data.delay = effect_data.delay - Global.low_delta_time
    if effect_data.delay <= 0 then
      local param = self.v_owner.act_effect_ctrl.create_effect_param()
      param.attach_point = effect_data.attach_point
      param.prefab_name = effect_data.prefab_name
      param.effect_bind_type = effect_data.effect_bind_type
      param.not_time_scale = true
      self.v_owner.act_effect_ctrl:play_attach_effect(param, self.v_owner)
      self.v_element_delay_effect[element_id] = nil
    end
  end
end

function M:clear_element_delay_effect(element_id)
  if element_id then
    self.v_element_delay_effect[element_id] = nil
  else
    UtilTable.clear_map(self.v_element_delay_effect)
  end
end

function M:check_before_abnormal_effect()
  if Util.is_destroy(self.v_owner) then
    return false
  end
  if self.v_owner:is_die() or self.v_owner:is_after_behitfly_die() then
    return false
  end
  return true
end

function M:init_abnormal_data()
  self.v_abnormal_value_map = {}
  self.v_abnormal_flag_value_map = {}
  self.v_abnormal_max_value_map = {}
  self.v_add_abnormal_magic_map = {}
  self.v_add_abnormal_flag_map = {}
  self.v_abnormal_timer_map = {}
  self.v_add_abnormal_magic_count = 0
  local attr_id
  for _, element_id in pairs(ELEMENT_TYPE) do
    attr_id = ELEMENT_TO_AB_ATTR[element_id]
    self.v_abnormal_value_map[element_id] = self.v_owner:get_attr_value(attr_id)
    self.v_abnormal_flag_value_map[element_id] = self.v_owner:get_attr_value(attr_id)
    self.v_abnormal_max_value_map[element_id] = self.v_owner.attr_mgr:get_attr_max(attr_id)
  end
end

function M:stop_all()
  self.v_duration_damage_data = {}
  self.v_additional_damage_data = nil
  self.v_first_trigger_dark_magic_rtid = nil
  self.v_add_abnormal_magic_map = {}
  self.v_add_abnormal_flag_map = {}
  self.v_add_abnormal_magic_count = 0
  if self.v_effect_timer then
    Timer:remove_timer(self.v_effect_timer)
    self.v_effect_timer = nil
  end
  if self.v_hp_change_msg_handle then
    self:mgr_unbind_auto_mq(self.v_hp_change_msg_handle)
    self.v_hp_change_msg_handle = nil
  end
  self:clear_element_delay_effect()
end

function M:reset_data()
  self.v_effect_id_map = {}
  self.v_element_magic_map = {}
  self.v_abnormal_uuid_map = {}
  self.v_abnormal_uuid_list = {}
  self.v_abnor_trigger_uuid_map = {}
  self.v_abnor_trigger_uuid_list = {}
  self.v_abnormal_count = {}
  self.v_abnromal_attacker_map = {}
  local attr_id
  for key, element_id in pairs(ELEMENT_TYPE) do
    self.v_effect_id_map[element_id] = {}
    self.v_element_magic_map[element_id] = {}
    attr_id = ELEMENT_TO_AB_ATTR[element_id]
    self.v_abnormal_uuid_map[attr_id] = {}
    self.v_abnormal_uuid_list[attr_id] = {}
    self.v_abnor_trigger_uuid_map[attr_id] = {}
    self.v_abnor_trigger_uuid_list[attr_id] = {}
    self.v_abnormal_count[element_id] = 0
  end
end

function M:on_role_dead()
  self.v_add_abnormal_magic_map = {}
  self.v_add_abnormal_flag_map = {}
  self.v_abnormal_timer_map = {}
  self.v_add_abnormal_magic_count = 0
end

function M:on_before_destroy()
  self:stop_all()
  self:reset_data()
  self.v_owner = nil
  self.v_effect_cfg = nil
end

return M
