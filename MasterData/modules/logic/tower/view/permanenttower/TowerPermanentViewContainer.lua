-- chunkname: @modules/logic/tower/view/permanenttower/TowerPermanentViewContainer.lua

module("modules.logic.tower.view.permanenttower.TowerPermanentViewContainer", package.seeall)

local TowerPermanentViewContainer = class("TowerPermanentViewContainer", BaseViewContainer)

function TowerPermanentViewContainer:buildViews()
	local views = {}

	self._scrollListView = LuaMixScrollView.New(TowerPermanentModel.instance, self:getListContentParam())

	table.insert(views, TabViewGroup.New(1, "#go_topleft"))
	table.insert(views, self._scrollListView)

	self.TowerPermanentPoolView = TowerPermanentPoolView.New()

	table.insert(views, TowerPermanentView.New())

	self.TowerPermanentInfoView = TowerPermanentInfoView.New()
	self.TowerPermanentDeepView = TowerPermanentDeepView.New()

	table.insert(views, self.TowerPermanentPoolView)
	table.insert(views, self.TowerPermanentInfoView)
	table.insert(views, self.TowerPermanentDeepView)

	return views
end

function TowerPermanentViewContainer:getListContentParam()
	local scrollParam = MixScrollParam.New()

	scrollParam.scrollGOPath = "Left/#scroll_category"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "Left/#scroll_category/Viewport/#go_Content/#go_item"
	scrollParam.cellClass = TowerPermanentItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV

	return scrollParam
end

function TowerPermanentViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			true
		}, HelpEnum.HelpId.TowerPermanent)

		return {
			self.navigateView
		}
	end
end

function TowerPermanentViewContainer:getTowerPermanentPoolView()
	return self.TowerPermanentPoolView
end

function TowerPermanentViewContainer:getTowerPermanentInfoView()
	return self.TowerPermanentInfoView
end

return TowerPermanentViewContainer
