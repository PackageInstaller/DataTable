-- chunkname: @modules/logic/versionactivity/view/VersionActivityPushBoxTaskView.lua

module("modules.logic.versionactivity.view.VersionActivityPushBoxTaskView", package.seeall)

local VersionActivityPushBoxTaskView = class("VersionActivityPushBoxTaskView", BaseViewExtended)

function VersionActivityPushBoxTaskView:onInitView()
	self._btnclose1 = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close1")
	self._simagebg2 = gohelper.findChildSingleImage(self.viewGO, "#simage_bg2")
	self._simageheroicon = gohelper.findChildSingleImage(self.viewGO, "#simage_heroicon")
	self._scrolltasklist = gohelper.findChildScrollRect(self.viewGO, "#scroll_tasklist")
	self._gotaskitem = gohelper.findChild(self.viewGO, "#scroll_tasklist/Viewport/Content/#go_taskitem")
	self._btnclose2 = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close2")
	self._gohero = gohelper.findChild(self.viewGO, "#go_hero")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivityPushBoxTaskView:addEvents()
	self._btnclose1:AddClickListener(self._btnclose1OnClick, self)
	self._btnclose2:AddClickListener(self._btnclose2OnClick, self)
	self.addEventCb(self, PushBoxController.instance, PushBoxEvent.DataEvent.ReceiveTaskRewardReply, self._onReceiveTaskRewardReply, self)
end

function VersionActivityPushBoxTaskView:removeEvents()
	self._btnclose1:RemoveClickListener()
	self._btnclose2:RemoveClickListener()
end

function VersionActivityPushBoxTaskView:_btnclose1OnClick()
	self:closeThis()
end

function VersionActivityPushBoxTaskView:_btnclose2OnClick()
	self:closeThis()
end

function VersionActivityPushBoxTaskView:onOpen()
	self:_showTaskList()
	self._simageheroicon:LoadImage(ResUrl.getVersionActivityIcon("pushbox/img_lihui_rw"))
	self._simagebg2:LoadImage(ResUrl.getVersionActivityIcon("pushbox/bg_rwdi2"))
end

function VersionActivityPushBoxTaskView:_showTaskList()
	self._task_list = PushBoxEpisodeConfig.instance:getTaskList()

	PushBoxTaskListModel.instance:initData(self._task_list)
	PushBoxTaskListModel.instance:sortData()
	PushBoxTaskListModel.instance:refreshData()
	gohelper.addChild(self.viewGO, self._gotaskitem)
	gohelper.setActive(self._gotaskitem, false)
	TaskDispatcher.runDelay(self._showTaskItem, self, 0.2)
end

function VersionActivityPushBoxTaskView:_showTaskItem()
	self:com_createObjList(self._onItemShow, PushBoxTaskListModel.instance.data, gohelper.findChild(self.viewGO, "#scroll_tasklist/Viewport/Content"), self._gotaskitem, nil, 0.1)
end

function VersionActivityPushBoxTaskView:_onItemShow(obj, data, index)
	self._item_list = self._item_list or {}

	local new = false

	if not self._item_list[index] then
		new = true
		self._item_list[index] = self:openSubView(PushBoxTaskItem, obj)
	end

	self._item_list[index]:_refreshData(data)

	if new then
		self._item_list[index]:playOpenAni(index)
	end
end

function VersionActivityPushBoxTaskView:_onReceiveTaskRewardReply()
	self:_showTaskList()
end

function VersionActivityPushBoxTaskView:onClose()
	TaskDispatcher.cancelTask(self._showTaskItem, self, 0.2)

	self._item_list = nil

	PushBoxTaskListModel.instance:clearData()
end

function VersionActivityPushBoxTaskView:onDestroyView()
	self._simageheroicon:UnLoadImage()
	self._simagebg2:UnLoadImage()
end

return VersionActivityPushBoxTaskView
