-- chunkname: @modules/logic/season/view1_5/Season1_5EquipComposeViewContainer.lua

module("modules.logic.season.view1_5.Season1_5EquipComposeViewContainer", package.seeall)

local Season1_5EquipComposeViewContainer = class("Season1_5EquipComposeViewContainer", BaseViewContainer)

function Season1_5EquipComposeViewContainer:buildViews()
	local scrollParam = self:createEquipItemsParam()
	local filterView = Season1_5EquipTagSelect.New()

	filterView:init(Activity104EquipComposeController.instance, "left/#drop_filter")

	return {
		Season1_5EquipComposeView.New(),
		filterView,
		LuaListScrollView.New(Activity104EquipItemComposeModel.instance, scrollParam),
		TabViewGroup.New(1, "#go_btns")
	}
end

function Season1_5EquipComposeViewContainer:createEquipItemsParam()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "left/mask/#scroll_cardlist"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = Season1_5EquipComposeItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = Season1_5EquipComposeItem.ColumnCount
	scrollParam.cellWidth = 170
	scrollParam.cellHeight = 235
	scrollParam.cellSpaceH = 8.48
	scrollParam.cellSpaceV = 1
	scrollParam.frameUpdateMs = 100
	scrollParam.minUpdateCountInFrame = Season1_5EquipComposeItem.ColumnCount

	return scrollParam
end

function Season1_5EquipComposeViewContainer:buildTabViews(tabContainerId)
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

function Season1_5EquipComposeViewContainer:playCloseTransition()
	local animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	animator:Play("close", 0, 0)
	TaskDispatcher.runDelay(self.delayOnPlayCloseAnim, self, 0.2)
end

function Season1_5EquipComposeViewContainer:delayOnPlayCloseAnim()
	self:onPlayCloseTransitionFinish()
end

return Season1_5EquipComposeViewContainer
