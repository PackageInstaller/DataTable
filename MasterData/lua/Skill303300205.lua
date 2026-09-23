-- 大地破浪
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill303300205 = oo.class(SkillBase)
function Skill303300205:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill303300205:DoSkill(caster, target, data)
	-- 33011
	self.order = self.order + 1
	self:Cure(SkillEffect[33011], caster, target, data, 1,0.18)
end
