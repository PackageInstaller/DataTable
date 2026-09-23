-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill702300307 = oo.class(SkillBase)
function Skill702300307:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill702300307:DoSkill(caster, target, data)
	self.order = self.order + 1
	self:AddBuff(SkillEffect[2127], caster, target, data, 2127)
end
