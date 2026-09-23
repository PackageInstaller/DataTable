-- 赫格尼技能2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill603200201 = oo.class(SkillBase)
function Skill603200201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill603200201:DoSkill(caster, target, data)
	-- 603200221
	self.order = self.order + 1
	self:OwnerAddBuffCount(SkillEffect[603200221], caster, self.card, data, 4603201,1,10)
	-- 603200201
	self.order = self.order + 1
	self:AddSp(SkillEffect[603200201], caster, self.card, data, 10)
	-- 603200211
	self.order = self.order + 1
	self:AddNp(SkillEffect[603200211], caster, self.card, data, 10)
end
