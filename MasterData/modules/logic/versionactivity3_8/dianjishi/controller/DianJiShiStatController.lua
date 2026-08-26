-- chunkname: @modules/logic/versionactivity3_8/dianjishi/controller/DianJiShiStatController.lua

module("modules.logic.versionactivity3_8.dianjishi.controller.DianJiShiStatController", package.seeall)

local DianJiShiStatController = class("DianJiShiStatController")

function DianJiShiStatController:enterGame(episodeId)
	self._gameStartTime = UnityEngine.Time.realtimeSinceStartup
	self._gameTipTimes = 0
	self._gameRevertTimes = 0
	self._episodeId = episodeId
end

function DianJiShiStatController:addHelpTimes()
	self._gameTipTimes = self._gameTipTimes + 1
end

function DianJiShiStatController:addRollBackTimes()
	self._gameRevertTimes = self._gameRevertTimes + 1
end

function DianJiShiStatController:sendGameAbort()
	self:_endGame("手动退出")
end

function DianJiShiStatController:sendGameSettle()
	self:_endGame("关卡结算")
end

function DianJiShiStatController:_endGame(operationType)
	local useTime = UnityEngine.Time.realtimeSinceStartup - self._gameStartTime

	StatController.instance:track(StatEnum.EventName.DianJiShiGame, {
		[StatEnum.EventProperties.OperationType] = operationType,
		[StatEnum.EventProperties.MapId] = tostring(self._episodeId),
		[StatEnum.EventProperties.RevertTimes] = self._gameRevertTimes,
		[StatEnum.EventProperties.TipTimes] = self._gameTipTimes,
		[StatEnum.EventProperties.UseTime] = math.ceil(useTime)
	})
end

DianJiShiStatController.instance = DianJiShiStatController.New()

return DianJiShiStatController
