---会心
---
---
local Buff_2039 = BaseClass("Buff_2039",Buff)
local base = Buff

local function OnHit(self,activeSkillResult)
    activeSkillResult.IsMustCri = true
end

Buff_2039.OnHit = OnHit

return Buff_2039


