-- 天赋效果307303
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill307303 = oo.class(SkillBase)
function Skill307303:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill307303:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 307303
	if self:Rand(4000) then
		self:AddPhysicsShieldCount(SkillEffect[307303], caster, self.card, data, 2209,4,10)
	end
end
