-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill302000109 = oo.class(SkillBase)
function Skill302000109:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill302000109:DoSkill(caster, target, data)
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11001], caster, target, data, 1,1)
end
