-- 赫格尼技能2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill603200203 = oo.class(SkillBase)
function Skill603200203:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill603200203:DoSkill(caster, target, data)
	-- 603200222
	self.order = self.order + 1
	self:OwnerAddBuffCount(SkillEffect[603200222], caster, self.card, data, 4603201,2,10)
	-- 603200203
	self.order = self.order + 1
	self:AddSp(SkillEffect[603200203], caster, self.card, data, 20)
	-- 603200212
	self.order = self.order + 1
	self:AddNp(SkillEffect[603200212], caster, self.card, data, 15)
end
