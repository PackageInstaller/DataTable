--  袅韵2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill202300201 = oo.class(SkillBase)
function Skill202300201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill202300201:DoSkill(caster, target, data)
	-- 202300201
	self.order = self.order + 1
	self:AddBuff(SkillEffect[202300201], caster, self.card, data, 202300201)
	-- 202300206
	self.order = self.order + 1
	self:AddBuff(SkillEffect[202300206], caster, self.card, data, 402900201,1)
end
