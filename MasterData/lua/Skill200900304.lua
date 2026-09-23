-- 荧荧奏曲
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill200900304 = oo.class(SkillBase)
function Skill200900304:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill200900304:DoSkill(caster, target, data)
	-- 200900304
	self.order = self.order + 1
	self:Cure(SkillEffect[200900304], caster, target, data, 1,0.11)
	-- 200900313
	self.order = self.order + 1
	self:AddBuff(SkillEffect[200900313], caster, target, data, 200900313,2)
end
