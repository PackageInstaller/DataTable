-- chunkname: @modules/logic/versionactivity1_9/heroinvitation/view/HeroInvitationDungeonMapViewContainer.lua

module("modules.logic.versionactivity1_9.heroinvitation.view.HeroInvitationDungeonMapViewContainer", package.seeall)

local HeroInvitationDungeonMapViewContainer = class("HeroInvitationDungeonMapViewContainer", BaseViewContainer)

function HeroInvitationDungeonMapViewContainer:buildViews()
	local views = {}

	self.mapView = HeroInvitationDungeonMapView.New()
	self.mapSceneElements = HeroInvitationDungeonMapSceneElements.New()
	self.mapScene = HeroInvitationDungeonMapScene.New()

	table.insert(views, HeroInvitationDungeonMapHoleView.New())
	table.insert(views, self.mapView)
	table.insert(views, self.mapSceneElements)
	table.insert(views, self.mapScene)
	table.insert(views, DungeonMapElementReward.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function HeroInvitationDungeonMapViewContainer:getMapScene()
	return self.mapScene
end

function HeroInvitationDungeonMapViewContainer:buildTabViews(tabContainerId)
	self.navigateView = NavigateButtonsView.New({
		true,
		true,
		false
	})

	return {
		self.navigateView
	}
end

function HeroInvitationDungeonMapViewContainer:onUpdateParamInternal(viewParam)
	self.viewParam = viewParam

	self:onContainerUpdateParam()
	self:_setVisible(true)

	if self._views then
		for _, item in ipairs(self._views) do
			item.viewParam = viewParam

			item:onUpdateParamInternal()
		end
	end
end

function HeroInvitationDungeonMapViewContainer:setVisibleInternal(isVisible)
	HeroInvitationDungeonMapViewContainer.super.setVisibleInternal(self, isVisible)

	if ViewMgr.instance:isOpen(ViewName.StoryBackgroundView) then
		isVisible = true
	end

	if self.mapScene then
		self.mapScene:setSceneVisible(isVisible)
	end
end

return HeroInvitationDungeonMapViewContainer
