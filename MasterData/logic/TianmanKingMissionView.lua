-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/tianmanking/TianmanKingMissionView.lua

module("logic.extensions.timelimitedchallenge.view.tianmanking.TianmanKingMissionView", package.seeall)

local TianmanKingMissionView = class("TianmanKingMissionView", MissionView)

function TianmanKingMissionView:onEnter()
	local openParam = self:getOpenParam()

	self._challengeType, self._challengeId = openParam[1], openParam[2]

	self:onEnterInherit()
	MissionModel.instance:setForceResetOneKey(true)

	local stageCfg = TianmanKingConfig.instance:getStageByTypeAndStage(self._challengeType, self._challengeId)

	self._titleTxt.text = stageCfg.name
	self._descTxt.text = stageCfg.WinDesc

	self:_setMaskBlock(false)

	self._fmtChanged = false

	self._videoButton.gameObject:SetActive(false)
	GlobalDispatcher:addListener(TianmanKingController.PM_TMWCSetFormRes, self._handlePM_TMWCSetFormRes, self)
	goutil.setActive(self._btnOneKey.gameObject, false)
	goutil.setActive(self._btnClean.gameObject, false)
	goutil.setActive(self._topDesc.gameObject, true)
	goutil.setActive(self._txtValidatorDesc.gameObject, false)

	if string.nilorempty(stageCfg.missionCondition) then
		goutil.setActive(self._txtDesc.gameObject, false)
	else
		goutil.setActive(self._txtDesc.gameObject, true)

		self._txtDesc.text = stageCfg.missionCondition
	end
end

function TianmanKingMissionView:onExit()
	TianmanKingMissionView.super.onExit(self)
	GlobalDispatcher:removeListener(TianmanKingController.PM_TMWCSetFormRes, self._handlePM_TMWCSetFormRes, self)
end

function TianmanKingMissionView:_handlePM_TMWCSetFormRes()
	BattleFacade.instance:startSenluo()
	TianmanKingController.instance:sendPM_TMWCChallengeStageReq(self._challengeType, self._challengeId)
end

function TianmanKingMissionView:_setTitleName()
	self._titleTxt.text = string.nilorempty(self._titleStr) and self._levelStr or self._titleStr .. " " .. self._levelStr
end

function TianmanKingMissionView:_onClickStart()
	if self._challengeType == 2 then
		local okFlag = 0
		local formInfo = TianmanKingModel.instance:getForm()
		local curFormPos = formInfo:GetPositions()
		local supportPetCfg = TianmanKingConfig.instance:getSupportPet()
		local supportPetId = supportPetCfg[1].supportPetId

		for i = 1, 9 do
			if curFormPos[i] == supportPetId then
				okFlag = okFlag + 1
			elseif curFormPos[i] == TianmanKingModel.instance:getCurSummon() then
				okFlag = okFlag + 1
			end
		end

		if okFlag < 2 then
			FloatWordMgr.instance:show(TianmanKingController.instance:getText("TEXT_17"))

			return
		end

		if EscortModel.instance:IsPickupEscort() and self._viewPresentor.viewName ~= ViewName.EscortMission then
			FloatWordMgr.instance:show("护送期间不能进行其他战斗!")

			return
		end

		if not self:_isFormationValidatorMatchOnStart() then
			return
		end

		local hasOneKey = GameUtil.GetActive(self._btnOneKey)

		if self:needCheckNumLimit() and self:checkFormationEmptyAndPosNumLimit(function()
			self:_startClg()
		end, hasOneKey, function()
			self:_onClickOneKey()
		end) then
			return
		end

		self:_startClg()
	else
		TianmanKingMissionView.super._onClickStart(self)
	end
end

function TianmanKingMissionView:_enterBattle()
	if self._challengeType == 2 then
		local formInfo = TianmanKingModel.instance:getForm()
		local simpleForm = formInfo:createFormPb()

		TianManWangChallengeAgent.instance:sendPM_TMWCSetFormReq(simpleForm)
	elseif not FormationController.instance:SaveFormationEx(function()
		if self._challengeType == 3 then
			BattleFacade.instance:startTimeLimitedChallenge()
		end

		TianmanKingController.instance:sendPM_TMWCChallengeStageReq(self._challengeType, self._challengeId)
	end) then
		if self._challengeType == 3 then
			BattleFacade.instance:startTimeLimitedChallenge()
		end

		TianmanKingController.instance:sendPM_TMWCChallengeStageReq(self._challengeType, self._challengeId)
	end
end

function TianmanKingMissionView:_getCurFormation()
	if self._challengeType == 2 then
		return TianmanKingModel.instance:getForm()
	else
		return TianmanKingMissionView.super._getCurFormation(self)
	end
end

return TianmanKingMissionView
