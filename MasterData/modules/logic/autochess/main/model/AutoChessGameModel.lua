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

		if sceneType == AutoChessEnum.ViewType.Player then
			self.tileNodes[4] = self.tileNodes[4] or {}

			local x = startPos.x - (tileSize.x + offsetX)

			self.tileNodes[4][i] = Vector2(x, startPos.y)
		end
	end
end

function AutoChessGameModel:getNearestTileXY(posX, posY)
	for row, posTbl in ipairs(self.tileNodes) do
		for column, pos in ipairs(posTbl) do
			local index = row ~= 4 and row or column
			local tileSize = AutoChessEnum.TileSize[self.viewType][index]
			local xDis = math.abs(posX - pos.x)
			local yDis = math.abs(posY - pos.y)

			if xDis < tileSize.x / 2 and yDis < tileSize.y / 2 then
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

function AutoChessGameModel:getNearestMaster(pos)
	local location1 = self:getLeaderLocation(AutoChessEnum.TeamType.Player)
	local location2 = self:getLeaderLocation(AutoChessEnum.TeamType.Enemy)

	if self.viewType == AutoChessEnum.ViewType.Player then
		local xDis = math.abs(pos.x - location1.x)
		local yDis = math.abs(pos.y - location1.y)

		if xDis < 55 and yDis < 145 then
			return AutoChessModel.instance:getSceneMo().fight.mySideMaster
		end
	elseif self.viewType == AutoChessEnum.ViewType.Enemy then
		local xDis = math.abs(pos.x - location2.x)
		local yDis = math.abs(pos.y - location2.y)

		if xDis < 55 and yDis < 145 then
			return AutoChessModel.instance:getSceneMo().fight.enemyMaster
		end
	elseif self.viewType == AutoChessEnum.ViewType.All then
		local xDis = math.abs(pos.x - location1.x)
		local yDis = math.abs(pos.y - location1.y)

		if xDis < 65 and yDis < 135 then
			return AutoChessModel.instance:getSceneMo().lastFight.mySideMaster
		end

		xDis = math.abs(pos.x - location2.x)
		yDis = math.abs(pos.y - location2.y)

		if xDis < 65 and yDis < 135 then
			return AutoChessModel.instance:getSceneMo().lastFight.enemyMaster
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
