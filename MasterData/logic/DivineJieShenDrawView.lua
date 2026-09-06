-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinejieshen/view/DivineJieShenDrawView.lua

module("logic.extensions.divinejieshen.view.DivineJieShenDrawView", package.seeall)

local DivineJieShenDrawView = class("DivineJieShenDrawView", ViewComponent)

function DivineJieShenDrawView:ctor()
	DivineJieShenDrawView.super.ctor(self)
end

function DivineJieShenDrawView:buildUI()
	DivineJieShenDrawView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._trialView = goutil.findChild(self.mainGO, "trialView")
	self._trialCell = goutil.findChild(self.mainGO, "trialCell")
	self._btnEnter = goutil.findChild(self.mainGO, "btnEnter")
	self._btnDraw = goutil.findChild(self.mainGO, "btnDraw")
	self._drawAgain = goutil.findChild(self.mainGO, "drawAgain")
	self._btnDrawAgain = goutil.findChild(self.mainGO, "drawAgain/btn")
	self._costDrawAgain = goutil.findChild(self.mainGO, "drawAgain/cost")
	self._iconCostDrawAgain = goutil.findChild(self.mainGO, "drawAgain/cost/icon")
	self._txtNumCostDrawAgain = goutil.findChildTextComponent(self.mainGO, "drawAgain/cost/txtNum")
	self._trailCellList = {}

	GameUtil.SetActive(self._trialCell, false)
end

function DivineJieShenDrawView:bindEvents()
	DivineJieShenDrawView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnEnter, self._onClickBtnEnter, self)
	GameUtil.addClickHandler(self._btnDraw, self._onClickBtnDraw, self)
	GameUtil.addClickHandler(self._btnDrawAgain, self._onClickBtnDraw, self)
end

function DivineJieShenDrawView:unbindEvents()
	DivineJieShenDrawView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnEnter)
	GameUtil.rmClickHandler(self._btnDraw)
	GameUtil.rmClickHandler(self._btnDrawAgain)
end

function DivineJieShenDrawView:onEnter()
	DivineJieShenDrawView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._stageId = checknumber(params[2])

	local isInTime = DivineJieShenController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._divineJieShenMo = DivineJieShenModel.instance:getDivineJieShenMo(self._activityId)
	self._curStageTrialId = 0

	self.addGEvent(self, GlobalNotify.HandlePM_DivineJieShenClgGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_DivineJieShenClgNormalRandomTrialRes, self._handlePM_DivineJieShenClgNormalRandomTrialRes, self)
	self:_onUpdate()
end

function DivineJieShenDrawView:onExit()
	DivineJieShenDrawView.super.onExit(self)
	self:_stopTurnGames()
	self:_onClear()
end

function DivineJieShenDrawView:_handlePM_DivineJieShenClgNormalRandomTrialRes(msg)
	self._randomTrialId = msg.randomTrialId

	local index = 0
	local cellList = {}

	for trialMode, cell in ipairs(self._trailCellList) do
		if self._randomTrialId == trialMode then
			index = trialMode
		end

		table.insert(cellList, cell)
	end

	if index > 0 then
		self:_startTurnGames(index, cellList)
	else
		printError("错误,试图寻找不存在的index")
	end
end

function DivineJieShenDrawView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function DivineJieShenDrawView:_onUpdateData()
	local cfg = DivineJieShenConfig.instance:getRandomPlanCfg(self._activityId)
	local parentTran = self._trialView.transform
	local childCount = parentTran.childCount
	local length = Mathf.Max(#cfg, childCount)

	table.clear(self._trailCellList)

	for index = 1, length do
		local mainGo = index <= childCount and parentTran:GetChild(index - 1).gameObject or goutil.cloneAndSetParent(self._trialCell, parentTran, self._trialCell.name .. "_" .. index)

		if index <= #cfg then
			local cell = {}

			cell.mainGo = mainGo
			cell.txtName = goutil.findChildTextComponent(mainGo, "name/txt")
			cell.imgPoster = goutil.findChild(mainGo, "imgPoster")
			cell.imgSelected = goutil.findChild(mainGo, "imgSelected")

			table.insert(self._trailCellList, cell)
			GameUtil.SetActive(mainGo, true)
		else
			GameUtil.SetActive(mainGo, false)
		end
	end

	self._curStageTrialId = self._divineJieShenMo:getCurStageTrialId()
end

function DivineJieShenDrawView:_onUpdateUI()
	self:_onUpdatePlaneUI()
	self:_onUpdateTrialColUI()
end

function DivineJieShenDrawView:_onClear()
	MaterialMgr.clearIcon(self._iconCostDrawAgain)
	self:_onClearTrialColUI()
end

function DivineJieShenDrawView:_onUpdatePlaneUI()
	local curStageTrialId = self._curStageTrialId
	local curDrawCost = self._divineJieShenMo:getCurDrawCostInNor()

	if not string.nilorempty(curDrawCost) then
		local matType, matId, matNum = MaterialMgr.getMatParams(curDrawCost)

		MaterialMgr.setIcon(self._iconCostDrawAgain, matType, matId, nil, nil)

		self._txtNumCostDrawAgain.text = matNum

		GameUtil.SetActive(self._costDrawAgain, true)
	else
		MaterialMgr.clearIcon(self._iconCostDrawAgain)
		GameUtil.SetActive(self._costDrawAgain, false)
	end

	GameUtil.SetActive(self._btnDraw, curStageTrialId <= 0)
	GameUtil.SetActive(self._drawAgain, curStageTrialId > 0)
	GameUtil.SetActive(self._btnEnter, curStageTrialId > 0)

	local enterResult = self:_getTryEnterResultAndTips(self._activityId, curStageTrialId)

	GameUtil.SetGray(self._btnEnter, enterResult ~= GameEnum.ResultCode.Success)

	local drawResult = self:_getTryDrawResultAndTips(self._activityId)

	GameUtil.SetGray(self._btnDraw, drawResult ~= GameEnum.ResultCode.Success)
	GameUtil.SetGray(self._drawAgain, drawResult ~= GameEnum.ResultCode.Success)
end

function DivineJieShenDrawView:_onUpdateTrialColUI()
	for trialMode, cell in ipairs(self._trailCellList) do
		local data = DivineJieShenConfig.instance:getRandomPlanData(self._activityId, trialMode)

		self:_updateTrialCell(cell, data)
	end
end

function DivineJieShenDrawView:_onClearTrialColUI()
	table.clear(self._trailCellList)
	GameUtil.clearCells(self._trialView, self._clearTrialCell, self)
end

function DivineJieShenDrawView:_updateTrialCell(cell, data)
	cell.txtName.text = data.name

	uGuiUtil.setSpriteToImage(cell.imgPoster, uGuiUtil.SpriteType.BigBg, data.imgUrl .. ".png")
	GameUtil.SetActive(cell.imgSelected, self._curStageTrialId == data.trialMode)
end

function DivineJieShenDrawView:_clearTrialCell(mainGo)
	local imgPoster = goutil.findChild(mainGo, "imgPoster")

	uGuiUtil.clearImage(imgPoster)
end

function DivineJieShenDrawView:_startTurnGames(targetIdx, cellList)
	self:_stopTurnGames()
	ViewBlockMgr.instance:blockClick(true, self)

	self._animGameCellList = cellList
	self._interval = 0.01
	self._sumInr = 0
	self._startInr = 0.05
	self._endInr = 0.25
	self._limitInr = 0
	self._cellCount = #self._animGameCellList
	self._curStepCount = -1
	self._totalStepCount = 5 - 5 % self._cellCount + targetIdx - 1

	settimer(self._interval, self._onTicking, self, true)
	self:_onTicking()
end

function DivineJieShenDrawView:_stopTurnGames()
	removetimer(self._onTicking, self)
	removetimer(self._endTurnGames, self)
	removetimer(self._lightCell, self)
	ViewBlockMgr.instance:blockClick(false, self)
end

function DivineJieShenDrawView:_onTicking()
	self._sumInr = self._sumInr + self._interval

	if self._sumInr < self._limitInr then
		return
	end

	self._sumInr = 0
	self._curStepCount = self._curStepCount + 1

	local stepIdx = self._curStepCount % self._cellCount + 1
	local t = self._curStepCount / self._totalStepCount - 0.5

	self._limitInr = Mathf.SmoothStep(self._startInr, self._endInr, t)

	for idx, cell in ipairs(self._animGameCellList) do
		GameUtil.SetActive(cell.imgSelected, stepIdx == idx)
	end

	if self._curStepCount >= self._totalStepCount then
		removetimer(self._onTicking, self)

		self._animGameCellList = {}

		self:_readyEndTurnGames()

		return
	end
end

function DivineJieShenDrawView:_readyEndTurnGames()
	self._lightTimes = 0
	self._totalLightTimes = 3
	self._isLight = false

	removetimer(self._lightCell, self)
	settimer(0.3, self._lightCell, self, true)
end

function DivineJieShenDrawView:_lightCell()
	local cell = self._trailCellList[self._randomTrialId]

	GameUtil.SetActive(cell.imgSelected, self._isLight)

	self._isLight = not self._isLight
	self._lightTimes = self._lightTimes + 1

	if self._lightTimes > self._totalLightTimes then
		removetimer(self._lightCell, self)
		self:_endTurnGames()
	end
end

function DivineJieShenDrawView:_endTurnGames()
	ViewBlockMgr.instance:blockClick(false, self)
	self:_doTrail(self._randomTrialId)
end

function DivineJieShenDrawView:_doTrail(trialMode)
	local isNeedAutoClose = true

	if trialMode == DivineJieShenEnum.TrialMode_Battle then
		DivineJieShenController.instance:enterBattleInNorStage(self._activityId, self._stageId)
	elseif trialMode == DivineJieShenEnum.TrialMode_EuropeanEmirate then
		local tipsContent = "恭喜你，抽中欧气爆棚，直接进入下一关！"

		local function okFunc()
			self:close()
			GlobalDispatcher:dispatch(GlobalNotify.DivineJieShenNorViewUpdate)
		end

		local alignment = UnityEngine.TextAnchor.MiddleCenter

		TipsFacade.instance:openTipWindowNoX("提示", tipsContent, okFunc, "确定", alignment)

		isNeedAutoClose = false
	elseif trialMode == DivineJieShenEnum.TrialMode_BoxGame then
		DivineJieShenController.instance:enterBoxGameInNorStage(self._activityId, self._stageId)
	elseif trialMode == DivineJieShenEnum.TrialMode_Answer then
		DivineJieShenController.instance:enterAnswerInNorStage(self._activityId, self._stageId)
	else
		printError(string.format("错误,试图进入不存在的试炼类型,trialMode=%d", trialMode))
	end

	if isNeedAutoClose then
		self:close()
	end
end

function DivineJieShenDrawView:_getTryDrawResultAndTips(activityId)
	local result = GameEnum.ResultCode.Success
	local tips = ""
	local mo = self._divineJieShenMo
	local stageId = self._stageId

	if not DivineJieShenController.instance:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间范围内"
	elseif mo:isPassBossInNor() then
		result = GameEnum.ResultCode.IsPass
		tips = "已通关"
	elseif mo:isPassedStageInNor(stageId) then
		result = GameEnum.ResultCode.IsPass
		tips = "已通关"
	elseif not mo:isPassPreStageInNor(stageId) then
		result = GameEnum.ResultCode.NotPassLast
		tips = "未通关前置试炼关卡"
	elseif not mo:isEnoughTimesInNor() then
		result = GameEnum.ResultCode.Error
		tips = "今日可挑战次数不足"
	end

	return result, tips
end

function DivineJieShenDrawView:_getTryEnterResultAndTips(activityId, trialMode)
	local result = GameEnum.ResultCode.Success
	local tips = ""
	local mo = self._divineJieShenMo
	local stageId = self._stageId

	if not DivineJieShenController.instance:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间范围内"
	elseif mo:isPassBossInNor() then
		result = GameEnum.ResultCode.IsPass
		tips = "已通关"
	elseif mo:isPassedStageInNor(stageId) then
		result = GameEnum.ResultCode.IsPass
		tips = "已通关"
	elseif not mo:isPassPreStageInNor(stageId) then
		result = GameEnum.ResultCode.NotPassLast
		tips = "未通关前置试炼关卡"
	elseif not mo:isEnoughTimesInNor() then
		result = GameEnum.ResultCode.Error
		tips = "今日可挑战次数不足"
	elseif trialMode ~= mo:getCurStageTrialId() then
		result = GameEnum.ResultCode.NotPassLast
		tips = "非抽选试炼无法进行挑战"
	end

	return result, tips
end

function DivineJieShenDrawView:_onClickBtnEnter()
	local trialMode = self._curStageTrialId
	local result, tips = self:_getTryEnterResultAndTips(self._activityId, trialMode)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	self:_doTrail(trialMode)
end

function DivineJieShenDrawView:_onClickBtnDraw()
	local result, tips = self:_getTryDrawResultAndTips(self._activityId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	local drawTimes = self._divineJieShenMo:getDrawTimesInNor()
	local cost = self._divineJieShenMo:getCurDrawCostInNor()

	local function successFunc()
		DivineJieShenController.instance:sendPM_DivineJieShenClgNormalRandomTrialReq(self._activityId, self._stageId, drawTimes)
	end

	if drawTimes <= 0 then
		successFunc()
	elseif not string.nilorempty(cost) then
		local matType, matId, matNum = MaterialMgr.getMatParams(cost)
		local matName = MaterialMgr.getMaterialsName(matType, matId)
		local tipsContent = string.format("是否消耗 %s x %s 再次抽取？", matName, matNum)

		local function okFunc()
			successFunc()
		end

		local function cencelFunc()
			return
		end

		TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, cencelFunc, "确定", "取消")
	else
		successFunc()
	end
end

return DivineJieShenDrawView
