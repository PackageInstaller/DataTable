---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by daiyi.
--- DateTime: 2019/7/12 15:48
--- 毁灭
---
local Buff_2014 = BaseClass("Buff_2014",Buff)
local base = Buff

local function OnHit(self,activeSkillResult)
    activeSkillResult.IsDevastate = true
end

Buff_2014.OnHit = OnHit

return Buff_2014