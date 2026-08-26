-- chunkname: @modules/logic/rouge2/map/work/Rouge2_WaitTriggerAttrCheckDoneWork.lua

module("modules.logic.rouge2.map.work.Rouge2_WaitTriggerAttrCheckDoneWork", package.seeall)

local Rouge2_WaitTriggerAttrCheckDoneWork = class("Rouge2_WaitTriggerAttrCheckDoneWork", BaseWork)

function Rouge2_WaitTriggerAttrCheckDoneWork:ctor()
	return
end

function Rouge2_WaitTriggerAttrCheckDoneWork:onStart()
	local isAttrCheck = Rouge2_MapAttrCheckHelper.isAttrCheckInteract()

	if not isAttrCheck then
		return self:onDone(true)
	end

	local curInteract = Rouge2_MapModel.instance:getCurInteractiveJson()
	local fromType = curInteract and curInteract.fromType

	if fromType ~= Rouge2_MapEnum.InteractFromType.Event then
		return self:onDone(true)
	end

	self:destroyFlow()
	Rouge2_MapModel.instance:blockTriggerInteractive(true)

	self._flow = FlowSequence.New()

	self._flow:addWork(Rouge2_WaitTriggerChoiceEventWork.New())
	self._flow:addWork(Rouge2_WaitAttrDiceDoneWork.New())
	self._flow:addWork(Rouge2_PlayDialogueWork.New())
	self._flow:addWork(FunctionWork.New(Rouge2_MapModel.blockTriggerInteractive, Rouge2_MapModel.instance, false))
	self._flow:addWork(Rouge2_WaitRougeInteractDoneWork.New())
	self._flow:addWork(Rouge2_WaitGetAttrDropRewardWork.New())
	self._flow:addWork(Rouge2_WaitPopViewDoneWork.New())
	self._flow:registerDoneListener(self._onFlowDone, self)
	self._flow:start()
end

function Rouge2_WaitTriggerAttrCheckDoneWork:_onFlowDone()
	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onChoiceFlowDone)
	self:onDone(true)
end

function Rouge2_WaitTriggerAttrCheckDoneWork:destroyFlow()
	if self._flow then
		self._flow:destroy()

		self._flow = nil
	end
end

function Rouge2_WaitTriggerAttrCheckDoneWork:clearWork()
	self:destroyFlow()
	Rouge2_MapModel.instance:blockTriggerInteractive(false)
end

return Rouge2_WaitTriggerAttrCheckDoneWork
