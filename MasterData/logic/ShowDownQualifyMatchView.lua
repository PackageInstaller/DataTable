-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/view/ShowDownQualifyMatchView.lua

module("logic.extensions.numberbomb.view.ShowDownQualifyMatchView", package.seeall)

local ShowDownQualifyMatchView = class("ShowDownQualifyMatchView", ViewComponent)

function ShowDownQualifyMatchView:ctor()
	ShowDownQualifyMatchView.super.ctor(self)

	self._isSendMsg = false
	self._waitTime = 2
	self._sussTime = 0
end

function ShowDownQualifyMatchView:buildUI()
	ShowDownQualifyMatchView.super.buildUI(self)

	self._btnCancel = goutil.findChild(self.mainGO, "btnCancel")
	self._txtTime = goutil.findChildTextComponent(self.mainGO, "txtTime")
end

function ShowDownQualifyMatchView:bindEvents()
	ShowDownQualifyMatchView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnCancel, self._onClickCancleBtn, self)
end

function ShowDownQualifyMatchView:unbindEvents()
	ShowDownQualifyMatchView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnCancel)
end

function ShowDownQualifyMatchView:onEnter()
	ShowDownQualifyMatchView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._qualType = params[2]
	self._activityType = ShowDownController.instance:getActivityType()

	local isInTime = ShowDownController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._qualifyData = ShowDownConfig.instance:getQualifyData(self._activityId, self._qualType)
	self._battleResult = nil
	self._maxTimeSec = self._qualifyData.maxMatchingTimeSec + 2
	self._curTimeSec = 0
	self._txtTime.text = string.format("00：%02d", self._curTimeSec)
	self._waitTime = 2
	self._sussTime = 0
	self._isSendMsg = false
	self._startMatchTime = ServerTime.now()

	settimer(0.2, self._calculationSurplusTime, self, true)

	local effPath = "fx_ui_zdsz/fx_ui_zdsz_pipei.prefab"

	self._pmEff = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 0, 0, true, nil, nil, nil, self)

	self._pmEff:setParent(self.mainGO.transform)
	self._pmEff:setLocalPos(0, 0, 0)
	self._pmEff:setScale(1)
	self.addGEvent(self, GlobalNotify.HandlePM_ShowDownQualify_CancelMatchingRes, self._handlePM_ShowDownQualify_CancelMatchingRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_ShowDownQualify_NotifyMatchFailRes, self._handlePM_ShowDownQualify_NotifyMatchFailRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_ShowDownQualify_NotifyMatchBattleResultRes, self._handlePM_ShowDownQualify_NotifyMatchBattleResultRes, self)
end

function ShowDownQualifyMatchView:onExit()
	ShowDownQualifyMatchView.super.onExit(self)

	if self._pmEff then
		UIEffectManager.instance:stopEffect(self._pmEff)

		self._pmEff = nil
	end

	removetimer(self._calculationSurplusTime, self)
	removetimer(self._startFight, self)
end

function ShowDownQualifyMatchView:_handlePM_ShowDownQualify_CancelMatchingRes()
	self:close()
end

function ShowDownQualifyMatchView:_handlePM_ShowDownQualify_NotifyMatchFailRes(status)
	self:_matchFail()
end

function ShowDownQualifyMatchView:_handlePM_ShowDownQualify_NotifyMatchBattleResultRes(msg)
	local detail = msg.detail

	self._battleResult = detail and detail.battleResult or nil

	self:_matchSuccess()
end

function ShowDownQualifyMatchView:_calculationSurplusTime()
	self._curTimeSec = Mathf.Floor(ServerTime.now() - self._startMatchTime)
	self._txtTime.text = string.format("00：%02d", self._curTimeSec)

	if self._curTimeSec > self._maxTimeSec then
		self._txtTime.text = "未匹配到玩家"

		if self._curTimeSec >= self._maxTimeSec then
			self:_matchFail()
		end
	end
end

function ShowDownQualifyMatchView:_matchSuccess()
	GameUtil.SetActive(self._btnCancel, false)
	settimer(2, self._startFight, self)
end

function ShowDownQualifyMatchView:_matchFail()
	removetimer(self._calculationSurplusTime, self)
	FloatWordMgr.instance:show("匹配失败")
	self:close()
end

function ShowDownQualifyMatchView:_startFight()
	self:close()
	UIStateManager.instance:push(ViewName.ShowDownQualifyMatchSuccessView, self._activityId, self._battleResult)
end

function ShowDownQualifyMatchView:_onClickCancleBtn()
	if self._isSendMsg == true then
		return
	end

	self._isSendMsg = true

	ShowDownController.instance:sendPM_ShowDownQualify_CancelMatchingReq(self._activityId)
end

return ShowDownQualifyMatchView
