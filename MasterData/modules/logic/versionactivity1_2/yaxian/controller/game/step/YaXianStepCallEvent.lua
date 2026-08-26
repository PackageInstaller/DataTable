-- chunkname: @modules/logic/versionactivity1_2/yaxian/controller/game/step/YaXianStepCallEvent.lua

module("modules.logic.versionactivity1_2.yaxian.controller.game.step.YaXianStepCallEvent", package.seeall)

local YaXianStepCallEvent = class("YaXianStepCallEvent", YaXianStepBase)

function YaXianStepCallEvent:start()
	local stateMgr = YaXianGameController.instance.state

	if stateMgr then
		stateMgr:setCurEventByObj(self.originData.event)

		self._curState = stateMgr:getCurEvent()
	end

	if self._curState then
		YaXianGameController.instance:registerCallback(YaXianEvent.OnStateFinish, self.onReceiveFinished, self)
	else
		self:finish()
	end
end

function YaXianStepCallEvent:onReceiveFinished(stateType)
	if self._curState and self._curState.stateType == stateType then
		YaXianGameController.instance:unregisterCallback(YaXianEvent.OnStateFinish, self.onReceiveFinished, self)
		self:finish()
	end
end

function YaXianStepCallEvent:finish()
	local stateMgr = YaXianGameController.instance.state

	if stateMgr then
		stateMgr:disposeEventState()
	end

	YaXianStepCallEvent.super.finish(self)
end

function YaXianStepCallEvent:dispose()
	YaXianGameController.instance:unregisterCallback(YaXianEvent.OnStateFinish, self.onReceiveFinished, self)

	local stateMgr = YaXianGameController.instance.state

	if stateMgr then
		stateMgr:disposeEventState()
	end
end

return YaXianStepCallEvent
