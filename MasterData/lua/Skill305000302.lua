-- SP昆仑3
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill305000302 = oo.class(SkillBase)
function Skill305000302:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill305000302:DoSkill(caster, target, data)
	-- 305000302
	self.order = self.order + 1
	self:AddBuff(SkillEffect[305000302], caster, self.card, data, 305000302)
	-- 305000312
	self.order = self.order + 1
	self:AddBuff(SkillEffect[305000312], caster, self.card, data, 305000312)
	-- 305000310
	self.order = self.order + 1
	self:ChangeSkill(SkillEffect[305000310], caster, self.card, data, 3,305000401)
	-- 305000212
	self.order = self.order + 1
	self:AddFury(SkillEffect[305000212], caster, self.card, data, 15,100)
end
