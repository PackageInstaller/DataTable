-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill10010202 = oo.class(SkillBase)
function Skill10010202:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill10010202:DoSkill(caster, target, data)
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11001], caster, target, data, 1,1)
	self.order = self.order + 1
	self:HitAddBuff(SkillEffect[3001], caster, target, data, 10000,3001)
	self.order = self.order + 1
	self:AddSp(SkillEffect[80001], caster, caster, data, 10)
end
