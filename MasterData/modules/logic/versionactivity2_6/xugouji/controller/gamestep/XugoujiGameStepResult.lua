-- chunkname: @modules/logic/versionactivity2_6/xugouji/controller/gamestep/XugoujiGameStepResult.lua

module("modules.logic.versionactivity2_6.xugouji.controller.gamestep.XugoujiGameStepResult", package.seeall)

local XugoujiGameStepResult = class("XugoujiGameStepResult", XugoujiGameStepBase)

function XugoujiGameStepResult:start()
	XugoujiController.instance:dispatchEvent(XugoujiEvent.GameResult, self._stepData)
	XugoujiGameStepController.instance:disposeAllStep()
end

return XugoujiGameStepResult
