-- 寒气
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4302502 = oo.class(SkillBase)
function Skill4302502:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill4302502:OnBefourHurt(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 8434
	local count34 = SkillApi:BuffCount(self, caster, target,2,3,3005)
	-- 8117
	if SkillJudger:Greater(self, caster, self.card, true,count34,0) then
	else
		return
	end
	-- 8407
	local count7 = SkillApi:GetAttr(self, caster, target,1,"speed")
	-- 8408
	local count8 = SkillApi:GetAttr(self, caster, target,2,"speed")
	-- 4302507
	self:AddTempAttr(SkillEffect[4302507], caster, target, data, "defense",math.max(math.min(-(count7-count8)*3,0),-300))
end
-- 加buff时
function Skill4302502:OnAddBuff(caster, target, data, buffer)
	-- 8434
	local count34 = SkillApi:BuffCount(self, caster, target,2,3,3005)
	-- 8117
	if SkillJudger:Greater(self, caster, self.card, true,count34,0) then
	else
		return
	end
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 4302502
	self:OwnerAddBuffCount(SkillEffect[4302502], caster, target, data, 4302502,1,1)
end
-- 回合结束时
function Skill4302502:OnRoundOver(caster, target, data)
	-- 8733
	local count733 = SkillApi:BuffCount(self, caster, target,1,3,3005)
	-- 8946
	if SkillJudger:Less(self, caster, self.card, true,count733,1) then
	else
		return
	end
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 4302522
	self:DelBufferForce(SkillEffect[4302522], caster, caster, data, 4302502)
end
-- 回合开始时
function Skill4302502:OnRoundBegin(caster, target, data)
	-- 4302531
	local targets = SkillFilter:All(self, caster, target, 4)
	for i,target in ipairs(targets) do
		-- 8434
		local count34 = SkillApi:BuffCount(self, caster, target,2,3,3005)
		-- 8807
		if SkillJudger:Less(self, caster, self.card, true,count34,1) then
		else
			return
		end
		-- 4302532
		self:DelBufferTypeForce(SkillEffect[4302532], caster, target, data, 4302501)
	end
end
