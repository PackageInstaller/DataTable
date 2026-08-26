-- chunkname: @modules/logic/sp02/paomian/enter/view/Sp02_GuessMeEntryItem.lua

module("modules.logic.sp02.paomian.enter.view.Sp02_GuessMeEntryItem", package.seeall)

local Sp02_GuessMeEntryItem = class("Sp02_GuessMeEntryItem", LuaCompBase)

function Sp02_GuessMeEntryItem.Get(go, actId)
	return MonoHelper.addNoUpdateLuaComOnceToGo(go, Sp02_GuessMeEntryItem, actId)
end

function Sp02_GuessMeEntryItem:ctor(actId)
	self._actId = actId
	self._activityCo = ActivityConfig.instance:getActivityCo(self._actId)
	self._activityName = self._activityCo and self._activityCo.name
	self._redDotId = self._activityCo and self._activityCo.redDotId
end

function Sp02_GuessMeEntryItem:init(go)
	self.go = go
	self._goLock = gohelper.findChild(self.go, "go_Lock")
	self._goNormal = gohelper.findChild(self.go, "go_Normal")
	self._goExpired = gohelper.findChild(self.go, "go_Expired")
	self._btnClick = gohelper.findChildButtonWithAudio(self.go, "btn_Click")
	self._goReddot = gohelper.findChild(self.go, "go_Reddot")
	self._txtTime1 = gohelper.findChildText(self.go, "go_Lock/bottombg/txt_Time")
	self._txtTime2 = gohelper.findChildText(self.go, "go_Normal/bottombg/txt_Time")
	self._txtTime3 = gohelper.findChildText(self.go, "go_Expired/bottombg/txt_Time")

	self:initRedDot()
end

function Sp02_GuessMeEntryItem:addEventListeners()
	self._btnClick:AddClickListener(self._btnClickOnClick, self)
end

function Sp02_GuessMeEntryItem:removeEventListeners()
	self._btnClick:RemoveClickListener()
end

function Sp02_GuessMeEntryItem:_btnClickOnClick()
	SDKDataTrackMgr.instance:trackClickEnterActivityButton("Sp02_PaoMian_MainView", "entry2")

	local status, toastId = ActivityHelper.getActivityStatusAndToast(self._actId)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		if toastId and toastId ~= 0 then
			GameFacade.showToast(toastId)
		end

		return
	end

	self:excuteClickCallback()
end

function Sp02_GuessMeEntryItem:excuteClickCallback()
	Sp02_PaoMianController.instance:openGuessMeView(self._actId, {
		activityId = self._actId
	})
end

function Sp02_GuessMeEntryItem:initRedDot()
	local taskList = Sp02_GuessMeConfig.instance:getConfigList(self._actId)
	local redDotInfoList = {}

	if taskList then
		for _, taskCo in ipairs(taskList) do
			local redDotInfo = {
				id = self._redDotId,
				uid = taskCo.id
			}

			table.insert(redDotInfoList, redDotInfo)
		end
	end

	RedDotController.instance:addMultiRedDot(self._goReddot, redDotInfoList)
end

function Sp02_GuessMeEntryItem:onUpdateMO()
	self._actMo = ActivityModel.instance:getActMO(self._actId)
	self._status = ActivityHelper.getActivityStatus(self._actId)
	self._isNormal = self._status == ActivityEnum.ActivityStatus.Normal
	self._isExpired = self._status == ActivityEnum.ActivityStatus.Expired
	self._isLock = not self._isNormal and not self._isExpired
	self._remainTimeStr = ActivityHelper.getActivityRemainTimeStr(self._actId)

	self:refreshUI()
end

function Sp02_GuessMeEntryItem:refreshUI()
	gohelper.setActive(self._goLock, self._isLock)
	gohelper.setActive(self._goNormal, self._isNormal)
	gohelper.setActive(self._goExpired, self._isExpired)
	self:refreshRemainTime()
end

function Sp02_GuessMeEntryItem:refreshRemainTime()
	local timeStr = ""

	if self._status == ActivityEnum.ActivityStatus.NotOpen then
		local openTime = self._actMo and self._actMo:getRealStartTimeStamp() or 0
		local remainTime = openTime - ServerTime.now()

		timeStr = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("sp02_paomian_mainview_open"), TimeUtil.SecondToActivityTimeFormat(remainTime))
	elseif self._status == ActivityEnum.ActivityStatus.NotUnlock then
		if self._activityCo and self._activityCo.openId ~= 0 then
			timeStr = OpenHelper.getActivityUnlockTxt(self._activityCo.openId)
		end
	else
		timeStr = ActivityHelper.getActivityRemainTimeStr(self._actId)
	end

	self._txtTime1.text = timeStr
	self._txtTime2.text = timeStr
	self._txtTime3.text = timeStr
end

function Sp02_GuessMeEntryItem:onDestroy()
	return
end

return Sp02_GuessMeEntryItem
