-- chunkname: @modules/logic/versionactivity1_9/fairyland/view/FairyLandViewContainer.lua

module("modules.logic.versionactivity1_9.fairyland.view.FairyLandViewContainer", package.seeall)

local FairyLandViewContainer = class("FairyLandViewContainer", BaseViewContainer)

function FairyLandViewContainer:buildViews()
	local views = {}

	table.insert(views, FairyLandPuzzles.New())
	table.insert(views, FairyLandView.New())

	self.elements = FairyLandElements.New()

	table.insert(views, self.elements)
	table.insert(views, FairyLandStairs.New())

	self.scene = FairyLandScene.New()

	table.insert(views, self.scene)
	table.insert(views, FairyLandDialogView.New())
	table.insert(views, TabViewGroup.New(1, "#go_LeftTop"))

	return views
end

function FairyLandViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self.navigateView
		}
	end
end

function FairyLandViewContainer:getElement(type)
	if self.elements then
		return self.elements:getElementByType(type)
	end
end

function FairyLandViewContainer:_setVisible(isVisible)
	FairyLandViewContainer.super._setVisible(self, isVisible)

	if self.scene then
		self.scene:setSceneVisible(isVisible)
	end
end

return FairyLandViewContainer
