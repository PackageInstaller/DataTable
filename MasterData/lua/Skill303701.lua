-- 天赋效果303701
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill303701 = oo.class(SkillBase)
function Skill303701:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 治疗时
function Skill303701:OnCure(caster, target, data)
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
	-- 303701
	if self:Rand(1000) then
		self:AddBuff(SkillEffect[303701], caster, target, data, 4304,1)
	end
end
