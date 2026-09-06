-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesstrial/view/GoddessTrialMainView.lua

module("logic.extensions.goddesstrial.view.GoddessTrialMainView", package.seeall)

local GoddessTrialMainView = class("GoddessTrialMainView", ViewComponent)

function GoddessTrialMainView:ctor()
	GoddessTrialMainView.super.ctor(self)
end

function GoddessTrialMainView:unbindEvents()
	GoddessTrialMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnBoss)
	GameUtil.rmClickHandler(self._btnSuper)
	GameUtil.rmClickHandler(self._btnNormal)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnPrize)
end

function GoddessTrialMainView:bindEvents()
	GoddessTrialMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnBoss, self._onClickBoss, self)
	GameUtil.addClickHandler(self._btnSuper, self._onClickSuper, self)
	GameUtil.addClickHandler(self._btnNormal, self._onClickNormal, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnPrize, self._onClickPrize, self)
end

function GoddessTrialMainView:buildUI()
	GoddessTrialMainView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnTip = self:getGo("btnTip")
	self._btnBoss = self:getGo("btnBoss")
	self._redpointBoss = self:getGo("btnBoss/redpoint")
	self._btnSuper = self:getGo("btnSuper")
	self._btnNormal = self:getGo("btnNormal")
	self._btnRank = self:getGo("btnRank")
	self._btnPrize = self:getGo("btnPrize")
	self._redPointPrize = self:getGo("btnPrize/redpoint")
	self._txtTime = self:getTxt("time/txtTime")
	self._petCon = self:getGo("petCon")
end

function GoddessTrialMainView:onExit()
	GoddessTrialMainView.super.onExit(self)

	if self._roleObj then
		RoleObjectPool.instance:removeRole(self._roleObj)

		self._roleObj = nil
	end

	RedPointController.instance:unregRedPoint(self._redPointPrize)
end

function GoddessTrialMainView:onEnter()
	GoddessTrialMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_GoddessTrialGetInfoRes, self._refreshView, self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = 574001
	end

	self._activityCfg = GoddessTrialConfig.instance:getActivityCfg(self._activityId)

	if self._roleObj then
		RoleObjectPool.instance:removeRole(self._roleObj)

		self._roleObj = nil
	end

	self._roleObj = RoleObjectPool.instance:addRoleToParent(self._roleObj, self._activityCfg.showRaceId, self._petCon)
	self._txtTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)

	RedPointController.instance:regRedPoint(self._redPointPrize, self._activityCfg.redPointId)
	GoddessTrialClgAgent.instance:sendPM_GoddessTrialGetInfoReq(self._activityId)
end

function GoddessTrialMainView:_refreshView()
	local fightTime = GoddessTrialModel.instance:getTodayFightBossTimes(self._activityId)
	local curBattleTime = math.max(self._activityCfg.dailyBossTimes - fightTime, 0)

	GameUtil.SetActive(self._redpointBoss, curBattleTime > 0)
end

function GoddessTrialMainView:_onClickRank()
	UIStateManager.instance:push(ViewName.GoddessTrialRankView, self._activityId)
end

function GoddessTrialMainView:_onClickPrize()
	UIStateManager.instance:push(ViewName.GoddessTrialPrizeView, self._activityId)
end

function GoddessTrialMainView:_onClickBoss()
	UIStateManager.instance:push(ViewName.GoddessTrialBossView, self._activityId)
end

function GoddessTrialMainView:_onClickSuper()
	UIStateManager.instance:push(ViewName.GoddessTrialSuperView, self._activityId)
end

function GoddessTrialMainView:_onClickNormal()
	UIStateManager.instance:push(ViewName.GoddessTrialNormalView, self._activityId)
end

function GoddessTrialMainView:_onClickTip()
	TipsFacade.instance:openRulesView("goddess_trial_rule")
end

return GoddessTrialMainView
