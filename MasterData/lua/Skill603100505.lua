-- 提泽纳2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill603100505 = oo.class(SkillBase)
function Skill603100505:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill603100505:DoSkill(caster, target, data)
	-- 603100505
	self.order = self.order + 1
	self:Cure(SkillEffect[603100505], caster, target, data, 1,0.20)
end
