-- chunkname: @modules/logic/versionactivity2_2/eliminate/model/mo/TeamChessUnitMO.lua

module("modules.logic.versionactivity2_2.eliminate.model.mo.TeamChessUnitMO", package.seeall)

local TeamChessUnitMO = class("TeamChessUnitMO")

function TeamChessUnitMO:init(uid, id, stronghold, pos, teamType)
	self.uid = uid or 0
	self.soldierId = id or 0
	self.stronghold = stronghold or 0
	self.pos = pos or 0
	self.teamType = teamType or 0
end

function TeamChessUnitMO:update(uid, id, stronghold, pos, teamType)
	self.uid = uid
	self.soldierId = id
	self.stronghold = stronghold
	self.pos = pos
	self.teamType = teamType
end

function TeamChessUnitMO:getUid()
	return self.uid
end

function TeamChessUnitMO:getSoldierConfig()
	return EliminateConfig.instance:getSoldierChessConfig(self.soldierId)
end

function TeamChessUnitMO:getUnitPath()
	return EliminateConfig.instance:getSoldierChessModelPath(self.soldierId)
end

function TeamChessUnitMO:getScale()
	return self:getSoldierConfig().resZoom
end

function TeamChessUnitMO:getOrder()
	local index = 0
	local stronghold = EliminateTeamChessModel.instance:getStronghold(self.stronghold)

	if self.teamType == EliminateTeamChessEnum.TeamChessTeamType.enemy then
		local config = EliminateConfig.instance:getStrongHoldConfig(self.stronghold)

		index = config.enemyCapacity - stronghold:getEnemySideIndexByUid(self.uid)
	end

	return (self.teamType == EliminateTeamChessEnum.TeamChessTeamType.player or nil) and stronghold:getMySideIndexByUid(self.uid)
end

function TeamChessUnitMO:canActiveMove()
	local chess = EliminateTeamChessModel.instance:getChess(self.uid)

	return chess and chess:canActiveMove() or false
end

function TeamChessUnitMO:clear()
	self.uid = 0
	self.soldierId = 0
	self.stronghold = 0
	self.pos = 0
	self.teamType = 0
end

return TeamChessUnitMO
