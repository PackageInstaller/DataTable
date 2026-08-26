-- chunkname: @modules/logic/versionactivity1_2/versionactivity1_2dungeonother/view/VersionActivity1_2TaskView.lua

module("modules.logic.versionactivity1_2.versionactivity1_2dungeonother.view.VersionActivity1_2TaskView", package.seeall)

local VersionActivity1_2TaskView = class("VersionActivity1_2TaskView", BaseView)

function VersionActivity1_2TaskView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._simagelangtxt = gohelper.findChildSingleImage(self.viewGO, "left/#simage_langtxt")
	self._txtremaintime = gohelper.findChildText(self.viewGO, "left/#simage_langtxt/#txt_remaintime")
	self._txtcurrencynum = gohelper.findChildText(self.viewGO, "left/node/cn/#txt_currencynum")
	self._scrolllist = gohelper.findChildScrollRect(self.viewGO, "#scroll_list")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_2TaskView:addEvents()
	return
end

function VersionActivity1_2TaskView:removeEvents()
	return
end

function VersionActivity1_2TaskView:onClickStore()
	VersionActivity1_2EnterController.instance:openActivityStoreView()
end

function VersionActivity1_2TaskView:_editableInitView()
	self._simagebg:LoadImage(ResUrl.getVersionActivity1_2TaskImage("renwu_bj"))

	self.storeClick = gohelper.findChildClick(self.viewGO, "left/node")

	self.storeClick:AddClickListener(self.onClickStore, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshCurrency, self)
end

function VersionActivity1_2TaskView:onUpdateParam()
	return
end

function VersionActivity1_2TaskView:onOpen()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.ActivityDungeon
	}, self._onOpen, self)
end

function VersionActivity1_2TaskView:_onOpen()
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self.refreshRight, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self.refreshRight, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self.refreshRight, self)
	TaskDispatcher.runRepeat(self.refreshRemainTime, self, TimeUtil.OneMinuteSecond)
	VersionActivity1_2TaskListModel.instance:initTask()
	self:refreshLeft()
	self:refreshRight()
end

function VersionActivity1_2TaskView:refreshLeft()
	self:refreshRemainTime()
	self:refreshCurrency()
end

function VersionActivity1_2TaskView:refreshRemainTime()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[VersionActivity1_2Enum.ActivityId.Dungeon]
	local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()
	local day = Mathf.Floor(offsetSecond / TimeUtil.OneDaySecond)
	local hourSecond = offsetSecond % TimeUtil.OneDaySecond
	local hour = Mathf.Floor(hourSecond / TimeUtil.OneHourSecond)

	if day > 0 then
		self._txtremaintime.text = string.format(luaLang("remain"), string.format("%s%s%s%s", day, luaLang("time_day"), hour, luaLang("time_hour")))
	else
		local minuteSecond = hourSecond % TimeUtil.OneHourSecond
		local minute = Mathf.Floor(minuteSecond / TimeUtil.OneMinuteSecond)

		self._txtremaintime.text = hour > 0 and string.format(luaLang("remain"), string.format("%s%s%s%s", hour, luaLang("time_hour"), minute, luaLang("time_minute2"))) or minute > 0 and string.format(luaLang("remain"), string.format("%s%s", minute, luaLang("time_minute"))) or string.format(luaLang("remain"), string.format("<1%s", luaLang("time_minute")))
	end
end

function VersionActivity1_2TaskView:refreshCurrency()
	local currencyMo = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.LvHuEMen)

	self._txtcurrencynum.text = currencyMo and GameUtil.numberDisplay(currencyMo.quantity) or 0
end

function VersionActivity1_2TaskView:refreshRight()
	VersionActivity1_2TaskListModel.instance:sortTaskMoList()
	VersionActivity1_2TaskListModel.instance:refreshList()
end

function VersionActivity1_2TaskView:onClose()
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
end

function VersionActivity1_2TaskView:onDestroyView()
	self._simagebg:UnLoadImage()
	self.storeClick:RemoveClickListener()
end

return VersionActivity1_2TaskView
