-- 天赋效果307302
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill307302 = oo.class(SkillBase)
function Skill307302:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill307302:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 307302
	if self:Rand(3000) then
		self:AddPhysicsShieldCount(SkillEffect[307302], caster, self.card, data, 2209,4,10)
	end
end
