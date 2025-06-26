---
--- 物防和魔防提升${Params[1]}%
---
local Equip_12020003 = BaseClass("Equip_12020003", Skill)
local base = Skill

local function __init(self)
end

local function OnBattleStart(self)
    base.OnBattleStart(self)
    self.__snc:Inc(NumericType.DefPct, self.Params[1])
    self.__snc:Inc(NumericType.MagicDefPct, self.Params[1])
end


Equip_12020003.__init = __init
Equip_12020003.OnBattleStart = OnBattleStart

return Equip_12020003