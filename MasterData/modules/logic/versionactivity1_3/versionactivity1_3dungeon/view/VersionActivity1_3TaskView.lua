-- chunkname: @modules/logic/versionactivity1_3/versionactivity1_3dungeon/view/VersionActivity1_3TaskView.lua

module("modules.logic.versionactivity1_3.versionactivity1_3dungeon.view.VersionActivity1_3TaskView", package.seeall)

local VersionActivity1_3TaskView = class("VersionActivity1_3TaskView", BaseView)

function VersionActivity1_3TaskView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_LimitTime")
	self._txtPropNum = gohelper.findChildText(self.viewGO, "Left/Prop/txt_PropName/#txt_PropNum")
	self._btnshop = gohelper.findChildButtonWithAudio(self.viewGO, "Left/Prop/#btn_shop")
	self._scrollTaskList = gohelper.findChildScrollRect(self.viewGO, "#scroll_TaskList")
	self._goBackBtns = gohelper.findChild(self.viewGO, "#go_BackBtns")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_3TaskView:addEvents()
	self._btnshop:AddClickListener(self._btnshopOnClick, self)
end

function VersionActivity1_3TaskView:removeEvents()
	self._btnshop:RemoveClickListener()
end

function VersionActivity1_3TaskView:_btnshopOnClick()
	VersionActivity1_3EnterController.instance:openStoreView()
end

function VersionActivity1_3TaskView:_editableInitView()
	self._simageFullBG:LoadImage(ResUrl.getV1a3TaskViewSinglebg("v1a3_taskview_fullbg"))

	self._txtremaintime = gohelper.findChildText(self.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_LimitTime")

	self:refreshCurrency()
end

function VersionActivity1_3TaskView:refreshCurrency()
	local currencyMO = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.Planet)

	if currencyMO then
		if not currencyMO.quantity then
			local quantity = 0

			self._txtPropNum.text = GameUtil.numberDisplay(quantity)
		end
	end
end

function VersionActivity1_3TaskView:onUpdateParam()
	return
end

function VersionActivity1_3TaskView:onOpen()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.ActivityDungeon
	}, self._onOpen, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshCurrency, self)
end

function VersionActivity1_3TaskView:_onOpen()
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self.refreshRight, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self.refreshRight, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self.refreshRight, self)
	TaskDispatcher.runRepeat(self.refreshRemainTime, self, TimeUtil.OneMinuteSecond)
	VersionActivity1_3TaskListModel.instance:initTask()
	self:refreshLeft()
	self:refreshRight()
end

function VersionActivity1_3TaskView:refreshLeft()
	self:refreshRemainTime()
end

function VersionActivity1_3TaskView:refreshRemainTime()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[VersionActivity1_3Enum.ActivityId.Dungeon]
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

function VersionActivity1_3TaskView:refreshRight()
	VersionActivity1_3TaskListModel.instance:sortTaskMoList()
	VersionActivity1_3TaskListModel.instance:refreshList()
end

function VersionActivity1_3TaskView:onClose()
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
end

function VersionActivity1_3TaskView:onDestroyView()
	self._simageFullBG:UnLoadImage()
end

return VersionActivity1_3TaskView
