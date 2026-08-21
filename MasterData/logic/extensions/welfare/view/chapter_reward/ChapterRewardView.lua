-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfare/view/chapter_reward/ChapterRewardView.lua

module("logic.extensions.welfare.view.chapter_reward.ChapterRewardView", package.seeall)

local M = class("ChapterRewardView", DynamicFragmentView)

function M:buildUI()
	self._loopList = LoopListHelper.New(self._registry:getGo("chapter_rewards_view_1093375885"))

	self._loopList:InitListView(0, self._onCellUpdate, self)

	self._textDesc = self._registry:getText("chapter_rewards_view_1594494724")
	self._textDesc.text = lang("chapter_reward_desc")
	self._guiTimeline = self._registry:getGo("chapter_rewards_view_1648369894"):GetComponent(typeof(Astral.GUITimelineAniLua))
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:onEnter()
	self:_setEvent(true)

	local tabId = self.params[1]
	local activityList = WelfareUtil.getActivityListByTabId(tabId)
	local activeData = activityList[1]

	self._configId = activeData:getConfigId()
	self._label = TaskEnum.TaskLabel.ChapterReward

	TaskAgent.instance:sendListTaskRequest(self._label)
	self._guiTimeline:PlayOpenAni()
	self:_refreshView()
end

function M:onExit()
	self:_setEvent(false)
end

function M:destroyUI()
	self._loopList:Dispose()

	self._loopList = nil
	self._guiTimeline = nil
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.ACT_REWARD_TASK_REFRESH, self._onTaskRefresh, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ACT_REWARD_TASK_REFRESH, self._onTaskRefresh, self)
	end
end

function M:_onCellUpdate(curIndex, row, column)
	curIndex = curIndex + 1

	local item = self._loopList:NewListViewItem("item")
	local taskMo = self._taskList[curIndex]
	local shower = Astral.SimpleLuaComponentContainer.Add(item.gameObject, ChapterRewardTaskCell)

	shower:setData(taskMo)

	return item
end

function M:_refreshView()
	self._taskList = ActTaskRewardModel.instance:getTaskList(self._configId)

	table.sort(self._taskList, ActTaskRewardModel.instance.sortTaskFunc)
	self._loopList:SetListItemCount(#self._taskList, true)
	self._loopList:RefreshAllShownItem()
end

function M:_onTaskRefresh(_, label)
	if label == self._label then
		self:_refreshView()
	end
end

return M
