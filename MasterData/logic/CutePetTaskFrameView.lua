-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eventtasksummary/view/tab/cutepet/CutePetTaskFrameView.lua

module("logic.extensions.eventtasksummary.view.tab.cutepet.CutePetTaskFrameView", package.seeall)

local CutePetTaskFrameView = class("CutePetTaskFrameView", EventTaskTabFrameView)

function CutePetTaskFrameView:ctor()
	self._activityIdList = {
		17082,
		17083
	}
end

function CutePetTaskFrameView:buildUI()
	CutePetTaskFrameView.super.buildUI(self)

	self._btnJumpTo = self:getGo("btnJump")
	self._txtTime = self:getTxt("time/txt")
	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
end

function CutePetTaskFrameView:bindEvents()
	CutePetTaskFrameView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnJumpTo, self._onClickJumpTo, self)
end

function CutePetTaskFrameView:unbindEvents()
	CutePetTaskFrameView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnJumpTo)
end

function CutePetTaskFrameView:onEnter()
	self._activityId = self:_getCurActId()

	if self._activityId <= 0 then
		printError("活动id错误")
		self:close()

		return
	end

	local timeCfg = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.Summary, self._activityId)
	local startTime = GameUtil.string2date(timeCfg.startTime)
	local endTime = GameUtil.string2date(timeCfg.endTime)

	self._txtTime.text = langPara("活动时间：%d.%d %02d:%02d - %d.%d %02d:%02d", startTime.month, startTime.day, startTime.hour, startTime.min, endTime.month, endTime.day, endTime.hour, endTime.min)

	if self._eventTaskMgr == nil then
		self._eventTaskMgr = EventTaskMgr.New()
	end

	self._eventTaskMgr:onEnter(self._activityId)

	self._curTabIdx = 1

	self:_onSetUI()
	GlobalDispatcher:addListener(GlobalNotify.PM_EventTaskTabChildExit, self.close, self)
	GlobalDispatcher:addListener(GlobalNotify.PM_EventTaskTabUpdate, self._onUpdate, self)
	EventTaskSummaryController.instance:onSendEventTaskSummaryGetInfoReq(self._activityId)
	self:_onUpdate()
end

function CutePetTaskFrameView:_getCurActId()
	local actId = 0

	for i, v in ipairs(self._activityIdList) do
		if ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.Summary, v) then
			actId = v

			break
		end
	end

	return actId
end

function CutePetTaskFrameView:_onClickJumpTo()
	GotoMgr.gotoByString("func#923")
end

return CutePetTaskFrameView
