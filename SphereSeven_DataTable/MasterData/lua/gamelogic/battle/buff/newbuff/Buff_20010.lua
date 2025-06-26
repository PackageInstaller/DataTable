---
--- 攻击提升 攻击力提升50%
---
local Buff_20010 = BaseClass("Buff_20010",Buff)
local base = Buff

local function OnOccur(self)
    base.OnOccur(self)
end

local function OnRemoved(self)
    base.OnRemoved(self)
end

Buff_20010.OnOccur = OnOccur
Buff_20010.OnRemoved = OnRemoved

return Buff_20010