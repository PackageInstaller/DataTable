-- chunkname: @modules/logic/season/view/SeasonEquipViewContainer.lua

module("modules.logic.season.view.SeasonEquipViewContainer", package.seeall)

local SeasonEquipViewContainer = class("SeasonEquipViewContainer", BaseViewContainer)

function SeasonEquipViewContainer:buildViews()
	local scrollParam = self:createEquipItemsParam()
	local filterView = SeasonEquipTagSelect.New()

	filterView:init(Activity104EquipController.instance, "right/#drop_filter")

	return {
		SeasonEquipView.New(),
		SeasonEquipSpineView.New(),
		filterView,
		LuaListScrollView.New(Activity104EquipItemListModel.instance, scrollParam),
		TabViewGroup.New(1, "#go_btn")
	}
end

function SeasonEquipViewContainer:createEquipItemsParam()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "right/#scroll_card"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = SeasonEquipItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = SeasonEquipItem.ColumnCount
	scrollParam.cellWidth = 170
	scrollParam.cellHeight = 235
	scrollParam.cellSpaceH = 8.4
	scrollParam.cellSpaceV = 0
	scrollParam.frameUpdateMs = 100
	scrollParam.minUpdateCountInFrame = SeasonEquipItem.ColumnCount

	return scrollParam
end

function SeasonEquipViewContainer:buildTabViews(tabContainerId)
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

SeasonEquipViewContainer.Close_Anim_Time = 0.2

function SeasonEquipViewContainer:playCloseTransition()
	UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")

	local animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	animator:Play("close", 0, 0)
	TaskDispatcher.runDelay(self.delayOnPlayCloseAnim, self, SeasonEquipViewContainer.Close_Anim_Time)
end

function SeasonEquipViewContainer:delayOnPlayCloseAnim()
	UnityEngine.Shader.DisableKeyword("_CLIPALPHA_ON")
	self:onPlayCloseTransitionFinish()
end

return SeasonEquipViewContainer
