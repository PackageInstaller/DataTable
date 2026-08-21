local t = {}
local ATTR_TYPE = {
  CHAR_HP = 1,
  CHAR_SP = 2,
  EX_ENERGY = 3,
  CHAR_HP_MAX = 4,
  CHAR_SP_MAX = 5,
  EX_ENERGY_MAX = 6,
  CHAR_ABNORMAL_BP1 = 7,
  CHAR_ABNORMAL_BP2 = 8,
  CHAR_ABNORMAL_BP3 = 9,
  CHAR_ABNORMAL_BP4 = 10,
  CHAR_ABNORMAL_BP5 = 11,
  CHAR_ABNORMAL_BP6 = 12,
  CHAR_ABNORMAL_MAX1 = 13,
  CHAR_ABNORMAL_MAX2 = 14,
  CHAR_ABNORMAL_MAX3 = 15,
  CHAR_ABNORMAL_MAX4 = 16,
  CHAR_ABNORMAL_MAX5 = 17,
  CHAR_ABNORMAL_MAX6 = 18,
  CHAR_SP_ON_GROUND_CV = 19,
  CHAR_ATTACK = 20,
  CHAR_PENETRATE = 21,
  CHAR_DEFENSE = 22,
  ABNORMAL_PURE_ESSENCE = 23,
  CHAR_SPEED = 24,
  EX_HURT_DERATE = 25,
  EX_HURT_ADD = 26,
  EX_AB_OPPOSE = 27,
  EX_AB_ADD = 28,
  CHAR_EFFECT_ADD1 = 29,
  CHAR_EFFECT_ADD2 = 30,
  CHAR_EFFECT_ADD3 = 31,
  CHAR_EFFECT_ADD4 = 32,
  CHAR_EFFECT_ADD5 = 33,
  CHAR_EFFECT_ADD6 = 34,
  CHAR_ABNORMAL_ADD1 = 35,
  CHAR_ABNORMAL_ADD2 = 36,
  CHAR_ABNORMAL_ADD3 = 37,
  CHAR_ABNORMAL_ADD4 = 38,
  CHAR_ABNORMAL_ADD5 = 39,
  CHAR_ABNORMAL_ADD6 = 40,
  CHAR_EFFECT_OPPOSE1 = 41,
  CHAR_EFFECT_OPPOSE2 = 42,
  CHAR_EFFECT_OPPOSE3 = 43,
  CHAR_EFFECT_OPPOSE4 = 44,
  CHAR_EFFECT_OPPOSE5 = 45,
  CHAR_EFFECT_OPPOSE6 = 46,
  CHAR_ABNORMAL_OPPOSE1 = 47,
  CHAR_ABNORMAL_OPPOSE2 = 48,
  CHAR_ABNORMAL_OPPOSE3 = 49,
  CHAR_ABNORMAL_OPPOSE4 = 50,
  CHAR_ABNORMAL_OPPOSE5 = 51,
  CHAR_ABNORMAL_OPPOSE6 = 52,
  CHAR_ABNORMAL1 = 53,
  CHAR_ABNORMAL2 = 54,
  CHAR_ABNORMAL3 = 55,
  CHAR_ABNORMAL4 = 56,
  CHAR_ABNORMAL5 = 57,
  CHAR_ABNORMAL6 = 58,
  OVERLOAD_INCREASE = 59,
  WATER_ELEMENT_INCREASE = 60,
  FIRE_ELEMENT_INCREASE = 61,
  THUNDERBOLT_ELEMENT_INCREASE = 62,
  LIGHT_ELEMENT_INCREASE = 63,
  DARK_ELEMENT_INCREASE = 64,
  OVERLOAD_RESISTANCE = 65,
  WATER_ELEMENT_RESISTANCE = 66,
  FIRE_ELEMENT_RESISTANCE = 67,
  THUNDERBOLT_ELEMENT_RESISTANCE = 68,
  LIGHT_ELEMENT_RESISTANCE = 69,
  DARK_ELEMENT_RESISTANCE = 70,
  CHAR_HP_SHIELD = 71,
  CHAR_FIGHT_LINE_BAR = 74,
  CHAR_FIGHT_LINE_BAR_MAX = 75,
  CHAR_CRIT_ATK_PER = 76,
  CHAR_CRIT_DEF_PER = 77,
  CHAR_CRIT_DAMAGE_ATK_PER = 78,
  CHAR_CRIT_DAMAGE_DEF_PER = 79,
  CHAR_LOST_HP = 81,
  TREAT_ADDITIVE = 82,
  TREATED_ADDITIVE = 83,
  RECOVER_ENERGY_ADDITIVE = 84,
  FREEZE_DIRATION_ADD = 85,
  FREEZE_DIRATION_RESI = 86,
  TEAM_SKILL_ENERGY = 108,
  TEAM_SKILL_ENERGY_MAX = 109,
  ATTACH_PHYSICE_DMG = 110,
  ATTACH_ICE_DMG = 111,
  ATTACH_FIRE_DMG = 112,
  ATTACH_THUNDER_DMG = 113,
  ATTACH_LIGHT_DMG = 114,
  ATTACH_DARK_DMG = 115,
  DEFENSE_PHYSICE_DMG = 116,
  DEFENSE_ICE_DMG = 117,
  DEFENSE_FIRE_DMG = 118,
  DEFENSE_THUNDER_DMG = 119,
  DEFENSE_LIGHT_DMG = 120,
  DEFENSE_DARK_DMG = 121,
  NORMAL_DMG_INCREASE = 122,
  THUMP_DMG_INCREASE = 123,
  ROUTINE_SKILL_INCREASE = 124,
  INTENSIFY_SKILL_INCREASE = 125,
  BRANCH_SKILL_INCREASE = 126,
  CHARGE_ABILITY_INCREASE = 127,
  PURSUE_SKILL_INCREASE = 128,
  OTHER_SKILL_INCREASE = 129,
  AB_TRI_DMG_INCREASE = 130,
  AB_SUS_DMG_INCREASE = 131,
  STA_SKILL_DMG_INCREASE = 132,
  NORMAL_DMG_RESI = 133,
  THUMP_DMG_RESI = 134,
  ROUTINE_SKILL_RESI = 135,
  INTENSIFY_SKILL_RESI = 136,
  BRANCH_SKILL_RESI = 137,
  CHARGE_ABILITY_RESI = 138,
  PURSUE_SKILL_RESI = 139,
  OTHER_SKILL_RESI = 140,
  AB_TRI_DMG_RESI = 141,
  AB_SUS_DMG_RESI = 142,
  STA_SKILL_DMG_RESI = 143,
  TOUGHNESS_HURT_RESI = 144,
  GET_EXTRA_ENERGY_RATIO = 145,
  USE_EXTRA_ENERGY_RATIO = 146,
  GET_EXTRA_EX_ENERGY_RATIO = 147,
  USE_EXTRA_EX_ENERGY_RATIO = 148,
  TOUGHNESS_UPPER_LIMIT = 149,
  CHAR_ABATTACK = 151,
  TOUGHNESS_HURT_INCREASE = 152,
  TOUGHNESS = 153,
  CHAR_SP_BACK_GROUND_CV = 154,
  SHIELD_ADDITIVE = 158,
  COMBINE_ENERGY = 159,
  COMBINE_ENERGY_MAX = 160,
  ADD_COMBINE_ENERGY_RATIO = 161
}
t.CHECK_ATTR_FILTER = {
  [ATTR_TYPE.CHAR_FIGHT_LINE_BAR] = true
}
local ELEMENT_TYPE = {
  BASE = 1,
  WATER = 2,
  FIRE = 3,
  THUNDER = 4,
  LIGHT = 5,
  DARK = 6
}
t.ELEMENT_TYPE = ELEMENT_TYPE
t.ELEMENT_TO_AB_ATTR = {
  [ELEMENT_TYPE.BASE] = ATTR_TYPE.CHAR_ABNORMAL_BP1,
  [ELEMENT_TYPE.WATER] = ATTR_TYPE.CHAR_ABNORMAL_BP2,
  [ELEMENT_TYPE.FIRE] = ATTR_TYPE.CHAR_ABNORMAL_BP3,
  [ELEMENT_TYPE.THUNDER] = ATTR_TYPE.CHAR_ABNORMAL_BP4,
  [ELEMENT_TYPE.LIGHT] = ATTR_TYPE.CHAR_ABNORMAL_BP5,
  [ELEMENT_TYPE.DARK] = ATTR_TYPE.CHAR_ABNORMAL_BP6
}
t.AB_ATTR_TO_ELEMENT = {
  [ATTR_TYPE.CHAR_ABNORMAL_BP1] = ELEMENT_TYPE.BASE,
  [ATTR_TYPE.CHAR_ABNORMAL_BP2] = ELEMENT_TYPE.WATER,
  [ATTR_TYPE.CHAR_ABNORMAL_BP3] = ELEMENT_TYPE.FIRE,
  [ATTR_TYPE.CHAR_ABNORMAL_BP4] = ELEMENT_TYPE.THUNDER,
  [ATTR_TYPE.CHAR_ABNORMAL_BP5] = ELEMENT_TYPE.LIGHT,
  [ATTR_TYPE.CHAR_ABNORMAL_BP6] = ELEMENT_TYPE.DARK
}
t.ELEMENT_ATTR = {
  [ATTR_TYPE.CHAR_ABNORMAL_BP1] = true,
  [ATTR_TYPE.CHAR_ABNORMAL_BP2] = true,
  [ATTR_TYPE.CHAR_ABNORMAL_BP3] = true,
  [ATTR_TYPE.CHAR_ABNORMAL_BP4] = true,
  [ATTR_TYPE.CHAR_ABNORMAL_BP5] = true,
  [ATTR_TYPE.CHAR_ABNORMAL_BP6] = true,
  [ATTR_TYPE.CHAR_ABNORMAL_MAX1] = true,
  [ATTR_TYPE.CHAR_ABNORMAL_MAX2] = true,
  [ATTR_TYPE.CHAR_ABNORMAL_MAX3] = true,
  [ATTR_TYPE.CHAR_ABNORMAL_MAX4] = true,
  [ATTR_TYPE.CHAR_ABNORMAL_MAX5] = true,
  [ATTR_TYPE.CHAR_ABNORMAL_MAX6] = true
}
t.AB_ATTR_TO_TIME = {
  [ELEMENT_TYPE.BASE] = ATTR_TYPE.CHAR_ABNORMAL1,
  [ELEMENT_TYPE.WATER] = ATTR_TYPE.CHAR_ABNORMAL2,
  [ELEMENT_TYPE.FIRE] = ATTR_TYPE.CHAR_ABNORMAL3,
  [ELEMENT_TYPE.THUNDER] = ATTR_TYPE.CHAR_ABNORMAL4,
  [ELEMENT_TYPE.LIGHT] = ATTR_TYPE.CHAR_ABNORMAL5,
  [ELEMENT_TYPE.DARK] = ATTR_TYPE.CHAR_ABNORMAL6
}
local DMG_TYPE = {
  NORMAL_DMG = 1,
  THUMP_DMG = 2,
  ROUTINE_SKILL = 3,
  INTENSIFY_SKILL = 4,
  BRANCH_SKILL = 5,
  CHARGE_ABILITY = 6,
  PURSUE_SKILL = 7,
  OTHER_SKILL = 8,
  AB_TRI_DMG = 9,
  AB_SUS_DMG = 10,
  STA_SKILL_DMG = 11
}
t.DMG_TYPE = DMG_TYPE
local DMG_VALUE_TO_TYPE = {
  [DMG_TYPE.NORMAL_DMG] = "NORMAL_DMG",
  [DMG_TYPE.THUMP_DMG] = "THUMP_DMG",
  [DMG_TYPE.ROUTINE_SKILL] = "ROUTINE_SKILL",
  [DMG_TYPE.INTENSIFY_SKILL] = "INTENSIFY_SKILL",
  [DMG_TYPE.BRANCH_SKILL] = "BRANCH_SKILL",
  [DMG_TYPE.CHARGE_ABILITY] = "CHARGE_ABILITY",
  [DMG_TYPE.PURSUE_SKILL] = "PURSUE_SKILL",
  [DMG_TYPE.OTHER_SKILL] = "OTHER_SKILL",
  [DMG_TYPE.AB_TRI_DMG] = "AB_TRI_DMG",
  [DMG_TYPE.AB_SUS_DMG] = "AB_SUS_DMG",
  [DMG_TYPE.STA_SKILL_DMG] = "STA_SKILL_DMG"
}
t.DMG_VALUE_TO_TYPE = DMG_VALUE_TO_TYPE
local ATK2DEF_TYPES = {
  [ELEMENT_TYPE.BASE] = {
    ATTACH_DMG = ATTR_TYPE.ATTACH_PHYSICE_DMG,
    DEF_DMG = ATTR_TYPE.DEFENSE_PHYSICE_DMG,
    EFFECT_ADD = ATTR_TYPE.CHAR_EFFECT_ADD1,
    EFFECT_OPPOSE = ATTR_TYPE.CHAR_EFFECT_OPPOSE1
  }
}
for _, element in pairs(ELEMENT_TYPE) do
  if element ~= ELEMENT_TYPE.BASE then
    ATK2DEF_TYPES[element] = {
      ATTACH_DMG = ATTR_TYPE.ATTACH_PHYSICE_DMG + element - 1,
      DEF_DMG = ATTR_TYPE.DEFENSE_PHYSICE_DMG + element - 1,
      EFFECT_ADD = ATTR_TYPE.CHAR_EFFECT_ADD1 + element - 1,
      EFFECT_OPPOSE = ATTR_TYPE.CHAR_EFFECT_OPPOSE1 + element - 1
    }
  end
end
local ATK2DEF_TYPES2 = {
  [ELEMENT_TYPE.BASE] = {
    EFFECT_ADD = ATTR_TYPE.CHAR_ABNORMAL_ADD1,
    EFFECT_OPPOSE = ATTR_TYPE.CHAR_ABNORMAL_OPPOSE1
  }
}
for _, element in pairs(ELEMENT_TYPE) do
  if element ~= ELEMENT_TYPE.BASE then
    ATK2DEF_TYPES2[element] = {
      EFFECT_ADD = ATTR_TYPE.CHAR_ABNORMAL_ADD1 + element - 1,
      EFFECT_OPPOSE = ATTR_TYPE.CHAR_ABNORMAL_OPPOSE1 + element - 1
    }
  end
end
local ATK2DEF_TYPES3 = {
  [ELEMENT_TYPE.BASE] = {
    EFFECT_INCREASE = ATTR_TYPE.OVERLOAD_INCREASE,
    EFFECT_RESISTANCE = ATTR_TYPE.OVERLOAD_RESISTANCE
  }
}
for _, element in pairs(ELEMENT_TYPE) do
  if element ~= ELEMENT_TYPE.BASE then
    ATK2DEF_TYPES3[element] = {
      EFFECT_INCREASE = ATTR_TYPE.OVERLOAD_INCREASE + element - 1,
      EFFECT_RESISTANCE = ATTR_TYPE.OVERLOAD_RESISTANCE + element - 1
    }
  end
end
local SKILLTYPE2TYPES = {
  [DMG_TYPE.NORMAL_DMG] = {
    DMG_INCREASE = ATTR_TYPE.NORMAL_DMG_INCREASE,
    DMG_RESI = ATTR_TYPE.NORMAL_DMG_RESI
  },
  [DMG_TYPE.THUMP_DMG] = {
    DMG_INCREASE = ATTR_TYPE.THUMP_DMG_INCREASE,
    DMG_RESI = ATTR_TYPE.THUMP_DMG_RESI
  },
  [DMG_TYPE.ROUTINE_SKILL] = {
    DMG_INCREASE = ATTR_TYPE.ROUTINE_SKILL_INCREASE,
    DMG_RESI = ATTR_TYPE.ROUTINE_SKILL_RESI
  },
  [DMG_TYPE.INTENSIFY_SKILL] = {
    DMG_INCREASE = ATTR_TYPE.INTENSIFY_SKILL_INCREASE,
    DMG_RESI = ATTR_TYPE.INTENSIFY_SKILL_RESI
  },
  [DMG_TYPE.BRANCH_SKILL] = {
    DMG_INCREASE = ATTR_TYPE.BRANCH_SKILL_INCREASE,
    DMG_RESI = ATTR_TYPE.BRANCH_SKILL_RESI
  },
  [DMG_TYPE.CHARGE_ABILITY] = {
    DMG_INCREASE = ATTR_TYPE.CHARGE_ABILITY_INCREASE,
    DMG_RESI = ATTR_TYPE.CHARGE_ABILITY_RESI
  },
  [DMG_TYPE.PURSUE_SKILL] = {
    DMG_INCREASE = ATTR_TYPE.PURSUE_SKILL_INCREASE,
    DMG_RESI = ATTR_TYPE.PURSUE_SKILL_RESI
  },
  [DMG_TYPE.OTHER_SKILL] = {
    DMG_INCREASE = ATTR_TYPE.OTHER_SKILL_INCREASE,
    DMG_RESI = ATTR_TYPE.OTHER_SKILL_RESI
  },
  [DMG_TYPE.AB_TRI_DMG] = {
    DMG_INCREASE = ATTR_TYPE.AB_TRI_DMG_INCREASE,
    DMG_RESI = ATTR_TYPE.AB_TRI_DMG_RESI
  },
  [DMG_TYPE.AB_SUS_DMG] = {
    DMG_INCREASE = ATTR_TYPE.AB_SUS_DMG_INCREASE,
    DMG_RESI = ATTR_TYPE.AB_SUS_DMG_RESI
  },
  [DMG_TYPE.STA_SKILL_DMG] = {
    DMG_INCREASE = ATTR_TYPE.STA_SKILL_DMG_INCREASE,
    DMG_RESI = ATTR_TYPE.STA_SKILL_DMG_RESI
  }
}
t.SKILLTYPE2TYPES = SKILLTYPE2TYPES
t.ATK2DEF_TYPES = ATK2DEF_TYPES
t.ATK2DEF_TYPES2 = ATK2DEF_TYPES2
t.ATK2DEF_TYPES3 = ATK2DEF_TYPES3
t.ATTR_TYPE = ATTR_TYPE
t.ATTR_TYPE_NUM2NAME = {}
for k, v in pairs(ATTR_TYPE) do
  if 0 ~= v then
    t.ATTR_TYPE_NUM2NAME[v] = k
  end
end
t.ROOM_WAY_TYPE = {
  def_enter = 1,
  tp_enter = 2,
  def_exit = 3,
  tp_exit = 4,
  reborn_enter = 5
}
local CONFIG_NAME_ATTR_ID = {
  ["nil"] = 0,
  hp = t.ATTR_TYPE.CHAR_HP_MAX,
  max_hp = t.ATTR_TYPE.CHAR_HP_MAX,
  energy = t.ATTR_TYPE.CHAR_SP,
  max_energy = t.ATTR_TYPE.CHAR_SP_MAX,
  exenergy = t.ATTR_TYPE.EX_ENERGY_MAX,
  max_exenergy = t.ATTR_TYPE.EX_ENERGY_MAX,
  fight_line_bar = t.ATTR_TYPE.CHAR_FIGHT_LINE_BAR,
  fight_line_bar_max = t.ATTR_TYPE.CHAR_FIGHT_LINE_BAR_MAX,
  elmabp1 = t.ATTR_TYPE.CHAR_ABNORMAL_MAX1,
  elmabp2 = t.ATTR_TYPE.CHAR_ABNORMAL_MAX2,
  elmabp3 = t.ATTR_TYPE.CHAR_ABNORMAL_MAX3,
  elmabp4 = t.ATTR_TYPE.CHAR_ABNORMAL_MAX4,
  elmabp5 = t.ATTR_TYPE.CHAR_ABNORMAL_MAX5,
  elmabp6 = t.ATTR_TYPE.CHAR_ABNORMAL_MAX6,
  on_ground_cvenergy = t.ATTR_TYPE.CHAR_SP_ON_GROUND_CV,
  back_ground_cvenergy = t.ATTR_TYPE.CHAR_SP_BACK_GROUND_CV,
  attack = t.ATTR_TYPE.CHAR_ATTACK,
  abattack = t.ATTR_TYPE.CHAR_ABATTACK,
  penetrate = t.ATTR_TYPE.CHAR_PENETRATE,
  defense = t.ATTR_TYPE.CHAR_DEFENSE,
  abnormal_pure_essence = t.ATTR_TYPE.ABNORMAL_PURE_ESSENCE,
  mvspeed = t.ATTR_TYPE.CHAR_SPEED,
  exharmredu = t.ATTR_TYPE.EX_HURT_DERATE,
  exharmadd = t.ATTR_TYPE.EX_HURT_ADD,
  exaboppose = t.ATTR_TYPE.EX_AB_OPPOSE,
  exabadd = t.ATTR_TYPE.EX_AB_ADD,
  elmeftadd1 = t.ATTR_TYPE.CHAR_EFFECT_ADD1,
  elmeftadd2 = t.ATTR_TYPE.CHAR_EFFECT_ADD2,
  elmeftadd3 = t.ATTR_TYPE.CHAR_EFFECT_ADD3,
  elmeftadd4 = t.ATTR_TYPE.CHAR_EFFECT_ADD4,
  elmeftadd5 = t.ATTR_TYPE.CHAR_EFFECT_ADD5,
  elmeftadd6 = t.ATTR_TYPE.CHAR_EFFECT_ADD6,
  elmabadd1 = t.ATTR_TYPE.CHAR_ABNORMAL_ADD1,
  elmabadd2 = t.ATTR_TYPE.CHAR_ABNORMAL_ADD2,
  elmabadd3 = t.ATTR_TYPE.CHAR_ABNORMAL_ADD3,
  elmabadd4 = t.ATTR_TYPE.CHAR_ABNORMAL_ADD4,
  elmabadd5 = t.ATTR_TYPE.CHAR_ABNORMAL_ADD5,
  elmabadd6 = t.ATTR_TYPE.CHAR_ABNORMAL_ADD6,
  elmeftoppose1 = t.ATTR_TYPE.CHAR_EFFECT_OPPOSE1,
  elmeftoppose2 = t.ATTR_TYPE.CHAR_EFFECT_OPPOSE2,
  elmeftoppose3 = t.ATTR_TYPE.CHAR_EFFECT_OPPOSE3,
  elmeftoppose4 = t.ATTR_TYPE.CHAR_EFFECT_OPPOSE4,
  elmeftoppose5 = t.ATTR_TYPE.CHAR_EFFECT_OPPOSE5,
  elmeftoppose6 = t.ATTR_TYPE.CHAR_EFFECT_OPPOSE6,
  elmaboppose1 = t.ATTR_TYPE.CHAR_ABNORMAL_OPPOSE1,
  elmaboppose2 = t.ATTR_TYPE.CHAR_ABNORMAL_OPPOSE2,
  elmaboppose3 = t.ATTR_TYPE.CHAR_ABNORMAL_OPPOSE3,
  elmaboppose4 = t.ATTR_TYPE.CHAR_ABNORMAL_OPPOSE4,
  elmaboppose5 = t.ATTR_TYPE.CHAR_ABNORMAL_OPPOSE5,
  elmaboppose6 = t.ATTR_TYPE.CHAR_ABNORMAL_OPPOSE6,
  elmabcd1 = t.ATTR_TYPE.CHAR_ABNORMAL1,
  elmabcd2 = t.ATTR_TYPE.CHAR_ABNORMAL2,
  elmabcd3 = t.ATTR_TYPE.CHAR_ABNORMAL3,
  elmabcd4 = t.ATTR_TYPE.CHAR_ABNORMAL4,
  elmabcd5 = t.ATTR_TYPE.CHAR_ABNORMAL5,
  elmabcd6 = t.ATTR_TYPE.CHAR_ABNORMAL6,
  crit_atk_per = t.ATTR_TYPE.CHAR_CRIT_ATK_PER,
  crit_def_per = t.ATTR_TYPE.CHAR_CRIT_DEF_PER,
  crit_dmg_atk_per = t.ATTR_TYPE.CHAR_CRIT_DAMAGE_ATK_PER,
  crit_dmg_def_per = t.ATTR_TYPE.CHAR_CRIT_DAMAGE_DEF_PER,
  treat_additive = t.ATTR_TYPE.TREAT_ADDITIVE,
  treated_additive = t.ATTR_TYPE.TREATED_ADDITIVE,
  recover_energy_additive = t.ATTR_TYPE.RECOVER_ENERGY_ADDITIVE,
  team_skill_energy = t.ATTR_TYPE.TEAM_SKILL_ENERGY,
  team_skill_energy_max = t.ATTR_TYPE.TEAM_SKILL_ENERGY_MAX,
  attach_physice_dmg = t.ATTR_TYPE.ATTACH_PHYSICE_DMG,
  attach_ice_dmg = t.ATTR_TYPE.ATTACH_ICE_DMG,
  attach_fire_dmg = t.ATTR_TYPE.ATTACH_FIRE_DMG,
  attach_thunder_dmg = t.ATTR_TYPE.ATTACH_THUNDER_DMG,
  attach_light_dmg = t.ATTR_TYPE.ATTACH_LIGHT_DMG,
  attach_dark_dmg = t.ATTR_TYPE.ATTACH_DARK_DMG,
  defense_physice_dmg = t.ATTR_TYPE.DEFENSE_PHYSICE_DMG,
  defense_ice_dmg = t.ATTR_TYPE.DEFENSE_ICE_DMG,
  defense_fire_dmg = t.ATTR_TYPE.DEFENSE_FIRE_DMG,
  defense_thunder_dmg = t.ATTR_TYPE.DEFENSE_THUNDER_DMG,
  defense_light_dmg = t.ATTR_TYPE.DEFENSE_LIGHT_DMG,
  defense_dark_dmg = t.ATTR_TYPE.DEFENSE_DARK_DMG,
  normal_dmg_increase = t.ATTR_TYPE.NORMAL_DMG_INCREASE,
  thump_dmg_increase = t.ATTR_TYPE.THUMP_DMG_INCREASE,
  routine_skill_increase = t.ATTR_TYPE.ROUTINE_SKILL_INCREASE,
  intensify_skill_increase = t.ATTR_TYPE.INTENSIFY_SKILL_INCREASE,
  branch_skill_increase = t.ATTR_TYPE.BRANCH_SKILL_INCREASE,
  charge_ability_increase = t.ATTR_TYPE.CHARGE_ABILITY_INCREASE,
  pursue_skill_increase = t.ATTR_TYPE.PURSUE_SKILL_INCREASE,
  other_skill_increase = t.ATTR_TYPE.OTHER_SKILL_INCREASE,
  ab_tri_dmg_increase = t.ATTR_TYPE.AB_TRI_DMG_INCREASE,
  ab_sus_dmg_increase = t.ATTR_TYPE.AB_SUS_DMG_INCREASE,
  sta_skill_dmg_increase = t.ATTR_TYPE.STA_SKILL_DMG_INCREASE,
  normal_dmg_resi = t.ATTR_TYPE.NORMAL_DMG_RESI,
  thump_dmg_resi = t.ATTR_TYPE.THUMP_DMG_RESI,
  routine_skill_resi = t.ATTR_TYPE.ROUTINE_SKILL_RESI,
  intensify_skill_resi = t.ATTR_TYPE.INTENSIFY_SKILL_RESI,
  branch_skill_resi = t.ATTR_TYPE.BRANCH_SKILL_RESI,
  charge_ability_resi = t.ATTR_TYPE.CHARGE_ABILITY_RESI,
  pursue_skill_resi = t.ATTR_TYPE.PURSUE_SKILL_RESI,
  other_skill_resi = t.ATTR_TYPE.OTHER_SKILL_RESI,
  ab_tri_dmg_resi = t.ATTR_TYPE.AB_TRI_DMG_RESI,
  ab_sus_dmg_resi = t.ATTR_TYPE.AB_SUS_DMG_RESI,
  sta_skill_dmg_resi = t.ATTR_TYPE.STA_SKILL_DMG_RESI,
  toughness_hurt_resi = t.ATTR_TYPE.TOUGHNESS_HURT_RESI,
  toughness_upper_limit = t.ATTR_TYPE.TOUGHNESS_UPPER_LIMIT,
  get_extra_energy_ratio = t.ATTR_TYPE.GET_EXTRA_ENERGY_RATIO,
  use_extra_energy_ratio = t.ATTR_TYPE.USE_EXTRA_ENERGY_RATIO,
  get_extra_ex_energy_ratio = t.ATTR_TYPE.GET_EXTRA_EX_ENERGY_RATIO,
  use_extra_ex_energy_ratio = t.ATTR_TYPE.USE_EXTRA_EX_ENERGY_RATIO,
  toughness_hurt_increase = t.ATTR_TYPE.TOUGHNESS_HURT_INCREASE,
  toughness = t.ATTR_TYPE.TOUGHNESS,
  shield_additive = t.ATTR_TYPE.SHIELD_ADDITIVE,
  overload_increase = t.OVERLOAD_INCREASE,
  water_element_increase = t.WATER_ELEMENT_INCREASE,
  fire_element_increase = t.FIRE_ELEMENT_INCREASE,
  thunderbolt_element_increase = t.THUNDERBOLT_ELEMENT_INCREASE,
  light_element_increase = t.LIGHT_ELEMENT_INCREASE,
  dark_element_increase = t.DARK_ELEMENT_INCREASE,
  overload_resistance = t.OVERLOAD_RESISTANCE,
  water_element_resistance = t.WATER_ELEMENT_RESISTANCE,
  fire_element_resistance = t.FIRE_ELEMENT_RESISTANCE,
  thunderbolt_element_resistance = t.THUNDERBOLT_ELEMENT_RESISTANCE,
  light_element_resistance = t.LIGHT_ELEMENT_RESISTANCE,
  dark_element_resistance = t.DARK_ELEMENT_RESISTANCE,
  combine_energy = t.ATTR_TYPE.COMBINE_ENERGY,
  combine_energy_max = t.ATTR_TYPE.COMBINE_ENERGY_MAX,
  add_combine_energy_ratio = t.ATTR_TYPE.ADD_COMBINE_ENERGY_RATIO
}
t.CONFIG_NAME_ATTR_ID = CONFIG_NAME_ATTR_ID
t.NUM2NAME = {}
for k, v in pairs(CONFIG_NAME_ATTR_ID) do
  if 0 ~= v then
    t.NUM2NAME[v] = k
  end
end
local ATTRS = t.ATTR_TYPE
t.RES_ATTRS = {
  [ATTRS.CHAR_HP] = true,
  [ATTRS.CHAR_SP] = true,
  [ATTRS.CHAR_HP_SHIELD] = true,
  [ATTRS.CHAR_FIGHT_LINE_BAR] = true,
  [ATTRS.CHAR_ABNORMAL_BP1] = true,
  [ATTRS.CHAR_ABNORMAL_BP2] = true,
  [ATTRS.CHAR_ABNORMAL_BP3] = true,
  [ATTRS.CHAR_ABNORMAL_BP4] = true,
  [ATTRS.CHAR_ABNORMAL_BP5] = true,
  [ATTRS.CHAR_ABNORMAL_BP6] = true,
  [ATTRS.TEAM_SKILL_ENERGY] = true,
  [ATTRS.TOUGHNESS] = true,
  [ATTR_TYPE.COMBINE_ENERGY] = true
}
local RES_ATTRS = t.RES_ATTRS
local RES2MAX = {
  [ATTRS.CHAR_HP] = ATTRS.CHAR_HP_MAX,
  [ATTRS.CHAR_SP] = ATTRS.CHAR_SP_MAX,
  [ATTRS.EX_ENERGY] = ATTRS.EX_ENERGY_MAX,
  [ATTRS.CHAR_HP_SHIELD] = -1,
  [ATTRS.CHAR_FIGHT_LINE_BAR] = ATTRS.CHAR_FIGHT_LINE_BAR_MAX,
  [ATTRS.CHAR_ABNORMAL_BP1] = ATTRS.CHAR_ABNORMAL_MAX1,
  [ATTRS.CHAR_ABNORMAL_BP2] = ATTRS.CHAR_ABNORMAL_MAX2,
  [ATTRS.CHAR_ABNORMAL_BP3] = ATTRS.CHAR_ABNORMAL_MAX3,
  [ATTRS.CHAR_ABNORMAL_BP4] = ATTRS.CHAR_ABNORMAL_MAX4,
  [ATTRS.CHAR_ABNORMAL_BP5] = ATTRS.CHAR_ABNORMAL_MAX5,
  [ATTRS.CHAR_ABNORMAL_BP6] = ATTRS.CHAR_ABNORMAL_MAX6,
  [ATTRS.TEAM_SKILL_ENERGY] = ATTRS.TEAM_SKILL_ENERGY_MAX,
  [ATTRS.TOUGHNESS] = ATTRS.TOUGHNESS_UPPER_LIMIT,
  [ATTR_TYPE.COMBINE_ENERGY] = ATTR_TYPE.COMBINE_ENERGY_MAX
}
t.RES2MAX = RES2MAX
t.HERO_RES2MAX = {
  [ATTRS.CHAR_HP] = ATTRS.CHAR_HP_MAX,
  [ATTRS.CHAR_SP] = ATTRS.CHAR_SP_MAX,
  [ATTRS.EX_ENERGY] = -1,
  [ATTRS.CHAR_HP_SHIELD] = -1,
  [ATTRS.CHAR_FIGHT_LINE_BAR] = -1,
  [ATTRS.CHAR_ABNORMAL_BP1] = ATTRS.CHAR_ABNORMAL_MAX1,
  [ATTRS.CHAR_ABNORMAL_BP2] = ATTRS.CHAR_ABNORMAL_MAX2,
  [ATTRS.CHAR_ABNORMAL_BP3] = ATTRS.CHAR_ABNORMAL_MAX3,
  [ATTRS.CHAR_ABNORMAL_BP4] = ATTRS.CHAR_ABNORMAL_MAX4,
  [ATTRS.CHAR_ABNORMAL_BP5] = ATTRS.CHAR_ABNORMAL_MAX5,
  [ATTRS.CHAR_ABNORMAL_BP6] = ATTRS.CHAR_ABNORMAL_MAX6,
  [ATTRS.TEAM_SKILL_ENERGY] = -1,
  [ATTRS.TOUGHNESS] = ATTRS.TOUGHNESS_UPPER_LIMIT,
  [ATTR_TYPE.COMBINE_ENERGY] = -1
}
t.MONSTER_RES2MAX = {
  [ATTRS.CHAR_HP] = ATTRS.CHAR_HP_MAX,
  [ATTRS.CHAR_HP_SHIELD] = -1,
  [ATTRS.CHAR_SP] = ATTRS.CHAR_SP_MAX,
  [ATTRS.CHAR_ABNORMAL_BP1] = ATTRS.CHAR_ABNORMAL_MAX1,
  [ATTRS.CHAR_ABNORMAL_BP2] = ATTRS.CHAR_ABNORMAL_MAX2,
  [ATTRS.CHAR_ABNORMAL_BP3] = ATTRS.CHAR_ABNORMAL_MAX3,
  [ATTRS.CHAR_ABNORMAL_BP4] = ATTRS.CHAR_ABNORMAL_MAX4,
  [ATTRS.CHAR_ABNORMAL_BP5] = ATTRS.CHAR_ABNORMAL_MAX5,
  [ATTRS.CHAR_ABNORMAL_BP6] = ATTRS.CHAR_ABNORMAL_MAX6,
  [ATTRS.TEAM_SKILL_ENERGY] = -1,
  [ATTRS.TOUGHNESS] = ATTRS.TOUGHNESS_UPPER_LIMIT,
  [ATTR_TYPE.COMBINE_ENERGY] = -1
}
t.ITEM_SOURCE_EVENT = {
  ROOM_DROP = 1,
  BATTLE_SHOP_BUY = 2,
  BATTLE_SHOP_SELL = 3,
  OTHER = 4,
  GM = 5,
  BATTLE_TREASURE = 6,
  SCENE_REWARD_NPC = 7,
  ROOM_END_DROP = 8,
  MAGIC_ENTRY_EX_DROP_FAKE = 9,
  MAGIC_ENTRY_EX_DROP = 10
}
t.ITEM_SOURCE_NAME2ID = {
  room_drop = t.ITEM_SOURCE_EVENT.ROOM_DROP,
  battle_shop_buy = t.ITEM_SOURCE_EVENT.BATTLE_SHOP_BUY,
  battle_shop_sell = t.ITEM_SOURCE_EVENT.BATTLE_SHOP_SALE,
  other = t.ITEM_SOURCE_EVENT.OTHER,
  gm = t.ITEM_SOURCE_EVENT.GM,
  GM = t.ITEM_SOURCE_EVENT.GM,
  battle_treasure_excute_choose = t.ITEM_SOURCE_EVENT.BATTLE_TREASURE,
  battle_reward_npc_do_reward = t.ITEM_SOURCE_EVENT.SCENE_REWARD_NPC,
  room_end_drop = t.ITEM_SOURCE_EVENT.ROOM_END_DROP,
  magic_entry_ex_drop_fake = t.ITEM_SOURCE_EVENT.MAGIC_ENTRY_EX_DROP_FAKE,
  magic_entry_ex_drop = t.ITEM_SOURCE_EVENT.MAGIC_ENTRY_EX_DROP
}
t.HERO_INIT_ZERO_RES = {}
t.MONSTER_INIT_ZERO_RES = {
  [ATTRS.TEAM_SKILL_ENERGY] = ATTRS.TEAM_SKILL_ENERGY
}
t.ELEMENT_DAMAGE_TYPE = {
  AD = 1,
  Ice = 2,
  Fire = 3,
  Electric = 4,
  Light = 5,
  Darkness = 6
}
t.DAMAGE_CALCU_USED_ATTRS = {
  [ATTRS.EX_ENERGY] = true,
  [ATTRS.CHAR_ATTACK] = true,
  [ATTRS.CHAR_PENETRATE] = true,
  [ATTRS.EX_HURT_ADD] = true,
  [ATTRS.CHAR_CRIT_ATK_PER] = true,
  [ATTRS.CHAR_CRIT_DAMAGE_ATK_PER] = true,
  [ATTRS.CHAR_EFFECT_ADD1] = true,
  [ATTRS.CHAR_EFFECT_ADD2] = true,
  [ATTRS.CHAR_EFFECT_ADD3] = true,
  [ATTRS.CHAR_EFFECT_ADD4] = true,
  [ATTRS.CHAR_EFFECT_ADD5] = true,
  [ATTRS.CHAR_EFFECT_ADD6] = true,
  [ATTRS.ATTACH_PHYSICE_DMG] = true,
  [ATTRS.ATTACH_ICE_DMG] = true,
  [ATTRS.ATTACH_FIRE_DMG] = true,
  [ATTRS.ATTACH_THUNDER_DMG] = true,
  [ATTRS.ATTACH_LIGHT_DMG] = true,
  [ATTRS.ATTACH_DARK_DMG] = true,
  [ATTRS.NORMAL_DMG_INCREASE] = true,
  [ATTRS.THUMP_DMG_INCREASE] = true,
  [ATTRS.ROUTINE_SKILL_INCREASE] = true,
  [ATTRS.INTENSIFY_SKILL_INCREASE] = true,
  [ATTRS.BRANCH_SKILL_INCREASE] = true,
  [ATTRS.CHARGE_ABILITY_INCREASE] = true,
  [ATTRS.PURSUE_SKILL_INCREASE] = true,
  [ATTRS.OTHER_SKILL_INCREASE] = true,
  [ATTRS.AB_TRI_DMG_INCREASE] = true,
  [ATTRS.AB_SUS_DMG_INCREASE] = true,
  [ATTRS.STA_SKILL_DMG_INCREASE] = true,
  [ATTRS.NORMAL_DMG_RESI] = true,
  [ATTRS.THUMP_DMG_RESI] = true,
  [ATTRS.ROUTINE_SKILL_RESI] = true,
  [ATTRS.INTENSIFY_SKILL_RESI] = true,
  [ATTRS.BRANCH_SKILL_RESI] = true,
  [ATTRS.CHARGE_ABILITY_RESI] = true,
  [ATTRS.PURSUE_SKILL_RESI] = true,
  [ATTRS.OTHER_SKILL_RESI] = true,
  [ATTRS.AB_TRI_DMG_RESI] = true,
  [ATTRS.AB_SUS_DMG_RESI] = true,
  [ATTRS.STA_SKILL_DMG_RESI] = true,
  [ATTRS.TOUGHNESS_HURT_RESI] = true
}
local VALUE_TYPE = {FIXED = 1, RATIO = 2}
t.single_attr_pool = {}
t.pool_count = 0
local single_attr_proxy_table
if _LUA_SERVER_ENV then
  single_attr_proxy_table = import("service.utils.single_attr_proxy_table", "common")
else
  single_attr_proxy_table = require("utils.single_attr_proxy_table")
end

local function _pop_single_attr_temp()
  local single_attr
  if t.pool_count <= 0 then
    single_attr = single_attr_proxy_table.create_encrypted_table()
    single_attr.FIXED = 0
    single_attr.RATIO = 0
    single_attr.OTHER_RATIO = single_attr_proxy_table.create_encrypted_table()
  else
    single_attr = t.single_attr_pool[t.pool_count]
    t.single_attr_pool[t.pool_count] = nil
    t.pool_count = t.pool_count - 1
  end
  return single_attr
end

function t.push_single_attr_temp(single_attr)
  single_attr.FIXED = 0
  single_attr.RATIO = 0
  for key in pairs(single_attr.OTHER_RATIO) do
    single_attr.OTHER_RATIO[key] = nil
  end
  t.pool_count = t.pool_count + 1
  t.single_attr_pool[t.pool_count] = single_attr
end

function t.release_single_attr_temp()
  t.pool_count = 0
  t.single_attr_pool = {}
end

function init_single_attr(value, value_type)
  local single_attr
  if _LUA_SERVER_ENV then
    single_attr = single_attr_proxy_table.create_encrypted_table()
    single_attr.FIXED = 0
    single_attr.RATIO = 0
    single_attr.OTHER_RATIO = single_attr_proxy_table.create_encrypted_table()
  else
    single_attr = _pop_single_attr_temp()
  end
  if value then
    if value_type == VALUE_TYPE.FIXED then
      single_attr.FIXED = value
    elseif value_type == VALUE_TYPE.RATIO then
      single_attr.RATIO = value
    else
      assert(false)
    end
  end
  return single_attr
end

function t.single_attr_add(left_attr, right_attr)
  if not left_attr or not right_attr then
    return
  end
  left_attr.FIXED = left_attr.FIXED + right_attr.FIXED
  left_attr.RATIO = left_attr.RATIO + right_attr.RATIO
  for t, v in pairs(right_attr.OTHER_RATIO) do
    if left_attr.OTHER_RATIO[t] then
      left_attr.OTHER_RATIO[t] = left_attr.OTHER_RATIO[t] + v
    else
      left_attr.OTHER_RATIO[t] = v
    end
  end
end

t.init_single_attr = init_single_attr

function t.append_attr_to_set(attrs, attr_type, value, value_type)
  local attr = attrs[attr_type]
  if not attr then
    attrs[attr_type] = init_single_attr(value, value_type)
  elseif value then
    if value_type == VALUE_TYPE.FIXED then
      attr.FIXED = attr.FIXED + value
    elseif value_type == VALUE_TYPE.RATIO then
      attr.RATIO = attr.RATIO + value
    else
      assert(false)
    end
  end
end

local function attr_is_res(attr_type)
  return RES_ATTRS[attr_type]
end

t.attr_is_res = attr_is_res

function t.get_empty_attrs()
  local attrs = {}
  for k, v in pairs(t.ATTR_TYPE) do
    if not attr_is_res(v) then
      attrs[v] = init_single_attr()
    end
  end
  return attrs
end

function t.init_res(attrs, res2max, init_zero)
  for res_attr, max_attr in pairs(res2max) do
    if 0 == attrs[res_attr].FIXED and not init_zero[res_attr] then
      attrs[res_attr].FIXED = math.huge
    end
  end
end

function t.get_other_sys_attrs_add(buddy_base_attr, euqip_attr, engrave_attr)
  local attrs = {}
  if engrave_attr then
    for attr_id, attr_info in pairs(engrave_attr) do
      if not attrs[attr_id] then
        attrs[attr_id] = init_single_attr()
      end
      if attr_info.FIXED then
        attrs[attr_id].FIXED = attrs[attr_id].FIXED + attr_info.FIXED
      end
      local euqip_val = euqip_attr[attr_id] and euqip_attr[attr_id].FIXED or 0
      if attr_info.RATIO and buddy_base_attr[attr_id].FIXED ~= math.huge then
        attrs[attr_id].FIXED = attrs[attr_id].FIXED + (buddy_base_attr[attr_id].FIXED + euqip_val + attrs[attr_id].FIXED) * (attr_info.RATIO / 10000)
      end
    end
  end
  return attrs
end

function t.get_char_attrs(id, break_lv, lv, base_attr, upgrade_attr, mArgs)
  if not base_attr[id] then
    error("id not exist" .. id)
    return
  end
  local attrs = {}
  for k, v in pairs(t.ATTR_TYPE) do
    attrs[v] = init_single_attr()
  end
  local base_attr_level = base_attr[id][break_lv]
  local upgrade_attr_level = upgrade_attr[id][break_lv]
  for k, v in pairs(base_attr_level) do
    local attr_id = CONFIG_NAME_ATTR_ID[k]
    if attr_id then
      local level_value = 0
      if upgrade_attr_level[k] then
        level_value = upgrade_attr_level[k] * lv
      end
      attrs[attr_id].FIXED = v + level_value
    end
  end
  local advance_lv = mArgs.advance_lv
  local upgrade_advance_attr = mArgs.upgrade_advance
  local all_advance_attr_cfg = upgrade_advance_attr[id]
  if all_advance_attr_cfg then
    for lv = 1, advance_lv do
      local advance_attr_cfg = all_advance_attr_cfg[lv]
      if advance_attr_cfg then
        for attr_name, add_val in pairs(advance_attr_cfg) do
          local attr_id = CONFIG_NAME_ATTR_ID[attr_name]
          if attr_id then
            attrs[attr_id].FIXED = attrs[attr_id].FIXED + add_val
          end
        end
      end
    end
  end
  local upgrade_talent_cfg = mArgs.upgrade_talent_cfg
  local talent_lv = mArgs.talent_lv
  if talent_lv then
    for lv = 1, talent_lv do
      local talent_lv_cfg = upgrade_talent_cfg[lv]
      if talent_lv_cfg then
        local attr_id = talent_lv_cfg.AttrId
        if 0 == talent_lv_cfg.AttrType then
          attrs[attr_id].FIXED = attrs[attr_id].FIXED + talent_lv_cfg.AttrValue
        end
      end
    end
  end
  t.init_res(attrs, t.HERO_RES2MAX, t.HERO_INIT_ZERO_RES)
  return attrs
end

function t.get_monster_attrs(id, lv, base_attr, upgrade_attr)
  if not base_attr[id] then
    error("id not exist" .. id)
    return
  end
  local attrs = {}
  for k, v in pairs(t.ATTR_TYPE) do
    attrs[v] = init_single_attr()
  end
  for k, v in pairs(base_attr[id]) do
    local attr_id = CONFIG_NAME_ATTR_ID[k]
    if attr_id then
      local level_value = 0
      if upgrade_attr[id] and upgrade_attr[id][k] then
        level_value = upgrade_attr[id][k] * lv
      end
      attrs[attr_id].FIXED = v + level_value
    end
  end
  t.init_res(attrs, t.MONSTER_RES2MAX, t.MONSTER_INIT_ZERO_RES)
  return attrs
end

function t.get_monster_kv_attrs(id, lv, base_attr, upgrade_attr)
  if not base_attr[id] then
    error("id not exist" .. id)
    return
  end
  local attrs = {}
  for k, v in pairs(t.ATTR_TYPE) do
    attrs[v] = 0
  end
  for k, v in pairs(base_attr[id]) do
    local attr_id = CONFIG_NAME_ATTR_ID[k]
    if attr_id then
      local level_value = 0
      if upgrade_attr[id] and upgrade_attr[id][k] then
        level_value = upgrade_attr[id][k] * lv
      end
      attrs[attr_id] = v + level_value
    end
  end
  for k, v in pairs(t.MONSTER_RES2MAX) do
    if v > 0 then
      attrs[k] = attrs[v]
    end
  end
  return attrs
end

function t.get_max_strenge_val(base_strength_val, buddy_physique, bonus_val)
  local max_strenge_val = base_strength_val * (1 + buddy_physique * bonus_val)
  return max_strenge_val
end

t.CHAR_ABNORMAL_MAP = {
  [ATTR_TYPE.CHAR_ABNORMAL_BP1] = true,
  [ATTR_TYPE.CHAR_ABNORMAL_BP2] = true,
  [ATTR_TYPE.CHAR_ABNORMAL_BP3] = true,
  [ATTR_TYPE.CHAR_ABNORMAL_BP4] = true,
  [ATTR_TYPE.CHAR_ABNORMAL_BP5] = true,
  [ATTR_TYPE.CHAR_ABNORMAL_BP6] = true
}
t.ABNORMAL_STATUS = {
  CLOSE = 1,
  OPEN = 2,
  IMMUNITY = 3
}
t.ABNORMAL_DEFAULT_STATUS = {
  [ELEMENT_TYPE.BASE] = t.ABNORMAL_STATUS.CLOSE,
  [ELEMENT_TYPE.WATER] = t.ABNORMAL_STATUS.OPEN,
  [ELEMENT_TYPE.FIRE] = t.ABNORMAL_STATUS.OPEN,
  [ELEMENT_TYPE.THUNDER] = t.ABNORMAL_STATUS.OPEN,
  [ELEMENT_TYPE.LIGHT] = t.ABNORMAL_STATUS.OPEN,
  [ELEMENT_TYPE.DARK] = t.ABNORMAL_STATUS.OPEN
}
return t
