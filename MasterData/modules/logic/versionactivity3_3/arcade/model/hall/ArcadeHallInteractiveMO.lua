-- chunkname: @modules/logic/versionactivity3_3/arcade/model/hall/ArcadeHallInteractiveMO.lua

module("modules.logic.versionactivity3_3.arcade.model.hall.ArcadeHallInteractiveMO", package.seeall)

local ArcadeHallInteractiveMO = class("ArcadeHallInteractiveMO", ArcadeHallEntityMO)

function ArcadeHallInteractiveMO:initConfig()
	self.co = ArcadeConfig.instance:getInteractiveCfg(self.id)
end

function ArcadeHallInteractiveMO:initGrid()
	local grid = string.splitToNumber(self.co.grid, "#")
	local pos = string.splitToNumber(self.co.pos, "#")

	self._gridX, self._gridY = grid[1], grid[2]
	self._posX, self._posY = pos[1], pos[2]
end

function ArcadeHallInteractiveMO:getResPath()
	if not string.nilorempty(self.co.resPath) then
		return (string.format(ArcadeEnum.SceneResUrl, self.co.resPath))
	end
end

function ArcadeHallInteractiveMO:getIcon()
	return
end

function ArcadeHallInteractiveMO:getInteractiveParams()
	return ArcadeHallEnum.HallInteractiveParams[self.id]
end

function ArcadeHallInteractiveMO:getShowInfoUI()
	local param = self:getInteractiveParams()

	return param and param.ShowInfoUI
end

function ArcadeHallInteractiveMO:gridRange()
	local minPosX, minPosY = self._posX, self._posY
	local maxPosX, maxPosY = self._posX + self._gridX - 1, self._posY + self._gridY - 1

	return minPosX, minPosY, maxPosX, maxPosY
end

function ArcadeHallInteractiveMO:isEnterRange(x, y)
	local minPosX, minPosY, maxPosX, maxPosY = self:gridRange()

	return minPosX <= x and x <= maxPosX and minPosY <= y and y <= maxPosY
end

function ArcadeHallInteractiveMO:getNeareastGrid(x, y)
	local gridX, gridY
	local minPosX, minPosY, maxPosX, maxPosY = self:gridRange()

	gridY = y < minPosY and minPosY or maxPosY < y and maxPosY or y

	return x < minPosX and minPosX or maxPosX < x and maxPosX or x, gridY
end

function ArcadeHallInteractiveMO:setReddotType(reddotType)
	self._reddotType = reddotType
end

function ArcadeHallInteractiveMO:getReddotType()
	return self._reddotType
end

function ArcadeHallInteractiveMO:isUnlock()
	local param = ArcadeHallEnum.LevelScene[self.id]

	if not param then
		return true
	end

	return (ArcadeOutSizeModel.instance:isUnlockLevel(param.Level))
end

return ArcadeHallInteractiveMO
