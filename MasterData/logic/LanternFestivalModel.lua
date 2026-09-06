-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lanternfestival/model/LanternFestivalModel.lua

module("logic.extensions.lanternfestival.model.LanternFestivalModel", package.seeall)

local LanternFestivalModel = class("LanternFestivalModel", BaseModel)

function LanternFestivalModel:onInit()
	self:onReset()
end

function LanternFestivalModel:onReset()
	self._infoMap = {}
end

function LanternFestivalModel:getInfoByActId(activityId)
	local info = self._infoMap[activityId]

	if not info then
		printInfo("山海灯谜会数据不存在，activityId=%d", activityId)
	end

	return self._infoMap[activityId]
end

function LanternFestivalModel:onGetInfo(msg)
	local activityId = msg.activityId

	self._infoMap[activityId] = GameUtil.pbToTable(msg)
end

function LanternFestivalModel:onfinishPersionQuestion(msg)
	local activityId = msg.activityId
	local info = self:getInfoByActId(activityId)

	if info then
		info.todayGainPersonPrize = true
		info.gainPersonPrizeDayCount = msg.gainPersonPrizeDayCount
	end
end

function LanternFestivalModel:onAnswerChannelQuestion(msg)
	local newInfo = GameUtil.pbToTable(msg)
	local activityId = newInfo.activityId
	local info = self:getInfoByActId(activityId)

	if info then
		if newInfo.todayLastGainPrizeMillis then
			info.lastChannelPrizeMillis = newInfo.todayLastGainPrizeMillis
		end

		if newInfo.todayChannelPrizeTimes then
			info.todayChannelPrizeTimes = newInfo.todayChannelPrizeTimes
		end
	end
end

function LanternFestivalModel:onGainExtPrize(msg)
	local newInfo = GameUtil.pbToTable(msg)
	local activityId = newInfo.activityId
	local info = self:getInfoByActId(activityId)

	if info then
		info.gainExtPrize = true
	end
end

function LanternFestivalModel:onExchangeCollectPrize(msg)
	local newInfo = GameUtil.pbToTable(msg)
	local activityId = newInfo.activityId
	local info = self:getInfoByActId(activityId)

	if info then
		info.gainCollectPrizeIds = info.gainCollectPrizeIds or {}

		table.insert(info.gainCollectPrizeIds, newInfo.prizeId)
	end
end

LanternFestivalModel.instance = LanternFestivalModel.New()

return LanternFestivalModel
