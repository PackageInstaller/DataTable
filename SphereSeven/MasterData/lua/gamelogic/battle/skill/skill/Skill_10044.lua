---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by daiyi.
--- DateTime: 2019/4/21 2:13
--- 忍辱负重
---
local Skill_10044 = BaseClass("Skill_10044",Skill)
local base = Skill

local function __init(self)
end

local function AfterHurt(self)
    base.AfterHurt(self)
    if self.IsDisabled then
        return
    end    
    if not BattleUtil.IsPctProbHit(self.Params[1]) then
        return
    end
    self.SrcUnit:GetComponent("BuffComponent"):CreateBuff(BattleBuffType.Hide,self.SkillId,self.SrcUnit,self.SrcUnit,self.Params[2])
end

Skill_10044.__init = __init
Skill_10044.AfterHurt = AfterHurt

return Skill_10044