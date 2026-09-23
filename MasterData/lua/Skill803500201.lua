-- 放逐者2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill803500201 = oo.class(SkillBase)
function Skill803500201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill803500201:DoSkill(caster, target, data)
	-- 803500201
	self.order = self.order + 1
	self:AddBuff(SkillEffect[803500201], caster, target, data, 4004,2)
end
