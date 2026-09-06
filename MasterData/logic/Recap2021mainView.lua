-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recap2021/view/Recap2021mainView.lua

module("logic.extensions.recap2021.view.Recap2021mainView", package.seeall)

local Recap2021mainView = class("Recap2021mainView", ViewComponent)

function Recap2021mainView:ctor()
	Recap2021mainView.super.ctor(self)
end

function Recap2021mainView:unbindEvents()
	Recap2021mainView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnRule:RemoveClickListener()
	self._btnJumpPersonEvent:RemoveClickListener()
	self._btnJumpGameEvent:RemoveClickListener()
	self._btnJumpMassage:RemoveClickListener()
end

function Recap2021mainView:bindEvents()
	Recap2021mainView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnRule:AddClickListener(self._onClickbtnRule, self)
	self._btnJumpPersonEvent:AddClickListener(self._onClickbtnJumpPersonEvent, self)
	self._btnJumpGameEvent:AddClickListener(self._onClickbtnJumpGameEvent, self)
	self._btnJumpMassage:AddClickListener(self._onClickbtnJumpMassage, self)
end

function Recap2021mainView:buildUI()
	Recap2021mainView.super.buildUI(self)

	self._txtTime = goutil.findChildTextComponent(self.mainGO, "time/txt")
	self._img2Go = self:getGo("img2")
	self._img1Go = self:getGo("img1")
	self._btnClose = self:getBtn("btnClose")
	self._btnRule = self:getBtn("btnRule")
	self._btnJumpPersonEvent = self:getBtn("btnJumpPersonEvent")
	self._btnJumpGameEvent = self:getBtn("btnJumpGameEvent")
	self._btnJumpMassage = self:getBtn("btnJumpMassage")
	self._game_redpointGo = self:getGo("btnJumpGameEvent/redpoint")
	self._massge_redpointGo = self:getGo("btnJumpMassage/redpoint")
	self._person_redpointGo = self:getGo("btnJumpPersonEvent/redpoint")
	self._effectGo = self:getGo("effect")
end

function Recap2021mainView:onExit()
	Recap2021mainView.super.onExit(self)
	GlobalDispatcher:removeListener(Recap2021Controller.PM_Recap21GetInfoRes, self._PM_Recap21GetInfoRes, self)
	GlobalDispatcher:removeListener(Recap2021Controller.UpdateShareData, self._UpdateShareData, self)
	GlobalDispatcher:removeListener(Recap2021Controller.PM_Recap21GainLetterPrizeRes, self._updateRedPoint, self)
	UIEffectManager.instance:stopEffect(self._effectHandler)
end

function Recap2021mainView:onEnter()
	Recap2021mainView.super.onEnter(self)

	self._activityType = GameEnum.ActivityType.RECAP_2021
	self._activityId = Recap2021Config.instance:getCommonValue("ACTIVITY_ID", true)

	GlobalDispatcher:addListener(Recap2021Controller.PM_Recap21GetInfoRes, self._PM_Recap21GetInfoRes, self)
	GlobalDispatcher:addListener(Recap2021Controller.UpdateShareData, self._UpdateShareData, self)
	GlobalDispatcher:addListener(Recap2021Controller.PM_Recap21GainLetterPrizeRes, self._updateRedPoint, self)
	Recap2021Agent.instance:sendPM_Recap21GetInfoReq()
	Recap2021Controller.instance:sendPM_GetShareLinkDataReq(10)
	self:_setActTime()
	self:_updateRedPoint()
	self:_playEffect()
end

function Recap2021mainView:_onClickbtnClose()
	self:close()
end

function Recap2021mainView:_onClickbtnRule()
	TipsFacade.instance:openRulesView("recap2021mainview")
end

function Recap2021mainView:_onClickbtnJumpPersonEvent()
	UIStateManager.instance:push(ViewName.Recap2021presonlookbackView)
end

function Recap2021mainView:_onClickbtnJumpGameEvent()
	UIStateManager.instance:push(ViewName.Recap2021gamelookbackView)
end

function Recap2021mainView:_onClickbtnJumpMassage()
	UIStateManager.instance:push(ViewName.Recap2021teammsgView)
end

function Recap2021mainView:_PM_Recap21GetInfoRes(status)
	if status == 0 then
		self:_updateRedPoint()
	end
end

function Recap2021mainView:_UpdateShareData()
	self:_updateRedPoint()
end

function Recap2021mainView:_setActTime()
	local stime, etime = ActivityDefineController.instance:getStartTimeAndEndTime(self._activityType, self._activityId)
	local sDate = GameUtil.time2date(stime)
	local eDate = GameUtil.time2date(etime)
	local startTime = string.format("%s.%s %s:00", sDate.month, sDate.day, sDate.hour)
	local endTime = string.format("%s.%s %s:00", eDate.month, eDate.day, eDate.hour)

	self._txtTime.text = string.format("活动时间：%s - %s", startTime, endTime)
end

function Recap2021mainView:_updateRedPoint()
	local isGameRed = Recap2021Model.instance:checkGameEventPrizeRed()
	local isPersonRed = Recap2021Model.instance:checkPersonEventPrizeRed()
	local isMsgRed = Recap2021Model.instance:checkMsgPrizeRed()

	goutil.setActive(self._game_redpointGo, isGameRed)
	goutil.setActive(self._massge_redpointGo, isMsgRed)
	goutil.setActive(self._person_redpointGo, isPersonRed)
end

function Recap2021mainView:_playEffect()
	local effName = "20220401/zhounianqingzongjie/fx_ui_zhounianzongjie_jiemian.prefab"

	self._effectHandler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, true)

	self._effectHandler:setParent(self._effectGo.transform)
	self._effectHandler:setLocalPos(0, 0, 0)
	self._effectHandler:setScale(1)
end

return Recap2021mainView
