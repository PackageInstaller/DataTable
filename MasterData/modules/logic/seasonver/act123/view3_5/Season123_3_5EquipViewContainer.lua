-- chunkname: @modules/logic/seasonver/act123/view3_5/Season123_3_5EquipViewContainer.lua

module("modules.logic.seasonver.act123.view3_5.Season123_3_5EquipViewContainer", package.seeall)

local Season123_3_5EquipViewContainer = class("Season123_3_5EquipViewContainer", BaseViewContainer)

function Season123_3_5EquipViewContainer:buildViews()
	local scrollParam = self:createEquipItemsParam()
	local filterView = Season123_3_5EquipTagSelect.New()

	filterView:init(Season123EquipController.instance, "right/#drop_filter")

	return {
		Season123_3_5EquipView.New(),
		Season123_3_5EquipSpineView.New(),
		filterView,
		LuaListScrollView.New(Season123EquipItemListModel.instance, scrollParam),
		TabViewGroup.New(1, "#go_btn")
	}
end

function Season123_3_5EquipViewContainer:createEquipItemsParam()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "right/#scroll_card"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = Season123_3_5EquipItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = Season123_3_5EquipItem.ColumnCount
	scrollParam.cellWidth = 170
	scrollParam.cellHeight = 235
	scrollParam.cellSpaceH = 8.4
	scrollParam.cellSpaceV = 0
	scrollParam.frameUpdateMs = 100
	scrollParam.minUpdateCountInFrame = Season123_3_5EquipItem.ColumnCount

	return scrollParam
end

function Season123_3_5EquipViewContainer:buildTabViews(tabContainerId)
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

function Season123_3_5EquipViewContainer:_reallyClose()
	self:_playCloseAnim()
end

Season123_3_5EquipViewContainer.Close_Anim_Time = 0.2

function Season123_3_5EquipViewContainer:_playCloseAnim()
	UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")

	local animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	animator:Play("close", 0, 0)
	TaskDispatcher.runDelay(self.delayOnPlayCloseAnim, self, Season123_3_5EquipViewContainer.Close_Anim_Time)
end

function Season123_3_5EquipViewContainer:delayOnPlayCloseAnim()
	UnityEngine.Shader.DisableKeyword("_CLIPALPHA_ON")
	Season123_3_5EquipViewContainer.super._reallyClose(self)
end

return Season123_3_5EquipViewContainer
