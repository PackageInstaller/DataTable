-- 不羁之兽
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill302200201 = oo.class(SkillBase)
function Skill302200201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill302200201:DoSkill(caster, target, data)
	-- 302200201
	self.order = self.order + 1
	self:OwnerAddBuffCount(SkillEffect[302200201], caster, self.card, data, 302200201,1,3)
	-- 302200203
	self.order = self.order + 1
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:AddBuff(SkillEffect[302200203], caster, target, data, 302200202,1)
	end
	-- 302200204
	self.order = self.order + 1
	self:AddBuff(SkillEffect[302200204], caster, self.card, data, 302200204)
end
