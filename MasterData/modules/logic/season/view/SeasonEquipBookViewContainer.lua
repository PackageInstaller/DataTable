-- chunkname: @modules/logic/season/view/SeasonEquipBookViewContainer.lua

module("modules.logic.season.view.SeasonEquipBookViewContainer", package.seeall)

local SeasonEquipBookViewContainer = class("SeasonEquipBookViewContainer", BaseViewContainer)

function SeasonEquipBookViewContainer:buildViews()
	local scrollParam = self:createEquipItemsParam()
	local touchView = SeasonEquipFloatTouch.New()

	touchView:init("left/#go_target/#go_ctrl", "left/#go_target/#go_touch")

	local filterView = SeasonEquipTagSelect.New()

	filterView:init(Activity104EquipBookController.instance, "right/#drop_filter")

	return {
		SeasonEquipBookView.New(),
		touchView,
		filterView,
		LuaListScrollView.New(Activity104EquipItemBookModel.instance, scrollParam),
		TabViewGroup.New(1, "#go_btns")
	}
end

function SeasonEquipBookViewContainer:createEquipItemsParam()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "right/mask/#scroll_cardlist"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = SeasonEquipBookItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = SeasonEquipBookItem.ColumnCount
	scrollParam.cellWidth = 170
	scrollParam.cellHeight = 235
	scrollParam.cellSpaceH = 8.2
	scrollParam.cellSpaceV = 1.74
	scrollParam.frameUpdateMs = 100
	scrollParam.minUpdateCountInFrame = SeasonEquipBookItem.ColumnCount

	return scrollParam
end

function SeasonEquipBookViewContainer:buildTabViews(tabContainerId)
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

function SeasonEquipBookViewContainer:playCloseTransition()
	local animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	animator:Play("close", 0, 0)
	TaskDispatcher.runDelay(self.delayOnPlayCloseAnim, self, 0.2)
end

function SeasonEquipBookViewContainer:delayOnPlayCloseAnim()
	self:onPlayCloseTransitionFinish()
end

return SeasonEquipBookViewContainer
