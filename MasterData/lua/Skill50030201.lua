-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill50030201 = oo.class(SkillBase)
function Skill50030201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill50030201:DoSkill(caster, target, data)
	self.order = self.order + 1
	self:AddBuff(SkillEffect[2102], caster, target, data, 2102)
end
