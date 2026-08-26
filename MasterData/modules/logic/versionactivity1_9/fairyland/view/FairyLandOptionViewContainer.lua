-- chunkname: @modules/logic/versionactivity1_9/fairyland/view/FairyLandOptionViewContainer.lua

module("modules.logic.versionactivity1_9.fairyland.view.FairyLandOptionViewContainer", package.seeall)

local FairyLandOptionViewContainer = class("FairyLandOptionViewContainer", BaseViewContainer)

function FairyLandOptionViewContainer:buildViews()
	local views = {}

	table.insert(views, FairyLandOptionView.New())
	table.insert(views, TabViewGroup.New(1, "#go_LeftTop"))

	return views
end

function FairyLandOptionViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		self.navigateView:setOverrideClose(self.overrideCloseFunc, self)

		return {
			self.navigateView
		}
	end
end

function FairyLandOptionViewContainer:overrideCloseFunc()
	self:closeThis()
	ViewMgr.instance:closeView(ViewName.FairyLandView)
end

return FairyLandOptionViewContainer
