-- chunkname: @modules/logic/versionactivity/view/VersionActivityTaskView.lua

module("modules.logic.versionactivity.view.VersionActivityTaskView", package.seeall)

local VersionActivityTaskView = class("VersionActivityTaskView", BaseView)

function VersionActivityTaskView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._simagedecorate2 = gohelper.findChildSingleImage(self.viewGO, "#simage_decorate2")
	self._scrollleft = gohelper.findChildScrollRect(self.viewGO, "#scroll_left")
	self._goitem = gohelper.findChild(self.viewGO, "#scroll_left/Viewport/Content/#go_item")
	self._txtgetcount = gohelper.findChildText(self.viewGO, "horizontal/totalprogress/#txt_getcount")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivityTaskView:addEvents()
	return
end

function VersionActivityTaskView:removeEvents()
	return
end

function VersionActivityTaskView:_editableInitView()
	gohelper.setActive(self._goitem, false)

	self.goTaskBonusContent = gohelper.findChild(self.viewGO, "#scroll_left/Viewport/Content")
	self.itemResPath = self.viewContainer:getSetting().otherRes[1]
	self.taskBonusItemList = {}

	self._simagebg:LoadImage(ResUrl.getVersionActivityIcon("full/bg1"))
end

function VersionActivityTaskView:onUpdateParam()
	return
end

function VersionActivityTaskView:onOpen()
	self.addEventCb(self, VersionActivityController.instance, VersionActivityEvent.OnReceiveFinishTaskReply, self.onReceiveFinishTaskReply, self)
	VersionActivityTaskListModel.instance:initTaskList()
	self:setTaskBonusY()
	self:refreshUI()
end

function VersionActivityTaskView:refreshUI()
	self:refreshLeftUI()
	self:refreshRightUI()
end

function VersionActivityTaskView:setTaskBonusY()
	local curStage = TaskModel.instance:getTaskActivityMO(TaskEnum.TaskType.ActivityDungeon).defineId
	local taskBonusCount = #TaskConfig.instance:getTaskActivityBonusConfig(TaskEnum.TaskType.ActivityDungeon)

	curStage = math.min(curStage, taskBonusCount - 5)

	local y = 165 * curStage

	transformhelper.setLocalPosXY(self.goTaskBonusContent.transform, 0, y)
	self.viewContainer:setTaskBonusScrollViewIndexOffset(curStage)
end

function VersionActivityTaskView:refreshLeftUI()
	self:refreshTaskBonusItem()
end

function VersionActivityTaskView:refreshRightUI()
	self._txtgetcount.text = string.format(" %s/%s", VersionActivityTaskListModel.instance:getGetRewardTaskCount(), VersionActivityConfig.instance:getAct113TaskCount(VersionActivityEnum.ActivityId.Act113))

	VersionActivityTaskListModel.instance:sortTaskMoList()
	VersionActivityTaskListModel.instance:refreshList()
end

function VersionActivityTaskView:refreshTaskBonusItem()
	VersionActivityTaskBonusListModel.instance:refreshList()
end

function VersionActivityTaskView:onReceiveFinishTaskReply()
	self:refreshRightUI()
	VersionActivityController.instance:dispatchEvent(VersionActivityEvent.AddTaskActivityBonus)
	TaskDispatcher.runDelay(self.onTaskBonusAnimationDone, self, 0.833)
end

function VersionActivityTaskView:onTaskBonusAnimationDone()
	self:refreshLeftUI()
	self:setTaskBonusY()
end

function VersionActivityTaskView:onClose()
	TaskDispatcher.cancelTask(self.onTaskBonusAnimationDone, self)
end

function VersionActivityTaskView:onDestroyView()
	for _, taskBonusItem in ipairs(self.taskBonusItemList) do
		taskBonusItem:onDestroyView()
	end

	self._simagebg:UnLoadImage()
end

return VersionActivityTaskView
