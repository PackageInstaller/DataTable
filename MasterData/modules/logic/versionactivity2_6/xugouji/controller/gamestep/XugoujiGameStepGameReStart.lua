-- chunkname: @modules/logic/versionactivity2_6/xugouji/controller/gamestep/XugoujiGameStepGameReStart.lua

module("modules.logic.versionactivity2_6.xugouji.controller.gamestep.XugoujiGameStepGameReStart", package.seeall)

local XugoujiGameStepGameReStart = class("XugoujiGameStepGameReStart", XugoujiGameStepBase)

function XugoujiGameStepGameReStart:start()
	XugoujiController.instance:dispatchEvent(XugoujiEvent.GameRestartCardDisplay)
	TaskDispatcher.runDelay(self.finish, self, 0.5)
end

function XugoujiGameStepGameReStart:dispose()
	XugoujiGameStepBase.dispose(self)
end

return XugoujiGameStepGameReStart
