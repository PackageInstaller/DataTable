-- 密接和应
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4200402 = oo.class(SkillBase)
function Skill4200402:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill4200402:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4200402
	if self:Rand(3500) then
		self:AddNp(SkillEffect[4200402], caster, self.card, data, 10)
	end
end
