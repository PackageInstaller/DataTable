---
--- 攻击提升 攻击力提升50%
---
local Buff_20005 = BaseClass("Buff_20005",Buff)
local base = Buff

local function OnOccur(self)
    base.OnOccur(self)
    self.__tnc:Dec(NumericType.EAccAdd,50)
end

local function OnRemoved(self)
    self.__tnc:Inc(NumericType.EAccAdd,50)
    base.OnRemoved(self)
end

Buff_20005.OnOccur = OnOccur
Buff_20005.OnRemoved = OnRemoved

return Buff_20005