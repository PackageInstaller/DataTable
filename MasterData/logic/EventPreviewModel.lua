-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eventpreview/model/EventPreviewModel.lua

module("logic.extensions.eventpreview.model.EventPreviewModel", package.seeall)

local EventPreviewModel = class("EventPreviewModel", BaseModel)

function EventPreviewModel:ctor()
	return
end

function EventPreviewModel:onInit()
	self:onReset()
end

function EventPreviewModel:onReset()
	self._allInfo = {}
	self._isAllZan = false
	self._id2likeTimes = {}
	self._unlockInfo = {}
end

function EventPreviewModel:setAllInfo(msg)
	self._allInfo.curProgress = msg.curProgress
	self._allInfo.infos = msg.infos
	self._allInfo.gainProgressPrizeIds = msg.gainProgressPrizeIds

	self:_setIsAllZan(self._allInfo.infos)
	self:_calSpaceInfo(msg.spaceInfos)
end

function EventPreviewModel:setUpcomingInfo(infos)
	self._allInfo.infos = infos

	self:_setIsAllZan(infos)
end

function EventPreviewModel:setGainProgressPrize(msg)
	self._allInfo.gainProgressPrizeIds = msg.gainProgressPrizeIds
end

function EventPreviewModel:_setIsAllZan(infos)
	self._isAllZan = false

	for k, v in pairs(infos) do
		if checknumber(v.likeTimes) <= 0 then
			self._isAllZan = true
		end
	end
end

function EventPreviewModel:getAllInfo()
	return self._allInfo
end

function EventPreviewModel:getIsAllZan()
	return self._isAllZan
end

function EventPreviewModel:isPlayerRewardCanGet(isInActTime, prizeId, needScore)
	local isScoreEnough = needScore <= checknumber(self._allInfo.curProgress)

	if isScoreEnough and isInActTime then
		local isGeted = self:isPlayerRewardGeted(prizeId)

		return not isGeted
	else
		return false
	end
end

function EventPreviewModel:isPlayerRewardGeted(prizeId)
	if not self._allInfo.gainProgressPrizeIds then
		return TableUtil.isHad(self._allInfo.gainProgressPrizeIds, prizeId)
	end
end

function EventPreviewModel:_calSpaceInfo(spaceInfos)
	self._id2likeTimes = {}

	for i, v in ipairs(spaceInfos) do
		self._id2likeTimes[v.id] = v.likeTimes
	end
end

function EventPreviewModel:getLikeTimes(id)
	return self._id2likeTimes[id] or 0
end

function EventPreviewModel:getUnlockInfo(actId)
	local unlockInfo = self._unlockInfo[actId]

	if not unlockInfo then
		printInfo("预告基础数据未初始化")
	end

	return unlockInfo
end

function EventPreviewModel:onGetUnlockInfo(msg)
	local info = GameUtil.pbToTable(msg)

	self._unlockInfo[info.actId] = info
end

function EventPreviewModel:onSendUnlock(msg)
	local info = self:getUnlockInfo(msg.actId)

	if info then
		info.unlockedIds = info.unlockedIds or {}

		table.insert(info.unlockedIds, msg.id)
	end
end

function EventPreviewModel:onGainPersonPrize(msg)
	local info = self:getUnlockInfo(msg.actId)

	if info then
		info.gainedPersonPrizeIds = info.gainedPersonPrizeIds or {}

		if not msg.prizeIds then
			local prizeIds = {}

			for _, prizeId in ipairs(prizeIds) do
				table.insert(info.gainedPersonPrizeIds, prizeId)
			end
		end
	end
end

function EventPreviewModel:onGainWorldPrize(msg)
	local info = self:getUnlockInfo(msg.actId)

	if info then
		info.gainedWorldPrizeIds = info.gainedWorldPrizeIds or {}

		if not msg.prizeIds then
			local prizeIds = {}

			for _, prizeId in ipairs(prizeIds) do
				table.insert(info.gainedWorldPrizeIds, prizeId)
			end
		end
	end
end

EventPreviewModel.instance = EventPreviewModel.New()

return EventPreviewModel
