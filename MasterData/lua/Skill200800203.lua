-- 初春协奏
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill200800203 = oo.class(SkillBase)
function Skill200800203:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill200800203:DoSkill(caster, target, data)
	-- 200800203
	self.order = self.order + 1
	self:Cure(SkillEffect[200800203], caster, target, data, 1,0.11)
	-- 200800212
	self.order = self.order + 1
	self:AddBuff(SkillEffect[200800212], caster, target, data, 200800202,2)
end
