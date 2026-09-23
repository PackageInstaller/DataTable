-- 重拳连击
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill904300201 = oo.class(SkillBase)
function Skill904300201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill904300201:DoSkill(caster, target, data)
	-- 11003
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11003], caster, target, data, 0.333,3)
	-- 904300201
	self.order = self.order + 1
	self:HitAddBuff(SkillEffect[904300201], caster, target, data, 5000,3004)
end
