-- 嘲讽巨盾
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill951900201 = oo.class(SkillBase)
function Skill951900201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill951900201:DoSkill(caster, target, data)
	-- 12001
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12001], caster, target, data, 1,1)
	-- 92019
	if self:Rand(3000) then
		self.order = self.order + 1
		self:DelBufferGroup(SkillEffect[92019], caster, target, data, 2,2)
	end
end
