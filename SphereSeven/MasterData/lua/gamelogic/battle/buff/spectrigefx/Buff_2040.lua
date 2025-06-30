---
---锁定

local Buff_2040 = BaseClass("Buff_2040",Buff)
local base = Buff

-- 要在闪避判定之前
local function BeforeHit(self,activeSkillResult)
    activeSkillResult.IsMustHit = true
end

Buff_2040.BeforeHit = BeforeHit

return Buff_2040


