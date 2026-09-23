-- 辉剑
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4303004 = oo.class(SkillBase)
function Skill4303004:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 拉条时
function Skill4303004:OnAddProgress(caster, target, data)
	-- 8071
	if SkillJudger:TargetIsFriend(self, caster, target, true) then
	else
		return
	end
	-- 4303001
	self:AddBuffCount(SkillEffect[4303001], caster, target, data, 4303001,1,999)
end
-- 行动结束
function Skill4303004:OnActionOver(caster, target, data)
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
	-- 8261
	if SkillJudger:IsCallSkill(self, caster, target, true) then
	else
		return
	end
	-- 4303002
	self:AddBuffCount(SkillEffect[4303002], caster, self.card, data, 4303002,1,999)
end
-- 回合结束时
function Skill4303004:OnRoundOver(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 8772
	local count772 = SkillApi:GetCount(self, caster, target,3,4303002)
	-- 4303004
	if SkillJudger:Greater(self, caster, target, true,count772,5) then
	else
		return
	end
	-- 4303007
	self:AddBuffCount(SkillEffect[4303007], caster, self.card, data, 4303002,-6,999)
	-- 4303013
	self:tFunc_4303013_4303014(caster, target, data)
	self:tFunc_4303013_4303009(caster, target, data)
end
function Skill4303004:tFunc_4303013_4303014(caster, target, data)
	-- 4303015
	if SkillJudger:HasBuff(self, caster, target, false,1,4303001) then
	else
		return
	end
	-- 8774
	local count774 = SkillApi:SkillLevel(self, caster, target,3,3030003)
	-- 4303014
	local targets = SkillFilter:Rand(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:CallOwnerSkill(SkillEffect[4303014], caster, target, data, 303000300+count774)
	end
end
function Skill4303004:tFunc_4303013_4303009(caster, target, data)
	-- 4303009
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		-- 8773
		local count773 = SkillApi:GetCount(self, caster, target,2,4303001)
		-- 4303010
		if SkillJudger:Greater(self, caster, target, true,count773,0) then
			-- 4303011
			self:AddProgress(SkillEffect[4303011], caster, target, data, 150)
			-- 4303016
			self:AddBuffCount(SkillEffect[4303016], caster, target, data, 4303001,-1,999)
		else
			-- 4303012
			self:AddProgress(SkillEffect[4303012], caster, target, data, 300)
			-- 4303016
			self:AddBuffCount(SkillEffect[4303016], caster, target, data, 4303001,-1,999)
		end
	end
end
