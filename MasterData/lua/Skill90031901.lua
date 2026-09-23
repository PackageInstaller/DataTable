-- 技能19
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill90031901 = oo.class(SkillBase)
function Skill90031901:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill90031901:DoSkill(caster, target, data)
	-- 2301
	self.order = self.order + 1
	self:AddPhysicsShieldCount(SkillEffect[2301], caster, target, data, 2209,1,10)
end
