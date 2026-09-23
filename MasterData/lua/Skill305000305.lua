-- SP昆仑3
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill305000305 = oo.class(SkillBase)
function Skill305000305:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill305000305:DoSkill(caster, target, data)
	-- 305000305
	self.order = self.order + 1
	self:AddBuff(SkillEffect[305000305], caster, self.card, data, 305000305)
	-- 305000315
	self.order = self.order + 1
	self:AddBuff(SkillEffect[305000315], caster, self.card, data, 305000315)
	-- 305000310
	self.order = self.order + 1
	self:ChangeSkill(SkillEffect[305000310], caster, self.card, data, 3,305000401)
	-- 305000215
	self.order = self.order + 1
	self:AddFury(SkillEffect[305000215], caster, self.card, data, 30,100)
end
