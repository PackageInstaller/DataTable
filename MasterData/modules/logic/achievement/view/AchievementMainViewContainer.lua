-- chunkname: @modules/logic/achievement/view/AchievementMainViewContainer.lua

module("modules.logic.achievement.view.AchievementMainViewContainer", package.seeall)

local AchievementMainViewContainer = class("AchievementMainViewContainer", BaseViewContainer)

function AchievementMainViewContainer:buildViews()
	self._scrollListView = LuaMixScrollView.New(AchievementMainListModel.instance, self:getListContentParam())

	self._scrollListView:setDynamicGetItem(self._dynamicGetItem, self)

	self._scrollNamePlateView = LuaMixScrollView.New(AchievementMainListModel.instance, self:getNamePlateParam())
	self._scrollTileView = LuaMixScrollView.New(AchievementMainTileModel.instance, self:getMixContentParam())
	self._poolView = AchievementMainViewPool.New(AchievementEnum.MainIconPath)

	return {
		AchievementMainView.New(),
		TabViewGroup.New(1, "#go_btns"),
		self._scrollTileView,
		self._scrollListView,
		self._scrollNamePlateView,
		self._poolView,
		AchievementMainViewFocus.New(),
		AchievementMainTopView.New(),
		AchievementMainViewFold.New()
	}
end

function AchievementMainViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			self.navigateView
		}
	end
end

function AchievementMainViewContainer:_dynamicGetItem(mo)
	if not mo then
		return
	end

	local isNamePlate = AchievementMainCommonModel.instance:checkIsNamePlate()

	if isNamePlate then
		return "nameplate", AchievementNamePlateListItem, "#go_container/#scroll_list/Viewport/content/#go_listitem"
	end
end

function AchievementMainViewContainer:getMixContentParam()
	local scrollParam = MixScrollParam.New()

	scrollParam.scrollGOPath = "#go_container/#scroll_content"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = AchievementMainItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.startSpace = 0
	scrollParam.endSpace = 50

	return scrollParam
end

function AchievementMainViewContainer:getListContentParam()
	local scrollParam = MixScrollParam.New()

	scrollParam.scrollGOPath = "#go_container/#scroll_list"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "#go_container/#scroll_list/Viewport/content/#go_listitem"
	scrollParam.cellClass = AchievementMainListItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.startSpace = 0
	scrollParam.endSpace = 50

	return scrollParam
end

function AchievementMainViewContainer:getNamePlateParam()
	local scrollParam = MixScrollParam.New()

	scrollParam.scrollGOPath = "#go_container/#scroll_content_misihai"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[3]
	scrollParam.cellClass = AchievementMainNamePlateItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.startSpace = 0
	scrollParam.endSpace = 50

	return scrollParam
end

function AchievementMainViewContainer:getScrollView(viewType)
	if viewType == AchievementEnum.ViewType.Tile then
		return self._scrollTileView
	else
		return self._scrollListView
	end
end

function AchievementMainViewContainer:getPoolView()
	return self._poolView
end

return AchievementMainViewContainer
