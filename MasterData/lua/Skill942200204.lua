-- 熔铄技能2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill942200204 = oo.class(SkillBase)
function Skill942200204:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill942200204:DoSkill(caster, target, data)
	-- 942200204
	self.order = self.order + 1
	self:AddBuff(SkillEffect[942200204], caster, target, data, 4605,2)
	-- 942200214
	self.order = self.order + 1
	self:AddBuff(SkillEffect[942200214], caster, target, data, 4405,2)
end
