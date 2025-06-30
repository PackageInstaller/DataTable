---
--- 攻击提升 攻击力提升50%
---
local Buff_10025 = BaseClass("Buff_10025",Buff)
local base = Buff

local function OnOccur(self)
    base.OnOccur(self)
    self.__tnc:Inc(NumericType.AtkPct,50)
end

local function OnRemoved(self)
    self.__tnc:Dec(NumericType.AtkPct,50)
    base.OnRemoved(self)
end

Buff_10025.OnOccur = OnOccur
Buff_10025.OnRemoved = OnRemoved

return Buff_10025