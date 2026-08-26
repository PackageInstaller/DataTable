-- chunkname: @modules/logic/season/view/SeasonEquipComposeViewContainer.lua

module("modules.logic.season.view.SeasonEquipComposeViewContainer", package.seeall)

local SeasonEquipComposeViewContainer = class("SeasonEquipComposeViewContainer", BaseViewContainer)

function SeasonEquipComposeViewContainer:buildViews()
	local scrollParam = self:createEquipItemsParam()
	local filterView = SeasonEquipTagSelect.New()

	filterView:init(Activity104EquipComposeController.instance, "left/#drop_filter")

	return {
		SeasonEquipComposeView.New(),
		filterView,
		LuaListScrollView.New(Activity104EquipItemComposeModel.instance, scrollParam),
		TabViewGroup.New(1, "#go_btns")
	}
end

function SeasonEquipComposeViewContainer:createEquipItemsParam()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "left/mask/#scroll_cardlist"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = SeasonEquipComposeItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = SeasonEquipComposeItem.ColumnCount
	scrollParam.cellWidth = 170
	scrollParam.cellHeight = 235
	scrollParam.cellSpaceH = 8.48
	scrollParam.cellSpaceV = 1
	scrollParam.frameUpdateMs = 100
	scrollParam.minUpdateCountInFrame = SeasonEquipComposeItem.ColumnCount

	return scrollParam
end

function SeasonEquipComposeViewContainer:buildTabViews(tabContainerId)
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

function SeasonEquipComposeViewContainer:playCloseTransition()
	local animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	animator:Play("close", 0, 0)
	TaskDispatcher.runDelay(self.delayOnPlayCloseAnim, self, 0.2)
end

function SeasonEquipComposeViewContainer:delayOnPlayCloseAnim()
	self:onPlayCloseTransitionFinish()
end

return SeasonEquipComposeViewContainer
