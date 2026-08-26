-- chunkname: @modules/logic/rouge2/map/work/Rouge2_WaitGetAttrDropRewardWork.lua

module("modules.logic.rouge2.map.work.Rouge2_WaitGetAttrDropRewardWork", package.seeall)

local Rouge2_WaitGetAttrDropRewardWork = class("Rouge2_WaitGetAttrDropRewardWork", BaseWork)

function Rouge2_WaitGetAttrDropRewardWork:ctor()
	return
end

function Rouge2_WaitGetAttrDropRewardWork:onStart()
	local isBlockTrigger = Rouge2_MapModel.instance:isBlockTriggerInteractive()
	local isWaitGetReward = Rouge2_AttrDropController.instance:isWaitGetAttrReward()

	if isBlockTrigger or isWaitGetReward then
		self:onDone(true)

		return
	end

	Rouge2_AttrDropController.instance:recordWaitGetAttrReward(true)

	local attrInfoList = Rouge2_Model.instance:getHeroAttrInfoList()

	self._flow = FlowSequence.New()

	self._flow:addWork(Rouge2_WaitRougeInteractDoneWork.New(true))

	if attrInfoList then
		for _, attrInfo in ipairs(attrInfoList) do
			local attrId = attrInfo:getId()

			self._flow:addWork(Rouge2_WaitPopViewDoneWork.New())
			self._flow:addWork(Rouge2_SendGetAttrDropRpcWork.New(attrId))
			self._flow:addWork(Rouge2_WaitRougeInteractDoneWork.New(true))
		end
	end

	self._flow:registerDoneListener(self._onGetRewardFlowDone, self)
	self._flow:start()
end

function Rouge2_WaitGetAttrDropRewardWork:_onGetRewardFlowDone()
	Rouge2_AttrDropController.instance:recordWaitGetAttrReward(false)
	self:onDone(true)
end

function Rouge2_WaitGetAttrDropRewardWork:clearWork()
	if self._flow then
		self._flow:destroy()

		self._flow = nil
	end
end

return Rouge2_WaitGetAttrDropRewardWork
