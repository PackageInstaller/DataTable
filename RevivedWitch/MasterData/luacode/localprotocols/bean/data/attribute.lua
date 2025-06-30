-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/bean/data/attribute.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Attribute = dataclass("Attribute")
Attribute.id = 0
Attribute.key = 0
Attribute.pos = 0
Attribute.skinId = 0
Attribute.level = 0
Attribute.x = 0
Attribute.y = 0
Attribute.z = 0
Attribute.havealternate = 0
Attribute.hp = 0
Attribute.hpmax = 0
Attribute.atk = 0
Attribute.def = 0
Attribute.matk = 0
Attribute.mdef = 0
Attribute.damage = 0
Attribute.physicalbonus = 0
Attribute.physicalreduce = 0
Attribute.magicbonus = 0
Attribute.magicreduce = 0
Attribute.physicalcritrate = 0
Attribute.physicalcritdegree = 0
Attribute.critratelevel = 0
Attribute.critdegreelevel = 0
Attribute.magiccritrate = 0
Attribute.magiccritratedegree = 0
Attribute.attackspeed = 0
Attribute.magiclifesteal = 0
Attribute.physicallifesteal = 0
Attribute.physicalevasion = 0
Attribute.magicevasion = 0
Attribute.physicalblock = 0
Attribute.magicblock = 0
Attribute.physicaldefbreak = 0
Attribute.magicdefbreak = 0
Attribute.critrateresistance = 0
Attribute.critdegreeresistance = 0
Attribute.extraphysicaldamage = 0
Attribute.extramagicdamage = 0
Attribute.curativebonus = 0
Attribute.accuracy = 0
Attribute.speed = 0
Attribute.healingpower = 0
Attribute.camp = 0
Attribute.baseskill = 0
Attribute.bosshpstr = ""
Attribute.assetbundlename = ""
Attribute.prefabname = ""
Attribute.comborate1 = 0
Attribute.comborate2 = 0
Attribute.nameTextId = 0
Attribute.evolutionLevel = 0
Attribute.exclusiveLevel = 0
Attribute.damagereduce = 0
Attribute.runelv = 0
Attribute.Ctor = function(self)
  -- function num : 0_0
  self.skilllist = {}
  self.bosshpstage = {}
  self.passiveskill = {}
  self.equipskilllist = {}
  self.runeskilllist = {}
  self.autoExploreSkill = {}
end

Attribute.Marshal = function(self, data)
  -- function num : 0_1 , upvalues : _ENV
  data.id = self.id
  data.key = self.key
  data.pos = self.pos
  data.skinId = self.skinId
  data.level = self.level
  data.x = self.x
  data.y = self.y
  data.z = self.z
  data.havealternate = self.havealternate
  data.hp = self.hp
  data.hpmax = self.hpmax
  data.atk = self.atk
  data.def = self.def
  data.matk = self.matk
  data.mdef = self.mdef
  data.damage = self.damage
  data.physicalbonus = self.physicalbonus
  data.physicalreduce = self.physicalreduce
  data.magicbonus = self.magicbonus
  data.magicreduce = self.magicreduce
  data.physicalcritrate = self.physicalcritrate
  data.physicalcritdegree = self.physicalcritdegree
  data.critratelevel = self.critratelevel
  data.critdegreelevel = self.critdegreelevel
  data.magiccritrate = self.magiccritrate
  data.magiccritratedegree = self.magiccritratedegree
  data.attackspeed = self.attackspeed
  data.magiclifesteal = self.magiclifesteal
  data.physicallifesteal = self.physicallifesteal
  data.physicalevasion = self.physicalevasion
  data.magicevasion = self.magicevasion
  data.physicalblock = self.physicalblock
  data.magicblock = self.magicblock
  data.physicaldefbreak = self.physicaldefbreak
  data.magicdefbreak = self.magicdefbreak
  data.critrateresistance = self.critrateresistance
  data.critdegreeresistance = self.critdegreeresistance
  data.extraphysicaldamage = self.extraphysicaldamage
  data.extramagicdamage = self.extramagicdamage
  data.curativebonus = self.curativebonus
  data.accuracy = self.accuracy
  data.speed = self.speed
  data.healingpower = self.healingpower
  data.camp = self.camp
  data.skilllist = {}
  for index,value in ipairs(self.skilllist) do
    -- DECOMPILER ERROR at PC96: Confused about usage of register: R7 in 'UnsetPending'

    (data.skilllist)[index] = {}
    ;
    ((self.skilllist)[index]):Marshal((data.skilllist)[index])
  end
  data.baseskill = self.baseskill
  data.bosshpstage = {}
  for index,value in ipairs(self.bosshpstage) do
    -- DECOMPILER ERROR at PC115: Confused about usage of register: R7 in 'UnsetPending'

    (data.bosshpstage)[index] = {}
    ;
    ((self.bosshpstage)[index]):Marshal((data.bosshpstage)[index])
  end
  data.bosshpstr = self.bosshpstr
  data.passiveskill = {}
  for index,value in ipairs(self.passiveskill) do
    -- DECOMPILER ERROR at PC134: Confused about usage of register: R7 in 'UnsetPending'

    (data.passiveskill)[index] = {}
    ;
    ((self.passiveskill)[index]):Marshal((data.passiveskill)[index])
  end
  data.equipskilllist = {}
  for index,value in ipairs(self.equipskilllist) do
    -- DECOMPILER ERROR at PC151: Confused about usage of register: R7 in 'UnsetPending'

    (data.equipskilllist)[index] = {}
    ;
    ((self.equipskilllist)[index]):Marshal((data.equipskilllist)[index])
  end
  data.runeskilllist = {}
  for index,value in ipairs(self.runeskilllist) do
    -- DECOMPILER ERROR at PC168: Confused about usage of register: R7 in 'UnsetPending'

    (data.runeskilllist)[index] = {}
    ;
    ((self.runeskilllist)[index]):Marshal((data.runeskilllist)[index])
  end
  data.assetbundlename = self.assetbundlename
  data.prefabname = self.prefabname
  data.comborate1 = self.comborate1
  data.comborate2 = self.comborate2
  data.nameTextId = self.nameTextId
  data.autoExploreSkill = {}
  for index,value in ipairs(self.autoExploreSkill) do
    -- DECOMPILER ERROR at PC195: Confused about usage of register: R7 in 'UnsetPending'

    (data.autoExploreSkill)[index] = {}
    ;
    ((self.autoExploreSkill)[index]):Marshal((data.autoExploreSkill)[index])
  end
  data.evolutionLevel = self.evolutionLevel
  data.exclusiveLevel = self.exclusiveLevel
  data.damagereduce = self.damagereduce
  data.runelv = self.runelv
end

Attribute.Unmarshal = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  self.id = data.id
  self.key = data.key
  self.pos = data.pos
  self.skinId = data.skinId
  self.level = data.level
  self.x = data.x
  self.y = data.y
  self.z = data.z
  self.havealternate = data.havealternate
  self.hp = data.hp
  self.hpmax = data.hpmax
  self.atk = data.atk
  self.def = data.def
  self.matk = data.matk
  self.mdef = data.mdef
  self.damage = data.damage
  self.physicalbonus = data.physicalbonus
  self.physicalreduce = data.physicalreduce
  self.magicbonus = data.magicbonus
  self.magicreduce = data.magicreduce
  self.physicalcritrate = data.physicalcritrate
  self.physicalcritdegree = data.physicalcritdegree
  self.critratelevel = data.critratelevel
  self.critdegreelevel = data.critdegreelevel
  self.magiccritrate = data.magiccritrate
  self.magiccritratedegree = data.magiccritratedegree
  self.attackspeed = data.attackspeed
  self.magiclifesteal = data.magiclifesteal
  self.physicallifesteal = data.physicallifesteal
  self.physicalevasion = data.physicalevasion
  self.magicevasion = data.magicevasion
  self.physicalblock = data.physicalblock
  self.magicblock = data.magicblock
  self.physicaldefbreak = data.physicaldefbreak
  self.magicdefbreak = data.magicdefbreak
  self.critrateresistance = data.critrateresistance
  self.critdegreeresistance = data.critdegreeresistance
  self.extraphysicaldamage = data.extraphysicaldamage
  self.extramagicdamage = data.extramagicdamage
  self.curativebonus = data.curativebonus
  self.accuracy = data.accuracy
  self.speed = data.speed
  self.healingpower = data.healingpower
  self.camp = data.camp
  for index,value in ipairs(data.skilllist) do
    -- DECOMPILER ERROR at PC94: Confused about usage of register: R7 in 'UnsetPending'

    (self.skilllist)[index] = {}
    ;
    ((data.skilllist)[index]):Unmarshal((self.skilllist)[index])
  end
  self.baseskill = data.baseskill
  for index,value in ipairs(data.bosshpstage) do
    -- DECOMPILER ERROR at PC111: Confused about usage of register: R7 in 'UnsetPending'

    (self.bosshpstage)[index] = {}
    ;
    ((data.bosshpstage)[index]):Unmarshal((self.bosshpstage)[index])
  end
  self.bosshpstr = data.bosshpstr
  for index,value in ipairs(data.passiveskill) do
    -- DECOMPILER ERROR at PC128: Confused about usage of register: R7 in 'UnsetPending'

    (self.passiveskill)[index] = {}
    ;
    ((data.passiveskill)[index]):Unmarshal((self.passiveskill)[index])
  end
  for index,value in ipairs(data.equipskilllist) do
    -- DECOMPILER ERROR at PC143: Confused about usage of register: R7 in 'UnsetPending'

    (self.equipskilllist)[index] = {}
    ;
    ((data.equipskilllist)[index]):Unmarshal((self.equipskilllist)[index])
  end
  for index,value in ipairs(data.runeskilllist) do
    -- DECOMPILER ERROR at PC158: Confused about usage of register: R7 in 'UnsetPending'

    (self.runeskilllist)[index] = {}
    ;
    ((data.runeskilllist)[index]):Unmarshal((self.runeskilllist)[index])
  end
  self.assetbundlename = data.assetbundlename
  self.prefabname = data.prefabname
  self.comborate1 = data.comborate1
  self.comborate2 = data.comborate2
  self.nameTextId = data.nameTextId
  for index,value in ipairs(data.autoExploreSkill) do
    -- DECOMPILER ERROR at PC183: Confused about usage of register: R7 in 'UnsetPending'

    (self.autoExploreSkill)[index] = {}
    ;
    ((data.autoExploreSkill)[index]):Unmarshal((self.autoExploreSkill)[index])
  end
  self.evolutionLevel = data.evolutionLevel
  self.exclusiveLevel = data.exclusiveLevel
  self.damagereduce = data.damagereduce
  self.runelv = data.runelv
end

Attribute.CheckVariable = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if type(self.id) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.id) = %s. number required.", type(self.id))
    return false
  end
  if type(self.key) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.key) = %s. number required.", type(self.key))
    return false
  end
  if type(self.pos) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.pos) = %s. number required.", type(self.pos))
    return false
  end
  if type(self.skinId) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.skinId) = %s. number required.", type(self.skinId))
    return false
  end
  if type(self.level) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.level) = %s. number required.", type(self.level))
    return false
  end
  if type(self.x) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.x) = %s. number required.", type(self.x))
    return false
  end
  if type(self.y) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.y) = %s. number required.", type(self.y))
    return false
  end
  if type(self.z) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.z) = %s. number required.", type(self.z))
    return false
  end
  if type(self.havealternate) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.havealternate) = %s. number required.", type(self.havealternate))
    return false
  end
  if type(self.hp) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.hp) = %s. number required.", type(self.hp))
    return false
  end
  if type(self.hpmax) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.hpmax) = %s. number required.", type(self.hpmax))
    return false
  end
  if type(self.atk) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.atk) = %s. number required.", type(self.atk))
    return false
  end
  if type(self.def) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.def) = %s. number required.", type(self.def))
    return false
  end
  if type(self.matk) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.matk) = %s. number required.", type(self.matk))
    return false
  end
  if type(self.mdef) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.mdef) = %s. number required.", type(self.mdef))
    return false
  end
  if type(self.damage) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.damage) = %s. number required.", type(self.damage))
    return false
  end
  if type(self.physicalbonus) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.physicalbonus) = %s. number required.", type(self.physicalbonus))
    return false
  end
  if type(self.physicalreduce) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.physicalreduce) = %s. number required.", type(self.physicalreduce))
    return false
  end
  if type(self.magicbonus) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.magicbonus) = %s. number required.", type(self.magicbonus))
    return false
  end
  if type(self.magicreduce) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.magicreduce) = %s. number required.", type(self.magicreduce))
    return false
  end
  if type(self.physicalcritrate) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.physicalcritrate) = %s. number required.", type(self.physicalcritrate))
    return false
  end
  if type(self.physicalcritdegree) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.physicalcritdegree) = %s. number required.", type(self.physicalcritdegree))
    return false
  end
  if type(self.critratelevel) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.critratelevel) = %s. number required.", type(self.critratelevel))
    return false
  end
  if type(self.critdegreelevel) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.critdegreelevel) = %s. number required.", type(self.critdegreelevel))
    return false
  end
  if type(self.magiccritrate) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.magiccritrate) = %s. number required.", type(self.magiccritrate))
    return false
  end
  if type(self.magiccritratedegree) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.magiccritratedegree) = %s. number required.", type(self.magiccritratedegree))
    return false
  end
  if type(self.attackspeed) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.attackspeed) = %s. number required.", type(self.attackspeed))
    return false
  end
  if type(self.magiclifesteal) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.magiclifesteal) = %s. number required.", type(self.magiclifesteal))
    return false
  end
  if type(self.physicallifesteal) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.physicallifesteal) = %s. number required.", type(self.physicallifesteal))
    return false
  end
  if type(self.physicalevasion) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.physicalevasion) = %s. number required.", type(self.physicalevasion))
    return false
  end
  if type(self.magicevasion) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.magicevasion) = %s. number required.", type(self.magicevasion))
    return false
  end
  if type(self.physicalblock) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.physicalblock) = %s. number required.", type(self.physicalblock))
    return false
  end
  if type(self.magicblock) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.magicblock) = %s. number required.", type(self.magicblock))
    return false
  end
  if type(self.physicaldefbreak) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.physicaldefbreak) = %s. number required.", type(self.physicaldefbreak))
    return false
  end
  if type(self.magicdefbreak) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.magicdefbreak) = %s. number required.", type(self.magicdefbreak))
    return false
  end
  if type(self.critrateresistance) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.critrateresistance) = %s. number required.", type(self.critrateresistance))
    return false
  end
  if type(self.critdegreeresistance) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.critdegreeresistance) = %s. number required.", type(self.critdegreeresistance))
    return false
  end
  if type(self.extraphysicaldamage) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.extraphysicaldamage) = %s. number required.", type(self.extraphysicaldamage))
    return false
  end
  if type(self.extramagicdamage) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.extramagicdamage) = %s. number required.", type(self.extramagicdamage))
    return false
  end
  if type(self.curativebonus) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.curativebonus) = %s. number required.", type(self.curativebonus))
    return false
  end
  if type(self.accuracy) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.accuracy) = %s. number required.", type(self.accuracy))
    return false
  end
  if type(self.speed) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.speed) = %s. number required.", type(self.speed))
    return false
  end
  if type(self.healingpower) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.healingpower) = %s. number required.", type(self.healingpower))
    return false
  end
  if type(self.camp) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.camp) = %s. number required.", type(self.camp))
    return false
  end
  if type(self.skilllist) ~= "table" then
    LogErrorFormat("LocalProtocols", "type error!type(self.skilllist) = %s. table required.", type(self.skilllist))
    return false
  end
  for index,value in ipairs(self.skilllist) do
    if type(R7_PC636) ~= "number" then
      LogErrorFormat(R7_PC636, "type error!type(self.skilllist -> value) = %s. number required.", type(R10_PC644))
      return false
    end
  end
  if type(self.baseskill) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.baseskill) = %s. number required.", type(self.baseskill))
    return false
  end
  if type(self.bosshpstage) ~= "table" then
    LogErrorFormat("LocalProtocols", "type error!type(self.bosshpstage) = %s. table required.", type(self.bosshpstage))
    return false
  end
  for index,value in ipairs(self.bosshpstage) do
    -- DECOMPILER ERROR at PC683: Overwrote pending register: R7 in 'AssignReg'

    -- DECOMPILER ERROR at PC688: Overwrote pending register: R7 in 'AssignReg'

    if type(R7_PC636) ~= "number" then
      LogErrorFormat(R7_PC636, "type error!type(self.bosshpstage -> value) = %s. number required.", type(R10_PC692))
      return false
    end
  end
  if type(self.bosshpstr) ~= "string" then
    LogErrorFormat("LocalProtocols", "type error!type(self.bosshpstr) = %s. string required.", type(self.bosshpstr))
    return false
  end
  if type(self.passiveskill) ~= "table" then
    LogErrorFormat("LocalProtocols", "type error!type(self.passiveskill) = %s. table required.", type(self.passiveskill))
    return false
  end
  for index,value in ipairs(self.passiveskill) do
    -- DECOMPILER ERROR at PC731: Overwrote pending register: R7 in 'AssignReg'

    -- DECOMPILER ERROR at PC736: Overwrote pending register: R7 in 'AssignReg'

    if type(R7_PC636) ~= "number" then
      LogErrorFormat(R7_PC636, "type error!type(self.passiveskill -> value) = %s. number required.", type(R10_PC740))
      return false
    end
  end
  if type(self.equipskilllist) ~= "table" then
    LogErrorFormat("LocalProtocols", "type error!type(self.equipskilllist) = %s. table required.", type(self.equipskilllist))
    return false
  end
  for index,value in ipairs(self.equipskilllist) do
    -- DECOMPILER ERROR at PC765: Overwrote pending register: R7 in 'AssignReg'

    -- DECOMPILER ERROR at PC770: Overwrote pending register: R7 in 'AssignReg'

    if type(R7_PC636) ~= "number" then
      LogErrorFormat(R7_PC636, "type error!type(self.equipskilllist -> value) = %s. number required.", type(R10_PC774))
      return false
    end
  end
  if type(self.runeskilllist) ~= "table" then
    LogErrorFormat("LocalProtocols", "type error!type(self.runeskilllist) = %s. table required.", type(self.runeskilllist))
    return false
  end
  for index,value in ipairs(self.runeskilllist) do
    -- DECOMPILER ERROR at PC799: Overwrote pending register: R7 in 'AssignReg'

    -- DECOMPILER ERROR at PC804: Overwrote pending register: R7 in 'AssignReg'

    if type(R7_PC636) ~= "number" then
      LogErrorFormat(R7_PC636, "type error!type(self.runeskilllist -> value) = %s. number required.", type(R10_PC808))
      return false
    end
  end
  if type(self.assetbundlename) ~= "string" then
    LogErrorFormat("LocalProtocols", "type error!type(self.assetbundlename) = %s. string required.", type(self.assetbundlename))
    return false
  end
  if type(self.prefabname) ~= "string" then
    LogErrorFormat("LocalProtocols", "type error!type(self.prefabname) = %s. string required.", type(self.prefabname))
    return false
  end
  if type(self.comborate1) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.comborate1) = %s. number required.", type(self.comborate1))
    return false
  end
  if type(self.comborate2) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.comborate2) = %s. number required.", type(self.comborate2))
    return false
  end
  if type(self.nameTextId) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.nameTextId) = %s. number required.", type(self.nameTextId))
    return false
  end
  if type(self.autoExploreSkill) ~= "table" then
    LogErrorFormat("LocalProtocols", "type error!type(self.autoExploreSkill) = %s. table required.", type(self.autoExploreSkill))
    return false
  end
  for index,value in ipairs(self.autoExploreSkill) do
    -- DECOMPILER ERROR at PC902: Overwrote pending register: R7 in 'AssignReg'

    if not value:CheckVariable() then
      return false
    end
  end
  if type(self.evolutionLevel) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.evolutionLevel) = %s. number required.", type(self.evolutionLevel))
    return false
  end
  if type(self.exclusiveLevel) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.exclusiveLevel) = %s. number required.", type(self.exclusiveLevel))
    return false
  end
  if type(self.damagereduce) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.damagereduce) = %s. number required.", type(self.damagereduce))
    return false
  end
  if type(self.runelv) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.runelv) = %s. number required.", type(self.runelv))
    return false
  end
  return true
end

return Attribute

