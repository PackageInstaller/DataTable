-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktower/view/PeakTowerStageView.lua

module("logic.extensions.peaktower.view.PeakTowerStageView", package.seeall)

local PeakTowerStageView = class("PeakTowerStageView", ViewComponent)
local TYPE_BASIC = 1
local TYPE_LEGEND = 2

function PeakTowerStageView:ctor()
	PeakTowerStageView.super.ctor(self)
end

function PeakTowerStageView:unbindEvents()
	PeakTowerStageView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnReset)
	GameUtil.rmClickHandler(self._btnPollute)
	GameUtil.rmClickHandler(self._btnVerify)
	GameUtil.rmClickHandler(self._btnTip)
end

function PeakTowerStageView:bindEvents()
	PeakTowerStageView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickReset, self)
	GameUtil.addClickHandler(self._btnPollute, self._onClickPollute, self)
	GameUtil.addClickHandler(self._btnVerify, self._onClickVerify, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
end

function PeakTowerStageView:buildUI()
	PeakTowerStageView.super.buildUI(self)

	self._btnReset = self:getGo("btnReset")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("btnTip")
	self._btnPollute = self:getGo("btnPollute")
	self._btnVerify = self:getGo("btnVerify")
	self._stageTableView = self:getGo("stageTableView")
	self._stageTableCell = self:getGo("stageTableCell")
	self._stageList = ScrollerList.create(self._stageTableView, self._stageTableCell, GameUtil.handler(self._updateStageCell, self), GameUtil.handler(self._clearStageCell, self))

	self._stageList:setCenterMode(true)

	self._petCell = self:getGo("petCell")
	self._scoreTableview = self:getGo("scoreTableview")
	self._conditionTablecell = self:getGo("conditionTablecell")
	self._scoreTableList = ScrollerList.create(self._scoreTableview, self._conditionTablecell, GameUtil.handler(self._updateConditionCell, self), GameUtil.handler(self._clearConditionCell, self))
	self._txtScore = self:getTxt("txtScore")
	self._passPrizeGo = self:getGo("passPrize")
	self._prizeGain = self:getGo("passPrize/prizeGain")
	self._prizeCon = self:getGo("passPrize/prizeCon")
end

function PeakTowerStageView:onExit()
	PeakTowerStageView.super.onExit(self)

	for k, v in pairs(self._petTableListDic) do
		v:dispose()
	end

	self._petTableListDic = nil
end

function PeakTowerStageView:onExitFinished()
	if self._jumpNext and self._jumpNext == true then
		UIStateManager.instance:push(self._viewPresentor.viewName, self._activityId, self._mode, self._floorId + 1)

		self._jumpNext = nil
	end
end

function PeakTowerStageView:onEnter()
	PeakTowerStageView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_PeakTowerInfoRes, self._refreshView, self)
	self.addGEvent(self, GlobalNotify.PM_PeakTowerNotifyClgRes, self._PM_PeakTowerNotifyClgRes, self)

	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])
	self._mode = checknumber(params[2])
	self._floorId = checknumber(params[3])
	self._curWeekId = PeakTowerController.instance:getCurWeekId(self._activityId)

	GameUtil.SetActive(self._btnPollute, self._mode == TYPE_LEGEND)
	GameUtil.SetActive(self._btnVerify, self._mode == TYPE_LEGEND)

	self._petTableListDic = {}

	self:_initView()
	self:_refreshView()

	if PeakTowerController.instance:isEnterBattle() == true then
		self:_tryEnterNextStage()
		PeakTowerController.instance:resetEnterBattle()
	end

	PeakTowerController.instance:savePopViewName(self._activityId, self._viewPresentor.viewName)
end

function PeakTowerStageView:_initView()
	local aliveCfgs = PeakTowerConfig.instance:getAliveNumScoreCfgs(self._activityId)
	local aliveList = {}

	for k, v in pairs(aliveCfgs) do
		table.insert(aliveList, v)
	end

	table.sort(aliveList, function(a, b)
		return a.aliveNum[1] < b.aliveNum[1]
	end)

	local circleNumCfgs = PeakTowerConfig.instance:getCircleNumScoreCfgs(self._activityId)
	local circleNumList = {}

	for k, v in pairs(circleNumCfgs) do
		table.insert(circleNumList, v)
	end

	table.sort(circleNumList, function(a, b)
		return a.circle[1] < b.circle[1]
	end)

	local conditionList = {}

	for i, v in ipairs(aliveList) do
		table.insert(conditionList, {
			aliveCfg = v
		})
	end

	for i, v in ipairs(circleNumList) do
		if conditionList[i] then
			conditionList[i].circleCfg = v
		else
			table.insert(conditionList, {
				circleCfg = v
			})
		end
	end

	for i, v in ipairs(conditionList) do
		conditionList[i].index = i
	end

	self._scoreTableList:reloadData(conditionList)
end

function PeakTowerStageView:_refreshView()
	self._stageListCfg = nil

	local maxScore = 0
	local curScore = 0

	if self._mode == TYPE_BASIC then
		self._stageListCfg = PeakTowerConfig.instance:getBasicStageCfgs(self._activityId, self._curWeekId, self._floorId)
		maxScore = PeakTowerController.instance:getAllBasicScore(self._activityId)

		do
			local floorInfo = PeakTowerModel.instance:getBasicFloorInfo(self._activityId, self._floorId)

			if floorInfo then
				curScore = floorInfo.maxScore
			end

			GameUtil.SetActive(self._passPrizeGo, false)
			MaterialMgr.resetAll(self._prizeCon)
		end
	elseif self._mode == TYPE_LEGEND then
		self._stageListCfg = PeakTowerConfig.instance:getLegendStageCfgs(self._activityId, self._curWeekId, self._floorId)
		maxScore = PeakTowerController.instance:getAllLegendScore(self._activityId)

		local floorInfo = PeakTowerModel.instance:getLegendFloorInfo(self._activityId, self._floorId)

		if floorInfo then
			curScore = floorInfo.maxScore
		end

		GameUtil.SetActive(self._passPrizeGo, false)
		GameUtil.SetActive(self._prizeGain, PeakTowerModel.instance:getLegendGainPass(self._activityId, self._floorId))
		MaterialMgr.resetAll(self._prizeCon)

		local floorCfg = PeakTowerConfig.instance:getLegendFloorCfg(self._activityId, self._curWeekId, self._floorId)

		if not string.nilorempty(floorCfg.passFloorPrize) then
			MaterialMgr.setCellByCfg(floorCfg.passFloorPrize, self._prizeCon)
			GameUtil.SetActive(self._passPrizeGo, true)
		end
	end

	self._stageList:reloadData(self._stageListCfg or {})

	self._txtScore.text = langPara("本层最高分：%d\n总最高分数：%d", curScore, maxScore)
end

function PeakTowerStageView:_updateStageCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtName = goutil.findChildTextComponent(go, "stageName/txt")
	local petTableView = goutil.findChild(go, "petTableView")
	local emptyPetGo = goutil.findChild(go, "emptyPet")
	local teamEnemy = goutil.findChild(go, "teamEnemy")
	local enemyCellMap = {}

	for i = 1, 9 do
		local enemyCell = {}

		enemyCell.cellGo = goutil.findChild(teamEnemy, "cell_" .. i)
		enemyCell.con = goutil.findChild(enemyCell.cellGo, "con")
		enemyCellMap[i] = enemyCell

		GameUtil.SetActive(enemyCell.cellGo, false)
	end

	local btnChallenge = goutil.findChild(go, "teamEnemy")
	local passGo = goutil.findChild(teamEnemy, "mask")
	local petTableList = self._petTableListDic[go]

	if not petTableList then
		petTableList = ScrollerList.create(petTableView, self._petCell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))

		petTableList:setCenterMode(true)

		self._petTableListDic[go] = petTableList
	end

	local banPetIds

	if self._mode == TYPE_BASIC then
		banPetIds = PeakTowerModel.instance:getBasicStageBanPetIds(self._activityId, self._floorId, data.stageId)
	elseif self._mode == TYPE_LEGEND then
		banPetIds = PeakTowerModel.instance:getLegendStageBanPetIds(self._activityId, self._floorId, data.stageId)
	end

	local petIds = banPetIds or {}

	petTableList:reloadData(petIds)
	GameUtil.SetActive(emptyPetGo, not petIds or #petIds == 0)

	local creepsCfg = PeakTowerConfig.instance:getCreepsCfg(data.creepsMasterId)

	for i, v in ipairs(creepsCfg) do
		local enemyCell = enemyCellMap[v.posId]

		if enemyCell then
			MaterialMgr.resetAll(enemyCell.con)
			MaterialMgr.setIcon(enemyCell.con, MatType.Pet, v.raceId)
			GameUtil.SetActive(enemyCell.cellGo, true)
		end
	end

	GameUtil.rmClickHandler(btnChallenge)
	GameUtil.addClickHandler(btnChallenge, function()
		self:_onClickChallenge(data.stageId)
	end, self)

	if self._mode == TYPE_BASIC then
		GameUtil.SetActive(passGo, PeakTowerModel.instance:isBasicStagePass(self._activityId, self._floorId, data.stageId) == true)

		local stageInfo = PeakTowerModel.instance:getBasicStageInfo(self._activityId, self._floorId, data.stageId)

		txtName.text = langPara("当前分数:%d", (stageInfo or nil) and stageInfo.score)
	elseif self._mode == TYPE_LEGEND then
		GameUtil.SetActive(passGo, PeakTowerModel.instance:isLegendStagePass(self._activityId, self._floorId, data.stageId) == true)

		local stageInfo = PeakTowerModel.instance:getLegendStageInfo(self._activityId, self._floorId, data.stageId)

		txtName.text = langPara("当前分数:%d", (stageInfo or nil) and stageInfo.score)
	else
		GameUtil.SetActive(passGo, false)

		txtName.text = lang("当前分数:0")
	end
end

function PeakTowerStageView:_clearStageCell(cell)
	local go = cell.gameObject
	local teamEnemy = goutil.findChild(go, "teamEnemy")
	local btnChallenge = goutil.findChild(go, "teamEnemy")

	for i = 1, 9 do
		local cellGo = goutil.findChild(teamEnemy, "cell_" .. i)
		local con = goutil.findChild(cellGo, "icon")

		GameUtil.SetActive(cellGo, false)
		MaterialMgr.resetAll(con)
	end

	local petTableList = self._petTableListDic[go]

	if petTableList then
		petTableList:dispose()

		self._petTableListDic[go] = nil
	end

	GameUtil.rmClickHandler(btnChallenge)
end

function PeakTowerStageView:_updatePetCell(view, cell, data, tag)
	local go = cell.gameObject

	MaterialMgr.setCell(MatType.Pet, data, go)
end

function PeakTowerStageView:_clearPetCell(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

function PeakTowerStageView:_updateConditionCell(view, cell, data, tag)
	local go = cell.gameObject
	local bgGo = goutil.findChild(go, "bg")
	local txtAliveCondition = goutil.findChildTextComponent(go, "txtAliveCondition")
	local txtCircleCondition = goutil.findChildTextComponent(go, "txtCircleCondition")

	txtAliveCondition.text = data.aliveCfg and langPara("%d只→%d分", data.aliveCfg.aliveNum[1], data.aliveCfg.score) or ""
	txtCircleCondition.text = data.circleCfg and langPara("%d回合→%d分", data.circleCfg.circle[2], data.circleCfg.score) or ""

	GameUtil.SetActive(bgGo, data.index % 2 == 1)
end

function PeakTowerStageView:_clearConditionCell(cell)
	return
end

function PeakTowerStageView:_tryEnterNextStage()
	local isAllPass = true
	local hasNextFloor = false

	if self._mode == TYPE_BASIC then
		for i, v in ipairs(self._stageListCfg or {}) do
			if not PeakTowerModel.instance:isBasicStagePass(self._activityId, self._floorId, v.stageId) then
				isAllPass = false

				break
			end
		end

		hasNextFloor = PeakTowerConfig.instance:getBasicStageCfgs(self._activityId, self._curWeekId, self._floorId + 1) ~= nil
	elseif self._mode == TYPE_LEGEND then
		for i, v in ipairs(self._stageListCfg or {}) do
			if not PeakTowerModel.instance:isLegendStagePass(self._activityId, self._floorId, v.stageId) then
				isAllPass = false

				break
			end
		end

		hasNextFloor = PeakTowerConfig.instance:getLegendStageCfgs(self._activityId, self._curWeekId, self._floorId + 1) ~= nil
	end

	if isAllPass == true then
		if hasNextFloor == true then
			local content = lang("当前层已通关，是否跳转到下一层")

			TipsFacade.instance:openPopupWindow(lang("提示"), content, function()
				self._jumpNext = true

				self:close()
			end)
		elseif self._mode == TYPE_BASIC then
			local activityCfg = PeakTowerConfig.instance:getActivityCfg(self._activityId)
			local totalBasicScore = PeakTowerController.instance:getAllBasicScore(self._activityId)

			if totalBasicScore < checknumber(activityCfg.legendOpenScore) then
				local needScore = checknumber(activityCfg.legendOpenScore) - totalBasicScore
				local content = langPara("已通过所有关卡，<color=#ff2e2e>当前解锁传奇模式还需%d分</color>，可重复挑战提高分数噢！", needScore)

				TipsFacade.instance:openTipWindow(lang("提示"), content, function()
					self:close()
				end, lang("前往"))
			else
				local content = lang("已通过所有关卡，<color=#ff2e2e>传奇模式</color>已解锁，是否前往挑战？")

				TipsFacade.instance:openPopupWindow(lang("提示"), content, function()
					self:close()
					UIStateManager.instance:popByName(ViewName.PeakTowerBasicView)
					UIStateManager.instance:push(ViewName.PeakTowerLegendView, self._activityId)
				end)
			end
		end
	end
end

function PeakTowerStageView:_onClickChallenge(stageId)
	if self._mode == TYPE_BASIC then
		if not PeakTowerModel.instance:isBasicStagePass(self._activityId, self._floorId, stageId) then
			PeakTowerController.instance:openBasicMissionView(self._activityId, self._floorId, stageId)
		else
			FloatWordMgr.instance:show(lang("已通关该关卡"))
		end
	elseif self._mode == TYPE_LEGEND then
		if not PeakTowerModel.instance:isLegendStagePass(self._activityId, self._floorId, stageId) then
			PeakTowerController.instance:openLegendMissionView(self._activityId, self._floorId, stageId)
		else
			FloatWordMgr.instance:show(lang("已通关该关卡"))
		end
	end
end

function PeakTowerStageView:_onClickPollute()
	UIStateManager.instance:push(ViewName.PeakTowerPolluteView, self._activityId, self._floorId)
end

function PeakTowerStageView:_onClickVerify()
	UIStateManager.instance:push(ViewName.PeakTowerVerifyView, self._activityId)
end

function PeakTowerStageView:_onClickReset()
	if self._mode == TYPE_BASIC then
		local hasInfo = false

		for i, v in ipairs(self._stageListCfg or {}) do
			if PeakTowerModel.instance:isBasicStagePass(self._activityId, self._floorId, v.stageId) then
				hasInfo = true

				break
			end
		end

		if hasInfo == true then
			local content = langPara("是否重置第%d层挑战记录和上锁精灵？\n注：重置不影响本层最高分数。", self._floorId)

			TipsFacade.instance:openPopupWindow(lang("提示"), content, function()
				PeakTowerAgent.instance:sendPM_PeakTowerResetFloorReq(self._activityId, self._mode, self._floorId)
			end)
		else
			FloatWordMgr.instance:show("未通关任意关卡")
		end
	elseif self._mode == TYPE_LEGEND then
		local hasInfo = false

		for i, v in ipairs(self._stageListCfg or {}) do
			if PeakTowerModel.instance:isLegendStagePass(self._activityId, self._floorId, v.stageId) then
				hasInfo = true

				break
			end
		end

		if hasInfo == true then
			local content = langPara("是否重置第%d层挑战记录和上锁精灵？\n注：重置不影响本层最高分数。", self._floorId)

			TipsFacade.instance:openPopupWindow(lang("提示"), content, function()
				PeakTowerAgent.instance:sendPM_PeakTowerResetFloorReq(self._activityId, self._mode, self._floorId)
			end)
		else
			FloatWordMgr.instance:show("未通关任意关卡")
		end
	end
end

function PeakTowerStageView:_onClickTip()
	TipsFacade.instance:openRulesView("peak_tower_rule")
end

function PeakTowerStageView:_PM_PeakTowerNotifyClgRes()
	self:_refreshView()
	self:_tryEnterNextStage()
end

return PeakTowerStageView
