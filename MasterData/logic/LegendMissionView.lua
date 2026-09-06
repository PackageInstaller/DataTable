-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/legend/view/LegendMissionView.lua

module("logic.extensions.legend.view.LegendMissionView", package.seeall)

local LegendMissionView = class("LegendMissionView", MissionView)

function LegendMissionView:ctor()
	LegendMissionView.super.ctor(self)
end

function LegendMissionView:onExit()
	LegendMissionView.super.onExit(self)
	LegendFastFormation.instance:setGetCurPetList(nil)
end

function LegendMissionView:onEnter()
	local challengeId, stageId = LegendModel.instance:getOpenChallengeIdAndStageId()

	self.challengeId = challengeId
	self._legendChallengeCfg = LegendConfig.instance:getLegendChallengeCfg(challengeId)
	self._stageId = stageId

	BulletScreenModel.instance:setEnum(GameEnum.BulletScene.Formation)
	BulletScreenModel.instance:setKey(string.format("ld_%s_%s", self.challengeId, self._stageId))
	self:onEnterInherit()
	self:procMid()
	self._videoButton.gameObject:SetActive(true)

	if LegendModel.instance:isExistSupportPet() then
		LegendFastFormation.instance:setGetCurPetList(function()
			return LegendModel.instance:getAllPets(true)
		end)
		LegendFastFormation.instance:setCurFormFunc(function()
			return (LegendModel.instance:getOriginalCurFormation())
		end)
	else
		FastFormation.instance:setGetCurPetList(function()
			return LegendModel.instance:getAllPets(false)
		end)
		FastFormation.instance:setCurFormFunc(function()
			return LegendModel.instance:_getCurFormation()
		end)
	end
end

function LegendMissionView:onEnterFinished()
	LegendMissionView.super.onEnterFinished(self)

	local isShow = not GameUtil.getUserDayData(MissionConst.MissionLegend .. self.challengeId)

	if isShow and self.challengeId ~= 1 then
		self:_onClickRule()
	end
end

function LegendMissionView:setRuleDesc()
	LegendMissionView.super.setRuleDesc(self)

	local cfg = LegendConfig.instance:getLegendChallengeCfg(self.challengeId)

	if cfg then
		if not cfg.challengeName then
			local legendParam = {}

			legendParam.challengeType = MissionConst.MissionLegend
			legendParam.battleType = MissionConst.BattleLegend
			legendParam.challengeId = self.challengeId
			legendParam.challengeName = ""

			MissionModel.instance:setRuleParam(legendParam)
		end
	end
end

function LegendMissionView:procMid()
	local challengeId, stageId = LegendModel.instance:getOpenChallengeIdAndStageId()
	local cfgs = LegendConfig.instance:getLegendChallengeStageCfgList(challengeId)
	local cfg = LegendConfig.instance:getLegendChallengeStageCfg(challengeId, stageId)
	local teamId = cfg.teamId
	local cfgTeam = LegendConfig.instance:getLegendChallengeTeamCfg(teamId)

	self:_updatePowerCost(checknumber(cfgTeam.strengthConsumption))
	self:_setDescStr(cfg.stageName, "", cfgTeam.description)
	self:_setRedPoint(cfgTeam.redPoint)
	self:_setTitleName()
end

function LegendMissionView:_enterBattle()
	local challengeId, stageId = LegendModel.instance:getOpenChallengeIdAndStageId()
	local cfg = LegendConfig.instance:getLegendChallengeStageCfg(challengeId, stageId)
	local teamId = cfg.teamId
	local cfgTeam = LegendConfig.instance:getLegendChallengeTeamCfg(teamId)
	local params = {}

	params.giveBackItem = MatType.Strength .. ":1:" .. cfgTeam.strengthConsumption

	BattleSettlementModel.instance:setType(BattleSettlementModel.Enum.Legend, params)
	LegendController.instance:sendPM_ChallengeReq(challengeId, stageId)
	BattleFacade.instance:startLegend(challengeId, stageId)

	local challengeId = LegendModel.instance:getRecordChallengeId()

	UIJumper.instance:pushOneStack(ViewName.Legend, true, challengeId)
end

function LegendMissionView:_onClickVideo()
	local challengeId, stageId = LegendModel.instance:getOpenChallengeIdAndStageId()

	BattleRecordRankController.instance:enterLegendRecord(challengeId, stageId)
end

function LegendMissionView:_onClickStart()
	local challengeId, stageId = LegendModel.instance:getOpenChallengeIdAndStageId()
	local cfgStage = LegendConfig.instance:getLegendChallengeStageCfg(challengeId, stageId)
	local cfgTeam = LegendConfig.instance:getLegendChallengeTeamCfg(cfgStage.teamId)
	local curPower = SupplyModel.instance:getHaveTiliCount()
	local isEnough = curPower >= checknumber(cfgTeam.strengthConsumption)

	if not isEnough then
		ViewMgr.instance:open(ViewName.RecoveryTili)

		return
	else
		LegendMissionView.super._onClickStart(self)
	end
end

function LegendMissionView:_isShowBtnEvaluate()
	return false
end

function LegendMissionView:_openPassRuleView()
	local challengeId, stageId = LegendModel.instance:getOpenChallengeIdAndStageId()

	LegendController.instance:openRaidersView(challengeId, stageId, self:_getBtnRulePosition())
end

function LegendMissionView:_maxPetNum()
	return LegendModel.instance:isExistSupportPet() and 6 or 5
end

function LegendMissionView:_onClickOneKey()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.ClickAutoFormationButton)

	if LegendModel.instance:isExistSupportPet() then
		LegendFastFormation.instance:setFormation(MissionModel.instance:getForceResetOneKey())
	else
		FastFormation.instance:setFormation(MissionModel.instance:getForceResetOneKey())
	end

	MissionModel.instance:setForceResetOneKey(false)
end

function LegendMissionView:_onClickClean()
	if LegendModel.instance:isExistSupportPet() then
		LegendFastFormation.instance:clean()
	else
		FastFormation.instance:clean()
	end
end

function LegendMissionView:_saveFormationEx()
	if LegendModel.instance:isExistSupportPet() then
		return LegendModel.instance:saveCurrFormation()
	else
		PetHireController.instance:sendSetHrieFormByFormId(PetHireModel.ID_TYPE_NORMAL)

		return LegendMissionView.super._saveFormationEx(self)
	end
end

function LegendMissionView:checkFormationEmptyAndPosNumLimit(callback, hasOneKey, onekeyCallBack)
	if LegendModel.instance:isExistSupportPet() then
		local formation = LegendModel.instance:getFormation()
		local numPos = formation:getCurExistPetNumber()
		local totalPos = self:_maxPetNum()
		local petsNum = LegendModel.instance:diffRacePetCount()
		local showNum = -1

		printInfo("test 当前数量是：", numPos, totalPos, petsNum)

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
				TipsFacade.instance:openPopupWindowWithX(lang("tip"), string.format(lang("fight_fmt_num"), tostring(showNum)), callback, onekeyCallBack, lang("确定"), lang("一键布阵"))
			else
				TipsFacade.instance:openPopupWindowWithX(lang("tip"), string.format(lang("fight_fmt_num"), tostring(showNum)), callback)
			end
		end

		return boo
	else
		return LegendMissionView.super.checkFormationEmptyAndPosNumLimit(self, callback, hasOneKey, onekeyCallBack)
	end

	return true
end

function LegendMissionView:_getCurFormation()
	if LegendModel.instance:isExistSupportPet() then
		return (LegendModel.instance:getOriginalCurFormation())
	else
		return LegendModel.instance:_getCurFormation()
	end
end

function LegendMissionView:_isCurFormationEmpty()
	if LegendModel.instance:isExistSupportPet() then
		return false
	else
		local formation = LegendModel.instance:_getCurFormation()

		if not formation then
			error("formation is nil")

			return true
		end

		for i = 1, 9 do
			local pos = formation:GetPosition(i)

			if not pos then
				return true
			end

			if pos > 0 then
				return false
			end
		end

		return true
	end
end

return LegendMissionView
