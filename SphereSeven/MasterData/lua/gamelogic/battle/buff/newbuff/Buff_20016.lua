---
--- 攻击提升 攻击力提升50%
---
local Buff_20016 = BaseClass("Buff_20016",Buff)
local base = Buff

local function OnOccur(self)
    base.OnOccur(self)
    self.__tnc:Dec(NumericType.PryAdd,15)
end

local function OnRemoved(self)
    self.__tnc:Inc(NumericType.PryAdd,15)
    base.OnRemoved(self)
end

Buff_20016.OnOccur = OnOccur
Buff_20016.OnRemoved = OnRemoved

return Buff_20016