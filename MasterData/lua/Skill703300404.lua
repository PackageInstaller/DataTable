-- 阿努比斯技能4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill703300404 = oo.class(SkillBase)
function Skill703300404:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill703300404:DoSkill(caster, target, data)
	-- 13011
	self.order = self.order + 1
	local targets = SkillFilter:Rand(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:DamageLight(SkillEffect[13011], caster, target, data, 1,1)
	end
	-- 13012
	self.order = self.order + 1
	local targets = SkillFilter:Rand(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:DamageLight(SkillEffect[13012], caster, target, data, 1,1)
	end
	-- 13013
	self.order = self.order + 1
	local targets = SkillFilter:Rand(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:DamageLight(SkillEffect[13013], caster, target, data, 1,1)
	end
	-- 13014
	self.order = self.order + 1
	local targets = SkillFilter:Rand(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:DamageLight(SkillEffect[13014], caster, target, data, 1,1)
	end
	-- 13015
	self.order = self.order + 1
	local targets = SkillFilter:Rand(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:DamageLight(SkillEffect[13015], caster, target, data, 1,1)
	end
end
