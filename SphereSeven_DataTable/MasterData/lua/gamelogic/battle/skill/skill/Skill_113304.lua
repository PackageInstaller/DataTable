---
--- 光明使者
--  攻击暗属性敌人时，最终伤害+${Params[1]}%。赋予友军治疗时，增加${Params[2]}%行动条。

local Skill_113304 = BaseClass("Skill_113304", Skill)
local base = Skill

local function __init(self)

end

local function BeforeHit(self, activeSkillResult, targetUnit)
    base.OnUnitSelfTurnStart(self, activeSkillResult, targetUnit)

    if self.IsDisabled then
        return
    end
    
    if activeSkillResult.HealHp > 0 and BattleUtil.IsFriend(self.SrcUnit, targetUnit) then
        targetUnit:GetComponent("BattleUnitComponent"):ChangeActValue(self.Params[2])
    elseif activeSkillResult.FeixiaoDamage.Value > 0 and not BattleUtil.IsFriend(self.SrcUnit, targetUnit) then
        activeSkillResult.ExtraFinalDamagePct = activeSkillResult.ExtraFinalDamagePct + self.Params[1]
    end

end

Skill_113304.__init = __init
Skill_113304.BeforeHit = BeforeHit

return Skill_113304