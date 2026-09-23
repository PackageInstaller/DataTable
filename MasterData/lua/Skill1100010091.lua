-- 攻击敌人后有30%概率治疗自身10%的耐久
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100010091 = oo.class(SkillBase)
function Skill1100010091:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill1100010091:OnAfterHurt(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 1100010091
	if self:Rand(3000) then
		self:Cure(SkillEffect[1100010091], caster, self.card, data, 6,0.1)
	end
end
