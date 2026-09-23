-- 天赋效果306804
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill306804 = oo.class(SkillBase)
function Skill306804:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 治疗时
function Skill306804:OnCure(caster, target, data)
	-- 8071
	if SkillJudger:TargetIsFriend(self, caster, target, true) then
	else
		return
	end
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 306804
	if self:Rand(5000) then
		self:AddPhysicsShieldCount(SkillEffect[306804], caster, target, data, 2209,2,10)
	end
end
