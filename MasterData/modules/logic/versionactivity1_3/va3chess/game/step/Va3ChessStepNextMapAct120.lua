-- chunkname: @modules/logic/versionactivity1_3/va3chess/game/step/Va3ChessStepNextMapAct120.lua

module("modules.logic.versionactivity1_3.va3chess.game.step.Va3ChessStepNextMapAct120", package.seeall)

local Va3ChessStepNextMapAct120 = class("Va3ChessStepNextMapAct120", Va3ChessStepBase)

function Va3ChessStepNextMapAct120:start()
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.GameLoadingMapStateUpdate, Va3ChessEvent.LoadingMapState.Start)
	TaskDispatcher.cancelTask(self._onProcessNextMapStatus, self)
	TaskDispatcher.runDelay(self._onProcessNextMapStatus, self, 0.5)
end

function Va3ChessStepNextMapAct120:_onProcessNextMapStatus()
	local actId = Va3ChessModel.instance:getActId()
	local episodeId = Va3ChessModel.instance:getEpisodeId()
	local episodeCfg = Va3ChessConfig.instance:getEpisodeCo(actId, episodeId)
	local mapId = Va3ChessModel.instance:getMapId()

	if episodeCfg and episodeCfg.mapIds then
		local mapIds = string.split(episodeCfg.mapIds, "#")

		mapId = tonumber(mapIds[2])
	end

	self.originData.id = episodeId

	local dataStr = cjson.encode(self.originData)
	local mapData = cjson.decode(dataStr)

	for k, v in ipairs(mapData.interactObjects) do
		if type(v.data) == "table" then
			v.data = cjson.encode(v.data)
		end
	end

	mapData.finishInteracts = mapData.finishInteracts or Va3ChessGameModel.instance:findInteractFinishIds()
	mapData.allFinishInteracts = mapData.allFinishInteracts or Va3ChessGameModel.instance:findInteractFinishIds(true)
	mapData.currentRound = mapData.currentRound or Va3ChessGameModel.instance:getRound()

	Va3ChessGameController.instance:initServerMap(actId, mapData)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.GameMapDataUpdate)
	Va3ChessGameController.instance:enterChessGame(actId, mapId)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.EnterNextMap)
end

function Va3ChessStepNextMapAct120:finish()
	TaskDispatcher.cancelTask(self._onProcessNextMapStatus, self)
	Va3ChessStepNextMapAct120.super.finish(self)
end

function Va3ChessStepNextMapAct120:dispose()
	TaskDispatcher.cancelTask(self._onProcessNextMapStatus, self)
	Va3ChessStepNextMapAct120.super.dispose(self)
end

return Va3ChessStepNextMapAct120
