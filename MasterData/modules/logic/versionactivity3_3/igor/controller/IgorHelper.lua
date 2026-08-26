-- chunkname: @modules/logic/versionactivity3_3/igor/controller/IgorHelper.lua

module("modules.logic.versionactivity3_3.igor.controller.IgorHelper", package.seeall)

local IgorHelper = {}

function IgorHelper.getPutEntityPosByScreenPos(screenPos)
	local offsetX = -83
	local offsetY = -100

	return screenPos.x + offsetX, screenPos.y + offsetY
end

return IgorHelper
