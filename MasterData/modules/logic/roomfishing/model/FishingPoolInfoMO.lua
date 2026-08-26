-- chunkname: @modules/logic/roomfishing/model/FishingPoolInfoMO.lua

module("modules.logic.roomfishing.model.FishingPoolInfoMO", package.seeall)

local FishingPoolInfoMO = pureTable("FishingPoolInfoMO")

function FishingPoolInfoMO:init(userId, fishingPoolInfo)
	self.userId = userId
	self.poolId = fishingPoolInfo.poolId
	self.refreshTime = fishingPoolInfo.refreshTime

	self:updateBoatInfos(fishingPoolInfo.boatsInfo)
	self:updateFishingProgressInfos(fishingPoolInfo.fishingProgress)
end

function FishingPoolInfoMO:updateBoatInfos(boatInfos)
	self._boatInfoDict = {}

	if boatInfos then
		for i, boatInfo in ipairs(boatInfos) do
			self._boatInfoDict[boatInfo.userId] = {
				isFriend = boatInfo.type == FishingEnum.OtherPlayerBoatType.Friend,
				userId = boatInfo.userId,
				name = boatInfo.name,
				portrait = boatInfo.portrait
			}
		end
	end
end

function FishingPoolInfoMO:updateFishingProgressInfos(fishingProgressInfos)
	self.myProgressInfoDict = {}
	self.otherProgressInfoDict = {}

	if fishingProgressInfos then
		for _, fishingProgressInfo in ipairs(fishingProgressInfos) do
			self:updateFishingProgressInfo(fishingProgressInfo)
		end
	end
end

function FishingPoolInfoMO:updateFishingProgressInfo(fishingProgressInfo)
	local dataInfo = {
		userId = fishingProgressInfo.fisheryUserId,
		poolId = fishingProgressInfo.poolId,
		fishTimes = fishingProgressInfo.fishTimes,
		startTime = fishingProgressInfo.startTime,
		finishTime = fishingProgressInfo.finishTime,
		name = fishingProgressInfo.name,
		portrait = fishingProgressInfo.portrait
	}

	if fishingProgressInfo.type == FishingEnum.FishingProgressType.Myself then
		self.myProgressInfoDict[dataInfo.userId] = dataInfo
	else
		self.otherProgressInfoDict[dataInfo.userId] = dataInfo
	end
end

function FishingPoolInfoMO:setFriendInfo(friendInfo)
	self._friendName = friendInfo.name
	self._friendPortrait = friendInfo.portrait
end

function FishingPoolInfoMO:getUserId()
	return self.userId
end

function FishingPoolInfoMO:getPoolId()
	return self.poolId
end

function FishingPoolInfoMO:getLastRefreshTime()
	return self.refreshTime or 0
end

function FishingPoolInfoMO:getOwnerInfo()
	local userId = self:getUserId()
	local name = ""
	local portrait = CommonConfig.instance:getConstNum(ConstEnum.PlayerDefaultIcon)
	local myUserId = PlayerModel.instance:getMyUserId()

	if userId == myUserId then
		name = luaLang("p_roomview_fishing_myself")

		local playerInfo = PlayerModel.instance:getPlayinfo()

		portrait = playerInfo.portrait
	else
		name = self._friendName or name
		portrait = self._friendPortrait or portrait
	end

	return userId, name, portrait
end

function FishingPoolInfoMO:getBoatInfoList()
	local result = {}

	for _, boatInfo in pairs(self._boatInfoDict) do
		result[#result + 1] = boatInfo
	end

	return result
end

function FishingPoolInfoMO:getBoatUserInfo(userId)
	local name = ""
	local portrait = CommonConfig.instance:getConstNum(ConstEnum.PlayerDefaultIcon)

	if self._boatInfoDict then
		if self._boatInfoDict then
			name = self._boatInfoDict.name
			portrait = self._boatInfoDict.portrait
		end

		return name, portrait
	end
end

function FishingPoolInfoMO:getMyProgressInfoDict()
	return self.myProgressInfoDict
end

function FishingPoolInfoMO:getOtherProgressInfoDict()
	return self.otherProgressInfoDict
end

function FishingPoolInfoMO:getMyProgressInfo(userId)
	return self.myProgressInfoDict and self.myProgressInfoDict[userId]
end

function FishingPoolInfoMO:getFishingCount()
	local result = 0

	if self.myProgressInfoDict then
		for _, progressInfo in pairs(self.myProgressInfoDict) do
			local startTime = progressInfo.startTime
			local endTime = progressInfo.finishTime
			local isFinished = FishingHelper.isFishingFinished(startTime, endTime)

			if not isFinished then
				result = result + 1
			end
		end
	end

	return result
end

return FishingPoolInfoMO
