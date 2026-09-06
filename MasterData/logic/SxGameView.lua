-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sxgame/view/SxGameView.lua

module("logic.extensions.sxgame.view.SxGameView", package.seeall)

local SxGameView = class("SxGameView", ViewComponent)

function SxGameView:ctor()
	SxGameView.super.ctor(self)

	self._x_space = 80
	self._y_space = 80
	self._cellPools = {}
end

function SxGameView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
	GameUtil.asBtn(self._btnHelp):AddClickListener(self.onHelpClick, self)
	self._customInput:AddListener(self._onCustomInputCallback, self)
end

function SxGameView:unbindEvents()
	self._closeButton:RemoveClickListener()
	GameUtil.asBtn(self._btnHelp):RemoveClickListener()
	self._customInput:RemoveListener()
end

function SxGameView:addGlobalEvent()
	GlobalDispatcher:addListener(GlobalNotify.SwapView, self._swapCell, self)
	GlobalDispatcher:addListener(GlobalNotify.RemoveCell, self._removeCell, self)
	GlobalDispatcher:addListener(GlobalNotify.NextStep, self._nextStep, self)
	GlobalDispatcher:addListener(GlobalNotify.StepOver, self._checkGameOverByStep, self)
	GlobalDispatcher:addListener(GlobalNotify.Combo, self._onCombo, self)
	GlobalDispatcher:addListener(GlobalNotify.SxCellSel, self._onSxCellSel, self)
	GlobalDispatcher:addListener(GlobalNotify.SxCellDeSel, self._onSxCellDeSel, self)
end

function SxGameView:rmGlobalEvent()
	GlobalDispatcher:removeListener(GlobalNotify.SwapView, self._swapCell, self)
	GlobalDispatcher:removeListener(GlobalNotify.RemoveCell, self._removeCell, self)
	GlobalDispatcher:removeListener(GlobalNotify.NextStep, self._nextStep, self)
	GlobalDispatcher:removeListener(GlobalNotify.StepOver, self._checkGameOverByStep, self)
	GlobalDispatcher:removeListener(GlobalNotify.Combo, self._onCombo, self)
	GlobalDispatcher:removeListener(GlobalNotify.SxCellSel, self._onSxCellSel, self)
	GlobalDispatcher:removeListener(GlobalNotify.SxCellDeSel, self._onSxCellDeSel, self)
end

function SxGameView:buildUI()
	self._closeButton = self:getBtn("close")
	self._container = self:getGo("Container")
	self._freeContainer = self:getGo("FreeContainer")
	self._btnHelp = self:getGo("btnHelp")
	self._tips = self:getGo("Tips")
	self._txtTips = goutil.findChildTextComponent(self.mainGO, "Tips/txt")
	self._customInput = UICustomInput.Get(self._tips)
	self._Txt_Step = self:getGo("Txt_Step"):GetComponent(typeof(UnityEngine.UI.Text))
	self.txtScore = self:getTxt("txtScore/txt")
	self.txtNumGo = self:getGo("txtNum")
	self.txtNum = self:getTxt("txtNum/txt")
	self.con = self:getGo("con")
	self._Txt_Wonerful = self:getGo("Txt_Wonerful")
	self.ExtTime = self:getGo("Panel/ExtTime")

	GameUtil.SetActive(self.ExtTime, false)
end

function SxGameView:destroyUI()
	return
end

function SxGameView:onEnter()
	SxGameModel.instance:getMoveRes()
	SxGameController.instance:defaultState()

	local params = self:getOpenParam() or {}

	self._info = params[1] or {}
	self._finishCallBack = self._info.finishCallBack

	SxGameModel.instance:initGameMapArr()

	self._cellArr = SxGameModel.instance:getGameMapArr()

	SxGameModel.instance:removeAction()

	self._cells = {}

	self:_initCells()
	GameUtil.SetActive(self.ExtTime, false)
	self:_refreshGift()

	self._Txt_Step.text = tostring(SxGameModel.instance:getCurStep())

	self:addGlobalEvent()

	local cfg = MiniGameCollectionConfig.instance:getBaseCfgById(GameEnum.MiniGame.SXGame)
	local ratioParams = string.split(cfg.prizeRatio, ":")

	self._txtTips.text = string.format("每消除1个宝石，都可得1分，每%s分可获得%s个金币，每局最多可获得%s个金币。", ratioParams[1], ratioParams[2], MiniGameCollectionConfig.instance:getCoinCount(GameEnum.MiniGame.SXGame, cfg.maxScore))
end

function SxGameView:onEnterFinished()
	return
end

function SxGameView:onExit()
	self:rmGlobalEvent()
end

function SxGameView:onExitFinished()
	local size = SxGameModel.instance:getGameMapSize()

	for i = 1, size.y do
		for j = 1, size.x do
			local cell = self._cells[i][j]

			if cell then
				cell:onDestroy()
			end

			self._cells[i][j] = nil
		end
	end

	for k, v in pairs(self._cellPools) do
		v:clear()
	end

	self._cellPools = {}
	self._cells = nil

	SxGameController.instance:defaultState()
	SxGameModel.instance:reset()
	SxGameModel.instance:getMoveRes()
end

function SxGameView:_onCustomInputCallback()
	GameUtil.SetActive(self._tips, false)
end

function SxGameView:onHelpClick()
	GameUtil.SetActive(self._tips, true)
end

function SxGameView:_onClickClose()
	if SxGameController.instance:isCanDoAction() then
		self:_popSxGameResult()
	else
		TipsFacade.instance:openCommonTips(lang("请在计算得分后进行操作"))
	end
end

function SxGameView:_popSxGameResult()
	UIStateManager.instance:push(ViewName.SxGameResultView, self._finishCallBack)
end

function SxGameView:_onResourceLoaded()
	self:_initCells()
end

function SxGameView:_disposeFunc(obj)
	local sxGameCell = Framework.LuaComponentContainer.Get(obj.gameObject, SxGameCell)

	sxGameCell:onDestroy()
end

function SxGameView:_resetFunc(obj)
	goutil.addChildToParent(obj.gameObject, self._freeContainer.gameObject.transform)
end

function SxGameView:_initCells()
	local size = SxGameModel.instance:getGameMapSize()

	for i = 1, size.y do
		for j = 1, size.x do
			local _cellType = self._cellArr[i][j]._type
			local cellObj, sxGameCell = self:genarateCell(_cellType, self._cellArr[i][j]:getCellRes(), self._cellArr[i][j])

			cellObj.transform.localPosition = Vector3.New(self._y_space * (j - 1), self._x_space * (i - 1))
			self._cells[i] = self._cells[i] or {}
			self._cells[i][j] = sxGameCell
		end
	end
end

function SxGameView:genarateCell(type, rssPath, cellDat)
	function resetFunc(obj)
		self:_resetFunc(obj)
	end

	function disposeFunc(obj)
		self:_disposeFunc(obj)
	end

	self._cellPools[type] = self._cellPools[type] or ObjectPool.New(5, nil, disposeFunc, resetFunc)

	local cellObj

	if self._cellPools[type] then
		cellObj = self._cellPools[type]:fetchObject()
	end

	local sxGameCell

	if not cellObj then
		cellObj = self:getResInstance(rssPath)

		if cellObj then
			goutil.addChildToParent(cellObj, self._container.gameObject.transform)

			sxGameCell = Framework.LuaComponentContainer.Add(cellObj, SxGameCell)

			sxGameCell:initCell(cellDat)
		end
	else
		goutil.addChildToParent(cellObj.gameObject, self._container.gameObject.transform)

		sxGameCell = Framework.LuaComponentContainer.Get(cellObj.gameObject, SxGameCell)

		sxGameCell:resetCell(cellDat)
	end

	return cellObj, sxGameCell
end

function SxGameView:_swapCell(back)
	local actions = SxGameModel.instance:getActions()

	if actions == nil or actions:IsEmpty() then
		return
	end

	local mo0 = actions:Get(0)
	local mo1 = actions:Get(1)

	if mo0 == nil then
		print(" tetssss ")
	end

	local preCell = self._cells[mo0._y][mo0._x]
	local afterCell = self._cells[mo1._y][mo1._x]
	local count = 0

	function swapActionFinish()
		count = count + 1

		if count == 2 then
			count = 0
			self._cells[mo0._y][mo0._x] = afterCell
			self._cells[mo1._y][mo1._x] = preCell

			local tempType = self._cellArr[mo0._y][mo0._x]._type

			SxGameModel.instance:setCellData(self._cellArr[mo0._y][mo0._x]._x, self._cellArr[mo0._y][mo0._x]._y, self._cellArr[mo1._y][mo1._x]._type)
			SxGameModel.instance:setCellData(self._cellArr[mo1._y][mo1._x]._x, self._cellArr[mo1._y][mo1._x]._y, tempType)
			self._cells[mo0._y][mo0._x]:resetCell(self._cellArr[mo0._y][mo0._x])
			self._cells[mo1._y][mo1._x]:resetCell(self._cellArr[mo1._y][mo1._x])

			if not back then
				SxGameController.instance:findScore()
			else
				SxGameModel.instance:removeAction()
				SxGameController.instance:defaultState()
			end
		end
	end

	preCell:onChangePos(mo1._x, mo1._y, swapActionFinish)
	afterCell:onChangePos(mo0._x, mo0._y, swapActionFinish)
end

function SxGameView:_removeCell()
	local _removeCellCount = 0

	local function removeFunc(cell)
		if self._cellPools[cell:getType()] then
			self._cellPools[cell:getType()]:returnObject(cell:getObj())
		end

		_removeCellCount = _removeCellCount - 1

		if _removeCellCount == 0 then
			settimer(0.4, self._fallDown, self, false)
		end
	end

	local operates = SxGameModel.instance:getOperate()

	operates:ForEach(function(operateMo, index)
		_removeCellCount = _removeCellCount + 1

		local cell = self._cells[operateMo._operatePos.y][operateMo._operatePos.x]

		cell:onRemove(removeFunc)

		if operateMo._special_effect then
			self:_onSpecialEffect(operateMo, function()
				return
			end)
		else
			self:_onNormalEffect(cell._container.gameObject)
		end
	end)
end

function SxGameView:_fallDown()
	SxGameModel.instance:removeAction()
	SxGameModel.instance:removeCellData()
	self:_checkSpecial()

	local size = SxGameModel.instance:getGameMapSize()

	for i = 1, size.x do
		self:_checkCellFallDown(i)
	end

	for i = 1, size.x do
		self:_checkSupplyCell(i)
	end

	self:_refreshGift()
end

function SxGameView:_checkSpecial()
	local spArr = SxGameModel.instance:getSpecial()

	if spArr:GetSize() == 0 then
		return nil
	end

	for i = 1, spArr:GetSize() do
		local spCellData = spArr:PopFront()
		local _cellType = spCellData._type
		local cellObj, sxGameCell = self:genarateCell(_cellType, spCellData:getCellRes(), self._cellArr[spCellData._y][spCellData._x])

		cellObj.transform.localPosition = Vector3.New(self._x_space * (spCellData._x - 1), self._y_space * (spCellData._y - 1))
		self._cells[spCellData._y][spCellData._x] = sxGameCell
	end
end

function SxGameView:_checkCellFallDown(i)
	local size = SxGameModel.instance:getGameMapSize()
	local from_y, count = -1, 0

	for j = 1, size.y do
		if self._cellArr[j][i]._type == -1 then
			if from_y == -1 then
				count = 0
				from_y = j
			end

			count = count + 1
		elseif from_y ~= -1 then
			self._cells[j][i]:onChangePos(i, j - count)

			self._cells[j - count][i] = self._cells[j][i]

			SxGameModel.instance:setCellData(i, j - count, self._cells[j - count][i]:getType())

			self._cells[j - count][i]._cellData = self._cellArr[j - count][i]

			SxGameModel.instance:setCellData(i, j, -1)

			return self:_checkCellFallDown(i)
		end
	end
end

function SxGameView:_checkSupplyCell(i)
	local size = SxGameModel.instance:getGameMapSize()
	local from_y, count = -1, 0

	for j = 1, size.y do
		if self._cellArr[j][i]._type == -1 then
			if from_y == -1 then
				count = 0
				from_y = j
			end

			count = count + 1

			if j == size.y then
				self:_supplyCell(i, from_y, count)
			end
		end
	end

	settimer(0.2, self._checkContinue, self, false)
end

function SxGameView:_supplyCell(x, from_y, num)
	local function onMoveCallBack()
		return
	end

	for i = 1, num do
		local supplyType = SxGameModel.instance:getSupplyCellType()
		local addType = SxGameModel.instance:getSupplyCellAddType(supplyType)

		SxGameModel.instance:setCellData(x, from_y + i - 1, supplyType, addType)

		local _cellType = self._cellArr[from_y + i - 1][x]._type
		local cellObj, sxGameCell = self:genarateCell(_cellType, self._cellArr[from_y + i - 1][x]:getCellRes(), self._cellArr[from_y + i - 1][x])

		cellObj.transform.localPosition = Vector3.New(self._x_space * (x - 1), self._y_space * (7 + i))

		sxGameCell:onBuildAction(onMoveCallBack)

		self._cells[from_y + i - 1][x] = sxGameCell
	end
end

function SxGameView:_refreshGift()
	local count = self:_calcScore()

	self.txtScore.text = count

	local mat = MiniGameCollectionConfig.instance:getParamValueByKey("GAME_PRIZE")
	local max = MiniGameCollectionConfig.instance:getCoinCount(GameEnum.MiniGame.SXGame, count)

	MaterialMgr.updateItemByStr(self.con, mat)

	self.txtNum.text = "" .. max
end

function SxGameView:_calcScore()
	return SxGameModel.instance:calcScore()
end

function SxGameView:_checkContinue()
	SxGameController.instance:continueFindScore()
end

function SxGameView:_nextStep()
	SxGameModel.instance:reduceStep()

	self._Txt_Step.text = tostring(SxGameModel.instance:getCurStep())
end

function SxGameView:_onNormalEffect(cellGo, callback)
	local effName = "fx_ui_sanxiao/fx_ui_sanxiao_xiaochu.prefab"

	UIEffectManager.instance:playEffect(self, effName, cellGo, 0, 0, false, false, nil, callback)
end

function SxGameView:_onSpecialEffect(operateMo, callback)
	if operateMo then
		local _pos = operateMo._operatePos
		local _cellGo = self._cells[_pos.y][_pos.x]._container.gameObject
		local effName = "fx_ui_sanxiao/fx_ui_sanxiao_xiaochu.prefab"
		local offset_x = 0
		local offset_y = 0

		if operateMo._special_type == SxGameCellType.Flash then
			effName = "fx_ui_sanxiao/fx_ui_sanxiao_shandian.prefab"
			offset_x = (4 - _pos.x) * 80 + 40
		elseif operateMo._special_type == SxGameCellType.Bloom then
			effName = "fx_ui_sanxiao/fx_ui_sanxiao_zhadan.prefab"
		elseif operateMo._special_type == SxGameCellType.FlashShu then
			effName = "fx_ui_sanxiao/fx_ui_sanxiao_shandian_shu.prefab"
			offset_y = (4 - _pos.y) * 80 + 40
		end

		self._spEff = UIEffectManager.instance:playEffect(self, effName, _cellGo, offset_x, offset_y, false, false, nil, callback)
	end
end

function SxGameView:_checkGameOverByStep()
	if SxGameModel.instance:getCurStep() == 0 then
		local cell = SxGameModel.instance:getSpecialCell()

		if cell == nil then
			GameUtil.SetActive(self.ExtTime, false)
			self:_popSxGameResult()
		else
			GameUtil.SetActive(self.ExtTime, true)
			SxGameController.instance:addAction(cell)
		end
	else
		printInfo("没获取到对象")
	end
end

function SxGameView:_onCombo()
	local cellObj = self:getResInstance("effect/prefabs/ui/fx_ui_sanxiao/fx_ui_sanxiao_combo.prefab")

	if cellObj then
		local sxGameCombo = Framework.LuaComponentContainer.Add(cellObj, SxGameCombo)

		sxGameCombo:setCombo(SxGameModel.instance:getCombo())
	end

	if SxGameModel.instance:getCombo() == 5 then
		local cellObj = self:getResInstance("effect/prefabs/ui/fx_ui_sanxiao/fx_ui_sanxiao_amazing.prefab")

		if cellObj then
			local sxGameCombo = Framework.LuaComponentContainer.Add(cellObj, SxGameAmazing)
		end
	end
end

function SxGameView:testCell()
	for i = 1, 8 do
		local str = " "

		for j = 1, 8 do
			str = str .. " " .. self._cells[i][j]._cellData._type

			printInfo("x:" .. self._cells[i][j]._cellData._x .. ",y:" .. self._cells[i][j]._cellData._y)
		end
	end
end

function SxGameView:_onSxCellSel()
	local actions = SxGameModel.instance:getActions()

	actions:ForEach(function(action, index)
		if action then
			local _cell = self._cells[action._y][action._x]

			if _cell then
				_cell:addSelEffect()
			end
		end
	end)
end

function SxGameView:_onSxCellDeSel(x, y)
	local _cell = self._cells[y][x]

	if _cell then
		_cell:removeSelEffect()
	end
end

return SxGameView
