-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/club/controller/ClubBashenSystem.lua

EVT_CLUB_BASHEN_REOPEN_SUCC = "EVT_CLUB_BASHEN_REOPEN_SUCC"
EVT_CLUB_BASHEN_RECEIVE_ANNOUNCE = "EVT_CLUB_BASHEN_RECEIVE_ANNOUNCE"
EVT_CLUB_BASHEN_REWARD_CHANGE = "EVT_CLUB_BASHEN_REWARD_CHANGE"

require("dm.gameplay.club.model.ClubBashen")

ClubBashenSystem = class("ClubBashenSystem", legs.Actor)

ClubBashenSystem:has("_clubSystem", {
	is = "r"
}):injectWith("ClubSystem")
ClubBashenSystem:has("_clubBashen", {
	is = "rw"
})

GemQuality = {
	blue = 3,
	orange = 5,
	red = 6,
	green = 2,
	purple = 4,
	white = 1
}
GemPath = {
	[GemQuality.white] = "gems_green.png",
	[GemQuality.green] = "gems_green.png",
	[GemQuality.blue] = "gems_blue.png",
	[GemQuality.purple] = "gems_purple.png",
	[GemQuality.orange] = "gems_orange.png",
	[GemQuality.red] = "gems_red.png"
}
GemName = {
	[GemQuality.white] = "Hero_QualityName_20",
	[GemQuality.green] = "Hero_QualityName_20",
	[GemQuality.blue] = "Hero_QualityName_30",
	[GemQuality.purple] = "Hero_QualityName_40",
	[GemQuality.orange] = "Hero_QualityName_50",
	[GemQuality.red] = "Hero_QualityName_60"
}
GemColor = {
	[GemQuality.white] = cc.c3b(120, 241, 12),
	[GemQuality.green] = cc.c3b(120, 241, 12),
	[GemQuality.blue] = cc.c3b(35, 169, 245),
	[GemQuality.purple] = cc.c3b(247, 0, 255),
	[GemQuality.orange] = cc.c3b(255, 115, 31),
	[GemQuality.red] = cc.c3b(239, 15, 15)
}
ClubBashenRankType = {
	kToday = "0",
	kYesterday = "1"
}

function ClubBashenSystem:initialize()
	super.initialize(self)

	self._clubBashen = ClubBashen:new()
end

function ClubBashenSystem:synchronize(data)
	self._clubBashen:synchronize(data)
	self:dispatch(Event:new(EVT_CLUB_PUSHREDPOINT_SUCC))
end

function ClubBashenSystem:syncDelateData(data)
	self._clubBashen:syncDelateData(data)
end

function ClubBashenSystem:synchronizeBigPrize(data)
	self._clubBashen:synchronizeBigPrize(data)
end

function ClubBashenSystem:synchronizeManualFinish(data)
	self._clubBashen:synchronizeManualFinish(data)
	self:dispatch(Event:new(EVT_CLUB_PUSHREDPOINT_SUCC))
end

function ClubBashenSystem:tryEnter()
	local view = self:getInjector():getInstance("ClubBashenMainView")

	self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil))
end

function ClubBashenSystem:isSkipAnim()
	return (cc.UserDefault:getInstance():getBoolForKey("clubBashenSkipAnim"))
end

function ClubBashenSystem:setSkipAnim(isSkipAnim)
	assert(type(isSkipAnim) == "boolean", "Bad argument is not bool")
	cc.UserDefault:getInstance():setBoolForKey("clubBashenSkipAnim", isSkipAnim)
end

function ClubBashenSystem:getManualFinish()
	return self._clubBashen:getManualFinish()
end

function ClubBashenSystem:getRedPointSta()
	local club = self._clubSystem:getClub()
	local clubInfo = club:getInfo()
	local lastOutTime = clubInfo:getLastQuitTime()
	local gameServerAgent = self:getInjector():getInstance(GameServerAgent)
	local curTime = gameServerAgent:remoteTimestamp()

	if TimeUtil:isSameDay(lastOutTime, curTime, {
		sec = 0,
		min = 0,
		hour = 5
	}) then
		return false
	end

	return not self:getManualFinish()
end

function ClubBashenSystem:isTodayNotPlayed()
	local club = self._clubSystem:getClub()
	local clubInfo = club:getInfo()
	local lastOutTime = clubInfo:getLastQuitTime()
	local gameServerAgent = self:getInjector():getInstance(GameServerAgent)
	local curTime = gameServerAgent:remoteTimestamp()

	if TimeUtil:isSameDay(lastOutTime, curTime, {
		sec = 0,
		min = 0,
		hour = 5
	}) then
		return false
	end

	return self:getLeaveOpenCount() == 5
end

function ClubBashenSystem:getLeaveOpenCount()
	return self._clubBashen:getLeaveOpenCount()
end

function ClubBashenSystem:getFreeReopenCount()
	return self._clubBashen:getFreeReopenCount()
end

function ClubBashenSystem:getLeaveDiamondReopenCount()
	return self._clubBashen:getLeaveDiamondReopenCount()
end

function ClubBashenSystem:getDiamondReopenCost()
	return self._clubBashen:getDiamondReopenCost()
end

function ClubBashenSystem:getAnnounceList()
	return self._clubBashen:getAnnounceList()
end

function ClubBashenSystem:clearupRecordData(data)
	if data then
		if not data.tempItems then
			local gemsInfo = {}
			local tempRewardIds = data.realRewardIds
			local gemsQualityList = {}
			local rewardId

			for _, gems in pairs(gemsInfo) do
				local config = ConfigReader:getRecordById("ItemConfig", tostring(gems.code))
				local amount = gems.amount

				for i = 1, amount do
					gemsQualityList[#gemsQualityList + 1] = config.Quality
				end
			end

			for k, realReward in pairs(tempRewardIds) do
				rewardId = realReward
			end

			table.sort(gemsQualityList, function(a, b)
				return b < a
			end)

			return {
				gemsQualityList = gemsQualityList,
				rewardId = rewardId
			}
		end
	end
end

function ClubBashenSystem:getTotalRewards()
	local totalRecord = self._clubBashen:getTotalRecord()
	local bigRewardList = self._clubBashen:getBigRewardList()
	local rewardIdList = {}
	local realRewardId

	for _, record in pairs(totalRecord) do
		for _, rewardId in pairs(record.realRewardIds) do
			realRewardId = rewardId
		end

		rewardIdList[#rewardIdList + 1] = realRewardId
	end

	local totalRewards = {}

	for _, rewardData in pairs(bigRewardList) do
		local code = rewardData.code

		if totalRewards[code] then
			totalRewards[code].amount = totalRewards[code].amount + rewardData.amount
		else
			totalRewards[code] = setmetatable({
				code = code
			}, {
				__index = rewardData
			})
		end
	end

	for _, rewardId in pairs(rewardIdList) do
		local rewards = ConfigReader:getDataByNameIdAndKey("Reward", rewardId, "Content")

		if rewards then
			for k, reward in pairs(rewards) do
				local code = reward.code

				if totalRewards[code] then
					totalRewards[code].amount = totalRewards[code].amount + reward.amount
				else
					totalRewards[code] = setmetatable({
						code = code
					}, {
						__index = reward
					})
				end
			end
		end
	end

	local totalRewardsList = {}

	for code, data in pairs(totalRewards) do
		local rewardData = {}

		rewardData.type = data.type
		rewardData.amount = data.amount
		rewardData.code = data.code
		totalRewardsList[#totalRewardsList + 1] = rewardData
	end

	table.sort(totalRewardsList, function(a, b)
		dump(a.code, "code_____a")
		dump(b.code, "code_____b")

		local itemConfigA = ConfigReader:getRecordById("ItemConfig", tostring(a.code))
		local itemConfigB = ConfigReader:getRecordById("ItemConfig", tostring(b.code))

		return itemConfigA.Quality > itemConfigB.Quality or itemConfigA.Quality == itemConfigB.Quality and b.code == "IR_Gold"
	end)

	return totalRewardsList
end

function ClubBashenSystem:getRecordList()
	local totalRecord = self._clubBashen:getTotalRecord()
	local recordList = {}

	for index, record in pairs(totalRecord) do
		recordList[#recordList + 1] = self:clearupRecordData(record)
	end

	return recordList
end

function ClubBashenSystem:getGemsNumByQuality(quality)
	local totalRecord = self._clubBashen:getTotalRecord()
	local gemsNum = 0

	for k, record in pairs(totalRecord) do
		if record then
			if not record.tempItems then
				local gemsInfo = {}

				for _, gems in pairs(gemsInfo) do
					local gemsQuality = ConfigReader:getDataByNameIdAndKey("ItemConfig", tostring(gems.code), "Quality")

					if gemsQuality == quality then
						gemsNum = gemsNum + gems.amount
					end
				end
			end
		end
	end

	return gemsNum
end

function ClubBashenSystem:getCurOpenPackIndex()
	local totalRecord = self._clubBashen:getTotalRecord()

	return table.nums(totalRecord)
end

function ClubBashenSystem:getCostReopenMaxCount()
	local costData = ConfigReader:getDataByNameIdAndKey("ConfigValue", "BaShen_ResetPay", "content")

	if costData then
		return costData.payTimes
	end

	return 0
end

function ClubBashenSystem:getFreeReopenMaxCount()
	return self._clubBashen:getFreeReopenMaxCount()
end

function ClubBashenSystem:sortQualityList(qualityList)
	for i = 1, #qualityList do
		local randomNum = math.random(1, #qualityList)

		qualityList[i], qualityList[randomNum] = qualityList[randomNum], qualityList[i]
	end
end

function ClubBashenSystem:playOpenGemsAudio(quality)
	if quality == GemQuality.purple then
		-- block empty
	elseif quality == GemQuality.orange then
		-- block empty
	end
end

function ClubBashenSystem:requestOpenNewPack(callback)
	local clubService = self:getInjector():getInstance(ClubService)

	clubService:requestOpenNewPack({}, true, function(response)
		if response.resCode == GS_SUCCESS then
			self:dispatch(Event:new(EVT_CLUB_BASHEN_REWARD_CHANGE))

			if callback then
				callback(response.data)
			end
		end
	end)
end

function ClubBashenSystem:requestReopenPack(index, callback)
	local clubService = self:getInjector():getInstance(ClubService)
	local params = {
		index = index
	}

	clubService:requestReopenPack(params, true, function(response)
		if response.resCode == GS_SUCCESS then
			self:dispatch(Event:new(EVT_CLUB_BASHEN_REOPEN_SUCC))

			if callback then
				callback(response.data)
			end
		end
	end)
end

function ClubBashenSystem:requestGetAnnounce(isFirstRequest, callback)
	local clubService = self:getInjector():getInstance(ClubService)

	clubService:requestGetAnnounce({}, false, function(response)
		if response.resCode == GS_SUCCESS then
			self._clubBashen:syncAnnounce(response.data)
			self:dispatch(Event:new(EVT_CLUB_BASHEN_RECEIVE_ANNOUNCE, {
				isFirstRequest = isFirstRequest
			}))

			if callback then
				callback()
			end
		end
	end)
end

function ClubBashenSystem:requestBashenRank(type, startIndex, endIndex, callback)
	local clubService = self:getInjector():getInstance(ClubService)
	local params = {
		type = type,
		start = startIndex,
		["end"] = endIndex
	}

	clubService:requestGetBashenRank(params, true, function(response)
		if response.resCode == GS_SUCCESS then
			self._clubBashen:syncRankData(response.data)

			if callback then
				callback()
			end
		end
	end)
end

function ClubBashenSystem:requestBashenManualFinish(callback)
	local clubService = self:getInjector():getInstance(ClubService)

	clubService:requestBashenManualFinish({}, true, function(response)
		if response.resCode == GS_SUCCESS then
			self:dispatch(Event:new(EVT_CLUB_BASHEN_REWARD_CHANGE))

			if callback then
				callback(response)
			end
		end
	end)
end
