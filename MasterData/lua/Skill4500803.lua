-- 优化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4500803 = oo.class(SkillBase)
function Skill4500803:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill4500803:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4500803
	if self:Rand(4000) then
		self:DelBuffQuality(SkillEffect[4500803], caster, self.card, data, 2,2)
	end
end
