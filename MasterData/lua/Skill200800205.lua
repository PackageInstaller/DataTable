-- 初春协奏
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill200800205 = oo.class(SkillBase)
function Skill200800205:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill200800205:DoSkill(caster, target, data)
	-- 200800205
	self.order = self.order + 1
	self:Cure(SkillEffect[200800205], caster, target, data, 1,0.12)
	-- 200800213
	self.order = self.order + 1
	self:AddBuff(SkillEffect[200800213], caster, target, data, 200800203,2)
end
