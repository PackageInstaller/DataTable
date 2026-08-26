-- chunkname: @modules/logic/versionactivity3_2/cruise/model/Activity217InfoMO.lua

module("modules.logic.versionactivity3_2.cruise.model.Activity217InfoMO", package.seeall)

local Activity217InfoMO = pureTable("Activity217InfoMO")

function Activity217InfoMO:ctor()
	self.expEpisodeCount = 0
	self.coinEpisodeCount = 0
	self.typeInfoList = {}
	self._typeInfoDict = {}
end

function Activity217InfoMO:init(info)
	self.expEpisodeCount = info.expEpisodeCount
	self.coinEpisodeCount = info.coinEpisodeCount

	if info.typeInfos and #info.typeInfos > 0 then
		self:_updateTypeInfos(info.typeInfos)
	end

	self._subTypeCo = Activity217Config.instance:getSubTypeCO(info.activityId)
end

function Activity217InfoMO:_updateTypeInfos(infoList)
	self.typeInfoList = infoList
	self._typeInfoDict = {}

	for index, info in ipairs(infoList) do
		self._typeInfoDict[info.type] = info
	end
end

function Activity217InfoMO:updateInfo(info)
	self.expEpisodeCount = info.expEpisodeCount
	self.coinEpisodeCount = info.coinEpisodeCount
	self.typeInfoList = info.typeInfos

	if info.typeInfos and #info.typeInfos > 0 then
		self:_updateTypeInfos(info.typeInfos)
	end

	self._subTypeCo = Activity217Config.instance:getSubTypeCO(info.activityId)
end

function Activity217InfoMO:getDailyUseCountByType(type)
	local info = self._typeInfoDict[type]

	if not info then
		return 0
	end

	return info.dailyUseCount
end

function Activity217InfoMO:getTotalUseCountByType(type)
	local info = self._typeInfoDict[type]

	if not info then
		return 0
	end

	return info.totalUseCount
end

function Activity217InfoMO:updateExpEpisodeCount(count)
	self.expEpisodeCount = count
end

function Activity217InfoMO:updateCoinEpisodeCount(count)
	self.coinEpisodeCount = count
end

function Activity217InfoMO:getJumpId()
	return self._subTypeCo and self._subTypeCo.jumpId
end

function Activity217InfoMO:getReddot()
	return self._subTypeCo and self._subTypeCo.reddotId
end

return Activity217InfoMO
