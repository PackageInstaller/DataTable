-- chunkname: @modules/logic/autochess/main/model/rpcmo/AutoChessFightMo.lua

module("modules.logic.autochess.main.model.rpcmo.AutoChessFightMo", package.seeall)

local AutoChessFightMo = pureTable("AutoChessFightMo")

function AutoChessFightMo:init(data)
	self.round = data.round
	self.warZones = GameUtil.rpcInfosToList(data.warZones, AutoChessWarZoneMo)
	self.mySideMaster = GameUtil.rpcInfoToMo(data.mySideMaster, AutoChessMasterMo)
	self.enemyMaster = GameUtil.rpcInfoToMo(data.enemyMaster, AutoChessMasterMo)
	self.unwarZones = GameUtil.rpcInfosToList(data.unwarZones, AutoChessWarZoneMo)
	self.roundType = data.roundType
end

function AutoChessFightMo:updateMasterSkill(skill)
	self.mySideMaster:updateMasterSkill(skill)
	AutoChessController.instance:dispatchEvent(AutoChessEvent.UpdateMasterSkill)
end

function AutoChessFightMo:unlockMasterSkill(uid)
	uid = tonumber(uid)

	if self.mySideMaster.uid == uid then
		self.mySideMaster.skill.unlock = true
	elseif self.enemyMaster.uid == uid then
		self.enemyMaster.skill.unlock = true
	end

	AutoChessController.instance:dispatchEvent(AutoChessEvent.UpdateMasterSkill)
end

function AutoChessFightMo:updateMaster(master)
	self.mySideMaster = GameUtil.rpcInfoToMo(master, AutoChessMasterMo)

	AutoChessController.instance:dispatchEvent(AutoChessEvent.UpdateMasterSkill)
end

function AutoChessFightMo:hasUpgradeableChess(chessId)
	for _, warZone in ipairs(self.warZones) do
		for _, chessPos in ipairs(warZone.positions) do
			if chessPos.index < AutoChessEnum.BoardSize.Column and chessPos.chess.id == chessId and chessPos.chess.maxExpLimit ~= 0 then
				return true
			end
		end
	end

	return false
end

function AutoChessFightMo:getChessPosition(x, y)
	x = tonumber(x)
	y = tonumber(y)

	if x == AutoChessEnum.WarZone.Four then
		for _, warZone in ipairs(self.unwarZones) do
			if warZone.id == x then
				for _, position in ipairs(warZone.positions) do
					if position.index == y - 1 then
						return position
					end
				end
			end
		end
	else
		for _, warZone in ipairs(self.warZones) do
			if warZone.id == x then
				for _, position in ipairs(warZone.positions) do
					if position.index == y - 1 then
						return position
					end
				end
			end
		end
	end

	logError(string.format("异常:不存在战区%s站位%s的ChessPos数据", x, y))
end

function AutoChessFightMo:getChessPosition1(uid)
	uid = tonumber(uid)

	for _, warZone in ipairs(self.warZones) do
		for _, chessPos in ipairs(warZone.positions) do
			if chessPos.chess.uid == uid then
				return chessPos, warZone.id
			end
		end
	end

	local unWarzone = self:getUnwarZone()

	if unWarzone then
		for _, chessPos in ipairs(unWarzone.positions) do
			if chessPos.chess.uid == uid then
				return chessPos, unWarzone.id
			end
		end
	end

	logError(string.format("异常:不存在包含棋子%s的ChessPos数据", uid))
end

function AutoChessFightMo:getEmptyPos(chessType)
	if chessType == AutoChessStrEnum.ChessType.Incubate then
		local unWarzone = self.unwarZones[1]

		for _, chessPos in ipairs(unWarzone.positions) do
			if chessPos.teamType == AutoChessEnum.TeamType.Player and tonumber(chessPos.chess.uid) == 0 then
				return unWarzone.id, chessPos.index + 1
			end
		end
	else
		for _, warZone in ipairs(self.warZones) do
			if chessType == AutoChessEnum.WarZoneType[warZone.type] then
				for _, chessPos in ipairs(warZone.positions) do
					if chessPos.teamType == AutoChessEnum.TeamType.Player and tonumber(chessPos.chess.uid) == 0 then
						return warZone.id, chessPos.index + 1
					end
				end
			end
		end
	end
end

function AutoChessFightMo:getUnwarZone()
	return self.unwarZones[1]
end

return AutoChessFightMo
