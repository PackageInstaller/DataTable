-- chunkname: @modules/logic/sp01/odyssey/view/OdysseyDungeonViewContainer.lua

module("modules.logic.sp01.odyssey.view.OdysseyDungeonViewContainer", package.seeall)

local OdysseyDungeonViewContainer = class("OdysseyDungeonViewContainer", BaseViewContainer)

function OdysseyDungeonViewContainer:buildViews()
	self.odysseyDungeonSceneElements = OdysseyDungeonSceneElements.New()
	self.odysseyDungeonView = OdysseyDungeonView.New()
	self.odysseyDungeonSceneView = OdysseyDungeonSceneView.New()
	self.odysseyDungeonMapSelectView = OdysseyDungeonMapSelectView.New()

	return {
		self.odysseyDungeonSceneView,
		self.odysseyDungeonSceneElements,
		self.odysseyDungeonMapSelectView,
		self.odysseyDungeonView,
		TabViewGroup.New(1, "root/#go_topleft")
	}
end

function OdysseyDungeonViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			true
		}, HelpEnum.HelpId.OdysseyDungeon)

		return {
			self.navigateView
		}
	end
end

function OdysseyDungeonViewContainer:setOverrideCloseClick(overrideCloseFunc, overrideCloseObj)
	self.navigateView:setOverrideClose(overrideCloseFunc, overrideCloseObj)
end

function OdysseyDungeonViewContainer:getDungeonSceneView()
	return self.odysseyDungeonSceneView
end

function OdysseyDungeonViewContainer:getDungeonSceneElementsView()
	return self.odysseyDungeonSceneElements
end

function OdysseyDungeonViewContainer:getDungeonView()
	return self.odysseyDungeonView
end

function OdysseyDungeonViewContainer:getDungeonMapSelectView()
	return self.odysseyDungeonMapSelectView
end

function OdysseyDungeonViewContainer:getNavigateButtonsView()
	return self.navigateView
end

return OdysseyDungeonViewContainer
