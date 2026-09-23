-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill200201310 = oo.class(SkillBase)
function Skill200201310:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill200201310:DoSkill(caster, target, data)
	self.order = self.order + 1
	self:AddBuff(SkillEffect[200201310], caster, target, data, 200201310)
	self.order = self.order + 1
	self:AddBuff(SkillEffect[200201320], caster, target, data, 200201320)
end
