-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originmoonshadowking/view/OriginMoonShadowKingMainView.lua

module("logic.extensions.originmoonshadowking.view.OriginMoonShadowKingMainView", package.seeall)

local OriginMoonShadowKingMainView = class("OriginMoonShadowKingMainView", DivineLouNaMainView)

function OriginMoonShadowKingMainView:buildUI()
	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._btnJump1 = self:getGo("jumpBtnCol/btnJump1")
	self._btnJump2 = self:getGo("jumpBtnCol/btnJump2")
	self._btnJump3 = self:getGo("jumpBtnCol/btnJump3")
	self._btnJump4 = self:getGo("jumpBtnCol/btnJump4")
	self._btnChallenge1 = self:getBtn("btnChallenge1")
	self._btnChallenge2 = self:getBtn("btnChallenge2")
	self._con = self:getGo("con")
	self._txtTime = self:getTxt("time/txt")
	self._btnInfo = self:getBtn("petInfo/btnInfo")
	self._btnSkill = self:getBtn("petInfo/btnSkill")
	self._rare = self:getGo("petInfo/pointRare")
	self._txtName = self:getTxt("petInfo/txtName")
	self._txtProgress1 = self:getTxt("bgProgress1/txtProgress1")
	self._txtProgress2 = self:getTxt("bgProgress2/txtProgress2")
	self._goldBarCon = self:getGo("goldBarCon")
end

function OriginMoonShadowKingMainView:bindEvents()
	self._btnClose:AddClickListener(self.close, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
	self._btnChallenge1:AddClickListener(self._onClickChallenge1, self)
	self._btnChallenge2:AddClickListener(self._onClickChallenge2, self)
	self._btnInfo:AddClickListener(self._onClickInfo, self)
	self._btnSkill:AddClickListener(self._onClickSkill, self)
	GameUtil.addClickHandler(self._btnJump1, GameUtil.handler(self._onClickBtnJump, self, 1))
	GameUtil.addClickHandler(self._btnJump2, GameUtil.handler(self._onClickBtnJump, self, 2))
	GameUtil.addClickHandler(self._btnJump3, GameUtil.handler(self._onClickBtnJump, self, 3))
	GameUtil.addClickHandler(self._btnJump4, GameUtil.handler(self._onClickBtnJump, self, 4))
end

function OriginMoonShadowKingMainView:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnChallenge1:RemoveClickListener()
	self._btnChallenge2:RemoveClickListener()
	self._btnInfo:RemoveClickListener()
	self._btnSkill:RemoveClickListener()
	GameUtil.rmClickHandler(self._btnJump1)
	GameUtil.rmClickHandler(self._btnJump2)
	GameUtil.rmClickHandler(self._btnJump3)
	GameUtil.rmClickHandler(self._btnJump4)
end

function OriginMoonShadowKingMainView:onEnter()
	GlobalDispatcher:addListener(GlobalNotify.ShenJiChallengeGetInfoRes, self._onGetInfoRes, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 312003
	end

	ShenJiChallengeModel.instance:setCurActivityId(self._activityId)

	self._activityType = ShenJiChallengeModel.instance:getActivityType()
	self._isClick = false
	self._cfgActivity = ShenJiChallengeConfig.instance:getActivityCfg(self._activityId)
	self._challengeId = self._cfgActivity.challengeId
	self._ruleTip = self._cfgActivity.ruleTip

	local cfgChallenge = TimeLimitedConfig.instance:getCfgById(self._challengeId)

	if cfgChallenge then
		self._raceId = cfgChallenge.raceId or 0
	end

	self._dailySelectTimes = self._cfgActivity.dailySelectTimes
	self._fightBossTimes = self._cfgActivity.fightBossTimes
	self._actCfg = ShenJiChallengeConfig.instance:getActivityCfg(self._activityId)

	self:_initActivityTime()
	self:_initPetInfo()
	self:_showRoleModel()
	self:_setTopGoldBar(self._goldBarCon, self._cfgActivity.goldBarCon)
	self:_updateProgress1()
	self:_updateProgress2()
	ShenJiChallengeAgent.instance:sendPM_ShenJiChallengeGetInfoReq(self._activityId)
end

function OriginMoonShadowKingMainView:_onClickBtnJump(jumpIdx)
	local btnStr = self._actCfg["jumpTo" .. jumpIdx]

	GotoMgr.gotoByString(btnStr)
end

function OriginMoonShadowKingMainView:_updateProgress1()
	local maxNum = self._dailySelectTimes
	local curNum = ShenJiChallengeModel.instance:getTodayChallengeTimes()

	self._txtProgress1.text = string.format("今日剩余次数：<color=#43e0ff>%d</color>/%d", Mathf.Max(maxNum - curNum, 0), maxNum)
end

function OriginMoonShadowKingMainView:_updateProgress2()
	local cfgs = ShenJiChallengeConfig.instance:getBossList(self._activityId)
	local maxNum = #cfgs
	local curNum = ShenJiChallengeModel.instance:getPassBossNum(self._activityId)

	self._txtProgress2.text = string.format("当前挑战进度：<color=#43e0ff>%d</color>/%d", curNum, maxNum)
end

function OriginMoonShadowKingMainView:_onClickChallenge1()
	UIStateManager.instance:push(ViewName.OriginMoonShadowKingSelectView, self._activityId)
end

function OriginMoonShadowKingMainView:_onClickChallenge2()
	UIStateManager.instance:push(ViewName.OriginMoonShadowKingBossView, self._activityId)
end

return OriginMoonShadowKingMainView
