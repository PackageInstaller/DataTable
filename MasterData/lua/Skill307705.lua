-- 清晰
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill307705 = oo.class(SkillBase)
function Skill307705:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill307705:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 307705
	if self:Rand(9000) then
		self:DelBuffQuality(SkillEffect[307705], caster, self.card, data, 2,1)
	end
end
