---
--- 攻击提升 攻击力提升50%
---
local Buff_20002 = BaseClass("Buff_20002",Buff)
local base = Buff

local function OnOccur(self)
    base.OnOccur(self)
    self.__tnc:Dec(NumericType.DefPct,70)
end

local function OnRemoved(self)
    self.__tnc:Inc(NumericType.DefPct,70)
    base.OnRemoved(self)
end

Buff_20002.OnOccur = OnOccur
Buff_20002.OnRemoved = OnRemoved

return Buff_20002