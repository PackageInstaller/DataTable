---
--- 暴击抗性提升${Params[1]}%
---
local Equip_13070104 = BaseClass("Equip_13070104", Skill)
local base = Skill

local function __init(self)
end

local function OnBattleStart(self)
    base.OnBattleStart(self)
    self.__snc:Inc(NumericType.AntiCriAdd, self.Params[1])
end


Equip_13070104.__init = __init
Equip_13070104.OnBattleStart = OnBattleStart

return Equip_13070104