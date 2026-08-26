-- chunkname: @modules/logic/versionactivity3_3/marsha/model/MarshaEpisodeMo.lua

module("modules.logic.versionactivity3_3.marsha.model.MarshaEpisodeMo", package.seeall)

local MarshaEpisodeMo = class("MarshaEpisodeMo")

function MarshaEpisodeMo:ctor()
	self.episodeId = 0
	self.isFinished = false
	self.unlockBranchIds = nil
	self.progress = ""
end

function MarshaEpisodeMo:init(info)
	self.episodeId = info.episodeId
	self.isFinished = info.isFinished
	self.unlockBranchIds = info.unlockBranchIds
	self.progress = info.progress

	local actId = MarshaModel.instance:getCurActId()

	self.config = Activity220Config.instance:getEpisodeConfig(actId, self.episodeId)
end

function MarshaEpisodeMo:update(info)
	self.episodeId = info.episodeId
	self.isFinished = info.isFinished
	self.status = info.status
	self.progress = info.progress
end

function MarshaEpisodeMo:checkFinishGame()
	return self.progress and self.progress == "1"
end

function MarshaEpisodeMo:isGame()
	return self.config.gameId ~= 0
end

return MarshaEpisodeMo
