-- 射手座技能3
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill984600301 = oo.class(SkillBase)
function Skill984600301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill984600301:DoSkill(caster, target, data)
	-- 13016
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[13016], caster, target, data, 0.125,4)
	-- 13017
	self.order = self.order + 1
	self:DamageLight(SkillEffect[13017], caster, target, data, 0.125,4)
end
