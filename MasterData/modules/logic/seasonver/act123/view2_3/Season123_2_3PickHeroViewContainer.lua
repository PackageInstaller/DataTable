-- chunkname: @modules/logic/seasonver/act123/view2_3/Season123_2_3PickHeroViewContainer.lua

module("modules.logic.seasonver.act123.view2_3.Season123_2_3PickHeroViewContainer", package.seeall)

local Season123_2_3PickHeroViewContainer = class("Season123_2_3PickHeroViewContainer", BaseViewContainer)

function Season123_2_3PickHeroViewContainer:buildViews()
	return {
		Season123_2_3CheckCloseView.New(),
		Season123_2_3PickHeroView.New(),
		self:getScrollView(),
		Season123_2_3PickHeroDetailView.New(),
		TabViewGroup.New(1, "#go_btns")
	}
end

function Season123_2_3PickHeroViewContainer:getScrollView()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#go_rolecontainer/#scroll_quickedit"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = Season123_2_3PickHeroItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 5
	scrollParam.cellWidth = 200
	scrollParam.cellHeight = 440
	scrollParam.cellSpaceH = 12
	scrollParam.cellSpaceV = 10
	scrollParam.startSpace = 37

	local animationDelayTimes = {}

	for i = 1, 15 do
		animationDelayTimes[i] = math.ceil((i - 1) % 5) * 0.03
	end

	return LuaListScrollViewWithAnimator.New(Season123PickHeroModel.instance, scrollParam, animationDelayTimes)
end

function Season123_2_3PickHeroViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self._navigateButtonView
		}
	end
end

return Season123_2_3PickHeroViewContainer
