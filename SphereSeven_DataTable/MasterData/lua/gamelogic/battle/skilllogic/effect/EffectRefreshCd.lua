


local EffectBase = require "GameLogic.Battle.SkillLogic.Effect.EffectBase"
local EffectRefreshCd = BaseClass("EffectRefreshCd", EffectBase)

local function Run(self, skill, targetUnit, activeSkillResult)
    local skillComponent = targetUnit:GetComponent("SkillComponent")
    if self.Params[1] == BattleEffectRefreshCdType.GeneralAtk then
        skillComponent.ActiveSkills[skillComponent.GeneralAtkId]:SetCooldownTurn(0)
    elseif self.Params[1] == BattleEffectRefreshCdType.Skill1 then
        skillComponent.ActiveSkills[skillComponent.Skill1Id]:SetCooldownTurn(0)
    elseif self.Params[1] == BattleEffectRefreshCdType.Skill2 then
        skillComponent.ActiveSkills[skillComponent.Skill2Id]:SetCooldownTurn(0)
    elseif self.Params[1] == BattleEffectRefreshCdType.All then
        skillComponent.ActiveSkills[skillComponent.GeneralAtkId]:SetCooldownTurn(0)
        skillComponent.ActiveSkills[skillComponent.Skill1Id]:SetCooldownTurn(0)
        skillComponent.ActiveSkills[skillComponent.Skill2Id]:SetCooldownTurn(0)
    elseif self.Params[1] == BattleEffectRefreshCdType.CurrentSkill then
        skill:SetCooldownTurn(0)
        skill.DoNotCd = true
    end
end

EffectRefreshCd.Run = Run

return EffectRefreshCd