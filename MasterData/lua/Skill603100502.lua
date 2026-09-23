-- 提泽纳2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill603100502 = oo.class(SkillBase)
function Skill603100502:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill603100502:DoSkill(caster, target, data)
	-- 603100502
	self.order = self.order + 1
	self:Cure(SkillEffect[603100502], caster, target, data, 1,0.14)
end
