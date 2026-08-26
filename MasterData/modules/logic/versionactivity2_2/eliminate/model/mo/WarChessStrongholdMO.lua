-- chunkname: @modules/logic/versionactivity2_2/eliminate/model/mo/WarChessStrongholdMO.lua

module("modules.logic.versionactivity2_2.eliminate.model.mo.WarChessStrongholdMO", package.seeall)

local WarChessStrongholdMO = class("WarChessStrongholdMO")

function WarChessStrongholdMO:init(data)
	self.id = data.id
	self.mySidePiece = {}
	self.enemySidePiece = {}

	self:updateInfo(data)
end

function WarChessStrongholdMO:updateInfo(data)
	self.myScore = data.myScore or 0
	self.enemyScore = data.enemyScore or 0
	self.status = data.status

	if data.mySidePiece then
		self.mySidePiece = GameUtil.rpcInfosToList(data.mySidePiece, WarChessPieceMO)
	end

	if data.enemySidePiece then
		self.enemySidePiece = GameUtil.rpcInfosToList(data.enemySidePiece, WarChessPieceMO)
	end
end

function WarChessStrongholdMO:updatePiece(teamType, pieceInfo)
	if teamType == EliminateTeamChessEnum.TeamChessTeamType.enemy then
		local piece = WarChessPieceMO.New()

		piece:init(pieceInfo)
		table.insert(self.enemySidePiece, piece)

		return #self.enemySidePiece
	end

	if teamType == EliminateTeamChessEnum.TeamChessTeamType.player then
		local piece = WarChessPieceMO.New()

		piece:init(pieceInfo)
		table.insert(self.mySidePiece, piece)

		return #self.mySidePiece
	end
end

function WarChessStrongholdMO:addTempPiece(teamType, soliderId)
	local config = EliminateConfig.instance:getSoldierChessConfig(soliderId)
	local piece = WarChessPieceMO.New()

	piece.id = soliderId
	piece.teamType = teamType
	piece.battle = config.defaultPower
	piece.uid = EliminateTeamChessEnum.tempPieceUid

	if teamType == EliminateTeamChessEnum.TeamChessTeamType.enemy then
		table.insert(self.enemySidePiece, piece)

		return piece, #self.enemySidePiece
	end

	if teamType == EliminateTeamChessEnum.TeamChessTeamType.player then
		table.insert(self.mySidePiece, piece)

		return piece, #self.mySidePiece
	end
end

function WarChessStrongholdMO:updateChessPower(uid, diffValue)
	if self.mySidePiece then
		for i = 1, #self.mySidePiece do
			local piece = self.mySidePiece[i]

			if piece.uid == uid then
				piece:updatePower(diffValue)

				return true
			end
		end
	end

	if self.enemySidePiece then
		for i = 1, #self.enemySidePiece do
			local piece = self.enemySidePiece[i]

			if piece.uid == uid then
				piece:updatePower(diffValue)

				return true
			end
		end
	end

	return false
end

function WarChessStrongholdMO:updateSkillGrowUp(uid, skillId, upValue)
	if self.mySidePiece then
		for i = 1, #self.mySidePiece do
			local piece = self.mySidePiece[i]

			if piece.uid == uid and piece:updateSkillGrowUp(skillId, upValue) then
				return true
			end
		end
	end

	if self.enemySidePiece then
		for i = 1, #self.enemySidePiece do
			local piece = self.enemySidePiece[i]

			if piece.uid == uid and piece:updateSkillGrowUp(skillId, upValue) then
				return true
			end
		end
	end

	return false
end

function WarChessStrongholdMO:updateDisplacementState(uid, displacementState)
	if self.mySidePiece then
		for i = 1, #self.mySidePiece do
			local piece = self.mySidePiece[i]

			if piece.uid == uid then
				piece:updateDisplacementState(displacementState)

				return true
			end
		end
	end

	if self.enemySidePiece then
		for i = 1, #self.enemySidePiece do
			local piece = self.enemySidePiece[i]

			if piece.uid == uid then
				piece:updateDisplacementState(displacementState)

				return true
			end
		end
	end

	return false
end

function WarChessStrongholdMO:updateScore(teamType, diffValue)
	if teamType == EliminateTeamChessEnum.TeamChessTeamType.player then
		self.myScore = math.max(self.myScore + diffValue, 0)
	end

	if teamType == EliminateTeamChessEnum.TeamChessTeamType.enemy then
		self.enemyScore = math.max(self.enemyScore + diffValue, 0)
	end
end

function WarChessStrongholdMO:updateStatus(state)
	self.status = state
end

function WarChessStrongholdMO:getChess(uid)
	for i = 1, #self.mySidePiece do
		local piece = self.mySidePiece[i]

		if piece.uid == uid then
			return piece
		end
	end

	for i = 1, #self.enemySidePiece do
		local piece = self.enemySidePiece[i]

		if piece.uid == uid then
			return piece
		end
	end

	return nil
end

function WarChessStrongholdMO:removeChess(uid)
	for i = 1, #self.mySidePiece do
		local piece = self.mySidePiece[i]

		if piece.uid == uid then
			table.remove(self.mySidePiece, i)

			return
		end
	end

	for i = 1, #self.enemySidePiece do
		local piece = self.enemySidePiece[i]

		if piece.uid == uid then
			table.remove(self.enemySidePiece, i)

			return
		end
	end
end

function WarChessStrongholdMO:getPlayerSoliderCount()
	return (self.mySidePiece or nil) and (#self.mySidePiece or 0)
end

function WarChessStrongholdMO:getEnemySoliderCount()
	return (self.enemySidePiece or nil) and (#self.enemySidePiece or 0)
end

function WarChessStrongholdMO:isFull(teamType)
	local config = self:getStrongholdConfig()

	if teamType == EliminateTeamChessEnum.TeamChessTeamType.player then
		return config.friendCapacity == #self.mySidePiece
	end

	if teamType == EliminateTeamChessEnum.TeamChessTeamType.enemy then
		return config.enemyCapacity == #self.enemySidePiece
	end
end

function WarChessStrongholdMO:diffData(data)
	local isSame = self.id == data.id

	if self.myScore ~= data.myScore then
		isSame = false
	end

	if self.enemyScore ~= data.enemyScore then
		isSame = false
	end

	if self.status ~= data.status then
		isSame = false
	end

	if self.mySidePiece and data.mySidePiece then
		for i = 1, #self.mySidePiece do
			local piece = self.mySidePiece[i]

			if not piece:diffData(data.mySidePiece[i]) then
				isSame = false
			end
		end
	end

	if self.enemySidePiece and data.enemySidePiece then
		for i = 1, #self.enemySidePiece do
			local piece = self.enemySidePiece[i]

			if not piece:diffData(data.enemySidePiece[i]) then
				isSame = false
			end
		end
	end

	return isSame
end

function WarChessStrongholdMO:getStrongholdConfig()
	if self.config == nil then
		self.config = EliminateConfig.instance:getStrongHoldConfig(self.id)
	end

	return self.config
end

function WarChessStrongholdMO:getMySideIndexByUid(uid)
	if self.mySidePiece then
		for i = 1, #self.mySidePiece do
			local piece = self.mySidePiece[i]

			if piece.uid == uid then
				return i
			end
		end
	end

	return -1
end

function WarChessStrongholdMO:getEnemySideIndexByUid(uid)
	if self.enemySidePiece then
		for i = 1, #self.enemySidePiece do
			local piece = self.enemySidePiece[i]

			if piece.uid == uid then
				return i
			end
		end
	end

	return -1
end

function WarChessStrongholdMO:getEnemySideByUid(uid)
	if self.enemySidePiece then
		for i = 1, #self.enemySidePiece do
			local piece = self.enemySidePiece[i]

			if piece.uid == uid then
				return piece
			end
		end
	end

	return nil
end

function WarChessStrongholdMO:getMySideByUid(uid)
	if self.mySidePiece then
		for i = 1, #self.mySidePiece do
			local piece = self.mySidePiece[i]

			if piece.uid == uid then
				return piece
			end
		end
	end

	return nil
end

return WarChessStrongholdMO
