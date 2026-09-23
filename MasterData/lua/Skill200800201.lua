-- 初春协奏
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill200800201 = oo.class(SkillBase)
function Skill200800201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill200800201:DoSkill(caster, target, data)
	-- 200800201
	self.order = self.order + 1
	self:Cure(SkillEffect[200800201], caster, target, data, 1,0.10)
	-- 200800211
	self.order = self.order + 1
	self:AddBuff(SkillEffect[200800211], caster, target, data, 200800201,2)
end
