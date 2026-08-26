-- chunkname: @modules/logic/seasonver/act123/view2_1/Season123_2_1EquipHeroViewContainer.lua

module("modules.logic.seasonver.act123.view2_1.Season123_2_1EquipHeroViewContainer", package.seeall)

local Season123_2_1EquipHeroViewContainer = class("Season123_2_1EquipHeroViewContainer", BaseViewContainer)

function Season123_2_1EquipHeroViewContainer:buildViews()
	local scrollParam = self:createEquipItemsParam()
	local filterView = Season123_2_1EquipTagSelect.New()

	filterView:init(Season123EquipHeroController.instance, "#go_normal/right/#drop_filter")

	return {
		Season123_2_1EquipHeroView.New(),
		Season123_2_1EquipHeroSpineView.New(),
		filterView,
		LuaListScrollView.New(Season123EquipHeroItemListModel.instance, scrollParam),
		TabViewGroup.New(1, "#go_btn")
	}
end

Season123_2_1EquipHeroViewContainer.ColumnCount = 5

function Season123_2_1EquipHeroViewContainer:createEquipItemsParam()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#go_normal/right/#scroll_card"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = Season123_2_1EquipHeroItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = Season123_2_1EquipHeroViewContainer.ColumnCount
	scrollParam.cellWidth = 170
	scrollParam.cellHeight = 235
	scrollParam.cellSpaceH = 9.2
	scrollParam.cellSpaceV = 2.18
	scrollParam.frameUpdateMs = 100
	scrollParam.minUpdateCountInFrame = Season123_2_1EquipHeroViewContainer.ColumnCount

	return scrollParam
end

function Season123_2_1EquipHeroViewContainer:buildTabViews(tabContainerId)
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

Season123_2_1EquipHeroViewContainer.Close_Anim_Time = 0.17

function Season123_2_1EquipHeroViewContainer:playCloseTransition()
	UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")

	local animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	animator:Play("close", 0, 0)
	TaskDispatcher.runDelay(self.delayOnPlayCloseAnim, self, Season123_2_1EquipHeroViewContainer.Close_Anim_Time)
end

function Season123_2_1EquipHeroViewContainer:delayOnPlayCloseAnim()
	UnityEngine.Shader.DisableKeyword("_CLIPALPHA_ON")
	self:onPlayCloseTransitionFinish()
end

return Season123_2_1EquipHeroViewContainer
