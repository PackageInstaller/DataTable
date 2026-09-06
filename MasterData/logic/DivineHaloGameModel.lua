-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinehalogame/model/DivineHaloGameModel.lua

module("logic.extensions.divinehalogame.model.DivineHaloGameModel", package.seeall)

local DivineHaloGameModel = class("DivineHaloGameModel", BaseModel)

DivineHaloGameModel.CellAbstarctTypeEnum = {
	Wall = 3,
	Player = 1,
	Trig = 2
}
DivineHaloGameModel.CellTypeEnum = {
	ChangeColor = 2,
	LockWall = 4,
	MapSideWall = 8,
	ExitDoor = 7,
	PortalsDoor = 6,
	KeyCell = 5,
	Player = 1,
	ColorWall = 3,
	None = 0
}
DivineHaloGameModel.SpeedModeEnum = {
	Down = 3,
	Up = 1,
	Right = 2,
	Left = 4
}
DivineHaloGameModel.PlayerPosType = {
	Free = 3,
	Side = 1,
	Middle = 2
}
DivineHaloGameModel.PlayerChangeState = {
	ToInHorizontal = 1,
	ToInVertical = 2,
	ToOutVertical = 4,
	ToOutHorizontal = 3
}
DivineHaloGameModel.Map_Horizontal_Is_Side = {
	Right = 2,
	Left = 1,
	None = 0
}
DivineHaloGameModel.Map_Vertical_Is_Side = {
	Top = 1,
	Bottom = 2,
	None = 0
}

function DivineHaloGameModel:onInit()
	self:onReset()
end

function DivineHaloGameModel:onReset()
	self._infos = {}
	self._clientKeys = {}
end

function DivineHaloGameModel:getInfo(activityId)
	return self._infos[activityId]
end

function DivineHaloGameModel:handlePM_DivineHaloGameInfoRes(msg)
	self._infos[msg.activityId] = GameUtil.pbToTable(msg)
end

function DivineHaloGameModel:handlePM_DivineHaloGameBuyTimesRes(msg)
	local info = self._infos[msg.activityId]

	info.todayBuyTimes = msg.todayBuyTimes
end

function DivineHaloGameModel:handlePM_DivineHaloGameStartGameRes(msg)
	local info = self._infos[msg.activityId]

	info.serverKey = msg.serverKey
end

function DivineHaloGameModel:isTrigType(cellType)
	return cellType == DivineHaloGameModel.CellTypeEnum.ChangeColor or cellType == DivineHaloGameModel.CellTypeEnum.KeyCell or cellType == DivineHaloGameModel.CellTypeEnum.PortalsDoor or cellType == DivineHaloGameModel.CellTypeEnum.ExitDoor
end

function DivineHaloGameModel:isWallType(cellType)
	return cellType == DivineHaloGameModel.CellTypeEnum.ColorWall or cellType == DivineHaloGameModel.CellTypeEnum.LockWall or cellType == DivineHaloGameModel.CellTypeEnum.MapSideWall
end

function DivineHaloGameModel:isPlayerType(cellType)
	return cellType == DivineHaloGameModel.CellTypeEnum.Player
end

function DivineHaloGameModel:getCellAbstractType(cellType)
	if self:isTrigType(cellType) then
		return DivineHaloGameModel.CellAbstarctTypeEnum.Trig
	elseif self:isWallType(cellType) then
		return DivineHaloGameModel.CellAbstarctTypeEnum.Wall
	elseif self:isPlayerType(cellType) then
		return DivineHaloGameModel.CellAbstarctTypeEnum.Player
	end
end

function DivineHaloGameModel:getClientKey(activityId)
	local clientKey = math.random(1, ServerTime.now()) + activityId
	local info = self:getInfo(activityId)

	self._clientKeys[activityId] = clientKey

	return clientKey
end

function DivineHaloGameModel:getEncryptedKey(activityId, passOrNot)
	local info = self:getInfo(activityId)

	return (GameUtil.getClientEncryptedKey(self._clientKeys[activityId], info.serverKey, {
		activityId,
		passOrNot
	}))
end

DivineHaloGameModel.instance = DivineHaloGameModel.New()

return DivineHaloGameModel
