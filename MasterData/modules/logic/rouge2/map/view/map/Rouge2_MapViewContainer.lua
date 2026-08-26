-- chunkname: @modules/logic/rouge2/map/view/map/Rouge2_MapViewContainer.lua

module("modules.logic.rouge2.map.view.map.Rouge2_MapViewContainer", package.seeall)

local Rouge2_MapViewContainer = class("Rouge2_MapViewContainer", BaseViewContainer)

function Rouge2_MapViewContainer:buildViews()
	local views = {}

	table.insert(views, Rouge2_MapView.New())
	table.insert(views, Rouge2_MapDragView.New())
	table.insert(views, Rouge2_MapInputView.New())
	table.insert(views, Rouge2_MapCoinView.New())
	table.insert(views, Rouge2_MapNodeRightView.New())
	table.insert(views, Rouge2_MapLayerRightView.New())
	table.insert(views, Rouge2_MapLayerLineView.New())
	table.insert(views, Rouge2_MapLayerWeatherView.New())
	table.insert(views, Rouge2_MapEntrustView.New())
	table.insert(views, Rouge2_MapVoiceView.New())
	table.insert(views, Rouge2_MapWeatherView.New())
	table.insert(views, Rouge2_MapBoxView.New())
	table.insert(views, Rouge2_MapGuideView.New())
	table.insert(views, TabViewGroup.New(1, "#go_LeftTop"))

	return views
end

function Rouge2_MapViewContainer:buildTabViews(tabContainerId)
	self.navigateView = NavigateButtonsView.New({
		true,
		false,
		true
	})

	self.navigateView:setOverrideHelp(self.overrideHelpBtn, self)
	self.navigateView:setOverrideClose(self._overrideClose, self)

	return {
		self.navigateView
	}
end

function Rouge2_MapViewContainer:_overrideClose()
	Rouge2_MapHelper.backToMainScene()
	Rouge2_StatController.instance:statEnd(Rouge2_StatController.EndResult.Close)
end

function Rouge2_MapViewContainer:overrideHelpBtn()
	if Rouge2_MapModel.instance:isNormalLayer() then
		Rouge2_Controller.instance:openTechniqueView(Rouge2_MapEnum.TechniqueId.NormalLayer)
	elseif Rouge2_MapModel.instance:isMiddle() then
		Rouge2_Controller.instance:openTechniqueView(Rouge2_MapEnum.TechniqueId.MiddleLayer)
	elseif Rouge2_MapModel.instance:isPathSelect() then
		Rouge2_Controller.instance:openTechniqueView(Rouge2_MapEnum.TechniqueId.PathSelectLayer)
	else
		logError("肉鸽打开指引图失败!!!")
	end
end

return Rouge2_MapViewContainer
