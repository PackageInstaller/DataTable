-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill200200308 = oo.class(SkillBase)
function Skill200200308:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill200200308:DoSkill(caster, target, data)
	self.order = self.order + 1
	self:AddBuff(SkillEffect[200200308], caster, target, data, 200200308)
	self.order = self.order + 1
	self:AddBuff(SkillEffect[200200318], caster, target, data, 200200318)
end
