-- chunkname: @modules/logic/season/view3_0/Season3_0EquipComposeViewContainer.lua

module("modules.logic.season.view3_0.Season3_0EquipComposeViewContainer", package.seeall)

local Season3_0EquipComposeViewContainer = class("Season3_0EquipComposeViewContainer", BaseViewContainer)

function Season3_0EquipComposeViewContainer:buildViews()
	local scrollParam = self:createEquipItemsParam()
	local filterView = Season3_0EquipTagSelect2.New()

	filterView:init(Activity104EquipComposeController.instance, "left/#drop_filter", "left/#drop_filter2")

	return {
		Season3_0EquipComposeView.New(),
		filterView,
		LuaListScrollView.New(Activity104EquipItemComposeModel.instance, scrollParam),
		TabViewGroup.New(1, "#go_btns")
	}
end

function Season3_0EquipComposeViewContainer:createEquipItemsParam()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "left/mask/#scroll_cardlist"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = Season3_0EquipComposeItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = Season3_0EquipComposeItem.ColumnCount
	scrollParam.cellWidth = 170
	scrollParam.cellHeight = 235
	scrollParam.cellSpaceH = 8.48
	scrollParam.cellSpaceV = 1
	scrollParam.frameUpdateMs = 100
	scrollParam.minUpdateCountInFrame = Season3_0EquipComposeItem.ColumnCount

	return scrollParam
end

function Season3_0EquipComposeViewContainer:buildTabViews(tabContainerId)
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

function Season3_0EquipComposeViewContainer:playCloseTransition()
	local animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	animator:Play("close", 0, 0)
	TaskDispatcher.runDelay(self.delayOnPlayCloseAnim, self, 0.2)
end

function Season3_0EquipComposeViewContainer:delayOnPlayCloseAnim()
	self:onPlayCloseTransitionFinish()
end

return Season3_0EquipComposeViewContainer
