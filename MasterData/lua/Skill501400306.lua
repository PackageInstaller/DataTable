-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill501400306 = oo.class(SkillBase)
function Skill501400306:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill501400306:DoSkill(caster, target, data)
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12004], caster, target, data, 0.25,4)
	self.order = self.order + 1
	local targets = SkillFilter:MinPercentHp(self, caster, target, 1,"hp",2)
	for i,target in ipairs(targets) do
		self:AddBuff(SkillEffect[4926], caster, target, data, 4906)
	end
	self.order = self.order + 1
	local targets = SkillFilter:All(self, caster, target, 2)
	for i,target in ipairs(targets) do
		self:DelBuff(SkillEffect[94001], caster, target, data, 6302)
	end
	self.order = self.order + 1
	self:AddBuff(SkillEffect[94002], caster, target, data, 6302)
end
