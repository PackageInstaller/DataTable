-- 赤溟4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill334005 = oo.class(SkillBase)
function Skill334005:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 治疗时
function Skill334005:OnCure(caster, target, data)
	-- 334045
	self:tFunc_334045_334015(caster, target, data)
	self:tFunc_334045_334035(caster, target, data)
end
-- 入场时
function Skill334005:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 334005
	self:AddBuff(SkillEffect[334005], caster, self.card, data, 334005)
end
-- 回合开始时
function Skill334005:OnRoundBegin(caster, target, data)
	-- 334075
	self:tFunc_334075_334055(caster, target, data)
	self:tFunc_334075_334085(caster, target, data)
end
-- 行动结束2
function Skill334005:OnActionOver2(caster, target, data)
	-- 8686
	local count686 = SkillApi:SkillLevel(self, caster, target,3,3049001)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 334063
	if self:Rand(3000) then
		local targets = SkillFilter:HasBuff(self, caster, target, 4,304900306,4)
		for i,target in ipairs(targets) do
			self:CallOwnerSkill(SkillEffect[334063], caster, target, data, 304900100+count686)
		end
	end
end
function Skill334005:tFunc_334045_334035(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8686
	local count686 = SkillApi:SkillLevel(self, caster, target,3,3049001)
	-- 334025
	if self:Rand(5000) then
		local targets = SkillFilter:HasBuff(self, caster, target, 4,304900306,4)
		for i,target in ipairs(targets) do
			self:CallSkill(SkillEffect[334025], caster, target, data, 304900100+count686)
		end
	end
	-- 334035
	self:AddBuffCount(SkillEffect[334035], caster, self.card, data, 304900101,1,10)
end
function Skill334005:tFunc_334075_334055(caster, target, data)
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
	-- 334055
	if self:Rand(5000) then
		local targets = SkillFilter:HasBuff(self, caster, target, 4,304900306,4)
		for i,target in ipairs(targets) do
			self:CallOwnerSkill(SkillEffect[334055], caster, target, data, 304900100+count686)
		end
	end
end
function Skill334005:tFunc_334045_334015(caster, target, data)
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
	-- 334025
	if self:Rand(5000) then
		local targets = SkillFilter:HasBuff(self, caster, target, 4,304900306,4)
		for i,target in ipairs(targets) do
			self:CallSkill(SkillEffect[334025], caster, target, data, 304900100+count686)
		end
	end
	-- 334015
	self:AddBuffCount(SkillEffect[334015], caster, self.card, data, 304900101,1,10)
end
function Skill334005:tFunc_334075_334085(caster, target, data)
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
	-- 334085
	if self:Rand(5000) then
		local targets = SkillFilter:HasBuff(self, caster, target, 4,304900306,4)
		for i,target in ipairs(targets) do
			self:CallOwnerSkill(SkillEffect[334085], caster, target, data, 304900100+count686)
		end
	end
end
