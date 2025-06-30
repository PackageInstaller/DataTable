---
--- 攻击提升 攻击力提升50%
---
local Buff_10013 = BaseClass("Buff_10013",Buff)
local base = Buff

local function OnOccur(self)
    base.OnOccur(self)
    self.__tnc:Inc(NumericType.AntiCriAdd,50)
end

local function OnRemoved(self)
    self.__tnc:Dec(NumericType.AntiCriAdd,50)
    base.OnRemoved(self)
end

Buff_10013.OnOccur = OnOccur
Buff_10013.OnRemoved = OnRemoved

return Buff_10013