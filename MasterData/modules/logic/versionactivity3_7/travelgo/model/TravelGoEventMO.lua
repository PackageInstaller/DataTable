-- chunkname: @modules/logic/versionactivity3_7/travelgo/model/TravelGoEventMO.lua

module("modules.logic.versionactivity3_7.travelgo.model.TravelGoEventMO", package.seeall)

local TravelGoEventMO = pureTable("TravelGoEventMO")

function TravelGoEventMO:setData(day, eventId)
	self.day = day
	self.eventId = eventId
	self.gameId = TravelGoModel.instance.gameId
	self.cfg = TravelGoConfig.instance:getEventCfgByEventId(self.gameId, self.eventId)
	self.eventType = self.cfg.type

	if not string.nilorempty(self.cfg.frontText) then
		self.descList = string.split(self.cfg.frontText, "#")
	end

	self:onSetData()
end

function TravelGoEventMO:getResultRewards()
	if not self.rewardList then
		local str = self:getResultRewardStr()

		self.rewardList = TravelGoController.instance.travelGoRewardMgr:parseRewardStr(str)
	end

	return self.rewardList
end

function TravelGoEventMO:onSetData()
	return
end

function TravelGoEventMO:getResultRewardStr()
	return
end

return TravelGoEventMO
