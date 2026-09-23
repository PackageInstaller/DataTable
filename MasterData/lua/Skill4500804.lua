-- 优化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4500804 = oo.class(SkillBase)
function Skill4500804:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill4500804:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4500804
	if self:Rand(4500) then
		self:DelBuffQuality(SkillEffect[4500804], caster, self.card, data, 2,2)
	end
end
