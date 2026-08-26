-- chunkname: @modules/logic/rouge2/outside/work/Rouge2_WaitAlchemySuccessFxDoneWork.lua

module("modules.logic.rouge2.outside.work.Rouge2_WaitAlchemySuccessFxDoneWork", package.seeall)

local Rouge2_WaitAlchemySuccessFxDoneWork = class("Rouge2_WaitAlchemySuccessFxDoneWork", BaseWork)

function Rouge2_WaitAlchemySuccessFxDoneWork:ctor(viewParam)
	self.viewParam = viewParam
end

function Rouge2_WaitAlchemySuccessFxDoneWork:onStart()
	local fxTime = Rouge2_OutsideEnum.AlchemySuccessFxTime

	Rouge2_OutsideController.instance:lockScreen(true, fxTime)
	TaskDispatcher.runDelay(self.onFxPlayFinish, self, fxTime)
end

function Rouge2_WaitAlchemySuccessFxDoneWork:onFxPlayFinish()
	Rouge2_OutsideController.instance:lockScreen(false)
	TaskDispatcher.cancelTask(self.onFxPlayFinish, self)
	Rouge2_OutsideController.instance:openAlchemySuccessView(self.viewParam)
	self:onDone(true)
end

function Rouge2_WaitAlchemySuccessFxDoneWork:clearWork()
	TaskDispatcher.cancelTask(self.onFxPlayFinish, self)
end

function Rouge2_WaitAlchemySuccessFxDoneWork:onDestroy()
	TaskDispatcher.cancelTask(self.onFxPlayFinish, self)
	logNormal("Rouge2_WaitAlchemySuccessFxDoneWork onDestroy")
end

return Rouge2_WaitAlchemySuccessFxDoneWork
