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
	self.selectMasterId = info.selectMasterId
	self.refreshed = info.refreshed
	self.bossId = info.bossId
	self.cardpackId = info.cardpackId
end

function AutoChessGameMO:updateMasterIdBox(masterIds, refresh)
	self.masterIdBox = masterIds
	self.refreshed = refresh
end

function AutoChessGameMO:updateBossId(id)
	self.start = true
	self.bossId = id
end

function AutoChessGameMO:updateCardPackId(id)
	self.cardpackId = id
end

return AutoChessGameMO
