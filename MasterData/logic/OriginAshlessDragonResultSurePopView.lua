-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originashlessdragon/view/OriginAshlessDragonResultSurePopView.lua

module("logic.extensions.originashlessdragon.view.OriginAshlessDragonResultSurePopView", package.seeall)

local OriginAshlessDragonResultSurePopView = class("OriginAshlessDragonResultSurePopView", ViewComponent)

function OriginAshlessDragonResultSurePopView:buildUI()
	OriginAshlessDragonResultSurePopView.super.buildUI(self)

	self._txtTitle = self:getTxt("txtTitle")
	self._txtResult = self:getTxt("result/txt")
	self._strTxtResult = self._txtResult.text
	self._txtDetail = self:getTxt("detail/txt")
	self._strTxtDetail = self._txtDetail.text
	self._txtTip = self:getTxt("txt1")
	self._btnSure = self:getGo("btnSure")
	self._btnCancel = self:getGo("btnCancel")

	local petScrView = self:getGo("petCol/scrView")
	local petScrCell = self:getGo("petCol/scrCell")

	self._petScrollerList = ScrollerList.create(petScrView, petScrCell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))

	self._petScrollerList:setCenterMode(true)
end

function OriginAshlessDragonResultSurePopView:bindEvents()
	OriginAshlessDragonResultSurePopView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
	GameUtil.addClickHandler(self._btnCancel, self._onClickBtnCancel, self)
end

function OriginAshlessDragonResultSurePopView:unbindEvents()
	OriginAshlessDragonResultSurePopView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnCancel)
end

function OriginAshlessDragonResultSurePopView:onEnter()
	OriginAshlessDragonResultSurePopView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._customFmtMo = params[1]
	self._activityId = self._customFmtMo:getActivityId()
	self._phaseId = self._customFmtMo:getPhaseId()
	self._stageId = self._customFmtMo:getStageId()
	self._investBudget = self._customFmtMo:getInvestBudget()
	self._subMo = OriginAshlessDragonController.instance:getSubMo(self._activityId)

	local msg = self._subMo:getFightResultMsg()

	if msg == nil then
		self:_closeView()

		return
	end

	if msg then
		self._lockRaceIds = msg.lockRaceIds or {}
	end

	if msg and msg:HasField("balanceAddConstruction") then
		self._balanceAddConstruction = msg.balanceAddConstruction or 0
	end

	if msg and msg:HasField("balanceValue") then
		self._balanceValue = msg.balanceValue or 0
	end

	self.addGEvent(self, GlobalNotify.HandlePM_OriginAshlessDragonConfirmRes, self._handlePM_OriginAshlessDragonConfirmRes, self)
	self:_onUpdate()
end

function OriginAshlessDragonResultSurePopView:onExit()
	OriginAshlessDragonResultSurePopView.super.onExit(self)
	self._petScrollerList:dispose()
end

function OriginAshlessDragonResultSurePopView:_handlePM_OriginAshlessDragonConfirmRes(status, msg)
	if status == 0 and msg.save then
		OriginAshlessDragonController.instance:sendPM_OriginAshlessDragonGetInfoReq(self._activityId)
	end

	self:_closeView()
end

function OriginAshlessDragonResultSurePopView:_onUpdate()
	local formation = self._customFmtMo:getCurFormation()
	local positions = formation:GetPositions()
	local petMoList = {}

	for _, petId in ipairs(positions) do
		local petMo = formation:_getPet(petId)

		if petMo and table.indexof(self._lockRaceIds, petMo:getDefineId()) ~= false then
			table.insert(petMoList, petMo)
		end
	end

	self._petScrollerList:reloadData(petMoList)

	local budget = self._investBudget
	local risk = self._subMo:getRiskUnit(self._phaseId, budget)
	local construction = self._subMo:getConstructionUnit(self._phaseId, budget)

	self._txtDetail.text = string.format(self._strTxtDetail, budget, construction, risk)

	local stageData = OriginAshlessDragonConfig.instance:getStageData(self._activityId, self._phaseId, self._stageId)
	local balancePlanId = stageData.balancePlanId
	local balancePlanData = OriginAshlessDragonConfig.instance:getBalancePlanData(balancePlanId)
	local balanceDesc = string.format(balancePlanData.formatDesc, self._balanceValue)

	self._txtResult.text = string.format("结算结果：%s 建设度+%s", balanceDesc, self._balanceValue * balancePlanData.constructionAddUnit)
end

function OriginAshlessDragonResultSurePopView:_updatePetCell(view, cell, petMo, tag)
	local mainGo = cell.gameObject
	local itemGo = goutil.findChild(mainGo, "item")

	MaterialMgr.setCell(MatType.Pet, petMo:getDefineId(), itemGo)
end

function OriginAshlessDragonResultSurePopView:_clearPetCell(cell)
	local mainGo = cell.gameObject
	local itemGo = goutil.findChild(mainGo, "item")

	MaterialMgr.resetAll(itemGo)
end

function OriginAshlessDragonResultSurePopView:_onClickBtnSure()
	OriginAshlessDragonController.instance:sendPM_OriginAshlessDragonConfirmReq(self._activityId, self._phaseId, self._stageId, true)
end

function OriginAshlessDragonResultSurePopView:_onClickBtnCancel()
	OriginAshlessDragonController.instance:sendPM_OriginAshlessDragonConfirmReq(self._activityId, self._phaseId, self._stageId, false)
end

function OriginAshlessDragonResultSurePopView:_closeView()
	self:close()
	BattleController.instance:endBattle()
end

return OriginAshlessDragonResultSurePopView
