-- 天赋效果307602
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill307602 = oo.class(SkillBase)
function Skill307602:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill307602:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 307602
	if self:Rand(3000) then
		self:DelBuff(SkillEffect[307602], caster, self.card, data, 3003,2)
	end
end
