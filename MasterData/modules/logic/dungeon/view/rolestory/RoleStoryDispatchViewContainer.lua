-- chunkname: @modules/logic/dungeon/view/rolestory/RoleStoryDispatchViewContainer.lua

module("modules.logic.dungeon.view.rolestory.RoleStoryDispatchViewContainer", package.seeall)

local RoleStoryDispatchViewContainer = class("RoleStoryDispatchViewContainer", BaseViewContainer)

function RoleStoryDispatchViewContainer:buildViews()
	local views = {}

	table.insert(views, RoleStoryDispatchNormalView.New())
	table.insert(views, RoleStoryDispatchStoryView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))
	table.insert(views, TabViewGroup.New(2, "#go_topright"))

	return views
end

function RoleStoryDispatchViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		local view = NavigateButtonsView.New({
			true,
			true,
			true
		}, 1820001)

		return {
			view
		}
	end

	local currencyParam = {
		{
			isIcon = true,
			type = MaterialEnum.MaterialType.Item,
			id = CommonConfig.instance:getConstNum(ConstEnum.RoleStoryActivityItemId)
		}
	}

	self.currencyView = CurrencyView.New(currencyParam)
	self.currencyView.foreHideBtn = true

	return {
		self.currencyView
	}
end

return RoleStoryDispatchViewContainer
