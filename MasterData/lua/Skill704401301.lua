-- 朝晖技能3（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill704401301 = oo.class(SkillBase)
function Skill704401301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill704401301:DoSkill(caster, target, data)
	-- 11201
	self.order = self.order + 1
	local targets = SkillFilter:All(self, caster, target, 2)
	for i,target in ipairs(targets) do
		self:DamagePhysics(SkillEffect[11201], caster, target, data, 0.21,5)
	end
	-- 11202
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11202], caster, target, data, 0.53,3)
end
