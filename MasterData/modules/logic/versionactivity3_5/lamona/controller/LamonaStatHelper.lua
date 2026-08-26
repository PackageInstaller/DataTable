-- chunkname: @modules/logic/versionactivity3_5/lamona/controller/LamonaStatHelper.lua

module("modules.logic.versionactivity3_5.lamona.controller.LamonaStatHelper", package.seeall)

local LamonaStatHelper = class("LamonaStatHelper")

LamonaStatHelper.OperationType = {
	gameReset = "主动重置",
	gameSuccess = "成功通关退出",
	failExit = "失败后退出",
	gameExit = "主动退出"
}

function LamonaStatHelper:ctor()
	self.gameStartTime = nil
end

function LamonaStatHelper:initGameStartTime()
	self.gameStartTime = UnityEngine.Time.realtimeSinceStartup
end

function LamonaStatHelper:sendOperationInfo(operation)
	local gameEpisodeId = LamonaGameModel.instance:getGameEpisodeId()
	local gameId = LamonaGameModel.instance:getGameId()

	if not gameEpisodeId or not gameId or not self.gameStartTime then
		return
	end

	local mapId = LamonaGameModel.instance:getMapId()
	local round = LamonaGameModel.instance:getRound()
	local useTime = UnityEngine.Time.realtimeSinceStartup - self.gameStartTime

	StatController.instance:track(StatEnum.EventName.LamonaGame, {
		[StatEnum.EventProperties.EpisodeId] = tostring(gameEpisodeId),
		[StatEnum.EventProperties.GameId] = tostring(gameId),
		[StatEnum.EventProperties.MapId] = tostring(mapId),
		[StatEnum.EventProperties.RoundNum] = round,
		[StatEnum.EventProperties.OperationType] = operation,
		[StatEnum.EventProperties.UseTime] = useTime
	})

	self.gameStartTime = nil
end

LamonaStatHelper.instance = LamonaStatHelper.New()

return LamonaStatHelper
