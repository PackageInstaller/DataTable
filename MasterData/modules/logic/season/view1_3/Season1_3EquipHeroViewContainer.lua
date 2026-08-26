-- chunkname: @modules/logic/season/view1_3/Season1_3EquipHeroViewContainer.lua

module("modules.logic.season.view1_3.Season1_3EquipHeroViewContainer", package.seeall)

local Season1_3EquipHeroViewContainer = class("Season1_3EquipHeroViewContainer", BaseViewContainer)

function Season1_3EquipHeroViewContainer:buildViews()
	local scrollParam = self:createEquipItemsParam()
	local filterView = Season1_3EquipTagSelect.New()

	filterView:init(Activity104EquipController.instance, "#go_normal/right/#drop_filter")

	return {
		Season1_3EquipHeroView.New(),
		Season1_3EquipHeroSpineView.New(),
		filterView,
		LuaListScrollView.New(Activity104EquipItemListModel.instance, scrollParam),
		TabViewGroup.New(1, "#go_btn")
	}
end

Season1_3EquipHeroViewContainer.ColumnCount = 5

function Season1_3EquipHeroViewContainer:createEquipItemsParam()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#go_normal/right/#scroll_card"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = Season1_3EquipItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = Season1_3EquipHeroViewContainer.ColumnCount
	scrollParam.cellWidth = 170
	scrollParam.cellHeight = 235
	scrollParam.cellSpaceH = 9.2
	scrollParam.cellSpaceV = 2.18
	scrollParam.frameUpdateMs = 100
	scrollParam.minUpdateCountInFrame = Season1_3EquipHeroViewContainer.ColumnCount

	return scrollParam
end

function Season1_3EquipHeroViewContainer:buildTabViews(tabContainerId)
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

Season1_3EquipHeroViewContainer.Close_Anim_Time = 0.17

function Season1_3EquipHeroViewContainer:playCloseTransition()
	UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")

	local animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	animator:Play("close", 0, 0)
	TaskDispatcher.runDelay(self.delayOnPlayCloseAnim, self, Season1_3EquipHeroViewContainer.Close_Anim_Time)
end

function Season1_3EquipHeroViewContainer:delayOnPlayCloseAnim()
	UnityEngine.Shader.DisableKeyword("_CLIPALPHA_ON")
	self:onPlayCloseTransitionFinish()
end

return Season1_3EquipHeroViewContainer
