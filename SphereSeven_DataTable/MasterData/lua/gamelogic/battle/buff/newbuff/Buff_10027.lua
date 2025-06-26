---
--- 攻击提升 攻击力提升50%
---
local Buff_10027 = BaseClass("Buff_10027",Buff)
local base = Buff

local function OnOccur(self)
    base.OnOccur(self)
    self.Data.SrcUnit = self.SrcUnit
end

local function OnRemoved(self)

    base.OnRemoved(self)
end

Buff_10027.OnOccur = OnOccur
Buff_10027.OnRemoved = OnRemoved

return Buff_10027