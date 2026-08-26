-- chunkname: @modules/logic/autochess/main/model/AutoChessGameModel.lua

module("modules.logic.autochess.main.model.AutoChessGameModel", package.seeall)

local AutoChessGameModel = class("AutoChessGameModel", BaseModel)

function AutoChessGameModel:initTileNodes(sceneType)
	self.viewType = sceneType
	self.tileNodes = {}

	local row = AutoChessEnum.BoardSize.Row
	local column = sceneType == AutoChessEnum.ViewType.All and AutoChessEnum.BoardSize.Column * 2 or AutoChessEnum.BoardSize.Column
	local offsetX = AutoChessEnum.TileOffsetX[sceneType]

	for i = 1, row do
		local tileSize = AutoChessEnum.TileSize[sceneType][i]
		local startPos = AutoChessEnum.TileStartPos[sceneType][i]

		self.tileNodes[i] = self.tileNodes[i] or {}

		for j = 1, column do
			local x = startPos.x + (j - 1) * (tileSize.x + offsetX)

			self.tileNodes[i][j] = Vector2(x, startPos.y)
		end
	end
end

function AutoChessGameModel:getNearestTileXY(posX, posY)
	for row, posTbl in ipairs(self.tileNodes) do
		local tileSize

		for column, pos in ipairs(posTbl) do
			local xDis = math.abs(posX - pos.x)
			local yDis = math.abs(posY - pos.y)

			if xDis < AutoChessEnum.TileSize[self.viewType][row].x / 2 and yDis < AutoChessEnum.TileSize[self.viewType][row].y / 2 then
				return row, column
			end
		end
	end
end

function AutoChessGameModel:getChessLocation(x, y, isBoss)
	if isBoss then
		if self.viewType == AutoChessEnum.ViewType.Enemy then
			return Vector2(0, 60)
		elseif self.viewType == AutoChessEnum.ViewType.All then
			return Vector2(460, 15)
		end
	else
		local posTbl = self.tileNodes[x]
		local pos = posTbl[y]

		pos = pos or posTbl[y - 5]

		return pos
	end
end

function AutoChessGameModel:getNearestLeader(pos)
	if self.viewType == AutoChessEnum.ViewType.Player then
		local location = self:getLeaderLocation(AutoChessEnum.TeamType.Player)
		local xDis = math.abs(pos.x - location.x)
		local yDis = math.abs(pos.y - location.y)

		if xDis < 55 and yDis < 145 then
			return AutoChessModel.instance:getChessMo().svrFight.mySideMaster
		end
	elseif self.viewType == AutoChessEnum.ViewType.Enemy then
		local location = self:getLeaderLocation(AutoChessEnum.TeamType.Enemy)
		local xDis = math.abs(pos.x - location.x)
		local yDis = math.abs(pos.y - location.y)

		if xDis < 55 and yDis < 145 then
			return AutoChessModel.instance:getChessMo().svrFight.enemyMaster
		end
	end
end

function AutoChessGameModel:getLeaderLocation(teamType)
	local posTbl = AutoChessEnum.LeaderPos[self.viewType]

	return posTbl[teamType]
end

function AutoChessGameModel:setChessAvatar(go)
	self.avatar = go
end

function AutoChessGameModel:setUsingLeaderSkill(bool, types, noEvent)
	self.usingLeaderSkill = bool
	self.targetTypes = types

	if not noEvent then
		AutoChessController.instance:dispatchEvent(AutoChessEvent.UsingLeaderSkill, bool)
	end
end

AutoChessGameModel.instance = AutoChessGameModel.New()

return AutoChessGameModel
