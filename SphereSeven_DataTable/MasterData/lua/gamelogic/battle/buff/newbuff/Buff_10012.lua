---
--- 攻击提升 攻击力提升50%
---
local Buff_10012 = BaseClass("Buff_10012",Buff)
local base = Buff

local function OnOccur(self)
    base.OnOccur(self)
    self.__tnc:Inc(NumericType.CriDamageAdd,50)
end

local function OnRemoved(self)
    self.__tnc:Dec(NumericType.CriDamageAdd,50)
    base.OnRemoved(self)
end

Buff_10012.OnOccur = OnOccur
Buff_10012.OnRemoved = OnRemoved

return Buff_10012