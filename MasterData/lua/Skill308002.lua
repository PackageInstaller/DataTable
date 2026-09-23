-- 天赋效果308002
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill308002 = oo.class(SkillBase)
function Skill308002:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 治疗时
function Skill308002:OnCure(caster, target, data)
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
	-- 308002
	if self:Rand(3000) then
		self:DelBuffQuality(SkillEffect[308002], caster, self.card, data, 2,1)
	end
end
