-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill501400108 = oo.class(SkillBase)
function Skill501400108:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill501400108:DoSkill(caster, target, data)
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12002], caster, target, data, 0.5,2)
	self.order = self.order + 1
	local targets = SkillFilter:All(self, caster, target, 2)
	for i,target in ipairs(targets) do
		self:DelBuff(SkillEffect[94001], caster, target, data, 6302)
	end
	self.order = self.order + 1
	self:AddBuff(SkillEffect[94002], caster, target, data, 6302)
end
