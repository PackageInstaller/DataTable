---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by daiyi.
--- 仙奇之風
---【护盾】状态下的我方单位攻击时无视对方${Params[1]}%的双抗。
---
local Skill_10444 = BaseClass("Skill_10444",Skill)
local base = Skill

local function __init(self)
end

local function BeforeHitEvent(self, activeSkillResult, atkUnit, targetUnit)
    base.BeforeHitEvent(self, activeSkillResult, atkUnit, targetUnit)

    if self.IsDisabled then
        return
    end

    if not BattleUtil.IsFriend(self.SrcUnit, atkUnit) then
        return
    end

    if BattleUtil.IsFriend(self.SrcUnit, targetUnit) then
        return
    end

    activeSkillResult.ExtraIgnoreDef = activeSkillResult.ExtraIgnoreDef + self.Params[1]
    activeSkillResult.ExtraIgnoreMagicDef = activeSkillResult.ExtraIgnoreMagicDef + self.Params[1]
end


Skill_10444.__init = __init
Skill_10444.BeforeHitEvent = BeforeHitEvent

return Skill_10444