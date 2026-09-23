-- 碎裂强袭（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill301801301 = oo.class(SkillBase)
function Skill301801301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill301801301:DoSkill(caster, target, data)
	-- 11081
	self.order = self.order + 1
	local targets = SkillFilter:Different(self, caster, target, 4,8)
	for i,target in ipairs(targets) do
		-- 11082
		self:DamagePhysics(SkillEffect[11082], caster, target, data, 1,1)
		-- 11083
		self:AddOrder(SkillEffect[11083], caster, target, data, nil)
		-- 8331
		self:AddValue(SkillEffect[8331], caster, target, data, "suaijian",1)
	end
	-- 8332
	self.order = self.order + 1
	local targets = SkillFilter:All(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:DelValue(SkillEffect[8332], caster, target, data, "suaijian")
	end
end
