---
--- 暴击抗性提升${Params[1]}%，受到的暴击伤害减少${Params[2]}%
---

local Equip_13070105 = BaseClass("Equip_13070105", Skill)
local base = Skill

local function __init(self)
end

local function OnBattleStart(self)
    base.OnBattleStart(self)
    self.__snc:Inc(NumericType.AntiCriAdd, self.Params[1])
    self.__snc:Inc(NumericType.CriFinalHurtAdd, self.Params[2])
end


Equip_13070105.__init = __init
Equip_13070105.OnBattleStart = OnBattleStart

return Equip_13070105