-- chunkname: @modules/logic/versionactivity2_8/activity2nd/view/Activity2ndCollectionPageViewContainer.lua

module("modules.logic.versionactivity2_8.activity2nd.view.Activity2ndCollectionPageViewContainer", package.seeall)

local Activity2ndCollectionPageViewContainer = class("Activity2ndCollectionPageViewContainer", BaseViewContainer)

function Activity2ndCollectionPageViewContainer:buildViews()
	local views = {}

	self._view = Activity2ndCollectionPageView.New()

	table.insert(views, self._view)
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))

	return views
end

function Activity2ndCollectionPageViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		self._navigateButtonView:setOverrideClose(self._overrideCloseFunc, self)

		return {
			self._navigateButtonView
		}
	end
end

function Activity2ndCollectionPageViewContainer:_overrideCloseFunc()
	if Activity2ndModel.instance:getShowTypeMechine() then
		Activity2ndModel.instance:changeShowTypeMechine()
		self._view:switchTyepMechine()
	else
		self:closeThis()
	end
end

return Activity2ndCollectionPageViewContainer
