-- chunkname: @modules/logic/chessgame/game/step/ChessStepCurrMapRefresh.lua

module("modules.logic.chessgame.game.step.ChessStepCurrMapRefresh", package.seeall)

local ChessStepCurrMapRefresh = class("ChessStepCurrMapRefresh", BaseWork)

function ChessStepCurrMapRefresh:init(stepData)
	self.originData = stepData
end

function ChessStepCurrMapRefresh:onStart()
	local actId = ChessModel.instance:getActId()
	local episodeId = self.originData.scene.episodeId
	local newMapIndex = self.originData.scene.currMapIndex
	local currentRound = self.originData.scene.currRound
	local interact = self.originData.scene.maps[newMapIndex + 1].interacts
	local win = self.originData.scene.win
	local dead = self.originData.scene.dead

	if newMapIndex + 1 ~= ChessGameModel.instance:getNowMapIndex() then
		local mapInfo = {
			episodeId = episodeId,
			currMapIndex = newMapIndex,
			currentRound = currentRound,
			completedCount = self.originData.scene.completedCount,
			interact = interact,
			win = win,
			dead = dead
		}

		ChessGameController.instance:registerCallback(ChessGameEvent.GameLoadingMapStateUpdate, self._onLoadFinish, self)
		ChessGameController.instance:initServerMap(actId, mapInfo)
		ChessGameController.instance:dispatchEvent(ChessGameEvent.GameLoadingMapStateUpdate, ChessGameEvent.LoadingMapState.Start)
		ChessGameController.instance:setLoadingScene(true)

		local newSceneUrl = ChessGameModel.instance:getNowMapResPath()

		ChessGameController.instance:dispatchEvent(ChessGameEvent.ChangeMap, newSceneUrl)
	end
end

function ChessStepCurrMapRefresh:_onLoadFinish(state)
	if state == ChessGameEvent.LoadingMapState.Finish then
		self:onDone(true)
		ChessGameController.instance:unregisterCallback(ChessGameEvent.GameLoadingMapStateUpdate, self._onLoadFinish, self)
	end
end

function ChessStepCurrMapRefresh:cleanWork()
	ChessGameController.instance:unregisterCallback(ChessGameEvent.GameLoadingMapStateUpdate, self._onLoadFinish, self)
end

return ChessStepCurrMapRefresh
