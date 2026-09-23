-- 万华2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill780400201 = oo.class(SkillBase)
function Skill780400201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill780400201:DoSkill(caster, target, data)
	-- 780400201
	self.order = self.order + 1
	self:AddBuff(SkillEffect[780400201], caster, self.card, data, 780400201)
end
