-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill200200309 = oo.class(SkillBase)
function Skill200200309:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill200200309:DoSkill(caster, target, data)
	self.order = self.order + 1
	self:AddBuff(SkillEffect[200200309], caster, target, data, 200200309)
	self.order = self.order + 1
	self:AddBuff(SkillEffect[200200319], caster, target, data, 200200319)
end
