-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/bean/protocol/login/effecttype.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local EffectType = dataclass("EffectType")
EffectType.HP_ABL = 11
EffectType.HP_PCT = 12
EffectType.MAX_HP_ABL = 21
EffectType.MAX_HP_PCT = 22
EffectType.ATTACK_ABL = 31
EffectType.ATTACK_PCT = 32
EffectType.MAGIC_ATTACK_ABL = 41
EffectType.MAGIC_ATTACK_PCT = 42
EffectType.DEFEND_ABL = 51
EffectType.DEFEND_PCT = 52
EffectType.MAGIC_DEFEND_ABL = 61
EffectType.MAGIC_DEFEND_PCT = 62
EffectType.SPEED_ABL = 71
EffectType.SPEED_PCT = 72
EffectType.DAMAGE_ABL = 81
EffectType.DAMAGE_PCT = 82
EffectType.PHYSICALBONUS_ABL = 91
EffectType.PHYSICALBONUS_PCT = 92
EffectType.PHYSICALREDUCE_ABL = 101
EffectType.PHYSICALREDUCE_PCT = 102
EffectType.MAGICBONUS_ABL = 111
EffectType.MAGICBONUS_PCT = 112
EffectType.MAGICREDUCE_ABL = 121
EffectType.MAGICREDUCE_PCT = 122
EffectType.CRITRATE_ABL = 131
EffectType.CRITRATE_PCT = 132
EffectType.CRITDEGREE_ABL = 141
EffectType.CRITDEGREE_PCT = 142
EffectType.MAGICCRITRATE_ABL = 151
EffectType.MAGICCRITRATE_PCT = 152
EffectType.MAGICCRITRATEDEGREE_ABL = 161
EffectType.MAGICCRITRATEDEGREE_PCT = 162
EffectType.ATTACKSPEED_ABL = 171
EffectType.ATTACKSPEED_PCT = 172
EffectType.EVASION_ABL = 181
EffectType.EVASION_PCT = 182
EffectType.PHYSICALLIFESTEAL_ABL = 191
EffectType.PHYSICALLIFESTEAL_PCT = 192
EffectType.MAGICLIFESTEAL_ABL = 201
EffectType.MAGICLIFESTEAL_PCT = 202
EffectType.PHYSICALBLOCK_ABL = 211
EffectType.PHYSICALBLOCK_PCT = 212
EffectType.MAGICBLOCK_ABL = 221
EffectType.MAGICBLOCK_PCT = 222
EffectType.TOTALDMG_ABL = 231
EffectType.TOTALDMG_PCT = 232
EffectType.MAGICEVASION_ABL = 241
EffectType.MAGICEVASION_PCT = 242
EffectType.PHYSICALDEFBREAK_ABL = 251
EffectType.PHYSICALDEFBREAK_PCT = 252
EffectType.MAGICDEFBREAK_ABL = 261
EffectType.MAGICDEFBREAK_PCT = 262
EffectType.CRITRATERESISTANCE_ABL = 271
EffectType.CRITRATERESISTANCE_PCT = 272
EffectType.EXTRAPHYSICALDAMAGE_ABL = 291
EffectType.EXTRAPHYSICALDAMAGE_PCT = 292
EffectType.EXTRAMAGICDAMAGE_ABL = 301
EffectType.EXTRAMAGICDAMAGE_PCT = 302
EffectType.CURATIVEBONUS_ABL = 311
EffectType.CURATIVEBONUS_PCT = 312
EffectType.ACCURACY_ABL = 321
EffectType.ACCURACY_PCT = 322
EffectType.CRIT_LEVEL_ABL = 331
EffectType.CRIT_LEVEL_PCT = 332
EffectType.CRIT_DEGREE_LEVEL_ABL = 341
EffectType.CRIT_DEGREE_LEVEL_PCT = 342
EffectType.Ctor = function(self)
  -- function num : 0_0
end

EffectType.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

EffectType.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return EffectType

