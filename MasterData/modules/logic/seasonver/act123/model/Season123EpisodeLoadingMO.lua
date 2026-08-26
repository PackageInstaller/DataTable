-- chunkname: @modules/logic/seasonver/act123/model/Season123EpisodeLoadingMO.lua

module("modules.logic.seasonver.act123.model.Season123EpisodeLoadingMO", package.seeall)

local Season123EpisodeLoadingMO = pureTable("Season123EpisodeLoadingMO")

function Season123EpisodeLoadingMO:init(id, episodeMO, episodeCfg, emptyIndex)
	self.id = id
	self.cfg = episodeCfg
	self.emptyIndex = emptyIndex

	if episodeMO then
		self.isFinished = episodeMO:isFinished()
		self.round = episodeMO.round
	else
		self.isFinished = false
		self.round = 0
	end
end

return Season123EpisodeLoadingMO
