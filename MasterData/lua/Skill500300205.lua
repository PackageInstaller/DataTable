-- 蜂棘突刺
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill500300205 = oo.class(SkillBase)
function Skill500300205:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill500300205:DoSkill(caster, target, data)
	-- 12201
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12201], caster, target, data, 1,1)
	-- 8325
	self.order = self.order + 1
	self:AddValue(SkillEffect[8325], caster, target, data, "erduan",1)
	-- 12202
	self.order = self.order + 1
	local targets = SkillFilter:Rand(self, caster, target, 4)
	for i,target in ipairs(targets) do
		-- 12212
		self:DamagePhysics(SkillEffect[12212], caster, target, data, 1,1)
		-- 8325
		self:AddValue(SkillEffect[8325], caster, target, data, "erduan",1)
	end
end
-- 行动结束
function Skill500300205:OnActionOver(caster, target, data)
	-- 8326
	local targets = SkillFilter:All(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:DelValue(SkillEffect[8326], caster, target, data, "erduan")
	end
end
