-- 记录员
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4701101 = oo.class(SkillBase)
function Skill4701101:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill4701101:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4701101
	if self:Rand(3000) then
		self:DelBufferGroup(SkillEffect[4701101], caster, self.card, data, 1,5)
	end
end
