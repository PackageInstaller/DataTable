-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/threeelimination/model/ThreeEliminationModel.lua

module("logic.extensions.threeelimination.model.ThreeEliminationModel", package.seeall)

local ThreeEliminationModel = class("ThreeEliminationModel", BaseModel)

ThreeEliminationModel.MaxStep = 20

function ThreeEliminationModel:ctor()
	self._mapCells = {}
	self._lvlCfg = nil
	self._map_size = Vector2.New(5, 5)
	self._actionArray = Array.New()
	self._removeOperate = Array.New()
	self._needResetCell = Array.New()
	self._skillArray = Array.New()
	self._combo = 0
	self._step = ThreeEliminationModel.MaxStep
	self._giftArr = {}
	self._clientKey = 0
	self._severKey = 0
	self._formulaCnts = nil
	self._willRemoveCount = 0
	self._initReady = false
	self.scoreTypes = {}
	self._stageId = nil
	self._activityId = nil
	self._isWaittingMoveRes = nil
	self._removeCellType = {}
	self._preRemoveCell = {}
	self._noRemoveType = {}
	self._stoodType = {}
	self._iceList = Array.New()
	self._noRemoveType = {
		[SxGameCellType.Block] = true,
		[SxGameCellType.Empty] = true
	}
	self._specialType = {
		[SxGameCellType.Flash] = true,
		[SxGameCellType.Bloom] = true,
		[SxGameCellType.FlashShu] = true
	}
end

function ThreeEliminationModel:onInit()
	self:onReset()
end

function ThreeEliminationModel:onReset()
	self._remainCnt = nil
	self._isWaittingMoveRes = nil
	self._removeCellType = {}
	self._preRemoveCell = {}
	self._noRemoveType = {}
	self._stoodType = {}

	self._iceList:Clear()

	self._isUseAddSupply = false
	self._supplyList = {}
	self._supplyWeightMap = {}
	self._supplyTotalWeight = 0
	self._increasePet = {}
end

function ThreeEliminationModel:setMapInfo(activityId)
	self._activityId = activityId
end

function ThreeEliminationModel:getActivityId()
	return self._activityId
end

function ThreeEliminationModel:saveInfo(msg)
	self._activityId = msg.activityId

	self:setSupplyList()
	self:initGameMapArrFromMsg(msg)
end

function ThreeEliminationModel:initGameMapArrFromMsg(msg)
	if msg.mapInfo and #msg.mapInfo > 0 then
		for i = 1, self._map_size.y do
			self._mapCells[i] = self._mapCells[i] or {}

			for j = 1, self._map_size.x do
				local index = (i - 1) * self._map_size.y + j
				local mo = self._mapCells[i][j]

				mo = mo or ThreeEliminationCellMO.New()
				mo._type = msg.mapInfo[index]
				mo._x = j
				mo._y = i

				mo:initCell()

				self._mapCells[i][j] = mo
			end
		end
	else
		local actCfg = ThreeEliminationConfig.instance:getActivityCfg(self._activityId)
		local mapCfg = ThreeEliminationConfig.instance:getMapCfg(actCfg.mapId)

		self:resetGameMapByMapCfg(mapCfg)
	end

	self.scoreTypes = {}
	self._initReady = true
end

function ThreeEliminationModel:resetGameMapByMapCfg(mapCfg)
	self._map_size.y = #mapCfg
	self._map_size.x = #mapCfg[1].data

	for i = 1, self._map_size.y do
		self._mapCells[i] = self._mapCells[i] or {}

		for j = 1, self._map_size.x do
			local mo = self._mapCells[i][j]

			mo = mo or ThreeEliminationCellMO.New()
			mo._type = mapCfg[i].data[j]
			mo._x = j
			mo._y = i
			self._mapCells[i][j] = mo
		end
	end
end

function ThreeEliminationModel:reset()
	self._actionArray:Clear()
	self._removeOperate:Clear()
	self._skillArray:Clear()

	self._combo = 0
	self._step = checknumber(MiniGameCollectionConfig.instance:getParamValueByKey("SX_MAX_STEP_PER_GAME"))
	self._giftArr = {}
	self._clientKey = 0
	self._initReady = false
	self.scoreTypes = {}
end

function ThreeEliminationModel:setSupplyList()
	self._supplyList = self._supplyList and table.clear(self._supplyList) or {}
	self._supplyWeightMap = self._supplyWeightMap and table.clear(self._supplyWeightMap) or {}
	self._supplyTotalWeight = 0

	if checknumber(self._activityId) > 0 then
		local petCfgs = ThreeEliminationConfig.instance:getPetCfgs(self._activityId)

		for i, v in pairs(petCfgs) do
			local petWeight = 0

			petWeight = self._isUseAddSupply == true and v.addWeight or v.weight

			if petWeight > 0 then
				table.insert(self._supplyList, v.uniqueId)

				self._supplyWeightMap[v.uniqueId] = petWeight
				self._supplyTotalWeight = self._supplyTotalWeight + petWeight
			end
		end
	end
end

function ThreeEliminationModel:setUseAddSupply(isUse)
	self._isUseAddSupply = isUse
end

function ThreeEliminationModel:showMap()
	for i = 1, self._map_size.y do
		local str = " "

		for j = 1, self._map_size.x do
			str = str .. " " .. self._mapCells[i][j]:typeToString()
		end

		printInfo(str)
	end
end

function ThreeEliminationModel:randomClientKey()
	self._clientKey = math.random(1, 100000)

	return self._clientKey
end

function ThreeEliminationModel:getClientKey()
	return self._clientKey
end

function ThreeEliminationModel:setServerKey(key)
	self._severKey = key
end

function ThreeEliminationModel:getServerKey()
	return self._severKey
end

function ThreeEliminationModel:getGameMapArr()
	return self._mapCells
end

function ThreeEliminationModel:getSpecialCell()
	local spcell

	for i = 1, self._map_size.y do
		for j = 1, self._map_size.x do
			local specialType = self._mapCells[j][i]._type

			if self:_isSpecial(specialType) then
				return self._mapCells[j][i]
			end
		end
	end

	return nil
end

function ThreeEliminationModel:getGameMapSize()
	return self._map_size
end

function ThreeEliminationModel:getCurStep()
	return self._step
end

function ThreeEliminationModel:reduceStep()
	self._step = math.max(self._step - 1, 0)

	if self._step == 0 then
		-- block empty
	end
end

function ThreeEliminationModel:getActions()
	return self._actionArray
end

function ThreeEliminationModel:addAction(actionData)
	if not actionData then
		return false
	end

	if self._actionArray:GetSize() == 0 then
		self._actionArray:PushBack(TableUtil.deepcopy(actionData))
		GlobalDispatcher:dispatch(GlobalNotify.SxCellSel)

		return true
	elseif self._actionArray:GetSize() >= 2 then
		return false
	end

	local preAction = self._actionArray:Get(0)

	if preAction._x == actionData._x and preAction._y == actionData._y then
		self._actionArray:Clear()
		GlobalDispatcher:dispatch(GlobalNotify.SxCellSel)

		return true
	end

	self._actionArray:PushBack(TableUtil.deepcopy(actionData))
	GlobalDispatcher:dispatch(GlobalNotify.SxCellSel)

	return true
end

function ThreeEliminationModel:removeAction()
	self._actionArray:ForEach(function(action, index)
		if action then
			GlobalDispatcher:dispatch(GlobalNotify.SxCellDeSel, action._x, action._y)
		end
	end)
	self._actionArray:Clear()
end

function ThreeEliminationModel:exchangeAction()
	self._actionArray:PushBack(self._actionArray:PopFront())
end

function ThreeEliminationModel:swapCellData()
	local preCell = self._actionArray:Get(0)
	local afterCell = self._actionArray:Get(1)

	self._mapCells[preCell._y][preCell._x]._type = afterCell._type

	self._mapCells[preCell._y][preCell._x]:initCell()

	self._mapCells[afterCell._y][afterCell._x]._type = preCell._type

	self._mapCells[afterCell._y][afterCell._x]:initCell()
end

function ThreeEliminationModel:setCellData(x, y, type)
	self._mapCells[y][x]._type = type

	self._mapCells[y][x]:initCell()
end

function ThreeEliminationModel:setCombo()
	self._combo = self._combo + 1
end

function ThreeEliminationModel:getCombo()
	return self._combo
end

function ThreeEliminationModel:comBoFish()
	self._combo = 0
end

function ThreeEliminationModel:checkRemoveDataAll(activityId)
	local hasCheckArr = {}
	local needRemove = {}
	local needAdd = {}

	for x = 1, self._map_size.x do
		for y = 1, self._map_size.y do
			local removeByStep = {}
			local removeCountPre = #needRemove

			if activityId then
				local cfg = ThreeEliminationConfig.instance:getPetCfg(activityId, self._mapCells[y][x]._type)

				if cfg and cfg.evolvedId <= 0 then
					if table.indexof(hasCheckArr, self._mapCells[y][x]) == false then
						table.insert(hasCheckArr, self._mapCells[y][x])
					end

					local mo = self._mapCells[y][x]
					local isFind = false

					for i, v in pairs(needRemove) do
						if v.mo == mo then
							isFind = true
						end
					end

					if not isFind then
						local info = {
							mo = mo
						}

						table.insert(needRemove, info)
					end
				elseif self:checkDeep(x, y, false, hasCheckArr, needRemove, removeByStep) == true then
					table.insert(needAdd, self._mapCells[y][x])
				end
			elseif self:checkDeep(x, y, false, hasCheckArr, needRemove, removeByStep) == true then
				table.insert(needAdd, self._mapCells[y][x])
			end

			local removeCountAfter = #needRemove
			local removeCount = removeCountAfter - removeCountPre
			local removeType = self._mapCells[y][x]._type

			if removeCount > 0 then
				ThreeEliminationModel.instance:addRemoveByStep(removeType, removeCount)

				if removeCount >= 3 then
					for i, v in ipairs(removeByStep) do
						v.target = self._mapCells[y][x]
					end
				end
			end
		end
	end

	local can = #needRemove > 0

	if self._initReady then
		for i, v in ipairs(needRemove) do
			local mo = v.mo

			if v.target then
				self:AddRemoveOp(mo._x, mo._y, v.target._x, v.target._y)
			else
				self:AddRemoveOp(mo._x, mo._y)
			end
		end
	end

	return can, needAdd
end

function ThreeEliminationModel:checkDeep(x, y, isRemoveSelf, hasCheckArr, needRemove, removeByStep)
	local mo = self._mapCells[y][x]
	local noNeedCheckY = false
	local noNeedCheckX = false
	local isAdd = false

	if table.indexof(hasCheckArr, mo) == false then
		table.insert(hasCheckArr, mo)

		if y <= 1 or y >= self._map_size.y then
			noNeedCheckY = true
		end

		if x <= 1 or x >= self._map_size.x then
			noNeedCheckX = true
		end

		if not noNeedCheckX and self._mapCells[y][x - 1]._type == self._mapCells[y][x]._type and self._mapCells[y][x + 1]._type == self._mapCells[y][x]._type then
			if not isAdd then
				self:_addRemoveInDeepCheck(x, y, needRemove, removeByStep)

				isAdd = true
			end

			self:checkDeep(x + 1, y, true, hasCheckArr, needRemove, removeByStep)
			self:checkDeep(x - 1, y, true, hasCheckArr, needRemove, removeByStep)
		end

		if not noNeedCheckY and self._mapCells[y + 1][x]._type == self._mapCells[y][x]._type and self._mapCells[y - 1][x]._type == self._mapCells[y][x]._type then
			if not isAdd then
				self:_addRemoveInDeepCheck(x, y, needRemove, removeByStep)

				isAdd = true
			end

			self:checkDeep(x, y + 1, true, hasCheckArr, needRemove, removeByStep)
			self:checkDeep(x, y - 1, true, hasCheckArr, needRemove, removeByStep)
		end

		if not noNeedCheckX and not noNeedCheckY then
			if self._mapCells[y + 1][x - 1]._type == self._mapCells[y][x]._type and self._mapCells[y - 1][x + 1]._type == self._mapCells[y][x]._type then
				if not isAdd then
					self:_addRemoveInDeepCheck(x, y, needRemove, removeByStep)

					isAdd = true
				end

				self:checkDeep(x - 1, y + 1, true, hasCheckArr, needRemove, removeByStep)
				self:checkDeep(x + 1, y - 1, true, hasCheckArr, needRemove, removeByStep)
			end

			if self._mapCells[y + 1][x + 1]._type == self._mapCells[y][x]._type and self._mapCells[y - 1][x - 1]._type == self._mapCells[y][x]._type then
				if not isAdd then
					self:_addRemoveInDeepCheck(x, y, needRemove, removeByStep)

					isAdd = true
				end

				self:checkDeep(x + 1, y + 1, true, hasCheckArr, needRemove, removeByStep)
				self:checkDeep(x - 1, y - 1, true, hasCheckArr, needRemove, removeByStep)
			end
		end

		if isRemoveSelf == true and not isAdd then
			self:_addRemoveInDeepCheck(x, y, needRemove, removeByStep)
		end
	end

	if isRemoveSelf == true and not isAdd then
		self:_addRemoveInDeepCheck(x, y, needRemove, removeByStep)
	end

	return isAdd
end

function ThreeEliminationModel:_addRemoveInDeepCheck(x, y, needRemove, removeByStep)
	local mo = self._mapCells[y][x]
	local isFind = false

	for i, v in pairs(needRemove) do
		if v.mo == mo then
			isFind = true
		end
	end

	if not isFind then
		local info = {
			mo = mo
		}

		table.insert(needRemove, info)
		table.insert(removeByStep, info)
	end
end

function ThreeEliminationModel:checkAllLines(hasCheckArr, fo, to, len, isRev)
	fo = fo or 1
	hasCheckArr = hasCheckArr or {}

	local canRemoveTag = false
	local tem = {}

	for i = fo, to do
		local lastType = -1

		for j = 1, len do
			local act = isRev and self._mapCells[j][i] or self._mapCells[i][j]
			local type = act._type

			if type ~= lastType then
				if #tem >= 3 then
					canRemoveTag = true

					table.insert(self.scoreTypes, lastType)

					for k = 1, #tem do
						local mo = tem[k]

						if table.indexof(hasCheckArr, mo) == false then
							table.insert(hasCheckArr, mo)
						end
					end
				end

				tem = {}
			end

			lastType = act._type

			table.insert(tem, act)
		end

		if #tem >= 3 then
			canRemoveTag = true

			table.insert(self.scoreTypes, lastType)

			for k = 1, #tem do
				local mo = tem[k]

				if table.indexof(hasCheckArr, mo) == false then
					table.insert(hasCheckArr, mo)
				end
			end
		end
	end

	return canRemoveTag, hasCheckArr
end

function ThreeEliminationModel:clearOperate()
	self._removeOperate:Clear()
end

function ThreeEliminationModel:getOperate()
	return self._removeOperate
end

function ThreeEliminationModel:addSpecial(spMo)
	self._skillArray:PushBack(spMo)
end

function ThreeEliminationModel:getSpecial()
	return self._skillArray
end

function ThreeEliminationModel:removeCellData()
	self._removeOperate:ForEach(function(operateMo, index)
		local type = self._mapCells[operateMo._operatePos.y][operateMo._operatePos.x]._type

		self._removeCellType[type] = (self._removeCellType[type] or 0) + 1
		self._preRemoveCell[type] = (self._preRemoveCell[type] or 0) + 1
		self._mapCells[operateMo._operatePos.y][operateMo._operatePos.x]._type = SxGameCellType.Empty
	end)

	self.scoreTypes = {}

	self._skillArray:ForEach(function(skill)
		self._mapCells[skill._y][skill._x]._type = skill._type
	end)
end

function ThreeEliminationModel:AddRemoveOp(changeX, changeY, moveToX, moveToY, hideEffect)
	if self._initReady then
		if not isByEffect then
			self:effectSpecial(changeX, changeY)
		end

		if not isBySpecial and not isByEffect then
			self:effectSpecial(changeX - 1, changeY)
			self:effectSpecial(changeX + 1, changeY)
			self:effectSpecial(changeX, changeY - 1)
			self:effectSpecial(changeX, changeY + 1)
		end

		specialType = self._mapCells[changeY][changeX]._type
		specialEffect = self:_isSpecial(specialType)

		local operateMo = ThreeEliminationOperateMo.New()

		operateMo:initMO(Vector2.New(changeX, changeY), moveToX or -1, moveToY or -1, self._mapCells[changeY][changeX]._type)

		local has, idx = self._removeOperate:FindByFunc(function(item)
			return item:checkSamePos(operateMo)
		end)

		operateMo._showEffect = not (hideEffect and hideEffect == true)

		if not has then
			self._removeOperate:PushBack(operateMo)

			if not special and specialEffect then
				-- block empty
			end
		else
			local op = self._removeOperate:Get(idx)

			if op and op._remove_to_x < 0 then
				op._remove_to_x = moveToX or -1
			end

			if op and op._remove_to_y < 0 then
				op._remove_to_y = moveToY or -1
			end
		end
	end
end

function ThreeEliminationModel:_isSpecial(specialType)
	return self._specialType[specialType] or false
end

function ThreeEliminationModel:_checkRemoveOperate(start_x, end_x, start_y, end_y)
	local _theSame = true

	self._removeOperate:ForEach(function(mo, index)
		if mo._remove_from_x == start_x and mo._remove_from_y == start_y and mo._remove_to_x == end_x and mo._remove_to_y == end_y then
			_theSame = false
		end
	end)

	return _theSame
end

function ThreeEliminationModel:checkDataByPoints(changeX, changeY)
	local hasCheckArr = {}
	local needCreate = false
	local changeMo = self._mapCells[changeY][changeX]

	canRemoveTag1, hasCheckArr = self:checkAllLines(hasCheckArr, changeX, changeX, self._map_size.y, true)
	canRemoveTag2, hasCheckArr = self:checkAllLines(hasCheckArr, changeY, changeY, self._map_size.x)
	canRemoveTag3, hasCheckArr = self:checkObliqueLines(hasCheckArr, changeX, changeY)
	canRemoveTag4, hasCheckArr = self:checkObliqueLines(hasCheckArr, changeX, changeY, true)

	local var_48_0 = canRemoveTag1

	if not canRemoveTag1 then
		var_48_0 = canRemoveTag2

		if not canRemoveTag2 then
			var_48_0 = canRemoveTag3

			if not canRemoveTag3 then
				local can = canRemoveTag4

				for i = 1, #hasCheckArr do
					local mo = hasCheckArr[i]

					if mo._x == changeX and mo._y == changeY then
						needCreate = true
					end

					if changeMo._type == mo._type then
						self:AddRemoveOp(mo._x, mo._y, changeX, changeY)
					else
						self:AddRemoveOp(mo._x, mo._y)
					end
				end

				return can, #hasCheckArr, needCreate
			end
		end
	end
end

function ThreeEliminationModel:checkObliqueLines(hasCheckArr, checkX, checkY, isRev)
	hasCheckArr = hasCheckArr or {}

	local canRemoveTag = false
	local baseX, baseY, count

	if not isRev then
		baseX = checkX - math.min(checkX, checkY) + 1
		baseY = checkY - math.min(checkX, checkY) + 1
		count = math.min(self._map_size.x - baseX + 1, self._map_size.y - baseY + 1)
	else
		baseX = checkX - math.min(checkX - 1, self._map_size.y - checkY)
		baseY = checkY + math.min(checkX - 1, self._map_size.y - checkY)
		count = math.min(self._map_size.x - baseX + 1, baseY)
	end

	local tem = {}
	local lastType = -1

	for i = 0, count - 1 do
		local x, y
		local x = baseX + i
		local act = self._mapCells[not isRev and baseY + i or baseY - i][x]
		local type = act._type

		if type ~= lastType then
			if #tem >= 3 then
				canRemoveTag = true

				table.insert(self.scoreTypes, lastType)

				for k = 1, #tem do
					local mo = tem[k]

					if table.indexof(hasCheckArr, mo) == false then
						table.insert(hasCheckArr, mo)
					end
				end
			end

			tem = {}
		end

		lastType = act._type

		table.insert(tem, act)
	end

	if #tem >= 3 then
		canRemoveTag = true

		table.insert(self.scoreTypes, lastType)

		for k = 1, #tem do
			local mo = tem[k]

			if table.indexof(hasCheckArr, mo) == false then
				table.insert(hasCheckArr, mo)
			end
		end
	end

	return canRemoveTag, hasCheckArr
end

function ThreeEliminationModel:isIce(changeX, changeY)
	return self._mapCells[changeY][changeX]._isIce or false
end

function ThreeEliminationModel:_clearIce(changeX, changeY)
	local iceIndex = 0

	if self._mapCells[changeY][changeX]._isIce == false then
		return false
	end

	for i, v in pairs(self._mapCells[changeY][changeX]._addType) do
		if v >= SxGameCellAddType.Ice_1 and v <= SxGameCellAddType.Ice_2 then
			iceIndex = i

			break
		end
	end

	if iceIndex > 0 then
		if self._mapCells[changeY][changeX]._addType[iceIndex] == SxGameCellAddType.Ice_1 then
			table.remove(self._mapCells[changeY][changeX]._addType, iceIndex)

			self._mapCells[changeY][changeX]._isIce = false
		else
			self._mapCells[changeY][changeX]._addType[iceIndex] = self._mapCells[changeY][changeX]._addType[iceIndex] - 1
		end

		self._needResetCell:PushBack(self._mapCells[changeY][changeX])

		return true
	end

	return false
end

function ThreeEliminationModel:effectSpecial(changeX, changeY)
	if self._mapCells[changeY] and self._mapCells[changeY][changeX] then
		if self:isIce(changeX, changeY) == true then
			self:addIceList(changeX, changeY)
		elseif self._mapCells[changeY][changeX]._type == SxGameCellType.MoveForward then
			self:AddRemoveOp(changeX, changeY, 0, 0, false, true, true)
		elseif self._mapCells[changeY][changeX]._type == SxGameCellType.MoveBack then
			self:AddRemoveOp(changeX, changeY, 0, 0, false, true, true)
		end
	end
end

function ThreeEliminationModel:getNeedResetCell()
	return self._needResetCell
end

function ThreeEliminationModel:clearNeedResetCell()
	self._needResetCell:Clear()
end

function ThreeEliminationModel:isNoRemoveType(specialType)
	return self._noRemoveType[specialType] or false
end

function ThreeEliminationModel:isStoodType(specialType)
	return specialType == SxGameCellType.Block
end

function ThreeEliminationModel:getSupplyCellType()
	local randomWeight = math.random(1, self._supplyTotalWeight)
	local addWeight = 0
	local res = 0

	for i = 1, #self._supplyList do
		if randomWeight <= addWeight + self._supplyWeightMap[self._supplyList[i]] then
			res = self._supplyList[i]

			break
		else
			addWeight = addWeight + self._supplyWeightMap[self._supplyList[i]]
		end
	end

	if res == 0 then
		res = SxGameCellType.Empty
	end

	return res
end

function ThreeEliminationModel:getSupplyCellAddType(supplyType)
	return {}
end

function ThreeEliminationModel:waitMoveRes()
	self._isWaittingMoveRes = true
end

function ThreeEliminationModel:getMoveRes()
	self._isWaittingMoveRes = nil
end

function ThreeEliminationModel:isWaitingMoveRes()
	return self._isWaittingMoveRes
end

function ThreeEliminationModel:removePreRemoveCell()
	self._preRemoveCell = {}
end

function ThreeEliminationModel:getPreRemoveCell()
	return self._preRemoveCell
end

function ThreeEliminationModel:addIceList(changeX, changeY)
	self._iceList:PushBack(self._mapCells[changeY][changeX])
end

function ThreeEliminationModel:clearAllIce()
	self._iceList:ForEach(function(mo, index)
		self:_clearIce(mo._x, mo._y)
	end)
	self._iceList:Clear()
end

function ThreeEliminationModel:getFreeMo()
	if not self._freeCellMo then
		self._freeCellMo = ThreeEliminationCellMO.New()
		self._freeCellMo._x = 0
		self._freeCellMo._y = 0
		self._freeCellMo._type = SxGameCellType.Destroy
	end

	return self._freeCellMo
end

function ThreeEliminationModel:addRemoveByStep(type, num)
	if num >= 3 then
		local cfg = ThreeEliminationConfig.instance:getPetCfg(self._activityId, type)

		if cfg.evolvedId > 0 then
			local evolvedCfg = ThreeEliminationConfig.instance:getPetCfg(self._activityId, cfg.evolvedId)

			if evolvedCfg.evolvedId == 0 then
				self._increasePet[cfg.evolvedId] = (self._increasePet[cfg.evolvedId] or 0) + 1
			end
		else
			self._increasePet[type] = ((not self._increasePet[cfg.evolvedId] or nil) and 0) + 1
		end

		self._increasePet[type] = (self._increasePet[type] or 0) + num - 2
	elseif num > 0 then
		self._increasePet[type] = (self._increasePet[type] or 0) + num
	end
end

function ThreeEliminationModel:removeIncreasePet()
	self._increasePet = self._increasePet and table.clear(self._increasePet) or {}
end

function ThreeEliminationModel:getIncreasePet()
	return self._increasePet
end

ThreeEliminationModel.instance = ThreeEliminationModel.New()

return ThreeEliminationModel
