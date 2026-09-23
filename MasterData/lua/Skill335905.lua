-- 夜暝2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill335905 = oo.class(SkillBase)
function Skill335905:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合结束时
function Skill335905:OnRoundOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 335905
	if self:Rand(2000) then
		self:ExtraRound(SkillEffect[335905], caster, self.card, data, nil)
	end
end
