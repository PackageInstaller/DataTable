---
--- 攻击提升 攻击力提升50%
---
local Buff_10015 = BaseClass("Buff_10015",Buff)
local base = Buff

local function OnOccur(self)
    base.OnOccur(self)
    self.__tnc:Inc(NumericType.PryAdd,50)
end

local function OnRemoved(self)
    self.__tnc:Dec(NumericType.PryAdd,50)
    base.OnRemoved(self)
end

Buff_10015.OnOccur = OnOccur
Buff_10015.OnRemoved = OnRemoved

return Buff_10015