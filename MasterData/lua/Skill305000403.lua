-- 审判攻击
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill305000403 = oo.class(SkillBase)
function Skill305000403:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill305000403:DoSkill(caster, target, data)
	-- 11501
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11501], caster, target, data, 1,3)
	-- 11502
	self.order = self.order + 1
	local targets = SkillFilter:All(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:DamagePhysics(SkillEffect[11502], caster, target, data, 1.4,1)
	end
end
-- 行动结束2
function Skill305000403:OnActionOver2(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 305000401
	self:ChangeSkill(SkillEffect[305000401], caster, self.card, data, 3,305000301)
	-- 305000402
	self:SetFury(SkillEffect[305000402], caster, self.card, data, 0)
	-- 305000403
	self:DelBufferTypeForce(SkillEffect[305000403], caster, self.card, data, 305000301)
end
-- 攻击结束
function Skill305000403:OnAttackOver(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8071
	if SkillJudger:TargetIsFriend(self, caster, target, true) then
	else
		return
	end
	-- 305000328
	local count3050 = SkillApi:BuffCount(self, caster, target,3,4,305000301)
	-- 305000327
	if SkillJudger:Greater(self, caster, target, true,count3050,0) then
	else
		return
	end
	-- 305000321
	self:AddFury(SkillEffect[305000321], caster, self.card, data, 10,100)
end
-- 行动结束
function Skill305000403:OnActionOver(caster, target, data)
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
	-- 305000328
	local count3050 = SkillApi:BuffCount(self, caster, target,3,4,305000301)
	-- 305000327
	if SkillJudger:Greater(self, caster, target, true,count3050,0) then
	else
		return
	end
	-- 8244
	if SkillJudger:IsBeatBack(self, caster, target, true) then
	else
		return
	end
	-- 305000325
	self:AddFury(SkillEffect[305000325], caster, self.card, data, 10,100)
end
-- 回合开始时
function Skill305000403:OnRoundBegin(caster, target, data)
	-- 305000320
	local xuneng = SkillApi:GetFury(self, caster, self.card,3)
	-- 305000322
	if SkillJudger:GreaterEqual(self, caster, target, true,xuneng,100) then
	else
		return
	end
	-- 305000328
	local count3050 = SkillApi:BuffCount(self, caster, target,3,4,305000301)
	-- 305000327
	if SkillJudger:Greater(self, caster, target, true,count3050,0) then
	else
		return
	end
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 305000323
	self:ChangeSkill(SkillEffect[305000323], caster, self.card, data, 3,305000501)
	-- 305000511
	self:AddBuff(SkillEffect[305000511], caster, self.card, data, 305000400)
end
