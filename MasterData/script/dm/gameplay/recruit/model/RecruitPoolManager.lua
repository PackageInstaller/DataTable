-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/recruit/model/RecruitPoolManager.lua

RecruitPoolType = {
	kGold = "GOLD",
	kEquip = "EQUIP",
	kActivity = "ACTIVITYDRAW",
	kPve = "PVE",
	kPvp = "PVP",
	kActivityEquip = "ACTIVITYDRAWEQUIP",
	kDiamond = "DIAMOND",
	kActivityUREquip = "ACTIVITYDRAWUR",
	kClub = "CLUB"
}
RecruitPoolId = {
	kHeroGold = "DrawCard_Gold_1",
	kEquip = "DrawCard_Equip_1",
	kHeroDiamond = "DrawCard_Diamond_1"
}
RecruitBoxState = {
	kCannotReceive = -1,
	kHasReceived = 1,
	kCanReceive = 0
}
RecruitPoolManager = class("RecruitPoolManager", objectlua.Object, _M)

RecruitPoolManager:has("_player", {
	is = "rw"
})
RecruitPoolManager:has("_boxRewardRecruitTimes", {
	is = "rw"
})
RecruitPoolManager:has("_recruitPools", {
	is = "rw"
})
RecruitPoolManager:has("_drawTimeMap", {
	is = "rw"
})
RecruitPoolManager:has("_dailyDrawTimeMap", {
	is = "rw"
})

function RecruitPoolManager:initialize()
	super.initialize(self)

	self._recruitPools = {}

	local config = ConfigReader:getDataTable("DrawCard")

	for id, v in pairs(config) do
		local recuritPool = RecruitPool:new(id)

		recuritPool:setOwner(self)

		self._recruitPools[id] = recuritPool
	end

	self._boxRewardRecruitTimes = 0
	self._drawTimeMap = {}
	self._dailyDrawTimeMap = {}
	self._goldRecruitTimes = 0
	self._diamondRecruitTimes = 0
	self._equipRecruitTimes = 0
end

function RecruitPoolManager:dispose()
	super.dispose(self)
end

function RecruitPoolManager:sync(data)
	if data.drawFreeMap then
		local recruitPoolsData = data.drawFreeMap

		for id, recruitPoolData in pairs(recruitPoolsData) do
			local recruitPool = self._recruitPools[id]

			if recruitPool then
				recruitPool:sync(recruitPoolData)
			end
		end
	end

	if data.accPoints then
		self._boxRewardRecruitTimes = data.accPoints or 0
	end

	if data.drawTimeMap then
		for i, v in pairs(data.drawTimeMap) do
			self._drawTimeMap[i] = self._drawTimeMap[i] or {}

			for jj, vv in pairs(v) do
				self._drawTimeMap[i][jj] = vv
			end

			if self._recruitPools[i] then
				self._recruitPools[i]:syncRebateCount(v["1"])
			end
		end
	end

	if data.dailyTimes then
		for i, v in pairs(data.dailyTimes) do
			if not self._drawTimeMap[i] then
				self._dailyDrawTimeMap[i] = 0
			end

			self._dailyDrawTimeMap[i] = v

			if self._recruitPools[i] then
				self._recruitPools[i]:syncDailyCount(v)
			end
		end
	end

	if data.pointRewarded then
		local boxStateData = {}

		for index, times in pairs(data.pointRewarded) do
			boxStateData[times] = true
		end
	end

	if data.rebateInfoMap then
		for id, info in pairs(data.rebateInfoMap) do
			if self._recruitPools[id] then
				self._recruitPools[id]:syncRebateInfo(info)
			end
		end
	end

	if data.rebateRoundInfoMap then
		for id, counts in pairs(data.rebateRoundInfoMap) do
			if self._recruitPools[id] then
				self._recruitPools[id]:syncRebateRound(counts)
			end
		end
	end
end

function RecruitPoolManager:getRecruitPoolById(id)
	return self._recruitPools[id]
end

function RecruitPoolManager:getRecruitPoolByType(type)
	if self._recruitPools[type] then
		return {
			self._recruitPools[type]
		}
	end

	local recruitPolls = {}

	if type == RecruitPoolType.kDiamond then
		for id, recruitPoll in pairs(self._recruitPools) do
			if RecruitPoolType.kActivity == recruitPoll:getType() then
				table.insert(recruitPolls, recruitPoll)
			end
		end
	end

	for id, recruitPoll in pairs(self._recruitPools) do
		if type == recruitPoll:getType() then
			table.insert(recruitPolls, recruitPoll)
		end
	end

	table.sort(recruitPolls, function(a, b)
		local rankA = a:getRank()
		local rankB = b:getRank()

		return rankB < rankA
	end)

	return recruitPolls
end
