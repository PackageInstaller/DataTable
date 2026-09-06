-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingway/view/holychallmission/HolyChallMissionView.lua

module("logic.extensions.kingway.view.holychallmission.HolyChallMissionView", package.seeall)

local HolyChallMissionView = class("HolyChallMissionView", MissionView)

function HolyChallMissionView:buildUI()
	HolyChallMissionView.super.buildUI(self)
end

function HolyChallMissionView:bindEvents()
	HolyChallMissionView.super.bindEvents(self)
end

function HolyChallMissionView:unbindEvents()
	HolyChallMissionView.super.unbindEvents(self)
end

function HolyChallMissionView:onEnter()
	self._data = self:getFirstParam()

	self:onEnterInherit()
	self:_setMaskBlock(false)
	self._videoButton.gameObject:SetActive(false)
	MissionModel.instance:setForceResetOneKey(true)

	self._fmtChanged = false
	self._loader, self._lastCallBack, self._mdlObj = RoleObjectPool.instance:resetLoader(self._loader, self._lastCallBack, self._mdlObj)

	self:_setMissionCfgInfo()
end

function HolyChallMissionView:onEnterFinished()
	HolyChallMissionView.super.onEnterFinished(self)

	local challengeId = self._data.isTrial and "holychall100" or "holychall" .. self._data.challengeId

	GameUtil.getUserDayData(MissionConst.MissionLegend .. challengeId, function(isShow)
		if not isShow then
			self:_onClickRule()
		end
	end)
end

function HolyChallMissionView:_onClickStart()
	if self._data.isTrial then
		HolyChallMissionView.super._onClickStart(self)
	else
		if self:_checkFormationPosNumber(function()
			self:_startClg()
		end, true) then
			return
		end

		self:_startClg()
	end
end

function HolyChallMissionView:_startClg()
	if self._data.isTrial then
		HolyChallMissionView.super._startClg(self)
	else
		self:_setMaskBlock(true)
		GlobalDispatcher:addListener(GlobalNotify.FormationRefresh, self._startNow, self)
		HolyChallModel.instance:saveCurrFormation()
	end
end

function HolyChallMissionView:_checkFormationPosNumber(posLimitCallback)
	local totalPos = 6
	local formation = HolyChallModel.instance:getFormation()
	local numPos = formation:getCurExistPetNumber()
	local petsNum = HolyChallModel.instance:diffRacePetCount()
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
		local function onekeyCallBack()
			self:_onClickOneKey()
		end

		TipsFacade.instance:openTipWindowNoX(lang("tip"), langPara("上阵精灵未满%s只（上阵精灵越多，战斗力越强），请一键布阵上阵%s只精灵吧！", showNum, showNum), onekeyCallBack, lang("一键布阵"))
	end

	return boo
end

function HolyChallMissionView:_setMissionCfgInfo()
	if self._data == nil then
		return
	end

	local stageCfg = HolyChallConfig.instance:GetChallStageCfg(self._data.challengeId, self._data.stageId)
	local titleStr = stageCfg.name

	self:_setDescStr(titleStr, nil, (not string.nilorempty(stageCfg.playRule2) or nil) and stageCfg.playRule1 .. "\n" .. stageCfg.playRule2)
	self:setRuleDesc()
end

function HolyChallMissionView:_enterBattle()
	BattleFacade.instance:startHolyChall(self._data.challengeId, self._data.stageId)

	if self._data.isTrial then
		HolyChallController.instance:CSRequestFeilongTrialReq(self._data.challNum or 1)
	else
		HolyChallController.instance:CSRequestChallengeGuardReq(self._data.challengeId, self._data.stageId)
	end

	UIJumper.instance:pushOneStack(ViewName.HolyChall, true)
end

function HolyChallMissionView:_onClickOneKey()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.ClickAutoFormationButton)

	if self._data.isTrial then
		FastFormation.instance:setFormation(MissionModel.instance:getForceResetOneKey())
	else
		HolyChallFastFormation.instance:setFormation(MissionModel.instance:getForceResetOneKey())
	end

	MissionModel.instance:setForceResetOneKey(false)
end

function HolyChallMissionView:_openPassRuleView()
	local stageCfg = HolyChallConfig.instance:GetChallStageCfg(self._data.challengeId, self._data.stageId)
	local param = {}

	param.challengeId = self._data.isTrial and "holychall100" or "holychall" .. self._data.challengeId
	param.stageId = self._data.stageId
	param.txtCfg = stageCfg
	param.challengeName = stageCfg.name

	LegendController.instance:openRaidersViewByParam(param, self:_getBtnRulePosition())
end

function HolyChallMissionView:_onClickClean()
	if self._data.isTrial then
		FastFormation.instance:clean()
	else
		HolyChallFastFormation.instance:clean()
	end
end

function HolyChallMissionView:_maxPetNum()
	if self._data.isTrial then
		return 5
	else
		return 6
	end
end

return HolyChallMissionView
