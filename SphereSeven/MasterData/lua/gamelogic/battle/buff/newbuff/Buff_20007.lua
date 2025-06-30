---
--- 攻击提升 攻击力提升50%
---
local Buff_20007 = BaseClass("Buff_20007",Buff)
local base = Buff

local function OnOccur(self)
    base.OnOccur(self)
    self.__tnc:Dec(NumericType.HitAdd,50)
end

local function OnRemoved(self)
    self.__tnc:Inc(NumericType.HitAdd,50)
    base.OnRemoved(self)
end

Buff_20007.OnOccur = OnOccur
Buff_20007.OnRemoved = OnRemoved

return Buff_20007