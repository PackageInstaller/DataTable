-- 天赋效果307304
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill307304 = oo.class(SkillBase)
function Skill307304:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill307304:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 307304
	if self:Rand(5000) then
		self:AddPhysicsShieldCount(SkillEffect[307304], caster, self.card, data, 2209,4,10)
	end
end
