-- 星墙
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill907800702 = oo.class(SkillBase)
function Skill907800702:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill907800702:DoSkill(caster, target, data)
	-- 907800702
	self.order = self.order + 1
	self:AddProgress(SkillEffect[907800702], caster, self.card, data, 200)
end
