-- chunkname: @modules/logic/fight/controller/FightReplayController.lua

module("modules.logic.fight.controller.FightReplayController", package.seeall)

local FightReplayController = class("FightReplayController", BaseController)

function FightReplayController:onInit()
	self._replayErrorFix = FightReplayErrorFix.New()
end

function FightReplayController:reInit()
	self._replayErrorFix:reInit()
	self:_stopReplay()

	self._callback = nil
	self._calbackObj = nil
end

function FightReplayController:addConstEvents()
	FightController.instance:registerCallback(FightEvent.StartReplay, self._startReplay, self)
	FightController.instance:registerCallback(FightEvent.PushEndFight, self._stopReplay, self)
	FightController.instance:registerCallback(FightEvent.RespGetFightOperReplay, self._onGetOperReplay, self)
	FightController.instance:registerCallback(FightEvent.RespGetFightOperReplayFail, self._onGetOperReplayFail, self)
	self._replayErrorFix:addConstEvents()
end

function FightReplayController:reqReplay(callback, calbackObj)
	self._callback = callback
	self._calbackObj = calbackObj

	FightRpc.instance:sendGetFightOperRequest()
end

function FightReplayController:_setQuality(isReplay)
	if isReplay then
		if not self._quality then
			self._quality = SettingsModel.instance:getModelGraphicsQuality()
			self._frameRate = SettingsModel.instance:getModelTargetFrameRate()

			GameGlobalMgr.instance:getScreenState():setLocalQuality(ModuleEnum.Performance.Low, true)
			GameGlobalMgr.instance:getScreenState():setTargetFrameRate(ModuleEnum.TargetFrameRate.Low, true)
		end
	elseif self._quality then
		GameGlobalMgr.instance:getScreenState():setLocalQuality(self._quality, true)
		GameGlobalMgr.instance:getScreenState():setTargetFrameRate(self._frameRate, true)

		self._quality = nil
		self._frameRate = nil
	end
end

function FightReplayController:_onGetOperReplay()
	FightController.instance:dispatchEvent(FightEvent.StartReplay)

	FightDataHelper.stateMgr.isReplay = true

	self:_reqReplayCallback()
end

function FightReplayController:_onGetOperReplayFail()
	self:_reqReplayCallback()
end

function FightReplayController:_reqReplayCallback()
	local callback = self._callback
	local callbackObj = self._calbackObj

	self._callback = nil
	self._calbackObj = nil

	if callback then
		self._callback(callbackObj)
	end
end

function FightReplayController:_startReplay()
	self:_setQuality(true)
	self:_stopReplayFlow()

	self._replayFlow = FightReplayStepBuilder.buildReplaySequence()

	self._replayFlow:registerDoneListener(self._onReplayDone, self)
	self._replayFlow:start({})
end

function FightReplayController:doneCardStage()
	if self._replayFlow and self._replayFlow.status == WorkStatus.Running then
		local workList = self._replayFlow:getWorkList()
		local curWorkIdx = self._replayFlow._curIndex

		if self._replayFlow._workList then
			for i = curWorkIdx, #workList do
				local work = workList[i]

				if isTypeOf(work, FightReplayWorkWaitRoundEnd) then
					self._replayFlow._curIndex = i - 1

					self._replayFlow:_runNext()

					break
				end
			end

			if self._replayFlow._workList then
				self._replayFlow._workList:onDone(true)
			end
		end
	end
end

function FightReplayController:_onReplayDone()
	self:_stopReplayFlow()
end

function FightReplayController:_stopReplay()
	self:_setQuality(false)

	FightDataHelper.stateMgr.isReplay = false

	self:_stopReplayFlow()
end

function FightReplayController:_stopReplayFlow()
	if self._replayFlow then
		if self._replayFlow.status == WorkStatus.Running then
			self._replayFlow:stop()
		end

		self._replayFlow:unregisterDoneListener(self._onReplayDone, self)

		self._replayFlow = nil
	end
end

FightReplayController.instance = FightReplayController.New()

return FightReplayController
