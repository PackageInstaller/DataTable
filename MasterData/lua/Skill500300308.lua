-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill500300308 = oo.class(SkillBase)
function Skill500300308:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill500300308:DoSkill(caster, target, data)
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[12203], caster, target, data, 0.32,1)
	self.order = self.order + 1
	self:AddBuff(SkillEffect[5104], caster, target, data, 5104)
	self.order = self.order + 1
	local targets = SkillFilter:All(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:DamageLight(SkillEffect[12204], caster, target, data, 0.075,4)
	end
end
