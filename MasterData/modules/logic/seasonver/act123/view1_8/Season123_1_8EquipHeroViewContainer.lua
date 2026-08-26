-- chunkname: @modules/logic/seasonver/act123/view1_8/Season123_1_8EquipHeroViewContainer.lua

module("modules.logic.seasonver.act123.view1_8.Season123_1_8EquipHeroViewContainer", package.seeall)

local Season123_1_8EquipHeroViewContainer = class("Season123_1_8EquipHeroViewContainer", BaseViewContainer)

function Season123_1_8EquipHeroViewContainer:buildViews()
	local scrollParam = self:createEquipItemsParam()
	local filterView = Season123_1_8EquipTagSelect.New()

	filterView:init(Season123EquipHeroController.instance, "#go_normal/right/#drop_filter")

	return {
		Season123_1_8EquipHeroView.New(),
		Season123_1_8EquipHeroSpineView.New(),
		filterView,
		LuaListScrollView.New(Season123EquipHeroItemListModel.instance, scrollParam),
		TabViewGroup.New(1, "#go_btn")
	}
end

Season123_1_8EquipHeroViewContainer.ColumnCount = 5

function Season123_1_8EquipHeroViewContainer:createEquipItemsParam()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#go_normal/right/#scroll_card"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = Season123_1_8EquipHeroItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = Season123_1_8EquipHeroViewContainer.ColumnCount
	scrollParam.cellWidth = 170
	scrollParam.cellHeight = 235
	scrollParam.cellSpaceH = 9.2
	scrollParam.cellSpaceV = 2.18
	scrollParam.frameUpdateMs = 100
	scrollParam.minUpdateCountInFrame = Season123_1_8EquipHeroViewContainer.ColumnCount

	return scrollParam
end

function Season123_1_8EquipHeroViewContainer:buildTabViews(tabContainerId)
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

Season123_1_8EquipHeroViewContainer.Close_Anim_Time = 0.17

function Season123_1_8EquipHeroViewContainer:playCloseTransition()
	UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")

	local animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	animator:Play("close", 0, 0)
	TaskDispatcher.runDelay(self.delayOnPlayCloseAnim, self, Season123_1_8EquipHeroViewContainer.Close_Anim_Time)
end

function Season123_1_8EquipHeroViewContainer:delayOnPlayCloseAnim()
	UnityEngine.Shader.DisableKeyword("_CLIPALPHA_ON")
	self:onPlayCloseTransitionFinish()
end

return Season123_1_8EquipHeroViewContainer
