-- chunkname: @modules/logic/versionactivity2_6/xugouji/controller/gamestep/XugoujiGameStepHpUpdate.lua

module("modules.logic.versionactivity2_6.xugouji.controller.gamestep.XugoujiGameStepHpUpdate", package.seeall)

local XugoujiGameStepHpUpdate = class("XugoujiGameStepHpUpdate", XugoujiGameStepBase)

function XugoujiGameStepHpUpdate:start()
	local isSelf = self._stepData.isSelf
	local hpChangeValue = self._stepData.hpChange

	Activity188Model.instance:updateHp(isSelf, hpChangeValue)
	XugoujiController.instance:dispatchEvent(XugoujiEvent.HpUpdated)
	self:finish()
end

function XugoujiGameStepHpUpdate:dispose()
	TaskDispatcher.cancelTask(self.finish, self)
	XugoujiGameStepBase.dispose(self)
end

return XugoujiGameStepHpUpdate
