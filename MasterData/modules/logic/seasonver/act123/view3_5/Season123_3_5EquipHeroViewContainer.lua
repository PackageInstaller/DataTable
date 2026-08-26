-- chunkname: @modules/logic/seasonver/act123/view3_5/Season123_3_5EquipHeroViewContainer.lua

module("modules.logic.seasonver.act123.view3_5.Season123_3_5EquipHeroViewContainer", package.seeall)

local Season123_3_5EquipHeroViewContainer = class("Season123_3_5EquipHeroViewContainer", BaseViewContainer)

function Season123_3_5EquipHeroViewContainer:buildViews()
	local scrollParam = self:createEquipItemsParam()
	local filterView = Season123_3_5EquipTagSelect.New()

	filterView:init(Season123EquipHeroController.instance, "#go_normal/right/#drop_filter")

	return {
		Season123_3_5EquipHeroView.New(),
		Season123_3_5EquipHeroSpineView.New(),
		filterView,
		LuaListScrollView.New(Season123EquipHeroItemListModel.instance, scrollParam),
		TabViewGroup.New(1, "#go_btn")
	}
end

Season123_3_5EquipHeroViewContainer.ColumnCount = 5

function Season123_3_5EquipHeroViewContainer:createEquipItemsParam()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#go_normal/right/#scroll_card"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = Season123_3_5EquipHeroItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = Season123_3_5EquipHeroViewContainer.ColumnCount
	scrollParam.cellWidth = 170
	scrollParam.cellHeight = 235
	scrollParam.cellSpaceH = 9.2
	scrollParam.cellSpaceV = 2.18
	scrollParam.frameUpdateMs = 100
	scrollParam.minUpdateCountInFrame = Season123_3_5EquipHeroViewContainer.ColumnCount

	return scrollParam
end

function Season123_3_5EquipHeroViewContainer:buildTabViews(tabContainerId)
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

function Season123_3_5EquipHeroViewContainer:_reallyClose()
	self:_playCloseAnim()
end

Season123_3_5EquipHeroViewContainer.Close_Anim_Time = 0.17

function Season123_3_5EquipHeroViewContainer:_playCloseAnim()
	UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")

	local animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	animator:Play("close", 0, 0)
	TaskDispatcher.runDelay(self.delayOnPlayCloseAnim, self, Season123_3_5EquipHeroViewContainer.Close_Anim_Time)
end

function Season123_3_5EquipHeroViewContainer:delayOnPlayCloseAnim()
	UnityEngine.Shader.DisableKeyword("_CLIPALPHA_ON")
	Season123_3_5EquipHeroViewContainer.super._reallyClose(self)
end

return Season123_3_5EquipHeroViewContainer
