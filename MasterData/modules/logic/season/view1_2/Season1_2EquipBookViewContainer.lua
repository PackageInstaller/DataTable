-- chunkname: @modules/logic/season/view1_2/Season1_2EquipBookViewContainer.lua

module("modules.logic.season.view1_2.Season1_2EquipBookViewContainer", package.seeall)

local Season1_2EquipBookViewContainer = class("Season1_2EquipBookViewContainer", BaseViewContainer)

function Season1_2EquipBookViewContainer:buildViews()
	local scrollParam = self:createEquipItemsParam()
	local touchView = Season1_2EquipFloatTouch.New()

	touchView:init("left/#go_target/#go_ctrl", "left/#go_target/#go_touch")

	local filterView = Season1_2EquipTagSelect.New()

	filterView:init(Activity104EquipBookController.instance, "right/#drop_filter")

	return {
		Season1_2EquipBookView.New(),
		touchView,
		filterView,
		LuaListScrollView.New(Activity104EquipItemBookModel.instance, scrollParam),
		TabViewGroup.New(1, "#go_btns")
	}
end

function Season1_2EquipBookViewContainer:createEquipItemsParam()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "right/mask/#scroll_cardlist"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = Season1_2EquipBookItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = Season1_2EquipBookItem.ColumnCount
	scrollParam.cellWidth = 170
	scrollParam.cellHeight = 235
	scrollParam.cellSpaceH = 8.2
	scrollParam.cellSpaceV = 1.74
	scrollParam.frameUpdateMs = 100
	scrollParam.minUpdateCountInFrame = Season1_2EquipBookItem.ColumnCount

	return scrollParam
end

function Season1_2EquipBookViewContainer:buildTabViews(tabContainerId)
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

function Season1_2EquipBookViewContainer:playCloseTransition()
	local animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	animator:Play("close", 0, 0)
	TaskDispatcher.runDelay(self.delayOnPlayCloseAnim, self, 0.2)
end

function Season1_2EquipBookViewContainer:delayOnPlayCloseAnim()
	self:onPlayCloseTransitionFinish()
end

return Season1_2EquipBookViewContainer
