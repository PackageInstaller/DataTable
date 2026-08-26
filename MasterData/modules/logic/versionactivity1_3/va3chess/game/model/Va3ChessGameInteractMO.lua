-- chunkname: @modules/logic/versionactivity1_3/va3chess/game/model/Va3ChessGameInteractMO.lua

module("modules.logic.versionactivity1_3.va3chess.game.model.Va3ChessGameInteractMO", package.seeall)

local Va3ChessGameInteractMO = pureTable("Va3ChessGameInteractMO")

function Va3ChessGameInteractMO:init(actId, serverData)
	self.id = serverData.id
	self.actId = actId

	self:updateMO(serverData)
end

function Va3ChessGameInteractMO:updateMO(serverData)
	self.posX = serverData.x
	self.posY = serverData.y
	self.direction = serverData.direction or 6

	if serverData.data and not string.nilorempty(serverData.data) then
		self.data = cjson.decode(serverData.data)
	end
end

function Va3ChessGameInteractMO:setXY(x, y)
	self.posX = x
	self.posY = y
end

function Va3ChessGameInteractMO:getXY()
	return self.posX, self.posY
end

function Va3ChessGameInteractMO:getPosIndex()
	return Va3ChessMapUtils.calPosIndex(self.posX, self.posY)
end

function Va3ChessGameInteractMO:getPedalStatusInDataField()
	if self.data then
		return self.data.pedalStatus
	end
end

function Va3ChessGameInteractMO:setPedalStatus(pedalStatus)
	if self.data then
		self.data.pedalStatus = pedalStatus
	end

	local pedalItem = Va3ChessGameController.instance.interacts:get(self.id)

	if pedalItem and pedalItem:getHandler().refreshPedalStatus then
		pedalItem:getHandler():refreshPedalStatus()
	end
end

function Va3ChessGameInteractMO:setBrazierIsLight(isLight)
	self._isLight = isLight
end

function Va3ChessGameInteractMO:getBrazierIsLight()
	return self._isLight or false
end

function Va3ChessGameInteractMO:setDirection(dir)
	self.direction = dir
end

function Va3ChessGameInteractMO:getDirection()
	return self.direction
end

function Va3ChessGameInteractMO:setHaveBornEff(haveBornEff)
	self.haveBornEff = haveBornEff
end

function Va3ChessGameInteractMO:getHaveBornEff()
	return self.haveBornEff
end

return Va3ChessGameInteractMO
