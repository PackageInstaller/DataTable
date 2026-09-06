-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originashlessdragon/view/OriginAshlessDragonBudgetPopView.lua

module("logic.extensions.originashlessdragon.view.OriginAshlessDragonBudgetPopView", package.seeall)

local OriginAshlessDragonBudgetPopView = class("OriginAshlessDragonBudgetPopView", ViewComponent)

function OriginAshlessDragonBudgetPopView:buildUI()
	OriginAshlessDragonBudgetPopView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnSure = self:getGo("btnSure")
	self._txtValueConstruciton = self:getTxt("construciton/txtValue")
	self._txtProgressConstruciton = self:getTxt("construciton/txtProgress")
	self._strTxtProgressConstruciton = self._txtProgressConstruciton.text
	self._txtProgressRisk = self:getTxt("risk/txtProgress")
	self._txtValueRisk = self:getTxt("risk/txtValue")
	self._strTxtProgressRisk = self._txtProgressRisk.text
	self._txtCount = self:getTxt("count/txt")
	self._btnAddTen = self:getGo("adjust/btnAddTen")
	self._btnLessTen = self:getGo("adjust/btnLessTen")
	self._btnAdd = self:getGo("adjust/btnAdd")
	self._btnLess = self:getGo("adjust/btnLess")
	self._txtBudget = self:getTxt("txtBudget")
	self._strBudget = self._txtBudget.text
	self._imgSelect = self:getGo("btnTogglePop/imgSelect")
	self._btnTogglePop = self:getGo("btnTogglePop")
end

function OriginAshlessDragonBudgetPopView:bindEvents()
	OriginAshlessDragonBudgetPopView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnAddTen, GameUtil.handler(self._updateBudgetValue, self, 10), self)
	GameUtil.addClickHandler(self._btnLessTen, GameUtil.handler(self._updateBudgetValue, self, -10), self)
	GameUtil.addClickHandler(self._btnAdd, GameUtil.handler(self._updateBudgetValue, self, 1), self)
	GameUtil.addClickHandler(self._btnLess, GameUtil.handler(self._updateBudgetValue, self, -1), self)
end

function OriginAshlessDragonBudgetPopView:unbindEvents()
	OriginAshlessDragonBudgetPopView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnAddTen)
	GameUtil.rmClickHandler(self._btnLessTen)
	GameUtil.rmClickHandler(self._btnAdd)
	GameUtil.rmClickHandler(self._btnLess)
end

function OriginAshlessDragonBudgetPopView:onEnter()
	OriginAshlessDragonBudgetPopView.super.onEnter(self)

	local params = self:getOpenParam() or {}
	local activityId = checknumber(params[1])
	local phaseId = checknumber(params[2])
	local stageId = checknumber(params[3])
	local investBudget = params[4]
	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(activityId)

	if not isInTime then
		self:close()

		return
	end

	self._activityId = activityId
	self._phaseId = phaseId
	self._stageId = stageId
	self._subMo = OriginAshlessDragonController.instance:getSubMo(self._activityId)
	self._leftInvestBudget = 0

	local savedBudget = self._subMo:getSelectedBudget(phaseId, stageId)

	self._investBudget = investBudget and investBudget or savedBudget
	self._investBudget = self._investBudget or 0

	self:_onUpdate()
end

function OriginAshlessDragonBudgetPopView:onExit()
	OriginAshlessDragonBudgetPopView.super.onExit(self)
end

function OriginAshlessDragonBudgetPopView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function OriginAshlessDragonBudgetPopView:_onUpdateData()
	self._leftInvestBudget = self._subMo:getLeftInvestBudgetInPhase(self._phaseId)
	self._investBudget = Mathf.Clamp(self._investBudget, 0, self._leftInvestBudget)
end

function OriginAshlessDragonBudgetPopView:_onUpdateUI()
	local remain = self._leftInvestBudget - self._investBudget

	self._txtBudget.text = string.format(self._strBudget, remain, self._leftInvestBudget)
	self._txtCount.text = self._investBudget

	local deltaConstruction = self._subMo:getConstructionUnit(self._phaseId, self._investBudget)
	local targetConstruction = self._subMo:getTargetConstructionInPhase(self._phaseId)
	local curConstruction = self._subMo:getConstructionInPhase(self._phaseId)

	self._txtValueConstruciton.text = string.format("+%s", deltaConstruction)
	self._txtProgressConstruciton.text = string.format(self._strTxtProgressConstruciton, curConstruction + deltaConstruction, targetConstruction)

	local deltaRisk = self._subMo:getRiskUnit(self._phaseId, self._investBudget)
	local curRisk = self._subMo:getTotalRisk()

	self._txtValueRisk.text = string.format("+%s", deltaRisk)
	self._txtProgressRisk.text = string.format(self._strTxtProgressRisk, curRisk + deltaRisk)

	local result = self:_getTrySureBudgetResultAndTips(false)

	GameUtil.SetGray(self._btnSure, result ~= GameEnum.ResultCode.Success)
end

function OriginAshlessDragonBudgetPopView:_getTrySureBudgetResultAndTips(isShowTips)
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
		local isEnoughBudget = self._investBudget <= self._leftInvestBudget

		if not isEnoughBudget then
			result = GameEnum.ResultCode.Error
			tips = "预算不足"
		end
	end

	if isShowTips then
		FloatWordMgr.instance:show(tips)
	end

	return result
end

function OriginAshlessDragonBudgetPopView:_updateBudgetValue(delta)
	local newInvestBudget = Mathf.Clamp(self._investBudget + delta, 0, self._leftInvestBudget)

	if newInvestBudget ~= self._investBudget then
		self._investBudget = newInvestBudget

		self._subMo:saveSelectedBudget(self._phaseId, self._stageId, self._investBudget)
		self:_onUpdateUI()
	end
end

function OriginAshlessDragonBudgetPopView:_onClickBtnSure()
	local result = self:_getTrySureBudgetResultAndTips(true)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	OriginAshlessDragonController.instance:enterStageBattle(self._activityId, self._phaseId, self._stageId, self._investBudget)
	self:close()
end

return OriginAshlessDragonBudgetPopView
