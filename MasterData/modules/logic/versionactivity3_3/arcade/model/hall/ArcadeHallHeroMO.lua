-- chunkname: @modules/logic/versionactivity3_3/arcade/model/hall/ArcadeHallHeroMO.lua

module("modules.logic.versionactivity3_3.arcade.model.hall.ArcadeHallHeroMO", package.seeall)

local ArcadeHallHeroMO = class("ArcadeHallHeroMO", ArcadeHallEntityMO)

function ArcadeHallHeroMO:initConfig()
	self._heroMo = ArcadeHeroModel.instance:getHeroMoById(self.id)
	self.co = self._heroMo.co
end

function ArcadeHallHeroMO:initGrid()
	self._gridX, self._gridY = 1, 1
	self._posX, self._posY = ArcadeHeroModel.instance:getCharacterPos()
end

function ArcadeHallHeroMO:getResPath()
	if not string.nilorempty(self.co.resPath) then
		return (string.format(ArcadeEnum.SceneResUrl, self.co.resPath))
	end
end

function ArcadeHallHeroMO:isRange(x, y)
	local minPosX, minPosY = self._posX, self._posY
	local maxPosX, maxPosY = self._posX + self._gridX - 1, self._posY + self._gridY - 1

	return minPosX <= x and x <= maxPosX and minPosY <= y and y <= maxPosY
end

function ArcadeHallHeroMO:getHeroMo()
	return self._heroMo
end

function ArcadeHallHeroMO:setGridPos(x, y)
	self._posX, self._posY = x, y

	ArcadeHallModel.instance:setHeroGrid(x, y)
end

return ArcadeHallHeroMO
