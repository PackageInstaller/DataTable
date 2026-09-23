-- 迅驰轰炮
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill301200301 = oo.class(SkillBase)
function Skill301200301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill301200301:DoSkill(caster, target, data)
	-- 11041
	self.order = self.order + 1
	self:DamageLight(SkillEffect[11041], caster, target, data, 0.16,2)
	-- 11042
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11042], caster, target, data, 0.17,4)
end
