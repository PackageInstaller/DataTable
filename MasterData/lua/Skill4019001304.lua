-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4019001304 = oo.class(SkillBase)
function Skill4019001304:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill4019001304:DoSkill(caster, target, data)
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12001], caster, target, data, 1,1)
	self.order = self.order + 1
	self:HitAddBuff(SkillEffect[5225], caster, target, data, 10000,5205,3)
end
