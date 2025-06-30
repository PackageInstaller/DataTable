---
--- 魔蛛女皇
--- 攻击带有【中毒】的目标时，最终伤害提高${Params[1]}%，造成伤害后${Params[2]}%的概率为目标添加${Params[3]}个${Params[4]}回合随机异常状态。
--- 免疫【中毒】。
--- *随机异常范围：攻击降低，物防降低，术防降低，速度降低，精准降低，耐性降低，命中降低，回复禁止，强化禁止，拘束，麻痹，标靶，中毒。

local Skill_114204 = BaseClass("Skill_114204", Skill)
local base = Skill

Skill_114204.RandomDebufList = 
{
    { BuffId = BattleBuffType.AtkDecrease },
    { BuffId = BattleBuffType.DefDecrease },
    { BuffId = BattleBuffType.MagicDefDecrease },
    { BuffId = BattleBuffType.SpeedDecrease },
    { BuffId = BattleBuffType.EAccDecrease },
    { BuffId = BattleBuffType.EResistDecrease },
    { BuffId = BattleBuffType.HitDecrease },
    { BuffId = BattleBuffType.HealDisable },
    { BuffId = BattleBuffType.BuffDisable },
    { BuffId = BattleBuffType.PassiveDisable },
    { BuffId = BattleBuffType.Poison },
    { BuffId = BattleBuffType.Vulnerable },
    { BuffId = BattleBuffType.Paralysis },
    { BuffId = BattleBuffType.Restraint },
}

local function __init(self)
    self.Data.reduceSpeed = 0
end

local function BeforeHit(self, activeSkillResult, targetUnit)
    base.BeforeHit(self, activeSkillResult, targetUnit)

    if targetUnit:GetComponent("BuffComponent"):HasBuffId(BattleBuffType.Poison) then
        activeSkillResult.ExtraFinalDamagePct = activeSkillResult.ExtraFinalDamagePct + self.Params[1]
    end

    if BattleUtil.IsPctProbHit(self.Params[2]) then
        local randomBuffs = table.randtake(Skill_114204.RandomDebufList, self.Params[3])
        for _, randomBuff in pairs(randomBuffs) do
            table.insert(activeSkillResult.Buffs, ActiveSkillBuff.New(randomBuff.BuffId, self.Params[4]))
        end
    end
end

local function OnPassiveSkillEnabled(self)
    base.OnPassiveSkillEnabled(self)
    self.__scc:IncImmuneDeBuff(BattleBuffType.Poison)
end

local function OnPassiveSkillDisabled(self)
    base.OnPassiveSkillDisabled(self)
    self.__scc:DecImmuneDeBuff(BattleBuffType.Poison)
end

local function OnBattleStart(self)
    base.OnBattleStart(self)
    self:OnPassiveSkillEnabled()
end


Skill_114204.__init = __init
Skill_114204.OnPassiveSkillEnabled = OnPassiveSkillEnabled
Skill_114204.OnPassiveSkillDisabled = OnPassiveSkillDisabled
Skill_114204.OnBattleStart = OnBattleStart
Skill_114204.BeforeHit = BeforeHit

return Skill_114204