local FIGHT_DEFINE = require("cs_share.fight_define")
local RUN_MODE = require("cs_share.stat_defines").RUN_MODE
local ATTR_TYPE = FIGHT_DEFINE.ATTR_TYPE
local NAME2ATTR = FIGHT_DEFINE.CONFIG_NAME_ATTR_ID
local EXHARTYPE_MAX = 6
local INIT_ATTR = FIGHT_DEFINE.init_single_attr
local ATK2DEF_TYPES = FIGHT_DEFINE.ATK2DEF_TYPES
local ATK2DEF_TYPES2 = FIGHT_DEFINE.ATK2DEF_TYPES2
local ATK2DEF_TYPES3 = FIGHT_DEFINE.ATK2DEF_TYPES3
local SKILLTYPE2TYPES = FIGHT_DEFINE.SKILLTYPE2TYPES
local FACTOR_RATIO_IN = 1.0E-4
local _max = math.max
local _mfloor = math.floor
local _tpack = table.pack
local FIX_TYPE = {FIXED_VAL = 1, PROPORTION = 2}
local CALCUATION_TYPE = {CALCUATION = 1, FIXED = 2}
local TRANSMISSION_DEF_RATIO = 2000
local t = {}

local function round(num)
  return _mfloor(num + 0.5)
end

function t.get_crit_vaild(atk_attrs, def_attrs, random_ctx, crit_cfg)
  local crit_atk = atk_attrs[ATTR_TYPE.CHAR_CRIT_ATK_PER]
  if crit_cfg and crit_cfg[2] then
    crit_atk = crit_cfg[2]
  end
  local crit_def = def_attrs[ATTR_TYPE.CHAR_CRIT_DEF_PER]
  return t.Random(random_ctx, 0, 10000) < _max(crit_atk - crit_def, 0)
end

function t.get_crit_fix_value(atk_attrs, def_attrs, random_ctx, fix_crit_value, fix_type, calculation_type, is_crit, crit_cfg)
  if not is_crit then
    return 0
  end
  local crit_dmg_atk = atk_attrs[ATTR_TYPE.CHAR_CRIT_DAMAGE_ATK_PER]
  if crit_cfg and crit_cfg[3] then
    crit_dmg_atk = crit_cfg[3]
  end
  local crit_dmg_def = def_attrs[ATTR_TYPE.CHAR_CRIT_DAMAGE_DEF_PER]
  return _max(crit_dmg_atk - crit_dmg_def, 0) / 10000
end

function t.CalcHurtDamage(atk_attrs, def_attrs, hurt_src, hurt_factor, crit_factor, element_type, raw_hurt, kill_level_fix, skill_type, record_attrs)
  if element_type < 0 or element_type > EXHARTYPE_MAX then
    assert(false, "伤害元素类型错误")
  end
  if 0 == element_type then
    return 0, 0
  end
  local final_atk_attrs = record_attrs or atk_attrs
  if not raw_hurt then
    hurt_factor = hurt_factor * FACTOR_RATIO_IN
  end
  local atk_src = final_atk_attrs[hurt_src] or atk_attrs[hurt_src]
  local penetrate = final_atk_attrs[ATTR_TYPE.CHAR_PENETRATE] or atk_attrs[ATTR_TYPE.CHAR_PENETRATE]
  local def = def_attrs[ATTR_TYPE.CHAR_DEFENSE]
  local types = ATK2DEF_TYPES[element_type]
  local skilltypes = SKILLTYPE2TYPES[skill_type]
  local atk_increase_factor = (final_atk_attrs[ATTR_TYPE.EFFECT_ADD] or atk_attrs[types.EFFECT_ADD]) * FACTOR_RATIO_IN
  local atk_increase_factor2 = (final_atk_attrs[ATTR_TYPE.EX_HURT_ADD] or atk_attrs[ATTR_TYPE.EX_HURT_ADD]) * FACTOR_RATIO_IN
  local def_decrease_factor = def_attrs[types.EFFECT_OPPOSE] * FACTOR_RATIO_IN
  local def_decrease_factor2 = def_attrs[ATTR_TYPE.EX_HURT_DERATE] * FACTOR_RATIO_IN
  local atk_attach_dmg = final_atk_attrs[ATTR_TYPE.ATTACH_DMG] or atk_attrs[types.ATTACH_DMG]
  local def_dmg = def_attrs[types.DEF_DMG]
  local atk_dmg_increase, def_dmg_resi
  if not skilltypes then
    atk_dmg_increase = 0
    def_dmg_resi = 0
  else
    atk_dmg_increase = (final_atk_attrs[ATTR_TYPE.DMG_INCREASE] or atk_attrs[skilltypes.DMG_INCREASE]) * FACTOR_RATIO_IN
    def_dmg_resi = def_attrs[skilltypes.DMG_RESI] * FACTOR_RATIO_IN
  end
  local penetrate_ratio = _max(1 - penetrate * FACTOR_RATIO_IN, 0)
  local hurt = _max(atk_src * hurt_factor * (TRANSMISSION_DEF_RATIO / (TRANSMISSION_DEF_RATIO + def * penetrate_ratio)) * (1 + crit_factor) + atk_attach_dmg - def_dmg, 0) * (1 + atk_increase_factor) * (1 - def_decrease_factor) * (1 + atk_dmg_increase) * (1 - def_dmg_resi) * (1 + atk_increase_factor2) * (1 - def_decrease_factor2)
  hurt = round(_max(hurt, 1))
  local sp_armor_hurt = round(hurt * 0.3)
  return hurt, sp_armor_hurt
end

function t.CalcAbnormalDamage(multiple, exhurtype, atk_attrs, def_attrs, fix_value, random_ctx)
  if exhurtype < 0 or exhurtype > EXHARTYPE_MAX then
    assert(false, "exhartype type error")
  end
  local exab_add = atk_attrs[ATTR_TYPE.EX_AB_ADD] * FACTOR_RATIO_IN
  local exaboppose = def_attrs[ATTR_TYPE.EX_AB_OPPOSE] * FACTOR_RATIO_IN
  local types = ATK2DEF_TYPES2[exhurtype]
  local effect_add, effect_oppose = atk_attrs[types.EFFECT_ADD], def_attrs[types.EFFECT_OPPOSE]
  local effect_add_value = _max(1 + effect_add * FACTOR_RATIO_IN, 0)
  local effect_oppose_value = _max(1 - effect_oppose * FACTOR_RATIO_IN, 0)
  local abnormal = multiple * effect_add_value * effect_oppose_value * (1 + exab_add) * (1 - exaboppose)
  return -abnormal
end

function t.CalcAbnormalEffectDamage(element_type, level_param, pure_essence_param, damage_type, atk_attrs, def_attrs, calc_abnormal_max)
  if element_type < 1 or element_type > EXHARTYPE_MAX then
    assert(false, "exhartype type error")
  end
  local types = ATK2DEF_TYPES3[element_type]
  calc_abnormal_max = false ~= calc_abnormal_max
  local abnormal_max = calc_abnormal_max and def_attrs[FIGHT_DEFINE.RES2MAX[FIGHT_DEFINE.ELEMENT_TO_AB_ATTR[element_type]]] or 1
  local DAMAGETYPE_MAP = assert(FIGHT_DEFINE.SKILLTYPE2TYPES[damage_type], damage_type)
  local effect_add_attr_id, effect_oppose_attr_id = DAMAGETYPE_MAP.DMG_INCREASE, DAMAGETYPE_MAP.DMG_RESI
  local effect_add, effect_oppose = atk_attrs[effect_add_attr_id], def_attrs[effect_oppose_attr_id]
  local add, defense_damage = atk_attrs[types.EFFECT_INCREASE], def_attrs[types.EFFECT_RESISTANCE]
  local pure_essence_add = pure_essence_param * 1
  local attacker_effect_add = _max(1 + effect_add * FACTOR_RATIO_IN, 0)
  local target_effect_oppose = _max(1 - effect_oppose * FACTOR_RATIO_IN, 0)
  local attacker_effect_damage_add = math.max(1 + add * FACTOR_RATIO_IN, 0)
  local target_effect_damage_defense = math.max(1 - defense_damage * FACTOR_RATIO_IN, 0)
  return math.max(level_param * pure_essence_add * attacker_effect_add * target_effect_oppose * attacker_effect_damage_add * target_effect_damage_defense, 0) * abnormal_max * -1
end

function t.CalcThunderAdditionalDamage(element_type, level_param, pure_essence_param, damage_type, atk_attrs, def_attrs, calc_abnormal_max, element_count, count_multiple)
  local value = t.CalcAbnormalEffectDamage(element_type, level_param, pure_essence_param, damage_type, atk_attrs, def_attrs, calc_abnormal_max)
  value = value * (1 + (element_count - 1) * count_multiple * FACTOR_RATIO_IN)
  return value
end

function t.CalcDarkSettleDamage(element_type, level_param, pure_essence_param, dark_default_pure_essence_param, total_hurt, damage_type, atk_attrs, def_attrs, element_count, count_multiple)
  if element_type < 1 or element_type > EXHARTYPE_MAX then
    assert(false, "exhartype type error")
  end
  local DarkSettleDamageDefault = t.CalcAbnormalEffectDamage(element_type, level_param, dark_default_pure_essence_param, damage_type, atk_attrs, def_attrs)
  local DarkSettleDamage = total_hurt * t.CalcAbnormalEffectDamage(element_type, 1, pure_essence_param, damage_type, atk_attrs, def_attrs, false)
  local value = DarkSettleDamageDefault + DarkSettleDamage
  value = value * (1 + (element_count - 1) * count_multiple * FACTOR_RATIO_IN)
  return value
end

function t.CalcElementOverLoadDamage(element_type, level_param, pure_essence_param, damage_type, atk_attrs, def_attrs, calc_abnormal_max, abnor_count1, remain_time1, total_time1, abnor_count2, remain_time2, total_time2)
  local value = t.CalcAbnormalEffectDamage(element_type, level_param, pure_essence_param, damage_type, atk_attrs, def_attrs, calc_abnormal_max)
  local value2 = ((abnor_count1 + 1) * remain_time1 + (abnor_count2 + 1) * remain_time2) / (total_time1 + total_time2)
  return value * value2
end

function t.CalcHurtTough(hurt_tough_value, atk_attrs, def_attrs)
  assert(hurt_tough_value, "削韧值为空")
  local increase, resi = atk_attrs[ATTR_TYPE.TOUGHNESS_HURT_INCREASE], def_attrs[ATTR_TYPE.TOUGHNESS_HURT_RESI]
  local increase_value = _max(1 + increase * FACTOR_RATIO_IN, 0)
  local resi_value = _max(1 - resi * FACTOR_RATIO_IN, 0)
  local value = hurt_tough_value * increase_value * resi_value
  return value
end

function t.GetEquipAttrs(equip_attr_cfg, cache_attrs)
  local temp_type
  for attr_name, value in pairs(equip_attr_cfg) do
    temp_type = NAME2ATTR[attr_name]
    if temp_type then
      local attr = cache_attrs[temp_type]
      attr = attr and attr + value or value
      cache_attrs[temp_type] = attr
    end
  end
end

local function GetShareRes(fileName, fileDir)
  if not t._getResources then
    if _LUA_SERVER_ENV then
      t._getResources = require("glib.share_res").GetResources
    else
      t._getResources = ShareRes.create
    end
  end
  if fileDir then
    fileName = fileDir .. "." .. fileName
  end
  assert(type(t._getResources) == "function")
  return t._getResources(fileName)
end

function t.GetEquipAdditions(mEquipInfo, nRunMode)
  local sDir = "battle"
  local mEquipsCfg = GetShareRes("battle_equip", sDir)
  local lFixedEntrys = {}
  local lRandomEntrys = {}
  for equipId, randEntrys in pairs(mEquipInfo) do
    local cfg = mEquipsCfg[equipId]
    if cfg and cfg.FixedEntry then
      for _, entryId in pairs(cfg.FixedEntry) do
        lFixedEntrys[#lFixedEntrys + 1] = entryId
      end
    end
    for _, entryId in pairs(randEntrys) do
      lRandomEntrys[#lRandomEntrys + 1] = entryId
    end
  end
  return t.GetEntryAttrs(lFixedEntrys, lRandomEntrys)
end

function t.GetCollectionAdditions(mCollectionInfo, mJobAttrs)
  local sDir = "battle"
  local mCollectionsCfg = GetShareRes("battle_collection", sDir)
  local mJobAttrsCfg = GetShareRes("battle_collection_job_entry", sDir)
  local mFixedEntrys = {}
  local mRandomEntrys = {}
  for _, v in pairs(mCollectionInfo) do
    local cfg = mCollectionsCfg[v.id]
    if cfg then
      if cfg.FixedEntry then
        for _, entryId in pairs(cfg.FixedEntry) do
          if not mFixedEntrys[entryId] then
            mFixedEntrys[entryId] = 0
          end
          mFixedEntrys[entryId] = mFixedEntrys[entryId] + (v.count or 1)
        end
      end
      do
        local jobAttrId = cfg.CareerDesc
        if mJobAttrs and jobAttrId and mJobAttrsCfg[jobAttrId] then
          local jobAttrIdCfg = mJobAttrsCfg[jobAttrId]
          for level, jobAttrCfg in ipairs(jobAttrIdCfg) do
            local isOk = true
            for index, attrId in pairs(jobAttrCfg.AttrId) do
              local num = jobAttrCfg.Level[index]
              if not num or num > mJobAttrs[attrId] then
                isOk = false
                break
              end
            end
            if isOk then
              local entryId = jobAttrCfg.FixedEntry
              if not mFixedEntrys[entryId] then
                mFixedEntrys[entryId] = 0
              end
              mFixedEntrys[entryId] = mFixedEntrys[entryId] + (v.count or 1)
            end
          end
        end
      end
    end
    for _, entryId in pairs(v.random_entries) do
      if not mRandomEntrys[entryId] then
        mRandomEntrys[entryId] = 0
      end
      mRandomEntrys[entryId] = mRandomEntrys[entryId] + (v.count or 1)
    end
  end
  return t.GetEntryAttrs(mFixedEntrys, mRandomEntrys)
end

function t.GetEntryAttrs(lFixedEntrys, lRandomEntrys)
  local mAttrs = {}
  local sDir = "entry"
  if lFixedEntrys then
    local fixedEntryCfg = GetShareRes("battle_fixed_entry", sDir)
    for entryId, count in pairs(lFixedEntrys) do
      local fixedCfg = fixedEntryCfg[entryId]
      if fixedCfg then
        for _, entry in pairs(fixedCfg.Attr) do
          local tarSuffix = 1 == entry.Type and "FIXED" or "RATIO"
          local tmpTable = mAttrs[entry.Attr]
          if not tmpTable then
            tmpTable = INIT_ATTR()
            mAttrs[entry.Attr] = tmpTable
          end
          tmpTable[tarSuffix] = tmpTable[tarSuffix] + entry.Num * count
        end
      end
    end
  end
  if lRandomEntrys then
    local randomEntryCfg = GetShareRes("battle_random_entry", sDir)
    for entryId, count in pairs(lRandomEntrys) do
      local randomCfg = randomEntryCfg[entryId]
      if randomCfg then
        for _, entry in pairs(randomCfg.Attr) do
          local tarSuffix = 1 == entry.Type and "FIXED" or "RATIO"
          local tmpTable = mAttrs[entry.Attr]
          if not tmpTable then
            tmpTable = INIT_ATTR()
            mAttrs[entry.Attr] = tmpTable
          end
          tmpTable[tarSuffix] = tmpTable[tarSuffix] + entry.Num * count
        end
      end
    end
  end
  return mAttrs
end

local LCG_A = 1103515245
local LCG_C = 12345
local LCG_M = 2147483648

function t.Random(ctx, min, max)
  min = min or 0
  max = max or 10000
  local random_seed = assert(ctx and ctx.random_seed, "random_seed is empty")
  if min == max then
    return min
  end
  assert(min < max, "lcg random interval error")
  local random = (LCG_A * random_seed + LCG_C) % LCG_M
  ctx.random_seed = random
  return random % (max - min) + min
end

return t
