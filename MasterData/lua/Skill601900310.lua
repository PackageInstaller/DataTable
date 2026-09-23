-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill601900310 = oo.class(SkillBase)
function Skill601900310:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill601900310:DoSkill(caster, target, data)
	self.order = self.order + 1
	self:AddBuff(SkillEffect[601900301], caster, target, data, 601900301)
	self.order = self.order + 1
	self:ChangeSkill(SkillEffect[601900302], caster, target, data, 3,601900401)
end
