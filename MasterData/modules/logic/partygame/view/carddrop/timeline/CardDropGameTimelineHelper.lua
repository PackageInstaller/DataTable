-- chunkname: @modules/logic/partygame/view/carddrop/timeline/CardDropGameTimelineHelper.lua

module("modules.logic.partygame.view.carddrop.timeline.CardDropGameTimelineHelper", package.seeall)

local CardDropGameTimelineHelper = _M

function CardDropGameTimelineHelper.getPosParam(posStr)
	if string.nilorempty(posStr) then
		return 0, 0, 0
	end

	local array = string.splitToNumber(posStr, ",")

	return array[1], array[2], array[3]
end

function CardDropGameTimelineHelper.getIntParam(param)
	local value = tonumber(param)

	if not value then
		logError("int param parse fail : " .. tostring(param))

		return 0
	end

	return value
end

return CardDropGameTimelineHelper
