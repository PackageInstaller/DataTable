---
--- 攻击提升 攻击力提升50%
---
local Buff_10009 = BaseClass("Buff_10009",Buff)
local base = Buff

local function OnOccur(self)
    base.OnOccur(self)
    self.__tnc:Inc(NumericType.EAccAdd,50)
end

local function OnRemoved(self)
    self.__tnc:Dec(NumericType.EAccAdd,50)
    base.OnRemoved(self)
end

Buff_10009.OnOccur = OnOccur
Buff_10009.OnRemoved = OnRemoved

return Buff_10009