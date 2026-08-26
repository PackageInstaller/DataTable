-- chunkname: @modules/logic/season/view1_6/Season1_6EquipHeroViewContainer.lua

module("modules.logic.season.view1_6.Season1_6EquipHeroViewContainer", package.seeall)

local Season1_6EquipHeroViewContainer = class("Season1_6EquipHeroViewContainer", BaseViewContainer)

function Season1_6EquipHeroViewContainer:buildViews()
	local scrollParam = self:createEquipItemsParam()
	local filterView = Season1_6EquipTagSelect.New()

	filterView:init(Activity104EquipController.instance, "#go_normal/right/#drop_filter")

	return {
		Season1_6EquipHeroView.New(),
		Season1_6EquipHeroSpineView.New(),
		filterView,
		LuaListScrollView.New(Activity104EquipItemListModel.instance, scrollParam),
		TabViewGroup.New(1, "#go_btn")
	}
end

Season1_6EquipHeroViewContainer.ColumnCount = 5

function Season1_6EquipHeroViewContainer:createEquipItemsParam()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#go_normal/right/#scroll_card"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = Season1_6EquipItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = Season1_6EquipHeroViewContainer.ColumnCount
	scrollParam.cellWidth = 170
	scrollParam.cellHeight = 235
	scrollParam.cellSpaceH = 9.2
	scrollParam.cellSpaceV = 2.18
	scrollParam.frameUpdateMs = 100
	scrollParam.minUpdateCountInFrame = Season1_6EquipHeroViewContainer.ColumnCount

	return scrollParam
end

function Season1_6EquipHeroViewContainer:buildTabViews(tabContainerId)
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

Season1_6EquipHeroViewContainer.Close_Anim_Time = 0.17

function Season1_6EquipHeroViewContainer:playCloseTransition()
	UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")

	local animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	animator:Play("close", 0, 0)
	TaskDispatcher.runDelay(self.delayOnPlayCloseAnim, self, Season1_6EquipHeroViewContainer.Close_Anim_Time)
end

function Season1_6EquipHeroViewContainer:delayOnPlayCloseAnim()
	UnityEngine.Shader.DisableKeyword("_CLIPALPHA_ON")
	self:onPlayCloseTransitionFinish()
end

return Season1_6EquipHeroViewContainer
