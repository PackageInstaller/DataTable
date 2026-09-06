-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sxgame/view/SxGameNewView.lua

module("logic.extensions.sxgame.view.SxGameNewView", package.seeall)

local SxGameNewView = class("SxGameNewView", ViewComponent)

function SxGameNewView:ctor()
	SxGameNewView.super.ctor(self)

	self._x_space = 80
	self._y_space = 80
	self._cellPools = {}
end

function SxGameNewView:bindEvents()
	return
end

function SxGameNewView:unbindEvents()
	return
end

function SxGameNewView:addGlobalEvent()
	GlobalDispatcher:addListener(GlobalNotify.SwapView, self._swapCell, self)
	GlobalDispatcher:addListener(GlobalNotify.RemoveCell, self._removeCell, self)
	GlobalDispatcher:addListener(GlobalNotify.NextStep, self._nextStep, self)
	GlobalDispatcher:addListener(GlobalNotify.StepOver, self._checkGameOverByStep, self)
	GlobalDispatcher:addListener(GlobalNotify.Combo, self._onCombo, self)
	GlobalDispatcher:addListener(GlobalNotify.SxCellSel, self._onSxCellSel, self)
	GlobalDispatcher:addListener(GlobalNotify.SxCellDeSel, self._onSxCellDeSel, self)
	GlobalDispatcher:addListener(GlobalNotify.ThreeMathesGetInfo, self._PM_ThreeMatchesGameInfoRes, self)
end

function SxGameNewView:rmGlobalEvent()
	GlobalDispatcher:removeListener(GlobalNotify.SwapView, self._swapCell, self)
	GlobalDispatcher:removeListener(GlobalNotify.RemoveCell, self._removeCell, self)
	GlobalDispatcher:removeListener(GlobalNotify.NextStep, self._nextStep, self)
	GlobalDispatcher:removeListener(GlobalNotify.StepOver, self._checkGameOverByStep, self)
	GlobalDispatcher:removeListener(GlobalNotify.Combo, self._onCombo, self)
	GlobalDispatcher:removeListener(GlobalNotify.SxCellSel, self._onSxCellSel, self)
	GlobalDispatcher:removeListener(GlobalNotify.SxCellDeSel, self._onSxCellDeSel, self)
	GlobalDispatcher:removeListener(GlobalNotify.ThreeMathesGetInfo, self._PM_ThreeMatchesGameInfoRes, self)
end

function SxGameNewView:buildUI()
	self._container = self:getGo("Container")
	self._freeContainer = self:getGo("FreeContainer")
end

function SxGameNewView:destroyUI()
	return
end

function SxGameNewView:onEnter()
	SxGameModel.instance:getMoveRes()
	SxGameController.instance:defaultState()
	self:addGlobalEvent()

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._stageId = params[2]

	ThreeMatchesGameController.instance:sendPM_ThreeMatchesGameInfoReq(self._activityId, self._stageId)
end

function SxGameNewView:onEnterFinished()
	return
end

function SxGameNewView:onExit()
	self:rmGlobalEvent()
	removetimer(self._fallDown, self)
	removetimer(self._checkContinue, self)
	removetimer(self._waitOffsetDown, self)
end

function SxGameNewView:onExitFinished()
	local size = SxGameModel.instance:getGameMapSize()

	for i = 1, size.y do
		for j = 1, size.x do
			if self._cells and self._cells[i] then
				local cell = self._cells[i][j]

				if cell then
					cell:onDestroy()
				end

				self._cells[i][j] = nil
			end
		end
	end

	for k, v in pairs(self._cellPools or {}) do
		v:clear()
	end

	self._cellPools = {}
	self._cells = nil

	SxGameController.instance:defaultState()
	SxGameModel.instance:reset()
end

function SxGameNewView:_initView()
	return
end

function SxGameNewView:_onCustomInputCallback()
	GameUtil.SetActive(self._tips, false)
end

function SxGameNewView:onHelpClick()
	GameUtil.SetActive(self._tips, true)
end

function SxGameNewView:_onClickClose()
	if SxGameController.instance:isCanDoAction() then
		self._Pnl_Result.gameObject:SetActive(true)

		local sxGameResultView = Framework.LuaComponentContainer.Get(self._Pnl_Result.gameObject, SxGameResultView)

		sxGameResultView:showResultView()
	else
		TipsFacade.instance:openCommonTips(lang("请在计算得分后进行操作"))
	end
end

function SxGameNewView:_onResourceLoaded()
	self:_initCells()
end

function SxGameNewView:_disposeFunc(obj)
	local sxGameCell = Framework.LuaComponentContainer.Get(obj.gameObject, SxGameCell)

	sxGameCell:onDestroy()
end

function SxGameNewView:_resetFunc(obj)
	goutil.addChildToParent(obj.gameObject, self._freeContainer.gameObject.transform)
end

function SxGameNewView:_initCells()
	local size = SxGameModel.instance:getGameMapSize()

	for i = 1, size.y do
		for j = 1, size.x do
			local mo = self._cellArr[i][j]
			local _cellType = mo._type
			local cellObj, sxGameCell = self:genarateCell(_cellType, self:_getCellResPath(mo), mo)

			cellObj.transform.localPosition = Vector3.New(self._y_space * (j - 1), self._x_space * (i - 1))
			self._cells[i] = self._cells[i] or {}
			self._cells[i][j] = sxGameCell
		end
	end
end

function SxGameNewView:_getCellResPath(sxGameCellMO)
	return sxGameCellMO:getCellRes()
end

function SxGameNewView:genarateCell(type, rssPath, cellDat)
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

function SxGameNewView:_removeAllCell()
	local size = SxGameModel.instance:getGameMapSize()

	for i = 1, size.y do
		if not self._cells then
			break
		end

		for j = 1, size.x do
			if not self._cells[i] then
				break
			end

			local cell = self._cells[i][j]

			if cell then
				cell:onDestroy()
			end

			self._cells[i][j] = nil
		end
	end
end

function SxGameNewView:_swapCell(back)
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
			local tempAddType = self._cellArr[mo0._y][mo0._x]._addType

			SxGameModel.instance:setCellData(self._cellArr[mo0._y][mo0._x]._x, self._cellArr[mo0._y][mo0._x]._y, self._cellArr[mo1._y][mo1._x]._type, self._cellArr[mo1._y][mo1._x]._addType)
			SxGameModel.instance:setCellData(self._cellArr[mo1._y][mo1._x]._x, self._cellArr[mo1._y][mo1._x]._y, tempType, tempAddType)
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

function SxGameNewView:_removeCell()
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

	SxGameModel.instance:clearAllIce()

	local resetCells = SxGameModel.instance:getNeedResetCell()

	resetCells:ForEach(function(cellMo, index)
		self._cells[cellMo._y][cellMo._x]:resetCell(self._cellArr[cellMo._y][cellMo._x])
	end)

	local operates = SxGameModel.instance:getOperate()

	if operates:IsEmpty() == true then
		settimer(0.4, self._fallDown, self, false)
	end

	operates:ForEach(function(operateMo, index)
		_removeCellCount = _removeCellCount + 1

		local cell = self._cells[operateMo._operatePos.y][operateMo._operatePos.x]

		cell:onRemove(removeFunc)

		if operateMo._special_effect then
			self:_onSpecialEffect(operateMo, function()
				return
			end)
		else
			self:_onNormalEffect(cell._container.gameObject, function()
				return
			end, operateMo._type)
		end
	end)
end

function SxGameNewView:_fallDown()
	SxGameModel.instance:removeAction()
	SxGameModel.instance:removeCellData()
	self:_checkSpecial()
	self:_waitFallDown()
end

function SxGameNewView:_waitFallDown()
	local size = SxGameModel.instance:getGameMapSize()

	for i = 1, size.x do
		self:_checkCellFallDown(i)
	end

	for i = 1, size.x do
		self:_checkSupplyCell(i)
	end

	settimer(0, self._waitOffsetDown, self, false)
end

function SxGameNewView:_waitOffsetDown()
	local size = SxGameModel.instance:getGameMapSize()
	local move = false

	for i = 1, size.x do
		if self:_checkCellOffsetDown(i) == true then
			move = true
		end
	end

	for i = 1, size.x do
		if self:_checkSupplyCell(i) == true then
			move = true
		end
	end

	if move == true then
		settimer(0, self._waitFallDown, self, false)
	else
		self:_fallDownFinish()
	end
end

function SxGameNewView:_fallDownFinish()
	settimer(0.4, self._checkContinue, self, false)
	self:_refreshGift()
end

function SxGameNewView:_checkSpecial()
	local spArr = SxGameModel.instance:getSpecial()

	if spArr:GetSize() == 0 then
		return nil
	end

	for i = 1, spArr:GetSize() do
		local spCellData = spArr:PopFront()
		local _cellType = spCellData._type
		local cellObj, sxGameCell = self:genarateCell(_cellType, self:_getCellResPath(spCellData), self._cellArr[spCellData._y][spCellData._x])

		cellObj.transform.localPosition = Vector3.New(self._x_space * (spCellData._x - 1), self._y_space * (spCellData._y - 1))
		self._cells[spCellData._y][spCellData._x] = sxGameCell
	end
end

function SxGameNewView:_checkCellFallDown(i)
	local size = SxGameModel.instance:getGameMapSize()
	local from_y, count = -1, 0

	for j = 1, size.y do
		if self._cellArr[j][i]._type == SxGameCellType.Empty then
			if from_y == -1 then
				count = 0
				from_y = j
			end

			count = count + 1
		elseif from_y ~= -1 then
			if SxGameModel:isStoodType(self._cells[j][i]:getType()) then
				count = 0
				from_y = -1
			else
				self._cells[j][i]:onChangePos(i, j - count)

				self._cells[j - count][i] = self._cells[j][i]

				SxGameModel.instance:setCellData(i, j - count, self._cells[j - count][i]:getType(), self._cells[j - count][i]:getAddType())

				self._cells[j - count][i]._cellData = self._cellArr[j - count][i]

				SxGameModel.instance:setCellData(i, j, SxGameCellType.Empty)
			end
		end
	end
end

function SxGameNewView:_checkCellOffsetDown(i)
	local size = SxGameModel.instance:getGameMapSize()
	local isMove = false

	for j = 1, size.y do
		local from_y, from_x, to_y, to_x = -1, -1, -1, -1

		if self._cellArr[j][i]._type == -1 and self._cellArr[j + 1] then
			if self._cellArr[j + 1][i - 1] and not SxGameModel.instance:isStoodType(self._cellArr[j + 1][i - 1]._type) and self._cellArr[j + 1][i - 1]._type ~= SxGameCellType.Empty then
				to_x = i
				to_y = j
				from_x = i - 1
				from_y = j + 1
			elseif self._cellArr[j + 1][i + 1] and not SxGameModel.instance:isStoodType(self._cellArr[j + 1][i + 1]._type) and self._cellArr[j + 1][i + 1]._type ~= SxGameCellType.Empty then
				to_x = i
				to_y = j
				from_x = i + 1
				from_y = j + 1
			elseif SxGameModel.instance:isStoodType(self._cellArr[j + 1][i + 1]._type) and SxGameModel.instance:isStoodType(self._cellArr[j + 1][i - 1]._type) then
				if self._cellArr[j][i - 1] and not SxGameModel.instance:isStoodType(self._cellArr[j][i - 1]._type) and self._cellArr[j][i - 1]._type ~= SxGameCellType.Empty then
					to_x = i
					to_y = j
					from_x = i - 1
					from_y = j
				elseif self._cellArr[j][i + 1] and not SxGameModel.instance:isStoodType(self._cellArr[j][i + 1]._type) and self._cellArr[j][i + 1]._type ~= SxGameCellType.Empty then
					to_x = i
					to_y = j
					from_x = i + 1
					from_y = j
				end
			end
		end

		if from_y > 0 and from_x > 0 and to_y > 0 and to_x > 0 then
			self._cells[from_y][from_x]:onChangePos(to_x, to_y)

			self._cells[to_y][to_x] = self._cells[from_y][from_x]

			SxGameModel.instance:setCellData(to_x, to_y, self._cells[to_y][to_x]:getType(), self._cells[to_y][to_x]:getAddType())

			self._cells[to_y][to_x]._cellData = self._cellArr[to_y][to_x]

			SxGameModel.instance:setCellData(from_x, from_y, SxGameCellType.Empty)

			isMove = true
		end
	end

	return isMove
end

function SxGameNewView:_checkSupplyCell(i)
	local size = SxGameModel.instance:getGameMapSize()
	local from_y, count = -1, 0
	local blockIdx = 0
	local isSupply = false

	for j = 1, size.y do
		if self._cellArr[j][i]._type == SxGameCellType.Block then
			blockIdx = j
		end
	end

	for j = blockIdx + 1, size.y do
		if self._cellArr[j][i]._type == -1 then
			if from_y == -1 then
				count = 0
				from_y = j
			end

			count = count + 1

			if j == size.y then
				self:_supplyCell(i, from_y, count)

				isSupply = true
			end
		end
	end

	return isSupply
end

function SxGameNewView:_supplyCell(x, from_y, num)
	local function onMoveCallBack()
		return
	end

	for i = 1, num do
		local supplyType = SxGameModel.instance:getSupplyCellType()
		local addType = SxGameModel.instance:getSupplyCellAddType(supplyType)

		SxGameModel.instance:setCellData(x, from_y + i - 1, supplyType, addType)

		local mo = self._cellArr[from_y + i - 1][x]
		local _cellType = mo._type
		local cellObj, sxGameCell = self:genarateCell(_cellType, self:_getCellResPath(mo), mo)

		cellObj.transform.localPosition = Vector3.New(self._x_space * (x - 1), self._y_space * (7 + i))

		sxGameCell:onBuildAction(onMoveCallBack)

		self._cells[from_y + i - 1][x] = sxGameCell
	end
end

function SxGameNewView:_refreshGift()
	return
end

function SxGameNewView:_checkContinue()
	SxGameController.instance:continueFindScore()
end

function SxGameNewView:_nextStep()
	SxGameModel.instance:reduceStep()
end

function SxGameNewView:_onNormalEffect(cellGo, callback, type)
	local effName = "fx_ui_sanxiao/fx_ui_sanxiao_xiaochu.prefab"

	UIEffectManager.instance:playEffect(self, effName, cellGo, 0, 0, false, false, nil, callback)
end

function SxGameNewView:_onSpecialEffect(operateMo, callback)
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

function SxGameNewView:_checkGameOverByStep()
	local sxGameResultView

	if SxGameModel.instance:getCurStep() == 0 and sxGameResultView then
		local cell = SxGameModel.instance:getSpecialCell()

		if cell == nil then
			GameUtil.SetActive(self.ExtTime, false)
			sxGameResultView:showResultView()
		else
			GameUtil.SetActive(self.ExtTime, true)
			SxGameController.instance:addAction(cell)
		end
	else
		printInfo("没获取到对象")
	end
end

function SxGameNewView:_onCombo()
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

function SxGameNewView:testCell()
	for i = 1, 8 do
		local str = " "

		for j = 1, 8 do
			str = str .. " " .. self._cells[i][j]._cellData._type

			printInfo("x:" .. self._cells[i][j]._cellData._x .. ",y:" .. self._cells[i][j]._cellData._y)
		end
	end
end

function SxGameNewView:_onSxCellSel()
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

function SxGameNewView:_onSxCellDeSel(x, y)
	local _cell = self._cells[y][x]

	if _cell then
		_cell:removeSelEffect()
	end
end

function SxGameNewView:_getActivityId()
	printError("_getActivityId获取活动Id")
end

function SxGameNewView:_getStageId()
	printError("_getStageId获取关卡id")
end

function SxGameNewView:_PM_ThreeMatchesGameInfoRes()
	self._cellArr = SxGameModel.instance:getGameMapArr()

	SxGameModel.instance:removeAction()

	self._cells = {}

	self:_initCells()
	self:_refreshGift()
end

function SxGameNewView:_resetMap()
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

	SxGameController.instance:defaultState()
	SxGameModel.instance:reset()
	SxGameModel.instance:initGameMapArrFromMsg(self.activityId)
	self:_initCells()
end

return SxGameNewView
