-- 怪物群攻模组技能buff1
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill5700002 = oo.class(SkillBase)
function Skill5700002:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
function Skill5700002:CanSummon()
	return self.card:CanSummon(160105516,3,{1,1},{progress=300})
end
function Skill5700002:CanSummon()
	return self.card:CanSummon(160105517,3,{1,1},{progress=300})
end
function Skill5700002:CanSummon()
	return self.card:CanSummon(160105518,3,{1,1},{progress=300})
end
function Skill5700002:CanSummon()
	return self.card:CanSummon(160105519,3,{1,1},{progress=300})
end
function Skill5700002:CanSummon()
	return self.card:CanSummon(160105520,3,{1,1},{progress=300})
end
function Skill5700002:CanSummon()
	return self.card:CanSummon(160105521,3,{1,1},{progress=300})
end
function Skill5700002:CanSummon()
	return self.card:CanSummon(160105522,3,{1,1},{progress=300})
end
function Skill5700002:CanSummon()
	return self.card:CanSummon(160105523,3,{1,1},{progress=300})
end
function Skill5700002:CanSummon()
	return self.card:CanSummon(160105524,3,{1,1},{progress=300})
end
function Skill5700002:CanSummon()
	return self.card:CanSummon(160105525,3,{1,1},{progress=300})
end
function Skill5700002:CanSummon()
	return self.card:CanSummon(160105526,3,{1,1},{progress=300})
end
-- 死亡时
function Skill5700002:OnDeath(caster, target, data)
	-- 5700047
	self:tFunc_5700047_5700044(caster, target, data)
	self:tFunc_5700047_5700050(caster, target, data)
end
function Skill5700002:tFunc_5700047_5700044(caster, target, data)
	-- 5700044
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
		-- 5700011
		self:SummonTeammate(SkillEffect[5700011], caster, self.card, data, 160105516,3,{1,1},{progress=300})
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
		-- 5700012
		self:SummonTeammate(SkillEffect[5700012], caster, self.card, data, 160105517,3,{1,1},{progress=300})
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
		-- 5700013
		self:SummonTeammate(SkillEffect[5700013], caster, self.card, data, 160105518,3,{1,1},{progress=300})
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
		-- 5700014
		self:SummonTeammate(SkillEffect[5700014], caster, self.card, data, 160105519,3,{1,1},{progress=300})
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
		-- 5700015
		self:SummonTeammate(SkillEffect[5700015], caster, self.card, data, 160105520,3,{1,1},{progress=300})
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
		-- 5700016
		self:SummonTeammate(SkillEffect[5700016], caster, self.card, data, 160105521,3,{1,1},{progress=300})
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
		-- 5700017
		self:SummonTeammate(SkillEffect[5700017], caster, self.card, data, 160105522,3,{1,1},{progress=300})
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
		-- 5700018
		self:SummonTeammate(SkillEffect[5700018], caster, self.card, data, 160105523,3,{1,1},{progress=300})
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
		-- 5700019
		self:SummonTeammate(SkillEffect[5700019], caster, self.card, data, 160105524,3,{1,1},{progress=300})
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
		-- 5700020
		self:SummonTeammate(SkillEffect[5700020], caster, self.card, data, 160105525,3,{1,1},{progress=300})
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
		-- 5700021
		self:SummonTeammate(SkillEffect[5700021], caster, self.card, data, 160105526,3,{1,1},{progress=300})
	end
end
function Skill5700002:tFunc_5700047_5700050(caster, target, data)
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
