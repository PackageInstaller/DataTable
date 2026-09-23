-- 装甲护卫
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill100400202 = oo.class(SkillBase)
function Skill100400202:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill100400202:DoSkill(caster, target, data)
	-- 100400201
	self.order = self.order + 1
	self:AddBuff(SkillEffect[100400201], caster, target, data, 100400201)
	-- 100400212
	self.order = self.order + 1
	self:AddSp(SkillEffect[100400212], caster, target, data, 15)
end
