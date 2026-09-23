-- 天赋效果307604
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill307604 = oo.class(SkillBase)
function Skill307604:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill307604:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 307604
	if self:Rand(5000) then
		self:DelBuff(SkillEffect[307604], caster, self.card, data, 3003,2)
	end
end
