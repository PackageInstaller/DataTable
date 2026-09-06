-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/triplemacthesgame/view/TripleMacthesGameCopyView.lua

module("logic.extensions.triplemacthesgame.view.TripleMacthesGameCopyView", package.seeall)

local TripleMacthesGameCopyView = class("TripleMacthesGameCopyView", ViewComponent)

TripleMacthesGameCopyView.IceIndex = -2

function TripleMacthesGameCopyView:ctor()
	TripleMacthesGameCopyView.super.ctor(self)

	self._x_space = 80
	self._y_space = 80
	self._maxDir = 10000
end

function TripleMacthesGameCopyView:bindEvents()
	return
end

function TripleMacthesGameCopyView:unbindEvents()
	return
end

function TripleMacthesGameCopyView:addGlobalEvent()
	GlobalDispatcher:addListener(GlobalNotify.SwapView, self._swapCell, self)
	GlobalDispatcher:addListener(GlobalNotify.RemoveCell, self._removeCell, self)
	GlobalDispatcher:addListener(GlobalNotify.NextStep, self._nextStep, self)
	GlobalDispatcher:addListener(GlobalNotify.StepOver, self._checkGameOverByStep, self)
	GlobalDispatcher:addListener(GlobalNotify.Combo, self._onCombo, self)
	GlobalDispatcher:addListener(GlobalNotify.SxCellSel, self._onSxCellSel, self)
	GlobalDispatcher:addListener(GlobalNotify.SxCellDeSel, self._onSxCellDeSel, self)
	GlobalDispatcher:addListener(GlobalNotify.TripleMacthesClearSelAllEffect, self.removeAllSelEffect, self)
	GlobalDispatcher:addListener(GlobalNotify.TripleMacthesClearSpecial, self._removeAllSpecial, self)
	GlobalDispatcher:addListener(GlobalNotify.TripleMacthesGameStart, self._initView, self)
end

function TripleMacthesGameCopyView:rmGlobalEvent()
	GlobalDispatcher:removeListener(GlobalNotify.SwapView, self._swapCell, self)
	GlobalDispatcher:removeListener(GlobalNotify.RemoveCell, self._removeCell, self)
	GlobalDispatcher:removeListener(GlobalNotify.NextStep, self._nextStep, self)
	GlobalDispatcher:removeListener(GlobalNotify.StepOver, self._checkGameOverByStep, self)
	GlobalDispatcher:removeListener(GlobalNotify.Combo, self._onCombo, self)
	GlobalDispatcher:removeListener(GlobalNotify.SxCellSel, self._onSxCellSel, self)
	GlobalDispatcher:removeListener(GlobalNotify.SxCellDeSel, self._onSxCellDeSel, self)
	GlobalDispatcher:removeListener(GlobalNotify.TripleMacthesClearSelAllEffect, self.removeAllSelEffect, self)
	GlobalDispatcher:removeListener(GlobalNotify.TripleMacthesClearSpecial, self._removeAllSpecial, self)
	GlobalDispatcher:removeListener(GlobalNotify.TripleMacthesGameStart, self._initView, self)
end

function TripleMacthesGameCopyView:buildUI()
	self._container = self:getGo("Container")
	self._effectContainer = self:getGo("effectContainer")
	self._freeContainer = self:getGo("FreeContainer")
	self._cellObj = self:getGo("cellObj")
	self._flyEffectGo = self:getGo("flyEffect")
	self._effectShowGo = self:getGo("effectShow")
end

function TripleMacthesGameCopyView:destroyUI()
	return
end

function TripleMacthesGameCopyView:onEnter()
	self:addGlobalEvent()

	self._effectHandlesPool = {}

	TripleMachesGameController.instance:defaultState()
end

function TripleMacthesGameCopyView:onEnterFinished()
	return
end

function TripleMacthesGameCopyView:onExit()
	self:rmGlobalEvent()
	removetimer(self._fallDown, self)
	removetimer(self._checkContinue, self)
	removetimer(self._waitOffsetDown, self)

	for i, v in ipairs(self._effectHandlesPool) do
		UIEffectManager.instance:stopEffect(v)
	end

	table.clear(self._effectHandlesPool)
end

function TripleMacthesGameCopyView:onExitFinished()
	local size = TripleMacthesGameModel.instance:getGameMapSize()

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

	if self._cellPools then
		self._cellPools:clear()
	end

	self._cells = nil

	TripleMachesGameController.instance:defaultState()
	TripleMacthesGameModel.instance:reset()

	self._effectHandlesPool = nil

	if self._flyPools then
		self._flyPools:clear()
	end

	if self._rainbowPools then
		self._rainbowPools:clear()
	end
end

function TripleMacthesGameCopyView:_initView()
	self:initGame()
end

function TripleMacthesGameCopyView:_onCustomInputCallback()
	GameUtil.SetActive(self._tips, false)
end

function TripleMacthesGameCopyView:onHelpClick()
	GameUtil.SetActive(self._tips, true)
end

function TripleMacthesGameCopyView:_onClickClose()
	if TripleMachesGameController.instance:isCanDoAction() then
		-- block empty
	else
		TipsFacade.instance:openCommonTips(lang("请在计算得分后进行操作"))
	end
end

function TripleMacthesGameCopyView:_onResourceLoaded()
	self:_initCells()
end

function TripleMacthesGameCopyView:_disposeFunc(obj)
	local sxGameCell = Framework.LuaComponentContainer.Get(obj.gameObject, TripleMacthesCell)

	sxGameCell:onDestroy()
end

function TripleMacthesGameCopyView:_resetFunc(obj)
	goutil.addChildToParent(obj.gameObject, self._freeContainer.gameObject.transform)
end

function TripleMacthesGameCopyView:_initCells()
	local size = TripleMacthesGameModel.instance:getGameMapSize()

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

	local maxDirVector = self._cells[size.y][size.x]._container.transform.localPosition - self._cells[1][1]._container.transform.localPosition

	self._maxDir = maxDirVector.x * maxDirVector.x + maxDirVector.y * maxDirVector.y
end

function TripleMacthesGameCopyView:_getCellResPath(sxGameCellMO)
	return sxGameCellMO:getCellRes()
end

function TripleMacthesGameCopyView:genarateCell(type, rssPath, cellDat)
	function resetFunc(obj)
		self:_resetFunc(obj)
	end

	function disposeFunc(obj)
		self:_disposeFunc(obj)
	end

	self._cellPools = self._cellPools or ObjectPool.New(5, nil, disposeFunc, resetFunc)

	local cellObj

	if self._cellPools then
		cellObj = self._cellPools:fetchObject()
	end

	local sxGameCell

	if not cellObj then
		cellObj = goutil.clone(self._cellObj)

		if cellObj then
			GameUtil.SetActive(cellObj, true)
			goutil.addChildToParent(cellObj, self._container.gameObject.transform)

			sxGameCell = Framework.LuaComponentContainer.Add(cellObj.gameObject, TripleMacthesCell)
			sxGameCell._view = self

			sxGameCell:initCell(cellDat)
		end
	else
		GameUtil.SetActive(cellObj, true)
		goutil.addChildToParent(cellObj, self._container.gameObject.transform)

		sxGameCell = Framework.LuaComponentContainer.Get(cellObj.gameObject, TripleMacthesCell)
		sxGameCell._view = self

		sxGameCell:resetCell(cellDat)
	end

	return cellObj, sxGameCell
end

function TripleMacthesGameCopyView:_removeAllCell()
	local size = TripleMacthesGameModel.instance:getGameMapSize()

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

function TripleMacthesGameCopyView:_swapCell(back)
	local actions = TripleMacthesGameModel.instance:getActions()

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

			TripleMacthesGameModel.instance:setCellData(self._cellArr[mo0._y][mo0._x]._x, self._cellArr[mo0._y][mo0._x]._y, self._cellArr[mo1._y][mo1._x]._type, self._cellArr[mo1._y][mo1._x]._addType)
			TripleMacthesGameModel.instance:setCellData(self._cellArr[mo1._y][mo1._x]._x, self._cellArr[mo1._y][mo1._x]._y, tempType, tempAddType)
			self._cells[mo0._y][mo0._x]:resetCell(self._cellArr[mo0._y][mo0._x])
			self._cells[mo1._y][mo1._x]:resetCell(self._cellArr[mo1._y][mo1._x])

			if not back then
				TripleMachesGameController.instance:findScore()
			else
				TripleMacthesGameModel.instance:removeAction()
				TripleMachesGameController.instance:defaultState()
			end
		end
	end

	preCell:onChangePos(mo1._x, mo1._y, swapActionFinish)
	afterCell:onChangePos(mo0._x, mo0._y, swapActionFinish)
end

function TripleMacthesGameCopyView:_removeCell()
	local _removeCellCount = 0

	local function removeFunc(cell)
		if cell then
			self._cellPools:returnObject(cell:getObj())

			self._cells[cell._cellData._y][cell._cellData._x] = nil
		end

		_removeCellCount = _removeCellCount - 1

		if _removeCellCount == 0 then
			settimer(0.4, self._fallDown, self, false)
		end
	end

	self._specialCell = self._specialCell and table.clear(self._specialCell) or {}

	local recordIce = {}
	local speicalIce = TripleMacthesGameModel.instance:getAllIceSpeical()

	speicalIce:ForEach(function(info, index)
		recordIce[info.cellData] = true

		local cell = self._cells[info.cellData._y][info.cellData._x]
		local targetCell = self._cells[info.formY][info.formX]

		self._specialCell[info.specialType] = self._specialCell[info.specialType] or {}
		self._specialCell[info.specialType][targetCell] = self._specialCell[info.specialType][targetCell] or {}
		self._specialCell[info.specialType][targetCell][TripleMacthesGameCopyView.IceIndex] = self._specialCell[info.specialType][targetCell][TripleMacthesGameCopyView.IceIndex] or {}

		table.insert(self._specialCell[info.specialType][targetCell][TripleMacthesGameCopyView.IceIndex], cell)
	end)
	TripleMacthesGameModel.instance:clearAllIce()

	local resetCells = TripleMacthesGameModel.instance:getNeedResetCell()

	resetCells:ForEach(function(cellMo, index)
		if not recordIce[cellMo] then
			self._cells[cellMo._y][cellMo._x]:resetCell(self._cellArr[cellMo._y][cellMo._x])
		end
	end)

	local operates = TripleMacthesGameModel.instance:getOperate()

	if operates:IsEmpty() == true and speicalIce:IsEmpty() then
		settimer(0.4, self._fallDown, self, false)
	end

	local blooms = {}

	operates:ForEach(function(operateMo, index)
		_removeCellCount = _removeCellCount + 1

		local cell = self._cells[operateMo._operatePos.y][operateMo._operatePos.x]

		if operateMo._special_type == SxGameCellType.RainbowBall and operateMo._remove_from_x ~= 0 and operateMo._remove_from_y ~= 0 then
			local targetCell = self._cells[operateMo._remove_from_y][operateMo._remove_from_x]

			self._specialCell[SxGameCellType.RainbowBall] = self._specialCell[SxGameCellType.RainbowBall] or {}
			self._specialCell[SxGameCellType.RainbowBall][targetCell] = self._specialCell[SxGameCellType.RainbowBall][targetCell] or {}

			table.insert(self._specialCell[SxGameCellType.RainbowBall][targetCell], cell)
		elseif operateMo._special_type == SxGameCellType.Fly and operateMo._remove_from_x ~= 0 and operateMo._remove_from_y ~= 0 then
			local targetCell = self._cells[operateMo._remove_from_y][operateMo._remove_from_x]

			self._specialCell[SxGameCellType.Fly] = self._specialCell[SxGameCellType.Fly] or {}
			self._specialCell[SxGameCellType.Fly][targetCell] = self._specialCell[SxGameCellType.Fly][targetCell] or {}

			table.insert(self._specialCell[SxGameCellType.Fly][targetCell], cell)
		elseif operateMo._special_effect then
			self:_onSpecialEffect(operateMo, function()
				cell:onRemove(removeFunc)
			end)

			if operateMo._special_type == SxGameCellType.Bloom then
				table.insert(blooms, operateMo._operatePos)
			end
		else
			self:_onNormalEffect(cell._container.gameObject, function()
				cell:onRemove(removeFunc)
			end, operateMo._type, operateMo._special_type)
		end
	end)

	if self._specialCell[SxGameCellType.Fly] then
		for formCell, toCells in pairs(self._specialCell[SxGameCellType.Fly]) do
			for i, toCell in ipairs(toCells) do
				self:_onFlyEffect(formCell, toCell, function()
					self:_onNormalEffect(toCell._container.gameObject, function()
						toCell:onRemove(removeFunc)
					end, toCell._cellData._type, SxGameCellType.Fly)
				end)
			end

			for i, toCell in ipairs(toCells[TripleMacthesGameCopyView.IceIndex] or {}) do
				_removeCellCount = _removeCellCount + 1

				self:_onFlyEffect(formCell, toCell, function()
					removeFunc()
					toCell:resetCell(self._cellArr[toCell._cellData._y][toCell._cellData._x])
				end)
			end
		end
	end

	if self._specialCell[SxGameCellType.RainbowBall] then
		for formCell, toCells in pairs(self._specialCell[SxGameCellType.RainbowBall]) do
			for i, toCell in ipairs(toCells) do
				self:_onRainbowEffect(formCell, toCell, function()
					self:_onNormalEffect(toCell._container.gameObject, function()
						toCell:onRemove(removeFunc)
					end, toCell._cellData._type, SxGameCellType.RainbowBall)
				end)
			end

			for i, toCell in ipairs(toCells[TripleMacthesGameCopyView.IceIndex] or {}) do
				_removeCellCount = _removeCellCount + 1

				self:_onRainbowEffect(formCell, toCell, function()
					removeFunc()
					toCell:resetCell(self._cellArr[toCell._cellData._y][toCell._cellData._x])
				end)
			end
		end
	end

	if #blooms > 0 then
		local size = TripleMacthesGameModel.instance:getGameMapSize()

		for y = 1, size.y do
			for x = 1, size.x do
				if self._cells[y][x] then
					local go = self._cells[y][x]._container
					local totalOffset = Vector3.zero

					if go then
						for i, v in ipairs(blooms) do
							local bloomGo = self._cells[v.y][v.x]._container
							local offset = bloomGo.transform.localPosition - go.transform.localPosition
							local dir = Vector3.Normalize(offset)
							local offsetDir = offset.x * offset.x + offset.y * offset.y

							dir = dir * (self._maxDir - offsetDir) / self._maxDir

							if offsetDir < self._maxDir / 4 then
								totalOffset = totalOffset + dir
							end
						end

						totalOffset:ClampMagnitude(1)

						local totalTime = 0.3
						local sequence = DG.Tweening.DOTween.Sequence()

						sequence:Append(go.transform:DOBlendableLocalMoveBy(-totalOffset * 10, totalTime * totalOffset:SqrMagnitude() / 2):SetLoops(2, DG.Tweening.LoopType.Yoyo))
						sequence:PrependInterval(totalTime * (1 - totalOffset:SqrMagnitude() / 2))
					end
				end
			end
		end
	end
end

function TripleMacthesGameCopyView:_fallDown()
	TripleMacthesGameModel.instance:removeAction()
	TripleMacthesGameModel.instance:removeCellData()
	TripleMacthesGameModel.instance:clearAllIceSpeical()
	TripleMacthesGameModel.instance:clearEffectMap()
	self:_checkSpecial()
	self:_waitFallDown()
end

function TripleMacthesGameCopyView:_waitFallDown()
	local size = TripleMacthesGameModel.instance:getGameMapSize()

	for i = 1, size.x do
		self:_checkCellFallDown(i)
	end

	for i = 1, size.x do
		self:_checkSupplyCell(i)
	end

	settimer(0, self._waitOffsetDown, self, false)
end

function TripleMacthesGameCopyView:_waitOffsetDown()
	local size = TripleMacthesGameModel.instance:getGameMapSize()
	local move = false

	for i = 1, size.x do
		if self:_checkCellOffsetDown(i) == true then
			move = true
		end
	end

	for i = 1, size.x do
		self:_checkCellFallDown(i)
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

function TripleMacthesGameCopyView:_fallDownFinish()
	self:checkEmptyCell()
	settimer(0.4, self._checkContinue, self, false)
	self:_refreshGift()
end

function TripleMacthesGameCopyView:_checkSpecial()
	local spArr = TripleMacthesGameModel.instance:getSpecial()

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

function TripleMacthesGameCopyView:_checkCellFallDown(i)
	local size = TripleMacthesGameModel.instance:getGameMapSize()
	local from_y, count = -1, 0

	for j = 1, size.y do
		if self._cellArr[j][i]._type == SxGameCellType.Empty and not TripleMacthesGameModel.instance:isIce(i, j) then
			if from_y == -1 then
				count = 0
				from_y = j
			end

			count = count + 1
		elseif from_y ~= -1 then
			if not TripleMacthesGameModel.instance:isStoodType(self._cells[j][i]:getType()) then
				if TripleMacthesGameModel.instance:isIce(i, j) == true then
					count = 0
					from_y = -1

					goto label_45_0
				end
			end

			self._cells[j][i]:onChangePos(i, j - count)

			self._cells[j - count][i] = self._cells[j][i]

			TripleMacthesGameModel.instance:setCellData(i, j - count, self._cells[j - count][i]:getType(), self._cells[j - count][i]:getAddType())

			self._cells[j - count][i]._cellData = self._cellArr[j - count][i]

			TripleMacthesGameModel.instance:setCellData(i, j, SxGameCellType.Empty)

			self._cells[j][i] = nil
		end

		::label_45_0::
	end
end

function TripleMacthesGameCopyView:_checkCellOffsetDown(i)
	local size = TripleMacthesGameModel.instance:getGameMapSize()
	local isMove = false

	for j = 1, size.y do
		local from_y, from_x, to_y, to_x = -1, -1, -1, -1

		if self._cellArr[j][i]._type == SxGameCellType.Empty and self._cellArr[j + 1] then
			if self._cellArr[j + 1][i - 1] and not TripleMacthesGameModel.instance:isStoodCell(i - 1, j + 1) and self._cellArr[j + 1][i - 1]._type ~= SxGameCellType.Empty then
				if TripleMacthesGameModel.instance:isStoodCell(i, j + 1) then
					if not TripleMacthesGameModel.instance:isStoodCell(i - 1, j) then
						to_x = i
						to_y = j
						from_x = i - 1
						from_y = j + 1
					elseif self._cellArr[j + 1][i + 1] and not TripleMacthesGameModel.instance:isStoodCell(i + 1, j + 1) and self._cellArr[j + 1][i + 1]._type ~= SxGameCellType.Empty then
						if TripleMacthesGameModel.instance:isStoodCell(i, j + 1) then
							if not TripleMacthesGameModel.instance:isStoodCell(i + 1, j) then
								to_x = i
								to_y = j
								from_x = i + 1
								from_y = j + 1
							end

							if from_y > 0 and from_x > 0 and to_y > 0 and to_x > 0 then
								self._cells[from_y][from_x]:onChangePos(to_x, to_y)

								self._cells[to_y][to_x] = self._cells[from_y][from_x]

								TripleMacthesGameModel.instance:setCellData(to_x, to_y, self._cells[to_y][to_x]:getType(), self._cells[to_y][to_x]:getAddType())

								self._cells[to_y][to_x]._cellData = self._cellArr[to_y][to_x]

								TripleMacthesGameModel.instance:setCellData(from_x, from_y, SxGameCellType.Empty)

								isMove = true
								self._cells[from_y][from_x] = nil
							end
						end
					end
				end
			end
		end
	end

	return isMove
end

function TripleMacthesGameCopyView:_checkSupplyCell(i)
	local size = TripleMacthesGameModel.instance:getGameMapSize()
	local from_y, count = -1, 0
	local blockIdx = 0
	local isSupply = false

	for j = 1, size.y do
		if TripleMacthesGameModel.instance:isStoodCell(i, j) then
			blockIdx = j
		end
	end

	for j = blockIdx + 1, size.y do
		if self._cellArr[j][i]._type == SxGameCellType.Empty and not TripleMacthesGameModel.instance:isIce(i, j) then
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

function TripleMacthesGameCopyView:_supplyCell(x, from_y, num)
	local function onMoveCallBack()
		return
	end

	for i = 1, num do
		local supplyType = TripleMacthesGameModel.instance:getSupplyCellType()
		local addType = TripleMacthesGameModel.instance:getSupplyCellAddType(supplyType)

		TripleMacthesGameModel.instance:setCellData(x, from_y + i - 1, supplyType, addType)

		local mo = self._cellArr[from_y + i - 1][x]
		local _cellType = mo._type
		local cellObj, sxGameCell = self:genarateCell(_cellType, self:_getCellResPath(mo), mo)

		cellObj.transform.localPosition = Vector3.New(self._x_space * (x - 1), self._y_space * (7 + i))

		sxGameCell:onBuildAction(onMoveCallBack)

		self._cells[from_y + i - 1][x] = sxGameCell

		TripleMacthesGameModel.instance:_supplyCell(supplyType, addType)
	end
end

function TripleMacthesGameCopyView:checkEmptyCell()
	local size = TripleMacthesGameModel.instance:getGameMapSize()

	for i = 1, size.y do
		if not self._cells then
			break
		end

		for j = 1, size.x do
			if not self._cells[i] then
				break
			end

			local cell = self._cells[i][j]

			if cell and cell._cellData._type == SxGameCellType.Empty and not TripleMacthesGameModel.instance:isIce(j, i) then
				if not goutil.isNil(cell:getObj()) then
					self._cellPools:returnObject(cell:getObj())
				end

				self._cells[i][j] = nil
			end
		end
	end
end

function TripleMacthesGameCopyView:_refreshGift()
	return
end

function TripleMacthesGameCopyView:_checkContinue()
	TripleMachesGameController.instance:continueFindScore()
end

function TripleMacthesGameCopyView:_nextStep()
	TripleMacthesGameModel.instance:reduceStep()
end

function TripleMacthesGameCopyView:_onNormalEffect(cellGo, callback, type, specialType)
	local eff = UIEffectManager.instance:playEffect(self, (specialType == SxGameCellType.RainbowBall or nil) and "20240403/sanxiaowanfa/fx_ui_caihongqiujiguang.prefab", cellGo, 0, 0, false, false, nil, callback)

	if specialType == SxGameCellType.RainbowBall then
		eff:setScale(0.002777778)
	end
end

function TripleMacthesGameCopyView:_onSpecialEffect(operateMo, callback)
	if operateMo then
		local _pos = operateMo._operatePos
		local cellMo = self._cells[_pos.y][_pos.x]._cellData
		local _cellGo = self._cells[_pos.y][_pos.x]._container.gameObject
		local effName = "fx_ui_sanxiao/fx_ui_sanxiao_xiaochu.prefab"
		local offset_x = 0
		local offset_y = 0

		if cellMo._type == SxGameCellType.Flash then
			effName = "fx_ui_sanxiao/fx_ui_sanxiao_shandian.prefab"
			offset_x = (4 - _pos.x) * 80 + 40
		elseif cellMo._type == SxGameCellType.Bloom then
			effName = "20240403/sanxiaowanfa/fx_ui_gezibaozha.prefab"
		elseif cellMo._type == SxGameCellType.FlashShu then
			effName = "fx_ui_sanxiao/fx_ui_sanxiao_shandian_shu.prefab"
			offset_y = (4 - _pos.y) * 80 + 40
		elseif cellMo._type == SxGameCellType.RainbowBall then
			effName = "20240403/sanxiaowanfa/fx_ui_caihongqiubao.prefab"
		elseif cellMo._type == SxGameCellType.Fly then
			effName = "20240403/sanxiaowanfa/fx_ui_zhifeijibaozha.prefab"
		end

		local eff1 = UIEffectManager.instance:playEffect(self, effName, _cellGo, offset_x, offset_y, false, false, nil, callback)

		eff1:setScale(0.002777778)

		if operateMo._special_type == SxGameCellType.Bloom then
			eff1:setScale(0.004166667)
		end
	end
end

function TripleMacthesGameCopyView:_onFlyEffect(formCell, toCell, callback)
	function disposeFunc(obj)
		goutil.destroy(obj)
	end

	function resetFunc(obj)
		GameUtil.SetActive(obj, false)
	end

	self._flyPools = self._flyPools or ObjectPool.New(5, nil, disposeFunc, resetFunc)

	local obj = self._flyPools:fetchObject()
	local formPos = formCell._container.transform.localPosition
	local toPos = toCell._container.transform.localPosition
	local dirVector = toPos - formPos
	local dir = dirVector.x * dirVector.x + dirVector.y * dirVector.y
	local rate = math.sqrt(dir) / math.sqrt(self._maxDir)
	local time = 0.2 + 0.5 * rate

	obj = obj or goutil.cloneAndSetParent(self._flyEffectGo, self._effectContainer.transform)

	if obj then
		GameUtil.SetActive(obj, true)

		local imgGo = goutil.findChild(obj, "img")
		local effectPath = "20240403/sanxiaowanfa/fx_ui_zhifeijiqifei.prefab"
		local effect = UIEffectManager.instance:playEffect(self, effectPath, nil, 0, 0, true, nil, nil, function(handler, effect)
			effect:setLocalEulerAngle(0, 0, 0)
		end)

		effect:setParent(imgGo.transform)
		effect:setScale(1)
		effect:setLocalPos(0, 0, 0)
		GameUtil.setLocalPos(obj, formPos.x, formPos.y, formPos.z)

		local imageGo = goutil.findChild(obj, "img")
		local isRev = 1

		if math.random() > 0.5 then
			isRev = -1
		end

		local angle = -Vector3.AngleAroundAxis(Vector3(-isRev * dirVector.y, isRev * dirVector.x, 0), Vector3.right, Vector3.forward)

		GameUtil.setLocalRotation(imageGo, 0, 0, angle)
		imageGo.transform:Rotate(Vector3(0, 0, -isRev * 15))

		local sequence2 = DG.Tweening.DOTween.Sequence()

		sequence2:Append(imageGo.transform:DOLocalRotate(Vector3(0, 0, -isRev * 150), time, DG.Tweening.RotateMode.LocalAxisAdd))

		local sequence = DG.Tweening.DOTween.Sequence()
		local tween, tween2

		if dir > self._maxDir / 4 then
			tween = obj.transform:DOBlendableLocalMoveBy(dirVector, time)
			tween2 = obj.transform:DOBlendableLocalMoveBy(Vector3(-isRev * dirVector.y / 2 * rate, isRev * dirVector.x / 2, 0), time / 2)
		else
			tween = obj.transform:DOBlendableLocalMoveBy(dirVector, time)
			tween2 = obj.transform:DOBlendableLocalMoveBy(Vector3(-isRev * dirVector.y * rate, isRev * dirVector.x, 0), time / 2)
		end

		tween2:SetLoops(2, DG.Tweening.LoopType.Yoyo)
		sequence:Append(tween)
		sequence:Join(tween2)
		sequence:OnComplete(function()
			callback()
			GameUtil.SetActive(obj, false)
			UIEffectManager.instance:stopEffect(effect)
			self._flyPools:returnObject(obj)
		end)
	else
		callback()
	end
end

function TripleMacthesGameCopyView:_onRainbowEffect(formCell, toCell, callback)
	function disposeFunc(obj)
		goutil.destroy(obj)
	end

	function resetFunc(obj)
		GameUtil.SetActive(obj, false)

		if self._effectHandlesPool[obj] then
			UIEffectManager.instance:stopEffect(self._effectHandlesPool[obj])

			self._effectHandlesPool[obj] = nil
		end
	end

	self._rainbowPools = self._rainbowPools or ObjectPool.New(5, nil, disposeFunc, resetFunc)

	local obj = self._rainbowPools:fetchObject()
	local formPos = formCell._container.transform.localPosition
	local toPos = toCell._container.transform.localPosition
	local dirVector = toPos - formPos
	local dir = dirVector.x * dirVector.x + dirVector.y * dirVector.y
	local time = 0.5 + 0.5 * dir / self._maxDir

	obj = obj or goutil.cloneAndSetParent(self._effectShowGo, self._effectContainer.transform)

	if obj then
		GameUtil.SetActive(obj, true)
		GameUtil.setLocalPos(obj, formPos.x, formPos.y, formPos.z)

		local function _loadEffectEnd(handler, eff)
			local trs = eff.effGo:GetComponentsInChildren(typeof(UnityEngine.TrailRenderer))

			for i = 0, trs.Length - 1 do
				trs[i]:Clear()
			end

			local tween = obj.transform:DOBlendableLocalMoveBy(dirVector, time)

			tween:OnComplete(function()
				callback()
				GameUtil.SetActive(obj, false)
				self._rainbowPools:returnObject(obj)
			end)
		end

		local effectPath = "20240403/sanxiaowanfa/fx_ui_jiguang.prefab"

		if self._effectHandlesPool[obj] then
			UIEffectManager.instance:stopEffect(self._effectHandlesPool[obj])

			self._effectHandlesPool[obj] = nil
		end

		local effectHandler = UIEffectManager.instance:playEffect(self, effectPath, obj.transform, 0, 0, true, nil, nil, _loadEffectEnd)

		if effectHandler then
			effectHandler:setParent(obj.transform)
			effectHandler:setLocalPos(0, 0, 0)
			effectHandler:setScale(0.5)

			if effectHandler.effGo then
				local tr = effectHandler.effGo:GetComponentInChildren(typeof(UnityEngine.TrailRenderer))

				tr:Clear()
			end

			self._effectHandlesPool[obj] = effectHandler
		end
	end
end

function TripleMacthesGameCopyView:_checkGameOverByStep()
	return
end

function TripleMacthesGameCopyView:_onCombo()
	local cellObj = self:getResInstance("effect/prefabs/ui/fx_ui_sanxiao/fx_ui_sanxiao_combo.prefab")

	if cellObj then
		local sxGameCombo = Framework.LuaComponentContainer.Add(cellObj, SxGameCombo)

		sxGameCombo:setCombo(TripleMacthesGameModel.instance:getCombo())
	end

	if TripleMacthesGameModel.instance:getCombo() == 5 then
		local cellObj = self:getResInstance("effect/prefabs/ui/fx_ui_sanxiao/fx_ui_sanxiao_amazing.prefab")

		if cellObj then
			local sxGameCombo = Framework.LuaComponentContainer.Add(cellObj, SxGameAmazing)
		end
	end
end

function TripleMacthesGameCopyView:testCell()
	for i = 1, 8 do
		local str = " "

		for j = 1, 8 do
			str = str .. " " .. self._cells[i][j]._cellData._type

			printInfo("x:" .. self._cells[i][j]._cellData._x .. ",y:" .. self._cells[i][j]._cellData._y)
		end
	end
end

function TripleMacthesGameCopyView:_onSxCellSel()
	local actions = TripleMacthesGameModel.instance:getActions()

	actions:ForEach(function(action, index)
		if action then
			local _cell = self._cells[action._y][action._x]

			if _cell then
				_cell:addSelEffect()
			end
		end
	end)
end

function TripleMacthesGameCopyView:_onSxCellDeSel(x, y)
	local _cell = self._cells[y][x]

	if _cell then
		_cell:removeSelEffect()
	end
end

function TripleMacthesGameCopyView:removeAllSelEffect()
	local size = TripleMacthesGameModel.instance:getGameMapSize()

	for y = 1, size.y do
		for x = 1, size.x do
			local _cell = self._cells[y][x]

			if _cell then
				_cell:removeSelEffect()
			end
		end
	end
end

function TripleMacthesGameCopyView:_removeAllSpecial()
	local cell = TripleMacthesGameModel.instance:getSpecialCell()

	if cell == nil then
		GlobalDispatcher:dispatch(GlobalNotify.TripleMacthesClearSpecialEnd)
	else
		TripleMachesGameController.instance:addAction(cell)
	end
end

function TripleMacthesGameCopyView:_getActivityId()
	printError("_getActivityId获取活动Id")
end

function TripleMacthesGameCopyView:_getStageId()
	printError("_getStageId获取关卡id")
end

function TripleMacthesGameCopyView:initGame()
	self._cellArr = TripleMacthesGameModel.instance:getGameMapArr()

	TripleMacthesGameModel.instance:removeAction()

	self._cells = {}

	self:_initCells()
	self:_refreshGift()
end

function TripleMacthesGameCopyView:_resetMap()
	local size = TripleMacthesGameModel.instance:getGameMapSize()

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

	self._cellPools = nil

	TripleMachesGameController.instance:defaultState()
	TripleMacthesGameModel.instance:reset()
	TripleMacthesGameModel.instance:initGameMapArrFromMsg(self.activityId)
	self:_initCells()
end

return TripleMacthesGameCopyView
