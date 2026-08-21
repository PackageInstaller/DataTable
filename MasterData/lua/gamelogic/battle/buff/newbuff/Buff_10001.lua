---
--- 攻击提升 攻击力提升50%
---
local Buff_10001 = BaseClass("Buff_10001",Buff)
local base = Buff

local function OnOccur(self)
    base.OnOccur(self)
    self.__tnc:Inc(NumericType.AtkPct,50)
end

local function OnRemoved(self)
    self.__tnc:Dec(NumericType.AtkPct,50)
    base.OnRemoved(self)
end

Buff_10001.OnOccur = OnOccur
Buff_10001.OnRemoved = OnRemoved

return Buff_10001