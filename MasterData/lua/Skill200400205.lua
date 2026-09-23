-- 节奏骤升
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill200400205 = oo.class(SkillBase)
function Skill200400205:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill200400205:DoSkill(caster, target, data)
	-- 200400205
	self.order = self.order + 1
	self:AddProgress(SkillEffect[200400205], caster, target, data, 300)
end
