-- chunkname: @modules/logic/seasonver/act123/view3_5/Season123_3_5EquipBookViewContainer.lua

module("modules.logic.seasonver.act123.view3_5.Season123_3_5EquipBookViewContainer", package.seeall)

local Season123_3_5EquipBookViewContainer = class("Season123_3_5EquipBookViewContainer", BaseViewContainer)

function Season123_3_5EquipBookViewContainer:buildViews()
	self:createEquipItemsParam()

	local touchView = Season123_3_5EquipFloatTouch.New()

	touchView:init("left/#go_target/#go_ctrl", "left/#go_target/#go_touch")

	return {
		Season123_3_5EquipBookView.New(),
		touchView,
		self.scrollView,
		TabViewGroup.New(1, "#go_btns")
	}
end

function Season123_3_5EquipBookViewContainer:createEquipItemsParam()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "right/mask/#scroll_cardlist"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = Season123_3_5EquipBookItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = Season123_3_5EquipBookItem.ColumnCount
	scrollParam.cellWidth = 170
	scrollParam.cellHeight = 235
	scrollParam.cellSpaceH = 8.2
	scrollParam.cellSpaceV = 1.74
	scrollParam.frameUpdateMs = 100
	scrollParam.minUpdateCountInFrame = Season123_3_5EquipBookItem.ColumnCount
	self.scrollView = LuaListScrollView.New(Season123EquipBookModel.instance, scrollParam)
end

function Season123_3_5EquipBookViewContainer:buildTabViews(tabContainerId)
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

function Season123_3_5EquipBookViewContainer:playCloseTransition()
	local animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.viewGO)

	animatorPlayer:Play(UIAnimationName.Close, self.onCloseAnimDone, self)
end

function Season123_3_5EquipBookViewContainer:onCloseAnimDone()
	self:onPlayCloseTransitionFinish()
end

return Season123_3_5EquipBookViewContainer
