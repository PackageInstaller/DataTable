-- chunkname: @modules/logic/store/view/monthandseasoncard/MonthCardSubView.lua

module("modules.logic.store.view.monthandseasoncard.MonthCardSubView", package.seeall)

local MonthCardSubView = class("MonthCardSubView", StoreMonthCardView)

function MonthCardSubView:getTabIndex(id)
	if self.viewContainer and self.viewContainer.getMonthAndSeasonTabIndex and (self.config or id) then
		return self.viewContainer:getMonthAndSeasonTabIndex(id or self.config.id)
	end

	return 1
end

return MonthCardSubView
