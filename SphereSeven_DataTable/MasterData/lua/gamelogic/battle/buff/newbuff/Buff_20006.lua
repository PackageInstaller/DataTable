---
--- 攻击提升 攻击力提升50%
---
local Buff_20006 = BaseClass("Buff_20006",Buff)
local base = Buff

local function OnOccur(self)
    base.OnOccur(self)
    self.__tnc:Dec(NumericType.ERistAdd,50)
end

local function OnRemoved(self)
    self.__tnc:Inc(NumericType.ERistAdd,50)
    base.OnRemoved(self)
end

Buff_20006.OnOccur = OnOccur
Buff_20006.OnRemoved = OnRemoved

return Buff_20006