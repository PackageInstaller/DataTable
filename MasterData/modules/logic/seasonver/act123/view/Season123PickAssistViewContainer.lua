-- chunkname: @modules/logic/seasonver/act123/view/Season123PickAssistViewContainer.lua

module("modules.logic.seasonver.act123.view.Season123PickAssistViewContainer", package.seeall)

local Season123PickAssistViewContainer = class("Season123PickAssistViewContainer", BaseViewContainer)

function Season123PickAssistViewContainer:buildViews()
	self.viewOpenAnimTime = 0.4
	self.scrollView = self:instantiateListScrollView()

	return {
		Season123PickAssistView.New(),
		self.scrollView,
		TabViewGroup.New(1, "#go_lefttopbtns")
	}
end

function Season123PickAssistViewContainer:instantiateListScrollView()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_selection"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = Season123PickAssistItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 6
	scrollParam.cellWidth = 296
	scrollParam.cellHeight = 636

	local animationDelayTimes = {}

	for i = 1, 15 do
		animationDelayTimes[i] = math.ceil((i - 1) % 6) * 0.03 + self.viewOpenAnimTime
	end

	return LuaListScrollViewWithAnimator.New(Season123PickAssistListModel.instance, scrollParam, animationDelayTimes)
end

function Season123PickAssistViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			self._navigateButtonView
		}
	end
end

return Season123PickAssistViewContainer
