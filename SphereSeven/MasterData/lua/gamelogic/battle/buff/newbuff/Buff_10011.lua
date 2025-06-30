---
--- 攻击提升 攻击力提升50%
---
local Buff_10011 = BaseClass("Buff_10011",Buff)
local base = Buff

local function OnOccur(self)
    base.OnOccur(self)
    self.__tnc:Inc(NumericType.CriAdd,50)
end

local function OnRemoved(self)
    self.__tnc:Dec(NumericType.CriAdd,50)
    base.OnRemoved(self)
end

Buff_10011.OnOccur = OnOccur
Buff_10011.OnRemoved = OnRemoved

return Buff_10011