---
--- 攻击提升 攻击力提升50%
---
local Buff_10008 = BaseClass("Buff_10008",Buff)
local base = Buff

local function OnOccur(self)
    base.OnOccur(self)
    self.__tnc:Inc(NumericType.SpeedPct,45)
end

local function OnRemoved(self)
    self.__tnc:Dec(NumericType.SpeedPct,45)
    base.OnRemoved(self)
end

Buff_10008.OnOccur = OnOccur
Buff_10008.OnRemoved = OnRemoved

return Buff_10008