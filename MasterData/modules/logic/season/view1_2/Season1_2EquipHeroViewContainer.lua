-- chunkname: @modules/logic/season/view1_2/Season1_2EquipHeroViewContainer.lua

module("modules.logic.season.view1_2.Season1_2EquipHeroViewContainer", package.seeall)

local Season1_2EquipHeroViewContainer = class("Season1_2EquipHeroViewContainer", BaseViewContainer)

function Season1_2EquipHeroViewContainer:buildViews()
	local scrollParam = self:createEquipItemsParam()
	local filterView = Season1_2EquipTagSelect.New()

	filterView:init(Activity104EquipController.instance, "#go_normal/right/#drop_filter")

	return {
		Season1_2EquipHeroView.New(),
		Season1_2EquipHeroSpineView.New(),
		filterView,
		LuaListScrollView.New(Activity104EquipItemListModel.instance, scrollParam),
		TabViewGroup.New(1, "#go_btn")
	}
end

Season1_2EquipHeroViewContainer.ColumnCount = 5

function Season1_2EquipHeroViewContainer:createEquipItemsParam()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#go_normal/right/#scroll_card"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = Season1_2EquipItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = Season1_2EquipHeroViewContainer.ColumnCount
	scrollParam.cellWidth = 170
	scrollParam.cellHeight = 235
	scrollParam.cellSpaceH = 9.2
	scrollParam.cellSpaceV = 2.18
	scrollParam.frameUpdateMs = 100
	scrollParam.minUpdateCountInFrame = Season1_2EquipHeroViewContainer.ColumnCount

	return scrollParam
end

function Season1_2EquipHeroViewContainer:buildTabViews(tabContainerId)
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

Season1_2EquipHeroViewContainer.Close_Anim_Time = 0.17

function Season1_2EquipHeroViewContainer:playCloseTransition()
	UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")

	local animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	animator:Play("close", 0, 0)
	TaskDispatcher.runDelay(self.delayOnPlayCloseAnim, self, Season1_2EquipHeroViewContainer.Close_Anim_Time)
end

function Season1_2EquipHeroViewContainer:delayOnPlayCloseAnim()
	UnityEngine.Shader.DisableKeyword("_CLIPALPHA_ON")
	self:onPlayCloseTransitionFinish()
end

return Season1_2EquipHeroViewContainer
