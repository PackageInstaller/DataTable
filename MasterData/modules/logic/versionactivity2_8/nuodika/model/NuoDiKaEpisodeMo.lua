-- chunkname: @modules/logic/versionactivity2_8/nuodika/model/NuoDiKaEpisodeMo.lua

module("modules.logic.versionactivity2_8.nuodika.model.NuoDiKaEpisodeMo", package.seeall)

local NuoDiKaEpisodeMo = class("NuoDiKaEpisodeMo")

function NuoDiKaEpisodeMo:ctor()
	self.episodeId = 0
	self.isFinished = false
	self.status = NuoDiKaEnum.EpisodeStatus.BeforeStory
	self.gameString = ""
end

function NuoDiKaEpisodeMo:init(info)
	self.episodeId = info.episodeId
	self.isFinished = info.isFinished
	self.status = info.status
	self.gameString = info.gameString
end

function NuoDiKaEpisodeMo:update(info)
	self.episodeId = info.episodeId
	self.isFinished = info.isFinished
	self.status = info.status
	self.gameString = info.gameString
end

function NuoDiKaEpisodeMo:updateGameString(str)
	self.gameString = str
end

return NuoDiKaEpisodeMo
