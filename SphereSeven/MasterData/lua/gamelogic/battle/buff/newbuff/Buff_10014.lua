---
--- 攻击提升 攻击力提升50%
---
local Buff_10014 = BaseClass("Buff_10014",Buff)
local base = Buff

local function OnOccur(self)
    base.OnOccur(self)
    self.__tnc:Inc(NumericType.HitAdd,50)
end

local function OnRemoved(self)
    self.__tnc:Dec(NumericType.HitAdd,50)
    base.OnRemoved(self)
end

Buff_10014.OnOccur = OnOccur
Buff_10014.OnRemoved = OnRemoved

return Buff_10014