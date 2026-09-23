-- 熔铄技能2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill942200202 = oo.class(SkillBase)
function Skill942200202:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill942200202:DoSkill(caster, target, data)
	-- 942200202
	self.order = self.order + 1
	self:AddBuff(SkillEffect[942200202], caster, target, data, 4603,2)
	-- 942200212
	self.order = self.order + 1
	self:AddBuff(SkillEffect[942200212], caster, target, data, 4403,2)
end
