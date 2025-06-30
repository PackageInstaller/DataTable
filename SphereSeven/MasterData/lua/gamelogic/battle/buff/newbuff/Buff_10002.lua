---
--- 攻击提升 攻击力提升50%
---
local Buff_10002 = BaseClass("Buff_10002",Buff)
local base = Buff

local function OnOccur(self)
    base.OnOccur(self)
    self.__tnc:Inc(NumericType.AtkPct,75)
end

local function OnRemoved(self)
    self.__tnc:Dec(NumericType.AtkPct,75)
    base.OnRemoved(self)
end

Buff_10002.OnOccur = OnOccur
Buff_10002.OnRemoved = OnRemoved

return Buff_10002