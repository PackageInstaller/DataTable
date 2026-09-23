-- 毁灭
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill400500305 = oo.class(SkillBase)
function Skill400500305:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill400500305:DoSkill(caster, target, data)
	-- 12401
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12401], caster, target, data, 0.3,1)
	-- 12402
	self.order = self.order + 1
	local targets = SkillFilter:Rand(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:DamageLight(SkillEffect[12402], caster, target, data, 0.3,1)
	end
	-- 12405
	self.order = self.order + 1
	local targets = SkillFilter:Rand(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:DamageLight(SkillEffect[12405], caster, target, data, 0.3,1)
	end
	-- 12406
	self.order = self.order + 1
	local targets = SkillFilter:Rand(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:DamageLight(SkillEffect[12406], caster, target, data, 0.3,1)
	end
	-- 12403
	self.order = self.order + 1
	local targets = SkillFilter:All(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:DamagePhysics(SkillEffect[12403], caster, target, data, 0.25,2)
	end
	-- 12404
	self.order = self.order + 1
	local targets = SkillFilter:All(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:DamageLight(SkillEffect[12404], caster, target, data, 0.5,1)
	end
end
