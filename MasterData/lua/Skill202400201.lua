-- 和音
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill202400201 = oo.class(SkillBase)
function Skill202400201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill202400201:DoSkill(caster, target, data)
	-- 202400201
	self.order = self.order + 1
	self:AddBuff(SkillEffect[202400201], caster, target, data, 202400201)
	-- 202400211
	self.order = self.order + 1
	self:AddNp(SkillEffect[202400211], caster, target, data, 2)
end
