-- 怪物群攻模组技能buff1
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill5700004 = oo.class(SkillBase)
function Skill5700004:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
function Skill5700004:CanSummon()
	return self.card:CanSummon(160105538,3,{1,3},{progress=500})
end
function Skill5700004:CanSummon()
	return self.card:CanSummon(160105539,3,{1,3},{progress=500})
end
function Skill5700004:CanSummon()
	return self.card:CanSummon(160105540,3,{1,3},{progress=500})
end
function Skill5700004:CanSummon()
	return self.card:CanSummon(160105541,3,{1,3},{progress=500})
end
function Skill5700004:CanSummon()
	return self.card:CanSummon(160105542,3,{1,3},{progress=500})
end
function Skill5700004:CanSummon()
	return self.card:CanSummon(160105543,3,{1,3},{progress=500})
end
function Skill5700004:CanSummon()
	return self.card:CanSummon(160105544,3,{1,3},{progress=500})
end
function Skill5700004:CanSummon()
	return self.card:CanSummon(160105545,3,{1,3},{progress=500})
end
function Skill5700004:CanSummon()
	return self.card:CanSummon(160105546,3,{1,3},{progress=500})
end
function Skill5700004:CanSummon()
	return self.card:CanSummon(160105547,3,{1,3},{progress=500})
end
function Skill5700004:CanSummon()
	return self.card:CanSummon(160105548,3,{1,3},{progress=500})
end
-- 死亡时
function Skill5700004:OnDeath(caster, target, data)
	-- 5700049
	self:tFunc_5700049_5700046(caster, target, data)
	self:tFunc_5700049_5700050(caster, target, data)
end
function Skill5700004:tFunc_5700049_5700046(caster, target, data)
	-- 5700046
	local r = self.card:Rand(11)+1
	if 1 == r then
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
		-- 5700007
		if SkillJudger:HasBuff(self, caster, target, true,2,5700006) then
		else
			return
		end
		-- 5700033
		self:SummonTeammate(SkillEffect[5700033], caster, self.card, data, 160105538,3,{1,3},{progress=500})
	elseif 2 == r then
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
		-- 5700007
		if SkillJudger:HasBuff(self, caster, target, true,2,5700006) then
		else
			return
		end
		-- 5700034
		self:SummonTeammate(SkillEffect[5700034], caster, self.card, data, 160105539,3,{1,3},{progress=500})
	elseif 3 == r then
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
		-- 5700007
		if SkillJudger:HasBuff(self, caster, target, true,2,5700006) then
		else
			return
		end
		-- 5700035
		self:SummonTeammate(SkillEffect[5700035], caster, self.card, data, 160105540,3,{1,3},{progress=500})
	elseif 4 == r then
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
		-- 5700007
		if SkillJudger:HasBuff(self, caster, target, true,2,5700006) then
		else
			return
		end
		-- 5700036
		self:SummonTeammate(SkillEffect[5700036], caster, self.card, data, 160105541,3,{1,3},{progress=500})
	elseif 5 == r then
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
		-- 5700007
		if SkillJudger:HasBuff(self, caster, target, true,2,5700006) then
		else
			return
		end
		-- 5700037
		self:SummonTeammate(SkillEffect[5700037], caster, self.card, data, 160105542,3,{1,3},{progress=500})
	elseif 6 == r then
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
		-- 5700007
		if SkillJudger:HasBuff(self, caster, target, true,2,5700006) then
		else
			return
		end
		-- 5700038
		self:SummonTeammate(SkillEffect[5700038], caster, self.card, data, 160105543,3,{1,3},{progress=500})
	elseif 7 == r then
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
		-- 5700007
		if SkillJudger:HasBuff(self, caster, target, true,2,5700006) then
		else
			return
		end
		-- 5700039
		self:SummonTeammate(SkillEffect[5700039], caster, self.card, data, 160105544,3,{1,3},{progress=500})
	elseif 8 == r then
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
		-- 5700007
		if SkillJudger:HasBuff(self, caster, target, true,2,5700006) then
		else
			return
		end
		-- 5700040
		self:SummonTeammate(SkillEffect[5700040], caster, self.card, data, 160105545,3,{1,3},{progress=500})
	elseif 9 == r then
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
		-- 5700007
		if SkillJudger:HasBuff(self, caster, target, true,2,5700006) then
		else
			return
		end
		-- 5700041
		self:SummonTeammate(SkillEffect[5700041], caster, self.card, data, 160105546,3,{1,3},{progress=500})
	elseif 10 == r then
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
		-- 5700007
		if SkillJudger:HasBuff(self, caster, target, true,2,5700006) then
		else
			return
		end
		-- 5700042
		self:SummonTeammate(SkillEffect[5700042], caster, self.card, data, 160105547,3,{1,3},{progress=500})
	elseif 11 == r then
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
		-- 5700007
		if SkillJudger:HasBuff(self, caster, target, true,2,5700006) then
		else
			return
		end
		-- 5700043
		self:SummonTeammate(SkillEffect[5700043], caster, self.card, data, 160105548,3,{1,3},{progress=500})
	end
end
function Skill5700004:tFunc_5700049_5700050(caster, target, data)
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
	-- 5700050
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:AddBuffCount(SkillEffect[5700050], caster, target, data, 984700401,-1,20)
	end
end
