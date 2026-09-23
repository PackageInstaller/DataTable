-- 崩岩斩
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill100300302 = oo.class(SkillBase)
function Skill100300302:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill100300302:DoSkill(caster, target, data)
	-- 11051
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11051], caster, target, data, 0.125,4)
	-- 11052
	self.order = self.order + 1
	self:DamageLight(SkillEffect[11052], caster, target, data, 0.25,2)
end
