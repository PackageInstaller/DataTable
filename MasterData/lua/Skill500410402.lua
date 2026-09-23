-- 登场
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill500410402 = oo.class(SkillBase)
function Skill500410402:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill500410402:DoSkill(caster, target, data)
	-- 4500418
	self.order = self.order + 1
	self:OwnerAddBuff(SkillEffect[4500418], caster, target, data, 4500402)
end
