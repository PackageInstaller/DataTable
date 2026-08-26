-- chunkname: @modules/logic/season/view1_3/Season1_3EquipComposeViewContainer.lua

module("modules.logic.season.view1_3.Season1_3EquipComposeViewContainer", package.seeall)

local Season1_3EquipComposeViewContainer = class("Season1_3EquipComposeViewContainer", BaseViewContainer)

function Season1_3EquipComposeViewContainer:buildViews()
	local scrollParam = self:createEquipItemsParam()
	local filterView = Season1_3EquipTagSelect.New()

	filterView:init(Activity104EquipComposeController.instance, "left/#drop_filter")

	return {
		Season1_3EquipComposeView.New(),
		filterView,
		LuaListScrollView.New(Activity104EquipItemComposeModel.instance, scrollParam),
		TabViewGroup.New(1, "#go_btns")
	}
end

function Season1_3EquipComposeViewContainer:createEquipItemsParam()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "left/mask/#scroll_cardlist"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = Season1_3EquipComposeItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = Season1_3EquipComposeItem.ColumnCount
	scrollParam.cellWidth = 170
	scrollParam.cellHeight = 235
	scrollParam.cellSpaceH = 8.48
	scrollParam.cellSpaceV = 1
	scrollParam.frameUpdateMs = 100
	scrollParam.minUpdateCountInFrame = Season1_3EquipComposeItem.ColumnCount

	return scrollParam
end

function Season1_3EquipComposeViewContainer:buildTabViews(tabContainerId)
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

function Season1_3EquipComposeViewContainer:playCloseTransition()
	local animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	animator:Play("close", 0, 0)
	TaskDispatcher.runDelay(self.delayOnPlayCloseAnim, self, 0.2)
end

function Season1_3EquipComposeViewContainer:delayOnPlayCloseAnim()
	self:onPlayCloseTransitionFinish()
end

return Season1_3EquipComposeViewContainer
