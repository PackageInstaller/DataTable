-- 天赋效果308104
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill308104 = oo.class(SkillBase)
function Skill308104:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 治疗时
function Skill308104:OnCure(caster, target, data)
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
	-- 308104
	if self:Rand(5000) then
		self:DelBufferGroup(SkillEffect[308104], caster, self.card, data, 3,1)
	end
end
