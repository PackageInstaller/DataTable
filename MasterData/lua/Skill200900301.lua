-- 荧荧奏曲
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill200900301 = oo.class(SkillBase)
function Skill200900301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill200900301:DoSkill(caster, target, data)
	-- 200900301
	self.order = self.order + 1
	self:Cure(SkillEffect[200900301], caster, target, data, 1,0.10)
	-- 200900311
	self.order = self.order + 1
	self:AddBuff(SkillEffect[200900311], caster, target, data, 200900311,2)
end
