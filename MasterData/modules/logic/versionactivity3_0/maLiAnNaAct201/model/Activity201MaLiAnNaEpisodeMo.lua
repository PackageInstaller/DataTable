-- chunkname: @modules/logic/versionactivity3_0/maLiAnNaAct201/model/Activity201MaLiAnNaEpisodeMo.lua

module("modules.logic.versionactivity3_0.maLiAnNaAct201.model.Activity201MaLiAnNaEpisodeMo", package.seeall)

local Activity201MaLiAnNaEpisodeMo = class("Activity201MaLiAnNaEpisodeMo")

function Activity201MaLiAnNaEpisodeMo:ctor()
	self.episodeId = 0
	self.isFinished = false
	self.unlockBranchIds = nil
	self.progress = ""
end

function Activity201MaLiAnNaEpisodeMo:init(info)
	self.episodeId = info.episodeId
	self.isFinished = info.isFinished
	self.unlockBranchIds = info.unlockBranchIds
	self.progress = info.progress
	self._actId = VersionActivity3_0Enum.ActivityId.MaLiAnNa
end

function Activity201MaLiAnNaEpisodeMo:update(info)
	self.episodeId = info.episodeId
	self.isFinished = info.isFinished
	self.status = info.status
	self.progress = info.progress
end

function Activity201MaLiAnNaEpisodeMo:checkFinishGame()
	return self.progress and self.progress == "1"
end

function Activity201MaLiAnNaEpisodeMo:isGame()
	local config = Activity201MaLiAnNaConfig.instance:getEpisodeCo(self._actId, self.episodeId)

	return config and config.gameId ~= 0
end

return Activity201MaLiAnNaEpisodeMo
