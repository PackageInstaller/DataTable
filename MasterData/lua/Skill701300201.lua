-- 力场庇护
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill701300201 = oo.class(SkillBase)
function Skill701300201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill701300201:DoSkill(caster, target, data)
	-- 33011
	self.order = self.order + 1
	self:Cure(SkillEffect[33011], caster, target, data, 1,0.18)
end
