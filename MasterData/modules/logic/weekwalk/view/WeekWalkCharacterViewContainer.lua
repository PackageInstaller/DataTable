-- chunkname: @modules/logic/weekwalk/view/WeekWalkCharacterViewContainer.lua

module("modules.logic.weekwalk.view.WeekWalkCharacterViewContainer", package.seeall)

local WeekWalkCharacterViewContainer = class("WeekWalkCharacterViewContainer", BaseViewContainer)

function WeekWalkCharacterViewContainer:buildViews()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#go_rolecontainer/#scroll_card"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = WeekWalkCharacterItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 5
	scrollParam.cellWidth = 300
	scrollParam.cellHeight = 600
	scrollParam.cellSpaceH = 35
	scrollParam.cellSpaceV = -30

	local cardAnimationDelayTimes = {}

	for i = 1, 10 do
		cardAnimationDelayTimes[i] = math.ceil((i - 1) % 5) * 0.06
	end

	self._cardScrollView = LuaListScrollViewWithAnimator.New(WeekWalkCardListModel.instance, scrollParam, cardAnimationDelayTimes)

	return {
		self._cardScrollView,
		WeekWalkCharacterView.New(),
		TabViewGroup.New(1, "#go_btns")
	}
end

function WeekWalkCharacterViewContainer:buildTabViews(tabContainerId)
	self.navigationView = NavigateButtonsView.New({
		true,
		true,
		false
	})

	return {
		self.navigationView
	}
end

function WeekWalkCharacterViewContainer:onContainerOpenFinish()
	self.navigationView:resetOnCloseViewAudio(AudioEnum.UI.Play_UI_Universal_Click)
end

function WeekWalkCharacterViewContainer:playCardOpenAnimation()
	if self._cardScrollView then
		self._cardScrollView:playOpenAnimation()
	end
end

return WeekWalkCharacterViewContainer
