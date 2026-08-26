-- chunkname: @modules/logic/roomfishing/controller/FishingHelper.lua

module("modules.logic.roomfishing.controller.FishingHelper", package.seeall)

local FishingHelper = _M

function FishingHelper.getFishingProgress(startTime, endTime)
	local result = 0

	if startTime and endTime and startTime > 0 and endTime > 0 and startTime < endTime then
		local nowTime = ServerTime.now()
		local progress = Mathf.Clamp((nowTime - startTime) / (endTime - startTime), 0, 1)

		result = tonumber(string.format("%.2f", progress)) * 100
	end

	return result
end

function FishingHelper.isFishingFinished(startTime, endTime)
	local result = false

	if startTime and endTime and startTime > 0 and endTime > 0 then
		local nowTime = ServerTime.now()

		result = endTime < nowTime
	end

	return result
end

return FishingHelper
