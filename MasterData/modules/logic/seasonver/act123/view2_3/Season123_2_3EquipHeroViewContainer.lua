-- chunkname: @modules/logic/seasonver/act123/view2_3/Season123_2_3EquipHeroViewContainer.lua

module("modules.logic.seasonver.act123.view2_3.Season123_2_3EquipHeroViewContainer", package.seeall)

local Season123_2_3EquipHeroViewContainer = class("Season123_2_3EquipHeroViewContainer", BaseViewContainer)

function Season123_2_3EquipHeroViewContainer:buildViews()
	local scrollParam = self:createEquipItemsParam()
	local filterView = Season123_2_3EquipTagSelect.New()

	filterView:init(Season123EquipHeroController.instance, "#go_normal/right/#drop_filter")

	return {
		Season123_2_3EquipHeroView.New(),
		Season123_2_3EquipHeroSpineView.New(),
		filterView,
		LuaListScrollView.New(Season123EquipHeroItemListModel.instance, scrollParam),
		TabViewGroup.New(1, "#go_btn")
	}
end

Season123_2_3EquipHeroViewContainer.ColumnCount = 5

function Season123_2_3EquipHeroViewContainer:createEquipItemsParam()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#go_normal/right/#scroll_card"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = Season123_2_3EquipHeroItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = Season123_2_3EquipHeroViewContainer.ColumnCount
	scrollParam.cellWidth = 170
	scrollParam.cellHeight = 235
	scrollParam.cellSpaceH = 9.2
	scrollParam.cellSpaceV = 2.18
	scrollParam.frameUpdateMs = 100
	scrollParam.minUpdateCountInFrame = Season123_2_3EquipHeroViewContainer.ColumnCount

	return scrollParam
end

function Season123_2_3EquipHeroViewContainer:buildTabViews(tabContainerId)
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

Season123_2_3EquipHeroViewContainer.Close_Anim_Time = 0.17

function Season123_2_3EquipHeroViewContainer:playCloseTransition()
	UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")

	local animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	animator:Play("close", 0, 0)
	TaskDispatcher.runDelay(self.delayOnPlayCloseAnim, self, Season123_2_3EquipHeroViewContainer.Close_Anim_Time)
end

function Season123_2_3EquipHeroViewContainer:delayOnPlayCloseAnim()
	UnityEngine.Shader.DisableKeyword("_CLIPALPHA_ON")
	self:onPlayCloseTransitionFinish()
end

return Season123_2_3EquipHeroViewContainer
