-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sevendays/view/NewHandTargetView.lua

module("logic.extensions.sevendays.view.NewHandTargetView", package.seeall)

local NewHandTargetView = class("NewHandTargetView", ViewComponent)

function NewHandTargetView:ctor()
	NewHandTargetView.super.ctor(self)

	self._sevenDayTime = 7
	self._sevenOverTime = checknumber(ExcellentClassConfig.instance:getCommonCfgByKey("TIME_SEVEN-DAY"))
end

function NewHandTargetView:unbindEvents()
	NewHandTargetView.super.unbindEvents(self)
	self._btnSeven:RemoveClickListener()
	self._btnTwentyone:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnGoto:RemoveClickListener()
	self._btnTips:RemoveClickListener()
end

function NewHandTargetView:bindEvents()
	NewHandTargetView.super.bindEvents(self)
	self._btnSeven:AddClickListener(self._onClickSevenBtn, self)
	self._btnTwentyone:AddClickListener(self._onClickTwentyoneBtn, self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnGoto:AddClickListener(self._onClickSevenGotoPet, self)
	self._btnTips:AddClickListener(self._onClickTips, self)
end

function NewHandTargetView:buildUI()
	NewHandTargetView.super.buildUI(self)

	self._btnSeven = self:getBtn("btnSeven")
	self._btnTwentyone = self:getBtn("btnTwentyone")
	self._btnClose = self:getBtn("topleft/btnClose")
	self._btnGoto = self:getBtn("sevenTarget/btnGoto")
	self._btnTips = self:getBtn("topleft/btnTips")
	self._txtTime = self:getTxt("time/txtTime")
	self._imgSeven = self:getGo("btnSeven"):GetComponent(ComponentType.UIImageSpriteChange)
	self._imgTwentyone = self:getGo("btnTwentyone"):GetComponent(ComponentType.UIImageSpriteChange)
	self._txtColorSeven = self:getGo("btnSeven/Text"):GetComponent(ComponentType.UITextColorChange)
	self._txtColorTwentyone = self:getGo("btnTwentyone/Text"):GetComponent(ComponentType.UITextColorChange)
	self._sevenRedPoint = self:getGo("btnSeven/redPoint")
	self._twentyoneRedPoint = self:getGo("btnTwentyone/redPoint")
	self._sevenTarget = self:getGo("sevenTarget")
	self._twentyoneTarget = self:getGo("twentyoneTarget")
	self._sevenDay = SevenTargetView.New(self._sevenTarget, self)
	self._twentyoneDay = TwentyoneTargetView.New(self._twentyoneTarget, self)
end

function NewHandTargetView:onEnter()
	NewHandTargetView.super.onEnter(self)

	self._param = self:getOpenParam()

	self._sevenDay:onEnter(checknumber(self._param[1]))
	self._twentyoneDay:onEnter(checknumber(self._param[2]))
	self:_initOpenView()
	GlobalDispatcher:addListener("UpdataExcellentClassTask", self._refreshInfo, self)

	local redPointId1 = ExcellentClassConfig.instance:getRedPointIdByActId(checknumber(self._param[1]))
	local redPointId2 = ExcellentClassConfig.instance:getRedPointIdByActId(checknumber(self._param[2]))

	RedPointController.instance:regRedPoint(self._sevenRedPoint, redPointId1)
	RedPointController.instance:regRedPoint(self._twentyoneRedPoint, redPointId2)
end

function NewHandTargetView:onExit()
	NewHandTargetView.super.onExit(self)
	self._sevenDay:onExit()
	self._twentyoneDay:onExit()
	GlobalDispatcher:removeListener("UpdataExcellentClassTask", self._refreshInfo, self)
end

function NewHandTargetView:_onClickClose()
	self:close()
end

function NewHandTargetView:_onClickSevenBtn()
	if self:_judgeSevenIsOver() then
		FloatWordMgr.instance:show(lang("活动时间已过"))

		return
	end

	goutil.setActive(self._sevenTarget, true)
	goutil.setActive(self._twentyoneTarget, false)
	self._imgSeven:SetState(0)
	self._imgTwentyone:SetState(1)
	self._txtColorSeven:SetState(1)
	self._txtColorTwentyone:SetState(0)
	self:_setTime(checknumber(ExcellentClassConfig.instance:getCommonCfgByKey("TIME_SEVEN-DAY")))
	TrainerCourseNewAgent.instance:sendPM_TrainerCourseNewGetInfoReq(checknumber(self._param[1]))
end

function NewHandTargetView:_onClickTwentyoneBtn()
	local time = RoleModel.instance:getActiveTimeSec()
	local day = GameUtil.getDaysByTimestamp(time, ServerTime.now())

	if day < self._sevenDayTime then
		FloatWordMgr.instance:show("没到时间哦~")

		return
	end

	goutil.setActive(self._sevenTarget, false)
	goutil.setActive(self._twentyoneTarget, true)
	self._imgSeven:SetState(1)
	self._imgTwentyone:SetState(0)
	self._txtColorSeven:SetState(0)
	self._txtColorTwentyone:SetState(1)
	self:_setTime(checknumber(ExcellentClassConfig.instance:getCommonCfgByKey("TIME_TWENTYONE-DAY")))
	TrainerCourseNewAgent.instance:sendPM_TrainerCourseNewGetInfoReq(checknumber(self._param[2]))
end

function NewHandTargetView:_refreshInfo()
	if self._sevenTarget.activeInHierarchy then
		self._sevenDay:refreshTaskList()
	else
		self._twentyoneDay:refreshTaskList()
	end
end

function NewHandTargetView:_initOpenView()
	if self:_judgeSevenIsOver() then
		self:_onClickTwentyoneBtn()
	else
		self:_onClickSevenBtn()
	end
end

function NewHandTargetView:_judgeSevenIsOver()
	local day = GameUtil.getDaysByTimestamp(RoleModel.instance:getActiveTimeSec(), ServerTime.now())

	return day > self._sevenOverTime
end

function NewHandTargetView:_setTime(duration)
	local time = RoleModel.instance:getActiveTimeSec()
	local startTime, endTime = GameUtil.getTimestampOnStartAndEnd(time, 1, duration)
	local nowTime = ServerTime.now()

	self._txtTime.text = "剩余时间:" .. self:_formatTime(endTime - nowTime)
end

function NewHandTargetView:_formatTime(timeStamp)
	local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(timeStamp)

	return string.format("%d天%d小时", day, hour)
end

function NewHandTargetView:_onClickSevenGotoPet()
	UIStateManager.instance:clear()
	GotoMgr.gotoByString("zz_npc#10011017")
end

function NewHandTargetView:_onClickTips()
	UIStateManager.instance:push(ViewName.RulesView, "newhandtargetview_rule")
end

return NewHandTargetView
