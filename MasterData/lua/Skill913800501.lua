-- 提泽纳boss 被动技能2调用技能
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill913800501 = oo.class(SkillBase)
function Skill913800501:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill913800501:DoSkill(caster, target, data)
	-- 913800501
	self.order = self.order + 1
	self:AddBuffCount(SkillEffect[913800501], caster, target, data, 913800501,15,45)
end
