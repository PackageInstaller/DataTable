-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill60010101 = oo.class(SkillBase)
function Skill60010101:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill60010101:DoSkill(caster, target, data)
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12006], caster, target, data, 0.17,6)
end
