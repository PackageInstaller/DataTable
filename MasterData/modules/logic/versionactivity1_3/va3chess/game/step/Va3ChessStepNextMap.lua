-- chunkname: @modules/logic/versionactivity1_3/va3chess/game/step/Va3ChessStepNextMap.lua

module("modules.logic.versionactivity1_3.va3chess.game.step.Va3ChessStepNextMap", package.seeall)

local Va3ChessStepNextMap = class("Va3ChessStepNextMap", Va3ChessStepBase)

function Va3ChessStepNextMap:start()
	self:processNextMapStatus()
end

function Va3ChessStepNextMap:processNextMapStatus()
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.BeforeEnterNextMap)
	TaskDispatcher.runDelay(self.beginEnterNextMap, self, 0.5)
end

function Va3ChessStepNextMap:beginEnterNextMap()
	local actId = Va3ChessModel.instance:getActId()
	local episodeId = Va3ChessModel.instance:getEpisodeId()
	local episodeCfg = Va3ChessConfig.instance:getEpisodeCo(actId, episodeId)
	local mapId = Va3ChessModel.instance:getMapId()

	if episodeCfg and episodeCfg.mapIds then
		local mapIds = string.split(episodeCfg.mapIds, "#")

		mapId = tonumber(mapIds[2])
	end

	Va3ChessGameModel.instance:recordLastMapRound()
	Va3ChessController.instance:initMapData(actId, self.originData.act122Map)
	Va3ChessGameController.instance:enterChessGame(actId, mapId, ViewName.Activity1_3ChessGameView)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.EnterNextMap)
	self:finish()
end

return Va3ChessStepNextMap
