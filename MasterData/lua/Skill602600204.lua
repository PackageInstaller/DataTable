-- 布里欧纳克2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill602600204 = oo.class(SkillBase)
function Skill602600204:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill602600204:DoSkill(caster, target, data)
	-- 4106
	self.order = self.order + 1
	self:AddBuff(SkillEffect[4106], caster, target, data, 4106)
end
