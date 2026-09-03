-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/miniGame/model/jump/Jump.lua

JumpPosition = {
	JOver = 2,
	KWait = 0,
	JWar = 1
}
Jump = class("Jump", objectlua.Object, _M)

Jump:has("_goldGetCount", {
	is = "rw"
})
Jump:has("_diamondGetCount", {
	is = "rw"
})
Jump:has("_fragGetCount", {
	is = "rw"
})
Jump:has("_dailyRewards", {
	is = "rw"
})
Jump:has("_maxScore", {
	is = "rw"
})
Jump:has("_jumpMaxPressTime", {
	is = "rw"
})
Jump:has("_jumpMinPressTime", {
	is = "rw"
})
Jump:has("_rewardHeroId", {
	is = "rw"
})
Jump:has("_rewardHeroPieceId", {
	is = "rw"
})
Jump:has("_itemLimit", {
	is = "rw"
})
Jump:has("_goldLimit", {
	is = "rw"
})
Jump:has("_diamondLimit", {
	is = "rw"
})
Jump:has("_fragLimit", {
	is = "rw"
})
Jump:has("_jumpFloorList", {
	is = "rw"
})
Jump:has("_rewardMaxList", {
	is = "rw"
})
Jump:has("_buyTimesCost", {
	is = "r"
})
Jump:has("_eachBuyNum", {
	is = "r"
})
Jump:has("_buyLimit", {
	is = "r"
})

function Jump:initialize(data)
	self._dailyRewards = {}
	self._itemLimit = {}
	self._goldGetCount = 0
	self._diamondGetCount = 0
	self._fragGetCount = 0
	self._rewardHeroId = ""
	self._rewardMaxList = {}
	self._buyTimesCost = {}
	self._eachBuyNum = 0
	self._buyLimit = 0

	self:synchronize(data)
	self:initMaxReward()
end

function Jump:synchronize(data)
	self._activity = data

	local activityConfig = data:getActivityConfig()

	self._rewardMaxList = activityConfig.maxReward

	local pointConfig = ConfigReader:getRecordById("MiniJumpPoint", activityConfig.MiniGameConfig.point[1])

	self._jumpFloorList = pointConfig.List
	self._jumpMaxPressTime = pointConfig.MaxPressTime
	self._jumpMinPressTime = pointConfig.MinPressTime
	self._maxScore = pointConfig.MaxScoreClient

	self:syncDailyReward()

	self._eachBuyNum = activityConfig.eachBuyNum
	self._buyTimesCost = activityConfig.buyTimesCost
	self._buyLimit = activityConfig.buyLimit
end

function Jump:initMaxReward()
	local maxRewardConfig = self:getRewardMaxList()

	for k, v in pairs(maxRewardConfig) do
		local itemId = v.id
		local amount = v.amount

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

function Jump:syncDailyReward()
	for itemId, amount in pairs(self._activity:getDailyRewards()) do
		if itemId == CurrencyIdKind.kGold then
			self._goldGetCount = amount
		elseif itemId == CurrencyIdKind.kDiamond then
			self._diamondGetCount = amount
		else
			self._fragGetCount = amount
		end
	end

	dump(self._goldGetCount, "self._goldGetCount")
	dump(self._diamondGetCount, "self._goldGetCount")
	dump(self._fragGetCount, "self._goldGetCount")
end

function Jump:isGetRewardLimit()
	self:syncDailyReward()

	local goldlimit, diamondlimit, herolimit = false, false, false

	dump(self._goldGetCount, "self._goldGetCount")

	if self._goldGetCount == self._goldLimit then
		goldlimit = true
	end

	dump(self._diamondGetCount, "self._diamondGetCount")

	if self._diamondGetCount == self._diamondLimit then
		diamondlimit = true
	end

	dump(self._fragGetCount, "self._fragGetCount")

	if goldlimit and diamondlimit and (self._fragGetCount == self._fragLimit or nil) and true then
		return true
	else
		return false
	end
end

function Jump:resetData()
	self._goldGetCount = 0
	self._diamondGetCount = 0
	self._fragGetCount = 0
end
