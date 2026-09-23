-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill300800106 = oo.class(SkillBase)
function Skill300800106:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill300800106:DoSkill(caster, target, data)
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12002], caster, target, data, 0.5,2)
end
