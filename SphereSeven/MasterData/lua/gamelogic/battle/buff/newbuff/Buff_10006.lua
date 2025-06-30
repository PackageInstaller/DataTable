---
--- 攻击提升 攻击力提升50%
---
local Buff_10006 = BaseClass("Buff_10006",Buff)
local base = Buff

local function OnOccur(self)
    base.OnOccur(self)
    self.__tnc:Inc(NumericType.MagicDefPct,90)
end

local function OnRemoved(self)
    self.__tnc:Dec(NumericType.MagicDefPct,90)
    base.OnRemoved(self)
end

Buff_10006.OnOccur = OnOccur
Buff_10006.OnRemoved = OnRemoved

return Buff_10006