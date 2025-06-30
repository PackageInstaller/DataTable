---
--- 攻击力提升${Params[1]}
---
local Equip_11020103 = BaseClass("Equip_11020103", Skill)
local base = Skill

local function __init(self)
end

local function OnBattleStart(self)
    base.OnBattleStart(self)
    self.__snc:Inc(NumericType.AtkAdd, self.Params[1])
end


Equip_11020103.__init = __init
Equip_11020103.OnBattleStart = OnBattleStart

return Equip_11020103