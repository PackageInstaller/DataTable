-- 大型造物2 5技能
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill941700501 = oo.class(SkillBase)
function Skill941700501:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill941700501:DoSkill(caster, target, data)
	-- 11005
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11005], caster, target, data, 0.2,5)
end
