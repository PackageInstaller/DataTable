-- chunkname: @modules/logic/sp01/act204/view/Activity204EntranceItemBase.lua

module("modules.logic.sp01.act204.view.Activity204EntranceItemBase", package.seeall)

local Activity204EntranceItemBase = class("Activity204EntranceItemBase", LuaCompBase)

function Activity204EntranceItemBase:init(go)
	self.go = go
	self._btnEntrance = gohelper.findChildButtonWithAudio(self.go, "root/#btn_Entrance")
	self._txtEntrance = gohelper.findChildText(self.go, "root/#btn_Entrance/txt_Entrance")
	self._txtTime = gohelper.findChildText(self.go, "root/LimitTime/#txt_Time")
	self._goRedPoint = gohelper.findChild(self.go, "root/#go_RedPoint")
	self._golocked = gohelper.findChild(self.go, "root/#go_Locked")
	self._gofinished = gohelper.findChild(self.go, "root/#go_Finished")
	self._gounlock = gohelper.findChild(self.go, "root/#go_unlock")
end

function Activity204EntranceItemBase:addEventListeners()
	self._btnEntrance:AddClickListener(self._btnEntranceOnClick, self)
end

function Activity204EntranceItemBase:_btnEntranceOnClick()
	local status, toastId, toastParam = self:_getActivityStatus()

	if status ~= ActivityEnum.ActivityStatus.Normal then
		if toastId then
			GameFacade.showToastWithTableParam(toastId, toastParam)
		end

		return
	end

	Activity204Controller.instance:jumpToActivity(self._actId)
end

function Activity204EntranceItemBase:removeEventListeners()
	self._btnEntrance:RemoveClickListener()
end

function Activity204EntranceItemBase:onUpdateMO(actId)
	self:initActInfo(actId)
	self:refreshUI()
	self:updateReddot()
	TaskDispatcher.cancelTask(self.refreshUI, self)
	TaskDispatcher.runRepeat(self.refreshUI, self, 1)
end

function Activity204EntranceItemBase:initActInfo(actId)
	self._actId = actId
	self._actCfg = ActivityConfig.instance:getActivityCo(actId)
	self._actMo = ActivityModel.instance:getActMO(actId)
	self._startTime = self._actMo:getRealStartTimeStamp()
	self._endTime = self._actMo:getRealEndTimeStamp()
end

function Activity204EntranceItemBase:refreshUI()
	if not self._actCfg then
		TaskDispatcher.cancelTask(self.refreshUI, self)

		return
	end

	self:updateStatus()
	self:refreshTitle()
	self:updateRemainTime()
end

function Activity204EntranceItemBase:refreshTitle()
	if self._actCfg then
		self._txtEntrance.text = self._actCfg.tabName or ""
	end
end

function Activity204EntranceItemBase:updateStatus()
	self._status = self:_getActivityStatus()
	self._isFinish = self._status == ActivityEnum.ActivityStatus.Expired or self._status == ActivityEnum.ActivityStatus.NotOnLine

	gohelper.setActive(self._golocked, self._status == ActivityEnum.ActivityStatus.NotOpen)
	gohelper.setActive(self._gofinished, self._isFinish)
end

function Activity204EntranceItemBase:_getActivityStatus()
	return ActivityHelper.getActivityStatusAndToast(self._actId)
end

function Activity204EntranceItemBase:updateRemainTime()
	local timeTipStr = self:_getTimeStr()

	self._txtTime.text = timeTipStr or ""
end

function Activity204EntranceItemBase:_getTimeStr()
	if not self._actMo then
		return
	end

	local status = self:_getActivityStatus()

	return self:_decorateTimeStr(status, self._startTime, self._endTime)
end

function Activity204EntranceItemBase:_decorateTimeStr(status, openTime, endTime)
	if not openTime or not endTime then
		return
	end

	local serverTime = ServerTime.now()
	local timeStr = ""

	if status == ActivityEnum.ActivityStatus.NotOpen then
		local remainTime2Open = openTime - serverTime

		timeStr = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("activity204entranceview_lock"), TimeUtil.SecondToActivityTimeFormat(remainTime2Open))
	elseif status == ActivityEnum.ActivityStatus.NotUnlock then
		if self._actCfg.openId ~= 0 then
			timeStr = OpenHelper.getActivityUnlockTxt(self._actCfg.openId)
		end
	elseif status == ActivityEnum.ActivityStatus.Normal then
		local remainTime2End = endTime - serverTime

		timeStr = remainTime2End > 0 and GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("activity204entranceview_open"), TimeUtil.SecondToActivityTimeFormat(remainTime2End)) or luaLang("turnback_end")
	else
		timeStr = luaLang("turnback_end")
	end

	return timeStr
end

function Activity204EntranceItemBase:updateReddot()
	if self._actCfg and self._actCfg.redDotId ~= 0 then
		RedDotController.instance:addRedDot(self._goRedPoint, self._actCfg.redDotId)
	end
end

function Activity204EntranceItemBase:onDestroy()
	TaskDispatcher.cancelTask(self.refreshUI, self)
end

return Activity204EntranceItemBase
