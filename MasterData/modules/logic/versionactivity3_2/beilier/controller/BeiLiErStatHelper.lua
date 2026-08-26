-- chunkname: @modules/logic/versionactivity3_2/beilier/controller/BeiLiErStatHelper.lua

module("modules.logic.versionactivity3_2.beilier.controller.BeiLiErStatHelper", package.seeall)

local BeiLiErStatHelper = class("BeiLiErStatHelper")

function BeiLiErStatHelper:ctor()
	self.episodeId = "0"
end

function BeiLiErStatHelper:enterGame()
	self.gameStartTime = UnityEngine.Time.realtimeSinceStartup
end

function BeiLiErStatHelper:sendGameFinish()
	StatController.instance:track(StatEnum.EventName.BeiLiErGame, {
		[StatEnum.EventProperties.MapId] = tostring(BeiLiErGameModel.instance:getCurrentLevelId()),
		[StatEnum.EventProperties.OperationType] = "finish",
		[StatEnum.EventProperties.UseTime] = UnityEngine.Time.realtimeSinceStartup - self.gameStartTime,
		[StatEnum.EventProperties.PuzzleList] = BeiLiErGameModel.instance:getCorrectPuzzleList()
	})
end

function BeiLiErStatHelper:sendGameAbort()
	StatController.instance:track(StatEnum.EventName.BeiLiErGame, {
		[StatEnum.EventProperties.MapId] = tostring(BeiLiErGameModel.instance:getCurrentLevelId()),
		[StatEnum.EventProperties.OperationType] = "exit",
		[StatEnum.EventProperties.UseTime] = UnityEngine.Time.realtimeSinceStartup - self.gameStartTime,
		[StatEnum.EventProperties.PuzzleList] = BeiLiErGameModel.instance:getCorrectPuzzleList()
	})
end

function BeiLiErStatHelper:sendGameReset()
	StatController.instance:track(StatEnum.EventName.BeiLiErGame, {
		[StatEnum.EventProperties.MapId] = tostring(BeiLiErGameModel.instance:getCurrentLevelId()),
		[StatEnum.EventProperties.OperationType] = "reset",
		[StatEnum.EventProperties.UseTime] = UnityEngine.Time.realtimeSinceStartup - self.gameStartTime,
		[StatEnum.EventProperties.PuzzleList] = BeiLiErGameModel.instance:getCorrectPuzzleList()
	})
	self:enterGame()
end

function BeiLiErStatHelper:sendGameTip()
	StatController.instance:track(StatEnum.EventName.BeiLiErGame, {
		[StatEnum.EventProperties.MapId] = tostring(BeiLiErGameModel.instance:getCurrentLevelId()),
		[StatEnum.EventProperties.OperationType] = "tip",
		[StatEnum.EventProperties.UseTime] = UnityEngine.Time.realtimeSinceStartup - self.gameStartTime,
		[StatEnum.EventProperties.PuzzleList] = BeiLiErGameModel.instance:getCorrectPuzzleList()
	})
end

BeiLiErStatHelper.instance = BeiLiErStatHelper.New()

return BeiLiErStatHelper
