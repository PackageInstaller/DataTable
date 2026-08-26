-- chunkname: @modules/logic/room/view/backpack/RoomBackpackViewContainer.lua

module("modules.logic.room.view.backpack.RoomBackpackViewContainer", package.seeall)

local RoomBackpackViewContainer = class("RoomBackpackViewContainer", BaseViewContainer)
local TabGroup = {
	Navigate = 1,
	SubView = 2
}

RoomBackpackViewContainer.SubViewTabId = {
	Critter = 1,
	Prop = 2
}
RoomBackpackViewContainer.TabSettingList = {
	{
		namecn = "room_critter_backpack_cn",
		nameen = "room_critter_backpack_en"
	},
	{
		namecn = "room_prop_backpack_cn",
		nameen = "room_prop_backpack_en"
	}
}

function RoomBackpackViewContainer:buildViews()
	local views = {}

	table.insert(views, RoomBackpackView.New())
	table.insert(views, TabViewGroup.New(TabGroup.Navigate, "#go_topleft"))
	table.insert(views, TabViewGroup.New(TabGroup.SubView, "#go_container"))

	return views
end

function RoomBackpackViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == TabGroup.Navigate then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self.navigateView
		}
	elseif tabContainerId == TabGroup.SubView then
		local critterScrollParam = ListScrollParam.New()

		critterScrollParam.scrollGOPath = "#scroll_critter"
		critterScrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
		critterScrollParam.prefabUrl = "#scroll_critter/viewport/content/#go_critterItem"
		critterScrollParam.cellClass = RoomBackpackCritterItem
		critterScrollParam.scrollDir = ScrollEnum.ScrollDirV
		critterScrollParam.lineCount = 8
		critterScrollParam.cellWidth = 152
		critterScrollParam.cellHeight = 152
		critterScrollParam.cellSpaceH = 30
		critterScrollParam.cellSpaceV = 30
		critterScrollParam.startSpace = 20
		critterScrollParam.minUpdateCountInFrame = 100

		local critterView = MultiView.New({
			RoomBackpackCritterView.New(),
			LuaListScrollView.New(RoomBackpackCritterListModel.instance, critterScrollParam)
		})
		local propScrollParam = ListScrollParam.New()

		propScrollParam.scrollGOPath = "#scroll_prop"
		propScrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
		propScrollParam.prefabUrl = "#scroll_prop/viewport/content/#go_item"
		propScrollParam.cellClass = RoomBackpackPropItem
		propScrollParam.scrollDir = ScrollEnum.ScrollDirV
		propScrollParam.lineCount = 7
		propScrollParam.cellWidth = 220
		propScrollParam.cellHeight = 220
		propScrollParam.startSpace = 20
		propScrollParam.endSpace = 10
		propScrollParam.minUpdateCountInFrame = 100

		local propView = MultiView.New({
			RoomBackpackPropView.New(),
			LuaListScrollViewWithAnimator.New(RoomBackpackPropListModel.instance, propScrollParam)
		})

		return {
			critterView,
			propView
		}
	end
end

function RoomBackpackViewContainer:onContainerInit()
	if not self.viewParam then
		return
	end

	self.viewParam.defaultTabIds = {}
	self.viewParam.defaultTabIds[TabGroup.SubView] = self:getDefaultSelectedTab()
end

function RoomBackpackViewContainer:getDefaultSelectedTab()
	if self.viewParam then
		local paramTabId = self.viewParam.defaultTab
		local checkResult = self:checkTabId(paramTabId)

		return (checkResult or nil) and paramTabId
	end
end

function RoomBackpackViewContainer:checkTabId(argsTabId)
	local result = false

	if argsTabId then
		for _, tabId in pairs(RoomBackpackViewContainer.SubViewTabId) do
			if tabId == argsTabId then
				result = true

				break
			end
		end
	end

	return result
end

function RoomBackpackViewContainer:switchTab(tabId)
	local checkResult = self:checkTabId(tabId)

	if not checkResult then
		return
	end

	self:dispatchEvent(ViewEvent.ToSwitchTab, TabGroup.SubView, tabId)
end

function RoomBackpackViewContainer:onContainerCloseFinish()
	RoomBackpackCritterListModel.instance:onInit()
end

return RoomBackpackViewContainer
