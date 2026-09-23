-- 快感飨宴
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill600500304 = oo.class(SkillBase)
function Skill600500304:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill600500304:DoSkill(caster, target, data)
	-- 11111
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11111], caster, target, data, 0.5,1)
	-- 11112
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11112], caster, target, data, 0.55,1)
	-- 11113
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11113], caster, target, data, 0.6,1)
	-- 11114
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11114], caster, target, data, 0.65,1)
	-- 11115
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11115], caster, target, data, 0.7,1)
end
-- 行动开始
function Skill600500304:OnActionBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 600500304
	self:AddBuff(SkillEffect[600500304], caster, target, data, 600500304)
end
-- 行动结束2
function Skill600500304:OnActionOver2(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 600500305
	self:Cure(SkillEffect[600500305], caster, self.card, data, 4,0.10)
	-- 600500307
	self:DelBufferTypeForce(SkillEffect[600500307], caster, target, data, 600500304)
	-- 600500301
	self:AddBuff(SkillEffect[600500301], caster, self.card, data, 600500301,1)
end
-- 加buff时
function Skill600500304:OnAddBuff(caster, target, data, buffer)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8256
	if SkillJudger:IsCtrlBuff(buffer or self, caster, target, true) then
	else
		return
	end
	-- 8643
	local count643 = SkillApi:BuffCount(self, caster, target,3,4,600500301)
	-- 8844
	if SkillJudger:Greater(self, caster, target, true,count643,0) then
	else
		return
	end
	-- 600500302
	self:DelBufferGroup(SkillEffect[600500302], caster, self.card, data, 1,1)
	-- 600500303
	self:DelBufferTypeForce(SkillEffect[600500303], caster, self.card, data, 600500301)
end
