-- chunkname: @modules/logic/season/view1_6/Season1_6EquipViewContainer.lua

module("modules.logic.season.view1_6.Season1_6EquipViewContainer", package.seeall)

local Season1_6EquipViewContainer = class("Season1_6EquipViewContainer", BaseViewContainer)

function Season1_6EquipViewContainer:buildViews()
	local scrollParam = self:createEquipItemsParam()
	local filterView = Season1_6EquipTagSelect.New()

	filterView:init(Activity104EquipController.instance, "right/#drop_filter")

	return {
		Season1_6EquipView.New(),
		Season1_6EquipSpineView.New(),
		filterView,
		LuaListScrollView.New(Activity104EquipItemListModel.instance, scrollParam),
		TabViewGroup.New(1, "#go_btn")
	}
end

function Season1_6EquipViewContainer:createEquipItemsParam()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "right/#scroll_card"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = Season1_6EquipItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = Season1_6EquipItem.ColumnCount
	scrollParam.cellWidth = 170
	scrollParam.cellHeight = 235
	scrollParam.cellSpaceH = 8.4
	scrollParam.cellSpaceV = 0
	scrollParam.frameUpdateMs = 100
	scrollParam.minUpdateCountInFrame = Season1_6EquipItem.ColumnCount

	return scrollParam
end

function Season1_6EquipViewContainer:buildTabViews(tabContainerId)
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

Season1_6EquipViewContainer.Close_Anim_Time = 0.2

function Season1_6EquipViewContainer:playCloseTransition()
	UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")

	local animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	animator:Play("close", 0, 0)
	TaskDispatcher.runDelay(self.delayOnPlayCloseAnim, self, Season1_6EquipViewContainer.Close_Anim_Time)
end

function Season1_6EquipViewContainer:delayOnPlayCloseAnim()
	UnityEngine.Shader.DisableKeyword("_CLIPALPHA_ON")
	self:onPlayCloseTransitionFinish()
end

return Season1_6EquipViewContainer
