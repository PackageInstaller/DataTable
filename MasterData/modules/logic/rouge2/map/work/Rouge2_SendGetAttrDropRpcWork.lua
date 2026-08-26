-- chunkname: @modules/logic/rouge2/map/work/Rouge2_SendGetAttrDropRpcWork.lua

module("modules.logic.rouge2.map.work.Rouge2_SendGetAttrDropRpcWork", package.seeall)

local Rouge2_SendGetAttrDropRpcWork = class("Rouge2_SendGetAttrDropRpcWork", BaseWork)

function Rouge2_SendGetAttrDropRpcWork:ctor(attrId)
	self._attrId = attrId
end

function Rouge2_SendGetAttrDropRpcWork:onStart()
	self._canGetReward = Rouge2_AttrDropController.instance:canGetAttrDropReward(self._attrId)

	if not self._canGetReward then
		self:onDone(true)

		return
	end

	self._flow = FlowSequence.New()

	self._flow:addWork(Rouge2_WaitSendRpcSuccWork.New(Rouge2_Rpc.sendRouge2GainCareerAttrDropRequest, Rouge2_Rpc.instance, self._attrId))
	self._flow:registerDoneListener(self._onGetRewardFlowDone, self)
	self._flow:start()
end

function Rouge2_SendGetAttrDropRpcWork:_onGetRewardFlowDone()
	Rouge2_AttrDropController.instance:recordWaitGetAttrReward(false)
	self:onDone(true)
end

function Rouge2_SendGetAttrDropRpcWork:clearWork()
	if self._flow then
		self._flow:destroy()

		self._flow = nil
	end
end

return Rouge2_SendGetAttrDropRpcWork
