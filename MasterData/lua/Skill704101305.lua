-- 鸣刀技能3（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill704101305 = oo.class(SkillBase)
function Skill704101305:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill704101305:DoSkill(caster, target, data)
	-- 11125
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11125], caster, target, data, 0.2,5)
	-- 8703
	local count703 = SkillApi:GetCount(self, caster, target,3,704100101)
	-- 8918
	if SkillJudger:Greater(self, caster, target, true,count703,2) then
	else
		return
	end
	-- 11126
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11126], caster, target, data, 0.2,1)
	-- 8703
	local count703 = SkillApi:GetCount(self, caster, target,3,704100101)
	-- 8919
	if SkillJudger:Greater(self, caster, target, true,count703,5) then
	else
		return
	end
	-- 11127
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11127], caster, target, data, 0.2,1)
end
