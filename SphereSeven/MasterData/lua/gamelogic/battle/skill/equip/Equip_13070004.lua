---
--- 物防提升${Params[1]}%
---

local Equip_13070004 = BaseClass("Equip_13070004", Skill)
local base = Skill

local function __init(self)
end

local function OnBattleStart(self)
    base.OnBattleStart(self)
    self.__snc:Inc(NumericType.DefPct, self.Params[1])
end


Equip_13070004.__init = __init
Equip_13070004.OnBattleStart = OnBattleStart

return Equip_13070004