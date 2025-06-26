---
--- 攻击提升 攻击力提升50%
---
local Buff_10024 = BaseClass("Buff_10024",Buff)
local base = Buff

local function OnOccur(self)
    base.OnOccur(self)
end

local function OnRemoved(self)
    base.OnRemoved(self)
end

Buff_10024.OnOccur = OnOccur
Buff_10024.OnRemoved = OnRemoved

return Buff_10024