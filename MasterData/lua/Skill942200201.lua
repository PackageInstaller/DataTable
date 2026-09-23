-- 熔铄技能2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill942200201 = oo.class(SkillBase)
function Skill942200201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill942200201:DoSkill(caster, target, data)
	-- 942200201
	self.order = self.order + 1
	self:AddBuff(SkillEffect[942200201], caster, target, data, 4602,2)
	-- 942200211
	self.order = self.order + 1
	self:AddBuff(SkillEffect[942200211], caster, target, data, 4402,2)
end
