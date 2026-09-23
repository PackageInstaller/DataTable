-- 星墙
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill907800701 = oo.class(SkillBase)
function Skill907800701:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill907800701:DoSkill(caster, target, data)
	-- 907800701
	self.order = self.order + 1
	self:AddBuffCount(SkillEffect[907800701], caster, self.card, data, 3404,2,2)
end
