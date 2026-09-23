-- 天赋效果306801
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill306801 = oo.class(SkillBase)
function Skill306801:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 治疗时
function Skill306801:OnCure(caster, target, data)
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
	-- 306801
	if self:Rand(2000) then
		self:AddPhysicsShieldCount(SkillEffect[306801], caster, target, data, 2209,2,10)
	end
end
