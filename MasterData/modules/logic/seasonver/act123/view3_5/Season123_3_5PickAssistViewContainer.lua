-- chunkname: @modules/logic/seasonver/act123/view3_5/Season123_3_5PickAssistViewContainer.lua

module("modules.logic.seasonver.act123.view3_5.Season123_3_5PickAssistViewContainer", package.seeall)

local Season123_3_5PickAssistViewContainer = class("Season123_3_5PickAssistViewContainer", BaseViewContainer)

function Season123_3_5PickAssistViewContainer:buildViews()
	self.viewOpenAnimTime = 0.4
	self.scrollView = self:instantiateListScrollView()

	return {
		Season123_3_5PickAssistView.New(),
		self.scrollView,
		TabViewGroup.New(1, "#go_lefttopbtns")
	}
end

function Season123_3_5PickAssistViewContainer:instantiateListScrollView()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_selection"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = Season123_3_5PickAssistItem
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

function Season123_3_5PickAssistViewContainer:buildTabViews(tabContainerId)
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

return Season123_3_5PickAssistViewContainer
