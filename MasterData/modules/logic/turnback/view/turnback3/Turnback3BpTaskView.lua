-- chunkname: @modules/logic/turnback/view/turnback3/Turnback3BpTaskView.lua

module("modules.logic.turnback.view.turnback3.Turnback3BpTaskView", package.seeall)

local Turnback3BpTaskView = class("Turnback3BpTaskView", BaseView)

function Turnback3BpTaskView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function Turnback3BpTaskView:addEvents()
	self.addEventCb(self, TurnbackController.instance, TurnbackEvent.OnTaskRewardGetFinish, self._playGetRewardFinishAnim, self)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self.refreshItem, self)
end

function Turnback3BpTaskView:removeEvents()
	self.removeEventCb(self, TurnbackController.instance, TurnbackEvent.OnTaskRewardGetFinish, self._playGetRewardFinishAnim, self)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, self.refreshItem, self)
end

function Turnback3BpTaskView:_editableInitView()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_task"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self.viewContainer:getSetting().otherRes[1]
	scrollParam.cellClass = Turnback3TaskItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 1568
	scrollParam.cellHeight = 132
	scrollParam.cellSpaceV = 16
	self._csListView = SLFramework.UGUI.ListScrollView.Get(gohelper.findChild(self.viewGO, "#scroll_task"))
	self._scrolltaskview = LuaListScrollView.New(TurnbackTaskModel.instance, scrollParam)

	self:addChildView(self._scrolltaskview)

	self._taskAnimRemoveItem = ListScrollAnimRemoveItem.Get(self._scrolltaskview)

	self._taskAnimRemoveItem:setMoveInterval(0)
	self._taskAnimRemoveItem:setMoveAnimationTime(TurnbackEnum.TaskMaskTime - TurnbackEnum.TaskGetAnimTime)
	self.viewContainer:dispatchEvent(TurnbackEvent.TapViewOpenAnimBegin, 2)
end

function Turnback3BpTaskView:_playGetRewardFinishAnim(indexList)
	if indexList then
		self.removeIndexTab = indexList
	end

	TaskDispatcher.runDelay(self.delayPlayFinishAnim, self, TurnbackEnum.TaskGetAnimTime)
end

function Turnback3BpTaskView:delayPlayFinishAnim()
	self._taskAnimRemoveItem:removeByIndexs(self.removeIndexTab)
end

function Turnback3BpTaskView:onUpdateParam()
	return
end

function Turnback3BpTaskView:refreshItem()
	TurnbackRpc.instance:sendGetTurnbackInfoRequest()
end

function Turnback3BpTaskView:onOpen()
	return
end

function Turnback3BpTaskView:onClose()
	return
end

function Turnback3BpTaskView:onDestroyView()
	return
end

return Turnback3BpTaskView
