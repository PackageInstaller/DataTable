-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill60010201 = oo.class(SkillBase)
function Skill60010201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill60010201:DoSkill(caster, target, data)
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12004], caster, target, data, 0.25,4)
	self.order = self.order + 1
	self:HitAddBuff(SkillEffect[60006], caster, target, data, 6000,3009)
end
