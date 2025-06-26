---
--- 攻击提升 攻击力提升50%
---
local Buff_10019 = BaseClass("Buff_10019",Buff)
local base = Buff

local function OnOccur(self)
    base.OnOccur(self)
    self.__tcc:IncSpecialEffect(SpecialEffectType.ImmuneAllDeBuff)
end

local function OnRemoved(self)
    self.__tcc:DecSpecialEffect(SpecialEffectType.ImmuneAllDeBuff)
    base.OnRemoved(self)
end

Buff_10019.OnOccur = OnOccur
Buff_10019.OnRemoved = OnRemoved

return Buff_10019