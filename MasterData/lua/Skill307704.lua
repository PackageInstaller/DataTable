-- 清晰
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill307704 = oo.class(SkillBase)
function Skill307704:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill307704:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 307704
	if self:Rand(7500) then
		self:DelBuffQuality(SkillEffect[307704], caster, self.card, data, 2,1)
	end
end
