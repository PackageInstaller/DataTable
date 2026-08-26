-- chunkname: @modules/logic/season/view/SeasonEquipHeroViewContainer.lua

module("modules.logic.season.view.SeasonEquipHeroViewContainer", package.seeall)

local SeasonEquipHeroViewContainer = class("SeasonEquipHeroViewContainer", BaseViewContainer)

function SeasonEquipHeroViewContainer:buildViews()
	local scrollParam = self:createEquipItemsParam()
	local filterView = SeasonEquipTagSelect.New()

	filterView:init(Activity104EquipController.instance, "#go_normal/right/#drop_filter")

	return {
		SeasonEquipHeroView.New(),
		SeasonEquipHeroSpineView.New(),
		filterView,
		LuaListScrollView.New(Activity104EquipItemListModel.instance, scrollParam),
		TabViewGroup.New(1, "#go_btn")
	}
end

SeasonEquipHeroViewContainer.ColumnCount = 5

function SeasonEquipHeroViewContainer:createEquipItemsParam()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#go_normal/right/#scroll_card"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = SeasonEquipItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = SeasonEquipHeroViewContainer.ColumnCount
	scrollParam.cellWidth = 170
	scrollParam.cellHeight = 235
	scrollParam.cellSpaceH = 9.2
	scrollParam.cellSpaceV = 2.18
	scrollParam.frameUpdateMs = 100
	scrollParam.minUpdateCountInFrame = SeasonEquipHeroViewContainer.ColumnCount

	return scrollParam
end

function SeasonEquipHeroViewContainer:buildTabViews(tabContainerId)
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

SeasonEquipHeroViewContainer.Close_Anim_Time = 0.17

function SeasonEquipHeroViewContainer:playCloseTransition()
	UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")

	local animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	animator:Play("close", 0, 0)
	TaskDispatcher.runDelay(self.delayOnPlayCloseAnim, self, SeasonEquipHeroViewContainer.Close_Anim_Time)
end

function SeasonEquipHeroViewContainer:delayOnPlayCloseAnim()
	UnityEngine.Shader.DisableKeyword("_CLIPALPHA_ON")
	self:onPlayCloseTransitionFinish()
end

return SeasonEquipHeroViewContainer
