---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by daiyi.
--- DateTime: 2019/4/22 16:52
--- 曹操
---
local FightSoul_30004 = BaseClass("FightSoul_30004",Skill)
local base = Skill

local function __init(self)
end

local function BeforeBeHit(self, activeSkillResult, atkUnit)
    base.BeforeBeHit(self, activeSkillResult, atkUnit)

    local characterComponent = self.SrcUnit:GetComponent("CharacterComponent")
    if characterComponent.IsHide > 0 then
        activeSkillResult.ExtraFinalDamagePct = activeSkillResult.ExtraFinalDamagePct - self.Params[1]
    end
end

FightSoul_30004.__init = __init
FightSoul_30004.BeforeBeHit = BeforeBeHit

return FightSoul_30004