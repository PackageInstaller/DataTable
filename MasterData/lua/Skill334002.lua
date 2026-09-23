-- 赤溟4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill334002 = oo.class(SkillBase)
function Skill334002:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 治疗时
function Skill334002:OnCure(caster, target, data)
	-- 334042
	self:tFunc_334042_334012(caster, target, data)
	self:tFunc_334042_334032(caster, target, data)
end
-- 入场时
function Skill334002:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 334002
	self:AddBuff(SkillEffect[334002], caster, self.card, data, 334002)
end
-- 回合开始时
function Skill334002:OnRoundBegin(caster, target, data)
	-- 334072
	self:tFunc_334072_334052(caster, target, data)
	self:tFunc_334072_334082(caster, target, data)
end
-- 行动结束2
function Skill334002:OnActionOver2(caster, target, data)
	-- 8686
	local count686 = SkillApi:SkillLevel(self, caster, target,3,3049001)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 334061
	if self:Rand(1000) then
		local targets = SkillFilter:HasBuff(self, caster, target, 4,304900306,4)
		for i,target in ipairs(targets) do
			self:CallOwnerSkill(SkillEffect[334061], caster, target, data, 304900100+count686)
		end
	end
end
function Skill334002:tFunc_334072_334082(caster, target, data)
	-- 8686
	local count686 = SkillApi:SkillLevel(self, caster, target,3,3049001)
	-- 334076
	local count334076 = SkillApi:BuffCount(self, caster, target,1,4,102200201)
	-- 334077
	if SkillJudger:Greater(self, caster, target, true,count334076,0) then
	else
		return
	end
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 334082
	if self:Rand(2000) then
		local targets = SkillFilter:HasBuff(self, caster, target, 4,304900306,4)
		for i,target in ipairs(targets) do
			self:CallOwnerSkill(SkillEffect[334082], caster, target, data, 304900100+count686)
		end
	end
end
function Skill334002:tFunc_334042_334032(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8686
	local count686 = SkillApi:SkillLevel(self, caster, target,3,3049001)
	-- 334022
	if self:Rand(2000) then
		local targets = SkillFilter:HasBuff(self, caster, target, 4,304900306,4)
		for i,target in ipairs(targets) do
			self:CallSkill(SkillEffect[334022], caster, target, data, 304900100+count686)
		end
	end
	-- 334032
	self:AddBuffCount(SkillEffect[334032], caster, self.card, data, 304900101,1,10)
end
function Skill334002:tFunc_334072_334052(caster, target, data)
	-- 8686
	local count686 = SkillApi:SkillLevel(self, caster, target,3,3049001)
	-- 8697
	local count697 = SkillApi:BuffCount(self, caster, target,3,4,20080)
	-- 8907
	if SkillJudger:Greater(self, caster, target, true,count697,0) then
	else
		return
	end
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 334052
	if self:Rand(2000) then
		local targets = SkillFilter:HasBuff(self, caster, target, 4,304900306,4)
		for i,target in ipairs(targets) do
			self:CallOwnerSkill(SkillEffect[334052], caster, target, data, 304900100+count686)
		end
	end
end
function Skill334002:tFunc_334042_334012(caster, target, data)
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8061
	if SkillJudger:CasterIsFriend(self, caster, target, true) then
	else
		return
	end
	-- 8686
	local count686 = SkillApi:SkillLevel(self, caster, target,3,3049001)
	-- 334022
	if self:Rand(2000) then
		local targets = SkillFilter:HasBuff(self, caster, target, 4,304900306,4)
		for i,target in ipairs(targets) do
			self:CallSkill(SkillEffect[334022], caster, target, data, 304900100+count686)
		end
	end
	-- 334012
	self:AddBuffCount(SkillEffect[334012], caster, self.card, data, 304900101,1,10)
end
