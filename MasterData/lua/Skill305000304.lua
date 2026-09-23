-- SP昆仑3
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill305000304 = oo.class(SkillBase)
function Skill305000304:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill305000304:DoSkill(caster, target, data)
	-- 305000304
	self.order = self.order + 1
	self:AddBuff(SkillEffect[305000304], caster, self.card, data, 305000304)
	-- 305000314
	self.order = self.order + 1
	self:AddBuff(SkillEffect[305000314], caster, self.card, data, 305000314)
	-- 305000310
	self.order = self.order + 1
	self:ChangeSkill(SkillEffect[305000310], caster, self.card, data, 3,305000401)
	-- 305000214
	self.order = self.order + 1
	self:AddFury(SkillEffect[305000214], caster, self.card, data, 25,100)
end
