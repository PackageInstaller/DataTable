-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/miniGame/model/darts/DartsData.lua

DartsPosition = {
	kWait = 0,
	kWar = 1,
	kOver = 2
}
DartsData = class("DartsData", objectlua.Object, _M)

DartsData:has("_golddaily", {
	is = "rw"
})
DartsData:has("_diamonddaily", {
	is = "rw"
})
DartsData:has("_fragdaily", {
	is = "rw"
})
DartsData:has("_goldLimit", {
	is = "rw"
})
DartsData:has("_diamondLimit", {
	is = "rw"
})
DartsData:has("_fragLimit", {
	is = "rw"
})
DartsData:has("_rewardHeroPieceId", {
	is = "r"
})
DartsData:has("_pointList", {
	is = "r"
})
DartsData:has("_dailyTimes", {
	is = "r"
})
DartsData:has("_maxTimes", {
	is = "r"
})
DartsData:has("_buyTimesCost", {
	is = "r"
})
DartsData:has("_buyLimit", {
	is = "r"
})
DartsData:has("_rewardMaxList", {
	is = "r"
})
DartsData:has("_maximumShow", {
	is = "r"
})
DartsData:has("_maxLevel", {
	is = "r"
})
DartsData:has("_eachBuyNum", {
	is = "r"
})
DartsData:has("_dartsScore", {
	is = "r"
})
DartsData:has("_revertGapTime", {
	is = "r"
})
DartsData:has("_accelerateTime", {
	is = "r"
})
DartsData:has("_activityDataiOfDarts", {
	is = "rw"
})

function DartsData:initialize(data)
	super.initialize(self)

	self._pointList = {}
	self._dailyTimes = 0
	self._maxTimes = 0
	self._buyTimesCost = {}
	self._rewardMaxList = {}
	self._maximumShow = 0
	self._maxLevel = 0
	self._buyLimit = 0
	self._rewardHeroPieceId = 0
	self._golddaily = 0
	self._diamonddaily = 0
	self._fragdaily = 0
	self._dartsScore = 0
	self._revertGapTime = 0
	self._accelerateTime = 0

	self:syncData(data)
	self:initMaxReward()
end

function DartsData:initMaxReward()
	local maxRewardConfig = self:getRewardMaxList()

	for k, v in pairs(maxRewardConfig) do
		local itemId = v.id
		local amount = v.amount
		local config = ConfigReader:getRecordById("ItemConfig", tostring(itemId))

		if itemId == CurrencyIdKind.kGold then
			self._goldLimit = amount
		elseif itemId == CurrencyIdKind.kDiamond then
			self._diamondLimit = amount
		else
			self._fragLimit = amount
			self._rewardHeroPieceId = itemId
		end
	end
end

function DartsData:InitActOfDartsDataByData(activityData)
	self._activityDataiOfDarts = activityData
end

function DartsData:getLevelInfoBylevel(level)
	return ConfigReader:getRecordById("ActivityMiniDarts", self._pointList[level])
end

function DartsData:syncData(activitydata)
	local activityConfig = activitydata:getActivityConfig()

	self._pointList = activityConfig.MiniGameConfig.point
	self._dailyTimes = activityConfig.dailyTimes
	self._maxTimes = activityConfig.maxTimes
	self._buyTimesCost = activityConfig.buyTimesCost
	self._buyLimit = activityConfig.buyLimit
	self._eachBuyNum = activityConfig.eachBuyNum
	self._rewardMaxList = activityConfig.maxReward
	self._maximumShow = activityConfig.maximumShow
	self._maxLevel = #self._pointList
	self._dartsScore = activityConfig.DartsScore
	self._revertGapTime = activityConfig.NinjaRevertGapTime
	self._accelerateTime = activityConfig.NinjaAccelerateTime

	for itemId, amount in pairs(activitydata:getDailyRewards()) do
		local config = ConfigReader:getRecordById("ItemConfig", tostring(itemId))

		if itemId == CurrencyIdKind.kGold then
			self._golddaily = amount
		elseif itemId == CurrencyIdKind.kDiamond then
			self._diamonddaily = amount
		else
			self._fragdaily = amount
		end
	end
end

function DartsData:isGetRewardLimit()
	local goldlimit, diamondlimit, herolimit = false, false, false

	if self._golddaily == self._goldLimit then
		goldlimit = true
	end

	if self._diamonddaily == self._diamondLimit then
		diamondlimit = true
	end

	if goldlimit and diamondlimit and (self._fragdaily == self._fragLimit or nil) and true then
		return true
	else
		return false
	end
end
