-- chunkname: @modules/logic/season/view3_0/Season3_0EquipViewContainer.lua

module("modules.logic.season.view3_0.Season3_0EquipViewContainer", package.seeall)

local Season3_0EquipViewContainer = class("Season3_0EquipViewContainer", BaseViewContainer)

function Season3_0EquipViewContainer:buildViews()
	local scrollParam = self:createEquipItemsParam()
	local filterView = Season3_0EquipTagSelect.New()

	filterView:init(Activity104EquipController.instance, "right/#drop_filter")

	return {
		Season3_0EquipView.New(),
		Season3_0EquipSpineView.New(),
		filterView,
		LuaListScrollView.New(Activity104EquipItemListModel.instance, scrollParam),
		TabViewGroup.New(1, "#go_btn")
	}
end

function Season3_0EquipViewContainer:createEquipItemsParam()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "right/#scroll_card"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = Season3_0EquipItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = Season3_0EquipItem.ColumnCount
	scrollParam.cellWidth = 170
	scrollParam.cellHeight = 235
	scrollParam.cellSpaceH = 8.4
	scrollParam.cellSpaceV = 0
	scrollParam.frameUpdateMs = 100
	scrollParam.minUpdateCountInFrame = Season3_0EquipItem.ColumnCount

	return scrollParam
end

function Season3_0EquipViewContainer:buildTabViews(tabContainerId)
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

Season3_0EquipViewContainer.Close_Anim_Time = 0.2

function Season3_0EquipViewContainer:playCloseTransition()
	UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")

	local animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	animator:Play("close", 0, 0)
	TaskDispatcher.runDelay(self.delayOnPlayCloseAnim, self, Season3_0EquipViewContainer.Close_Anim_Time)
end

function Season3_0EquipViewContainer:delayOnPlayCloseAnim()
	UnityEngine.Shader.DisableKeyword("_CLIPALPHA_ON")
	self:onPlayCloseTransitionFinish()
end

return Season3_0EquipViewContainer
