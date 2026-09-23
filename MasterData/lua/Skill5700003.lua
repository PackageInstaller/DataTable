-- 怪物群攻模组技能buff1
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill5700003 = oo.class(SkillBase)
function Skill5700003:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
function Skill5700003:CanSummon()
	return self.card:CanSummon(160105527,3,{1,2},{progress=400})
end
function Skill5700003:CanSummon()
	return self.card:CanSummon(160105528,3,{1,2},{progress=400})
end
function Skill5700003:CanSummon()
	return self.card:CanSummon(160105529,3,{1,2},{progress=400})
end
function Skill5700003:CanSummon()
	return self.card:CanSummon(160105530,3,{1,2},{progress=400})
end
function Skill5700003:CanSummon()
	return self.card:CanSummon(160105531,3,{1,2},{progress=400})
end
function Skill5700003:CanSummon()
	return self.card:CanSummon(160105532,3,{1,2},{progress=400})
end
function Skill5700003:CanSummon()
	return self.card:CanSummon(160105533,3,{1,2},{progress=400})
end
function Skill5700003:CanSummon()
	return self.card:CanSummon(160105534,3,{1,2},{progress=400})
end
function Skill5700003:CanSummon()
	return self.card:CanSummon(160105535,3,{1,2},{progress=400})
end
function Skill5700003:CanSummon()
	return self.card:CanSummon(160105536,3,{1,2},{progress=400})
end
function Skill5700003:CanSummon()
	return self.card:CanSummon(160105537,3,{1,2},{progress=400})
end
-- 死亡时
function Skill5700003:OnDeath(caster, target, data)
	-- 5700048
	self:tFunc_5700048_5700045(caster, target, data)
	self:tFunc_5700048_5700050(caster, target, data)
end
function Skill5700003:tFunc_5700048_5700050(caster, target, data)
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
function Skill5700003:tFunc_5700048_5700045(caster, target, data)
	-- 5700045
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
		-- 5700022
		self:SummonTeammate(SkillEffect[5700022], caster, self.card, data, 160105527,3,{1,2},{progress=400})
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
		-- 5700023
		self:SummonTeammate(SkillEffect[5700023], caster, self.card, data, 160105528,3,{1,2},{progress=400})
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
		-- 5700024
		self:SummonTeammate(SkillEffect[5700024], caster, self.card, data, 160105529,3,{1,2},{progress=400})
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
		-- 5700025
		self:SummonTeammate(SkillEffect[5700025], caster, self.card, data, 160105530,3,{1,2},{progress=400})
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
		-- 5700026
		self:SummonTeammate(SkillEffect[5700026], caster, self.card, data, 160105531,3,{1,2},{progress=400})
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
		-- 5700027
		self:SummonTeammate(SkillEffect[5700027], caster, self.card, data, 160105532,3,{1,2},{progress=400})
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
		-- 5700028
		self:SummonTeammate(SkillEffect[5700028], caster, self.card, data, 160105533,3,{1,2},{progress=400})
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
		-- 5700029
		self:SummonTeammate(SkillEffect[5700029], caster, self.card, data, 160105534,3,{1,2},{progress=400})
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
		-- 5700030
		self:SummonTeammate(SkillEffect[5700030], caster, self.card, data, 160105535,3,{1,2},{progress=400})
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
		-- 5700031
		self:SummonTeammate(SkillEffect[5700031], caster, self.card, data, 160105536,3,{1,2},{progress=400})
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
		-- 5700032
		self:SummonTeammate(SkillEffect[5700032], caster, self.card, data, 160105537,3,{1,2},{progress=400})
	end
end
