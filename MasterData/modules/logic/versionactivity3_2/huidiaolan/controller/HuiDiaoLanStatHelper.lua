-- chunkname: @modules/logic/versionactivity3_2/huidiaolan/controller/HuiDiaoLanStatHelper.lua

module("modules.logic.versionactivity3_2.huidiaolan.controller.HuiDiaoLanStatHelper", package.seeall)

local HuiDiaoLanStatHelper = class("HuiDiaoLanStatHelper")

function HuiDiaoLanStatHelper:ctor()
	self.gameStartTime = 0
	self.dataObj = {}
end

function HuiDiaoLanStatHelper:initGameStartTime()
	self.gameStartTime = UnityEngine.Time.realtimeSinceStartup
end

function HuiDiaoLanStatHelper:sendOperationInfo(mapId, operationStr)
	StatController.instance:track(StatEnum.EventName.HuiDiaoLanGame, {
		[StatEnum.EventProperties.MapId] = tostring(mapId),
		[StatEnum.EventProperties.OperationType] = operationStr,
		[StatEnum.EventProperties.UseTime] = UnityEngine.Time.realtimeSinceStartup - self.gameStartTime,
		[StatEnum.EventProperties.ActHuiDiaoLanDataObj] = self.dataObj
	})
end

function HuiDiaoLanStatHelper:buildDataObj(remainStep, changeColorUseCount, exchangePosUseCount, energy, diamond)
	self.dataObj = {
		remain_step = remainStep,
		skill_color_cnt = changeColorUseCount,
		skill_exchange_cnt = exchangePosUseCount,
		energy = energy,
		diamond = diamond
	}
end

HuiDiaoLanStatHelper.instance = HuiDiaoLanStatHelper.New()

return HuiDiaoLanStatHelper
