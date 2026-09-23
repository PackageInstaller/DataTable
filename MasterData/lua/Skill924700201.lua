-- 嘲讽巨盾
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill924700201 = oo.class(SkillBase)
function Skill924700201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill924700201:DoSkill(caster, target, data)
	-- 924700201
	self.order = self.order + 1
	self:HitAddBuff(SkillEffect[924700201], caster, target, data, 10000,3007)
	-- 924700202
	self.order = self.order + 1
	self:AddPhysicsShieldCount(SkillEffect[924700202], caster, self.card, data, 2209,4,10)
end
