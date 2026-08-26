-- chunkname: @modules/logic/survival/controller/work/SurvivalItemTipsPushWork.lua

module("modules.logic.survival.controller.work.SurvivalItemTipsPushWork", package.seeall)

local SurvivalItemTipsPushWork = class("SurvivalItemTipsPushWork", SurvivalMsgPushWork)

function SurvivalItemTipsPushWork:onStart(context)
	if self.context.fastExecute then
		self:onDone(true)

		return
	end

	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self.onViewClose, self)

	local items = {}

	for _, v in ipairs(self._msg.itemTips) do
		local itemMo = SurvivalBagItemMo.New()

		itemMo:init({
			id = v.itemId,
			count = v.count
		})

		itemMo.source = SurvivalEnum.ItemSource.Drop

		table.insert(items, itemMo)
	end

	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.SurvivalGetRewardView, {
		items = items
	})
end

function SurvivalItemTipsPushWork:onViewClose(viewName)
	if viewName == ViewName.SurvivalGetRewardView then
		self:onDone(true)
	end
end

function SurvivalItemTipsPushWork:clearWork()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self.onViewClose, self)
end

return SurvivalItemTipsPushWork
