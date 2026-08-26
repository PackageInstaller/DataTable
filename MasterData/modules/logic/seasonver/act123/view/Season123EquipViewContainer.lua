-- chunkname: @modules/logic/seasonver/act123/view/Season123EquipViewContainer.lua

module("modules.logic.seasonver.act123.view.Season123EquipViewContainer", package.seeall)

local Season123EquipViewContainer = class("Season123EquipViewContainer", BaseViewContainer)

function Season123EquipViewContainer:buildViews()
	local scrollParam = self:createEquipItemsParam()
	local filterView = Season123EquipTagSelect.New()

	filterView:init(Season123EquipController.instance, "right/#drop_filter")

	return {
		Season123EquipView.New(),
		Season123EquipSpineView.New(),
		filterView,
		LuaListScrollView.New(Season123EquipItemListModel.instance, scrollParam),
		TabViewGroup.New(1, "#go_btn")
	}
end

function Season123EquipViewContainer:createEquipItemsParam()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "right/#scroll_card"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = Season123EquipItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = Season123EquipItem.ColumnCount
	scrollParam.cellWidth = 170
	scrollParam.cellHeight = 235
	scrollParam.cellSpaceH = 8.4
	scrollParam.cellSpaceV = 0
	scrollParam.frameUpdateMs = 100
	scrollParam.minUpdateCountInFrame = Season123EquipItem.ColumnCount

	return scrollParam
end

function Season123EquipViewContainer:buildTabViews(tabContainerId)
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

Season123EquipViewContainer.Close_Anim_Time = 0.2

function Season123EquipViewContainer:playCloseTransition()
	UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")

	local animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	animator:Play("close", 0, 0)
	TaskDispatcher.runDelay(self.delayOnPlayCloseAnim, self, Season123EquipViewContainer.Close_Anim_Time)
end

function Season123EquipViewContainer:delayOnPlayCloseAnim()
	UnityEngine.Shader.DisableKeyword("_CLIPALPHA_ON")
	self:onPlayCloseTransitionFinish()
end

return Season123EquipViewContainer
