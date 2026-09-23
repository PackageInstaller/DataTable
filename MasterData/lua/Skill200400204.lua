-- 节奏骤升
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill200400204 = oo.class(SkillBase)
function Skill200400204:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill200400204:DoSkill(caster, target, data)
	-- 200400204
	self.order = self.order + 1
	self:AddProgress(SkillEffect[200400204], caster, target, data, 250)
end
