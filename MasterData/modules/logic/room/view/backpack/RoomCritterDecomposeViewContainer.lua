-- chunkname: @modules/logic/room/view/backpack/RoomCritterDecomposeViewContainer.lua

module("modules.logic.room.view.backpack.RoomCritterDecomposeViewContainer", package.seeall)

local RoomCritterDecomposeViewContainer = class("RoomCritterDecomposeViewContainer", BaseViewContainer)
local SHOW_LINE = 4
local LINE_ANIM_TIME = 0.03

function RoomCritterDecomposeViewContainer:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "left_container/#go_scrollcontainer/#scroll_critter"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "left_container/#go_scrollcontainer/#scroll_critter/Viewport/Content/#go_critterItem"
	scrollParam.cellClass = RoomCritterDecomposeItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = self:getLineCount()
	scrollParam.cellWidth = 200
	scrollParam.cellHeight = 200
	scrollParam.frameUpdateMs = 0
	scrollParam.minUpdateCountInFrame = scrollParam.lineCount

	local delayTimeArray = self.getDelayTimeArray(scrollParam.lineCount)
	local listScrollView = LuaListScrollViewWithAnimator.New(RoomCritterDecomposeListModel.instance, scrollParam, delayTimeArray)

	table.insert(views, listScrollView)
	table.insert(views, RoomCritterDecomposeView.New())
	table.insert(views, TabViewGroup.New(1, "#go_lefttopbtns"))

	return views
end

function RoomCritterDecomposeViewContainer:getLineCount()
	local contentTr = gohelper.findChildComponent(self.viewGO, "left_container/#go_scrollcontainer", gohelper.Type_Transform)
	local contentWidth = recthelper.getWidth(contentTr)

	return math.floor(contentWidth / 200)
end

function RoomCritterDecomposeViewContainer.getDelayTimeArray(lineCount)
	local timeArray = {}

	setmetatable(timeArray, timeArray)

	function timeArray.__index(t, index)
		local line = math.floor((index - 1) / lineCount)

		if line > SHOW_LINE then
			return
		end

		return line * LINE_ANIM_TIME
	end

	return timeArray
end

function RoomCritterDecomposeViewContainer:buildTabViews(tabContainerId)
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

function RoomCritterDecomposeViewContainer:playCloseTransition()
	self:onPlayCloseTransitionFinish()
end

function RoomCritterDecomposeViewContainer:onContainerCloseFinish()
	RoomCritterDecomposeListModel.instance:onInit()
end

return RoomCritterDecomposeViewContainer
