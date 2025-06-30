---
--- 受击时，减少最终伤害${Params[1]}%
---
local Equip_12020004 = BaseClass("Equip_12020004", Skill)
local base = Skill

local function __init(self)
end

local function OnBattleStart(self)
    base.OnBattleStart(self)
    self.__snc:Inc(NumericType.FinalHurtAdd, self.Params[1])
end


Equip_12020004.__init = __init
Equip_12020004.OnBattleStart = OnBattleStart

return Equip_12020004