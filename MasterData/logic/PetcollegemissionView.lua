-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petcollege/view/PetcollegemissionView.lua

module("logic.extensions.petcollege.view.PetcollegemissionView", package.seeall)

local PetcollegemissionView = class("PetcollegemissionView", MissionView)

function PetcollegemissionView:ctor()
	PetcollegemissionView.super.ctor(self)
end

function PetcollegemissionView:onEnter()
	local params = self:getOpenParam()

	self._challengeId, self._stageId = params[1], params[2]

	self:onEnterInherit()
	self:procMid()
	GameUtil.SetActive(self._btnOneKey, false)
	GameUtil.SetActive(self._videoButton.gameObject, false)
	GlobalDispatcher:addListener(BattleCollegeAgent.BC_ChallengeRes, self._onMissionBattleResBack, self)
	GlobalDispatcher:addListener(PetCollegeAgent.PetCollegeChallengeRes, self._onMissionBattleResBack, self)
	self:_setLeftLearnBtn()
end

function PetcollegemissionView:onEnterFinished()
	PetcollegemissionView.super.onEnterFinished(self)
	self:_onClickRule()
end

function PetcollegemissionView:onExit()
	PetcollegemissionView.super.onExit(self)
	GlobalDispatcher:removeListener(BattleCollegeAgent.BC_ChallengeRes, self._onMissionBattleResBack, self)
	GlobalDispatcher:removeListener(PetCollegeAgent.PetCollegeChallengeRes, self._onMissionBattleResBack, self)
end

function PetcollegemissionView:_setLeftLearnBtn()
	self._leftLearnBtnGo = self._leftLearnBtnGo or self:getResInstance("ui/views/petcollege/petcollegetechbtn.prefab")

	self._leftLearnBtnGo.transform:SetParent(self:getGo("Nego_Left/SelectView/Viewport/Content/Nego_Select").transform)
	GameUtil.setLocalPos(self._leftLearnBtnGo, 20, 0, 0)
	GameUtil.setLocalScale(self._leftLearnBtnGo, 1)

	local okBtnGo = goutil.findChild(self._leftLearnBtnGo, "okBtn")
	local change = okBtnGo:GetComponent(ComponentType.UIImageSpriteChange)
	local btn = GameUtil.asBtn(okBtnGo)
	local spriteName = PetCollegeConfig.instance:getStageCfgByStageId(self._challengeId, self._stageId).LabelName

	change:ChangeSprite(spriteName)
	btn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.PetcollegetipView, self._challengeId, self._stageId)
	end)
end

function PetcollegemissionView:procMid()
	local cfg = PetCollegeConfig.instance:getTeamCfgByStage(self._challengeId, self._stageId)
	local titleStr = cfg.name
	local levelStr = ""

	if not cfg.rule then
		self._formCondition = cfg.formCondition

		self:_setDescStr(titleStr, levelStr, cfg.rule)
		self:_setValidatorDesc(self._formCondition)
		self:_setRedPoint(cfg.redPoint)

		local cfgPerfectWin = BattleSettlementConfig.instance:getBattlePerfectWinOpCfgById(cfg.perfectWinId)
		local cfgPerfectWinOpType = BattleSettlementConfig.instance:getBattlePerfectWinOpTypeCfgById(cfg.perfectWinId)

		if cfgPerfectWin and cfgPerfectWinOpType then
			local perfectDesc = string.format(cfgPerfectWinOpType.desc, cfgPerfectWin.params)

			self:_setPerfectRuleDesc(perfectDesc)
		end
	end
end

function PetcollegemissionView:_onClickStart()
	if PetCollegeModel.instance:isCurFormationEmpty() then
		TipsFacade.instance:openTipWindow(lang("tip"), lang("fight_unformation"), nil, "去布阵")

		return
	end

	if not self:_isFormationValidatorMatchOnStart() then
		return
	end

	local flag = self:_checkFormationPosNumber(function()
		self:_startClg()
	end)

	if flag then
		return
	end

	self:_startClg()
end

function PetcollegemissionView:_startClg()
	self:_setMaskBlock(true)
	self:_startNow()
end

function PetcollegemissionView:_checkFormationPosNumber(posLimitCallback)
	if self:_isNotCheckFull() then
		return false
	end

	local formation = PetCollegeModel.instance:getFormation()
	local numPos = formation:getCurExistPetNumber()
	local totalPos = math.min(5, #PetCollegeConfig.instance:getSupportPetIds(self._challengeId, self._stageId))

	if numPos < totalPos then
		TipsFacade.instance:openPopupWindow(lang("tip"), string.format(lang("fight_fmt_num"), tostring(totalPos)), posLimitCallback)

		return true
	end
end

function PetcollegemissionView:_setBattleResultTxtTitle()
	BattleSettlementModel.instance:setTxtTitle("精灵试用空间")
end

function PetcollegemissionView:_startNow()
	self:_setBattleResultTxtTitle()
	GlobalDispatcher:removeListener(GlobalNotify.FormationRefresh, self._startNow, self)
	BattleFacade.instance:startPetCollege(self._challengeId, self._stageId)
	UIJumper.instance:saveCurStack()

	local topState = UIJumper.instance:getTopState()

	if topState then
		UIJumper.instance:removeTopState(topState.state)
	end

	PetCollegeController.instance:sendPetCollegeChallengeReq(self._challengeId, self._stageId)
end

function PetcollegemissionView:_onClickClean()
	PetCollegegFastFormation.instance:clean()
end

function PetcollegemissionView:_isFormationValidatorMatchOnStart()
	return FormationValidatorController.instance:isFormationValidatorMatchOnStart(self._formCondition, self:_getCurFormation())
end

function PetcollegemissionView:_onFormationChangeFinish()
	PetcollegemissionView.super._onFormationChangeFinish(self)
	self:_setValidatorDesc(self._formCondition)
end

function PetcollegemissionView:_getCurFormation()
	return PetCollegeModel.instance:getFormation()
end

function PetcollegemissionView:_isNotCheckFull()
	if self._challengeId == 12 then
		return true
	end

	if self._challengeId == 40 then
		return true
	end
end

return PetcollegemissionView
