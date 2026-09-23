-- 终结加深
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill318602 = oo.class(SkillBase)
function Skill318602:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 驱散buff时
function Skill318602:OnDelBuff(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 318602
	self:AddBuff(SkillEffect[318602], caster, self.card, data, 318602)
end
