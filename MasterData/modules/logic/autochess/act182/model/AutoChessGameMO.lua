-- chunkname: @modules/logic/autochess/act182/model/AutoChessGameMO.lua

module("modules.logic.autochess.act182.model.AutoChessGameMO", package.seeall)

local AutoChessGameMO = pureTable("AutoChessGameMO")

function AutoChessGameMO:init(info)
	self.activityId = info.activityId
	self.module = info.module
	self.start = info.start
	self.currRound = info.currRound
	self.episodeId = info.episodeId
	self.masterIdBox = info.masterIdBox
	self.cardpackIds = info.cardpackIds
	self.selectMasterId = info.selectMasterId
	self.refreshed = info.refreshed
	self.bossId = info.bossId
	self.mutationId = info.mutationId
end

function AutoChessGameMO:updateMasterIdBox(msg, refresh)
	self.start = true
	self.masterIdBox = msg.masterIds
	self.cardpackIds = msg.cardpackIds
	self.refreshed = refresh
end

function AutoChessGameMO:updateBossId(id)
	self.start = true
	self.bossId = id
end

function AutoChessGameMO:updateCardPackId(id)
	return
end

function AutoChessGameMO:updateMutationId(id)
	self.mutationId = id
end

return AutoChessGameMO
