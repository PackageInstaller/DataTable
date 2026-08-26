-- chunkname: @modules/logic/seasonver/act123/view2_1/Season123_2_1BatchDecomposeViewContainer.lua

module("modules.logic.seasonver.act123.view2_1.Season123_2_1BatchDecomposeViewContainer", package.seeall)

local Season123_2_1BatchDecomposeViewContainer = class("Season123_2_1BatchDecomposeViewContainer", BaseViewContainer)

function Season123_2_1BatchDecomposeViewContainer:buildViews()
	self:createEquipItemsParam()

	return {
		Season123_2_1BatchDecomposeView.New(),
		self.scrollView,
		TabViewGroup.New(1, "#go_lefttopbtns"),
		TabViewGroup.New(2, "#go_righttop")
	}
end

function Season123_2_1BatchDecomposeViewContainer:createEquipItemsParam()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "left_container/#go_scrollcontainer/#scroll_equip"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = Season123_2_1DecomposeItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = self:getLineCount()
	scrollParam.cellWidth = 170
	scrollParam.cellHeight = 235
	scrollParam.cellSpaceH = 8.48
	scrollParam.cellSpaceV = 1
	scrollParam.frameUpdateMs = 100
	scrollParam.minUpdateCountInFrame = SeasonEquipComposeItem.ColumnCount
	self.scrollView = LuaListScrollView.New(Season123DecomposeModel.instance, scrollParam)
end

function Season123_2_1BatchDecomposeViewContainer:buildTabViews(tabContainerId)
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

function Season123_2_1BatchDecomposeViewContainer:getLineCount()
	local contentTrans = gohelper.findChildComponent(self.viewGO, "left_container/#go_scrollcontainer", gohelper.Type_Transform)
	local contentWidth = recthelper.getWidth(contentTrans)

	return math.floor(contentWidth / 178.48)
end

function Season123_2_1BatchDecomposeViewContainer:playCloseTransition()
	local animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.viewGO)

	animatorPlayer:Play(UIAnimationName.Close, self.onCloseAnimDone, self)
end

function Season123_2_1BatchDecomposeViewContainer:onCloseAnimDone()
	self:onPlayCloseTransitionFinish()
end

return Season123_2_1BatchDecomposeViewContainer
