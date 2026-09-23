-- 凝冰坠落
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill401200305 = oo.class(SkillBase)
function Skill401200305:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill401200305:DoSkill(caster, target, data)
	-- 12205
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[12205], caster, target, data, 0.4,1)
	-- 12206
	self.order = self.order + 1
	local targets = SkillFilter:All(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:DamageLight(SkillEffect[12206], caster, target, data, 0.15,2)
	end
end
