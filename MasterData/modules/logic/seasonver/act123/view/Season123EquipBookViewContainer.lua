-- chunkname: @modules/logic/seasonver/act123/view/Season123EquipBookViewContainer.lua

module("modules.logic.seasonver.act123.view.Season123EquipBookViewContainer", package.seeall)

local Season123EquipBookViewContainer = class("Season123EquipBookViewContainer", BaseViewContainer)

function Season123EquipBookViewContainer:buildViews()
	self:createEquipItemsParam()

	local touchView = Season123EquipFloatTouch.New()

	touchView:init("left/#go_target/#go_ctrl", "left/#go_target/#go_touch")

	local filterView = Season123EquipTagSelect.New()

	filterView:init(Season123EquipBookController.instance, "right/#drop_filter")

	return {
		Season123EquipBookView.New(),
		touchView,
		filterView,
		self.scrollView,
		TabViewGroup.New(1, "#go_btns"),
		TabViewGroup.New(2, "right/#go_righttop")
	}
end

function Season123EquipBookViewContainer:createEquipItemsParam()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "right/mask/#scroll_cardlist"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = Season123EquipBookItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = Season123EquipBookItem.ColumnCount
	scrollParam.cellWidth = 170
	scrollParam.cellHeight = 235
	scrollParam.cellSpaceH = 8.2
	scrollParam.cellSpaceV = 1.74
	scrollParam.frameUpdateMs = 100
	scrollParam.minUpdateCountInFrame = Season123EquipBookItem.ColumnCount
	self.scrollView = LuaListScrollView.New(Season123EquipBookModel.instance, scrollParam)
end

function Season123EquipBookViewContainer:buildTabViews(tabContainerId)
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

	if tabContainerId == 2 then
		local actId = Season123Model.instance:getCurSeasonId()
		local currencyview = CurrencyView.New({
			Season123Config.instance:getEquipItemCoin(actId, Activity123Enum.Const.EquipItemCoin)
		})

		currencyview.foreHideBtn = true

		return {
			currencyview
		}
	end
end

function Season123EquipBookViewContainer:playCloseTransition()
	local animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.viewGO)

	animatorPlayer:Play(UIAnimationName.Close, self.onCloseAnimDone, self)
end

function Season123EquipBookViewContainer:onCloseAnimDone()
	self:onPlayCloseTransitionFinish()
end

return Season123EquipBookViewContainer
