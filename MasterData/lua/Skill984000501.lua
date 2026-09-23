-- 双子宫
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill984000501 = oo.class(SkillBase)
function Skill984000501:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill984000501:DoSkill(caster, target, data)
	-- 11013
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11013], caster, target, data, 0.5,2)
	-- 12002
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12002], caster, target, data, 0.5,2)
end
