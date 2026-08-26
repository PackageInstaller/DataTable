-- chunkname: @modules/logic/towercompose/view/TowerComposeTaskView.lua

module("modules.logic.towercompose.view.TowerComposeTaskView", package.seeall)

local TowerComposeTaskView = class("TowerComposeTaskView", BaseView)

function TowerComposeTaskView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._goLimitTime = gohelper.findChild(self.viewGO, "Left/LimitTime")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_LimitTime")
	self._goselectNormal = gohelper.findChild(self.viewGO, "taskTypeContent/go_normal/#go_selectNormal")
	self._btnnormalClick = gohelper.findChildButtonWithAudio(self.viewGO, "taskTypeContent/go_normal/#btn_normalClick")
	self._golimitTime = gohelper.findChild(self.viewGO, "taskTypeContent/go_limitTime")
	self._goselectLimitTime = gohelper.findChild(self.viewGO, "taskTypeContent/go_limitTime/#go_selectLimitTime")
	self._btnlimitTimeClick = gohelper.findChildButtonWithAudio(self.viewGO, "taskTypeContent/go_limitTime/#btn_limitTimeClick")
	self._godeadline = gohelper.findChild(self.viewGO, "taskTypeContent/go_limitTime/#go_deadline")
	self._txttime = gohelper.findChildText(self.viewGO, "taskTypeContent/go_limitTime/#go_deadline/#txt_time")
	self._txtformat = gohelper.findChildText(self.viewGO, "taskTypeContent/go_limitTime/#go_deadline/#txt_time/#txt_format")
	self._scrollTaskList = gohelper.findChildScrollRect(self.viewGO, "#scroll_TaskList")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")
	self._gomodTipPos = gohelper.findChild(self.viewGO, "#go_modTipPos")
	self._gonormalReddot = gohelper.findChild(self.viewGO, "taskTypeContent/go_normal/#go_normalReddot")
	self._golimitReddot = gohelper.findChild(self.viewGO, "taskTypeContent/go_limitTime/#go_limitTimeReddot")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerComposeTaskView:addEvents()
	self._btnnormalClick:AddClickListener(self._btnnormalClickOnClick, self)
	self._btnlimitTimeClick:AddClickListener(self._btnlimitTimeClickOnClick, self)
	self.addEventCb(self, TowerComposeController.instance, TowerComposeEvent.OnTaskRewardGetFinish, self._playGetRewardFinishAnim, self)
	self.addEventCb(self, TowerComposeController.instance, TowerComposeEvent.ShowModDescTip, self.showModDescTip, self)
	self.addEventCb(self, TowerComposeController.instance, TowerComposeEvent.TowerComposeTaskUpdated, self.refreshUI, self)
end

function TowerComposeTaskView:removeEvents()
	self._btnnormalClick:RemoveClickListener()
	self._btnlimitTimeClick:RemoveClickListener()
	self.removeEventCb(self, TowerComposeController.instance, TowerComposeEvent.OnTaskRewardGetFinish, self._playGetRewardFinishAnim, self)
	self.removeEventCb(self, TowerComposeController.instance, TowerComposeEvent.ShowModDescTip, self.showModDescTip, self)
	self.removeEventCb(self, TowerComposeController.instance, TowerComposeEvent.TowerComposeTaskUpdated, self.refreshUI, self)
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
end

TowerComposeTaskView.TaskMaskTime = 0.65
TowerComposeTaskView.TaskGetAnimTime = 0.567

function TowerComposeTaskView:_btnlimitTimeClickOnClick()
	if self.curTaskType == TowerComposeEnum.TaskType.LimitTime then
		return
	end

	TowerComposeTaskModel.instance:setSelectTaskType(TowerComposeEnum.TaskType.LimitTime)
	self:refreshSelectState()
end

function TowerComposeTaskView:_btnnormalClickOnClick()
	if self.curTaskType == TowerComposeEnum.TaskType.Normal then
		return
	end

	TowerComposeTaskModel.instance:setSelectTaskType(TowerComposeEnum.TaskType.Normal)
	self:refreshSelectState()
end

function TowerComposeTaskView:_editableInitView()
	self._taskAnimRemoveItem = ListScrollAnimRemoveItem.Get(self.viewContainer.scrollView)

	self._taskAnimRemoveItem:setMoveInterval(0)
	self._taskAnimRemoveItem:setMoveAnimationTime(TowerComposeTaskView.TaskMaskTime - TowerComposeTaskView.TaskGetAnimTime)

	self.removeIndexTab = {}
end

function TowerComposeTaskView:onUpdateParam()
	return
end

function TowerComposeTaskView:onOpen()
	self:refreshUI()
end

function TowerComposeTaskView:refreshUI()
	self:refreshTab()
	self:refreshSelectState()
	self:refreshRemainTime()
	self:refreshReddot()
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
	TaskDispatcher.runRepeat(self.refreshRemainTime, self, 1)
end

function TowerComposeTaskView:refreshRemainTime()
	local timeStamp = TowerComposeTaskModel.instance:getTaskLimitTime()

	if timeStamp and timeStamp > 0 then
		local timeStr = TimeUtil.SecondToActivityTimeFormat(timeStamp)

		self._txtLimitTime.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("activity204entranceview_open"), timeStr)

		local date, dateformate = TimeUtil.secondToRoughTime2(timeStamp, true)

		self._txttime.text = date
		self._txtformat.text = dateformate

		gohelper.setActive(self._godeadline, true)
		gohelper.setActive(self._goLimitTime, true)
	else
		self._txtLimitTime.text = ""

		gohelper.setActive(self._godeadline, false)
		gohelper.setActive(self._goLimitTime, false)
		self:_btnnormalClickOnClick()
	end
end

function TowerComposeTaskView:refreshTab()
	local limitTimeTaskMoList = TowerComposeTaskModel.instance:getLimitTimeTaskList()

	gohelper.setActive(self._golimitTime, #limitTimeTaskMoList > 0)
end

function TowerComposeTaskView:refreshSelectState()
	self._scrollTaskList.verticalNormalizedPosition = 1
	self.curTaskType = TowerComposeTaskModel.instance.curSelectTaskType

	gohelper.setActive(self._goselectNormal, self.curTaskType == TowerComposeEnum.TaskType.Normal)
	gohelper.setActive(self._goselectLimitTime, self.curTaskType == TowerComposeEnum.TaskType.LimitTime)
	TowerComposeTaskModel.instance:refreshList(self.curTaskType)
end

function TowerComposeTaskView:refreshReddot()
	local normalCanShowReddot = TowerComposeTaskModel.instance:canShowReddot(TowerComposeEnum.TaskType.Normal)
	local limitCanShowReddot = TowerComposeTaskModel.instance:canShowReddot(TowerComposeEnum.TaskType.LimitTime)

	gohelper.setActive(self._gonormalReddot, normalCanShowReddot)
	gohelper.setActive(self._golimitReddot, limitCanShowReddot)
end

function TowerComposeTaskView:_playGetRewardFinishAnim(index)
	if index then
		self.removeIndexTab = {
			index
		}
	end

	TaskDispatcher.runDelay(self.delayPlayFinishAnim, self, TowerComposeTaskView.TaskGetAnimTime)
end

function TowerComposeTaskView:delayPlayFinishAnim()
	self._taskAnimRemoveItem:removeByIndexs(self.removeIndexTab)
end

function TowerComposeTaskView:showModDescTip(modIdList)
	local param = {}

	param.modIdList = modIdList
	param.parentGO = self._gomodTipPos
	param.pivot = Vector2(0.5, 1)

	TowerComposeController.instance:openTowerComposeModDescTipView(param)
end

function TowerComposeTaskView:onClose()
	return
end

function TowerComposeTaskView:onDestroyView()
	return
end

return TowerComposeTaskView
