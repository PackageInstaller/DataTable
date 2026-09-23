-- 赫格尼技能2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill603200202 = oo.class(SkillBase)
function Skill603200202:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill603200202:DoSkill(caster, target, data)
	-- 603200221
	self.order = self.order + 1
	self:OwnerAddBuffCount(SkillEffect[603200221], caster, self.card, data, 4603201,1,10)
	-- 603200202
	self.order = self.order + 1
	self:AddSp(SkillEffect[603200202], caster, self.card, data, 15)
	-- 603200211
	self.order = self.order + 1
	self:AddNp(SkillEffect[603200211], caster, self.card, data, 10)
end
