-- chunkname: @modules/logic/versionactivity3_2/beilier/model/BeiLiErEpisodeMo.lua

module("modules.logic.versionactivity3_2.beilier.model.BeiLiErEpisodeMo", package.seeall)

local BeiLiErEpisodeMo = class("BeiLiErEpisodeMo")

function BeiLiErEpisodeMo:ctor()
	self.episodeId = 0
	self.isFinished = false
	self.unlockBranchIds = nil
	self.progress = ""
end

function BeiLiErEpisodeMo:init(info)
	self.episodeId = info.episodeId
	self.isFinished = info.isFinished
	self.unlockBranchIds = info.unlockBranchIds
	self.progress = info.progress
	self._actId = VersionActivity3_2Enum.ActivityId.BeiLiEr
end

function BeiLiErEpisodeMo:update(info)
	self.episodeId = info.episodeId
	self.isFinished = info.isFinished
	self.status = info.status
	self.progress = info.progress
end

function BeiLiErEpisodeMo:checkFinishGame()
	return self.progress and self.progress == "1"
end

function BeiLiErEpisodeMo:isGame()
	local config = BeiLiErConfig.instance:getEpisodeCo(self._actId, self.episodeId)

	return config and config.gameId ~= 0
end

return BeiLiErEpisodeMo
