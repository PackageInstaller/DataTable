local unpack = unpack or table.unpack

------------------筛选策略---------------------------------
SkillFilter = {}
-- 筛选策略参数filterArg 1施法方,2被施法方, 3我方(技能拥有者一方),4敌方
function SkillFilter:GetTeam(oSkill, caster, target, teamID)
	-- local list = {}
	local mgr = oSkill.team.fightMgr

	if not teamID or teamID == 2 then --2被施法方/默认该选项
		local team = mgr:GetTeam(mgr:GetEnemyTeamID(caster))
		return team
	elseif teamID == 1 then --1施法方
		local team = mgr:GetTeam(caster:GetTeamID())
		return team
	elseif teamID == 3 then -- 3我方(技能拥有者一方)
		return oSkill.team
	elseif teamID == 4 then -- 4敌方
		local team = mgr:GetTeam(mgr:GetEnemyTeamID(oSkill.card))
		return team	
	end
	ASSERT(nil, "筛选策略参数错误"..teamID)
end
-- 全体
function SkillFilter:All(oSkill, caster, target, teamID, num)
	local team = SkillFilter:GetTeam(oSkill, caster, target, teamID)
	return team.filter:GetAll()
end

-- 获取小队
function SkillFilter:Group(oSkill, caster, target, teamID, nClass, num)
	local team = SkillFilter:GetTeam(oSkill, caster, target, teamID)
	return team.filter:GetClass(nClass)
end

-- 一行
function SkillFilter:Row(oSkill, caster, target, teamID, num)

	local list = {}
	local mgr = oSkill.team.fightMgr

	if teamID == 1 then
		local team = mgr:GetTeam(caster:GetTeamID())
		local pos = caster:GetPos()
		return team.filter:GetRow(pos[1], pos[2])
	else
		local team = mgr:GetTeam(target:GetTeamID())
		local pos = target:GetPos()
		return team.filter:GetRow(pos[1], pos[2])
	end
	return list
end

-- 一列
function SkillFilter:Col(oSkill, caster, target, teamID, num)

	local list = {}
	local mgr = oSkill.team.fightMgr

	if teamID == 1 then
		local team = mgr:GetTeam(caster:GetTeamID())
		local pos = caster:GetPos()
		return team.filter:GetCol(pos[1], pos[2], true)
	else
		local team = mgr:GetTeam(target:GetTeamID())
		local pos = target:GetPos()
		return team.filter:GetCol(pos[1], pos[2], true)
	end
	return list
end

-- 十字(固定)
function SkillFilter:Cross(oSkill, caster, target, teamID, num)

	local list = {}
	local mgr = oSkill.team.fightMgr

	if teamID == 1 then
		local team = mgr:GetTeam(caster:GetTeamID())
		-- local pos = caster:GetPos()
		return team.filter:GetCross(2, 2)
	else
		local team = mgr:GetTeam(target:GetTeamID())
		-- local pos = target:GetPos()
		return team.filter:GetCross(2, 2)
	end
	return list
end

-- 十字(以目标为中心)
function SkillFilter:DynamicCross(oSkill, caster, target, teamID, num)

	local list = {}
	local mgr = oSkill.team.fightMgr

	if teamID == 1 then
		local team = mgr:GetTeam(caster:GetTeamID())
		local pos = caster:GetPos()
		return team.filter:GetCross(pos[1], pos[2], true)
	else
		local team = mgr:GetTeam(target:GetTeamID())
		local pos = target:GetPos()
		return team.filter:GetCross(pos[1], pos[2], true)
	end
	return list
end

-- 随机
function SkillFilter:Rand(oSkill, caster, target, teamID, exclude,isSummonIn)

	local team = SkillFilter:GetTeam(oSkill, caster, target, teamID)
	local r = oSkill.card:Rand(10000)

	if exclude == 1 then
		return team.filter:GetRand(r, caster,isSummonIn)
	elseif exclude == 2 then
		return team.filter:GetRand(r, target,isSummonIn)
	end

	return team.filter:GetRand(r,nil,isSummonIn)
end

-- 最大属性
function SkillFilter:MaxAttr(oSkill, caster, target, teamID, attr, num, filter)
	local team = SkillFilter:GetTeam(oSkill, caster, target, teamID)
	if filter then
		local card = SkillApi:Filter(oSkill, caster, target, filter)
		return team.filter:GetMaxAttribute(attr, num, card)
	end
	return team.filter:GetMaxAttribute(attr, num)
end

-- 最小属性
function SkillFilter:MinAttr(oSkill, caster, target, teamID, attr, num, filter)
	local team = SkillFilter:GetTeam(oSkill, caster, target, teamID)

	if filter then
		local card = SkillApi:Filter(oSkill, caster, target, filter)
		return team.filter:GetMinAttribute(attr, num, card)
	end
	return team.filter:GetMinAttribute(attr, num)
end

-- 最大血量比
function SkillFilter:MaxPercentHp(oSkill, caster, target, teamID, attr, num)
	local team = SkillFilter:GetTeam(oSkill, caster, target, teamID)
	return team.filter:GetMaxPercentHp(num)
end

-- 最小血量比
function SkillFilter:MinPercentHp(oSkill, caster, target, teamID, attr, num)
	local team = SkillFilter:GetTeam(oSkill, caster, target, teamID)
	return team.filter:GetMinPercentHp(num)
end

-- 获取所有队友(不含自己)
function SkillFilter:Teammate(oSkill, caster, target, teamID)
	-- local team = SkillFilter:GetTeam(oSkill, caster, target, teamID)
	local mgr = oSkill.team.fightMgr
	if not teamID or teamID == 2 then --2被施法方/默认该选项
		local team = mgr:GetTeam(target:GetTeamID())
		return team.filter:GetAll(target)
	elseif teamID == 1 then --1施法方
	--ASSERT(caster)
		local team = mgr:GetTeam(caster:GetTeamID())
		return team.filter:GetAll(caster)
	end
	return 
end

-- 获取尽量不同的攻击对象
function SkillFilter:Different(oSkill, caster, target, teamID, num)
	local team = SkillFilter:GetTeam(oSkill, caster, target, teamID)
	return team.filter:GetDifferent(num, target)
end

-- 目标以外的其他目标
function SkillFilter:Exception(oSkill, caster, target, teamID)
	local team = target.team
	return team.filter:GetException(target)
end

-- 人数最多的十字范围 
function SkillFilter:MaxCross(oSkill, caster, target, teamID)
	local team = SkillFilter:GetTeam(oSkill, caster, target, teamID)
	return team.filter:GetMaxCross()
end

-- 人数最多的田字范围 
function SkillFilter:MaxTian(oSkill, caster, target, teamID)
	local team = SkillFilter:GetTeam(oSkill, caster, target, teamID)
	return team.filter:GetMaxTian()
end

-- 返回有buff的对象, 没有就就随机一个
function SkillFilter:HasBuff(oSkill, caster, target, teamID, buffID, typ)
	local team = SkillFilter:GetTeam(oSkill, caster, target, teamID)
	local rand = oSkill.card:Rand(10000)
	local targets = team.filter:HasBuff(buffID, typ, rand) or {}

	if #targets > 0 then return targets end

	-- 
	return team.filter:GetRand(rand)
end

-- 返回某个角色对象
function SkillFilter:HasRole(oSkill, caster, target, teamID, cId)
	local team = SkillFilter:GetTeam(oSkill, caster, target, teamID)
	return team.filter:HasRole(cId)
end
------------------条件判断---------------------------------
SkillJudger = {}

-- 攻击方是自己
function SkillJudger:CasterIsSelf(oSkill, caster, target, res)
	if oSkill.card == caster then
		return res
	end
	return not res
end

-- 攻击方是队友
function SkillJudger:CasterIsFriend(oSkill, caster, target, res)
	local myTeamID = oSkill.card:GetTeamID()
	if myTeamID == caster:GetTeamID() and oSkill.card ~= caster and caster.type ~= CardType.Summon then
		return res
	end
	return not res
end

-- 攻击方是友方
function SkillJudger:CasterIsTeammate(oSkill, caster, target, res)
	local myTeamID = oSkill.card:GetTeamID()
	if myTeamID == caster:GetTeamID() then
		return res
	end
	return not res
end

-- 攻击方是敌方
function SkillJudger:CasterIsEnemy(oSkill, caster, target, res)
	--LogDebugEx("CasterIsEnemy", caster.name, oSkill.card.name, oSkill.card:GetTeamID(), caster:GetTeamID())
	local myTeamID = oSkill.card:GetTeamID()
	if myTeamID ~= caster:GetTeamID() then
		return res
	end
	return not res
end

-- 攻击方是召唤物
function SkillJudger:CasterIsSummon(oSkill, caster, target, res)
	if caster.type == CardType.Summon then
		return res
	end
	return not res
end

-- 攻击方是召唤主
function SkillJudger:CasterIsSummoner(oSkill, caster, target, res)
	local summon = oSkill.card
	if (summon.type == CardType.Summon or summon.bSummonTeammate) and summon.oSummonOwner and summon.oSummonOwner == caster then
		return res
	end
	return not res
end

function SkillJudger:CasterIsSummoner2(oSkill, caster, target, res)
	local summon = caster.oSummonObj
	if not summon then return not res end -- 没有召唤物

	if (summon.type == CardType.Summon or summon.bSummonTeammate) and summon.oSummonOwner and summon.oSummonOwner == caster then
		return res
	end
	return not res
end

-- 攻击方是自己的召唤物
function SkillJudger:CasterIsOwnSummon(oSkill, caster, target, res)
	local summon = oSkill.card
	-- LogDebugEx("CasterIsOwnSummon", summon.name)  --oSummoner
	if (caster.type == CardType.Summon or caster.bSummonTeammate) and caster.oSummonOwner and caster.oSummonOwner == summon  then
		return res
	end
	return not res
end

-- 攻击方是合体怪
function SkillJudger:CasterIsUnite(oSkill, caster, target, res)
	if caster:IsUnite() then
		return res
	end
	return not res
end


-- 受击方是自己
function SkillJudger:TargetIsSelf(oSkill, caster, target, res)
	--LogDebugEx("TargetIsSelf", target.name, oSkill.card.name)
	if oSkill.card == target then
		return res
	end
	return not res
end


-- 攻击方是唤物
function SkillJudger:CasterIsMonster(oSkill, caster, target, res)
	if caster.type == CardType.Monster or caster.type == CardType.Boss  then
		return res
	end
	return not res
end

-- 受击方是怪物
function SkillJudger:TargetIsMonster(oSkill, caster, target, res)
	if target.type == CardType.Monster or target.type == CardType.Boss  then
		return res
	end
	return not res
end

-- 受击方是友方
function SkillJudger:TargetIsFriend(oSkill, caster, target, res)
	local myTeamID = oSkill.card:GetTeamID()
	if myTeamID == target:GetTeamID() then
		return res
	end
	return not res
end

-- 受击方是队友
function SkillJudger:TargetIsTeammate(oSkill, caster, target, res)
	local myTeamID = oSkill.card:GetTeamID()
	if myTeamID == target:GetTeamID() and oSkill.card ~= target and target.type ~= CardType.Summon then
		return res
	end
	return not res
end

-- 受击方是敌方
function SkillJudger:TargetIsEnemy(oSkill, caster, target, res)
	local myTeamID = oSkill.card:GetTeamID()
	if myTeamID ~= target:GetTeamID() then
		return res
	end
	return not res
end

-- 受击方是召唤物
function SkillJudger:TargetIsSummon(oSkill, caster, target, res)
	if target.type == CardType.Summon then
		return res
	end
	return not res
end

-- 受击方是召唤主
function SkillJudger:TargetIsSummoner(oSkill, caster, target, res)
	local summon = oSkill.card
	if (summon.type == CardType.Summon or summon.bSummonTeammate) and summon.oSummonOwner and summon.oSummonOwner == target then
		return res
	end
	return not res
end


-- 攻击方种族
function SkillJudger:CasterRace(oSkill, caster, target, res, typ)
	if target.tRace == typ then
		return res
	end
	return not res
end

-- 受击方种族
function SkillJudger:TargetRace(oSkill, caster, target, res, typ)
	if target.tRace == typ then
		return res
	end
	return not res
end

-- 攻击方类型
function SkillJudger:CasterType(oSkill, caster, target, res, typ)
	if target.tType == typ then
		return res
	end
	return not res
end

-- 受击方类型
function SkillJudger:TargetType(oSkill, caster, target, res, typ)
	if target.tType == typ then
		return res
	end
	return not res
end

-- 攻击方体型
function SkillJudger:CasterBody(oSkill, caster, target, res, typ)
	if target.tBody == typ then
		return res
	end
	return not res
end

-- 受击方体型
function SkillJudger:TargetBody(oSkill, caster, target, res, typ)
	if target.tBody == typ then
		return res
	end
	return not res
end



-- 1、自己血量比>=xx%
function SkillJudger:CasterPercentHp(oSkill, caster, target, res, percent)
	local myPercent = caster.hp/caster:Get("maxhp")
	if myPercent >= percent then 
		return res
	end
	return not res
end

-- 2、技能所有者血量比>=xx%
function SkillJudger:OwnerPercentHp(oSkill, caster, target, res, percent)
	local myPercent = oSkill.card.hp/oSkill.card:Get("maxhp")
	LogDebugEx("OwnerPercentHp---", oSkill.card.name ,oSkill.card.hp, oSkill.card:Get("maxhp"), res, percent, myPercent >= percent)
	if myPercent >= percent then 
		return res
	end
	return not res
end

-- 3、目标血量比>=xx%
function SkillJudger:TargetPercentHp(oSkill, caster, target, res, percent)
	local myPercent = target.hp/target:Get("maxhp")
	LogDebugEx("TargetPercentHp---", target.name, target.hp, target:Get("maxhp"), res, percent, myPercent >= percent)
	if myPercent >= percent then 
		return res
	end
	return not res
end

-- 是否为单体技能(被动用)
function SkillJudger:IsSingle(oSkill, caster, target, res)
	if caster.currentSkill and caster.currentSkill.isSingle then
	-- if oSkill.isSingle then
		return res
	end
	return not res
end

-- 是否为伤害技能(被动用)
function SkillJudger:IsCanHurt(oSkill, caster, target, res)
	if caster.currentSkill and caster.currentSkill.isCanHurt then
		return res
	end
	return not res
end

-- 伤害类型
function SkillJudger:IsDamageType(oSkill, caster, target, res, ty)
	if caster.currentEDamage and caster.currentEDamage == ty then
		return res
	end
	return not res
end


-- 是否为普通技能(被动用)
function SkillJudger:IsNormal(oSkill, caster, target, res, percent)
	--LogDebugEx("SkillJudger:IsNormal", caster.currentSkill.id, caster.currentSkill.isNormal)
	--LogTable(skill[caster.currentSkill.id])
	if caster.currentSkill and caster.currentSkill.isNormal then
		return res
	end
	return not res
end

-- 是否为反击技能(被动用)
function SkillJudger:IsBeatBack(oSkill, caster, target, res, percent)

	-- local mgr = oSkill.team.fightMgr
	if caster.currentSkill and caster.currentSkill.callSkillType and caster.currentSkill.callSkillType == "BeatBack" then
		return res
	end
	return not res
end

-- 是否为追击技能(被动用)
function SkillJudger:IsBeatAgain(oSkill, caster, target, res, percent)

	if caster.currentSkill and caster.currentSkill.callSkillType and caster.currentSkill.callSkillType == "BeatAgain" then
		return res
	end
	return not res
end

-- 是否为协助技能(被动用)
function SkillJudger:IsOnHelp(oSkill, caster, target, res, percent)

	if caster.currentSkill and caster.currentSkill.callSkillType and caster.currentSkill.callSkillType == "OnHelp" then
		return res
	end
	return not res
end

-- 是否为CallSkill技能
function SkillJudger:IsCallSkill(oSkill, caster, target, res, percent)
	if caster.currentSkill and caster.currentSkill.callSkillType then
		return res
	end
	return not res
end

-- 是否为指挥官技能(被动用)
function SkillJudger:IsCommander(oSkill, caster, target, res, percent)
	--LogDebugEx("SkillJudger:IsNormal", caster.currentSkill.id, caster.currentSkill.isNormal)
	--LogTable(skill[caster.currentSkill.id])
	if caster.currentSkill and caster.currentSkill.isCommander then
		return res
	end
	return not res
end

-- 是否为普通技能(被动用)
function SkillJudger:IsNear(oSkill, caster, target, res, percent)
	if caster.currentSkill and caster.currentSkill.isNear then
		return res
	end
	return not res
end

-- 是否为第x技能(被动用)
function SkillJudger:IsTypeOf(oSkill, caster, target, res, ty)
	--LogDebugEx("SkillJudger:IsNormal", caster.currentSkill.id, caster.currentSkill.isNormal)
	--LogTable(skill[caster.currentSkill.id])

	if caster.currentSkill and caster.currentSkill.upgrade_type == ty then
		return res
	end
	return not res
end

-- 是否大招技能(被动用)
function SkillJudger:IsUltimate(oSkill, caster, target, res)

	LogDebugEx("是否大招", caster.name, caster.currentSkill and caster.currentSkill.upgrade_type or "nil")

	if caster.currentSkill and 
		(caster.currentSkill.upgrade_type == CardSkillUpType.C or 
			caster.currentSkill.upgrade_type == CardSkillUpType.OverLoad) then
		return res
	end
	return not res
end

-- 是否为全体攻击技能(被动用)
function SkillJudger:IsALLRange(oSkill, caster, target, res, ty)
	--LogDebugEx("SkillJudger:IsALLRange", caster.currentSkill.id, caster.currentSkill.range_key)
	--LogTable(skill[caster.currentSkill.id])

	if caster.currentSkill and caster.currentSkill.range_key == "all" then
		return res
	end
	return not res
end

local littleRange = {}
littleRange.one_row = true
littleRange.one_col = true
littleRange.tian    = true
littleRange.shizi   = true
-- littleRange.two_row = true
-- littleRange.two_col = true

-- 是否为小范围攻击技能(被动用)
function SkillJudger:IsLittleRange(oSkill, caster, target, res, ty)
	--LogDebugEx("SkillJudger:IsLittleRange", caster.currentSkill.id, caster.currentSkill.range_key)
	--LogTable(skill[caster.currentSkill.id])

	if caster.currentSkill and littleRange[caster.currentSkill.range_key] then
		return res
	end
	return not res
end


-- 控制类型
function SkillJudger:IsCtrlType(oSkill, caster, target, res, typ)
	if caster.currentSkill and 
		caster.currentSkill.ctrlType and 
		caster.currentSkill.ctrlType == typ then
		return res
	end
	return not res
end

-- 比较属性
function SkillJudger:CompareAttr(oSkill, caster, target, res, attr)
	if caster:Get(attr) > target:Get(attr) then
		return res
	end
	return not res
end

-- 是否当前技能
function SkillJudger:IsCurrSkill(oSkill, caster, target, res)
	if caster.currentSkill and caster.currentSkill == oSkill then
		return res
	end
	return not res
end

-- 大于
function SkillJudger:Greater(oSkill, caster, target, res, a, b)
	if a > b then
		return res
	end
	return not res
end

-- 大于等于
function SkillJudger:GreaterEqual(oSkill, caster, target, res, a, b)
	if a >= b then
		return res
	end
	return not res
end

-- 小于
function SkillJudger:Less(oSkill, caster, target, res, a, b)
	if a < b then
		return res
	end
	return not res
end

-- 小于等于
function SkillJudger:LessEqual(oSkill, caster, target, res, a, b)
	if a <= b then
		return res
	end
	return not res
end

-- 等于
function SkillJudger:Equal(oSkill, caster, target, res, a, b)
	if a == b then
		return res
	end
	return not res
end

-- 判断是否在CD中
function SkillJudger:CheckCD(oSkill, caster, target, res)
	if oSkill.curr_cd > 0 then 
		return res
	end

	return not res
end

-- 是否暴击
function SkillJudger:IsCrit(oSkill, caster, target, res)
	local mgr = oSkill.team.fightMgr
	if mgr.isCrit then 
		return res
	end

	return not res
end

-- 判断当前回合是否有暴击
function SkillJudger:HasCrit(oSkill, caster, target, res)

	if oSkill.bIsCrit then 
		return res
	end

	return not res
end

-- 判断目标护甲类型
function SkillJudger:IsTargetCareer(oSkill, caster, target, res, typ)

	if target.career == typ then 
		return res
	end

	return not res
end

-- 判断施法者护甲类型
function SkillJudger:IsCasterCareer(oSkill, caster, target, res, typ)

	if caster.career == typ then 
		return res
	end

	return not res
end

-- 判断目标兵种
function SkillJudger:IsTargetMech(oSkill, caster, target, res, typ)

	LogDebugEx("SkillJudger:IsTargetMech", target.name, target.sMech, typ)
	if target.sMech == typ then 
		return res
	end

	return not res
end

-- 判断施法者兵种
function SkillJudger:IsCasterMech(oSkill, caster, target, res, typ)


	LogDebugEx("SkillJudger:IsCasterMech", caster.name, caster.sMech, typ)
	if caster.sMech == typ then 
		return res
	end

	return not res
end


-- 判断进度条小于
function SkillJudger:IsProgressLess(oSkill, caster, target, res, val)

	if target.progress < val then 
		return res
	end

	return not res
end

-- 判断进度最慢
function SkillJudger:IsMinProgress(oSkill, caster, target, res)
	local mgr = oSkill.team.fightMgr
	local card = nil
	local curr = mgr.currTurn

	for i,v in ipairs(mgr.arrCard) do
		if v:IsLive() and v ~= curr and v ~= target and target.progress > v.progress then
			return not res
		end
	end
	return res
end

-- 判断进度低于一半
function SkillJudger:IsHalfProgress(oSkill, caster, target, res)
	if not target then return end
	local mgr = oSkill.team.fightMgr
	local curr = mgr.currTurn
	ASSERT(curr)
	local data = mgr:GetProgress()
	-- LogTable(data, "IsHalfProgress---")
	for i,v in ipairs(data) do
		if v.id == curr.oid then -- 当前当最快
			table.remove(data,i)
			table.insert(data, 1, v)
		end
	end
	local half = (#data)/2
	-- LogTable(data, "IsHalfProgress")
	-- LogDebugEx("IsHalfProgress", half, target.oid, res)
	for i,v in ipairs(data) do
		-- LogDebugEx("---", v.id , target.oid, i <= half)
		if v.id == target.oid then
			if i >= half then 
				-- ASSERT()
				return res
			end

			return not res
		end
	end
	return not res
end


-- 判断我方/敌方是否存在buff（ID）
function SkillJudger:HasBuff(oSkill, caster, target, res, teamID, buffID, typ)
	local mgr = oSkill.team.fightMgr
	-- local team
	-- if teamID == 1 then
	-- 	team = mgr:GetTeam(caster:GetTeamID())
	-- else
	-- 	team = mgr:GetTeam(mgr:GetEnemyTeamID(caster))
	-- end

	local team = SkillFilter:GetTeam(oSkill, caster, target, teamID)

	if team:HasBuff(buffID, typ) then
		return res
	else
		return not res
	end
end

-- 判断是否存在角色
function SkillJudger:HasRole(oSkill, caster, target, res, teamID, cId)
	local team = SkillFilter:GetTeam(oSkill, caster, target, teamID)
	if team:HasRole(cId) then
		return res
	else
		return not res
	end
end


-- 是否兄妹
function SkillJudger:IsSibling(oSkill, caster, target, res, charID)

	if target.id == charID then
		return res
	else
		return not res
	end
end

-- 攻击方是否兄妹
function SkillJudger:IsCasterSibling(oSkill, caster, target, res, charID)
	local card_id = caster.card_id or 0
	if caster.id == charID or card_id == charID then
		return res
	else
		return not res
	end
end


-- 判断护盾是否被打暴
function SkillJudger:IsShieldDestroy(oSkill, caster, target, res)

	if oSkill.shield and oSkill.shield <= 0 then
		return res
	else
		return not res
	end
end

-- 是否活着
function SkillJudger:IsLive(oSkill, caster, target, res)

	if target:IsLive() then
		return res
	else
		return not res
	end
end

-- 是否活着
function SkillJudger:TargetIndex(oSkill, caster, target, res, nIndex)

	if oSkill:GetTargetIndex() == nIndex then
		return res
	else
		return not res
	end
end

-- 是否控制buff(group)
function SkillJudger:IsCtrlBuff(oBuff, caster, target, res, typ)
	typ = typ or BuffGroup.Ctrl
	LogDebugEx("IsCtrlBuff", oBuff.group, BuffGroup.Ctrl)
	-- LogTable(oBuff, "IsCtrlBuff")
	if oBuff.group == typ then
		return res
	else
		return not res
	end
end

-- 是否控制buff(type)
function SkillJudger:IsCtrlBuffType(oBuff, caster, target, res, typ)
	typ = typ or BuffGroup.Ctrl
	LogDebugEx("IsCtrlBuff", oBuff.type, BuffGroup.Ctrl)
	-- LogTable(oBuff, "IsCtrlBuff")
	if oBuff.type == typ then
		return res
	else
		return not res
	end
end

-- 攻击方是buff创建者
function SkillJudger:IsCasterBuff(oBuff, caster, target, res)
	if oBuff.creater == caster then
		return res
	else
		return not res
	end
end

-- 受击方是buff创建者
function SkillJudger:IsTargetBuff(oBuff, caster, target, res)
	if oBuff.creater == target then
		return res
	else
		return not res
	end
end

-- 目标是否有召唤物
function SkillJudger:HasSummoner(oBuff, caster, target, res)
	if target.oSummoner then
		return res
	else
		return not res
	end
end
---------------------------------
SkillApi = {}
-- 对象选择 1攻击者,2受击者,3技能拥有者, 4buff的创建者 5召唤物 6召唤主
function SkillApi:Filter(oSkill, caster, target, filter)
	local card = caster
	if filter == 1 then
		card = caster
	elseif filter == 2 then
		card = target
	elseif filter == 3 then
		card = oSkill.card
	elseif filter == 4 then
		card = oSkill.creater
	elseif filter == 5 then -- 5和6在使用的时候要注意一下, 有可能获取的对象是nil
		card = oSkill.card.oSummonObj
	elseif filter == 6 then
		card = oSkill.card.oSummonOwner
	end
	--LogDebugEx("SkillApi:Filter", card.name)
	return card
end

-- -- 获取buff数量(按组)
-- function BuffMgr:GetBufferCountGroup(group)
-- -- 获取buff数量(按好坏的性质)
-- function BuffMgr:GetBufferCountQuality(group)
-- -- 获取buff数量(按ID)
-- function BuffMgr:GetBufferCountID(group)

-- 获取施法者buff数量
function SkillApi:BuffCount(oSkill, caster, target, filter, typ, group)

	--LogDebugEx("SkillApi:BuffCount", caster.name, target.name, filter)
	local card = self:Filter(oSkill, caster, target, filter)
	--ASSERT(card)


	if typ == 1 then
		return card.bufferMgr:GetBufferCountGroup(group)
	elseif typ == 2 then
		return card.bufferMgr:GetBufferCountQuality(group)
	elseif typ == 3 then	
		--ASSERT(card.bufferMgr)
		return card.bufferMgr:GetBufferCountID(group)
	elseif typ == 4 then	
		return card.bufferMgr:GetBufferCountType(group)
	end
	return 0
end

-- 获取指定buff的回合数
function SkillApi:BuffRound(oSkill, caster, target, filter, group)

	--LogDebugEx("SkillApi:BuffCount", caster.name, target.name, filter)
	local card = self:Filter(oSkill, caster, target, filter)
	--ASSERT(card)

	return card.bufferMgr:GetBufferRound(group)
end


-- 存活数量
function SkillApi:LiveCount(oSkill, caster, target, teamID)
	-- local mgr = oSkill.team.fightMgr
	-- local team
	-- if teamID == 1 then
	-- 	team = mgr:GetTeam(caster:GetTeamID())
	-- else
	-- 	team = mgr:GetTeam(mgr:GetEnemyTeamID(caster))
	-- end

	local team = SkillFilter:GetTeam(oSkill, caster, target, teamID)
	return team:LiveCount(CardType.Summon)
end


-- 获取所属小队成员数量
function SkillApi:ClassCount(oSkill, caster, target, teamID, nClass)
	local team = SkillFilter:GetTeam(oSkill, caster, target, teamID)
	return team:ClassCount(nClass)
end

-- 死亡数量
function SkillApi:DeathCount(oSkill, caster, target, teamID)
	-- local mgr = oSkill.team.fightMgr
	-- local team
	-- if teamID == 1 then
	-- 	team = mgr:GetTeam(caster:GetTeamID())
	-- else
	-- 	team = mgr:GetTeam(mgr:GetEnemyTeamID(caster))
	-- end
	local team = SkillFilter:GetTeam(oSkill, caster, target, teamID)
	return team:DeathCount(CardType.Summon)
end

-- 属性
function SkillApi:GetAttr(oSkill, caster, target, filter, attr)
	local card = self:Filter(oSkill, caster, target, filter)
	if not card then return end 
	--LogDebugEx("SkillApi:GetAttr", card.name, attr, card:Get(attr))
	return card:Get(attr)
end

-- 获取队伍NP
function SkillApi:GetNP(oSkill, caster, target, teamID)
	local team = SkillFilter:GetTeam(oSkill, caster, target, teamID)
	local mgr = oSkill.team.fightMgr
	return mgr:GetNP(team:GetTeamID())
end

-- 血量百分比
function SkillApi:PercentHp(oSkill, caster, target, filter, attr)
	local card = self:Filter(oSkill, caster, target, filter)
	return card.hp/card:Get("maxhp")
end

-- 伤害量
function SkillApi:GetDamage(oSkill, caster, target, filter)
	local card = self:Filter(oSkill, caster, target, filter)
	return card.nSkillDamage or 0
end

-- 最后一击的伤害量
function SkillApi:GetLastHitDamage(oSkill, caster, target, filter)
	local card = self:Filter(oSkill, caster, target, filter)
	return card.nLastHitDamage or 0
end

-- 过量伤害(死亡时那一击)
function SkillApi:GetOverDamage(oSkill, caster, target, filter)
	local card = self:Filter(oSkill, caster, target, filter)
	return card.nOverDamage or 0
end

-- 过量伤害(总过量伤害)
function SkillApi:GetOverDamageTotal(oSkill, caster, target, filter)
	local card = self:Filter(oSkill, caster, target, filter)
	return card.nOverDamageTotal or 0
end

-- 获取当前技能等级
function SkillApi:SkillLevel(oSkill, caster, target, filter, skillID)
	local card = self:Filter(oSkill, caster, target, filter)
	LogDebugEx("SkillApi:SkillLevel", card.name, skillID)
	LogTable(card.skillMgr.list, "card.skillMgr")
	local oskill = card.skillMgr:GetSkillByID(skillID)
	if not oskill then return 0 end
	-- ASSERT(oskill, card.name .. ":没有这个技能"..skillID)
	return oskill.lv
end

-- 当前治疗量
function SkillApi:GetCureHp(oSkill, caster, target, filter)
	local card = self:Filter(oSkill, caster, target, filter)
	return card.currCureHp or 0
end

-- 获取能量值
function SkillApi:GetEnergy(oSkill, caster, target, filter)
	local card = self:Filter(oSkill, caster, target, filter)
	return card:GetValue("energy") or 0
end

-- 获取蓄能（怒气值）
function SkillApi:GetFury(oSkill, caster, target, filter)
	local card = self:Filter(oSkill, caster, target, filter)
	return card:GetValue("fury") or 0
end

-- 获取分摊伤害量OnAfterHurt中使用
function SkillApi:GetShareDamage(effect, caster, target, data)
	LogDebugEx("获取分摊伤害", target.nShareDamage)
	return target.nShareDamage or 0
end

-- 获取被伤害量
function SkillApi:GetBeDamage(oSkill, caster, target, filter)
	local card = self:Filter(oSkill, caster, target, filter)
	LogDebugEx("获取被伤害量", card.nBeSkillDamage)
	return card.nBeSkillDamage or 0
end

-- 获取被物理伤害量
function SkillApi:GetBeDamagePhysics(oSkill, caster, target, filter)
	local card = self:Filter(oSkill, caster, target, filter)
	LogDebugEx("获取被物理伤害量", card.nBeSkillDamagePhysics)
	return card.nBeSkillDamagePhysics or 0
end

-- 获取被光束伤害量
function SkillApi:GetBeDamageLight(oSkill, caster, target, filter)
	local card = self:Filter(oSkill, caster, target, filter)
	LogDebugEx("获取被光束伤害量", card.nBeSkillDamageLight)
	return card.nBeSkillDamageLight or 0
end

-- 获取当前buff层数
function SkillApi:GetCount(oSkill, caster, target, filter, buffID)
	local card = self:Filter(oSkill, caster, target, filter)
	local oBuffMgr = card.bufferMgr
	return oBuffMgr:GetCount(buffID)
end

-- 获取当前操作数
function SkillApi:GetTurnCount(oSkill, caster, target)
	local mgr = oSkill.team.fightMgr
	LogDebugEx("SkillApi:GetTurnCount", ((mgr.nStepPVE or 0) - (oSkill.card.startopnum or 0)), oSkill.card.startopnum, mgr.nStepPVE, oSkill.card.name)
	-- return ((mgr:GetCurrStep() or 0) - (oSkill.card.startopnum or 0))
	return ((mgr:GetCurrStep() or 0) - (mgr.nInvStartopnum or 0))
end

-- 获取当前操作数(pvp)
function SkillApi:GetStep(oSkill, caster, target)
	local mgr = oSkill.team.fightMgr
	return mgr.nStep
end

-- 总伤害
function SkillApi:GetTotalDamage(oSkill, caster, target, filter)
	local mgr = oSkill.team.fightMgr
	return mgr.nInvTotalDamage or 0
end

-- 阶段伤害
function SkillApi:GetStateDamage(oSkill, caster, target, filter)
	LogDebugEx("SkillApi:GetStateDamage", oSkill.card.nStateDamage, oSkill.card.name)
	local mgr = oSkill.team.fightMgr
	return mgr.nInvStateDamage or 0
end

--获取最大恢复血量(默认是最大血量)
function SkillApi:GetMaxCureHp(oSkill, caster, target, filter)
	local card = self:Filter(oSkill, caster, target, filter)
    if card.fCurePercent then
        local max = math.floor(card:Get("maxhp") * card.fCurePercent) -- 每次重新计算回血最大血量, 避免最大血量调整需要重新计算
        return max
    end
    return card:Get("maxhp")
end

-- 获取队伍当前总血量
function SkillApi:GetTeamHP(oSkill, caster, target,teamID)
	local team = SkillFilter:GetTeam(oSkill, caster, target, teamID)
	return team:GetHp()
end

-- 获取队伍当前总血量上限
function SkillApi:GetTeamMaxHP(oSkill, caster, target,teamID)
	local team = SkillFilter:GetTeam(oSkill, caster, target, teamID)
	return team:GetMaxHp()
end

-- 获取装备技能
function SkillApi:GetOwnerEquipSkills(oSkill, caster, target)

	local oSummonOwner = self:Filter(oSkill, caster, target, 6)  --获取召唤主
    if oSummonOwner then
		local mgr = oSummonOwner.skillMgr
		return mgr.equipSkills or {}
    end
    return {}
end

----------------------------------------------
-- 技能基类
FightAPI = oo.class()

function FightAPI:Init(skillID)
end

function FightAPI:Destroy()
	-- LogDebugEx("FightAPI:Destroy()", self.name)
    for k,v in pairs(self) do
        self[k] = nil
    end
end

------------------技能和buffer通用api---------------------------------

-- 通用加buff
function FightAPI:AddBuff(effect, caster, target, data, buffID, nRoundNum)
	LogDebugEx("FightAPI:AddBuff", buffID, nRoundNum)
	-- local effect = SkillEffect[effectID]
	local buff = nil

	-- LogTrace()
	-- LogDebugEx("FightAPI:AddBuff", self.isSingle , self.isCanHurt , target.bIgnoreSingleAttack)
	-- 无视单攻
	if caster ~= target and self.isSingle and self.isCanHurt and target.bIgnoreSingleAttack then
		local log = {api="MissBuff", id = caster.oid, targetID = target.oid, 
			bufferID = buffID, effectID = effect.apiSetting}
		self.log:Add(log)
		return
	end

	LogDebug("AddBuff = %s, %s, %s, %s", effectID, self.name, caster.name, target.name)
	if target:IsLive() then
		local buff = target:AddBuff(caster, buffID, nRoundNum, effect.apiSetting)
		return buff
	end
end

-- 概率加buffer
function FightAPI:RandAddBuff(effect, caster, target, data, rand, buffID, nRoundNum)
	-- local effect = SkillEffect[effectID]
	local buff = nil

	-- 无视单攻
	if self.isSingle and self.isCanHurt and target.bIgnoreSingleAttack then
		local log = {api="MissBuff", id = caster.oid, targetID = target.oid, 
			bufferID = buffID, effectID = effect.apiSetting}
		self.log:Add(log)
		return
	end

	local r = self.card:Rand(10000)
	LogDebugEx("概率加buffer", r, rand, r <= rand)
	if target:IsLive() and r <= rand then
		local buff = target:AddBuff(caster, buffID, nRoundNum, effect.apiSetting)
	end
	-- LogTrace("RandAddBuff = %s, %s, %s, %s", effectID, self.name, caster.name, target.name)
end

-- 计算加buff 命中效果
function FightAPI:CalcHitAddBuff(effect, caster, target, data, base, buffID, nRoundNum)
	-- local effect = SkillEffect[effectID]

	-- 攻击方死了怎么还能调到这里, 原来是被技能反弹死的
	--LogDebugEx("FightAPI:HitAddBuff", caster:IsLive(), target:IsLive())
	if not caster:IsLive() then return end -- 死后不能再加嘲讽buff

	local buff = nil

	base = base / 10000
	-- for i,target in ipairs(targets) do
		if target:IsLive() then

			-- 无视单攻
			if self.isSingle and self.isCanHurt and target.bIgnoreSingleAttack then
				local log = {api="MissBuff", id = caster.oid, targetID = target.oid, 
					bufferID = buffID, effectID = effect.apiSetting}
				self.log:Add(log)
				return
			end

			-- LogDebugEx("-----------------------------")
			-- LogDebugEx(caster:Get("hit"), caster:Get("resist"), target:Get("hit"), target:Get("resist"))
			-- 状态未命中概率=MAX(0,1-技能基础概率*(1+OP状态命中))										
			local notHit = math.max(0,1-base*(1+caster:Get("hit")))
			-- 状态命中概率= MIN(1,MAX(0,技能基础概率*(1+OP状态命中-TP状态抵抗)))										
			local hit = math.min(1, math.max(0,base*(1+caster:Get("hit")-target:Get("resist"))))  
			-- 状态抵抗概率=1-效果未命中概率-效果命中概率										
			local hitAndResist = 1 - notHit - hit

			local r = self.card:Rand(10000)/10000
			-- LogDebugEx("HitAddBuff percent ", notHit, hit, hitAndResist, r)

			LogDebug("命中效果 -- caster.hit[%s], target.resist[%s],  不中[%s], 命中[%s], 抵抗[%s], 随机数[%s]",
				caster:Get("hit"), target:Get("resist"), notHit, hit, hitAndResist, r)
			if r <= notHit then
				-- 未命中
				local log = {api="MissBuff", id = caster.oid, targetID = target.oid, 
					bufferID = buffID, effectID = effect.apiSetting, notHit = true}
				self.log:Add(log)
			elseif r <= notHit+hit then
				-- 真正命中
				-- local buff = target:AddBuff(caster, buffID, nRoundNum, effect.apiSetting)
				-- -- LogTrace("HitAddBuff = %s, %s, %s, %s", effectID, self.name, caster.name, target.name)
				-- return buff
				return true
			else
				-- 命中但抵抗
				local log = {api="MissBuff", id = caster.oid, targetID = target.oid, 
					bufferID = buffID, effectID = effect.apiSetting}
				self.log:Add(log)
			end
		end
	-- end
end

-- 加buff 命中效果
function FightAPI:HitAddBuff(effect, caster, target, data, base, buffID, nRoundNum)
	if self:CalcHitAddBuff(effect, caster, target, data, base, buffID, nRoundNum) then
		local buff = target:AddBuff(caster, buffID, nRoundNum, effect.apiSetting)
		-- LogTrace("HitAddBuff = %s, %s, %s, %s", effectID, self.name, caster.name, target.name)
		return buff
	end
end

-- 拥有者给目标加buff 命中效果
function FightAPI:OwnerHitAddBuff(effect, caster, target, data, base, buffID, nRoundNum)
	local caster = self.card
	if self:CalcHitAddBuff(effect, caster, target, data, base, buffID, nRoundNum) then
		local buff = target:AddBuff(caster, buffID, nRoundNum, effect.apiSetting)
		-- LogTrace("HitAddBuff = %s, %s, %s, %s", effectID, self.name, caster.name, target.name)
		return buff
	end
end

-- 添加关联buff
function FightAPI:RelevanceBuff(effect, caster, target, data, buffID1, buffID2, nRoundNum, isHitRate)

	if not target:IsLive() then return end
	if caster == target then ASSERT(nil, "关联buff的对象不能是自己") end

	local config = BufferConfig[buffID1]
	ASSERT(config, "buffID="..buffID1)

	-- 判断buffer是否免疫
	if caster:GetTempBuffEffct("ImmuneBuffQuality"..config.goodOrBad) then 
		-- log.abnormalities = "ImmuneBuffQuality"..config.goodOrBad
		return
	end

	if caster:GetTempBuffEffct("ImmuneBufferGroup"..config.group) then 
		-- log.abnormalities = "ImmuneBufferGroup"..config.group
		return
	end

	if caster:GetTempBuffEffct("ImmuneBuffID"..config.id) then 
		-- log.abnormalities = "ImmuneBuffID"..config.id
		return
	end	

	local buff2
	if isHitRate then
		buff2 = self:HitAddBuff(effect, caster, target, data, isHitRate, buffID2, nRoundNum)
	else
		buff2 = target:AddBuff(caster, buffID2, nRoundNum, effect.apiSetting)
	end
	if not buff2 then return end

	-- 这个一定是加成功的
	local buff1 = caster:AddBuff(caster, buffID1, nRoundNum, effect.apiSetting)
	ASSERT(buff1)
	-- if not buff1 then 
	-- 	-- 加不成功删掉目标buff
	-- 	buff2.mgr:DelBuffer(buff2)
	-- 	return 
	-- end

	buff1:SetRelevanceBuff(buff2)
	buff2:SetRelevanceBuff(buff1)
end

-- 加buff层数
function FightAPI:AddBuffCount(effect, caster, target, data, buffID, nCount, limit)
	-- local effect = SkillEffect[effectID]
	local buff = nil

	-- LogTrace()
	-- LogDebugEx("FightAPI:AddBuff", self.isSingle , self.isCanHurt , target.bIgnoreSingleAttack)
	-- 无视单攻
	if caster ~= target and self.isSingle and self.isCanHurt and target.bIgnoreSingleAttack then
		local log = {api="MissBuff", id = caster.oid, targetID = target.oid, 
			bufferID = buffID, effectID = effect.apiSetting}
		self.log:Add(log)
		return
	end

	if target:IsLive() then
		local buff = target:AddBuffCount(caster, buffID, nCount, limit, effect.apiSetting)
		return buff
	end
	-- LogTrace("AddBuff = %s, %s, %s, %s", effectID, self.name, caster.name, target.name)
end

-- 拥有者给目标加buff层数
function FightAPI:OwnerAddBuffCount(effect, caster, target, data, buffID, nCount, limit)
	local caster = self.card
	return self:AddBuffCount(effect, caster, target, data, buffID, nCount, limit)
end

-- buff创建者给目标加buff层数
function FightAPI:CreaterAddBuffCount(effect, caster, target, data, buffID, nCount, limit)
	local caster = self.card
	return self:AddBuffCount(effect, self.creater, target, data, buffID, nCount, limit)
end

-- 加buff层数 命中效果
function FightAPI:HitAddBuffCount(effect, caster, target, data, base, buffID, nCount, limit)
	if self:CalcHitAddBuff(effect, caster, target, data, base, buffID, nCount) then
		-- LogTrace("HitAddBuff = %s, %s, %s, %s", effectID, self.name, caster.name, target.name)
		return self:OwnerAddBuffCount(effect, caster, target, data, buffID, nCount, limit)
	end
end


-- 偷取buff(target->caster)
function FightAPI:StealBuff(effect, caster, target, data, buffID, num)

	if not target:IsLive() then return end
	if caster == target then ASSERT(nil, "偷取buff的对象不能是自己") end

	local oBuffMgr = target.bufferMgr
	local list = oBuffMgr:StealBufferGroup(buffID, num)

	LogTable(list, "技能=")
	for i,buffer in ipairs(list) do
		local nRoundNum = buffer.round
		local buffID = buffer.id

		if nRoundNum then
			nRoundNum = nRoundNum + 1
		end
		
		buffer.mgr:DelBuffer(buffer, caster, target)
		buffer.fightMgr:DoEventWithLog("OnDelBuff", caster, target)
		caster:AddBuff(caster, buffID, nRoundNum, effect.apiSetting)
	end
end

-- 转移buff(caster->target)
function FightAPI:TransferBuff(effect, caster, target, data, buffID, num)

	if not target:IsLive() then return end
	if caster == target then ASSERT(nil, "转移buff的对象不能是自己") end

	local oBuffMgr = caster.bufferMgr
	local list = oBuffMgr:GetBufferByGroup(buffID, num)

	for i,buffer in ipairs(list) do
		local nRoundNum = buffer.round
		local buffID = buffer.id

		buffer.mgr:DelBuffer(buffer, caster, target)
		buffer.fightMgr:DoEventWithLog("OnDelBuff", caster, target)
		target:AddBuff(caster, buffID, nRoundNum, effect.apiSetting, eBufferAddType.Transfer)
	end
end

-- 扩散buff(caster->target)
function FightAPI:SpreadBuff(effect, caster, target, data, eType, buffID, num)

	if not target:IsLive() then return end
	if caster == target then ASSERT(nil, "扩散buff的对象不能是自己") end

	LogDebugEx("扩散buff", caster.name, target.name, eType, buffID, num)
	local oBuffMgr = caster.bufferMgr
	local list = {}
	if eType == 1 then
		list = oBuffMgr:GetBufferByGroup(buffID, num)
	elseif eType == 2 then
		list = oBuffMgr:GetBufferByType(buffID, num)
	elseif eType == 3 then
		list = oBuffMgr:GetBufferByID(buffID, num)
	else
		ASSERT(nil, "扩散类型不正确")
	end

	for i,buffer in ipairs(list) do
		local nRoundNum = buffer.round
		local buffID = buffer.id
		target:AddBuff(caster, buffID, nRoundNum, effect.apiSetting,eBufferAddType.Spread)
	end
end

-- 反射buff(caster->target)
function FightAPI:ReflectBuff(effect, caster, target, data, eType, groupID, rand, filter)

	if not target:IsLive() then return end
	if caster:GetTeamID() == target:GetTeamID() then return end
	if not self:Rand(rand) then 
		LogDebugEx("不反射buff")
		return 
	else
		LogDebugEx("反射buff")
	end

	local otarget = {caster}
	if filter == 2 then
		-- 攻击方随机一个, 排除自己
		otarget = SkillFilter:Rand(self, caster, target, 1, 1)
		if not otarget then 
			LogDebugEx("没有反射对象")
			return 
		end
	end

	-- 原受击者反给当前筛选的目标
	target.bufferMgr:ReflectBuff(eType, groupID, otarget)
	self:ShowTips(effect, caster, target, data, 2, "反射", true)
end

-- 驱散buff
function FightAPI:DelBuff(effect, caster, target, data, buffID, num, num2)
	local oBuffMgr = target.bufferMgr
	if num2 and num2 > num then
		num = self.card:RandEx(num, num2)
	end
	oBuffMgr:DelBufferID(caster, target, buffID, num, effect)
end

-- 强制删除buff(按id,不飘字, 不调事件)
function FightAPI:DelBufferForce(effect, caster, target, data, buffID, num, num2)
	local oBuffMgr = target.bufferMgr
	if num2 and num2 > num then
		num = self.card:RandEx(num, num2)
	end
	oBuffMgr:DelBufferIDForce(caster, target, buffID, num, effect)
end

-- 驱散buff(按好坏的性质)
function FightAPI:DelBuffQuality(effect, caster, target, data, buffID, num, num2)
	local oBuffMgr = target.bufferMgr
	if num2 and num2 > num then
		num = self.card:RandEx(num, num2)
	end
	oBuffMgr:DelBufferQuality(caster, target, buffID, num, effect)
end

-- 驱散buff(按组)
function FightAPI:DelBufferGroup(effect, caster, target, data, buffID, num, num2)
	local oBuffMgr = target.bufferMgr
	if num2 and num2 > num then
		num = self.card:RandEx(num, num2)
	end
	LogDebugEx(num, num2)
	LogDebug("DelBufferGroup GroupID[%s] num[%s], num2[%s]", buffID, num, num2)
	oBuffMgr:DelBufferGroup(caster, target, buffID, num, effect)
end

-- 强制删除buff(按组,不飘字, 不调事件)
function FightAPI:DelBufferGroupForce(effect, caster, target, data, buffID, num, num2)
	local oBuffMgr = target.bufferMgr
	if num2 and num2 > num then
		num = self.card:RandEx(num, num2)
	end
	oBuffMgr:DelBufferGroupForce(caster, target, buffID, num, effect)
end


-- 驱散buff(按type)
function FightAPI:DelBufferType(effect, caster, target, data, buffID, num, num2)
	local oBuffMgr = target.bufferMgr
	if num2 and num2 > num then
		num = self.card:RandEx(num, num2)
	end
	oBuffMgr:DelBufferType(caster, target, buffID, num, effect)
end

-- 强制删除buff(按type,不飘字, 不调事件)
function FightAPI:DelBufferTypeForce(effect, caster, target, data, buffID, num, num2)
	local oBuffMgr = target.bufferMgr
	if num2 and num2 > num then
		num = self.card:RandEx(num, num2)
	end
	oBuffMgr:DelBufferTypeForce(caster, target, buffID, num, effect)
end

-- 增加或减少buff回合
function FightAPI:AlterBufferByGroup(effect, caster, target, data, buffID, num)
	local oBuffMgr = target.bufferMgr
	oBuffMgr:AlterBufferByGroup(caster, target, buffID, num, effect)
end

-- 增加或减少buff回合
function FightAPI:AlterBufferByID(effect, caster, target, data, buffID, num)
	local oBuffMgr = target.bufferMgr
	oBuffMgr:AlterBufferByID(caster, target, buffID, num, effect)
end

-- 增加或减少随机一个buff的回合(Group)
function FightAPI:AlterRandBufferByGroup(effect, caster, target, data, buffID, num)
	local oBuffMgr = target.bufferMgr
	oBuffMgr:AlterRandBufferByGroup(caster, target, buffID, num, effect)
end

-- 增加或减少随机一个buff的回合(ID)
function FightAPI:AlterRandBufferByID(effect, caster, target, data, buffID, num)
	local oBuffMgr = target.bufferMgr
	oBuffMgr:AlterRandBufferByID(caster, target, buffID, num, effect)
end

-- 增加或减少随机一个buff的回合(Type)
function FightAPI:AlterRandBufferByType(effect, caster, target, data, type, num)
	local oBuffMgr = target.bufferMgr
	oBuffMgr:AlterRandBufferByType(caster, target, type, num, effect)
end

-- 拉条
function FightAPI:AddProgress(effect, caster, target, data, progress, max)

	LogDebugEx("拉条 AddProgress", target.name, max)
	if target:IsLive() then
		target:AddProgress(progress, max, effect.apiSetting, caster)
	end
end

-- 增加操作数上限
function FightAPI:AddStep(effect, caster, target, data, num, isHide)
	if caster:GetTeamID() ~= 1 then return end -- PVE只对我方有效
	
    local mgr = self.team.fightMgr
    mgr:AddStep(num, isHide)
end

function FightAPI:LimitAddStep(effect, caster, target, data, num)
    local mgr = self.team.fightMgr
    mgr:LimitAddStep(num)
end


function FightAPI:AddSp(effect, caster, target, data, num)
	ASSERT(target, "没有受击方")
	target:AddSP(num, effect.apiSetting)
end

function FightAPI:AddXp(effect, caster, target, data, num)
	ASSERT(target, "没有受击方")
	target:AddXP(num, effect.apiSetting)
end

function FightAPI:AddNp(effect, caster, target, data, num)
	ASSERT(target, "没有受击方")
	target:AddNP(num, effect.apiSetting)
end

function FightAPI:AddTempAttr(effect, caster, target, data, attr, num, num2)
	-- LogDebugEx("AddTempAttr---------------------------", target.name, attr, num)
	ASSERT(target, "没有受击方")
	if num2 then
		num = self:RandEx(num, num2, 1)
	end
	target:AddTempAttr(attr, num)
end

function FightAPI:AddTempAttrPercent(effect, caster, target, data, attr, num, num2, e)
	ASSERT(target, "没有受击方")
	if num2 then
		num = self:RandEx(num, num2, e)
	end
	target:AddTempAttrPercent(attr, num)
end

function FightAPI:CalcCure(caster, target, cureTy, percent)
	-- LogDebugEx("-----CalcCure-----", self.owner.name)
	local val = 0
	if cureTy == 1 then
		val = caster:Get("maxhp") * percent
	elseif cureTy == 2 then
		val = target:Get("maxhp") * percent
	elseif cureTy == 3 then
		val = caster:Get("attack") * percent
	elseif cureTy == 4 then
		caster.nSkillDamage = caster.nSkillDamage or 0
		val = caster.nSkillDamage * percent 
	elseif cureTy == 5 then
		caster.nLastHitDamage = caster.nLastHitDamage or 0
		val = caster.nLastHitDamage * percent
	elseif cureTy == 6 then
		val = self.card:Get("maxhp") * percent
	elseif cureTy == 7 then
		val = self.card:Get("defense") * percent
	elseif cureTy == 8 then
		val = self.creater:Get("maxhp") * percent
	elseif cureTy == 9 then
		val = self.creater:Get("attack") * percent
	elseif cureTy == 10 then
		val = self.creater:Get("defense") * percent	
	else
		ASSERT()
	end	

	val = math.floor(val)

	return val
end

-- 治疗
function FightAPI:Cure(effect, caster, target, data, cureTy, percent)
	-- self.order = self.order + 1
	local caster = self.card
	LogDebugEx("---FightAPI:CureEx---", caster.name, target.name)

	if not target:IsLive() then return 0 end -- 已经死了就不加血

	local mgr = self.team.fightMgr

	local damageAdjust = caster:Get("cure") * target:Get("becure")
	percent = percent * damageAdjust

	local hp = self:CalcCure(caster, target, cureTy, percent)

	LogDebugEx("FightAPI:Cure", hp, damageAdjust, caster:Get("cure") , target:Get("becure"))
	--LogTrace()
	-- ASSERT()
	hp = math.floor(hp)
	if hp <= 0 then return 0 end


	local spill = hp - (target:Get("maxhp") - target:Get("hp"))

	target:AddHp(hp)
	self.log:Add({api="AddHp", targetID = target.oid, attr = "hp", 
		hp = target:Get("hp"), add = hp, effectID = effect.apiSetting, order = self.order})

	target.currCureHp = hp -- 当前治疗量
	mgr:DoEventWithLog("OnCure", caster, target, data)
	target.currCureHp = nil

	-- if spill > 0 then return spill else return 0 end
	return spill
end

-- 溢出治疗
function FightAPI:SpillCure(effect, caster, target, data, cureTy, percent, spillType)
	local spill = self:Cure(effect, caster, target, data, cureTy, percent)
	if spill <= 0 then return end

	if spillType == 1 then
		-- 加盾
		target.currCureHp = spill -- 溢出量记到当前治疗量
		self:AddBuff(effect, caster, target, data, 2701)
		target.currCureHp = nil
	else
		-- 分摊到队友
		-- local filter = filter
		local arr = target.team.filter:GetAll(target)
		-- local arr = target.team.arrCard
		local count = #arr
		if count < 1 then return end -- 只剩自己
		local hp = math.floor(spill/count)
		if hp < 1 then return end 

		for k,v in ipairs(arr) do
			v:AddHp(hp)
			self.log:Add({api="AddHp", targetID = v.oid, attr = "hp", 
				hp = v:Get("hp"), add = hp, effectID = effect.apiSetting})
		end
	end
end

-- 恢复血量
function FightAPI:RestoreHP(effect, caster, target, data)
	-- self.order = self.order + 1
	LogDebugEx("---FightAPI:RestoreHP---", caster.name, target.name)

	if not target.isInvincible then return end
	target.hp = target.maxhp
	self.log:Add({api="RestoreHP", targetID = target.oid, attr = "hp", 
		hp = target:Get("hp"),  effectID = effect.apiSetting, order = self.order})
end

-- 无限血机制设置阶段[总阶段数, 阶段, 阶段血量, 操作数]
function FightAPI:SetInvincible(effect, caster, target, data, totalState, state, statehp, opnum)
	
	-- LogDebugEx("---FightAPI:SetInvincible---", caster.name, target.name)
	local target = self.card
	if not target.isInvincible then return end


	local mgr = self.team.fightMgr
	mgr:SetInvincible(effect, caster, target, data, totalState, state, statehp, opnum)
	-- target.nStateDamage = 0 -- 当前阶段伤害量
	-- target.totalState   = totalState -- 总阶段
	-- target.state        = state -- 阶段
	-- target.statehp      = statehp -- 阶段血量
	-- target.opnum        = opnum -- 操作数
	-- target.startopnum   = self.team.fightMgr.nStepPVE or 0 -- 阶段开始时的操作数
	self.log:Add({api="SetInvincible", --[[targetID = target.oid, ]]
		totalState = totalState, state = state, statehp = statehp, opnum = opnum,
		nStateDamage = 0, nTotalDamage = mgr.nInvTotalDamage, startopnum = mgr.nInvStartopnum, type= mgr.isInvincible,
		effectID = effect.apiSetting, order = self.order})

end

-- 强制结算 1胜利
function FightAPI:ForceOver(effect, caster, target, data, ret)

	-- if IS_CLIENT then return end
	local mgr = self.team.fightMgr
	if ret == 1 then
		-- -- mgr:Over(mgr.stage, 1)
		-- mgr.oForceOver = 1
		local team = mgr:GetTeam(2)
		-- if not team then
		-- 	mgr.oForceOver = 1
		-- end
		for i,v in ipairs(team.arrCard) do
			if v:IsLive() then
				v:ForceDeath(caster)
			end
		end
	else
		-- -- mgr:Over(mgr.stage, 2)
		-- mgr.oForceOver = 2
		local team = mgr:GetTeam(1)
		-- if not team then
		-- 	mgr.oForceOver = 2
		-- end
		for i,v in ipairs(team.arrCard) do
			if v:IsLive() then
				v:ForceDeath(caster)
			end
		end
	end
end

-- 复活
function FightAPI:Revive(effect, caster, target, data, cureTy, percent, sdata)

	--LogTrace()
	LogDebugEx("复活", caster.name, target.name)
	local mgr = self.team.fightMgr
	local target = mgr:GetCardByOID(data.target.reliveID)
	ASSERT(target)
	if target.isRemove then return end

	-- 删除所有buff
	local oBuffMgr = target.bufferMgr
	oBuffMgr:RemoveAll()

	local hp = self:CalcCure(caster, target, cureTy, percent)
	if hp <= 0 then
		hp = 1
	end

	target.grids = {}
	for k,v in pairs(sdata) do
		target[k] = v
	end
	target:SetPos(data.target.pos)
	target.team:SetGrids(data.target.pos[1], data.target.pos[2], target)
	
	target.hp = 0
	target.isLive = true
	target:AddHp(hp)

	-- 复活需要重新注册事件
	target.skillMgr:ReviveRegisterEvent()

	local info = target:GetShowData()

	self.log:Add({api="Revive", casterID = caster.oid, id = target.oid, 
		datas = {info}, effectID = effect.apiSetting})

	-- 还原
    target.skillMgr:Restore()

	mgr:OnBorn(target, true)
end

-- 被动复活
function FightAPI:PassiveRevive(effect, caster, target, data, cureTy, percent, sdata)
	-- LogTrace()
	LogDebugEx("被动复活", caster.name, target.name)
	local caster = self.card
	if target.isRemove then return end -- 禁止复活
	if target.isLive then return end -- 可能会有多个复活技能
	if caster ~= target and not caster.isLive then return end -- 不能自己死了还给别人复活

	-- 删除所有buff
	local oBuffMgr = target.bufferMgr
	oBuffMgr:RemoveAll()

	local hp = self:CalcCure(caster, target, cureTy, percent)
	if hp <= 0 then
		hp = 1
	end
	target.hp = 0
	target.isLive = true
	target:AddHp(hp)

	if sdata then
		for k,v in pairs(sdata) do
			target[k] = v
		end
	end

	local info = target:GetShowData()

	-- 复活需要重新注册事件
	target.skillMgr:ReviveRegisterEvent()

	self.log:Add({api="Revive", casterID = caster.oid, id = target.oid, 
		datas = {info}, effectID = effect.apiSetting})

	-- 还原
    target.skillMgr:Restore()

	self.team.fightMgr:OnBorn(target, true)
end

-- 关联召唤物主动复活
function FightAPI:SummonRevive(effect, caster, target, data)

	local card = self.card
	-- LogDebugEx("SummonRevive", card.name, card:IsLive())
	if not card:IsLive() or not card.oRelevanceCard then return end

	for i,oRelevanceCard in ipairs(card.oRelevanceCard) do
		if not oRelevanceCard:IsLive() then -- 死的才复活

			-- 删除所有buff
			local oBuffMgr = oRelevanceCard.bufferMgr
			oBuffMgr:RemoveAll()

			oRelevanceCard.hp = oRelevanceCard.maxhp
			oRelevanceCard.isLive = true

			local info = oRelevanceCard:GetShowData()
			oRelevanceCard.skillMgr:ReviveRegisterEvent()

			self.log:Add({api="Revive", casterID = card.oid, id = oRelevanceCard.oid, 
				datas = {info}, effectID = effect.apiSetting})

			-- 还原
		    oRelevanceCard.skillMgr:Restore()

			self.team.fightMgr:OnBorn(target, true)
		end
	end
end

-- 协战
function FightAPI:Help(effect, caster, target, data, ty, index,helpType,helpVal)
	LogDebugEx("FightAPI:bCallHelp------------", index,helpType,helpVal)

	-- 攻击方受击方是友方, 不触发协战
	if caster:GetTeamID() == target:GetTeamID() then return end

	local mgr = self.team.fightMgr

	-- if mgr.bCallHelp then return end
	-- mgr.bCallHelp = true

	if mgr.bInHelp then 
		-- LogTrace()
		return 
	end -- 禁止协战中触发协战

	-- index 支持同一回合多次触发
	mgr.bCallHelp = mgr.bCallHelp or {}
	index = index or 0
	helpType = helpType or 0
	if mgr.bCallHelp[index] then return end
	-- mgr.bCallHelp[index] = true
	-- LogTrace()

	local helper
	-- LogTable(data)
	if ty == 2 then
		-- 被动协助
		helper = {self.card}
	elseif ty == 1 then
		-- 主动协助
		if data.target and data.target.helperID then
			local mgr = self.team.fightMgr
			local t = mgr:GetCardByOID(data.target.helperID)
			ASSERT(t)
			helper = {t}
		elseif helpType == 1 and helpVal then					-- 属性最高
			local team = SkillFilter:GetTeam(self, caster, target, 1)
			helper = team.filter:GetMaxAttribute(helpVal,1,caster)
		else
			helper = SkillFilter:Rand(self, caster, target, 1, 1)
		end
	elseif ty == 3 then
		-- 召唤物主动协助
		if caster.oSummonObj and caster.oSummonObj:IsLive() then
			helper = {caster.oSummonObj}
		else
			return
		end
	else
		ASSERT(nil, "协助类型错误")
	end

	for k,v in ipairs(helper) do
		--LogDebugEx("name = ", v.name)
		if v ~= caster then
			-- self.log:Add({api="Help", id = caster.oid, helperID = v.oid})

			for id,helpcard in pairs(mgr.bCallHelp) do
				if helpcard == v then return end -- 同一个角色只调用一次, 调用过就不再调用
			end

			mgr.bCallHelp[index] = v -- 记录协战的人

			local skillMgr = v.skillMgr
			local skl = skillMgr:GetNormon()
			ASSERT(skl)
			local skillData = table.copy(data)
			skillData.skillID = skl.id
			LogDebugEx("触发协战", v.name)
			skl:OnHelp(effect.apiSetting, caster, v, target, pos, skillData)
		else
			ASSERT()
		end
	end
end

-- 吸收
function FightAPI:Suck(effect, caster, target, data, cureTy, percent)
	local mgr = self.team.fightMgr
	local hp = 0
	if cureTy == 4 then
		hp = caster.nSkillDamage
	elseif cureTy == 5 then
		hp = caster.nLastHitDamage
	else
		ASSERT()
	end	

	if hp <= 0 then return end

	-- percent = percent * suck
	hp = math.floor(hp * percent)
	LogDebugEx("---SkillBase:Suck---", caster.name, target.name, hp)
	caster:AddHp(hp)
	self.log:Add({api="AddHp", targetID = target.oid, attr = "hp", 
		hp = target:Get("hp"), add = hp, effectID = effect.apiSetting, order = self.order})
end

function FightAPI:IgnoreSingleAttack(effect, caster, target, data, res)
	LogDebugEx("-----无视单攻-----", target.name)
	-- local target = self.owner
	-- local caster = self.caster
	-- local apiSetting = BufferEffect[effectID].apiSetting
	self.bIgnoreSingleAttack = res
	target:IgnoreSingleAttack(res)

	-- local log = {api="IgnoreSingleAttack", bufferID = self.id, targetID = target.oid, casterID = caster.oid, 
	-- uuid = self.uuid, effectID = effect.id}
	-- self.log:Add(log)
end

--无视物盾/光盾
function FightAPI:IgnoreShield(effect, caster, target, data, res)
	LogDebugEx("-----无视物盾|光盾-----", target.name)
	self.bIgnoreShield = res
	target:IgnoreShield(res)
end

--设置标记
function FightAPI:SetValue(effect, caster, target, data, key, val, isNotify)
	LogDebugEx("--设置标记", self.name, key, val)
	target:SetValue(key, val)

	-- if isNotify then
		self.log:Add({api="UpdateValue", casterID = caster.oid, targetID = target.oid, effectID = effect.apiSetting, key=key, val = val})
	-- end
end

-- --获取标记数据
-- function FightAPI:GetValue(effect, caster, target, data, key)
-- 	LogDebugEx("--获取标记数据", self.name, target.name, key, target:GetValue(key))
-- 	return target:GetValue(key)
-- end

-- 获取标记数据
function SkillApi:GetValue(oSkill, caster, target, filter, key)
	local card = self:Filter(oSkill, caster, target, filter)
	LogDebugEx("获取标记数据", card.name, key, card:GetValue(key) or 0)
	return card:GetValue(key) or 0
end

--删除标记
function FightAPI:DelValue(effect, caster, target, data, key, isNotify)
	LogDebugEx("--删除标记", target.name, key)
	target:DelValue(key)
	-- if isNotify then
		if not caster then caster = target end -- Buffer336805:OnRemoveBuff 删除时报错
		self.log:Add({api="DelValue", casterID = caster.oid, targetID = target.oid, effectID = effect.apiSetting, key=key})
	-- end
end

--增加标记
function FightAPI:AddValue(effect, caster, target, data, key, val, min, max, isNotify)
	--LogTrace()
	LogDebugEx("--增加标记", self.name, target.name, target.oid, key, val, min, max)
	target:AddValue(key, val, min, max)

	-- if isNotify then
		self.log:Add({api="UpdateValue", casterID = caster.oid, targetID = target.oid, effectID = effect.apiSetting, key=key, val = target:GetValue(key)})
	-- end
end

--设置临时标记
function FightAPI:SetTempSign(effect, caster, target, data, key, val)
	LogDebugEx("--设置临时标记", self.name, key, val)
	target:SetTempSign(key, val)
end

--获取临时标记
function FightAPI:GetTempSign(effect, caster, target, data, key)
	LogDebugEx("--获取临时标记", self.name, key)
	return target:GetTempSign(key)
end

function FightAPI:HpProtect(effect, caster, target, data, percent)
	target.AddHp = target.AddHpProtect
	local hp = target.hp - math.floor(target.maxhp * percent)
	target:SetTempSign("HpProtect", hp)

	LogDebugEx("FightAPI:HpProtect", target.name, hp)
	-- 删除事件的时候取消这个效果
	local todo = function(target)
		LogDebugEx("FightAPI:HpProtect delete", target.name)
		target:SetTempSign("HpProtect", nil)
	end
	
	self:AddTodoOnDelete(todo, target)
end

-- 飞行兵种加成:飞行兵种攻击地面单位伤害增加
function FightAPI:FlyAdjust(effect, caster, target, data, percent, rand)
	target:SetSign("FlyAdjust",percent,{rand=rand, percent=percent}) 
end

-- MISS攻击:一定几率MISS攻击
function FightAPI:MissSurface(effect, caster, target, data, rand)
	target:SetSign("MissSurface",rand,{rand=rand}) 
end
-- MISS攻击 可叠加
function FightAPI:MissSurface2(effect, caster, target, data, rand)
	local d= target:GetSign("MissSurface2") or {rand = 0}
	d.rand = d.rand + rand
	LogDebug("增加[%s]MissSurface2:增加[%s]最终[%s]", target.name, rand, d.rand)

	target:SetSign("MissSurface2",rand, d) 
end

-- 免疫飞行兵种加成
function FightAPI:ImmuneFlyAdjust(effect, caster, target, data)
	target:SetTempSign("ImmuneFlyAdjust")
end


-- 直接加血扣血
function FightAPI:AddHp(effect, caster, target, data, hp, bNotDeathEvent)
	LogDebugEx("FightAPI:AddHp", hp)

	if target:GetTempSign("ImmuneDamage") then  
		return
	end
	
	local bIsLive = target:IsLive() -- 记录原来的状态, 死了就不再添加死亡列表
	hp = math.floor(hp)
	local isdeath, shield, num = target:AddHpNoShield(hp, caster)
	self.log:Add({api="AddHp", death = isdeath, targetID = target.oid, casterID = caster.oid,
	attr = "hp", hp = target:Get("hp"), add = num, effectID = effect.apiSetting, isReal = true}) --isReal真实伤害

	-- self.card.nLastHitDamage

	-- 触发死亡事件
	if bNotDeathEvent then return end

	LogDebugEx("FightAPI:AddHp bNotDeathEvent")
	local isdeath = not target:IsLive()
	if bIsLive and  isdeath and self.AddDeaths then
		self:AddDeaths(target, caster)
	end
end

--限制最大伤害
function FightAPI:LimitDamage(effect, caster, target, data, percenthp, percentatt,param)
	LogDebugEx("-----限制最大伤害-----", target.name)

	if target:GetTempSign("ImmuneDamage") then  
		return
	end

	local hp2 = self:CalcCure(caster, target, 2, percenthp) -- 受击者血量
	local useCaster = param and self.card or caster
	local hp3 = self:CalcCure(useCaster, target, 3, percentatt) -- 攻击者攻击

	-- [4.2版本]
	local bIsLive = target:IsLive() -- 记录原来的状态, 死了就不再添加死亡列表
	local coefficient = 1+(caster:GetValue("LimitDamage") or 0) -- 限制真实伤害
	local damageAdjust = caster:Get("damage") * target:Get("bedamage") * coefficient

	-- local damageAdjust = caster:Get("damage") * target:Get("bedamage")
	LogDebugEx(string.format("hp=%s, attack=%s damage=%s bedamage=%s damageAdjust= %s",
	hp2, hp3, caster:Get("damage") , target:Get("bedamage"), damageAdjust))
	local hp = math.floor(math.min(hp2, hp3) * damageAdjust)

	local isdeath, shield, num = target:AddHpNoShield(-hp, caster)
	self.log:Add({api="BufferDamage", death = isdeath, targetID = target.oid, casterID = caster.oid,
	attr = "hp", hp = target:Get("hp"), add = -num, effectID = effect.apiSetting, isReal = true}) --isReal真实伤害

	-- [4.2版本]
	LogDebugEx("FightAPI:AddHp bNotDeathEvent")
	local isdeath = not target:IsLive()
	if bIsLive and  isdeath and self.AddDeaths then
		self:AddDeaths(target, caster)
	end
end

-- 减少所有技能属性
function FightAPI:ReduceSkillAttr(effect, caster, target, data, attr, val)
	local mgr = caster.skillMgr
	mgr:ReduceSkillAttr(attr, val)
end

function FightAPI:AddSkillAttr(effect, caster, target, data, attr, val)
	local mgr = target.skillMgr
	mgr:AddSkillAttr(attr, val)
end

function FightAPI:AddSkillAttrPct(effect, caster, target, data, attr, val)
	local mgr = target.skillMgr
	mgr:AddSkillAttrPct(attr, val)
end

function FightAPI:AddOneSkillAttr(effect, caster, target, data, attr, val, t)
	local mgr = target.skillMgr
	mgr:AddOneSkillAttr(attr, val, t)
end

-- 结算伤害并删除buff(按type)
function FightAPI:ClosingBuff(effect, caster, target, data, num, type)
	local oBuffMgr = target.bufferMgr

	type = type or 1

	local list = {}
	for i,v in ipairs(oBuffMgr.list) do
		if v.type == type then
			table.insert(list, v)
		end
	end

	if #list == 0 then return end

	self:ClosingBuffEx(effect, caster, target, data, num, list)
end

-- 结算伤害并删除buff(按id)
function FightAPI:ClosingBuffByID(effect, caster, target, data, num, id)
	local oBuffMgr = target.bufferMgr
	
	local list = {}
	for i,v in ipairs(oBuffMgr.list) do
		if v.id == id then
			table.insert(list, v)
		end
	end

	if #list == 0 then return end

	self:ClosingBuffEx(effect, caster, target, data, num, list)
end

-- 结算伤害并删除buff
function FightAPI:ClosingBuffEx(effect, caster, target, data, num, list)
	local oBuffMgr = target.bufferMgr

	if #list == 0 then return end

	if effect.apiSetting then
		self.log:Add({api="ClosingBuff", targetID = target.oid, casterID = caster.oid, effectID = effect.apiSetting})
	end

	if num and num > 0 then
		-- 删除num个
		if num > #list then
			num = #list
		end
		for i=1,num do
			local v = list[i]
			if v and target:IsLive() then
				v:ClosingBuff()
			end
		end
	else
		-- 删除所有
		for i,v in ipairs(list) do
			if target:IsLive() then
				v:ClosingBuff()
			end
		end
	end
end


-- 强制改血量
function FightAPI:SetHP(effect, caster, target, data, val)
	target.hp = val
	if val > 0 then
		target.isLive = true
	else
		target.isLive = false
	end
	self.log:Add({api="SetHP", death = not target.isLive, targetID = target.oid, casterID = caster.oid,
	hp = val, effectID = effect.apiSetting})
end

-- 设置属性
function FightAPI:SetAttr(effect, caster, target, data, attr, val)
	if attr == "hp" then 
		ASSERT(nil, "设置血量请用SetHP")
	end
	target[attr] = val
	-- self.log:Add({api="SetAttr", death = isdeath, targetID = target.oid, casterID = caster.oid,
	-- attr = attr, val = val, effectID = effect.apiSetting})
end

-- 给target阵营的指挥官技能+-cd
function FightAPI:CommanderAddCD(effect, caster, target, data, team, val)
	-- 指挥官技能
	local oTeam = caster.team
	if team ~= 1 then
		local mgr = self.team.fightMgr
		oTeam = mgr:GetEnemyTeam(caster)
	end
	-- local oTeam = mgr:GetTeam()
	local oCommander = oTeam.oCommander
	if oCommander then
		return oCommander.skillMgr:AddCD(val)
	end
end

-- 替换技能
function FightAPI:ChangeSkill(effect, caster, target, data, nIndex, skillID)
	
	if not caster:IsLive() then return end

	local skillMgr = caster.skillMgr
	LogTable(skillMgr.list, "ChangeSkill before")

	for i,v in ipairs(skillMgr.skills) do
		LogDebugEx("技能", i, v.id, v.upgrade_type, v.main_type, skillID)
		-- 找到指定技能

		if (v.upgrade_type and v.upgrade_type == nIndex) then 
			local newSkillID = math.floor(skillID/100)*100 + v.lv  -- 要考虑替换技能的等级
			ASSERT(skill[newSkillID], "没有找到配置,无法替换技能"..newSkillID)
			-- 替换原来的技能
			for j,id in ipairs(skillMgr.list) do
				if newSkillID == id then
					LogDebugEx("新旧技能一样, 不切换", v.id, newSkillID)
					return 
				end
				if id == v.id then
					skillMgr.list[j] = newSkillID
					skillMgr:DeleteEvent() -- 清除旧技能事件
					skillMgr:InitSkill()

					skillMgr:GetSkill(newSkillID):ResetCD()--恢复CD
					-- Pause()

					self.log:Add({api="ChangeSkill", targetID = caster.oid, casterID = caster.oid,
						oldSkillID = id, newSkillID = newSkillID, effectID = effect.apiSetting})
					LogTable(skillMgr.list, "ChangeSkill after")
					return
				end
			end
		end
	end

	LogTable(skillMgr.list, "ChangeSkill after")
end

-- 挡刀保护(建议放在OnBorn)
function FightAPI:SetProtect(effect, caster, target, data, rand, filter)
	self.card:SetProtect(rand, target)
end

-- 增加能量
function FightAPI:AddEnergy(effect, caster, target, data, val, percent)
	-- local mgr = self.team.fightMgr
	val = math.floor(val)
	local max = math.floor(target:Get("maxhp") * percent)
	LogDebugEx("增加能量", target.name, val, percent, max)
	local energy = target:GetValue("energy") or 0
	if energy >= max then return end
	if val > 0 then
		energy = energy + val
		if energy > max then energy = max end
	else
	end

	target:SetValue("energy", energy)
end

-- 技能拥有者用能量给目标治疗
function FightAPI:EnergyCure(effect, caster, target, data, hp)
	local energy = self.card:GetValue("energy") or 0
	if energy <= 0 then 
		self.card:SetValue("energy", 10)
		energy = 10
	end

	hp = math.floor(hp)

	if hp > energy then
		hp = energy
	end

	local damageAdjust = self.card:Get("cure") * target:Get("becure")
	LogDebugEx("EnergyCure", self.card.name, self.card:Get("cure"), target.name, target:Get("becure"))
	local cureHP = math.floor(hp*damageAdjust)

	-- 治疗
	target:AddHp(cureHP)
	self.log:Add({api="AddHp", targetID = target.oid, attr = "hp", 
		hp = target:Get("hp"), add = cureHP, effectID = effect.apiSetting, order = self.order})

	LogDebugEx("能量治疗", energy, hp, cureHP, target.hp)
	-- 扣能量
	self.card:SetValue("energy", energy-hp)

	local mgr = self.team.fightMgr
	target.currCureHp = hp -- 当前治疗量
	mgr:DoEventWithLog("OnCure", caster, target, data)
	target.currCureHp = nil
end

-- 拥有者给目标加buff
function FightAPI:OwnerAddBuff(effect, caster, target, data, buffID, nRoundNum)
	local caster = self.card
	self:AddBuff(effect, caster, target, data, buffID, nRoundNum)
end

-- 自动战斗
function FightAPI:AutoFight(effect, caster, target, data, skillID)
	local mgr = self.team.fightMgr
	LogDebugEx("FightAPI:AutoFight", skillID, mgr.currTurn and mgr.currTurn.name)
	mgr.currTurn.skillMgr:CreateSkillEx(skillID) -- 没有技能就创建技能

	if mgr.isServerMgr or IS_SERVER then -- 仅服务器用

		if not mgr.currTurn then return end
		if not mgr.currTurn:IsLive() then return end
		if mgr.currTurn:IsMotionless() then 
			-- 无法行动 什么都不用做, 由框架处理跳过
			return 
		elseif mgr.currTurn.silence then -- 被沉默就不处理, 按普通流程去处理
		else
			-- mgr.currTurn.bIgnoreUseCommon = true
			mgr.currTurn.bAIOnTurn = true
			mgr.currTurn.nAutoSkillID = skillID and math.floor(skillID/100) -- 指定技能(同一个技能的不同等级都可以取到)
			
			-- mgr.currTurn:DoAI(true)
			-- mgr.currTurn.bIgnoreUseCommon = nil
			-- mgr.waitForDoSkill = nil
			-- LogDebugEx("------------AutoFight--------------")
		end 
	end
end

-- 额外回合
function FightAPI:ExtraRound(effect, caster, target, data)
	local mgr = self.team.fightMgr
	if mgr.oForceNext then return end
	
	mgr:SetNextCard(self.card)
	self.log:Add({api="ExtraRound", targetID = target.oid, effectID = effect.apiSetting})
end


function FightAPI:AddUplimitBuff(effect, caster, target, data, filter, typ, group, uplimit, buffID)
	-- self:print()
	local card = SkillApi:Filter(self, caster, target, filter)
	local count72 = SkillApi:BuffCount(self, caster, target, filter, typ, group)

	if count72 >= uplimit then return end
	self:AddBuff(effect, self.card, card, data, buffID)
end


function FightAPI:SetShareDamage(effect, caster, target, data, percent)
	LogDebugEx("设置分摊伤害比例", percent)
	if percent > 1 then percent = 1 end
	if percent < 0 then percent = 0 end
	LogDebugEx("设置分摊伤害比例", percent, target.name)
	target:SetValue("rateShareDamage", percent)
end

--飘字
function FightAPI:ShowTips(effect, caster, target, data, type, content, isFilter, iLanguageId)

	-- 过滤掉重复的提示
	if isFilter then
		local mgr = self.team.fightMgr
		mgr.currTips = mgr.currTips or {}
		if mgr.currTips[content] then
			return -- 提示过, 不再提示
		end

		mgr.currTips[content] = 1
	end

	local data = {api="ShowTips", type = type, content = content, id = iLanguageId, effectID = effect.apiSetting}
	if caster then
		data.casterID = caster.oid
	end
	if target then
		data.targetID = target.oid
	end
	self.log:Add(data)
end

--受到所有伤害来源变成1点(设置成固定伤害)
function FightAPI:SetFixedDamage(effect, caster, target, data, hp)
	target.GetDamage = function ()
		LogDebugEx("111111111111--------------", hp)
		return hp
	end

	-- 伤害
	target.Damage = function()
		LogDebugEx("2222222222--------------", hp)
		return hp
	end

	target.AddHp = function(self, num, killer, bNotDeathEvent)
		if num > 0 then
			return FightCardBase.AddHp(self, num, killer, bNotDeathEvent)
		else
			return FightCardBase.AddHp(self, -hp, killer, bNotDeathEvent)
		end
	end	

	target.AddHpNoShield = function(self, num, killer, bNotDeathEvent)
		if num > 0 then
			return FightCardBase.AddHpNoShield(self, num, killer, bNotDeathEvent)
		else
			return FightCardBase.AddHpNoShield(self, -hp, killer, bNotDeathEvent)
		end
	end		
end

--- 开始剧场表演
function FightAPI:StartPlay(effect, caster, target, data, key)

	LogDebugEx("FightAPI:StartPlay(effect, caster, target, data)")
	local mgr = self.team.fightMgr
	mgr.stage = mgr.stage + 1

	local data = {api="StartPlay", dels = {}, adds = {}, effectID = effect.apiSetting}

	if key then
		data.key = key
		self.log:Add(data)
		return
	end


	-- 清除怪物
	for i = #mgr.arrCard, 1, -1 do
		local v = mgr.arrCard[i]
		if v:GetTeamID() == 2 and v.type ~= CardType.Card then
			table.remove(mgr.arrCard, i)
			if v:IsLive() then
				-- 删除buff
				v.bufferMgr:OnSelfDeath()
				v.skillMgr:DeleteEvent()

				table.insert(data.dels, v.oid)
			end
		end
	end

	-- 重新加载数据
	mgr.arrTeam[2] = Team(2, mgr)
	mgr.arrTeam[2]:LoadConfig(mgr.groupID, mgr.stage)
	mgr:AfterChangeStage()

	-- if not IS_SERVER then
		-- 新增怪物
		for i, v in ipairs(mgr.arrCard) do
			if v:GetTeamID() == 2 and v.type ~= CardType.Card and v:IsLive() then
				table.insert(data.adds, v:GetShowData())
			end
		end
	-- end


	-- for i = #mgr.arrCard, 1, -1 do
	-- 	local v = mgr.arrCard[i]
	-- 	if v:GetTeamID() == 2 and v.type ~= CardType.Card then
	-- 		table.adds(data.dels, v.oid)
	-- 	end
	-- end

	-- mgr.stage = mgr.stage - 1

	-- 重置跑条
	for i = #mgr.arrCard, 1, -1 do
		local v = mgr.arrCard[i]
		v.progress = 0
	end

	-- 清除额外回合
	mgr.oForceNext = nil

	LogTable(data)
	-- ASSERT()

	self.log:Add(data)
end

-- 退场机制(移除尸体)
function FightAPI:RemoveDead(effect, caster, target, data)

	LogDebugEx("退场机制(移除尸体)", target.name, target:IsLive())
	local mgr = self.team.fightMgr
	for i = #mgr.arrCard, 1, -1 do
		local v = mgr.arrCard[i]
		if not v:IsLive() then
			if v.oid == target.oid then
				-- 移除死亡对象
				target.isRemove = true
				table.remove(mgr.arrCard, i)
				return
			end
		end
	end
end

-- 物理盾增加层数
function FightAPI:AddPhysicsShieldCount(effect, caster, target, data, buffID, round, uplimit)
		
	--LogTable(effect, "AddPhysicsShieldCount")

	if target:CheckAddBuff(caster, buffID,  effectID) then return end
	local oPhysicsShield = target.oPhysicsShield
	if oPhysicsShield then 
		oPhysicsShield:AddPhysicsShield(effect, caster, target, data, round, uplimit)
	else
		local oBuffMgr = target.bufferMgr
		local buff = oBuffMgr:AddCount(target, caster, buffID, round, uplimit, effect.apiSetting)
		if buff then
			buff:AddPhysicsShield(effect, caster, target, data, round, uplimit)
		end
	end
end

--光束盾增加层数
function FightAPI:AddLightShieldCount(effect, caster, target, data, buffID, round, uplimit)
	--LogTable(effect, "AddLightShieldCount")
	if target:CheckAddBuff(caster, buffID,  effectID) then return end
	local oLightShield = target.oLightShield
	if oLightShield then 
		oLightShield:AddLightShield(effect, caster, target, data, round, uplimit)
	else
		-- local buff = self:AddBuff(effect, caster, target, data, buffID, round)
		local oBuffMgr = target.bufferMgr
		local buff = oBuffMgr:AddCount(target, caster, buffID, round, uplimit, effect.apiSetting)
		if buff then
			buff:AddLightShield(effect, caster, target, data, round, uplimit)
		end
	end
end


-- 召唤队友
function FightAPI:SummonTeammate(effect, caster, target, data, monsterID, ty, pos, sdata, pre, after, isTransToSummon)
	-- local effect = SkillEffect[effectID]

	LogDebugEx("召唤队友", monsterID)
	local team = target.team
	local teamID = target:GetTeamID()
	local mgr = team.fightMgr

	local site = mgr:GetPosCard(teamID, pos)
	if site and site:IsLive() then
		LogDebug("召唤的位置被占用[%s][%s]", pos[1] or "", pos[2] or "")
		return
	end

	local log = {api="SummonTeammate", id = target.oid, uid=target.uid, effectID = effect.apiSetting, pre=pre, after=after}
	if isTransToSummon then
		log.api = "Summon"
	end

	self.log:Add(log)
	local card = team:SummonTeammate(target, monsterID, pos, sdata, ty)
	local datas = {card:GetShowData()}

	log.datas = datas

	mgr:OnBorn(card, true)
	
	-- ASSERT()
	return card
end

function FightAPI:DelMirrorSkill(effect, caster, target, data)

	LogDebugEx("FightCardBase:DelMirrorSkill", self.oid, self.name, target.oid, target.name)
	target.skillMgr:DelMirrorSkill()
end

-- 客户端表现
function FightAPI:Custom(effect, caster, target, data, action, param)

	LogDebugEx("FightAPI:Custom", self.oid, self.name, target.oid, target.name, action)
	local log = {api="custom", targetID = target.oid, effectID = effect.apiSetting, 
	action=action, param=param}
	self.log:Add(log)
end

-- 给队友增加一个技能
function FightAPI:AddSkill(effect, caster, target, data, skillID)
	if not target:IsLive() then return end
	local skillMgr = target.skillMgr
	local oSkill = skillMgr:GetSkill(skillID)
	if oSkill then return end

	LogDebugEx("FightAPI:AddSkill", caster.name, target.name, skillID)

	oSkill = skillMgr:CreateSkillEx(skillID) -- 没有技能就创建技能
	oSkill.bIsCanDel = true
	-- 注册技能事件
	oSkill:RegisterEvent(self)

	-- local log = {api="AddSkill", targetID = target.oid, effectID = effect.apiSetting, skillID=skillID}
	-- self.log:Add(log)
end

-- 获取召唤主技能
function FightAPI:AddOwnerEquipSkill(effect, caster, target, data)

	LogDebugEx("AddOwnerEquipSkill", target.name)
	local oSummonOwner = target.oSummonOwner --获取召唤主
	local mgr = oSummonOwner.skillMgr
	LogDebugEx("oSummonOwner", oSummonOwner.name)
	
	local equipSkills = mgr.equipSkills or {}
	LogTable(equipSkills, "equipSkills= ")
	if table.empty(equipSkills) then return end
	if target.bIsAddOwnerEquipSkill then return end

	for i,v in ipairs(equipSkills) do
		LogDebugEx("AddOwnerEquipSkill  AddSkill", i, v)
		self:AddSkill(effect, caster, target, data, v)
	end
	target.bIsAddOwnerEquipSkill = true

	local log = {api="AddOwnerEquipSkill", targetID = target.oid, effectID = effect.apiSetting, equipSkills=equipSkills}
	self.log:Add(log)
end

-- 给队友删除一个技能
function FightAPI:DelSkill(effect, caster, target, data, skillID)
	-- if not target:IsLive() then return end
	local skillMgr = target.skillMgr
	local oSkill = skillMgr:GetSkill(skillID)

	if not oSkill then return end
	if not oSkill.bIsCanDel then return end -- 不可删除的技能

	LogDebugEx("FightAPI:DelSkill", caster.name, target.name, skillID)
	oSkill.bIsCanDel = nil
	skillMgr:DelSkillEx(skillID) 

	-- local log = {api="DelSkill", targetID = target.oid, effectID = effect.apiSetting, skillID=skillID}
	-- self.log:Add(log)
end


-- 增加蓄能（怒气值）
function FightAPI:AddFury(effect, caster, target, data, val, max)
	-- local mgr = self.team.fightMgr
	val = math.floor(val)
	local fury = target:GetValue("fury") or 0
	if fury >= max then 
		LogDebugEx("蓄能已满", val, max)
		return 
	end
	if val > 0 then
		fury = fury + val
		if fury > max then fury = max end
	else
	end

	LogDebugEx("增加蓄能", val, max, "最终", fury)
	target:SetValue("fury", fury)

	self.log:Add({api="UpdateFury", targetID = target.oid, fury = fury, add = val, max = max, effectID = effect.apiSetting, order = self.order})
end

-- 设置蓄能（怒气值）
function FightAPI:SetFury(effect, caster, target, data, val, max)
	LogDebugEx("设置蓄能", val, max)
	-- local mgr = self.team.fightMgr
	val = math.floor(val)
	target:SetValue("fury", val)

	self.log:Add({api="SetFury", targetID = target.oid, fury = val, max = max, effectID = effect.apiSetting, order = self.order})
end

-- ---------------------------------------------------
-- -- 辅助函数

-- 概率随机
function FightAPI:Rand(rand)
	local r = self.card:Rand(10000)
	LogDebug("FightAPI:Rand 概率[%s] 随机数[%s] 结果[%s]", rand, r, r <= rand)
	if r > rand then return end
	return true
end

-- 随机[a,b] e精度
function FightAPI:RandEx(a,b,e)
	e = e or 1
	local r = self.card:RandEx(a,b)
	LogDebug("FightAPI:RandEx 随机数[%s]",  r/e)
	return r/e
end