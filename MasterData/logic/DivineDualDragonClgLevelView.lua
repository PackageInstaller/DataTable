-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinedualdragonclg/view/DivineDualDragonClgLevelView.lua

module("logic.extensions.divinedualdragonclg.view.DivineDualDragonClgLevelView", package.seeall)

local DivineDualDragonClgLevelView = class("DivineDualDragonClgLevelView", ViewComponent)

function DivineDualDragonClgLevelView:ctor()
	DivineDualDragonClgLevelView.super.ctor(self)
end

function DivineDualDragonClgLevelView:unbindEvents()
	DivineDualDragonClgLevelView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)

	for i, v in pairs(self._cellList) do
		GameUtil.rmClickHandler(v.clickArea)
	end
end

function DivineDualDragonClgLevelView:bindEvents()
	DivineDualDragonClgLevelView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)

	for i, v in pairs(self._cellList) do
		GameUtil.addClickHandler(v.clickArea, function()
			self:_onClickArea(i)
		end, self)
	end
end

function DivineDualDragonClgLevelView:buildUI()
	DivineDualDragonClgLevelView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._tablecell = self:getGo("groupRoot/tablecell")
	self._tableview = self:getGo("groupRoot/tableview")
	self._tableScrollRect = self:getScrollRect("groupRoot/tableview")
	self._tableList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateStageCell, self), GameUtil.handler(self._clearStageCell, self))

	self._tableList:regValueChanged(function(tableview)
		self:_onSpringfinish(tableview)

		local horizontal = tableview:GetScrollRect().horizontal
		local vertical = tableview:GetScrollRect().vertical

		if horizontal and not vertical then
			ScrollerList._onScrollValueCircleHorizontalChange(tableview, 100, "content")
		end

		if not horizontal and vertical then
			ScrollerList._onScrollValueCircleVerticalChange(tableview, 100, "content")
		end
	end)
	self._tableList:getView():RegisterOnSetOffsetSpringFinishCallback(function(scrollerList, tableview)
		self:_onSpringfinish(tableview)
	end)

	self._cellList = {}

	local levelRoot = self:getGo("levelRoot")

	for i = 1, levelRoot.transform.childCount do
		local cellObj = {}
		local stageCell = goutil.findChild(levelRoot, "stageCell_" .. i)

		cellObj.go = stageCell

		local teamEnemy = goutil.findChild(stageCell, "teamEnemy")
		local enemyList = {}

		for j = 1, 9 do
			enemyList[j] = {
				go = goutil.findChild(teamEnemy, "cell_" .. j),
				con = goutil.findChild(teamEnemy, "cell_" .. j .. "/icon")
			}
		end

		cellObj.enemyList = enemyList
		cellObj.passGo = goutil.findChild(stageCell, "pass")
		cellObj.lockGo = goutil.findChild(stageCell, "lock")
		cellObj.conditionGo = goutil.findChild(stageCell, "condition")
		cellObj.txtCondition = goutil.findChildTextComponent(stageCell, "condition/txtCondition")
		cellObj.clickArea = goutil.findChild(stageCell, "clickArea")
		cellObj.passZdl = goutil.findChild(stageCell, "passZdl")
		cellObj.txtPassZdl = goutil.findChildTextComponent(stageCell, "passZdl/txt")
		self._cellList[i] = cellObj
	end

	self._itemCon = self:getGo("txtDesc/prize/itemCon")
	self._received = self:getGo("txtDesc/prize/received")
	self._receivedGo = self._received
	self._title = self:getGo("txtDesc/prize/title")
	self._prizeGo = self:getGo("txtDesc/prize")
end

function DivineDualDragonClgLevelView:onExit()
	DivineDualDragonClgLevelView.super.onExit(self)
	self._tableList:dispose()
end

function DivineDualDragonClgLevelView:onEnter()
	DivineDualDragonClgLevelView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_DivineDualDragonClgGetInfoRes, self._refreshView, self)
	self.addGEvent(self, GlobalNotify.PM_Notify_DivineDualDragonClgChallengeRes, self._refreshView, self)

	self._activityId = checknumber(self:getFirstParam())
	self._activityCfg = DivineDualDragonClgConfig.instance:getActivityCfg(self._activityId)
	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)
	self._isInit = false

	self:_initAoqiGodUI()
	self:_initListInfo()
	DivineDualDragonClgAgent.instance:sendPM_DivineDualDragonClgGetInfoReq(self._activityId)
end

function DivineDualDragonClgLevelView:_initAoqiGodUI()
	local showPrize = not self._isAoqiGodProcessType

	GameUtil.SetActive(self._prizeGo, showPrize)
	GameUtil.SetActive(self._title, showPrize)
	GameUtil.SetActive(self._received, showPrize)
end

function DivineDualDragonClgLevelView:_initListInfo()
	local phaseCfgs = DivineDualDragonClgConfig.instance:getPhaseCfgs(self._activityCfg.phasePlanId)

	self._showList = {}

	table.insert(self._showList, {
		empty = true
	})
	table.insert(self._showList, {
		empty = true
	})

	for i, v in ipairs(phaseCfgs) do
		table.insert(self._showList, {
			empty = false,
			cfg = v
		})
	end

	table.insert(self._showList, {
		empty = true
	})
	table.insert(self._showList, {
		empty = true
	})
end

function DivineDualDragonClgLevelView:_refreshView()
	if self:_checkAoqiGodFinish() then
		return
	end

	if not self._isInit then
		self._phaseId = DivineDualDragonClgModel.instance:getSelectPhaseId()

		if not self._phaseId then
			local phaseCfgs = DivineDualDragonClgConfig.instance:getPhaseCfgs(self._activityCfg.phasePlanId)

			for i, phaseCfg in ipairs(phaseCfgs) do
				local stagePlanCfg = DivineDualDragonClgConfig.instance:getStagesByStagePlanId(phaseCfg.stagePlanId)

				for j, v in ipairs(stagePlanCfg) do
					if v.finalStage == true and DivineDualDragonClgModel.instance:getStagePass(self._activityId, phaseCfg.phaseId, v.stageId) == false then
						self._phaseId = phaseCfg.phaseId

						break
					end
				end

				if self._phaseId then
					break
				end
			end

			self._phaseId = self._phaseId or 1
		end

		if self:isCanSeePassStage() == false and DivineDualDragonClgController.instance:isPassAllStage(self._activityId) == true then
			FloatWordMgr.instance:show(lang("已通关所有关卡"))
			self:close()

			return
		end
	end

	self._tableList:reloadData(self._showList)
	self:_refreshStageView()

	local selectCellIndex = 0

	for i, v in ipairs(self._showList) do
		if not v.empty and v.cfg.phaseId == self._phaseId then
			selectCellIndex = i

			break
		end
	end

	self._tableList:MoveCellToCenter(selectCellIndex - 1)

	self._isInit = true
end

function DivineDualDragonClgLevelView:_updateStageCell(view, cell, data, tag)
	local go = cell.gameObject
	local contentGo = goutil.findChild(go, "content")
	local passGo = goutil.findChild(contentGo, "pass")
	local imgPassBg = goutil.findChild(contentGo, "imgPassBg")
	local imgPassChangeGroup = goutil.findChildComponent(contentGo, "imgPassBg", ComponentType.UIImageSpriteChange)
	local imgSelect = goutil.findChild(contentGo, "imgSelect")
	local txtNameSelect = goutil.findChildTextComponent(contentGo, "nameSelectText")
	local txtNameNormal = goutil.findChildTextComponent(contentGo, "nameNormalText")
	local btnSelect = goutil.findChild(contentGo, "btnSelect")

	if data.empty == true then
		GameUtil.SetActive(contentGo, false)

		return
	else
		GameUtil.SetActive(contentGo, true)
	end

	local cfg = data.cfg

	txtNameNormal.text = langPara("第%d关", cfg.phaseId)
	txtNameSelect.text = langPara("第<size=28>%d</size>关", cfg.phaseId)

	local stagePlanCfg = DivineDualDragonClgConfig.instance:getStagesByStagePlanId(cfg.stagePlanId)
	local finalStageIndex

	for i, v in ipairs(stagePlanCfg) do
		if v.finalStage == true then
			finalStageIndex = i

			break
		end
	end

	local isPass = DivineDualDragonClgModel.instance:getStagePass(self._activityId, cfg.phaseId, finalStageIndex)

	GameUtil.SetActive(passGo, isPass)

	if isPass == true then
		imgPassChangeGroup:SetState(1)
	else
		imgPassChangeGroup:SetState(0)
	end

	GameUtil.SetActive(txtNameSelect, cfg.phaseId == self._phaseId)
	GameUtil.SetActive(txtNameNormal, cfg.phaseId ~= self._phaseId)
	GameUtil.SetActive(imgPassBg, cfg.phaseId ~= self._phaseId)
	GameUtil.SetActive(imgSelect, cfg.phaseId == self._phaseId)
end

function DivineDualDragonClgLevelView:_clearStageCell(cell)
	local go = cell.gameObject
	local contentGo = goutil.findChild(go, "content")
	local btnSelect = goutil.findChild(contentGo, "btnSelect")
end

function DivineDualDragonClgLevelView:_refreshStageView()
	local phaseCfg = DivineDualDragonClgConfig.instance:getPhaseCfg(self._activityCfg.phasePlanId, self._phaseId)
	local stagePlanCfg = DivineDualDragonClgConfig.instance:getStagesByStagePlanId(phaseCfg.stagePlanId)
	local finalStageIndex

	for i = 1, 3 do
		local stageCfg = stagePlanCfg[i]
		local cellObj = self._cellList[i]
		local teamCfg = DivineDualDragonClgConfig.instance:getTeamCfg(stageCfg.creepsMasterId)

		cellObj.txtCondition.text = teamCfg.ruleDesc

		local isLock = not DivineDualDragonClgController.instance:checkNormalStagePass(self._activityId, self._phaseId)

		GameUtil.SetActive(cellObj.lockGo, isLock and stageCfg.finalStage)
		GameUtil.SetActive(cellObj.conditionGo, not stageCfg.finalStage)
		GameUtil.SetActive(cellObj.passGo, DivineDualDragonClgModel.instance:getStagePass(self._activityId, self._phaseId, i))

		if stageCfg.finalStage == true then
			finalStageIndex = i
		end

		for j = 1, 9 do
			MaterialMgr.resetAll(cellObj.enemyList[j].con)
			GameUtil.SetActive(cellObj.enemyList[j].go, false)
		end

		local creepCfg = DivineDualDragonClgConfig.instance:getCreepsCfg(stageCfg.creepsMasterId)

		for j, v in ipairs(creepCfg) do
			if cellObj.enemyList[v.posId] then
				GameUtil.setLocalScale(cellObj.enemyList[v.posId].con, 0.8, 0.8, 0.8)

				local proxy = MaterialMgr.setCell(MatType.Pet, v.raceId, cellObj.enemyList[v.posId].con)

				if proxy then
					proxy.binder:setAutoTips(false)
					proxy.binder:setCallBack(function()
						self:_onClickArea(i)
					end)
				end

				GameUtil.SetActive(cellObj.enemyList[v.posId].go, true)
			end
		end

		local zdl = checknumber(DivineDualDragonClgModel.instance:getStageScore(self._activityId, self._phaseId, i))

		GameUtil.SetActive(cellObj.passZdl, zdl ~= 0 and self:isShowPassZdl())

		if cellObj.txtPassZdl then
			cellObj.txtPassZdl.text = langPara("历史最低战力：%d", zdl)
		end
	end

	MaterialMgr.setCellByCfg(phaseCfg.prize, self._itemCon)
	GameUtil.SetActive(self._receivedGo, DivineDualDragonClgModel.instance:getStagePass(self._activityId, self._phaseId, finalStageIndex))
end

function DivineDualDragonClgLevelView:_onClickArea(index)
	local phaseCfg = DivineDualDragonClgConfig.instance:getPhaseCfg(self._activityCfg.phasePlanId, self._phaseId)
	local stagePlanCfg = DivineDualDragonClgConfig.instance:getStagesByStagePlanId(phaseCfg.stagePlanId)
	local stageCfg = stagePlanCfg[index]

	if stageCfg.finalStage == true then
		if not DivineDualDragonClgController.instance:checkNormalStagePass(self._activityId, self._phaseId) then
			FloatWordMgr.instance:show(lang("未通关其余关卡"))
		else
			if not self:_checkPassAoqiGodProcessResult() then
				return
			end

			DivineDualDragonClgController.instance:openFinalMissionView(self._activityId, self._phaseId, index)
		end
	else
		if not self:_checkPassAoqiGodProcessResult() then
			return
		end

		DivineDualDragonClgController.instance:openNormalMissionView(self._activityId, self._phaseId, index)
	end
end

function DivineDualDragonClgLevelView:_checkPassAoqiGodProcessResult()
	if not self._isAoqiGodProcessType then
		return true
	end

	if self:_checkAoqiGodFinish() then
		return false
	end

	local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, DivineDualDragonClgController.instance:getActivityType(), self._activityId)

	return result == GameEnum.ResultCode.Success
end

function DivineDualDragonClgLevelView:_checkAoqiGodFinish()
	if not self._isAoqiGodProcessType then
		return false
	end

	if not DivineDualDragonClgController.instance:isPassAllStage(self._activityId) then
		return false
	end

	AoqiGodController.instance:doHandleChallengeFinishReady(DivineDualDragonClgController.instance:getActivityType(), self._activityId)
	self:close()

	return true
end

function DivineDualDragonClgLevelView:_onClickStage(phaseId)
	if self._phaseId ~= phaseId and self._isInit == true then
		if self:isCanSeePassStage() == true or DivineDualDragonClgController.instance:checkFinalStagePass(self._activityId, phaseId) == false then
			local selectCellIndex = 0
			local oldCellIndex = 0

			for i, v in ipairs(self._showList) do
				if not v.empty and v.cfg.phaseId == phaseId then
					selectCellIndex = i
				end

				if not v.empty and v.cfg.phaseId == self._phaseId then
					oldCellIndex = i
				end
			end

			self._phaseId = phaseId

			self._tableList:updateCellAtIndex(selectCellIndex - 1)
			self._tableList:updateCellAtIndex(oldCellIndex - 1)
			self:_refreshStageView()
			DivineDualDragonClgModel.instance:setSelectPhaseId(self._phaseId)
		else
			FloatWordMgr.instance:show(lang("已通关 回到当前的显示的界面"))

			local selectCellIndex = 0

			for i, v in ipairs(self._showList) do
				if not v.empty and v.cfg.phaseId == self._phaseId then
					selectCellIndex = i

					break
				end
			end

			self._tableList:MoveCellToCenter(selectCellIndex - 1)
		end
	end
end

function DivineDualDragonClgLevelView:_onClickClose()
	DivineDualDragonClgModel.instance:setSelectPhaseId(nil)
	self:close()
end

function DivineDualDragonClgLevelView:_onSpringfinish(tableview)
	local viewPortTrans = tableview:GetViewport()
	local content = tableview:GetContent()
	local _, conY, _ = Framework.TransformUtil.GetLocalPos(content.transform, 0, 0, 0)
	local height = goutil.getHeight(viewPortTrans)
	local closeCellIndex = 0
	local dirClose = height
	local count = tableview:GetVisibleCount()

	for i = 0, count - 1 do
		local cell = tableview:GetCellByIndex(i)

		if cell then
			local _, locy, _ = Framework.TransformUtil.GetLocalPos(cell.transform, 0, 0, 0)
			local yy = locy + conY
			local cellDir = math.abs(yy + height / 2)

			if cellDir < dirClose then
				closeCellIndex = cell.index
				dirClose = cellDir
			end
		end
	end

	if self._tableScrollRect.scrollRect.velocity.y == 0 and self._showList and self._showList[closeCellIndex + 1].cfg then
		self:_onClickStage(self._showList[closeCellIndex + 1].cfg.phaseId)
	end
end

function DivineDualDragonClgLevelView:isShowPassZdl()
	return false
end

function DivineDualDragonClgLevelView:isCanSeePassStage()
	return false
end

return DivineDualDragonClgLevelView
