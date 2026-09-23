-- 吸收
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill316002 = oo.class(SkillBase)
function Skill316002:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill316002:OnAfterHurt(caster, target, data)
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
	-- 316002
	self:Cure(SkillEffect[316002], caster, self.card, data, 5,0.08)
end
