-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/lightking/LightKingMissionView.lua

module("logic.extensions.timelimitedchallenge.view.lightking.LightKingMissionView", package.seeall)

local LightKingMissionView = class("LightKingMissionView", MissionView)

function LightKingMissionView:buildUI()
	LightKingMissionView.super.buildUI(self)
end

function LightKingMissionView:onExit()
	LightKingMissionView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.LightKingSetFormRes, self._sendFightReq, self)
	FormationNewModel.instance:RecoverFmtFromServerData()
end

function LightKingMissionView:onEnter()
	self:onEnterInherit()
	self._videoButton.gameObject:SetActive(false)
	MissionModel.instance:setForceResetOneKey(true)

	self._challengeType = LightKingModel.instance:getCurChallengeType()
	self._stageCfg = LightKingModel.instance:getCurStageCfg()

	self:_setDescStr(self._stageCfg.name, nil, self._stageCfg.WinDesc)
	self:_setTitleName()
	self:setRuleDesc()

	local missionDesc = self._stageCfg.missionDesc

	if not string.nilorempty(missionDesc) then
		goutil.setActive(self._topDesc.gameObject, true)
		goutil.setActive(self._txtValidatorDesc.gameObject, true)
		goutil.setActive(self._imgYes, false)
		goutil.setActive(self._imgNo, false)

		self._txtValidatorDesc.text = missionDesc
	end

	if self._challengeType == 2 then
		self._btnOneKey.gameObject:SetActive(false)
	else
		self._btnOneKey.gameObject:SetActive(true)
	end
end

function LightKingMissionView:_saveFormationEx()
	return false
end

function LightKingMissionView:_saveCurForm()
	local formInfo = FormationNewModel.instance:GetCurTeam():GetCurFormation()
	local simpleForm = formInfo:createFormPb()

	LightKingController.instance:sendSetFormReq(self._challengeType, self._stageCfg.stage, simpleForm)
end

function LightKingMissionView:_onClickClose()
	self:_saveCurForm()
	LightKingMissionView.super._onClickClose(self)
end

function LightKingMissionView:_maxPetNum()
	local challengeType = LightKingModel.instance:getCurChallengeType()

	if challengeType == 1 then
		return 6
	else
		return 5
	end
end

function LightKingMissionView:_onClickOneKey()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.ClickAutoFormationButton)

	local key = MissionModel.instance:getForceResetOneKey()

	LightKingFastFmtView.instance:setFormation(key)
	MissionModel.instance:setForceResetOneKey(false)
end

function LightKingMissionView:_onClickStart()
	local id = LightKingModel.instance:getChallengeId()
	local challengeCfg = TimeLimitedConfig.instance:getCfgById(id)

	if self._challengeType == 3 then
		local hasRaceId = false
		local curPos = FormationNewModel.instance:GetCurTeam():GetCurFormation():GetPositions()

		for _, v in ipairs(curPos) do
			local pet = LightKingModel.instance:getPetMo(v)

			if pet and pet.raceId == challengeCfg.raceId then
				hasRaceId = true

				break
			end
		end

		if not hasRaceId then
			FloatWordMgr.instance:show("需上阵光明王，才可进入挑战哦！")

			return
		end
	end

	LightKingMissionView.super._onClickStart(self)
end

function LightKingMissionView:checkFormationEmptyAndPosNumLimit(posLimitCallback, hasOneKey, onekeyCallBack)
	if self._challengeType == 3 then
		local numPos = FormationFacade.instance:curFormationPetNum(formationMo)
		local totalPos = MissionModel.instance:getMaxPetNum()
		local petsNum = LightKingModel.instance:getDiffRacePetNum()
		local showNum = -1
		local boo = false

		if totalPos <= petsNum and numPos < totalPos then
			boo = true
			showNum = totalPos
		elseif petsNum < totalPos and petsNum > 0 and numPos < petsNum then
			boo = true
			showNum = petsNum
		end

		if showNum > 0 then
			if hasOneKey then
				TipsFacade.instance:openPopupWindowWithX(lang("tip"), string.format(lang("fight_fmt_num"), tostring(showNum)), posLimitCallback, onekeyCallBack, lang("确定"), lang("一键布阵"))
			else
				TipsFacade.instance:openPopupWindow(lang("tip"), string.format(lang("fight_fmt_num"), tostring(showNum)), posLimitCallback)
			end
		end

		return boo
	else
		return LightKingMissionView.super.checkFormationEmptyAndPosNumLimit(self, posLimitCallback, hasOneKey, onekeyCallBack)
	end
end

function LightKingMissionView:needCheckNumLimit()
	if self._challengeType == 2 then
		return false
	else
		return true
	end
end

function LightKingMissionView:_enterBattle()
	self:_saveCurForm()
	GlobalDispatcher:addListener(GlobalNotify.LightKingSetFormRes, self._sendFightReq, self)
end

function LightKingMissionView:_sendFightReq()
	GlobalDispatcher:removeListener(GlobalNotify.LightKingSetFormRes, self._sendFightReq, self)
	BattleFacade.instance:startBattle(GameEnum.MissionType.LIGHTKING)
	UIJumper.instance:pushOneStack(ViewName.LightKingMainView, true)
	UIJumper.instance:pushOneStack(ViewName.LightKingChallengeView, true)

	local baseCfg = LightKingConfig.instance:getBaseDefineCfg(self._challengeType)

	LightKingChallengeAgent.instance:sendPM_LightKingChallengeFightReq(self._challengeType, self._stageCfg.stage, self._onFightRes, self, self._onError)
end

function LightKingMissionView:_onError()
	self:_setMaskBlock(false)
end

function LightKingMissionView:_onFightRes()
	return
end

return LightKingMissionView
