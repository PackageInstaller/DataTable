-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nailonghotsearch/data/NaiLongHotSearchMo.lua

module("logic.extensions.nailonghotsearch.data.NaiLongHotSearchMo", package.seeall)

local NaiLongHotSearchMo = class("NaiLongHotSearchMo")

function NaiLongHotSearchMo:ctor(activityId)
	self._activityId = activityId
	self._heatValue = 0
	self._kudosCount = 0
	self._gainProgressPrizeIds = {}
	self._todayKudosTimes = 0
	self._totalCostGiftCount = 0
	self._todayReply = false
	self._recordList = {}

	local actData = NaiLongHotSearchConfig.instance:getActData(self._activityId)

	self._dailyKudosLimit = actData.dailyKudosLimit
end

function NaiLongHotSearchMo:dispose()
	return
end

function NaiLongHotSearchMo:handlePM_HotSearchGetInfoRes(msg)
	self._heatValue = checknumber(msg.heatValue)
	self._kudosCount = checknumber(msg.kudosCount)
	self._gainProgressPrizeIds = GameUtil.pbToTable(msg.gainProgressPrizeIds) or {}
	self._todayKudosTimes = msg.todayKudosTimes
	self._totalCostGiftCount = msg.totalCostGiftCount
	self._todayReply = msg.todayReply
	self._recordList = msg.recordList

	self:_updateTodayRecord()
end

function NaiLongHotSearchMo:handlePM_HotSearchGainPrizeRes(msg)
	table.insertto(self._gainProgressPrizeIds, msg.prizeIds)
end

function NaiLongHotSearchMo:handlePM_HotSearchReplyRes(msg)
	return
end

function NaiLongHotSearchMo:handlePM_HotSearchKudosRes(msg)
	self._kudosCount = self._kudosCount + 1
	self._todayKudosTimes = self._todayKudosTimes + 1
end

function NaiLongHotSearchMo:handlePM_HotSearchPresentRes(msg)
	self._totalCostGiftCount = msg.totalCostGiftCount
end

function NaiLongHotSearchMo:getHeatValue()
	return self._heatValue
end

function NaiLongHotSearchMo:getKudosCount()
	return self._kudosCount
end

function NaiLongHotSearchMo:getTodayKudosTimes()
	return self._todayKudosTimes
end

function NaiLongHotSearchMo:isHasDailyKudosLimit()
	return self._todayKudosTimes >= self._dailyKudosLimit
end

function NaiLongHotSearchMo:getTotalCostGiftCount()
	return self._totalCostGiftCount
end

function NaiLongHotSearchMo:getTodayReply()
	return self._todayReply
end

function NaiLongHotSearchMo:getRecordList()
	return self._recordList
end

function NaiLongHotSearchMo:getTodayRecord()
	if self._todayReply then
		return self._todayRecord
	end
end

function NaiLongHotSearchMo:_updateTodayRecord()
	self._todayRecord = nil

	local now = ServerTime.now()
	local nowStamp = ServerTime.now() - GameUtil.SERVER_TICK_DAILYR_EFRESH * 3600
	local nowDate = GameUtil.time2date(nowStamp)
	local todayStart = GameUtil.date2time(nowDate.year, nowDate.month, nowDate.day, GameUtil.SERVER_TICK_DAILYR_EFRESH, 0, 0)
	local todayEnd = todayStart + 86400
	local recordTime = 0

	for _, v in ipairs(self._recordList) do
		recordTime = Mathf.Floor(checknumber(v.replyTime) / 1000)

		if todayStart <= recordTime and recordTime < todayEnd then
			self._todayRecord = v

			break
		end
	end
end

function NaiLongHotSearchMo:getGainProgressPrizeIds()
	return self._gainProgressPrizeIds
end

function NaiLongHotSearchMo:isCanGetPrize(prizeId)
	return not self:isHasGainPrize(prizeId) and self:isEnoughGetPrize(prizeId)
end

function NaiLongHotSearchMo:isHasGainPrize(prizeId)
	return table.indexof(self._gainProgressPrizeIds, prizeId) ~= false
end

function NaiLongHotSearchMo:isEnoughGetPrize(prizeId)
	local data = NaiLongHotSearchConfig.instance:getProPrizeData(self._activityId, prizeId)

	return checknumber(data and data.needProgress) <= self._heatValue
end

return NaiLongHotSearchMo
