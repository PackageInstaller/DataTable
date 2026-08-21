-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfare/view/claw_doll/ClawDollTaskView.lua

module("logic.extensions.welfare.view.claw_doll.ClawDollTaskView", package.seeall)

local M = class("ClawDollTaskView", ViewComponent)

function M:buildUI()
	self._btnReturn = self:getBtn("1&universal_second_tips_common_bg_1201003252")
	self._clickExitPanel = self:getBtn("1&universal_second_tips_common_bg_-1467035629")
	self._loopList = LoopListHelper.New(self:getGo("starting_currency_tips_1154339275"))

	self._loopList:InitListView(0, self._onCellUpdate, self)
end

function M:destroyUI()
	self._btnReturn = nil
	self._clickExitPanel = nil

	self._loopList:Dispose()

	self._loopList = nil
end

function M:bindEvents()
	self._btnReturn:AddClickListener(self._onClickReturn, self)
	self._clickExitPanel:AddClickListener(self._onClickReturn, self)
end

function M:unbindEvents()
	self._btnReturn:RemoveClickListener()
	self._clickExitPanel:RemoveClickListener()
end

function M:onEnter()
	self:setEvent(true)
	TaskAgent.instance:sendListTaskRequest(TaskEnum.TaskLabel.ClipDollDaily)
end

function M:onExit()
	self:setEvent(false)
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.CLAW_DOLL_SETTASK, self._refreshTaskLst, self)
	else
		GlobalDispatcher:removeEventListener(EventType.CLAW_DOLL_SETTASK, self._refreshTaskLst, self)
	end
end

function M:_onClickReturn()
	self:back()
end

function M:_refreshTaskLst(e, label)
	self._taskMoLst = ClawDollController.instance:getClawDollTaskLstByLabel(label)

	local count = self._taskMoLst and #self._taskMoLst or 0

	self._loopList:SetListItemCount(count, false)
	self._loopList:RefreshAllShownItem()
	self._loopList:MoveToItemIndex(0)
end

function M:_onCellUpdate(curIndex, row, column)
	curIndex = curIndex + 1

	local class = ClawDollTaskCellItem
	local item = self._loopList:NewListViewItem("gain_item")
	local taskMo = self._taskMoLst[curIndex]
	local shower = Astral.LuaComponentContainer.Get(item.gameObject, class)

	shower = shower or Astral.LuaComponentContainer.Add(item.gameObject, class)

	shower:updateData(taskMo)

	return item
end

return M
