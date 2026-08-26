-- chunkname: @modules/logic/versionactivity3_5/lorentz/model/LorentzEpisodeMo.lua

module("modules.logic.versionactivity3_5.lorentz.model.LorentzEpisodeMo", package.seeall)

local LorentzEpisodeMo = class("LorentzEpisodeMo")

function LorentzEpisodeMo:ctor()
	self.episodeId = 0
	self.isFinished = false
	self.unlockBranchIds = nil
	self.progress = ""
end

function LorentzEpisodeMo:init(info)
	self.episodeId = info.episodeId
	self.isFinished = info.isFinished
	self.unlockBranchIds = info.unlockBranchIds
	self.progress = info.progress
	self._actId = VersionActivity3_5Enum.ActivityId.Lorentz
end

function LorentzEpisodeMo:update(info)
	self.episodeId = info.episodeId
	self.isFinished = info.isFinished
	self.status = info.status
	self.progress = info.progress
end

function LorentzEpisodeMo:checkFinishGame()
	return self.progress and self.progress == "1"
end

function LorentzEpisodeMo:isGame()
	local config = LorentzConfig.instance:getEpisodeCo(self._actId, self.episodeId)

	return config and config.gameId ~= 0
end

return LorentzEpisodeMo
