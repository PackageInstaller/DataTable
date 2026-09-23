-- 节奏骤升
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill200400203 = oo.class(SkillBase)
function Skill200400203:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill200400203:DoSkill(caster, target, data)
	-- 200400203
	self.order = self.order + 1
	self:AddProgress(SkillEffect[200400203], caster, target, data, 200)
end
