-- chunkname: @modules/logic/sp02/paomian/enter/view/Sp02_MarcusEntryItem.lua

module("modules.logic.sp02.paomian.enter.view.Sp02_MarcusEntryItem", package.seeall)

local Sp02_MarcusEntryItem = class("Sp02_MarcusEntryItem", LuaCompBase)

function Sp02_MarcusEntryItem.Get(go, actId)
	return MonoHelper.addNoUpdateLuaComOnceToGo(go, Sp02_MarcusEntryItem, actId)
end

function Sp02_MarcusEntryItem:ctor(actId)
	self._actId = actId
	self._activityCo = ActivityConfig.instance:getActivityCo(self._actId)
	self._activityName = self._activityCo and self._activityCo.name
	self._redDotId = self._activityCo and self._activityCo.redDotId
end

function Sp02_MarcusEntryItem:init(go)
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

function Sp02_MarcusEntryItem:addEventListeners()
	self._btnClick:AddClickListener(self._btnClickOnClick, self)
end

function Sp02_MarcusEntryItem:removeEventListeners()
	self._btnClick:RemoveClickListener()
end

function Sp02_MarcusEntryItem:_btnClickOnClick()
	SDKDataTrackMgr.instance:trackClickEnterActivityButton("Sp02_PaoMian_MainView", "entry1")

	local status, toastId = ActivityHelper.getActivityStatusAndToast(self._actId)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		if toastId and toastId ~= 0 then
			GameFacade.showToast(toastId)
		end

		return
	end

	Sp02_PaoMianController.instance:openMarcusView(self._actId, {
		activityId = self._actId
	})
end

function Sp02_MarcusEntryItem:initRedDot()
	local taskList = Sp02_MarcusConfig.instance:getBonusList(self._actId)
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

function Sp02_MarcusEntryItem:onUpdateMO()
	self._actMo = ActivityModel.instance:getActMO(self._actId)
	self._status = ActivityHelper.getActivityStatus(self._actId)
	self._isNormal = self._status == ActivityEnum.ActivityStatus.Normal
	self._isExpired = self._status == ActivityEnum.ActivityStatus.Expired
	self._isLock = not self._isNormal and not self._isExpired

	self:refreshRemainTime()
	self:refreshUI()
end

function Sp02_MarcusEntryItem:refreshUI()
	gohelper.setActive(self._goLock, self._isLock)
	gohelper.setActive(self._goNormal, self._isNormal)
	gohelper.setActive(self._goExpired, self._isExpired)
end

function Sp02_MarcusEntryItem:refreshRemainTime()
	local timeStr = Sp02_PaoMianController.instance:getMarcusRemainTimeStr(self._actId)

	self._txtTime1.text = timeStr
	self._txtTime2.text = timeStr
	self._txtTime3.text = timeStr
end

function Sp02_MarcusEntryItem:onDestroy()
	return
end

return Sp02_MarcusEntryItem
