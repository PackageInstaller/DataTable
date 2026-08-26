-- chunkname: @modules/logic/versionactivity3_5/lorentz/controller/LorentzStatHelper.lua

module("modules.logic.versionactivity3_5.lorentz.controller.LorentzStatHelper", package.seeall)

local LorentzStatHelper = class("LorentzStatHelper")

function LorentzStatHelper:ctor()
	self.episodeId = "0"
end

function LorentzStatHelper:enterGame()
	self.gameStartTime = UnityEngine.Time.realtimeSinceStartup
end

function LorentzStatHelper:sendGameFinish()
	StatController.instance:track(StatEnum.EventName.LorentzGame, {
		[StatEnum.EventProperties.MapId] = tostring(LorentzGameModel.instance:getCurrentLevelId()),
		[StatEnum.EventProperties.OperationType] = "finish",
		[StatEnum.EventProperties.UseTime] = UnityEngine.Time.realtimeSinceStartup - self.gameStartTime,
		[StatEnum.EventProperties.PuzzleList] = LorentzGameModel.instance:getCorrectPuzzleList()
	})
end

function LorentzStatHelper:sendGameAbort()
	StatController.instance:track(StatEnum.EventName.LorentzGame, {
		[StatEnum.EventProperties.MapId] = tostring(LorentzGameModel.instance:getCurrentLevelId()),
		[StatEnum.EventProperties.OperationType] = "exit",
		[StatEnum.EventProperties.UseTime] = UnityEngine.Time.realtimeSinceStartup - self.gameStartTime,
		[StatEnum.EventProperties.PuzzleList] = LorentzGameModel.instance:getCorrectPuzzleList()
	})
end

function LorentzStatHelper:sendGameReset()
	StatController.instance:track(StatEnum.EventName.LorentzGame, {
		[StatEnum.EventProperties.MapId] = tostring(LorentzGameModel.instance:getCurrentLevelId()),
		[StatEnum.EventProperties.OperationType] = "reset",
		[StatEnum.EventProperties.UseTime] = UnityEngine.Time.realtimeSinceStartup - self.gameStartTime,
		[StatEnum.EventProperties.PuzzleList] = LorentzGameModel.instance:getCorrectPuzzleList()
	})
	self:enterGame()
end

function LorentzStatHelper:sendGameTip()
	StatController.instance:track(StatEnum.EventName.LorentzGame, {
		[StatEnum.EventProperties.MapId] = tostring(LorentzGameModel.instance:getCurrentLevelId()),
		[StatEnum.EventProperties.OperationType] = "tip",
		[StatEnum.EventProperties.UseTime] = UnityEngine.Time.realtimeSinceStartup - self.gameStartTime,
		[StatEnum.EventProperties.PuzzleList] = LorentzGameModel.instance:getCorrectPuzzleList()
	})
end

LorentzStatHelper.instance = LorentzStatHelper.New()

return LorentzStatHelper
