-- chunkname: @modules/logic/seasonver/act123/view3_5/Season123_3_5SettlementTipsWork.lua

module("modules.logic.seasonver.act123.view3_5.Season123_3_5SettlementTipsWork", package.seeall)

local Season123_3_5SettlementTipsWork = class("Season123_3_5SettlementTipsWork", BaseWork)

function Season123_3_5SettlementTipsWork:onStart(context)
	self._context = context

	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)

	if PopupController.instance:getPopupCount() > 0 then
		PopupController.instance:setPause("fightsuccess", false)

		self._showPopupView = true
	else
		self:_showEquipGet()
	end
end

function Season123_3_5SettlementTipsWork:_showEquipGet()
	PopupController.instance:setPause("fightsuccess", false)

	self._showEquipCard = self._context.equipList or {}

	local delayTime = self._context.delayTime

	if #self._showEquipCard > 0 then
		local idDict = {}

		for i = #self._showEquipCard, 1, -1 do
			local cardId = self._showEquipCard[i]

			if idDict[cardId] then
				table.remove(self._showEquipCard, i)
			else
				idDict[cardId] = true
			end
		end

		TaskDispatcher.runDelay(self._showGetCardView, self, delayTime)
	else
		self:onDone(true)
	end
end

function Season123_3_5SettlementTipsWork:_onCloseViewFinish(viewName)
	if self._showPopupView then
		if PopupController.instance:getPopupCount() == 0 then
			self._showPopupView = nil

			self:_showEquipGet()
		end
	else
		local getViewName = ViewName.Season123_3_5CelebrityCardGetView

		if viewName == getViewName then
			self:onDone(true)
		end
	end
end

function Season123_3_5SettlementTipsWork:_showGetCardView()
	Season123Controller.instance:openSeasonCelebrityCardGetView({
		is_item_id = true,
		data = self._showEquipCard
	})
end

function Season123_3_5SettlementTipsWork:clearWork()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

return Season123_3_5SettlementTipsWork
