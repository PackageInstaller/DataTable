-- 荧荧奏曲（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill200901301 = oo.class(SkillBase)
function Skill200901301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill200901301:DoSkill(caster, target, data)
	-- 200901301
	self.order = self.order + 1
	self:Cure(SkillEffect[200901301], caster, target, data, 1,0.16)
	-- 200901311
	self.order = self.order + 1
	self:AddBuff(SkillEffect[200901311], caster, target, data, 200900311,4)
end
