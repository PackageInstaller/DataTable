---
--- 攻击力提升${Params[1]}%
---
local Equip_11010003 = BaseClass("Equip_11010003", Skill)
local base = Skill

local function __init(self)
end

local function OnBattleStart(self)
    base.OnBattleStart(self)
    self.__snc:Inc(NumericType.AtkPct, self.Params[1])
end


Equip_11010003.__init = __init
Equip_11010003.OnBattleStart = OnBattleStart

return Equip_11010003