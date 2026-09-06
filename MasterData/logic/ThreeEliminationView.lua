-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/threeelimination/view/ThreeEliminationView.lua

module("logic.extensions.threeelimination.view.ThreeEliminationView", package.seeall)

local ThreeEliminationView = class("ThreeEliminationView", ViewComponent)

function ThreeEliminationView:ctor()
	ThreeEliminationView.super.ctor(self)

	self._x_space = 125
	self._y_space = 125
	self._cellPools = {}
end

function ThreeEliminationView:bindEvents()
	return
end

function ThreeEliminationView:unbindEvents()
	return
end

function ThreeEliminationView:addGlobalEvent()
	self.addGEvent(self, GlobalNotify.SwapView, self._swapCell, self)
	self.addGEvent(self, GlobalNotify.RemoveCell, self._removeCell, self)
	self.addGEvent(self, GlobalNotify.NextStep, self._nextStep, self)
	self.addGEvent(self, GlobalNotify.Combo, self._onCombo, self)
	self.addGEvent(self, GlobalNotify.ThreeEliminationCellMoveStart, self._onCellMoveStart, self)
	self.addGEvent(self, GlobalNotify.ThreeEliminationCellMove, self._onCellMove, self)
	self.addGEvent(self, GlobalNotify.ThreeEliminationCellMoveEnd, self._onCellMoveEnd, self)
	self.addGEvent(self, GlobalNotify.PM_ThreeEliminationGameOpenFuncRes, self._PM_ThreeEliminationGameOpenFuncRes, self)
end

function ThreeEliminationView:buildUI()
	self._container = self:getGo("Container")
	self._freeContainer = self:getGo("FreeContainer")
	self._cellObjClone = self:getGo("petCell")
	self._freeCellAreaObj = self:getGo("freeCellArea")
end

function ThreeEliminationView:destroyUI()
	return
end

function ThreeEliminationView:onEnter()
	ThreeEliminationModel.instance:getMoveRes()
	ThreeEliminationController.instance:defaultState()
	self:addGlobalEvent()

	self._activityId = self:getFirstParam()
	self._freeToCellOffset = GameUtil.getLocalPos(self._freeCellAreaObj) - GameUtil.getLocalPos(self._container)
end

function ThreeEliminationView:onEnterFinished()
	return
end

function ThreeEliminationView:onExit()
	removetimer(self._fallDown, self)
	removetimer(self._waitFallDown, self)
	removetimer(self._checkContinue, self)
	removetimer(self._waitOffsetDown, self)
end

function ThreeEliminationView:onExitFinished()
	local size = ThreeEliminationModel.instance:getGameMapSize()

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

	ThreeEliminationController.instance:defaultState()
	ThreeEliminationModel.instance:reset()
end

function ThreeEliminationView:_initView()
	return
end

function ThreeEliminationView:_onCustomInputCallback()
	GameUtil.SetActive(self._tips, false)
end

function ThreeEliminationView:onHelpClick()
	GameUtil.SetActive(self._tips, true)
end

function ThreeEliminationView:_onClickClose()
	if ThreeEliminationController.instance:isCanDoAction() then
		self:close()
	else
		TipsFacade.instance:openCommonTips(lang("请在计算得分后进行操作"))
	end
end

function ThreeEliminationView:_disposeFunc(obj)
	local sxGameCell = Framework.LuaComponentContainer.Get(obj.gameObject, ThreeEliminationCell)

	sxGameCell:onDestroy()
end

function ThreeEliminationView:_resetFunc(obj)
	local go = obj.gameObject

	GameUtil.SetActive(go, false)
	goutil.addChildToParent(obj.gameObject, self._freeContainer.gameObject.transform)

	local canvasGroup = go:GetComponent(ComponentType.CanvasGroup)

	canvasGroup.alpha = 1
end

function ThreeEliminationView:_initCells()
	self._cells = {}
	self._scaleCellMap = {}
	self._cellArr = ThreeEliminationModel.instance:getGameMapArr()

	local size = ThreeEliminationModel.instance:getGameMapSize()

	for i = 1, size.y do
		for j = 1, size.x do
			local mo = self._cellArr[i][j]
			local _cellType = mo._type
			local cellObj, sxGameCell = self:genarateCell(_cellType, self._cellObjClone, mo)

			cellObj.transform.localPosition = Vector3.New(self._x_space * (j - 1), -self._y_space * (i - 1), 0)
			self._cells[i] = self._cells[i] or {}
			self._cells[i][j] = sxGameCell
		end
	end
end

function ThreeEliminationView:genarateCell(type, cellObjClone, cellDat)
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
		cellObj = goutil.clone(cellObjClone)

		if cellObj then
			GameUtil.SetActive(cellObj, true)
			goutil.addChildToParent(cellObj, self._container.gameObject.transform)

			sxGameCell = Framework.LuaComponentContainer.Add(cellObj, ThreeEliminationCell)

			sxGameCell:initCell(cellDat)
		end
	else
		GameUtil.SetActive(cellObj, true)
		goutil.addChildToParent(cellObj.gameObject, self._container.gameObject.transform)

		sxGameCell = Framework.LuaComponentContainer.Get(cellObj.gameObject, ThreeEliminationCell)

		sxGameCell:resetCell(cellDat)
	end

	return cellObj, sxGameCell
end

function ThreeEliminationView:_removeAllCell()
	local size = ThreeEliminationModel.instance:getGameMapSize()

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

function ThreeEliminationView:_swapCell(back)
	local actions = ThreeEliminationModel.instance:getActions()

	if actions == nil or actions:IsEmpty() then
		return
	end

	local mo0 = actions:Get(0)
	local mo1 = actions:Get(1)

	if mo0 == nil then
		print(" tetssss ")
	end

	if mo0._type == SxGameCellType.Destroy or mo1._type == SxGameCellType.Destroy then
		ThreeEliminationController.instance:findScore()

		return
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

			ThreeEliminationModel.instance:setCellData(self._cellArr[mo0._y][mo0._x]._x, self._cellArr[mo0._y][mo0._x]._y, self._cellArr[mo1._y][mo1._x]._type)
			ThreeEliminationModel.instance:setCellData(self._cellArr[mo1._y][mo1._x]._x, self._cellArr[mo1._y][mo1._x]._y, tempType)
			self._cells[mo0._y][mo0._x]:resetCell(self._cellArr[mo0._y][mo0._x])
			self._cells[mo1._y][mo1._x]:resetCell(self._cellArr[mo1._y][mo1._x])

			if not back then
				ThreeEliminationController.instance:findScore()
			else
				ThreeEliminationModel.instance:removeAction()
				ThreeEliminationController.instance:defaultState()
			end
		end
	end

	preCell:onChangePos(mo1._x, mo1._y, swapActionFinish)
	afterCell:onChangePos(mo0._x, mo0._y, swapActionFinish)
end

function ThreeEliminationView:_removeCell()
	local _removeCellCount = 0

	local function removeFunc(cell)
		if self._cellPools[cell:getType()] then
			self._cellPools[cell:getType()]:returnObject(cell:getObj())
		end

		_removeCellCount = _removeCellCount - 1

		if _removeCellCount == 0 then
			settimer(0.2, self._fallDown, self, false)
		end
	end

	ThreeEliminationModel.instance:clearAllIce()

	local resetCells = ThreeEliminationModel.instance:getNeedResetCell()

	resetCells:ForEach(function(cellMo, index)
		self._cells[cellMo._y][cellMo._x]:resetCell(self._cellArr[cellMo._y][cellMo._x])
	end)

	local operates = ThreeEliminationModel.instance:getOperate()

	if operates:IsEmpty() == true then
		settimer(0.2, self._fallDown, self, false)
	end

	self._moveEffectToList = {}

	operates:ForEach(function(operateMo, index)
		_removeCellCount = _removeCellCount + 1

		local cell = self._cells[operateMo._operatePos.y][operateMo._operatePos.x]
		local cellType = self._cellArr[operateMo._operatePos.y][operateMo._operatePos.x]._type
		local cfg = ThreeEliminationConfig.instance:getPetCfg(self._activityId, cellType)

		if operateMo._special_effect then
			cell:onRemove(removeFunc)
			self:_onSpecialEffect(operateMo, function()
				return
			end)
		elseif cfg and cfg.evolvedId <= 0 then
			cell:hideCell()
			cell:moveCell(self._freeToCellOffset, removeFunc, 0.5, 1)

			local cellGo = cell._container.gameObject
			local pos = GameUtil.getAnchoredPos(self._container) + GameUtil.getAnchoredPos(cellGo)

			GlobalDispatcher:dispatch(GlobalNotify.ThreeEliminationPetFly, pos, cellType)
		elseif operateMo._remove_to_x > 0 and operateMo._remove_to_y > 0 and (operateMo._operatePos.y ~= operateMo._remove_to_y or operateMo._operatePos.x ~= operateMo._remove_to_x) then
			self:_onNormalEffect(cell._container.gameObject, function()
				cell:moveAndRemove(Vector3.New(self._x_space * (operateMo._remove_to_x - 1), -self._y_space * (operateMo._remove_to_y - 1), 0), removeFunc)
			end)

			self._moveEffectToList[operateMo._remove_to_y] = self._moveEffectToList[operateMo._remove_to_y] or {}
			self._moveEffectToList[operateMo._remove_to_y][operateMo._remove_to_x] = (self._moveEffectToList[operateMo._remove_to_y][operateMo._remove_to_x] or 0) + 1
		elseif operateMo._showEffect == true then
			self:_onNormalEffect(cell._container.gameObject, function()
				cell:onRemove(removeFunc)
				self:_showFlyEffect(operateMo._remove_to_x, operateMo._remove_to_y, cellType)
			end, operateMo._type)
		else
			cell:onRemove(removeFunc)
		end
	end)
end

function ThreeEliminationView:_fallDown()
	ThreeEliminationModel.instance:removeAction()
	ThreeEliminationModel.instance:removeCellData()

	if self:_checkSpecialAndCreate() == true then
		settimer(0.1, self._removeCell, self, false)
	else
		self:_waitFallDown()
	end
end

function ThreeEliminationView:_waitFallDown()
	local size = ThreeEliminationModel.instance:getGameMapSize()

	for i = 1, size.x do
		self:_checkCellFallDown(i)
	end

	for i = 1, size.x do
		self:_checkSupplyCell(i)
	end

	settimer(0, self._waitOffsetDown, self, false)
end

function ThreeEliminationView:_waitOffsetDown()
	local size = ThreeEliminationModel.instance:getGameMapSize()
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

function ThreeEliminationView:_fallDownFinish()
	settimer(0.4, self._checkContinue, self, false)
end

function ThreeEliminationView:_checkSpecialAndCreate()
	ThreeEliminationModel.instance:clearOperate()

	local spArr = ThreeEliminationModel.instance:getSpecial()

	if spArr:GetSize() == 0 then
		return false
	end

	for i = 1, spArr:GetSize() do
		local spCellData = spArr:PopFront()
		local _cellType = spCellData._type
		local cellObj, sxGameCell = self:genarateCell(_cellType, self._cellObjClone, self._cellArr[spCellData._y][spCellData._x])

		cellObj.transform.localPosition = Vector3.New(self._x_space * (spCellData._x - 1), -self._y_space * (spCellData._y - 1), 0)
		self._cells[spCellData._y][spCellData._x] = sxGameCell

		local cfg = ThreeEliminationConfig.instance:getPetCfg(self._activityId, _cellType)

		if cfg.evolvedId <= 0 then
			ThreeEliminationModel.instance:AddRemoveOp(spCellData._x, spCellData._y)
		end
	end

	return true
end

function ThreeEliminationView:_checkCellFallDown(i)
	local size = ThreeEliminationModel.instance:getGameMapSize()
	local from_y, count = -1, 0

	for j = size.y, 1, -1 do
		if self._cellArr[j][i]._type == SxGameCellType.Empty then
			if from_y == -1 then
				count = 0
				from_y = j
			end

			count = count + 1
		elseif from_y ~= -1 then
			if ThreeEliminationModel:isStoodType(self._cells[j][i]:getType()) then
				count = 0
				from_y = -1
			else
				self._cells[j][i]:onChangePos(i, j + count)

				self._cells[j + count][i] = self._cells[j][i]

				ThreeEliminationModel.instance:setCellData(i, j + count, self._cells[j + count][i]:getType(), self._cells[j + count][i]:getAddType())

				self._cells[j + count][i]._cellData = self._cellArr[j + count][i]

				ThreeEliminationModel.instance:setCellData(i, j, SxGameCellType.Empty)
			end
		end
	end
end

function ThreeEliminationView:_checkCellOffsetDown(i)
	local size = ThreeEliminationModel.instance:getGameMapSize()
	local isMove = false

	for j = 1, size.y do
		local from_y, from_x, to_y, to_x = -1, -1, -1, -1

		if self._cellArr[j][i]._type == -1 and self._cellArr[j - 1] then
			if self._cellArr[j - 1][i - 1] and not ThreeEliminationModel.instance:isStoodType(self._cellArr[j - 1][i - 1]._type) and self._cellArr[j - 1][i - 1]._type ~= SxGameCellType.Empty then
				to_x = i
				to_y = j
				from_x = i - 1
				from_y = j - 1
			elseif self._cellArr[j - 1][i + 1] and not ThreeEliminationModel.instance:isStoodType(self._cellArr[j - 1][i + 1]._type) and self._cellArr[j - 1][i + 1]._type ~= SxGameCellType.Empty then
				to_x = i
				to_y = j
				from_x = i + 1
				from_y = j + 1
			elseif ThreeEliminationModel.instance:isStoodType(self._cellArr[j - 1][i + 1]._type) and ThreeEliminationModel.instance:isStoodType(self._cellArr[j - 1][i - 1]._type) then
				if self._cellArr[j][i - 1] and not ThreeEliminationModel.instance:isStoodType(self._cellArr[j][i - 1]._type) and self._cellArr[j][i - 1]._type ~= SxGameCellType.Empty then
					to_x = i
					to_y = j
					from_x = i - 1
					from_y = j
				elseif self._cellArr[j][i + 1] and not ThreeEliminationModel.instance:isStoodType(self._cellArr[j][i + 1]._type) and self._cellArr[j][i + 1]._type ~= SxGameCellType.Empty then
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

			ThreeEliminationModel.instance:setCellData(to_x, to_y, self._cells[to_y][to_x]:getType(), self._cells[to_y][to_x]:getAddType())

			self._cells[to_y][to_x]._cellData = self._cellArr[to_y][to_x]

			ThreeEliminationModel.instance:setCellData(from_x, from_y, SxGameCellType.Empty)

			isMove = true
		end
	end

	return isMove
end

function ThreeEliminationView:_checkSupplyCell(i)
	local size = ThreeEliminationModel.instance:getGameMapSize()
	local from_y, count = -1, 0
	local blockIdx = size.y + 1
	local isSupply = false

	for j = 1, size.y do
		if self._cellArr[j][i]._type == SxGameCellType.Block then
			blockIdx = j
		end
	end

	for j = blockIdx - 1, 1, -1 do
		if self._cellArr[j][i]._type == -1 then
			if from_y == -1 then
				count = 0
				from_y = j
			end

			count = count + 1

			if j == 1 then
				self:_supplyCell(i, from_y, count)

				isSupply = true
			end
		end
	end

	return isSupply
end

function ThreeEliminationView:_supplyCell(x, from_y, num)
	local function onMoveCallBack()
		return
	end

	for i = 0, num - 1 do
		local supplyType = ThreeEliminationModel.instance:getSupplyCellType()

		ThreeEliminationModel.instance:setCellData(x, from_y - i, supplyType)

		local mo = self._cellArr[from_y - i][x]
		local _cellType = mo._type
		local cellObj, sxGameCell = self:genarateCell(_cellType, self._cellObjClone, mo)

		cellObj.transform.localPosition = Vector3.New(self._x_space * (x - 1), self._y_space * (5 - from_y + i))

		sxGameCell:onBuildAction(onMoveCallBack)

		self._cells[from_y - i][x] = sxGameCell
	end
end

function ThreeEliminationView:_checkContinue()
	ThreeEliminationController.instance:continueFindScore()
end

function ThreeEliminationView:_nextStep()
	ThreeEliminationModel.instance:reduceStep()
end

function ThreeEliminationView:_onNormalEffect(cellGo, callback)
	local effName = "fx_ui_zhuangbeijiemian/fx_ui_fangru_zhuangbei.prefab"
	local effect = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, false, false, callback)

	effect:setScale(1)
	effect:setParent(cellGo.transform)
	effect:setLocalPos(0, 0, 0)
end

function ThreeEliminationView:_onSpecialEffect(operateMo, callback)
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

function ThreeEliminationView:_showFlyEffect(x, y, type)
	if self._moveEffectToList[y] and self._moveEffectToList[y][x] and self._moveEffectToList[y][x] >= 2 then
		local time = 0.1

		for i = 1, self._moveEffectToList[y][x] - 1 do
			local cellGo = self._cells[y][x]._container.gameObject
			local pos = self._container.transform.localPosition + cellGo.transform.localPosition

			GlobalDispatcher:dispatch(GlobalNotify.ThreeEliminationEffectFly, pos, time, type)
		end
	end
end

function ThreeEliminationView:_onCombo()
	local cellObj = self:getResInstance("effect/prefabs/ui/fx_ui_sanxiao/fx_ui_sanxiao_combo.prefab")

	if cellObj then
		local sxGameCombo = Framework.LuaComponentContainer.Add(cellObj, SxGameCombo)

		sxGameCombo:setCombo(ThreeEliminationModel.instance:getCombo())
	end

	if ThreeEliminationModel.instance:getCombo() == 5 then
		local cellObj = self:getResInstance("effect/prefabs/ui/fx_ui_sanxiao/fx_ui_sanxiao_amazing.prefab")

		if cellObj then
			local sxGameCombo = Framework.LuaComponentContainer.Add(cellObj, SxGameAmazing)
		end
	end
end

function ThreeEliminationView:testCell()
	for i = 1, 8 do
		local str = " "

		for j = 1, 8 do
			str = str .. " " .. self._cells[i][j]._cellData._type

			printInfo("x:" .. self._cells[i][j]._cellData._x .. ",y:" .. self._cells[i][j]._cellData._y)
		end
	end
end

function ThreeEliminationView:_onCellMoveStart(go, cell)
	self._moveCell = cell
	self._moveGo = go

	go.transform:SetAsLastSibling()
end

function ThreeEliminationView:_onCellMove(pos)
	for i, v in pairs(self._cells) do
		for j, k in pairs(v) do
			if self._moveGo == k._container.gameObject then
				-- block empty
			elseif k:checkHit(pos) == true then
				k:setHitScale()

				self._scaleCellMap[k] = true
			else
				k:resetScale()

				self._scaleCellMap[k] = nil
			end
		end
	end
end

function ThreeEliminationView:_onCellMoveEnd(pos)
	local isHitCell = false

	for i, v in pairs(self._cells) do
		for j, k in pairs(v) do
			if self._moveGo ~= k._container.gameObject and k:checkHit(pos) == true then
				k:setSwapCell()

				isHitCell = true
			end
		end
	end

	local isNeedFree = false
	local checkPos = pos + GameUtil.getLocalPos(self._container)
	local freeAreaPos = GameUtil.getLocalPos(self._freeCellAreaObj)
	local rectTf = self._freeCellAreaObj:GetComponent(typeof(UnityEngine.RectTransform))

	if self._freeCellAreaObj and checkPos.x > freeAreaPos.x - rectTf.rect.width / 2 and checkPos.x < freeAreaPos.x + rectTf.rect.width / 2 and checkPos.y > freeAreaPos.y - rectTf.rect.height / 2 and checkPos.y < freeAreaPos.y + rectTf.rect.height / 2 then
		isNeedFree = true

		ThreeEliminationController.instance:addAction(ThreeEliminationModel.instance:getFreeMo())
	end

	if not isHitCell and not isNeedFree then
		ThreeEliminationModel.instance:removeAction()
		ThreeEliminationController.instance:defaultState()
	end

	for i, v in pairs(self._cells) do
		for j, k in pairs(v) do
			self._scaleCellMap[k] = nil

			k:resetScale()
		end
	end

	self._moveGo = nil
	self._moveCell = nil
end

function ThreeEliminationView:_PM_ThreeEliminationGameOpenFuncRes()
	self._cellArr = ThreeEliminationModel.instance:getGameMapArr()

	ThreeEliminationModel.instance:removeAction()
	ThreeEliminationModel.instance:setSupplyList()

	self._cells = {}

	self:_initCells()
end

return ThreeEliminationView
