-- chunkname: @modules/logic/seasonver/act123/view1_9/Season123_1_9PickAssistViewContainer.lua

module("modules.logic.seasonver.act123.view1_9.Season123_1_9PickAssistViewContainer", package.seeall)

local Season123_1_9PickAssistViewContainer = class("Season123_1_9PickAssistViewContainer", BaseViewContainer)

function Season123_1_9PickAssistViewContainer:buildViews()
	self.viewOpenAnimTime = 0.4
	self.scrollView = self:instantiateListScrollView()

	return {
		Season123_1_9PickAssistView.New(),
		self.scrollView,
		TabViewGroup.New(1, "#go_lefttopbtns")
	}
end

function Season123_1_9PickAssistViewContainer:instantiateListScrollView()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_selection"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = Season123_1_9PickAssistItem
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

function Season123_1_9PickAssistViewContainer:buildTabViews(tabContainerId)
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

return Season123_1_9PickAssistViewContainer
