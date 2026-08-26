-- chunkname: @modules/logic/dispatch/model/DispatchInfoMo.lua

module("modules.logic.dispatch.model.DispatchInfoMo", package.seeall)

local DispatchInfoMo = pureTable("DispatchInfoMo")

function DispatchInfoMo:init(dispatchInfo)
	self.id = dispatchInfo.elementId

	self:updateMO(dispatchInfo)
end

function DispatchInfoMo:updateMO(dispatchInfo)
	self.dispatchId = dispatchInfo.dispatchId
	self.endTime = Mathf.Floor(tonumber(dispatchInfo.endTime) / 1000)
	self.heroIdList = dispatchInfo.heroIdList
end

function DispatchInfoMo:getDispatchId()
	return self.dispatchId
end

function DispatchInfoMo:getHeroIdList()
	return self.heroIdList
end

function DispatchInfoMo:getRemainTime()
	return Mathf.Max(self.endTime - ServerTime.now(), 0)
end

function DispatchInfoMo:getRemainTimeStr()
	local remainSecond = self:getRemainTime()
	local hours = math.floor(remainSecond / TimeUtil.OneHourSecond)
	local minutes = math.floor(remainSecond % TimeUtil.OneHourSecond / TimeUtil.OneMinuteSecond)
	local seconds = remainSecond % TimeUtil.OneMinuteSecond

	return string.format("%02d : %02d : %02d", hours, minutes, seconds)
end

function DispatchInfoMo:isRunning()
	return self.endTime > ServerTime.now()
end

function DispatchInfoMo:isFinish()
	return self.endTime <= ServerTime.now()
end

return DispatchInfoMo
