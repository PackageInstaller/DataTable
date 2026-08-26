-- chunkname: @modules/logic/autochess/main/model/AutoChessFightMO.lua

module("modules.logic.autochess.main.model.AutoChessFightMO", package.seeall)

local AutoChessFightMO = pureTable("AutoChessFightMO")

function AutoChessFightMO:init(data)
	self.round = data.round

	self:initWarZones(data.warZones)

	self.unwarZone = AutoChessFightMO.buildWarZone(data.unwarZones[1])
	self.mySideMaster = AutoChessFightMO.copyMaster(data.mySideMaster)
	self.enemyMaster = AutoChessFightMO.copyMaster(data.enemyMaster)
	self.roundType = data.roundType
end

function AutoChessFightMO:initWarZones(data)
	self.warZones = {}

	for _, warZone in ipairs(data) do
		table.insert(self.warZones, AutoChessFightMO.buildWarZone(warZone))
	end
end

function AutoChessFightMO.buildWarZone(warZone)
	if not warZone then
		return
	end

	local zoneTbl = {}

	zoneTbl.id = warZone.id
	zoneTbl.type = warZone.type
	zoneTbl.positions = {}

	for _, v in ipairs(warZone.positions) do
		local posTbl = {}

		posTbl.index = v.index
		posTbl.teamType = v.teamType
		posTbl.chess = AutoChessHelper.copyChess(v.chess)

		table.insert(zoneTbl.positions, posTbl)
	end

	return zoneTbl
end

function AutoChessFightMO.copyMaster(master)
	local masterTbl = {}

	masterTbl.id = master.id
	masterTbl.teamType = master.teamType
	masterTbl.hp = master.hp
	masterTbl.uid = master.uid
	masterTbl.skill = master.skill
	masterTbl.buffContainer = master.buffContainer
	masterTbl.collectionIds = master.collectionIds

	return masterTbl
end

function AutoChessFightMO:updateMasterSkill(skill)
	self.mySideMaster.skill = skill

	AutoChessController.instance:dispatchEvent(AutoChessEvent.UpdateMasterSkill)
end

function AutoChessFightMO:unlockMasterSkill(uid)
	if self.mySideMaster.uid == uid then
		self.mySideMaster.skill.unlock = true
	elseif self.enemyMaster.uid == uid then
		self.enemyMaster.skill.unlock = true
	end

	AutoChessController.instance:dispatchEvent(AutoChessEvent.UpdateMasterSkill)
end

function AutoChessFightMO:updateMaster(master)
	self.mySideMaster = AutoChessFightMO.copyMaster(master)

	AutoChessController.instance:dispatchEvent(AutoChessEvent.UpdateMasterSkill)
end

function AutoChessFightMO:hasUpgradeableChess(chessId)
	for _, warZone in ipairs(self.warZones) do
		for _, chessPos in ipairs(warZone.positions) do
			if chessPos.index < AutoChessEnum.BoardSize.Column and chessPos.chess.id == chessId and chessPos.chess.maxExpLimit ~= 0 then
				return true
			end
		end
	end

	return false
end

return AutoChessFightMO
