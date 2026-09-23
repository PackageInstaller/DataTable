-- 密接和应
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4200405 = oo.class(SkillBase)
function Skill4200405:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill4200405:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4200405
	if self:Rand(5000) then
		self:AddNp(SkillEffect[4200405], caster, self.card, data, 10)
	end
end
