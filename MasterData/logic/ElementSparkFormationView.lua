-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elementspark/view/ElementSparkFormationView.lua

module("logic.extensions.elementspark.view.ElementSparkFormationView", package.seeall)

local ElementSparkFormationView = class("ElementSparkFormationView", ViewComponent)

function ElementSparkFormationView:ctor()
	ElementSparkFormationView.super.ctor(self)
end

function ElementSparkFormationView:unbindEvents()
	ElementSparkFormationView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnChallenge)
end

function ElementSparkFormationView:bindEvents()
	ElementSparkFormationView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickChallenge, self)
end

function ElementSparkFormationView:buildUI()
	ElementSparkFormationView.super.buildUI(self)

	self._btnChallenge = self:getBtn("btnChallenge")
end

function ElementSparkFormationView:onExit()
	ElementSparkFormationView.super.onExit(self)
end

function ElementSparkFormationView:onEnter()
	ElementSparkFormationView.super.onEnter(self)

	self._activityId = ElementSparkController.instance:getActivityId()
	self._fmo = self:getFirstParam()
	self._teamId, self._chunkId, self._challengeType = self._fmo:getChallengeParams()
end

function ElementSparkFormationView:_onClickChallenge()
	local isEmpty = self._fmo:getCurFormation():isEmpty()

	if isEmpty then
		FloatWordMgr.instance:show("阵型为空，无法挑战")

		return
	end

	local planId = ElementSparkController.instance:getMapPlanId()
	local chunkCfg = ElementSparkConfig.instance:getMapChunkCfgById(planId, self._chunkId)
	local hasBelongMe, isInprotect = ElementSparkSceneController.instance:_hasChunkBelongMeAround(chunkCfg)

	if not hasBelongMe then
		if isInprotect then
			FloatWordMgr.instance:show("相邻地块正处于保护期,暂时无法攻打")
		else
			FloatWordMgr.instance:show("己方阵营暂未占领相邻地块,暂时无法攻打")
		end

		return
	end

	self._fmo:fmtVerifyReq(true)

	if self._challengeType > 1 then
		ElementSparkController.instance:sendPM_EleSparkChallengeBossReq(self._activityId, self._chunkId, self._teamId)
	else
		ElementSparkController.instance:sendPM_EleSparkChallengeDefenseFormReq(self._activityId, self._chunkId, self._teamId)
	end

	UIJumper.instance:pushOneStack(ViewName.ElementsparkbossbridgeView, nil, self._chunkId)
end

return ElementSparkFormationView
