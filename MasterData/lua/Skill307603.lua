-- 天赋效果307603
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill307603 = oo.class(SkillBase)
function Skill307603:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill307603:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 307603
	if self:Rand(4000) then
		self:DelBuff(SkillEffect[307603], caster, self.card, data, 3003,2)
	end
end
