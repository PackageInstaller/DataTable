-- 重创迅劈
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill902700201 = oo.class(SkillBase)
function Skill902700201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill902700201:DoSkill(caster, target, data)
	-- 11001
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11001], caster, target, data, 1,1)
	-- 1003
	self.order = self.order + 1
	self:HitAddBuff(SkillEffect[1003], caster, target, data, 10000,1003)
end
