-- 技能14
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill90031401 = oo.class(SkillBase)
function Skill90031401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill90031401:DoSkill(caster, target, data)
	-- 11101
	self.order = self.order + 1
	local targets = SkillFilter:Row(self, caster, target, 2)
	for i,target in ipairs(targets) do
		self:DamagePhysics(SkillEffect[11101], caster, target, data, 1,1)
	end
	-- 11102
	self.order = self.order + 1
	local targets = SkillFilter:Col(self, caster, target, 2)
	for i,target in ipairs(targets) do
		self:DamagePhysics(SkillEffect[11102], caster, target, data, 1,1)
	end
end
