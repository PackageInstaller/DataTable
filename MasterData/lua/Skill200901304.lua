-- 荧荧奏曲（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill200901304 = oo.class(SkillBase)
function Skill200901304:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill200901304:DoSkill(caster, target, data)
	-- 200901304
	self.order = self.order + 1
	self:Cure(SkillEffect[200901304], caster, target, data, 1,0.17)
	-- 200901313
	self.order = self.order + 1
	self:AddBuff(SkillEffect[200901313], caster, target, data, 200900313,4)
end
