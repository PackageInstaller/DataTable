-- chunkname: @modules/logic/versionactivity2_4/music/model/Act179EpisodeMO.lua

module("modules.logic.versionactivity2_4.music.model.Act179EpisodeMO", package.seeall)

local Act179EpisodeMO = pureTable("Act179EpisodeMO")

function Act179EpisodeMO:init(info)
	self.episodeId = info.episodeId
	self.isFinished = info.isFinished
	self.highScore = info.highScore
	self.config = Activity179Config.instance:getEpisodeConfig(self.episodeId)
end

return Act179EpisodeMO
