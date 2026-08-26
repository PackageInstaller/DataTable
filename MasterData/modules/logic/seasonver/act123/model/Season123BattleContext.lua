-- chunkname: @modules/logic/seasonver/act123/model/Season123BattleContext.lua

module("modules.logic.seasonver.act123.model.Season123BattleContext", package.seeall)

local Season123BattleContext = pureTable("Season123BattleContext")

function Season123BattleContext:init(actId, stage, layer, episodeId)
	self.actId = actId
	self.stage = stage
	self.layer = layer
	self.episodeId = episodeId
end

return Season123BattleContext
