-- chunkname: @modules/logic/rouge2/map/controller/Rouge2_MapChoiceController.lua

module("modules.logic.rouge2.map.controller.Rouge2_MapChoiceController", package.seeall)

local Rouge2_MapChoiceController = class("Rouge2_MapChoiceController", BaseController)

function Rouge2_MapChoiceController:reInit()
	self:clear()
end

function Rouge2_MapChoiceController:onSendChoiceRequest()
	Rouge2_MapModel.instance:blockTriggerInteractive(true)
	self:_destroyFlow()

	self._flow = FlowSequence.New()
	self._pushFlow = FlowSequence.New()
end

function Rouge2_MapChoiceController:onReceiveChoiceReply(resultCode, msg)
	if resultCode ~= 0 then
		self:_destroyFlow()
		Rouge2_MapModel.instance:blockTriggerInteractive(false)

		return
	end

	self:_addUpdateMapFlow(msg, self._flow)
	self._flow:addWork(Rouge2_WaitAttrDiceDoneWork.New())
	self._flow:addWork(Rouge2_PlayDialogueWork.New())
	self:_addPushStepFlow()
	self._flow:addWork(FunctionWork.New(Rouge2_MapModel.blockTriggerInteractive, Rouge2_MapModel.instance, false))
	self._flow:addWork(Rouge2_WaitRougeInteractDoneWork.New())
	self._flow:addWork(Rouge2_WaitGetAttrDropRewardWork.New())
	self._flow:addWork(Rouge2_WaitPopViewDoneWork.New())
	self._flow:registerDoneListener(self._onChoiceFlowDone, self)
	self._flow:start()
end

function Rouge2_MapChoiceController:addPushToFlow(msgName, msg)
	local workCls = _G[string.format("%sWork", msgName)] or Rouge2_MsgPushWork
	local work = workCls.New(msgName, msg)

	if self._flow and not self:isPushFlowDone() then
		self._pushFlow:addWork(work)

		return
	elseif not self._flow or self:isPushFlowDone() then
		self:_buildTempFlow(work)

		return
	else
		self._steps = self._steps or {}

		table.insert(self._steps, work)
	end
end

function Rouge2_MapChoiceController:_buildTempFlow(work)
	self._tempFlowMap = self._tempFlowMap or {}

	local tempFlow = FlowSequence.New()

	self._tempFlowMap[tempFlow] = true

	tempFlow:addWork(work)
	tempFlow.registerDoneListener(tempFlow, self._onTempFlowDone, tempFlow)
	tempFlow:start()
end

function Rouge2_MapChoiceController._onTempFlowDone(tempFlow)
	tempFlow:destroy()

	Rouge2_MapChoiceController.instance._tempFlowMap[tempFlow] = nil
end

function Rouge2_MapChoiceController:destroyTempFlowMap()
	if self._tempFlowMap then
		for tempFlow in pairs(self._tempFlowMap) do
			tempFlow:destroy()

			self._tempFlowMap[tempFlow] = nil
		end
	end

	Rouge2_AttrDropController.instance:recordWaitGetAttrReward(false)
end

function Rouge2_MapChoiceController:_destroyFlow()
	if self._flow then
		self._flow:destroy()

		self._flow = nil
	end

	self._pushFlow = nil
end

function Rouge2_MapChoiceController:_addUpdateMapFlow(msg, flow)
	if msg and msg:HasField("map") then
		local mapFlow = FlowSequence.New()

		mapFlow:addWork(FunctionWork.New(Rouge2_MapModel.updateMapInfo, Rouge2_MapModel.instance, msg.map))
		flow:addWork(mapFlow)
	end
end

function Rouge2_MapChoiceController:_addPushStepFlow()
	self._flow:addWork(self._pushFlow)

	if not self._steps or #self._steps <= 0 then
		return
	end

	for _, step in ipairs(self._steps) do
		self._pushFlow:addWork(step)
	end

	self._steps = nil
end

function Rouge2_MapChoiceController:isFlowRunning()
	return self._flow and self._flow.status == WorkStatus.Running
end

function Rouge2_MapChoiceController:isPushFlowDone()
	return self._pushFlow and self._pushFlow.isSuccess == true
end

function Rouge2_MapChoiceController:_onChoiceFlowDone()
	self:clearChoiceFlow()
	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onChoiceFlowDone)
end

function Rouge2_MapChoiceController:clearChoiceFlow()
	self:_destroyFlow()
	Rouge2_MapModel.instance:blockTriggerInteractive(false)
end

function Rouge2_MapChoiceController:clear()
	self:clearChoiceFlow()
	self:destroyTempFlowMap()
end

Rouge2_MapChoiceController.instance = Rouge2_MapChoiceController.New()

return Rouge2_MapChoiceController
