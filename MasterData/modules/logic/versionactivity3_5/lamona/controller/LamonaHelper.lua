-- chunkname: @modules/logic/versionactivity3_5/lamona/controller/LamonaHelper.lua

module("modules.logic.versionactivity3_5.lamona.controller.LamonaHelper", package.seeall)

local LamonaHelper = _M

function LamonaHelper.getGridId(x, y, mapWidth)
	return (x and y and mapWidth and x > 0 and y > 0 and mapWidth > 0 or nil) and (y - 1) * mapWidth + x
end

function LamonaHelper.getXYFromGridId(gridId, mapWidth)
	local x, y = 0, 0

	if gridId and mapWidth and gridId > 0 and mapWidth > 0 then
		local row = math.floor((gridId - 1) / mapWidth)

		x = gridId - row * mapWidth
		y = row + 1
	end

	return x, y
end

function LamonaHelper.isOutsizeMap(x, y, mapWidth, mapHeight)
	if not x or not y or not mapWidth or not mapHeight then
		return
	end

	return x < 1 or mapWidth < x or y < 1 or mapHeight < y
end

function LamonaHelper.getGridPos(gridX, gridY)
	local x, y = 0, 0

	if gridX and gridY then
		local mapId = LamonaGameModel.instance:getMapId()
		local startX, startY = LamonaConfig.instance:getLamonaMapStartPos(mapId)
		local gridSizeX, gridSizeY = LamonaConfig.instance:getGridSize()

		x = startX + (gridX - 1) * gridSizeX
		y = startY + (gridY - 1) * gridSizeY
	end

	return x, y
end

function LamonaHelper.getUnitTypeResPath(type)
	local result
	local resName = LamonaConfig.instance:getLamonaUnitTypeResName(type)

	return (resName or nil) and string.format("ui/viewres/versionactivity_3_5/v3a5_lamona/lamona_unit/%s.prefab", resName)
end

function LamonaHelper.checkInGuiding()
	local isForbid = GuideController.instance:isForbidGuides()

	if isForbid then
		return false
	end

	local isDoingClickGuide = GuideModel.instance:isDoingClickGuide()
	local isAnyGuideRunning = GuideController.instance:isAnyGuideRunning()
	local isGuiding = GuideController.instance:isGuiding()

	if isDoingClickGuide or isAnyGuideRunning or isGuiding then
		return true
	end
end

return LamonaHelper
