-- SP昆仑3
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill305000301 = oo.class(SkillBase)
function Skill305000301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill305000301:DoSkill(caster, target, data)
	-- 305000301
	self.order = self.order + 1
	self:AddBuff(SkillEffect[305000301], caster, self.card, data, 305000301)
	-- 305000311
	self.order = self.order + 1
	self:AddBuff(SkillEffect[305000311], caster, self.card, data, 305000311)
	-- 305000310
	self.order = self.order + 1
	self:ChangeSkill(SkillEffect[305000310], caster, self.card, data, 3,305000401)
	-- 305000211
	self.order = self.order + 1
	self:AddFury(SkillEffect[305000211], caster, self.card, data, 10,100)
end
