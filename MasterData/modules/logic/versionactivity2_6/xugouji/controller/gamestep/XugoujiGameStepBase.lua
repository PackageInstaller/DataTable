-- chunkname: @modules/logic/versionactivity2_6/xugouji/controller/gamestep/XugoujiGameStepBase.lua

module("modules.logic.versionactivity2_6.xugouji.controller.gamestep.XugoujiGameStepBase", package.seeall)

local XugoujiGameStepBase = class("XugoujiGameStepBase")

function XugoujiGameStepBase:init(stepData)
	self._stepData = stepData
end

function XugoujiGameStepBase:start()
	return
end

function XugoujiGameStepBase:finish()
	local stepCtrl = XugoujiGameStepController.instance

	if stepCtrl then
		stepCtrl:nextStep()
	end
end

function XugoujiGameStepBase:dispose()
	self._stepData = nil
end

return XugoujiGameStepBase
