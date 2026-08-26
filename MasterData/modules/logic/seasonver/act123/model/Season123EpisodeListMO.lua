-- chunkname: @modules/logic/seasonver/act123/model/Season123EpisodeListMO.lua

module("modules.logic.seasonver.act123.model.Season123EpisodeListMO", package.seeall)

local Season123EpisodeListMO = pureTable("Season123EpisodeListMO")

function Season123EpisodeListMO:init(episodeMO, episodeCfg)
	self.id = episodeCfg.layer
	self.cfg = episodeCfg
	self.star = 0

	if episodeMO then
		self.isFinished = episodeMO:isFinished()
		self.round = episodeMO.round
		self.star = episodeMO.star
	else
		self.isFinished = false
		self.round = 0
	end
end

return Season123EpisodeListMO
