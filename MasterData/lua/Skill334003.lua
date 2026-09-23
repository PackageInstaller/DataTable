-- 赤溟4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill334003 = oo.class(SkillBase)
function Skill334003:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 治疗时
function Skill334003:OnCure(caster, target, data)
	-- 334043
	self:tFunc_334043_334013(caster, target, data)
	self:tFunc_334043_334033(caster, target, data)
end
-- 入场时
function Skill334003:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 334003
	self:AddBuff(SkillEffect[334003], caster, self.card, data, 334003)
end
-- 回合开始时
function Skill334003:OnRoundBegin(caster, target, data)
	-- 334073
	self:tFunc_334073_334053(caster, target, data)
	self:tFunc_334073_334083(caster, target, data)
end
-- 行动结束2
function Skill334003:OnActionOver2(caster, target, data)
	-- 8686
	local count686 = SkillApi:SkillLevel(self, caster, target,3,3049001)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 334062
	if self:Rand(2000) then
		local targets = SkillFilter:HasBuff(self, caster, target, 4,304900306,4)
		for i,target in ipairs(targets) do
			self:CallOwnerSkill(SkillEffect[334062], caster, target, data, 304900100+count686)
		end
	end
end
function Skill334003:tFunc_334073_334083(caster, target, data)
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
	-- 334083
	if self:Rand(3000) then
		local targets = SkillFilter:HasBuff(self, caster, target, 4,304900306,4)
		for i,target in ipairs(targets) do
			self:CallOwnerSkill(SkillEffect[334083], caster, target, data, 304900100+count686)
		end
	end
end
function Skill334003:tFunc_334043_334033(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8686
	local count686 = SkillApi:SkillLevel(self, caster, target,3,3049001)
	-- 334023
	if self:Rand(3000) then
		local targets = SkillFilter:HasBuff(self, caster, target, 4,304900306,4)
		for i,target in ipairs(targets) do
			self:CallSkill(SkillEffect[334023], caster, target, data, 304900100+count686)
		end
	end
	-- 334033
	self:AddBuffCount(SkillEffect[334033], caster, self.card, data, 304900101,1,10)
end
function Skill334003:tFunc_334073_334053(caster, target, data)
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
	-- 334053
	if self:Rand(3000) then
		local targets = SkillFilter:HasBuff(self, caster, target, 4,304900306,4)
		for i,target in ipairs(targets) do
			self:CallOwnerSkill(SkillEffect[334053], caster, target, data, 304900100+count686)
		end
	end
end
function Skill334003:tFunc_334043_334013(caster, target, data)
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
	-- 334023
	if self:Rand(3000) then
		local targets = SkillFilter:HasBuff(self, caster, target, 4,304900306,4)
		for i,target in ipairs(targets) do
			self:CallSkill(SkillEffect[334023], caster, target, data, 304900100+count686)
		end
	end
	-- 334013
	self:AddBuffCount(SkillEffect[334013], caster, self.card, data, 304900101,1,10)
end
