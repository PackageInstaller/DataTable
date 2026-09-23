-- 天赋效果307301
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill307301 = oo.class(SkillBase)
function Skill307301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill307301:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 307301
	if self:Rand(2000) then
		self:AddPhysicsShieldCount(SkillEffect[307301], caster, self.card, data, 2209,4,10)
	end
end
