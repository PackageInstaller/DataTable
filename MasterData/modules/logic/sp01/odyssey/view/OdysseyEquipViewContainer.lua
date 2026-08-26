-- chunkname: @modules/logic/sp01/odyssey/view/OdysseyEquipViewContainer.lua

module("modules.logic.sp01.odyssey.view.OdysseyEquipViewContainer", package.seeall)

local OdysseyEquipViewContainer = class("OdysseyEquipViewContainer", BaseViewContainer)

function OdysseyEquipViewContainer:buildViews()
	local views = {}

	table.insert(views, TabViewGroup.New(1, "#go_topleft"))
	table.insert(views, OdysseySuitListView.New("root"))
	table.insert(views, OdysseyEquipView.New())

	local animationDelayTimes = {}

	for i = 1, 20 do
		animationDelayTimes[i] = math.ceil((i - 1) % 4) * 0.03
	end

	local scrollParam = self:getEquipScrollListParam()

	table.insert(views, LuaListScrollViewWithAnimator.New(OdysseyEquipListModel.instance, scrollParam, animationDelayTimes))

	local suitScrollParam = self:getEquipSuitTabListParam()

	table.insert(views, LuaListScrollView.New(OdysseyEquipSuitTabListModel.instance, suitScrollParam))

	return views
end

function OdysseyEquipViewContainer:getEquipScrollListParam()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "root/#go_container/#scroll_Equip"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = OdysseyEquipItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 4
	scrollParam.cellWidth = 200
	scrollParam.cellHeight = 200
	scrollParam.cellSpaceH = 12
	scrollParam.cellSpaceV = 16
	scrollParam.startSpace = 25
	scrollParam.endSpace = 0

	return scrollParam
end

function OdysseyEquipViewContainer:getEquipSuitTabListParam()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "root/#scroll_LeftTab"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "root/#scroll_LeftTab/Viewport/Content/#go_TabItem"
	scrollParam.cellClass = OdysseyEquipSuitTabItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 120
	scrollParam.cellHeight = 80
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 18
	scrollParam.startSpace = 19
	scrollParam.endSpace = 20

	return scrollParam
end

function OdysseyEquipViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self.navigateView
		}
	end
end

return OdysseyEquipViewContainer
