---
--- 攻击力提升${Params[1]}
---
local Equip_11030103 = BaseClass("Equip_11030103", Skill)
local base = Skill

local function __init(self)
end

local function OnBattleStart(self)
    base.OnBattleStart(self)
    self.__snc:Inc(NumericType.AtkAdd, self.Params[1])
end


Equip_11030103.__init = __init
Equip_11030103.OnBattleStart = OnBattleStart

return Equip_11030103