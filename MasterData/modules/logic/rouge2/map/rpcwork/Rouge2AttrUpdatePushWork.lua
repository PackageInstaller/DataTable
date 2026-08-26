-- chunkname: @modules/logic/rouge2/map/rpcwork/Rouge2AttrUpdatePushWork.lua

module("modules.logic.rouge2.map.rpcwork.Rouge2AttrUpdatePushWork", package.seeall)

local Rouge2AttrUpdatePushWork = class("Rouge2AttrUpdatePushWork", Rouge2_MsgPushWork)

function Rouge2AttrUpdatePushWork:onStart(context)
	self._flow = FlowSequence.New()

	self._flow:addWork(FunctionWork.New(self.updateInfo, self))
	self._flow:addWork(FunctionWork.New(self.showAttrUp, self))
	self._flow:addWork(Rouge2_WaitGetAttrDropRewardWork.New())
	self._flow:registerDoneListener(self._onAttrUpFlowDone, self)
	self._flow:start()
end

function Rouge2AttrUpdatePushWork:updateInfo()
	local updates = self._msg.updates

	Rouge2_Model.instance:updateAttrInfoList(updates)
	Rouge2_BackpackController.instance:buildBXSBoxReddot()
end

function Rouge2AttrUpdatePushWork:showAttrUp()
	Rouge2_MapInteractHelper.addPopMapAttrUpView()
end

function Rouge2AttrUpdatePushWork:_onAttrUpFlowDone()
	self:onDone(true)
end

function Rouge2AttrUpdatePushWork:clearWork()
	if self._flow then
		self._flow:destroy()

		self._flow = nil
	end
end

return Rouge2AttrUpdatePushWork
