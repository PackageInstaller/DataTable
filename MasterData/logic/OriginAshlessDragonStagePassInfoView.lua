-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originashlessdragon/view/OriginAshlessDragonStagePassInfoView.lua

module("logic.extensions.originashlessdragon.view.OriginAshlessDragonStagePassInfoView", package.seeall)

local OriginAshlessDragonStagePassInfoView = class("OriginAshlessDragonStagePassInfoView", ViewComponent)

function OriginAshlessDragonStagePassInfoView:buildUI()
	OriginAshlessDragonStagePassInfoView.super.buildUI(self)

	self._txtResult = self:getTxt("result/txt")
	self._strTxtResult = self._txtResult.text
	self._txtDetail = self:getTxt("detail/txt")
	self._strTxtDetail = self._txtDetail.text
	self._txtTip = self:getTxt("bg/txt1")

	local petScrView = self:getGo("petCol/scrView")
	local petScrCell = self:getGo("petCol/scrCell")

	self._petScrollerList = ScrollerList.create(petScrView, petScrCell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))

	self._petScrollerList:setCenterMode(true)

	self._customInput = UICustomInput.Get(self.mainGO)
end

function OriginAshlessDragonStagePassInfoView:bindEvents()
	OriginAshlessDragonStagePassInfoView.super.bindEvents(self)
	self._customInput:AddListener(function(self, hover)
		if not hover then
			self:close()
		end
	end, self)
end

function OriginAshlessDragonStagePassInfoView:unbindEvents()
	OriginAshlessDragonStagePassInfoView.super.unbindEvents(self)
	self._customInput:RemoveListener()
end

function OriginAshlessDragonStagePassInfoView:onEnter()
	OriginAshlessDragonStagePassInfoView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._phaseId = checknumber(params[2])
	self._stageId = checknumber(params[3])
	self._subMo = OriginAshlessDragonController.instance:getSubMo(self._activityId)
	self._lockRaceIds = self._subMo:getLockRaceIdsInStage(self._phaseId, self._stageId)
	self._balanceAddConstruction = self._subMo:getBalanceAddConstructionInStage(self._phaseId, self._stageId)
	self._investBudget = self._subMo:getInvestBudgetInStage(self._phaseId, self._stageId)

	local stageData = OriginAshlessDragonConfig.instance:getStageData(self._activityId, self._phaseId, self._stageId)

	if stageData then
		::label_5_0::

		local balancePlanData = OriginAshlessDragonConfig.instance:getBalancePlanData(stageData.balancePlanId)

		if balancePlanData then
			if not balancePlanData.constructionAddUnit then
				local constructionAddUnit = 1

				if constructionAddUnit > 0 then
					self._balanceValue = self._balanceAddConstruction / constructionAddUnit or 0
				end

				self:_onUpdate()
			end
		end
	end
end

function OriginAshlessDragonStagePassInfoView:onExit()
	OriginAshlessDragonStagePassInfoView.super.onExit(self)
	self._petScrollerList:dispose()
end

function OriginAshlessDragonStagePassInfoView:_onUpdate()
	self._petScrollerList:reloadData(self._lockRaceIds)

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

function OriginAshlessDragonStagePassInfoView:_updatePetCell(view, cell, raceId, tag)
	local mainGo = cell.gameObject
	local itemGo = goutil.findChild(mainGo, "item")
	local proxy = MaterialMgr.setCell(MatType.Pet, raceId, itemGo)

	if proxy then
		proxy:setAutoTips(false)
	end
end

function OriginAshlessDragonStagePassInfoView:_clearPetCell(cell)
	local mainGo = cell.gameObject
	local itemGo = goutil.findChild(mainGo, "item")

	MaterialMgr.resetAll(itemGo)
end

function OriginAshlessDragonStagePassInfoView:_closeView()
	self:close()
	BattleController.instance:endBattle()
end

return OriginAshlessDragonStagePassInfoView
