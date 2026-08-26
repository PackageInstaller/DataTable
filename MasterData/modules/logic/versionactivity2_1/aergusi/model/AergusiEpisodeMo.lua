-- chunkname: @modules/logic/versionactivity2_1/aergusi/model/AergusiEpisodeMo.lua

module("modules.logic.versionactivity2_1.aergusi.model.AergusiEpisodeMo", package.seeall)

local AergusiEpisodeMo = class("AergusiEpisodeMo")

function AergusiEpisodeMo:ctor()
	self.episodeId = 0
	self.passBeforeStory = false
	self.passEvidence = false
	self.passAfterStory = false
	self.episodeState = AergusiEnum.ProgressState.BeforeStory
end

function AergusiEpisodeMo:init(info)
	self.episodeId = info.episodeId
	self.passBeforeStory = info.passBeforeStory
	self.passEvidence = info.passEvidence
	self.passAfterStory = info.passAfterStory

	if self.passAfterStory then
		self.episodeState = AergusiEnum.ProgressState.Finished
	elseif self.passEvidence then
		self.episodeState = AergusiEnum.ProgressState.AfterStory
	elseif self.passBeforeStory then
		local episodeCo = AergusiConfig.instance:getEpisodeConfig(nil, self.episodeId)

		if episodeCo.evidenceId ~= "" then
			self.episodeState = AergusiEnum.ProgressState.Evidence or AergusiEnum.ProgressState.AfterStory
		end
	end
end

return AergusiEpisodeMo
