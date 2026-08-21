-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/containmentzone/model/ContainmentReportMo.lua

module("logic.extensions.containmentzone.model.ContainmentReportMo", package.seeall)

local M = class("ContainmentReportMo")

function M:ctor()
	return
end

function M:updateFromServer(reportData)
	self._roomId = reportData.roomId
	self._uuid = reportData.uuid
	self._reportId = reportData.reportId
	self._protomerId = reportData.protomerId
	self._failLevel = reportData.failLevel
	self._score = reportData.score
	self._presure = reportData.presure
	self._point = reportData.point
	self._rewards = {}

	if reportData.rewards and #reportData.rewards > 0 then
		for index, value in ipairs(reportData.rewards) do
			table.insert(self._rewards, {
				itemCode = value.itemCode,
				itemCount = value.itemCount
			})
		end
	end

	self._echoItem = reportData.echoItem
	self._failEffect = {}

	if reportData.failEffect and #reportData.failEffect > 0 then
		for index, value in ipairs(reportData.failEffect) do
			table.insert(self._failEffect, value)
		end
	end

	self._receive = reportData.receive
	self._intelligence = reportData.intelligence
	self._heroId = reportData.heroId
	self._touchWay = reportData.touchWay
	self._descId = reportData.desc
	self._read = reportData.read
	self._moodDeduct = {}

	if reportData.moodDeduct and #reportData.moodDeduct > 0 then
		for index, v in ipairs(reportData.moodDeduct) do
			table.insert(self._moodDeduct, {
				heroId = v.key,
				mood = v.value
			})
		end
	end

	self._isRunning = false
	self._isVaild = true
end

function M:getRewardsItemDataLst()
	local dataLst = {}
	local rewardLst = self:getRewards()

	if rewardLst and #rewardLst > 0 then
		for index, value in ipairs(rewardLst) do
			if value.itemCount > 0 then
				local itemData = ItemUtil.createItemData({
					itemId = value.itemCode
				})

				itemData:setCount(value.itemCount)
				table.insert(dataLst, itemData)
			end
		end
	end

	return dataLst
end

function M:getIsRunning()
	return self._isRunning
end

function M:getRoomId()
	return self._roomId
end

function M:setRoomId(val)
	self._roomId = val
end

function M:getHeroId()
	return self._heroId
end

function M:setHeroId(heroId)
	self._heroId = heroId
end

function M:getTouchWay()
	return self._touchWay
end

function M:setTouchWay(touchWay)
	self._touchWay = touchWay
end

function M:getUuid()
	return self._uuid
end

function M:getReportId()
	return self._reportId
end

function M:getProtomerId()
	return self._protomerId
end

function M:setProtomerId(protomerId)
	self._protomerId = protomerId
end

function M:getFailLevel()
	return self._failLevel
end

function M:getScore()
	return self._score
end

function M:getPresure()
	return self._presure
end

function M:getPoint()
	return self._point
end

function M:getRewards()
	return self._rewards
end

function M:getEchoItem()
	return self._echoItem
end

function M:getFailEffect()
	return self._failEffect
end

function M:getFailEffectByCode(code)
	return self._failEffect[code] or 0
end

function M:getRecive()
	return self._receive
end

function M:setReceive(isReceive)
	self._receive = isReceive
end

function M:getIntelligence()
	return self._intelligence
end

function M:getDescId()
	return self._descId
end

function M:getRead()
	return self._read
end

function M:setRead(isRead)
	self._read = isRead
end

function M:getMoodDeduct()
	return self._moodDeduct
end

function M:createRunningReport(roomId, protomerInfoMo, heroId)
	self._roomId = roomId
	self._uuid = "running"
	self._reportId = ""
	self._protomerId = protomerInfoMo and protomerInfoMo:getProtomerId() or 0
	self._failLevel = 0
	self._score = 0
	self._presure = protomerInfoMo and protomerInfoMo:getPressure() or 0
	self._point = 0
	self._rewards = {}
	self._echoItem = 0
	self._failEffect = {}
	self._receive = false
	self._intelligence = 0
	self._heroId = heroId
	self._touchWay = protomerInfoMo and protomerInfoMo:getTouchWay() or 1
	self._descId = 0
	self._read = true
	self._moodDeduct = {}
	self._isRunning = true
	self._isVaild = true
end

function M:getIsVaild()
	return self._isVaild
end

function M:setIsVaild(vaild)
	self._isVaild = vaild
end

function M:getRunningReportTotalSecond()
	return self._runningTotalSecond or 0
end

function M:setRunningReportTotalSecond(second)
	self._runningTotalSecond = second
end

function M:getRunningReportRemainSecond()
	return self._runningRemainSecond or 0
end

function M:setRunningReportRemainSecond(second)
	self._runningRemainSecond = second
end

function M:getRunningReportUpdateTimeStamp()
	return self._runningUpdateTimeStamp or 0
end

function M:setRunningReportUpdateTimeStamp(ts)
	self._runningUpdateTimeStamp = ts
end

function M:getRunningReportSpeed()
	return self._runningReportSpeed or 1
end

function M:setRunningReportSpeed(speed)
	self._runningReportSpeed = speed
end

return M
