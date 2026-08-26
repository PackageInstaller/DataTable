-- chunkname: @modules/logic/versionactivity2_6/xugouji/controller/gamestep/XugoujiGameStepOperateNumUpdate.lua

module("modules.logic.versionactivity2_6.xugouji.controller.gamestep.XugoujiGameStepOperateNumUpdate", package.seeall)

local XugoujiGameStepOperateNumUpdate = class("XugoujiGameStepOperateNumUpdate", XugoujiGameStepBase)

function XugoujiGameStepOperateNumUpdate:start()
	local leftNum = self._stepData.remainReverseCount
	local isMySelf = self._stepData.isSelf

	Activity188Model.instance:setCurTurnOperateTime(leftNum, not isMySelf)
	XugoujiController.instance:dispatchEvent(XugoujiEvent.OperateTimeUpdated)

	if isMySelf then
		Activity188Model.instance:setGameViewState((leftNum == 0 or nil) and (XugoujiEnum.GameViewState.PlayerOperaDisplay or XugoujiEnum.GameViewState.PlayerOperating))
	else
		Activity188Model.instance:setGameViewState((leftNum == 0 or nil) and (XugoujiEnum.GameViewState.EnemyOperaDisplay or XugoujiEnum.GameViewState.EnemyOperatingng))
	end

	self:finish()
end

return XugoujiGameStepOperateNumUpdate
