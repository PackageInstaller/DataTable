local CommonDef = require("cs_share.common_define")
local ATTR_GROUP_TYPE = Config.ATTR_GROUP_TYPE
local FightCalc = require("cs_share.fight_calc")
local FightDefine = require("cs_share.fight_define")
local BloodHelper = require("uimodule/fight/blood_helper")
local BLOOD_TYPE = BloodHelper.BLOOD_TYPE
local ATTR_TYPE = FightDefine.ATTR_TYPE
local MagicDef = require("cs_share.magic_def")
local MAGIC_TYPE = MagicDef.MAGIC_TYPE
local SET_TYPE = Config.ATTR_SET_TYPE
local RATIO_TYPE = Config.RATIO_TYPE
local ENERGY_TYPE = Config.ENERGY_TYPE
local LuaObjPoolMgr = require("manager.res.lua_obj_pool_mgr")
local VALUE_TYPE = {
  FIXED = 1,
  MAX_RATIO = 2,
  RATIO = 3
}
local CALCULATION_TYPE = {FIXED_VAL = 1, PROPORTION = 2}
local EffectWorldType = {TIME_SCALE = 1, NOT_TIME_SCALE = 2}
local HEAL_SET_TYPE = {NORMAL = 0, SET = 1}
local EnergySuffix = {
  recovery_fixed_suffix = "_RECOVERY_FIXED",
  recovery_ratio_suffix = "_RECOVERY_RATIO",
  consume_fixed_suffix = "_CONSUME_FIXED",
  consume_ratio_suffix = "_CONSUME_RATIO"
}
local TIME_SCELE_TYPE = MagicDef.TIME_SCELE_TYPE
local _max = math.max
local M = {}
local magic_fun = {}
M.fun = magic_fun

function M.on_magic_fun(magic_target, fun, magic_info, report)
  local effect_cfg = magic_info.effect_cfg
  if effect_cfg then
    local effect = effect_cfg.Effect
    local bone = effect_cfg.EffectJoint
    local effect_world = effect_cfg.EffectWorld
    local is_world = effect_world == MagicDef.EFFECT_BIND_TYPE.ONLY_ROTATION or effect_world == MagicDef.EFFECT_BIND_TYPE.SCENE_MAGIC
    local is_timescale = magic_info.logic_cfg and magic_info.logic_cfg.IsTimeScale or TIME_SCELE_TYPE.NONE
    local effect_scale = effect_cfg.EffectScale
    local effect_time_scale = effect_cfg.EffectTimeScale
    local not_time_scale
    if is_timescale == TIME_SCELE_TYPE.NONE or is_timescale == TIME_SCELE_TYPE.EXCEPT_EFFECT or is_timescale == TIME_SCELE_TYPE.UNSCALE then
      not_time_scale = true
    end
    local effect_data = magic_target.act_effect_ctrl.create_effect_param()
    effect_data.prefab_name = effect
    effect_data.attach_point = bone
    effect_data.scale = effect_scale
    effect_data.time_scale = effect_time_scale
    effect_data.effect_bind_type = effect_world
    effect_data.is_world = is_world
    effect_data.not_time_scale = not_time_scale
    effect_data.is_weapon_attach = effect_cfg.IsWeaponAttach
    magic_target.act_effect_ctrl:play_attach_effect(effect_data, magic_target)
  end
  local magic_fun = M.fun[fun]
  magic_fun(magic_target, magic_info.logic_cfg, magic_info, report)
  M.release_magic_param(magic_info)
end

function M.release_magic_param(magic_info)
  local pool = LuaObjPoolMgr.get_pool("magic_param_pool")
  if pool then
    pool:destroy_obj(magic_info)
  end
end

local HURT_TYPE = {
  BASE_HURT_START_IDX = 0,
  BASE_HURT_END_IDX = 1,
  ABNORMAL_HURT_START_IDX = 2,
  ABNORMAL_HURT_END_IDX = 6
}
local RATIO_IN = 1.0E-4
local _mmin = math.min
local _mceil = math.ceil
local _mmax = math.max

local function correction_magic_val(base_val, magic_type, magic_target)
  local cost_magic_val = 0
  if magic_target:is_hero() then
    base_val = -base_val
    local god_npc = SceneMgr:get_god_npc()
    if not god_npc then
      return -base_val, cost_magic_val
    end
    local overall_shield_id_list, overall_shield_id_map = god_npc:get_overall_shield()
    local index = #overall_shield_id_list
    local remove_magic_list = {}
    while true do
      local magic_id = overall_shield_id_list[index]
      if not magic_id then
        break
      end
      local magic_shield = overall_shield_id_map[magic_id]
      local shield_value = magic_shield.shield_value
      if base_val >= shield_value then
        base_val = base_val - shield_value
        cost_magic_val = cost_magic_val + shield_value
        remove_magic_list[#remove_magic_list + 1] = {
          magic_id = magic_shield.magic_id,
          uuid = magic_shield.uuid
        }
        index = index - 1
      else
        magic_shield.shield_value = shield_value - base_val
        cost_magic_val = cost_magic_val + base_val
        base_val = 0
        break
      end
    end
    if #remove_magic_list > 0 then
      local owner
      local is_building = MagicReporter:is_building_report()
      MagicReporter:push_action_start(is_building, CommonDef.MAGIC_ACTION_TYPE.remove_magic_on_effect)
      for index, data in ipairs(remove_magic_list) do
        owner = SceneMgr:get_hero_by_uuid(data.uuid)
        owner.magic_mgr:remove_magic_by_id(data.magic_id)
      end
      MagicReporter:push_action_end(is_building, CommonDef.MAGIC_ACTION_TYPE.remove_magic_on_effect)
    end
  else
    local magic_map = magic_target.magic_mgr:get_magics_by_type(magic_type)
    if not magic_map then
      return base_val, 0
    end
    base_val = -base_val
    for _, temp_blue_magic in pairs(magic_map) do
      if base_val > 0 then
        local temp
        base_val, temp = temp_blue_magic:correct_magic_val(base_val)
        cost_magic_val = cost_magic_val + temp
      end
    end
    cost_magic_val = math.floor(cost_magic_val)
  end
  if 0 ~= cost_magic_val then
    local msg = MsgGame:mq_publish2(Const.MSG_ON_ROLE_SHIELD_CHANGE)
    msg.mm_x = magic_target:is_hero()
    msg.mm_obj = magic_target.uuid
  end
  return -base_val, cost_magic_val
end

local function _damage_sharing(magic_target, total_hurt, attacker, magic_info)
  local magic_list = magic_target.magic_mgr:get_magics_by_type(MAGIC_TYPE.DamageSharing)
  if not magic_list or not next(magic_list) then
    return total_hurt
  end
  local other_hero_list = SceneMgr:get_hero_list_except(magic_target.uuid)
  local nOtherNum = #other_hero_list
  if nOtherNum > 0 then
    local sharing_standard_hurt = _mceil(total_hurt / (nOtherNum + 1))
    for _, hero in pairs(other_hero_list) do
      local hp = hero.attr_mgr:get_hp()
      if hp > 1 then
        local hero_sharing_standard_hurt = _mmax(sharing_standard_hurt, -(hp - 1))
        total_hurt = total_hurt - hero_sharing_standard_hurt
        hero.attr_mgr:change_attr(ATTR_GROUP_TYPE.BASE, ATTR_TYPE.CHAR_HP, hero_sharing_standard_hurt, attacker, magic_info.magic_id, magic_info.owner_missile)
      end
    end
  end
  return total_hurt
end

local function get_kill_dmg_correction(magic_mgr)
  local kill_dmg_correction = 0
  local magic_map = magic_mgr:get_magics_by_type(MAGIC_TYPE.KILL_LEVEL)
  if not magic_map then
    return 0
  end
  for _, magic in pairs(magic_map) do
    kill_dmg_correction = kill_dmg_correction + magic:get_magic_val()
  end
  return kill_dmg_correction * RATIO_IN
end

function magic_fun.on_grab(magic_target, logic_cfg, magic_info, report)
  local attacker = magic_info.attacker
  local attach_point = logic_cfg[1]
  local is_weapon = 0 ~= logic_cfg[2]
  MagicReporter:push_action_start(report, CommonDef.MAGIC_ACTION_TYPE.magic_event_something)
  attacker:grab_obj(attach_point, magic_target, is_weapon)
  MagicReporter:push_action_end(report, CommonDef.MAGIC_ACTION_TYPE.magic_event_something)
end

function magic_fun.on_throw(magic_target, logic_cfg, magic_info, report)
  local attacker = magic_info.attacker
  local attach_point, speed_factor, fly_time = logic_cfg[1], logic_cfg[2], logic_cfg[3]
  MagicReporter:push_action_start(report, CommonDef.MAGIC_ACTION_TYPE.magic_event_something)
  attacker:throw_obj(attach_point, speed_factor, fly_time)
  MagicReporter:push_action_end(report, CommonDef.MAGIC_ACTION_TYPE.magic_event_something)
end

function magic_fun.on_skill_energy(magic_target, logic_cfg)
  local skill_mgr = magic_target.skill_mgr
  local skill_id = logic_cfg[1]
  if not skill_id or 0 == skill_id then
    skill_id = skill_mgr:get_change_effect_energy_id()
  end
  local skill = skill_mgr:get_skill(skill_id)
  if not skill then
    return
  end
  local energy_info = skill:get_skill_energy_info()
  if not energy_info then
    return
  end
  local value = logic_cfg[2]
  local value_type = logic_cfg[3]
  local set_type = logic_cfg[4]
  local energy_type = logic_cfg[5]
  if value_type == VALUE_TYPE.FIXED then
  elseif value_type == VALUE_TYPE.RATIO then
    value = energy_info.cur_energy * value / 10000
  elseif value_type == VALUE_TYPE.MAX_RATIO then
    value = energy_info.max_energy * value / 10000
  end
  local is_max_energy = energy_type == ENERGY_TYPE.MAX_ENERGY
  if set_type == SET_TYPE.CHANGE_BY_DELTA then
    skill:on_change_skill_energy(value, is_max_energy)
  else
    skill:on_set_skill_energy(value, is_max_energy)
  end
end

function magic_fun.on_ui_object_visble(magic_target, logic_cfg)
  local list = Util.split_str(logic_cfg[1], "/")
  local ui_name = list[1]
  local object_name = list[2]
  local is_show = 1 == logic_cfg[2]
  local ui = UIMgr:get_ui(ui_name)
  if ui then
    local object = ui:get_uiobject(object_name)
    if object then
      object:SetActive(is_show)
    end
  end
end

local HURT_CTX = {}

local function _clear_hurt_ctx()
  for k, _ in pairs(HURT_CTX) do
    HURT_CTX[k] = nil
  end
end

local function get_factor_by_magiclevel(level_cfg, magic_level)
  if not level_cfg then
    return 0
  end
  if type(level_cfg) ~= "table" then
    return level_cfg
  end
  local factor = level_cfg[magic_level]
  return factor and factor or level_cfg[#level_cfg]
end

local function _get_random_ctx(attacker, magic_info)
  local scene_logic = SceneMgr:get_scene_logic()
  local random_ctx = Global.last_room_random_ctx
  if scene_logic then
    random_ctx = scene_logic:get_random_ctx()
  end
  local random_seed_check = random_ctx.random_seed
  if random_ctx.random_seed ~= random_seed_check then
    Global.log.Debug(string.format("random seed had changed in function on_hurt_damage : magic_id = %d", magic_info.magic_id))
  end
  return random_ctx
end

local function _correction_damage_by_lock_hp(is_lock_hp, def_attr_mgr, total_hurt)
  if not is_lock_hp then
    return total_hurt
  end
  local cur_hp = def_attr_mgr:get_attr(ATTR_TYPE.CHAR_HP)
  local after_hp = cur_hp + total_hurt
  if after_hp <= 0 then
    return math.min(-cur_hp + 1, 0)
  end
  return total_hurt
end

local function _processing_dmg(base_hurt, element_hurt, base_sp_armor_hurt, element_sp_armor_hurt)
  local attacker = HURT_CTX.attacker
  local magic_target = HURT_CTX.magic_target
  local report = HURT_CTX.report
  local magic_info = HURT_CTX.magic_info
  local skill_type = HURT_CTX.skill_type
  local element_type = HURT_CTX.element_type
  local is_crit = HURT_CTX.is_crit
  local part_info = HURT_CTX.part_info
  local special = HURT_CTX.special
  local not_play_hurt_dmg = HURT_CTX.not_play_hurt_dmg
  local atk_attr_mgr = magic_info.attacker_attr_mgr
  local def_attr_mgr = magic_target.attr_mgr
  local attr_group_type = ATTR_GROUP_TYPE.BASE
  local damage_fix_value = magic_info.attacker_magic_mgr:on_trigger_effect(MAGIC_TYPE.DamageCorrect, magic_info, skill_type, element_type) or 0
  local sp_armor_fix_value = magic_info.attacker_magic_mgr:on_trigger_effect(MAGIC_TYPE.SparmorCorrect, magic_info) or 0
  base_hurt = base_hurt * (1 + damage_fix_value) * -1
  element_hurt = element_hurt * (1 + damage_fix_value) * -1
  local sp_armor_hurt = (base_sp_armor_hurt + element_sp_armor_hurt) * (1 + sp_armor_fix_value) * -1
  local total_hurt = 0
  local is_part_hurt = nil ~= part_info
  local deg = Util.get_target_relative_to_attacker_deg(magic_target, attacker, magic_info)
  local shield = magic_target:get_shield_num()
  if is_part_hurt then
    local hurt = base_hurt + element_hurt
    local part_hp = magic_target:change_part_attr(part_info.part_id, ATTR_TYPE.CHAR_HP, hurt)
    MagicReporter:push_action_start(report, CommonDef.MAGIC_ACTION_TYPE.on_part_damage)
    BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.ON_PART_DAMAGE, attacker, magic_target, part_info.part_id, part_hp, is_crit, hurt, magic_info.magic_id)
    MagicReporter:push_action_end(report, CommonDef.MAGIC_ACTION_TYPE.on_part_damage)
    total_hurt = math.floor(hurt * part_info.fix_dmg)
    sp_armor_hurt = 0
  else
    local base_block = 0
    local element_block = 0
    base_hurt, base_block = correction_magic_val(base_hurt, MAGIC_TYPE.HpShield, magic_target)
    element_hurt, element_block = correction_magic_val(element_hurt, MAGIC_TYPE.HpShield, magic_target)
    local sum_block = base_block + element_block
    if 0 ~= sum_block then
      BloodHelper.play_shiled_block(magic_target, sum_block, nil, deg)
    end
    total_hurt = base_hurt + element_hurt
  end
  local attach_point = is_part_hurt and part_info.attach_point
  attach_point = attach_point or magic_info.attach_point
  if not not_play_hurt_dmg then
    BloodHelper.play_hurt_dmg(magic_target, 0, -total_hurt, element_type, is_crit, attach_point, HURT_CTX.suc_immune, deg)
  end
  total_hurt = _damage_sharing(magic_target, total_hurt, attacker, magic_info)
  if HURT_CTX.replace_last_hurt then
    attacker._LAST_HURT = -total_hurt
    magic_target._LAST_BE_HURT = -total_hurt
  end
  total_hurt = _correction_damage_by_lock_hp(HURT_CTX.is_lock_hp, def_attr_mgr, total_hurt)
  magic_target:set_last_hurt_info(attacker, total_hurt)
  local before_hp = def_attr_mgr:get_attr(ATTR_TYPE.CHAR_HP)
  def_attr_mgr:change_attr(attr_group_type, ATTR_TYPE.CHAR_HP, total_hurt, attacker, magic_info.magic_id, magic_info.owner_missile)
  if FightDataMgr:is_record_damage_trigger_open() and attacker:is_hero() then
    local owner_skill = magic_info.owner_skill
    if not owner_skill then
      local owner_skill_id = magic_info.owner_skill_id
      owner_skill = attacker.skill_mgr:get_skill(owner_skill_id)
    end
    local owner_skill_type = owner_skill and owner_skill:get_skill_type()
    if owner_skill_type == Config.SKILL_ATTACK_TYPE.APPEAR then
      local after_hp = def_attr_mgr:get_attr(ATTR_TYPE.CHAR_HP)
      FightDataMgr:record_skill_link_damage(attacker.uuid, before_hp - after_hp)
    end
  end
  if JournalMgr then
    local magic_level = HURT_CTX.magic_level
    local base_hurt_src = HURT_CTX.base_hurt_src
    local element_hurt_src = HURT_CTX.element_hurt_src
    local base_hurt_factor = HURT_CTX.base_hurt_factor
    local element_hurt_factor = HURT_CTX.element_hurt_factor
    local crit_fix_value = HURT_CTX.crit_fix_value
    local atk_attrs = HURT_CTX.atk_attrs
    local def_attrs = HURT_CTX.def_attrs
    local kill_level_fix = HURT_CTX.kill_level_fix
    local pre_caculate_data = {
      magic_level = magic_level,
      skill_type = skill_type,
      element_type = element_type,
      base_hurt_src = base_hurt_src,
      base_hurt_factor = base_hurt_factor,
      element_hurt_src = element_hurt_src,
      element_hurt_factor = element_hurt_factor,
      damage_fix_value = damage_fix_value,
      kill_level_fix = kill_level_fix,
      skill_type = skill_type,
      special = special
    }
    local crit_info = {is_crit = is_crit, crit_fix_value = crit_fix_value}
    local hurts = {base_hurt = base_hurt, element_hurt = element_hurt}
    JournalMgr:insert_hurt_journal(atk_attr_mgr, atk_attrs, def_attr_mgr, def_attrs, pre_caculate_data, hurts, crit_info, magic_info)
  end
  _clear_hurt_ctx()
  MagicReporter:push_action_start(report, CommonDef.MAGIC_ACTION_TYPE.after_damage)
  local owner_missile = magic_info.owner_missile
  local owner_skill_id = magic_info.owner_skill_id
  BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.AFTER_DAMAGE, attacker, magic_target, magic_info.magic_id, skill_type, element_type, is_crit, total_hurt, base_hurt, element_hurt, owner_skill_id, owner_missile)
  BehaviorMgr:call_behavior_fun(attacker, "after_damage_target", magic_target, magic_info.magic_id, skill_type, element_type, is_crit, total_hurt, base_hurt, element_hurt, owner_skill_id, owner_missile)
  BehaviorMgr:call_behavior_fun(magic_target, "after_damage_self", attacker, magic_info.magic_id, skill_type, element_type, is_crit, total_hurt, base_hurt, element_hurt, owner_skill_id, owner_missile)
  magic_target:check_additional_damage()
  MagicReporter:push_action_end(report, CommonDef.MAGIC_ACTION_TYPE.after_damage)
  magic_target:trigger_hurt(attacker)
  if TowerMgr then
    TowerMgr:add_hurt_record_val(magic_target, attacker, total_hurt)
  end
end

local function _cal_crit(attacker, magic_target, logic_cfg, magic_info, report)
  local random_ctx = _get_random_ctx(attacker, magic_info)
  local crit_cfg = logic_cfg[9]
  if crit_cfg and #crit_cfg <= 1 and 1 == crit_cfg[1] then
    return false, 0
  end
  local atk_attr_mgr = magic_info.attacker_attr_mgr
  local def_attr_mgr = magic_target.attr_mgr
  local is_crit = FightCalc.get_crit_vaild(atk_attr_mgr.attrs, def_attr_mgr.attrs, random_ctx, crit_cfg)
  if is_crit then
    local fix_crit_value, fix_type, calculation_type = magic_info.attacker_magic_mgr:on_trigger_effect(MAGIC_TYPE.CritCorret)
    MagicReporter:push_action_start(report, CommonDef.MAGIC_ACTION_TYPE.on_critical)
    BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.ON_CRITICAL, attacker, magic_target, logic_cfg, magic_info.magic_id)
    MagicReporter:push_action_end(report, CommonDef.MAGIC_ACTION_TYPE.on_critical)
    return is_crit, FightCalc.get_crit_fix_value(atk_attr_mgr.attrs, def_attr_mgr.attrs, random_ctx, fix_crit_value, fix_type, calculation_type, is_crit, crit_cfg)
  else
    return is_crit, 0
  end
end

function magic_fun.on_hurt_damage(magic_target, logic_cfg, magic_info, report)
  local skill_type = logic_cfg[1]
  if not skill_type or not FightDefine.DMG_VALUE_TO_TYPE[skill_type] then
    Log.Error("伤害Magic：", magic_info.magic_id, "所配参数1异常，值为:", skill_type)
    return
  end
  local attacker = magic_info.attacker
  local magic_level = magic_info.magic_level
  local atk_attr_mgr = magic_info.attacker_attr_mgr
  local atk_magic_mgr = magic_info.attacker_magic_mgr
  local def_attr_mgr = magic_target.attr_mgr
  if not atk_attr_mgr then
    Log.Error("magic no magic_info.attacker_attr_mgr", magic_info.magic_id, debug.traceback())
    return
  end
  if not atk_magic_mgr then
    Log.Error("magic no magic_info.attacker_magic_mgr", magic_info.magic_id, debug.traceback())
    return
  end
  if not def_attr_mgr then
    Log.Error("magic no magic_target.attr_mgr", magic_info.magic_id, debug.traceback())
    return
  end
  local element_type = logic_cfg[2]
  if 1 == element_type then
    element_type = 0
  end
  local hurt_factor = get_factor_by_magiclevel(logic_cfg[3], magic_level) or 0
  local hurt_source = logic_cfg[4]
  hurt_source = 0 == hurt_source and ATTR_TYPE.CHAR_ATTACK or hurt_source
  magic_target:set_before_hurt_info(attacker, magic_info.owner_skill_id)
  local abnormal_id = FightDefine.ELEMENT_TO_AB_ATTR[element_type]
  if abnormal_id then
    local abnormal_hurt_factor = get_factor_by_magiclevel(logic_cfg[7], magic_level) or 0
    magic_fun._do_abnor_damage(magic_target, magic_info, skill_type, element_type, abnormal_hurt_factor)
  end
  local is_lock_hp = 1 == logic_cfg[5]
  local part_id = magic_info.part_id
  local part_info = part_id and magic_target:get_part_info_by_id(part_id)
  local is_part_hurt = part_id and part_info
  local atk_attrs = atk_attr_mgr.attrs
  local def_attrs = is_part_hurt and part_info.attrs or def_attr_mgr.attrs
  MagicReporter:push_action_start(report, CommonDef.MAGIC_ACTION_TYPE.before_damage)
  local camp, change_lv
  if magic_target:is_monster() and def_attrs[ATTR_TYPE.CHAR_HP_SHIELD] <= 0 then
    local hurt_tough_value = logic_cfg[6]
    if hurt_tough_value and hurt_tough_value > 0 then
      hurt_tough_value = FightCalc.CalcHurtTough(hurt_tough_value, atk_attrs, def_attrs)
      camp, change_lv = magic_target:change_tough_value(hurt_tough_value)
    end
  end
  local owner_missile = magic_info.owner_missile
  local owner_skill_id = magic_info.owner_skill_id
  BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.BEFORE_DAMAGE, attacker, magic_target, magic_info.magic_id, skill_type, element_type, camp, change_lv, magic_level, owner_skill_id, owner_missile)
  BehaviorMgr:call_behavior_fun(attacker, "before_damage_target", magic_target, magic_info.magic_id, skill_type, element_type, camp, change_lv, magic_level, owner_skill_id, owner_missile)
  BehaviorMgr:call_behavior_fun(magic_target, "before_damage_self", attacker, magic_info.magic_id, skill_type, element_type, camp, change_lv, magic_level, owner_skill_id, owner_missile)
  MagicReporter:push_action_end(report, CommonDef.MAGIC_ACTION_TYPE.before_damage)
  local is_crit, crit_fix_value = _cal_crit(attacker, magic_target, logic_cfg, magic_info, report)
  local kill_level_fix = get_kill_dmg_correction(magic_info.attacker_magic_mgr)
  local base_hurt, base_sp_armor_hurt = 0, 0
  local element_hurt, element_sp_armor_hurt = 0, 0
  local ctx_base_hurt_src, ctx_element_hurt_src, ctx_base_hurt_factor, ctx_element_hurt_factor, record_attrs
  if magic_info.owner_missile then
    record_attrs = magic_info.owner_missile:get_record_attr_list()
  end
  if 0 == element_type or 1 == element_type then
    local base_element = 1
    if 0 ~= hurt_factor then
      base_hurt, base_sp_armor_hurt = FightCalc.CalcHurtDamage(atk_attrs, def_attrs, hurt_source, hurt_factor, crit_fix_value, base_element, nil, kill_level_fix, skill_type, record_attrs)
    end
    ctx_base_hurt_src = hurt_source
    ctx_base_hurt_factor = hurt_factor
  else
    if 0 ~= hurt_factor then
      element_hurt, element_sp_armor_hurt = FightCalc.CalcHurtDamage(atk_attrs, def_attrs, hurt_source, hurt_factor, crit_fix_value, element_type, nil, kill_level_fix, skill_type, record_attrs)
    end
    ctx_element_hurt_src = hurt_source
    ctx_element_hurt_factor = hurt_factor
  end
  local suc_immune = false
  if magic_target.magic_mgr:check_immunity_damage_magic(skill_type, element_type) then
    base_hurt, base_sp_armor_hurt, element_hurt, element_sp_armor_hurt = 0, 0, 0, 0
    suc_immune = true
  end
  if 6 ~= skill_type and attacker:is_hero() and TowerMgr then
    TowerMgr:check_tower_task_update(CommonDef.TOWER_TASK_TYPE.NO_SKILL, false, 1)
  end
  HURT_CTX.attacker = attacker
  HURT_CTX.magic_target = magic_target
  HURT_CTX.report = report
  HURT_CTX.magic_info = magic_info
  HURT_CTX.skill_type = skill_type
  HURT_CTX.element_type = element_type
  HURT_CTX.is_crit = is_crit
  HURT_CTX.part_info = part_info
  HURT_CTX.magic_level = magic_level
  HURT_CTX.base_hurt_src = ctx_base_hurt_src
  HURT_CTX.element_hurt_src = ctx_element_hurt_src
  HURT_CTX.base_hurt_factor = ctx_base_hurt_factor
  HURT_CTX.element_hurt_factor = ctx_element_hurt_factor
  HURT_CTX.crit_fix_value = crit_fix_value
  HURT_CTX.atk_attrs = atk_attrs
  HURT_CTX.def_attrs = def_attrs
  HURT_CTX.replace_last_hurt = true
  HURT_CTX.suc_immune = suc_immune
  HURT_CTX.kill_level_fix = kill_level_fix
  HURT_CTX.is_lock_hp = is_lock_hp
  HURT_CTX.not_play_hurt_dmg = logic_cfg[8]
  _processing_dmg(base_hurt, element_hurt, base_sp_armor_hurt, element_sp_armor_hurt)
end

local SPECIAL_DMG_CALC_FUNC = {
  [1] = function(attacker, parm)
    return parm
  end,
  [2] = function(attacker, parm)
    return (attacker._LAST_HURT or 0) * parm * 1.0E-4
  end,
  [3] = function(attacker, parm)
    return (attacker._LAST_BE_HURT or 0) * parm * 1.0E-4
  end,
  [4] = function(attacker, parm, attr_mgr, attr_type)
    local attr_value = attr_mgr:get_attr(attr_type)
    return attr_value * parm * 1.0E-4
  end
}
local NO_ELEMENT = 0
local BASE_ELEMENT = 1

function magic_fun.on_special_dmg(magic_target, logic_cfg, magic_info, report)
  local skill_type = logic_cfg[1]
  if not skill_type or not FightDefine.DMG_VALUE_TO_TYPE[skill_type] then
    Log.Error("伤害Magic：", magic_info.magic_id, "所配参数1异常，值为:", skill_type)
    return
  end
  local attacker = magic_info.attacker
  if not attacker then
    return
  end
  if magic_info.part_id then
    return
  end
  local magic_level = magic_info.magic_level
  local atk_attrs = magic_info.attacker_attr_mgr.attrs
  local def_attrs = magic_target.attr_mgr.attrs
  local element_type = logic_cfg[2]
  local calculation_type = logic_cfg[3]
  local can_crit = logic_cfg[4]
  local calculation_parm = logic_cfg[5]
  local replace_last_hurt = logic_cfg[6]
  local is_lock_hp = 1 == logic_cfg[7]
  local damage_value_attr_type = logic_cfg[8]
  local value = 0
  if 4 == calculation_type then
    if damage_value_attr_type and damage_value_attr_type > 0 then
      value = SPECIAL_DMG_CALC_FUNC[calculation_type](attacker, calculation_parm, magic_info.attacker_attr_mgr, damage_value_attr_type)
    else
      Log.Error("特殊伤害公式(参数3)为4，但并未配置参数8，请检查配置， magic_id:", magic_info.magic_id)
    end
  else
    value = SPECIAL_DMG_CALC_FUNC[calculation_type](attacker, calculation_parm, magic_info.attacker_attr_mgr, damage_value_attr_type)
  end
  magic_target:set_before_hurt_info(attacker, magic_info.owner_skill_id)
  local camp, change_lv
  MagicReporter:push_action_start(report, CommonDef.MAGIC_ACTION_TYPE.before_damage)
  if magic_target:is_monster() and def_attrs[ATTR_TYPE.CHAR_HP_SHIELD] <= 0 then
    local hurt_tough_value = logic_cfg[9]
    if hurt_tough_value and hurt_tough_value > 0 then
      hurt_tough_value = FightCalc.CalcHurtTough(hurt_tough_value, atk_attrs, def_attrs)
      camp, change_lv = magic_target:change_tough_value(hurt_tough_value)
    end
  end
  local owner_missile = magic_info.owner_missile
  local owner_skill_id = magic_info.owner_skill_id
  BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.BEFORE_DAMAGE, attacker, magic_target, magic_info.magic_id, skill_type, element_type, camp, change_lv, magic_level, owner_skill_id, owner_missile)
  BehaviorMgr:call_behavior_fun(attacker, "before_damage_target", magic_target, magic_info.magic_id, skill_type, element_type, camp, change_lv, magic_level, owner_skill_id, owner_missile)
  BehaviorMgr:call_behavior_fun(magic_target, "before_damage_self", attacker, magic_info.magic_id, skill_type, element_type, camp, change_lv, magic_level, owner_skill_id, owner_missile)
  MagicReporter:push_action_end(report, CommonDef.MAGIC_ACTION_TYPE.before_damage)
  local is_crit = false
  local crit_fix_value = 0
  if can_crit then
    is_crit, crit_fix_value = _cal_crit(attacker, magic_target, logic_cfg, magic_info, report)
  end
  local kill_level_fix = get_kill_dmg_correction(magic_info.attacker_magic_mgr)
  local hurt, sp_armor_hurt = math.floor(value + 0.5), math.floor(value * 0.3 + 0.5)
  local suc_immune = false
  if magic_target.magic_mgr:check_immunity_damage_magic(skill_type, element_type) then
    hurt, sp_armor_hurt = 0, 0
    suc_immune = true
  end
  local abnormal_id = FightDefine.ELEMENT_TO_AB_ATTR[element_type]
  if abnormal_id and magic_target.attr_mgr:get_abnormal_status(abnormal_id) == FightDefine.ABNORMAL_STATUS.OPEN then
    local abnormal_hurt_factor = get_factor_by_magiclevel(logic_cfg[10], magic_level) or 0
    magic_fun._do_abnor_damage(magic_target, magic_info, skill_type, element_type, abnormal_hurt_factor)
  end
  HURT_CTX.attacker = attacker
  HURT_CTX.magic_target = magic_target
  HURT_CTX.report = report
  HURT_CTX.magic_info = magic_info
  HURT_CTX.skill_type = skill_type
  HURT_CTX.special = true
  HURT_CTX.element_type = element_type
  HURT_CTX.is_crit = is_crit
  HURT_CTX.magic_level = magic_level
  HURT_CTX.crit_fix_value = crit_fix_value
  HURT_CTX.atk_attrs = atk_attrs
  HURT_CTX.def_attrs = def_attrs
  HURT_CTX.replace_last_hurt = replace_last_hurt
  HURT_CTX.suc_immune = suc_immune
  HURT_CTX.kill_level_fix = kill_level_fix
  HURT_CTX.is_lock_hp = is_lock_hp
  HURT_CTX.not_play_hurt_dmg = logic_cfg[11]
  local base_hurt, base_sp_hurt, element_hurt, element_sp_hurt = 0, 0, 0, 0
  if element_type == NO_ELEMENT or element_type == BASE_ELEMENT then
    base_hurt = hurt
    base_sp_hurt = sp_armor_hurt
  else
    element_hurt = hurt
    element_sp_hurt = sp_armor_hurt
  end
  _processing_dmg(base_hurt, element_hurt, base_sp_hurt, element_sp_hurt)
end

function magic_fun.on_cut_hp_shield(magic_target, logic_cfg, magic_info)
  local attacker = magic_info.attacker
  if not attacker then
    return
  end
  local def_attr_mgr = magic_target.attr_mgr
  local value = logic_cfg[1]
  local value_type = logic_cfg[2]
  local tar_ratio_type = logic_cfg[3]
  local shield = magic_target:get_shield_num()
  local SHIELD_VALUE_TYPE = {FIXED = 1, RATIO = 2}
  local cut_val = 0
  local blocked_val = 0
  if value_type == SHIELD_VALUE_TYPE.FIXED then
    cut_val = value
  else
    local tar_attr = def_attr_mgr:get_attr(tar_ratio_type)
    cut_val = value * RATIO_IN * tar_attr
  end
  cut_val, blocked_val = correction_magic_val(-cut_val, MAGIC_TYPE.HpShield, magic_target)
  if 0 ~= blocked_val then
    local deg = Util.get_target_relative_to_attacker_deg(magic_target, attacker, magic_info)
    BloodHelper.play_shiled_block(magic_target, -blocked_val, nil, deg)
  end
end

function magic_fun._do_abnor_damage(magic_target, magic_info, skill_type, element_type, hurt_factor)
  if not magic_target:is_npc() then
    return
  end
  local element_abnormal_mgr = magic_target.element_abnormal_mgr
  local attacker = magic_info.attacker
  if not attacker then
    return
  end
  local atk_attr_mgr = magic_info.attacker_attr_mgr
  local def_attr_mgr = magic_target.attr_mgr
  local random_ctx
  local scene_logic = SceneMgr:get_scene_logic()
  if scene_logic then
    random_ctx = scene_logic:get_random_ctx()
  end
  if attacker:is_hero() or attacker:is_summons() and not attacker:is_monster() then
    element_abnormal_mgr:cache_abnor_magic(attacker, magic_info.owner_skill_id, element_type)
  end
  local fix_value = magic_target.magic_mgr:on_trigger_effect(MAGIC_TYPE.DamageCorrect, magic_info, skill_type, element_type) or 0
  local elmabp = FightCalc.CalcAbnormalDamage(hurt_factor, element_type, atk_attr_mgr.attrs, def_attr_mgr.attrs, fix_value, random_ctx)
  local trigger = element_abnormal_mgr:change_abnormal_value(attacker, element_type, elmabp)
  if JournalMgr then
    JournalMgr:insert_abnormal_journal(atk_attr_mgr, def_attr_mgr, hurt_factor, magic_info, skill_type, element_type, elmabp)
  end
  if not trigger then
    return
  end
  local part_id = magic_info.part_id
  local part_info = part_id and magic_target:get_part_info_by_id(part_id)
  local attach_point = nil ~= part_info and part_info.attach_point
  attach_point = attach_point or magic_info.attach_point
  BloodHelper.play_abnor_font(magic_target, element_type, attach_point)
end

local _mfloor = math.floor

local function calibrationValue(value, valueDecimalPlaces)
  local mult = 10 ^ (valueDecimalPlaces or 0)
  return _mfloor(value * mult) / mult
end

function magic_fun.on_heal(magic_target, logic_cfg, magic_info, report)
  local attacker = magic_info.attacker
  if not attacker then
    return
  end
  local magic_level = magic_info.magic_level
  local atk_attr_mgr = magic_info.attacker_attr_mgr
  local def_attr_mgr = magic_target.attr_mgr
  if not atk_attr_mgr or not def_attr_mgr then
    return
  end
  local attr_type = logic_cfg[1]
  local calculation_val = logic_cfg[2][magic_level] or logic_cfg[2][#logic_cfg[2]]
  if not calculation_val then
    return
  end
  local calculation_type = logic_cfg[3]
  local is_def_attr = logic_cfg[4]
  local is_set = logic_cfg[5]
  MagicReporter:push_action_start(report, CommonDef.MAGIC_ACTION_TYPE.before_heal)
  BehaviorMgr:call_event_fun("before_heal", attacker, magic_target, magic_info.magic_id)
  BehaviorMgr:call_behavior_fun(attacker, "before_heal_target", magic_target, magic_info.magic_id)
  BehaviorMgr:call_behavior_fun(magic_target, "before_heal_self", attacker, magic_info.magic_id)
  MagicReporter:push_action_end(report, CommonDef.MAGIC_ACTION_TYPE.before_heal)
  local attr_mgr = atk_attr_mgr
  if 1 == is_def_attr then
    attr_mgr = def_attr_mgr
  end
  local cur_attr_val = attr_mgr:get_attr(attr_type) or 0
  local ratio_val = 10000
  if calculation_type == CALCULATION_TYPE.FIXED_VAL then
  elseif calculation_type == CALCULATION_TYPE.PROPORTION then
    calculation_val = calculation_val / ratio_val
  end
  local treat_additive = attr_mgr:get_attr(ATTR_TYPE.TREAT_ADDITIVE)
  treat_additive = _max(1 + treat_additive / ratio_val, 0)
  local treated_additive = attr_mgr:get_attr(ATTR_TYPE.TREATED_ADDITIVE)
  treated_additive = _max(1 + treated_additive / ratio_val, 0)
  local fix_value = magic_info.attacker_magic_mgr:on_trigger_effect(MAGIC_TYPE.HealCorrect) or 0
  fix_value = fix_value + magic_fun._get_addtional_effect(magic_info.magic_id)
  local add_hp_val = _max(cur_attr_val * calculation_val * treat_additive * treated_additive, 0)
  if is_set == HEAL_SET_TYPE.SET then
    if calculation_type == CALCULATION_TYPE.FIXED_VAL then
      add_hp_val = _max(calculation_val, 0)
    elseif calculation_type == CALCULATION_TYPE.PROPORTION then
      add_hp_val = _max(cur_attr_val * calculation_val, 0)
    end
  else
    add_hp_val = calibrationValue(add_hp_val * (1 + fix_value), 2)
  end
  MagicReporter:push_action_start(report, CommonDef.MAGIC_ACTION_TYPE.after_heal)
  BehaviorMgr:call_event_fun("after_heal", attacker, magic_target, magic_info.magic_id, add_hp_val)
  BehaviorMgr:call_behavior_fun(attacker, "after_heal_target", magic_target, magic_info.magic_id, add_hp_val)
  BehaviorMgr:call_behavior_fun(magic_target, "after_heal_self", attacker, magic_info.magic_id, add_hp_val)
  MagicReporter:push_action_end(report, CommonDef.MAGIC_ACTION_TYPE.after_heal)
  local hp = magic_target.attr_mgr:get_attr(ATTR_TYPE.CHAR_HP)
  local hp_max = magic_target.attr_mgr:get_attr(ATTR_TYPE.CHAR_HP_MAX)
  local offset = calibrationValue(hp_max - hp, 2)
  if add_hp_val > offset then
    add_hp_val = offset
  end
  local attr_group_type = ATTR_GROUP_TYPE.BASE
  local target_attr_mgr = magic_target.attr_mgr
  target_attr_mgr:change_attr(attr_group_type, ATTR_TYPE.CHAR_HP, add_hp_val, attacker, magic_info.magic_id, magic_info.owner_missile)
  if add_hp_val > 0 and not magic_target:is_die() then
    local msg = MsgGame:mq_publish2(Const.MSG_ON_ROLE_HEAL)
    msg.mm_x = magic_target.uuid
    msg.mm_y = hp
    msg.mm_obj = magic_target.attr_mgr:get_attr(ATTR_TYPE.CHAR_HP)
  end
  if magic_target:is_hero() and not magic_target:check_background() and add_hp_val > 0 then
    BloodHelper.play_blood_animation(BLOOD_TYPE.NORMAL_HEAL, magic_target, add_hp_val)
  end
end

function magic_fun._get_addtional_effect(magic_id)
  local add = 0
  if FightBagMgr then
    add = add + FightBagMgr:get_attr_magic_buff_addtional(magic_id) / 10000
  end
  return add
end

function magic_fun.on_energy_recovery(magic_target, logic_cfg, magic_info)
  local attacker = magic_info.attacker
  if not attacker then
    return
  end
  local magic_level = magic_info.magic_level
  local target_attr_mgr = magic_target.attr_mgr
  if not target_attr_mgr then
    return
  end
  local attr_type = logic_cfg[1]
  local value = logic_cfg[2][magic_level]
  if not value then
    local level_max = #logic_cfg[2]
    value = logic_cfg[2][level_max]
  end
  local value_type = logic_cfg[3]
  local set_type = logic_cfg[4]
  local attr_ratio_type = logic_cfg[5] or attr_type
  local now_attr_val = target_attr_mgr:get_attr(attr_type) or 0
  local base_value = 0
  if value_type == CALCULATION_TYPE.FIXED_VAL then
    base_value = value
  elseif value_type == CALCULATION_TYPE.PROPORTION then
    if attr_ratio_type == attr_type then
      base_value = now_attr_val * value / 10000
    else
      local other_attr = target_attr_mgr:get_attr(attr_ratio_type)
      base_value = other_attr * value / 10000
    end
  end
  local attr_name = FightDefine.ATTR_TYPE_NUM2NAME[attr_type]
  local fixed_name, ratio_name
  if set_type == Config.ENERGY_ATTR_SET_TYPE.ADD then
    fixed_name = attr_name .. EnergySuffix.recovery_fixed_suffix
    ratio_name = attr_name .. EnergySuffix.recovery_ratio_suffix
  elseif set_type == Config.ENERGY_ATTR_SET_TYPE.REDUCE then
    fixed_name = attr_name .. EnergySuffix.consume_fixed_suffix
    ratio_name = attr_name .. EnergySuffix.consume_ratio_suffix
  end
  local fixed_attr_id = FightDefine.ATTR_TYPE[fixed_name]
  local ration_attr_id = FightDefine.ATTR_TYPE[ratio_name]
  local fixed_val = target_attr_mgr:get_attr(fixed_attr_id) or 0
  local ration_val = (target_attr_mgr:get_attr(ration_attr_id) or 0) / 10000
  local final_val = math.max((base_value + fixed_val) * (1 + ration_val), 0)
  final_val = math.abs(final_val)
  if set_type == Config.ENERGY_ATTR_SET_TYPE.REDUCE then
    final_val = -final_val
  end
  target_attr_mgr:change_attr(ATTR_GROUP_TYPE.BASE, attr_type, final_val, attacker, magic_info.magic_id, magic_info.owner_missile)
end

return M
