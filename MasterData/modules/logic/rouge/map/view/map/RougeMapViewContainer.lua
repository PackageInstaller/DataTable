-- chunkname: @modules/logic/rouge/map/view/map/RougeMapViewContainer.lua

module("modules.logic.rouge.map.view.map.RougeMapViewContainer", package.seeall)

local RougeMapViewContainer = class("RougeMapViewContainer", BaseViewContainer)

function RougeMapViewContainer:buildViews()
	local views = {}

	table.insert(views, RougeMapView.New())
	table.insert(views, RougeMapDragView.New())
	table.insert(views, RougeMapInputView.New())
	table.insert(views, RougeMapCoinView.New())
	table.insert(views, RougeMapNodeRightView.New())
	table.insert(views, RougeMapLayerRightView.New())
	table.insert(views, RougeMapLayerLineView.New())
	table.insert(views, RougeMapEntrustView.New())
	table.insert(views, RougeMapEliteFightView.New())
	table.insert(views, RougeMapVoiceView.New())
	table.insert(views, TabViewGroup.New(1, "#go_LeftTop"))
	table.insert(views, RougeBaseDLCViewComp.New())

	return views
end

function RougeMapViewContainer:buildTabViews(tabContainerId)
	self.navigateView = NavigateButtonsView.New({
		true,
		false,
		false
	})

	self.navigateView:setHelpId(HelpEnum.HelpId.RougeMapViewHelp)
	self.navigateView:setOverrideClose(self._overrideClose, self)

	return {
		self.navigateView
	}
end

function RougeMapViewContainer:_overrideClose()
	RougeMapHelper.backToMainScene()
	RougeStatController.instance:statEnd(RougeStatController.EndResult.Close)
end

return RougeMapViewContainer
