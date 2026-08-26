-- chunkname: @modules/logic/versionactivity3_2/cruise/model/Activity217Model.lua

module("modules.logic.versionactivity3_2.cruise.model.Activity217Model", package.seeall)

local Activity217Model = class("Activity217Model", BaseModel)

function Activity217Model:onInit()
	self:reInit()
end

function Activity217Model:reInit()
	self._actInfos = {}
	self._liveId = nil
end

function Activity217Model:setAct217Info(info)
	if info then
		if not info.activityId then
			local actId = VersionActivity3_2Enum.ActivityId.CruiseTripleDrop

			self._actInfos[actId] = self._actInfos[actId] or Activity217InfoMO.New()

			self._actInfos[actId]:init(info)

			self._liveId = nil
		end
	end
end

function Activity217Model:updateAct217Info(info)
	self:setAct217Info(info)
end

function Activity217Model:getActInfoById(actId)
	return self._actInfos[actId]
end

function Activity217Model:updateExpEpisodeCount(count, actId)
	actId = actId or self:getLiveActId()

	if not self._actInfos[actId] then
		return
	end

	self._actInfos[actId]:updateExpEpisodeCount(count)
end

function Activity217Model:updateCoinEpisodeCount(count, actId)
	actId = actId or self:getLiveActId()

	if not self._actInfos[actId] then
		return
	end

	self._actInfos[actId]:updateCoinEpisodeCount(count)
end

function Activity217Model:getExpEpisodeCount(actId)
	actId = actId or self:getLiveActId()

	if not self._actInfos[actId] then
		return 0
	end

	local controlCo = Activity217Config.instance:getControlCO(Activity217Enum.ActType.MultiExp, actId)

	return self:getLeftCountByCo(controlCo)
end

function Activity217Model:getCoinEpisodeCount(actId)
	actId = actId or self:getLiveActId()

	if not self._actInfos[actId] then
		return 0
	end

	local controlCo = Activity217Config.instance:getControlCO(Activity217Enum.ActType.MultiCoin, actId)

	return self:getLeftCountByCo(controlCo)
end

function Activity217Model:getShowTripleByChapter(chapterId, actId)
	actId = actId or self:getLiveActId()

	local actInfoMo = ActivityModel.instance:getActivityInfo()[actId]

	if not actInfoMo or not actInfoMo:isOnline() or not actInfoMo:isOpen() or actInfoMo:isExpired() then
		return false
	end

	local controlCos = Activity217Config.instance:getControlCos(actId)
	local actInfo = self._actInfos[actId]

	for _, config in pairs(controlCos) do
		local targetChapterId = Activity217Enum.DungeonChapter[config.showtype]

		if targetChapterId and targetChapterId == chapterId then
			local magnification = config.magnification
			local limit = config.limit
			local isDaily = false
			local dailyLimit = 0
			local leftCount = 0

			if not string.nilorempty(config.dailyLimit) then
				dailyLimit = config.dailyLimit
				isDaily = true
			end

			local dailyUseCount = actInfo:getDailyUseCountByType(config.type)
			local totalUseCount = actInfo:getTotalUseCountByType(config.type)

			if isDaily then
				local dailyLeftCount = dailyLimit - dailyUseCount
				local totalLeftCount = limit - totalUseCount

				leftCount = totalLeftCount < dailyLeftCount and totalLeftCount or dailyLeftCount
				limit = dailyLimit
			else
				leftCount = limit - totalUseCount
			end

			return true, leftCount, limit, magnification, isDaily
		end
	end

	return false
end

function Activity217Model:getLeftCountByCo(config)
	if not config then
		return 0
	end

	local actId = self:getLiveActId()
	local actInfo = self._actInfos[actId]
	local limit = config.limit
	local dailyUseCount = actInfo:getDailyUseCountByType(config.type)
	local totalUseCount = actInfo:getTotalUseCountByType(config.type)
	local dailyLeftCount = ((not string.nilorempty(config.dailyLimit) or nil) and config.dailyLimit) - dailyUseCount
	local totalLeftCount = limit - totalUseCount

	return totalLeftCount < dailyLeftCount and totalLeftCount or dailyLeftCount
end

function Activity217Model:getLiveActId()
	if self._liveId then
		return self._liveId
	end

	for actId, mo in pairs(self._actInfos) do
		local actInfoMo = ActivityModel.instance:getActMO(actId)

		if actInfoMo and actInfoMo:isOnline() and actInfoMo:isOpen() and not actInfoMo:isExpired() then
			self._liveId = actId

			return actId
		end
	end

	return -1
end

function Activity217Model:getActName()
	local name = ""
	local id = self:getLiveActId()

	if id == -1 then
		return name
	end

	local co = ActivityConfig.instance:getActivityCo(id)

	name = co and co.name

	return name
end

Activity217Model.instance = Activity217Model.New()

return Activity217Model
