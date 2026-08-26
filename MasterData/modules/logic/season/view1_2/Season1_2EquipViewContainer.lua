-- chunkname: @modules/logic/season/view1_2/Season1_2EquipViewContainer.lua

module("modules.logic.season.view1_2.Season1_2EquipViewContainer", package.seeall)

local Season1_2EquipViewContainer = class("Season1_2EquipViewContainer", BaseViewContainer)

function Season1_2EquipViewContainer:buildViews()
	local scrollParam = self:createEquipItemsParam()
	local filterView = Season1_2EquipTagSelect.New()

	filterView:init(Activity104EquipController.instance, "right/#drop_filter")

	return {
		Season1_2EquipView.New(),
		Season1_2EquipSpineView.New(),
		filterView,
		LuaListScrollView.New(Activity104EquipItemListModel.instance, scrollParam),
		TabViewGroup.New(1, "#go_btn")
	}
end

function Season1_2EquipViewContainer:createEquipItemsParam()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "right/#scroll_card"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = Season1_2EquipItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = Season1_2EquipItem.ColumnCount
	scrollParam.cellWidth = 170
	scrollParam.cellHeight = 235
	scrollParam.cellSpaceH = 8.4
	scrollParam.cellSpaceV = 0
	scrollParam.frameUpdateMs = 100
	scrollParam.minUpdateCountInFrame = Season1_2EquipItem.ColumnCount

	return scrollParam
end

function Season1_2EquipViewContainer:buildTabViews(tabContainerId)
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

Season1_2EquipViewContainer.Close_Anim_Time = 0.2

function Season1_2EquipViewContainer:playCloseTransition()
	UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")

	local animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	animator:Play("close", 0, 0)
	TaskDispatcher.runDelay(self.delayOnPlayCloseAnim, self, Season1_2EquipViewContainer.Close_Anim_Time)
end

function Season1_2EquipViewContainer:delayOnPlayCloseAnim()
	UnityEngine.Shader.DisableKeyword("_CLIPALPHA_ON")
	self:onPlayCloseTransitionFinish()
end

return Season1_2EquipViewContainer
