-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originashlessdragon/view/OriginAshlessDragonStageView.lua

module("logic.extensions.originashlessdragon.view.OriginAshlessDragonStageView", package.seeall)

local OriginAshlessDragonStageView = class("OriginAshlessDragonStageView", ViewComponent)

function OriginAshlessDragonStageView:buildUI()
	OriginAshlessDragonStageView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtRuleTips = self:getTxt("ruleTips/txtRule")
	self._stageView = self:getGo("stage/stageView")
	self._stageCell = self:getGo("stage/stageCell")

	local txtConstrucitonStage = self:getTxt("stage/stageCell/detail/txtConstruciton")
	local txtRiskTempStage = self:getTxt("stage/stageCell/detail/txtRisk")

	self._strTxtConstrucitonStage = txtConstrucitonStage.text
	self._strTxtRiskStage = txtRiskTempStage.text
	self._btnReset = self:getGo("ruleTips/btnReset")
	self._tagHasGain = self:getGo("ruleTips/prize/tagHasGain")

	local prizeScrView = self:getGo("ruleTips/prize/scrView")
	local prizeScrCell = self:getGo("ruleTips/prize/scrCell")

	self._prizeScrollList = ScrollerList.create(prizeScrView, prizeScrCell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))

	self._prizeScrollList:setCenterMode(true)

	self._btnLast = self:getGo("btnLast")
	self._btnNext = self:getGo("btnNext")
	self._btnRisk = self:getGo("detail/btnRisk")
	self._txtTarget = self:getTxt("detail/txtTarget")
	self._strTxtTarget = self._txtTarget.text
	self._txtRisk = self:getTxt("detail/txtRisk")
	self._strTxtRisk = self._txtRisk.text
	self._txtBuff = self:getTxt("detail/txtBuff")
	self._strTxtBuff = self._txtBuff.text
	self._txtBudget = self:getTxt("budget/txt")
	self._endTips = self:getGo("budget/endTips")
	self._tagProgress = self:getGo("budget/tagProgress")
end

function OriginAshlessDragonStageView:bindEvents()
	OriginAshlessDragonStageView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickBtnReset, self)
	GameUtil.addClickHandler(self._btnLast, GameUtil.handler(self._changePhase, self, -1), self)
	GameUtil.addClickHandler(self._btnNext, GameUtil.handler(self._changePhase, self, 1), self)
	GameUtil.addClickHandler(self._btnRisk, self._onClickBtnRisk, self)
end

function OriginAshlessDragonStageView:unbindEvents()
	OriginAshlessDragonStageView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnReset)
	GameUtil.rmClickHandler(self._btnLast)
	GameUtil.rmClickHandler(self._btnNext)
	GameUtil.rmClickHandler(self._btnRisk)
end

function OriginAshlessDragonStageView:onEnter()
	OriginAshlessDragonStageView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._subMo = OriginAshlessDragonController.instance:getSubMo(self._activityId)

	self.addGEvent(self, GlobalNotify.HandlePM_OriginAshlessDragonGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_OriginAshlessDragonResetRes, self._onUpdate, self)
	self:_onUpdate()

	local changeSetId = self._subMo:popChangeSetId()

	if changeSetId then
		MaterialController.instance:showChangeSetInTemp(changeSetId)
	end
end

function OriginAshlessDragonStageView:onExit()
	OriginAshlessDragonStageView.super.onExit(self)
	self:_onClearStageCol()
	self:_onClearPrizeUI()
end

function OriginAshlessDragonStageView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function OriginAshlessDragonStageView:_onUpdateData()
	self._phaseId = checknumber(self._phaseId)

	local maxPhaseId = self._subMo:getMaxPhaseId()

	if self._phaseId <= 0 then
		for id = 1, maxPhaseId do
			self._phaseId = id

			local isPassed = self._subMo:isPassedInPhase(id)

			if not isPassed then
				break
			end
		end
	end

	self._phaseId = Mathf.Clamp(self._phaseId, 1, maxPhaseId)
end

function OriginAshlessDragonStageView:_onUpdateUI()
	self:_onUpdateStageCol()
	self:_onUpdatePrizeUI()

	local curConstruction = self._subMo:getConstructionInPhase(self._phaseId)
	local targetConstruction = self._subMo:getTargetConstructionInPhase(self._phaseId)

	self._txtBudget.text = self._subMo:getLeftInvestBudgetInPhase(self._phaseId)

	if curConstruction < targetConstruction then
		local construction = string.format("<color=#eb4624>%s</color>", curConstruction)

		self._txtTarget.text = string.format(self._strTxtTarget, construction, targetConstruction)
	else
		self._txtTarget.text = string.format(self._strTxtTarget, curConstruction, targetConstruction)
	end

	local currentTotalBudget = self._subMo:getCurrentTotalBudget()
	local useBudget = self._subMo:getUsedBudget()
	local risk = self._subMo:getTotalRisk()
	local debuffData = OriginAshlessDragonConfig.instance:getDebuffDataByRisk(self._activityId, risk)

	self._txtRisk.text = string.format(self._strTxtRisk, risk)

	if debuffData then
		self._txtBuff.text = debuffData.desc or self._strTxtBuff
	end

	local maxPhaseId = self._subMo:getMaxPhaseId()

	GameUtil.SetActive(self._endTips.gameObject, maxPhaseId <= self._phaseId)
	GameUtil.SetActive(self._btnLast, self._phaseId > 1)
	GameUtil.SetActive(self._btnNext, maxPhaseId > self._phaseId)

	local resetResult = self:_getTryResetPhaseResultAndTips(false, self._phaseId)

	GameUtil.SetGray(self._btnReset, resetResult ~= GameEnum.ResultCode.Success)

	local actData = OriginAshlessDragonConfig.instance:getActivityData(self._activityId)

	self._txtRuleTips.text = actData and actData.ruleTips
end

function OriginAshlessDragonStageView:_getTryEnterStageResultAndTips(isShowTips, phaseId, stageId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if result == GameEnum.ResultCode.Success then
		local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

		if not isInTime then
			result = GameEnum.ResultCode.Error
			tips = "不在活动时间范围内"
		end
	end

	if result == GameEnum.ResultCode.Success then
		local isUnlocked = self._subMo:isUnlockedInStage(phaseId, stageId)

		if not isUnlocked then
			result = GameEnum.ResultCode.Error
			tips = "未解锁"
		end
	end

	if result == GameEnum.ResultCode.Success then
		local isPassed = self._subMo:isPassedInStage(phaseId, stageId)

		if isPassed then
			result = GameEnum.ResultCode.IsPass
		end
	end

	if isShowTips then
		FloatWordMgr.instance:show(tips)
	end

	return result
end

function OriginAshlessDragonStageView:_getTryResetPhaseResultAndTips(isShowTips, phaseId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if result == GameEnum.ResultCode.Success then
		local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

		if not isInTime then
			result = GameEnum.ResultCode.Error
			tips = "不在活动时间范围内"
		end
	end

	if result == GameEnum.ResultCode.Success then
		local isHasPassedStage = false
		local stageDatas = OriginAshlessDragonConfig.instance:getStageDatas(self._activityId, phaseId)

		if stageDatas then
			for _, data in ipairs(stageDatas) do
				if self._subMo:isPassedInStage(phaseId, data.stageId) then
					isHasPassedStage = true

					break
				end
			end
		end

		if not isHasPassedStage then
			result = GameEnum.ResultCode.Error
			tips = "无需重置"
		end
	end

	if isShowTips then
		FloatWordMgr.instance:show(tips)
	end

	return result
end

function OriginAshlessDragonStageView:_onUpdateStageCol()
	local cfg = OriginAshlessDragonConfig.instance:getStageDatas(self._activityId, self._phaseId) or {}

	GameUtil.updateCellsList(self._stageView, self._stageCell, cfg, self._updateStageCell, self)
	self._stageView:GetComponent(ComponentType.TestRecordPos):LoadPlan(0)
end

function OriginAshlessDragonStageView:_onClearStageCol()
	GameUtil.clearCells(self._stageView, self._clearStageCell, self)
end

function OriginAshlessDragonStageView:_updateStageCell(mainGo, data, index)
	local phaseId = data.phaseId
	local stageId = data.stageId
	local isUnlockedStage = self._subMo:isUnlockedInStage(phaseId, stageId)
	local isPassedStage = self._subMo:isPassedInStage(phaseId, stageId)
	local investBudget = self._subMo:getInvestBudgetInStage(phaseId, stageId)
	local construction = self._subMo:getConstructionInStage(phaseId, stageId)
	local risk = self._subMo:getRiskInStage(phaseId, stageId)
	local btnGo = goutil.findChild(mainGo, "btn")
	local tagSelected = goutil.findChild(mainGo, "btn/tagSelected")
	local tagLock = goutil.findChild(mainGo, "btn/tagLock")
	local txtName = goutil.findChildTextComponent(mainGo, "btn/txtName")
	local txtBudget = goutil.findChildTextComponent(mainGo, "btn/txtBudget")
	local detailGo = goutil.findChild(mainGo, "detail")
	local txtRisk = goutil.findChildTextComponent(mainGo, "detail/txtRisk")
	local txtConstruciton = goutil.findChildTextComponent(mainGo, "detail/txtConstruciton")

	txtName.text = data.name
	txtBudget.text = investBudget
	txtRisk.text = string.format(self._strTxtRiskStage, risk)
	txtConstruciton.text = string.format(self._strTxtConstrucitonStage, construction)

	GameUtil.SetActive(tagLock, not isUnlockedStage)
	GameUtil.SetActive(detailGo, isUnlockedStage and isPassedStage)
	GameUtil.SetActive(txtBudget.gameObject, isUnlockedStage and isPassedStage)
	GameUtil.SetActive(txtName.gameObject, not GameUtil.GetActive(txtBudget.gameObject))
	GameUtil.addClickHandler(btnGo, function()
		local result = self:_getTryEnterStageResultAndTips(true, phaseId, stageId)

		if result == GameEnum.ResultCode.Success then
			UIStateManager.instance:push(ViewName.OriginAshlessDragonBudgetPopView, self._activityId, phaseId, stageId)
		elseif result == GameEnum.ResultCode.IsPass then
			UIStateManager.instance:push(ViewName.OriginAshlessDragonStagePassInfoView, self._activityId, phaseId, stageId)
		end
	end, self)
end

function OriginAshlessDragonStageView:_clearStageCell(mainGo)
	local btnGo = goutil.findChild(mainGo, "btnGo")

	GameUtil.rmClickHandler(btnGo)
end

function OriginAshlessDragonStageView:_onUpdatePrizeUI()
	local isHistoryPassedInPhase = self._subMo:isHistoryPassedInPhase(self._phaseId)

	GameUtil.SetActive(self._tagHasGain, isHistoryPassedInPhase)

	local phaseData = OriginAshlessDragonConfig.instance:getPhaseData(self._activityId, self._phaseId)
	local prizeArray = phaseData and string.split(phaseData.prize, "#") or {}

	self._prizeScrollList:reloadData(prizeArray)
end

function OriginAshlessDragonStageView:_onClearPrizeUI()
	self._prizeScrollList:dispose()
end

function OriginAshlessDragonStageView:_updatePrizeCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject
	local itemGo = goutil.findChild(mainGo, "item")

	MaterialMgr.setCellByCfg(prizeStr, itemGo)
end

function OriginAshlessDragonStageView:_clearPrizeCell(cell)
	local mainGo = cell.gameObject
	local itemGo = goutil.findChild(mainGo, "item")

	MaterialMgr.resetAll(itemGo)
end

function OriginAshlessDragonStageView:_changePhase(delta)
	local phaseId = Mathf.Clamp(self._phaseId + delta, 1, self._subMo:getMaxPhaseId())

	if phaseId == self._phaseId then
		return
	end

	self._phaseId = phaseId

	self:_onUpdateUI()
end

function OriginAshlessDragonStageView:_onClickBtnTip()
	local actData = OriginAshlessDragonConfig.instance:getActivityData(self._activityId)
	local key = actData and actData.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

function OriginAshlessDragonStageView:_onClickBtnReset()
	local result = self:_getTryResetPhaseResultAndTips(true, self._phaseId)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	local tipsContent = "仅重置本层及本层之后所有关卡状态，是否确认？"

	local function okFunc()
		OriginAshlessDragonController.instance:sendPM_OriginAshlessDragonResetReq(self._activityId, self._phaseId)
	end

	TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, nil, "确定", "取消")
end

function OriginAshlessDragonStageView:_onClickBtnRisk()
	UIStateManager.instance:push(ViewName.OriginAshlessDragonBuffView, self._activityId)
end

return OriginAshlessDragonStageView
