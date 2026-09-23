-- 震荡挥击
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill904000501 = oo.class(SkillBase)
function Skill904000501:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill904000501:DoSkill(caster, target, data)
	-- 11001
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11001], caster, target, data, 1,1)
	-- 904000501
	self.order = self.order + 1
	self:AddProgress(SkillEffect[904000501], caster, target, data, -300)
	-- 92008
	self.order = self.order + 1
	self:DelBufferGroup(SkillEffect[92008], caster, target, data, 2,3)
end
