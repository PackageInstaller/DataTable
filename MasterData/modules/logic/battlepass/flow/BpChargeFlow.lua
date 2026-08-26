-- chunkname: @modules/logic/battlepass/flow/BpChargeFlow.lua

module("modules.logic.battlepass.flow.BpChargeFlow", package.seeall)

local BpChargeFlow = class("BpChargeFlow", FlowSequence)

function BpChargeFlow:buildFlow()
	PopupController.instance:setPause("BpChargeFlow", true)
	UIBlockMgrExtend.instance.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("BpChargeFlow")

	local needShowLevelUp = BpController.instance:needShowLevelUp()

	BpController.instance:pauseShowLevelUp()
	self:addWork(BpWaitSecWork.New(0.06))

	if needShowLevelUp then
		self:addWork(BpOpenAndWaitCloseWork.New(ViewName.BpLevelupTipView))
	end

	self:addWork(BpCloseViewWork.New(BpController.instance:getBpChargeView()))
	self:addWork(BpWaitBonusAnimWork.New())
	self:start()
end

function BpChargeFlow:clearWork()
	UIBlockMgrExtend.instance.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("BpChargeFlow")
	PopupController.instance:setPause("BpChargeFlow", false)
end

return BpChargeFlow
