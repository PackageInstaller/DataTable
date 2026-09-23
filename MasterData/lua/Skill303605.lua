-- 天赋效果303605
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill303605 = oo.class(SkillBase)
function Skill303605:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 治疗时
function Skill303605:OnCure(caster, target, data)
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
	-- 303605
	if self:Rand(5000) then
		self:AddBuff(SkillEffect[303605], caster, target, data, 4204,1)
	end
end
