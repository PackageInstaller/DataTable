-- chunkname: @modules/logic/seasonver/act123/view2_1/Season123_2_1TaskView.lua

module("modules.logic.seasonver.act123.view2_1.Season123_2_1TaskView", package.seeall)

local Season123_2_1TaskView = class("Season123_2_1TaskView", BaseView)

function Season123_2_1TaskView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._goreward = gohelper.findChild(self.viewGO, "top/#go_reward")
	self._gorewardunchoose = gohelper.findChild(self.viewGO, "top/#go_reward/#go_rewardunchoose")
	self._gorewardchoose = gohelper.findChild(self.viewGO, "top/#go_reward/#go_rewardchoose")
	self._gorewardreddot = gohelper.findChild(self.viewGO, "top/#go_reward/#go_rewardreddot")
	self._btnreward = gohelper.findChildButtonWithAudio(self.viewGO, "top/#go_reward/#btn_reward")
	self._gotask = gohelper.findChild(self.viewGO, "top/#go_task")
	self._gotaskunchoose = gohelper.findChild(self.viewGO, "top/#go_task/#go_taskunchoose")
	self._gotaskchoose = gohelper.findChild(self.viewGO, "top/#go_task/#go_taskchoose")
	self._gotaskreddot = gohelper.findChild(self.viewGO, "top/#go_task/#go_taskreddot")
	self._btntask = gohelper.findChildButtonWithAudio(self.viewGO, "top/#go_task/#btn_task")
	self._scrolltasklist = gohelper.findChildScrollRect(self.viewGO, "#scroll_tasklist")
	self._scrollmaplist = gohelper.findChildScrollRect(self.viewGO, "left/#go_maplist/#scroll_maplist")
	self._gomapcontent = gohelper.findChild(self.viewGO, "left/#go_maplist/#scroll_maplist/Viewport/#go_mapContent")
	self._gomaplist = gohelper.findChild(self.viewGO, "left/#go_maplist")
	self._btnarrowdown = gohelper.findChildButton(self.viewGO, "left/#go_maplist/#btn_arrowDown")
	self._btnarrowtop = gohelper.findChildButton(self.viewGO, "left/#go_maplist/#btn_arrowTop")
	self._goreddotdown = gohelper.findChild(self.viewGO, "left/#go_maplist/#btn_arrowDown/#go_reddotDown")
	self._goreddottop = gohelper.findChild(self.viewGO, "left/#go_maplist/#btn_arrowTop/#go_reddotTop")
	self._goscrollArea = gohelper.findChild(self.viewGO, "left/#go_maplist/#go_scrollArea")
	self._goachievement = gohelper.findChild(self.viewGO, "left/#go_achievement")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season123_2_1TaskView:addEvents()
	self._btnreward:AddClickListener(self._btnrewardOnClick, self)
	self._btntask:AddClickListener(self._btntaskOnClick, self)
	self._btnarrowdown:AddClickListener(self._btnArrowDownOnClick, self)
	self._btnarrowtop:AddClickListener(self._btnArrowUpOnClick, self)
	self.addEventCb(self, Season123Controller.instance, Season123Event.OnTaskRewardGetFinish, self._playGetRewardFinishAnim, self)
	self.addEventCb(self, Season123Controller.instance, Season123Event.TaskUpdated, self.refreshRedDot, self)
	self.addEventCb(self, Season123Controller.instance, Season123Event.clickTaskMapItem, self.moveScrollPos, self)
end

function Season123_2_1TaskView:removeEvents()
	self._btnreward:RemoveClickListener()
	self._btntask:RemoveClickListener()
	self._btnarrowdown:RemoveClickListener()
	self._btnarrowtop:RemoveClickListener()
	self.removeEventCb(self, Season123Controller.instance, Season123Event.OnTaskRewardGetFinish, self._playGetRewardFinishAnim, self)
	self.removeEventCb(self, Season123Controller.instance, Season123Event.TaskUpdated, self.refreshRedDot, self)
	self.addEventCb(self, Season123Controller.instance, Season123Event.clickTaskMapItem, self.moveScrollPos, self)
end

Season123_2_1TaskView.TaskMaskTime = 0.65
Season123_2_1TaskView.TaskGetAnimTime = 0.567
Season123_2_1TaskView.StageMapItemCount = 6
Season123_2_1TaskView.moveDistance = 50

function Season123_2_1TaskView:_btnrewardOnClick()
	self.curTaskType = Activity123Enum.TaskRewardViewType

	self:refreshUI()
end

function Season123_2_1TaskView:_btntaskOnClick()
	self.curTaskType = Activity123Enum.TaskNormalType

	self:refreshUI()
end

function Season123_2_1TaskView:_btnArrowDownOnClick()
	self.curStage = Mathf.Min(self.curStage + 1, Season123_2_1TaskView.StageMapItemCount)
	Season123TaskModel.instance.curStage = self.curStage

	self:refreshUI()
	AudioMgr.instance:trigger(AudioEnum.Season123.play_ui_feedback_open)
end

function Season123_2_1TaskView:_btnArrowUpOnClick()
	self.curStage = Mathf.Max(self.curStage - 1, 1)
	Season123TaskModel.instance.curStage = self.curStage

	self:refreshUI()
	AudioMgr.instance:trigger(AudioEnum.Season123.play_ui_feedback_open)
end

function Season123_2_1TaskView:_onScrollDragBegin(param, eventData)
	self.scrollStartPos = eventData.position
end

function Season123_2_1TaskView:_onScrollDragEnd(param, eventData)
	local moveOffset = eventData.position - self.scrollStartPos
	local canMove = Mathf.Abs(moveOffset.y) - Season123_2_1TaskView.moveDistance >= 0

	if moveOffset.y > 0 and canMove then
		self:_btnArrowDownOnClick()
	elseif moveOffset.y < 0 and canMove then
		self:_btnArrowUpOnClick()
	end
end

function Season123_2_1TaskView:_editableInitView()
	self._taskAnimRemoveItem = ListScrollAnimRemoveItem.Get(self.viewContainer.scrollView)

	self._taskAnimRemoveItem:setMoveInterval(0)
	self._taskAnimRemoveItem:setMoveAnimationTime(Season123_2_1TaskView.TaskMaskTime - Season123_2_1TaskView.TaskGetAnimTime)

	self.stageMapItemTab = self:getUserDataTb_()
	self.layoutGroup = self._gomapcontent:GetComponent(typeof(UnityEngine.UI.VerticalLayoutGroup))
	self.mapcontentRectTrans = self._gomapcontent:GetComponent(gohelper.Type_RectTransform)
	self.mapScroll = SLFramework.UGUI.UIDragListener.Get(self._goscrollArea)

	self.mapScroll:AddDragBeginListener(self._onScrollDragBegin, self)
	self.mapScroll:AddDragEndListener(self._onScrollDragEnd, self)
end

function Season123_2_1TaskView:onOpen()
	self.actId = self.viewParam.actId
	self.stageId = self.viewParam.stage

	local seasonTasks = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Season123) or {}

	Season123TaskModel.instance:setTaskInfoList(seasonTasks)
	Season123TaskModel.instance:initStageAndTaskType()

	if self.stageId ~= nil then
		Season123TaskModel.instance.curStage = self.stageId or Season123TaskModel.instance.curStage
	end

	if self.stageId ~= nil then
		self.curTaskType = Activity123Enum.TaskRewardViewType or self.curTaskType
	end

	self:createStageMapItem()
	self:refreshUI()
	self:refreshArrowRedDot()
	UIBlockMgr.instance:startBlock("playEnterSeason123_2_1TaskViewAnim")
	TaskDispatcher.runDelay(self.endEnterAnimBlock, self, 0.8)
	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonEnterTaskView)
end

function Season123_2_1TaskView:refreshUI()
	self.curStage = Season123TaskModel.instance.curStage

	if not self.curTaskType then
		if not Season123TaskModel.instance.curTaskType then
			local curTaskType = self.curTaskType

			Season123TaskModel.instance:refreshList(curTaskType)

			self._scrolltasklist.verticalNormalizedPosition = 1

			gohelper.setActive(self._gorewardchoose, curTaskType == Activity123Enum.TaskRewardViewType)
			gohelper.setActive(self._gorewardunchoose, curTaskType == Activity123Enum.TaskNormalType)
			gohelper.setActive(self._gotaskchoose, curTaskType == Activity123Enum.TaskNormalType)
			gohelper.setActive(self._gotaskunchoose, curTaskType == Activity123Enum.TaskRewardViewType)
			gohelper.setActive(self._goachievement, curTaskType == Activity123Enum.TaskNormalType)
			gohelper.setActive(self._scrollmaplist.gameObject, curTaskType == Activity123Enum.TaskRewardViewType)
			gohelper.setActive(self._gomaplist, curTaskType == Activity123Enum.TaskRewardViewType)
			self:refreshArrowUI()
			self:refreshRedDot()
			self:moveScrollPos()
		end
	end
end

function Season123_2_1TaskView:refreshRedDot()
	gohelper.setActive(self._gorewardreddot, Season123TaskModel.instance.reddotShowMap[Activity123Enum.TaskRewardViewType])
	gohelper.setActive(self._gotaskreddot, Season123TaskModel.instance.reddotShowMap[Activity123Enum.TaskNormalType])
end

function Season123_2_1TaskView:refreshArrowRedDot()
	local rewardStageIndexList = Season123TaskModel.instance:getHaveRewardTaskIndexList()
	local topIndex = Mathf.Max(self.curStage - 1, 1)
	local downIndex = Mathf.Min(self.curStage + 1, Season123_2_1TaskView.StageMapItemCount)
	local needShowTopRedDot = false
	local neesShowDownRedDot = false

	for i = 1, #rewardStageIndexList do
		if topIndex - rewardStageIndexList[i] >= 0 then
			needShowTopRedDot = true

			break
		end
	end

	for i = 1, #rewardStageIndexList do
		if rewardStageIndexList[i] - downIndex >= 0 then
			neesShowDownRedDot = true

			break
		end
	end

	gohelper.setActive(self._goreddotdown, downIndex - self.curStage > 0 and neesShowDownRedDot)
	gohelper.setActive(self._goreddottop, self.curStage - topIndex > 0 and needShowTopRedDot)
end

function Season123_2_1TaskView:refreshArrowUI()
	gohelper.setActive(self._btnarrowdown.gameObject, self.curStage < Season123_2_1TaskView.StageMapItemCount)
	gohelper.setActive(self._btnarrowtop.gameObject, self.curStage > 1)
	self:refreshArrowRedDot()
end

function Season123_2_1TaskView:_playGetRewardFinishAnim(index)
	if index then
		self.removeIndexTab = {
			index
		}
	end

	TaskDispatcher.runDelay(self.delayPlayFinishAnim, self, Season123_2_1TaskView.TaskGetAnimTime)
end

function Season123_2_1TaskView:delayPlayFinishAnim()
	self._taskAnimRemoveItem:removeByIndexs(self.removeIndexTab)
end

function Season123_2_1TaskView:endEnterAnimBlock()
	UIBlockMgr.instance:endBlock("playEnterSeason123_2_1TaskViewAnim")
end

function Season123_2_1TaskView:createStageMapItem()
	for index = 1, Season123_2_1TaskView.StageMapItemCount do
		local stageMapItem = self.stageMapItemTab[index]

		if not stageMapItem then
			stageMapItem = {
				itemGO = gohelper.findChild(self._gomapcontent, "go_item" .. index)
			}
			stageMapItem.item = MonoHelper.addNoUpdateLuaComOnceToGo(stageMapItem.itemGO, Season123_2_1TaskMapItem, {
				stage = index,
				actId = self.actId
			})
			stageMapItem.height = recthelper.getHeight(stageMapItem.itemGO:GetComponent(gohelper.Type_RectTransform))
			self.stageMapItemTab[index] = stageMapItem
		end

		gohelper.setActive(stageMapItem.itemGO, true)
		stageMapItem.item:refreshUI()
	end
end

function Season123_2_1TaskView:moveScrollPos()
	self.curStage = Season123TaskModel.instance.curStage

	local scrollHeight = recthelper.getHeight(self._scrollmaplist:GetComponent(gohelper.Type_RectTransform))
	local space = self.layoutGroup.spacing
	local frontItemHeight = 0

	for index = 1, self.curStage - 1 do
		frontItemHeight = frontItemHeight + self.stageMapItemTab[index].height
	end

	local targetPos = -scrollHeight / 2 + (self.curStage - 1) * space + frontItemHeight + self.stageMapItemTab[self.curStage].height / 2

	self.scrollMoveTweenId = ZProj.TweenHelper.DOAnchorPosY(self.mapcontentRectTrans, targetPos, 0.5, self.refreshArrowUI, self)

	for index, stageMapItem in ipairs(self.stageMapItemTab) do
		stageMapItem.item:setScale()
	end
end

function Season123_2_1TaskView:onClose()
	Season123TaskModel.instance:clear()
	UIBlockMgr.instance:endBlock("playEnterSeason123_2_1TaskViewAnim")
	TaskDispatcher.cancelTask(self.endEnterAnimBlock, self)
	TaskDispatcher.cancelTask(self.delayPlayFinishAnim, self)
	self.mapScroll:RemoveDragBeginListener()
	self.mapScroll:RemoveDragEndListener()
end

function Season123_2_1TaskView:onDestroyView()
	if self.scrollMoveTweenId then
		ZProj.TweenHelper.KillById(self.scrollMoveTweenId)
	end
end

return Season123_2_1TaskView
