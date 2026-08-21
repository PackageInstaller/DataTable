-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitactivity/view/TimeLimitActivityEntranceView.lua

module("logic.extensions.timelimitactivity.view.TimeLimitActivityEntranceView", package.seeall)

local M = class("TimeLimitActivityEntranceView", ViewComponent)

function M:buildUI()
	self._loopListHelper = LoopListHelper.New(self:getGo("time_activities_entry_view_-1473188435"))

	self._loopListHelper:InitListView(0, self._onCellUpdate, self)
end

function M:onEnter()
	self:_bindEvents()
	self:_refreshView()
end

function M:_bindEvents()
	GlobalDispatcher:addEventListener(EventType.ACTIVITY_ALL_REFRESH, self._activityUpdate, self)
end

function M:_unbindEvents()
	GlobalDispatcher:removeEventListener(EventType.ACTIVITY_ALL_REFRESH, self._activityUpdate, self)
end

function M:_activityUpdate()
	self._loopListHelper:RefreshAllShownItem()
end

function M:_refreshView()
	self._openActivityList = TimeLimitActivityModel.instance:getAllOpenActIds()

	self._loopListHelper:SetListItemCount(#self._openActivityList, true)
	self._loopListHelper:MoveToItemIndex(0)
	self._loopListHelper:RefreshAllShownItem()
end

function M:_onCellUpdate(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local id = self._openActivityList[curIndex]
	local item = self._loopListHelper:NewListViewItem("time_activities_banner")
	local shower = Astral.LuaComponentContainer.Add(item.gameObject, TimeLimitActivityEntranceItem)

	shower:setClickCallBack(self._onClickCell, self)
	shower:setData(id)

	return item
end

function M:_onClickCell(actId)
	if actId == BattleExtension_pb.GameType.FOOTBALLPVP then
		ViewMgr.instance:open(ViewName.FootBall)
	end
end

function M:onExit()
	self:_unbindEvents()
	self._loopListHelper:ClearCells()
end

function M:destroyUI()
	self._loopListHelper:Dispose()

	self._loopListHelper = nil
end

return M
