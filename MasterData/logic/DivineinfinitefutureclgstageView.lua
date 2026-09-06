-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineinfinitefutureclg/view/DivineinfinitefutureclgstageView.lua

module("logic.extensions.divineinfinitefutureclg.view.DivineinfinitefutureclgstageView", package.seeall)

local DivineinfinitefutureclgstageView = class("DivineinfinitefutureclgstageView", ViewComponent)

function DivineinfinitefutureclgstageView:ctor()
	DivineinfinitefutureclgstageView.super.ctor(self)

	self._curStageId = 0
end

function DivineinfinitefutureclgstageView:unbindEvents()
	DivineinfinitefutureclgstageView.super.unbindEvents(self)
	self._btnSure:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
end

function DivineinfinitefutureclgstageView:bindEvents()
	DivineinfinitefutureclgstageView.super.bindEvents(self)
	self._btnSure:AddClickListener(self._onClickbtnSure, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnTip:AddClickListener(self._onClickbtnTip, self)
end

function DivineinfinitefutureclgstageView:buildUI()
	DivineinfinitefutureclgstageView.super.buildUI(self)

	self._btnSure = self:getBtn("btnSure")
	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._txt_clone2 = self:getTxt("txt_clone2")
	self._itemcon = self:getGo("itemcon")
	self._itemconGo = self._itemcon
	self._tableviewGo = self:getGo("tableview")
	self._tablecellGo = self:getGo("tablecell")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._txtDesc = self:getTxt("txtDesc")

	self:_buildCells()
end

function DivineinfinitefutureclgstageView:_buildCells()
	local cellsGo = self:getGo("formation/cells")

	self._cellGos = {}

	for i = 1, 9 do
		local go = goutil.findChild(cellsGo, "cell_" .. i)

		table.insert(self._cellGos, go)
	end
end

function DivineinfinitefutureclgstageView:onExit()
	DivineinfinitefutureclgstageView.super.onExit(self)
	self._scrollerList:dispose()
	MaterialMgr.resetAll(self._itemconGo)
end

function DivineinfinitefutureclgstageView:onEnter()
	DivineinfinitefutureclgstageView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.DivineInfiniteFutureClgValidRes, self._onDivineInfiniteFutureClgValidRes, self)
	self.addGEvent(self, GlobalNotify.DivineInfiniteFutureClgConfirmRes, self._updateUI, self)

	self._activityId = self:getFirstParam()
	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)
	self._info = DivineinfinitefutureclgModel.instance:getInfo(self._activityId)

	self:_calGrid2ValueKv()

	self._stageCfgs = DivineinfinitefutureclgConfig.instance:getStageCfgs(self._activityId)
	self._curPassStageId = self._info.curPassStageId

	if self._curStageId <= 0 then
		self._curStageId = self._curPassStageId + 1
	end

	self:_updateUI()
	self:_initAoqiGodUI()
end

function DivineinfinitefutureclgstageView:_initAoqiGodUI()
	local showPrize = not self._isAoqiGodProcessType

	GameUtil.SetActive(self._txt_clone2.gameObject, showPrize)
	GameUtil.SetActive(self._itemcon, showPrize)
end

function DivineinfinitefutureclgstageView:_onClickbtnSure()
	if not DivineinfinitefutureclgController.instance:checkPassAoqiGodProcessResult(self._activityId) then
		return
	end

	local nextStageId = self._curPassStageId + 1
	local nextGridCfgs = DivineinfinitefutureclgConfig.instance:getGridCfgs(self._activityId, nextStageId)

	if not nextGridCfgs then
		FloatWordMgr.instance:show("您已通关")

		return
	end

	if not DivineinfinitefutureclgController.instance:checkIsInOpenTime(self._activityId) then
		local actCfg = DivineinfinitefutureclgConfig.instance:getActCfg(self._activityId)

		FloatWordMgr.instance:show(string.format("挑战在%s开启", actCfg.openTime))

		return
	end

	local gridCfgs = DivineinfinitefutureclgConfig.instance:getGridCfgs(self._activityId, self._curStageId)
	local isPass = true

	for i, v in ipairs(gridCfgs) do
		if v.gridType == 2 and not self._gridId2Value_kv[v.gridId] then
			isPass = false

			break
		end
	end

	if isPass then
		if self:_verifyStage(nextStageId) then
			DivineInfiniteFutureClgAgent.instance:sendPM_DivineInfiniteFutureClgValidReq(self._activityId)
		else
			FloatWordMgr.instance:show("请详细阅读关卡填数规则后再试")
		end
	else
		FloatWordMgr.instance:show("所有格子内必须填满数字")
	end
end

function DivineinfinitefutureclgstageView:_onClickbtnClose()
	self:close()
end

function DivineinfinitefutureclgstageView:_onClickbtnTip()
	local challengeCfg = DivineinfinitefutureclgController.instance:getChallengeCfg()

	TipsFacade.instance:openRulesView(challengeCfg.ruleKey)
end

function DivineinfinitefutureclgstageView:_updateUI()
	self:_updateGrids()
	self._scrollerList:reloadData(self._stageCfgs)

	local stageCfg = DivineinfinitefutureclgConfig.instance:getStageCfg(self._activityId, self._curStageId)

	self._txtDesc.text = stageCfg.desc

	MaterialMgr.setCellByCfg(stageCfg.passPrize, self._itemconGo)
	self:_initAoqiGodUI()
end

function DivineinfinitefutureclgstageView:_updateCell(view, cell, cfg, tag)
	local btn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")
	local goLock = goutil.findChild(cell.gameObject, "lock")
	local txtStage = goutil.findChildTextComponent(cell.gameObject, "txtStage")
	local isLock = cfg.stageId > self._curPassStageId + 1
	local isPass = cfg.stageId <= self._curPassStageId

	goutil.setActive(goLock, isLock)

	txtStage.text = string.format("第%s关", cfg.stageId)

	GameUtil.SetGray(cell.gameObject, isPass)
	btn:AddClickListener(function()
		if isPass then
			FloatWordMgr.instance:show("您已通关")

			return
		end

		if isLock then
			FloatWordMgr.instance:show("先通关前面关卡")

			return
		end

		self:_onClickStage(cfg.stageId)
	end)
end

function DivineinfinitefutureclgstageView:_clearCell(cell)
	return
end

function DivineinfinitefutureclgstageView:_onClickStage(stageId)
	self._curStageId = stageId

	self._scrollerList:refresh()
	self:_updateGrids()
end

function DivineinfinitefutureclgstageView:_onDivineInfiniteFutureClgValidRes()
	self._curPassStageId = self._info.curPassStageId

	local nextStageId = self._curPassStageId + 1
	local nextGridCfgs = DivineinfinitefutureclgConfig.instance:getGridCfgs(self._activityId, nextStageId)

	if nextGridCfgs then
		self._curStageId = self._curPassStageId + 1
	elseif not self._isAoqiGodProcessType then
		self:close()

		return
	else
		AoqiGodController.instance:doHandleChallengeFinishReady(DivineinfinitefutureclgController.instance:getActivityType(), self._activityId)
		UIStateManager.instance:popByName(ViewName.DivineinfinitefutureclgmainView)
		self:close()
	end

	self:_calGrid2ValueKv()
	self:_updateUI()
end

function DivineinfinitefutureclgstageView:_updateGrids()
	local gridCfgs = DivineinfinitefutureclgConfig.instance:getGridCfgs(self._activityId, self._curStageId)

	for i, go in ipairs(self._cellGos) do
		local gridCfg = gridCfgs[i]

		self:_updateGrid(go, gridCfg)
	end
end

function DivineinfinitefutureclgstageView:_updateGrid(cell, gridCfg)
	local goImgEnter = goutil.findChild(cell.gameObject, "imgEnter")
	local goStatic = goutil.findChild(cell.gameObject, "static")
	local txtPass = goutil.findChildTextComponent(cell.gameObject, "txtPass")
	local txtStatic = goutil.findChildTextComponent(cell.gameObject, "static/txtStatic")
	local btn = Framework.ButtonAdapter.Get(cell)
	local isPass = self._gridId2Value_kv[gridCfg.gridId]
	local isClg = gridCfg.gridType == 2
	local isStatic = gridCfg.gridType == 1

	goutil.setActive(goImgEnter, isClg and not isPass)
	goutil.setActive(goStatic, isStatic)

	txtStatic.text = ""
	txtPass.text = ""

	if isStatic then
		txtStatic.text = gridCfg.gridParam
	elseif isPass then
		txtPass.text = self._gridId2Value_kv[gridCfg.gridId]
	end

	btn:AddClickListener(function()
		if self._curPassStageId >= self._curStageId then
			FloatWordMgr.instance:show("您已通关")

			return
		end

		if isStatic then
			FloatWordMgr.instance:show("请点击有编辑按钮的格子")

			return
		end

		if not DivineinfinitefutureclgController.instance:checkPassAoqiGodProcessResult(self._activityId) then
			return
		end

		local fmtMo = DivineinfinitefutureclgModel.instance:getFmtMo()

		fmtMo:initParams(self._activityId, gridCfg.gridId, checknumber(gridCfg.gridParam))
		CustomFmtController.instance:showMissionView(fmtMo)
	end)
end

function DivineinfinitefutureclgstageView:_calGrid2ValueKv()
	self._gridId2Value = self._info.gridId2Value
	self._gridId2Value_kv = {}

	for i, v in ipairs(self._gridId2Value) do
		self._gridId2Value_kv[v.left] = v.right
	end
end

function DivineinfinitefutureclgstageView:_verifyStage(stageId)
	local stageCfg = DivineinfinitefutureclgConfig.instance:getStageCfg(self._activityId, stageId)
	local gridCfgs = DivineinfinitefutureclgConfig.instance:getGridCfgs(self._activityId, self._curStageId)
	local valueList = {}

	for i, v in ipairs(gridCfgs) do
		if v.gridType == 2 then
			valueList[v.gridId] = self._gridId2Value_kv[v.gridId]
		elseif v.gridType == 1 then
			valueList[v.gridId] = v.gridParam
		end
	end

	if stageCfg.validatorType == "RowSumEqual" then
		return self:_areRowsEqual(valueList, stageCfg.rowColumnGridCount)
	elseif stageCfg.validatorType == "AllNumbersNXDirectSumEqual" then
		return self:_isMagicSquare(valueList, stageCfg.rowColumnGridCount)
	elseif stageCfg.validatorType == "AllNumbers" then
		return self:_areAllNumbersUnique(valueList)
	end
end

function DivineinfinitefutureclgstageView:_areRowsEqual(arr, n)
	if #arr % n ~= 0 then
		return false
	end

	local numRows = #arr / n
	local targetSum

	for i = 0, numRows - 1 do
		local rowSum = 0

		for j = 1, n do
			rowSum = rowSum + arr[i * n + j]
		end

		if targetSum == nil then
			targetSum = rowSum
		elseif rowSum ~= targetSum then
			return false
		end
	end

	return true
end

function DivineinfinitefutureclgstageView:_isMagicSquare(arr, n)
	if #arr ~= n * n then
		return false
	end

	if not self:_areAllNumbersUnique(arr) then
		return false
	end

	local sums = {}

	for i = 0, n - 1 do
		local rowSum = 0

		for j = 1, n do
			rowSum = rowSum + arr[i * n + j]
		end

		table.insert(sums, rowSum)
	end

	for i = 1, n do
		local colSum = 0

		for j = 0, n - 1 do
			colSum = colSum + arr[i + j * n]
		end

		table.insert(sums, colSum)
	end

	local diag1Sum = 0

	for i = 0, n - 1 do
		diag1Sum = diag1Sum + arr[i * n + i + 1]
	end

	table.insert(sums, diag1Sum)

	local diag2Sum = 0

	for i = 0, n - 1 do
		diag2Sum = diag2Sum + arr[i * n + (n - i)]
	end

	table.insert(sums, diag2Sum)

	for i = 2, #sums do
		if sums[i] ~= sums[1] then
			return false
		end
	end

	return true
end

function DivineinfinitefutureclgstageView:_areAllNumbersUnique(arr)
	local seen = {}

	for _, num in ipairs(arr) do
		if seen[num] then
			return false
		end

		seen[num] = true
	end

	return true
end

function DivineinfinitefutureclgstageView:_tryDoHandleChallengeFinishReady()
	AoqiGodController.instance:doHandleChallengeFinishReady(DivineinfinitefutureclgController.instance:getActivityType(), self._activityId)
end

return DivineinfinitefutureclgstageView
