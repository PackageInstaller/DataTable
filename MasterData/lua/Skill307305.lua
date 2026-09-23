-- 天赋效果307305
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill307305 = oo.class(SkillBase)
function Skill307305:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill307305:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 307305
	if self:Rand(6000) then
		self:AddPhysicsShieldCount(SkillEffect[307305], caster, self.card, data, 2209,4,10)
	end
end
