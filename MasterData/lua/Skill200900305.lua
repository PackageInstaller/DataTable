-- 荧荧奏曲
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill200900305 = oo.class(SkillBase)
function Skill200900305:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill200900305:DoSkill(caster, target, data)
	-- 200900305
	self.order = self.order + 1
	self:Cure(SkillEffect[200900305], caster, target, data, 1,0.12)
	-- 200900313
	self.order = self.order + 1
	self:AddBuff(SkillEffect[200900313], caster, target, data, 200900313,2)
end
