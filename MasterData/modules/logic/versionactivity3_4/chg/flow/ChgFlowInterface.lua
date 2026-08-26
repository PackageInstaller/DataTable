-- chunkname: @modules/logic/versionactivity3_4/chg/flow/ChgFlowInterface.lua

module("modules.logic.versionactivity3_4.chg.flow.ChgFlowInterface", package.seeall)

local ChgFlowInterface = class("ChgFlowInterface")

function ChgFlowInterface:resetToIdle(...)
	return self.dragContext:resetToIdle(...)
end

function ChgFlowInterface:checkIsCompleted(...)
	return self.dragContext:checkIsCompleted(...)
end

function ChgFlowInterface:setCompleted(...)
	return self.dragContext:setCompleted(...)
end

function ChgFlowInterface:getAllVisitedCheckpointItemList(...)
	return self.dragContext:getAllVisitedCheckpointItemList(...)
end

function ChgFlowInterface:calcEnergy(...)
	return self.viewContainer:calcEnergy(...)
end

function ChgFlowInterface:calcEnergy01(...)
	return self.viewContainer:calcEnergy01(...)
end

function ChgFlowInterface:setText_txtCount(...)
	return self.viewObj:setText_txtCount(...)
end

function ChgFlowInterface:setEnergy(...)
	return self.viewContainer:setEnergy(...)
end

function ChgFlowInterface:curEnergy(...)
	return self.viewContainer:curEnergy(...)
end

function ChgFlowInterface:startItem()
	return self.viewContainer:startItem()
end

function ChgFlowInterface:endItemList()
	return self.viewContainer:endItemList()
end

function ChgFlowInterface:getGroupListByGroupId(...)
	return self.viewContainer:getGroupListByGroupId(...)
end

function ChgFlowInterface:Settings()
	return self.viewObj._Settings
end

function ChgFlowInterface:Image_SliderFG()
	return self.viewObj._Image_SliderFG
end

function ChgFlowInterface:Image_SliderFGTran()
	return self.viewObj._Image_SliderFGTran
end

function ChgFlowInterface:getLineItemAPosByKey(...)
	return self.viewObj:getLineItemAPosByKey(...)
end

function ChgFlowInterface:getItemByKey(key)
	return self.viewObj:getItemByKey(key)
end

function ChgFlowInterface:setText_txtTips(...)
	return self.viewObj:setText_txtTips(...)
end

function ChgFlowInterface:setText_txtNum(...)
	return self.viewObj:setText_txtNum(...)
end

function ChgFlowInterface:getOrCreateUIFlying(...)
	return self.viewObj:getOrCreateUIFlying(...)
end

function ChgFlowInterface:Line_HorizontalTrans()
	return self.viewObj._Line_HorizontalTrans
end

function ChgFlowInterface:Line_VerticalTrans()
	return self.viewObj._Line_VerticalTrans
end

function ChgFlowInterface:Line_HorizontalLayoutCmp()
	return self.viewObj._Line_HorizontalLayoutCmp
end

function ChgFlowInterface:Line_VerticalGoLayoutCmp()
	return self.viewObj._Line_VerticalGoLayoutCmp
end

function ChgFlowInterface:setActive_goVictory(...)
	self.viewObj:setActive_goVictory(...)
end

function ChgFlowInterface:doRestart(...)
	self.viewObj:doRestart(...)
end

function ChgFlowInterface:recycleAllUIFlying(...)
	self.viewObj:recycleAllUIFlying(...)
end

function ChgFlowInterface:setActive_goBgClick(...)
	self.viewObj:setActive_goBgClick(...)
end

function ChgFlowInterface:setRound(...)
	self.viewContainer:setRound(...)
end

function ChgFlowInterface:completeGame(...)
	self.viewContainer:completeGame(...)
end

function ChgFlowInterface:triggerPlayLoopSFX(...)
	self.viewContainer:triggerPlayLoopSFX(...)
end

return ChgFlowInterface
