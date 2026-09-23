-- 赫格尼技能2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill603200205 = oo.class(SkillBase)
function Skill603200205:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill603200205:DoSkill(caster, target, data)
	-- 603200222
	self.order = self.order + 1
	self:OwnerAddBuffCount(SkillEffect[603200222], caster, self.card, data, 4603201,2,10)
	-- 603200205
	self.order = self.order + 1
	self:AddSp(SkillEffect[603200205], caster, self.card, data, 30)
	-- 603200213
	self.order = self.order + 1
	self:AddNp(SkillEffect[603200213], caster, self.card, data, 20)
end
