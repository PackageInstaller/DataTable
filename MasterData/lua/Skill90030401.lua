-- 技能4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill90030401 = oo.class(SkillBase)
function Skill90030401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill90030401:DoSkill(caster, target, data)
	-- 11002
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11002], caster, target, data, 0.5,2)
	-- 60002
	self.order = self.order + 1
	self:HitAddBuff(SkillEffect[60002], caster, target, data, 4000,3001)
end
