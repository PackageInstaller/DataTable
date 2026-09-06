-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/plotcopy/view/CopyMissionView.lua

module("logic.extensions.plotcopy.view.CopyMissionView", package.seeall)

local CopyMissionView = class("CopyMissionView", MissionView)

function CopyMissionView:ctor()
	CopyMissionView.super.ctor(self)
end

function CopyMissionView:onEnter()
	GlobalDispatcher:addListener(PlotChallengeAgent.ChallengeRes, self._onMissionBattleResBack, self)

	local params = self:getOpenParam()

	if not params or not params[1] or not params[2] then
		return
	end

	self._chapterId = params[1]
	self._stageId = params[2]

	BulletScreenModel.instance:setEnum(GameEnum.BulletScene.Formation)
	BulletScreenModel.instance:setKey(string.format("cp_%s_%s", self._chapterId, self._stageId))
	self:onEnterInherit()
	self:procMid()
	self._videoButton.gameObject:SetActive(true)
	FastFormation.instance:setGetCurPetList(function()
		return PlotCopyModel.instance:getAllShowPetList()
	end)
	FastFormation.instance:setCurFormFunc(function()
		return PlotCopyModel.instance:_getCurFormation()
	end)
end

function CopyMissionView:onExit()
	CopyMissionView.super.onExit(self)
	GlobalDispatcher:removeListener(PlotChallengeAgent.ChallengeRes, self._onMissionBattleResBack, self)
end

function CopyMissionView:procMid()
	local cfg = CopyConfig.instance:getStageById(self._chapterId, self._stageId)

	if not cfg then
		return
	end

	local titleStr = cfg.stageName
	local levelStr = ""

	if cfg.passDesc then
		if not cfg.passDesc then
			local ruleDesc = ""

			self:_setDescStr(titleStr, levelStr, ruleDesc)

			local cfgTeam = CopyConfig.instance:getTeamCfg(cfg.teamIds)

			if cfgTeam then
				local isPass = PlotCopyModel.instance:isStagePassed(self._chapterId, self._stageId)

				self:_updatePowerCost(cfgTeam.strengthConsumption, not isPass)
			end

			local perfectDesc = BattleSettlementModel.instance:getPlotCopyPerfectText(self._chapterId, self._stageId, true)

			self:_setPerfectRuleDesc(perfectDesc)
		end
	end
end

function CopyMissionView:_enterBattle()
	PlotCopyController.instance:sendChallengeReq(self._chapterId, self._stageId)
	PlotCopyController.instance:pushOneStackView(self._chapterId, self._stageId)
end

function CopyMissionView:_onClickVideo()
	BattleRecordRankController.instance:enterStoryRecord(self._chapterId, self._stageId)
end

function CopyMissionView:_isShowBtnEvaluate()
	return true
end

function CopyMissionView:checkFormationEmptyAndPosNumLimit(callback, hasOneKey, onekeyCallBack)
	if self:_isCurFormationEmpty() then
		return true
	end

	return self:checkFormationPosNumber(posLimitCallback, hasOneKey, onekeyCallBack)
end

function CopyMissionView:checkFormationPosNumber(posLimitCallback, hasOneKey, onekeyCallBack)
	local mo
	local numPos = FormationFacade.instance:curFormationPetNum((PlotCopyModel.instance:_getCurFormation()))
	local curFormId = FormationModel.instance:getCurFormId()
	local formationCo = BattleConfig.instance:getFormationCo(curFormId)
	local totalPos = 5
	local petsNum = BagModel.instance:diffRacePetCount()
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
			TipsFacade.instance:openTipWindowNoX(lang("tip"), langPara("上阵精灵未满%s只（上阵精灵越多，战斗力越强），请一键布阵上阵%s只精灵吧！", showNum, showNum), onekeyCallBack, lang("一键布阵"))
		else
			TipsFacade.instance:openPopupWindow(lang("tip"), string.format(lang("fight_fmt_num"), tostring(showNum)), posLimitCallback)
		end
	end

	return boo
end

function CopyMissionView:_onClickOneKey()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.ClickAutoFormationButton)
	FastFormation.instance:setFormation(MissionModel.instance:getForceResetOneKey())
	MissionModel.instance:setForceResetOneKey(false)
end

function CopyMissionView:_saveFormationEx()
	PetHireController.instance:sendSetHrieFormByFormId(PetHireModel.ID_TYPE_NORMAL)

	return CopyMissionView.super._saveFormationEx(self)
end

function CopyMissionView:_getCurFormation()
	return PlotCopyModel.instance:_getCurFormation()
end

function CopyMissionView:_isCurFormationEmpty()
	local formation = PlotCopyModel.instance:_getCurFormation()

	if not formation then
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

return CopyMissionView
