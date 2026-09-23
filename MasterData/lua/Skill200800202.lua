-- 初春协奏
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill200800202 = oo.class(SkillBase)
function Skill200800202:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill200800202:DoSkill(caster, target, data)
	-- 200800202
	self.order = self.order + 1
	self:Cure(SkillEffect[200800202], caster, target, data, 1,0.10)
	-- 200800212
	self.order = self.order + 1
	self:AddBuff(SkillEffect[200800212], caster, target, data, 200800202,2)
end
