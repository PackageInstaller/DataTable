-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firepowercontest/game/strategy/FPC_MoveStrategyBase.lua

module("logic.extensions.firepowercontest.game.strategy.FPC_MoveStrategyBase", package.seeall)

local FPC_MoveStrategyBase = class("FPC_MoveStrategyBase")

function FPC_MoveStrategyBase:ctor()
	self._data = FirePowerContestModel.instance.handler.data
	self._speedMap = {}
end

function FPC_MoveStrategyBase.getPosByGrid(grid, gridSize, anchorPos)
	local x = anchorPos.x + grid.x * gridSize
	local y = anchorPos.y - grid.y * gridSize

	return Vector2.New(x, y)
end

function FPC_MoveStrategyBase:simulateMove(delta2SpeedZoom, items, item2Info, mapInfo, bNeedTraceObb)
	local gridSize = mapInfo.gridSize
	local anchorPos = mapInfo.anchorPos

	while delta2SpeedZoom >= self._data.oneCircleTotalSteps do
		delta2SpeedZoom = delta2SpeedZoom - self._data.oneCircleTotalSteps
	end

	delta2SpeedZoom = math.max(delta2SpeedZoom, 0)

	for _, item in ipairs(items) do
		local itemInfo = item2Info[item]
		local delta = delta2SpeedZoom
		local curGrid = self._data:getNodeData(itemInfo.posId)

		while true do
			local step = self._data.oneCircleTimeMap[curGrid.x][curGrid.y]

			if step <= delta then
				delta = delta - step
				curGrid = self._data:getTargetGrid(curGrid)
			else
				break
			end
		end

		if not curGrid then
			print(string.format("curGrid is nil panel'curStage = %s, data'curStage = %s", tostring(mapInfo.curStage), tostring(self._data.curStage)))
		end

		local beginPos = FPC_MoveStrategyBase.getPosByGrid(curGrid, gridSize, anchorPos)

		self._speedMap[curGrid.x] = self._speedMap[curGrid.x] or {}

		local speed = self._speedMap[curGrid.x][curGrid.y]

		if speed == nil then
			local targetGrid = self._data:getTargetGrid(curGrid)
			local endPos = FPC_MoveStrategyBase.getPosByGrid(targetGrid, gridSize, anchorPos)

			self._speedMap[curGrid.x][curGrid.y] = (endPos - beginPos):SetNormalize() * self._data.speedValue
			speed = self._speedMap[curGrid.x][curGrid.y]
		end

		local pos = beginPos + speed * delta

		GameUtil.setLocalPos(item, pos.x, pos.y)

		if bNeedTraceObb then
			table.insert(itemInfo.movePaths, pos)
		end
	end
end

return FPC_MoveStrategyBase
