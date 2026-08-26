-- chunkname: @modules/logic/commandstation/view/CommandStationMapViewContainer.lua

module("modules.logic.commandstation.view.CommandStationMapViewContainer", package.seeall)

local CommandStationMapViewContainer = class("CommandStationMapViewContainer", BaseViewContainer)

function CommandStationMapViewContainer:buildViews()
	self._leftVersionView = CommandStationMapLeftVersionView.New()
	self._timelineAnimView = CommandStationMapTimelineAnimView.New()
	self._mapScene = CommandStationMapSceneView.New()
	self._mapEvent = CommandStationMapEventView.New()

	local views = {}

	table.insert(views, CommandStationMapVersionLogoView.New())
	table.insert(views, self._leftVersionView)
	table.insert(views, CommandStationMapVersionView.New())
	table.insert(views, self._mapEvent)
	table.insert(views, self._mapScene)
	table.insert(views, self._timelineAnimView)
	table.insert(views, CommandStationMapView.New())
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))

	return views
end

function CommandStationMapViewContainer:getLeftVersionView()
	return self._leftVersionView
end

function CommandStationMapViewContainer:getTimelineAnimView()
	return self._timelineAnimView
end

function CommandStationMapViewContainer:getMapEventView()
	return self._mapEvent
end

function CommandStationMapViewContainer:getSceneGo()
	return self._mapScene and self._mapScene:getSceneGo()
end

function CommandStationMapViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._helpId = HelpEnum.HelpId.CommandStationMap
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			true
		}, self._helpId)

		return {
			self.navigateView
		}
	end
end

function CommandStationMapViewContainer:showHelp(visible)
	if visible then
		self.navigateView:setHelpId(self._helpId)
	else
		self.navigateView:hideHelpIcon()
	end
end

function CommandStationMapViewContainer:_setVisible(isVisible)
	CommandStationMapViewContainer.super._setVisible(self, isVisible)

	if self._mapScene then
		self._mapScene:setSceneVisible(isVisible)
	end
end

function CommandStationMapViewContainer:_onResLoadFinish(multiAbLoader)
	self.viewGO = CommandStationMapModel.instance:getPreloadView()

	if not self.viewGO then
		local uiLayerGO = ViewMgr.instance:getUILayer(self._viewSetting.layer)
		local assetItem = self._abLoader:getAssetItem(self._viewSetting.mainRes)
		local mainPrefab = assetItem:GetResource(self._viewSetting.mainRes)

		self.viewGO = gohelper.clone(mainPrefab, uiLayerGO, self.viewName)
	else
		CommandStationMapModel.instance:setPreloadView(nil)
		recthelper.setAnchor(self.viewGO.transform, 0, 0)
		gohelper.setAsLastSibling(self.viewGO)
	end

	self._views = self:buildViews()

	if self._views then
		for _, item in ipairs(self._views) do
			if isTypeOf(item, TabViewGroup) then
				self._tabViews = self._tabViews or {}
				self._tabViews[item:getTabContainerId()] = item
			end

			item:tryCallMethodName("__onInit")

			item.viewGO = self.viewGO
			item.viewContainer = self
			item.viewName = self.viewName

			item:onInitViewInternal()
			item:addEventsInternal()
		end
	end

	self:onContainerInit()

	BaseViewContainer.ViewLoadingCount = BaseViewContainer.ViewLoadingCount - 1

	if BaseViewContainer.ViewLoadingCount <= 0 then
		UIBlockMgr.instance:endBlock(UIBlockKey.ViewOpening)
	end

	self:_reallyOpen()
end

return CommandStationMapViewContainer
