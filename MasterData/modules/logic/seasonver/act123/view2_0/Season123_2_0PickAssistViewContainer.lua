-- chunkname: @modules/logic/seasonver/act123/view2_0/Season123_2_0PickAssistViewContainer.lua

module("modules.logic.seasonver.act123.view2_0.Season123_2_0PickAssistViewContainer", package.seeall)

local Season123_2_0PickAssistViewContainer = class("Season123_2_0PickAssistViewContainer", BaseViewContainer)

function Season123_2_0PickAssistViewContainer:buildViews()
	self.viewOpenAnimTime = 0.4
	self.scrollView = self:instantiateListScrollView()

	return {
		Season123_2_0PickAssistView.New(),
		self.scrollView,
		TabViewGroup.New(1, "#go_lefttopbtns")
	}
end

function Season123_2_0PickAssistViewContainer:instantiateListScrollView()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_selection"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = Season123_2_0PickAssistItem
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

function Season123_2_0PickAssistViewContainer:buildTabViews(tabContainerId)
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

return Season123_2_0PickAssistViewContainer
