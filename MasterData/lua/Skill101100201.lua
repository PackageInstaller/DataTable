-- 固守
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill101100201 = oo.class(SkillBase)
function Skill101100201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill101100201:DoSkill(caster, target, data)
	-- 101100201
	self.order = self.order + 1
	self:AddBuff(SkillEffect[101100201], caster, target, data, 101100201)
end
