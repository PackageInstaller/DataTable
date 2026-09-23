-- 天赋效果306901
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill306901 = oo.class(SkillBase)
function Skill306901:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 治疗时
function Skill306901:OnCure(caster, target, data)
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
	-- 306901
	if self:Rand(2000) then
		self:AddLightShieldCount(SkillEffect[306901], caster, target, data, 2309,2,10)
	end
end
