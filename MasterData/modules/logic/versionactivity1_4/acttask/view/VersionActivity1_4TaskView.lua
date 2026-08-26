-- chunkname: @modules/logic/versionactivity1_4/acttask/view/VersionActivity1_4TaskView.lua

module("modules.logic.versionactivity1_4.acttask.view.VersionActivity1_4TaskView", package.seeall)

local VersionActivity1_4TaskView = class("VersionActivity1_4TaskView", BaseView)

function VersionActivity1_4TaskView:onInitView()
	self.simageFullBg = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self.txtTime = gohelper.findChildTextMesh(self.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_LimitTime")
	self.btnNote = gohelper.findChildButtonWithAudio(self.viewGO, "Left/Note/#btn_note")
	self.goFinish = gohelper.findChild(self.viewGO, "Left/Note/#simage_finished")
	self.btnReward = gohelper.findChildButtonWithAudio(self.viewGO, "btnReward")
	self.simageIcon = gohelper.findChildSingleImage(self.viewGO, "btnReward/#simage_icon")

	local goRedDot = gohelper.findChild(self.viewGO, "Left/#go_reddot")

	self._redDot = RedDotController.instance:addRedDot(goRedDot, 1095)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_4TaskView:addEvents()
	return
end

function VersionActivity1_4TaskView:removeEvents()
	return
end

function VersionActivity1_4TaskView:_editableInitView()
	self.simageFullBg:LoadImage("singlebg/v1a4_taskview_singlebg/v1a4_taskview_fullbg.png")
	self.addClickCb(self, self.btnReward, self.onClickRewad, self)
	self.addClickCb(self, self.btnNote, self.onClickNote, self)
end

function VersionActivity1_4TaskView:onClickRewad()
	local scrollView = self.viewContainer:getScrollView()

	scrollView:moveToByCheckFunc(function(mo)
		return mo.config and mo.config.isKeyReward == 1 and mo.finishCount < mo.config.maxFinishCount
	end, 0.5, self.onFouceReward, self)
end

function VersionActivity1_4TaskView:onFouceReward()
	return
end

function VersionActivity1_4TaskView:onClickNote()
	Activity132Controller.instance:openCollectView(VersionActivity1_4Enum.ActivityId.Collect)
end

function VersionActivity1_4TaskView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mission_open)

	self.actId = self.viewParam.activityId

	self:initTab()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.ActivityDungeon
	}, self._onOpen, self)
	ActivityEnterMgr.instance:enterActivity(self.actId)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		self.actId
	})
end

function VersionActivity1_4TaskView:initTab()
	self.tabList = {}

	for i = 1, 3 do
		self.tabList[i] = self:createTab(i)
	end
end

function VersionActivity1_4TaskView:createTab(index)
	local item = self:getUserDataTb_()

	item.actId = self.actId
	item.index = index
	item.go = gohelper.findChild(self.viewGO, string.format("Top/#go_tab%s", index))
	item.goChoose = gohelper.findChild(item.go, "#go_choose")
	item.goRed = gohelper.findChild(item.go, "#go_reddot")
	item.btn = gohelper.findChildButtonWithAudio(item.go, "#btn")

	function item.refreshRed(tabItem)
		tabItem.redDot.show = VersionActivity1_4TaskListModel.instance:checkTaskRedByPage(tabItem.actId, tabItem.index)

		tabItem.redDot:showRedDot(1)
	end

	item.redDot = MonoHelper.addNoUpdateLuaComOnceToGo(item.goRed, CommonRedDotIcon)

	item.redDot:setMultiId({
		id = 1096
	})
	item.redDot:overrideRefreshDotFunc(item.refreshRed, item)
	item.redDot:refreshDot()
	self.addClickCb(self, item.btn, self.onClickTab, self, index)

	return item
end

function VersionActivity1_4TaskView:refreshTabRed()
	for k, v in pairs(self.tabList) do
		v.redDot:refreshDot()
	end
end

function VersionActivity1_4TaskView:onClickTab(index)
	if self.tabIndex == index then
		return
	end

	self.tabIndex = index

	for i, v in ipairs(self.tabList) do
		gohelper.setActive(v.goChoose, i == self.tabIndex)
	end

	self:refreshRight()
end

function VersionActivity1_4TaskView:_onOpen()
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self.refreshRight, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self.refreshRight, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self.refreshRight, self)
	TaskDispatcher.runRepeat(self.refreshRemainTime, self, TimeUtil.OneMinuteSecond)
	self:refreshLeft()
	self:onClickTab(1)
end

function VersionActivity1_4TaskView:refreshLeft()
	self:refreshRemainTime()
end

function VersionActivity1_4TaskView:refreshRemainTime()
	local actInfoMo = ActivityModel.instance:getActMO(self.actId)
	local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()
	local day = Mathf.Floor(offsetSecond / TimeUtil.OneDaySecond)
	local hourSecond = offsetSecond % TimeUtil.OneDaySecond
	local hour = Mathf.Floor(hourSecond / TimeUtil.OneHourSecond)

	if day > 0 then
		self.txtTime.text = string.format(luaLang("remain"), string.format("%s%s%s%s", day, luaLang("time_day"), hour, luaLang("time_hour")))
	else
		local minuteSecond = hourSecond % TimeUtil.OneHourSecond
		local minute = Mathf.Floor(minuteSecond / TimeUtil.OneMinuteSecond)

		self.txtTime.text = hour > 0 and string.format(luaLang("remain"), string.format("%s%s%s%s", hour, luaLang("time_hour"), minute, luaLang("time_minute2"))) or minute > 0 and string.format(luaLang("remain"), string.format("%s%s", minute, luaLang("time_minute"))) or string.format(luaLang("remain"), string.format("<1%s", luaLang("time_minute")))
	end
end

function VersionActivity1_4TaskView:refreshRight()
	VersionActivity1_4TaskListModel.instance:sortTaskMoList(self.actId, self.tabIndex)

	local keyMo = VersionActivity1_4TaskListModel.instance:getKeyRewardMo()
	local hasKeyReward = keyMo ~= nil

	gohelper.setActive(self.btnReward, hasKeyReward)

	if hasKeyReward then
		local rewardList = GameUtil.splitString2(keyMo.config.bonus, true, "|", "#")
		local firstReward = rewardList[1]
		local type, id = firstReward[1], firstReward[2]
		local _, icon = ItemModel.instance:getItemConfigAndIcon(type, id, true)

		self.simageIcon:LoadImage(icon)
	end

	gohelper.setActive(self.goFinish, VersionActivity1_4TaskListModel.instance.allTaskFinish)
	self:refreshTabRed()
end

function VersionActivity1_4TaskView:onClose()
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
end

function VersionActivity1_4TaskView:onDestroyView()
	self.simageFullBg:UnLoadImage()
	self.simageIcon:UnLoadImage()
end

return VersionActivity1_4TaskView
