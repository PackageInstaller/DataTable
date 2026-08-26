-- chunkname: @modules/logic/dungeon/view/rolestory/RoleStoryDispatchMainViewContainer.lua

module("modules.logic.dungeon.view.rolestory.RoleStoryDispatchMainViewContainer", package.seeall)

local RoleStoryDispatchMainViewContainer = class("RoleStoryDispatchMainViewContainer", BaseViewContainer)

function RoleStoryDispatchMainViewContainer:buildViews()
	local views = {}

	table.insert(views, RoleStoryItemRewardView.New())
	table.insert(views, RoleStoryDispatchMainView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))
	table.insert(views, TabViewGroup.New(2, "#go_topright"))

	return views
end

function RoleStoryDispatchMainViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonsView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			self._navigateButtonsView
		}
	end

	local currencyParam = {
		{
			isIcon = true,
			type = MaterialEnum.MaterialType.Item,
			id = CommonConfig.instance:getConstNum(ConstEnum.RoleStoryActivityItemId)
		},
		CurrencyEnum.CurrencyType.RoleStory
	}

	self.currencyView = CurrencyView.New(currencyParam)
	self.currencyView.foreHideBtn = true

	return {
		self.currencyView
	}
end

function RoleStoryDispatchMainViewContainer:refreshCurrency(currencyTypeParam)
	self.currencyView:setCurrencyType(currencyTypeParam)
end

function RoleStoryDispatchMainViewContainer:onContainerClose()
	if self:isManualClose() and not ViewMgr.instance:isOpen(ViewName.MainView) then
		MainController.instance:dispatchEvent(MainEvent.ManuallyOpenMainView)
	end
end

return RoleStoryDispatchMainViewContainer
