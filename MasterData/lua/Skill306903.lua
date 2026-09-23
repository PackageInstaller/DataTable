-- 天赋效果306903
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill306903 = oo.class(SkillBase)
function Skill306903:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 治疗时
function Skill306903:OnCure(caster, target, data)
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
	-- 306903
	if self:Rand(4000) then
		self:AddLightShieldCount(SkillEffect[306903], caster, target, data, 2309,2,10)
	end
end
