-- 重盾牵引
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill940900201 = oo.class(SkillBase)
function Skill940900201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill940900201:DoSkill(caster, target, data)
	-- 903400201
	self.order = self.order + 1
	self:HitAddBuff(SkillEffect[903400201], caster, target, data, 10000,3007)
	-- 903400202
	self.order = self.order + 1
	self:AddPhysicsShieldCount(SkillEffect[903400202], caster, self.card, data, 2209,4,10)
end
