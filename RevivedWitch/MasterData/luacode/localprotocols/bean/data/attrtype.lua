-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/bean/data/attrtype.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local AttrType = dataclass("AttrType")
AttrType.HP = 10
AttrType.MAX_HP = 20
AttrType.ATTACK = 30
AttrType.MAGIC_ATTACK = 40
AttrType.DEFEND = 50
AttrType.MAGIC_DEFEND = 60
AttrType.SPEED = 70
AttrType.DAMAGE = 80
AttrType.PHYSICALBONUS = 90
AttrType.PHYSICALREDUCE = 100
AttrType.MAGICBONUS = 110
AttrType.MAGICREDUCE = 120
AttrType.CRITRATE = 130
AttrType.CRITDEGREE = 140
AttrType.MAGICCRITRATE = 150
AttrType.MAGICCRITRATEDEGREE = 160
AttrType.ATTACKSPEED = 170
AttrType.EVASION = 180
AttrType.PHYSICALLIFESTEAL = 190
AttrType.MAGICLIFESTEAL = 200
AttrType.PHYSICALBLOCK = 210
AttrType.MAGICBLOCK = 220
AttrType.TOTALDMG = 230
AttrType.MAGICEVASION = 240
AttrType.PHYSICALDEFBREAK = 250
AttrType.MAGICDEFBREAK = 260
AttrType.CRITRATERESISTANCE = 270
AttrType.EXTRAPHYSICALDAMAGE = 290
AttrType.EXTRAMAGICDAMAGE = 300
AttrType.CURATIVEBONUS = 310
AttrType.ACCURACY = 320
AttrType.ORDER_PWR = 330
AttrType.CHAOS_PWR = 340
AttrType.DMG_SKILL_ADD = 350
AttrType.HEAL_SKILL_ADD = 360
AttrType.SKILL_DAMAGE = 370
AttrType.ORDER_COST = 380
AttrType.CHAOS_COST = 390
AttrType.DISPEL_BUFF_NUM = 400
AttrType.MONSTER_TYPE = 410
AttrType.SHEILD = 420
AttrType.COMBO_NUM = 430
AttrType.COOL_DOWN_REDUCE = 440
AttrType.PASSIVE_SKILL = 450
AttrType.IS_DEBUFF = 460
AttrType.ORDER_COST_REDUCE = 470
AttrType.CHAOS_COST_REDUCE = 480
AttrType.BOSS_COMBO_NUM = 490
AttrType.CRIT_LEVEL = 500
AttrType.CRIT_DEGREE_LEVEL = 510
AttrType.HEALING_POWER = 530
AttrType.BASIC_ATTACK_PERCENT = 550
AttrType.BASIC_DEFEND_PERCENT = 560
AttrType.BASIC_MAGIC_DEFEND_PERCENT = 570
AttrType.BASIC_MAX_HP_PERCENT = 580
AttrType.COMBORATE1 = 670
AttrType.COMBORATE2 = 680
AttrType.CRITDEGREERESISTANCE = 830
AttrType.DAMAGE_REDUCE = 1060
AttrType.RUNE_LV = 1070
AttrType.Ctor = function(self)
  -- function num : 0_0
end

AttrType.Marshal = function(self, data)
  -- function num : 0_1
end

AttrType.Unmarshal = function(self, data)
  -- function num : 0_2
end

AttrType.CheckVariable = function(self)
  -- function num : 0_3
  return true
end

return AttrType

