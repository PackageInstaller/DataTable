-- chunkname: @modules/logic/sp01/odyssey/view/OdysseyBagViewContainer.lua

module("modules.logic.sp01.odyssey.view.OdysseyBagViewContainer", package.seeall)

local OdysseyBagViewContainer = class("OdysseyBagViewContainer", BaseViewContainer)

function OdysseyBagViewContainer:buildViews()
	local views = {}

	table.insert(views, OdysseyBagView.New())
	table.insert(views, TabViewGroup.New(1, "root/#go_topleft"))

	local animationDelayTimes = {}

	for i = 1, 25 do
		animationDelayTimes[i] = math.ceil((i - 1) % 5) * 0.03
	end

	local scrollParam = self:getEquipScrollListParam()
	local scrollView = LuaListScrollViewWithAnimator.New(OdysseyEquipListModel.instance, scrollParam, animationDelayTimes)

	table.insert(views, scrollView)

	local suitScrollParam = self:getEquipSuitTabListParam()

	table.insert(views, LuaListScrollView.New(OdysseyEquipSuitTabListModel.instance, suitScrollParam))

	return views
end

function OdysseyBagViewContainer:buildTabViews(tabContainerId)
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

function OdysseyBagViewContainer:getEquipScrollListParam()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "root/Equip/#scroll_Equip"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = OdysseyEquipItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = self:getCurrentBagLineCount()
	scrollParam.cellWidth = 200
	scrollParam.cellHeight = 170
	scrollParam.cellSpaceH = 8
	scrollParam.cellSpaceV = 34
	scrollParam.startSpace = 20
	scrollParam.endSpace = 15

	return scrollParam
end

function OdysseyBagViewContainer:getEquipSuitTabListParam()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "root/Equip/#scroll_LeftTab"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "root/Equip/#scroll_LeftTab/Viewport/Content/#go_TabItem"
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

function OdysseyBagViewContainer:getCurrentBagLineCount(width, height)
	width = width or UnityEngine.Screen.width
	height = height or UnityEngine.Screen.height

	local longScreenRatio = 2.39

	return width / height - longScreenRatio >= 0.0001 and 6 or 5
end

return OdysseyBagViewContainer
