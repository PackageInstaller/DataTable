-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill700700309 = oo.class(SkillBase)
function Skill700700309:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill700700309:DoSkill(caster, target, data)
	self.order = self.order + 1
	local targets = SkillFilter:DynamicCross(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:DamageLight(SkillEffect[12301], caster, target, data, 1,1)
	end
	self.order = self.order + 1
	local targets = SkillFilter:All(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:DamageLight(SkillEffect[12302], caster, target, data, 1,1)
	end
end
