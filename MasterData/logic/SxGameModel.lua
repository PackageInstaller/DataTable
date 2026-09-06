-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sxgame/model/SxGameModel.lua

module("logic.extensions.sxgame.model.SxGameModel", package.seeall)

local SxGameModel = class("SxGameModel", BaseModel)

SxGameModel.MaxStep = 20
SxGameModel.ALL_TYPES = {
	{
		{
			4,
			2,
			3,
			3,
			4,
			1,
			2,
			2
		},
		{
			1,
			2,
			2,
			4,
			1,
			4,
			3,
			3
		},
		{
			4,
			1,
			1,
			2,
			3,
			2,
			4,
			2
		},
		{
			2,
			4,
			1,
			4,
			2,
			4,
			1,
			1
		},
		{
			2,
			1,
			2,
			4,
			4,
			1,
			4,
			4
		},
		{
			3,
			2,
			3,
			1,
			1,
			4,
			3,
			4
		},
		{
			4,
			3,
			2,
			4,
			2,
			4,
			3,
			2
		},
		{
			4,
			2,
			1,
			1,
			2,
			3,
			1,
			4
		}
	},
	{
		{
			2,
			1,
			3,
			4,
			3,
			3,
			1,
			4
		},
		{
			4,
			3,
			2,
			1,
			2,
			4,
			4,
			2
		},
		{
			1,
			3,
			3,
			2,
			4,
			1,
			1,
			4
		},
		{
			2,
			4,
			1,
			4,
			4,
			2,
			1,
			1
		},
		{
			4,
			1,
			2,
			1,
			3,
			4,
			4,
			3
		},
		{
			3,
			2,
			4,
			4,
			2,
			2,
			4,
			4
		},
		{
			3,
			3,
			1,
			3,
			4,
			1,
			3,
			4
		},
		{
			2,
			3,
			1,
			1,
			3,
			1,
			3,
			3
		}
	},
	{
		{
			4,
			3,
			4,
			2,
			2,
			3,
			3,
			4
		},
		{
			3,
			3,
			4,
			4,
			2,
			2,
			4,
			1
		},
		{
			3,
			2,
			2,
			3,
			3,
			1,
			1,
			3
		},
		{
			4,
			3,
			3,
			4,
			2,
			3,
			4,
			1
		},
		{
			3,
			3,
			1,
			3,
			1,
			4,
			2,
			3
		},
		{
			3,
			1,
			3,
			1,
			4,
			3,
			1,
			1
		},
		{
			4,
			1,
			1,
			3,
			4,
			2,
			1,
			4
		},
		{
			2,
			4,
			4,
			2,
			1,
			3,
			3,
			2
		}
	}
}
SxGameModel.RAND_TYPES = {
	{
		1,
		2,
		3,
		4
	},
	{
		1,
		3,
		4,
		2
	},
	{
		2,
		1,
		3,
		4
	},
	{
		2,
		3,
		4,
		1
	},
	{
		3,
		4,
		1,
		2
	},
	{
		3,
		4,
		2,
		1
	},
	{
		4,
		1,
		2,
		3
	},
	{
		4,
		2,
		1,
		3
	}
}

function SxGameModel:ctor()
	self._mapCells = {}
	self._lvlCfg = nil
	self._map_size = Vector2.New(8, 8)
	self._actionArray = Array.New()
	self._removeOperate = Array.New()
	self._needResetCell = Array.New()
	self._skillArray = Array.New()
	self._combo = 0
	self._step = SxGameModel.MaxStep
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
	self._canRemoveType = {
		[SxGameCellType.Red] = true,
		[SxGameCellType.Yellow] = true,
		[SxGameCellType.Green] = true,
		[SxGameCellType.Purple] = true,
		[SxGameCellType.Blue] = true
	}
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

function SxGameModel:onInit()
	self:onReset()
end

function SxGameModel:onReset()
	self._remainCnt = nil
	self._isWaittingMoveRes = nil
	self._removeCellType = {}
	self._preRemoveCell = {}
	self._noRemoveType = {}
	self._stoodType = {}

	self._iceList:Clear()
end

function SxGameModel:initGameMapArr(activityId, stageId, lvl)
	self._step = checknumber(MiniGameCollectionConfig.instance:getParamValueByKey("SX_MAX_STEP_PER_GAME"))

	local stageCfg

	self._lvlCfg = SxGameConfigureMO.New((activityId and stageId or nil) and ThreeMatchesGameConfig.instance:getStageCfg(activityId, stageId))
	self._stageId = stageId
	self._activityId = activityId

	local idx = math.random(1, #SxGameModel.ALL_TYPES)
	local t_idx = math.random(1, #SxGameModel.RAND_TYPES)
	local arr = SxGameModel.ALL_TYPES[idx]
	local types = SxGameModel.RAND_TYPES[t_idx]

	for i = 1, #arr do
		local tem = arr[i]

		self._mapCells[i] = self._mapCells[i] or {}

		for j = 1, #tem do
			local mo = self._mapCells[i][j]

			mo = mo or SxGameCellMO.New()
			mo._type = tem[j] == 5 and SxGameCellType.Block or types[tem[j]] + SxGameCellType.Red - 1
			mo._cellRes = nil
			mo._addType = {}
			mo._isIce = false
			mo._x = j
			mo._y = i

			mo:initCell()

			self._mapCells[i][j] = mo
		end
	end

	self.scoreTypes = {}
	self._removeCellType = {}
	self._preRemoveCell = {}
	self._initReady = true
end

function SxGameModel:getMapInfo(activityId, stageId)
	self._stageId = stageId
	self._activityId = activityId
end

function SxGameModel:initGameMapArrFromMsg(activityId, stageInfo)
	if activityId then
		self._activityId = activityId
	end

	self._step = checknumber(MiniGameCollectionConfig.instance:getParamValueByKey("SX_MAX_STEP_PER_GAME"))

	if stageInfo and stageInfo.stageId == self._stageId and stageInfo.pieceIds then
		local stageCfg = ThreeMatchesGameConfig.instance:getStageCfg(self._activityId, self._stageId)

		self._lvlCfg = SxGameConfigureMO.New(stageCfg)

		for i = 1, self._map_size.y do
			self._mapCells[i] = self._mapCells[i] or {}

			for j = 1, self._map_size.x do
				local index = (i - 1) * self._map_size.y + j
				local mo = self._mapCells[i][j]

				mo = mo or SxGameCellMO.New()

				mo:string2Type(stageInfo.pieceIds[index])

				mo._x = j
				mo._y = i

				mo:initCell()

				self._mapCells[i][j] = mo
			end
		end
	elseif self._stageId then
		local stageCfg = ThreeMatchesGameConfig.instance:getStageCfg(self._activityId, self._stageId)

		self:resetGameMapByStageCfg(stageCfg)
	end

	self.scoreTypes = {}
	self._initReady = true
end

function SxGameModel:resetGameMapByStageCfg(stageCfg)
	self._lvlCfg = SxGameConfigureMO.New(stageCfg)

	local layoutCfg = ThreeMatchesGameConfig.instance:getLayoutInfo(stageCfg.layoutId[math.random(1, #stageCfg.layoutId)])

	for i = 1, self._map_size.y do
		self._mapCells[i] = self._mapCells[i] or {}

		for j = 1, self._map_size.x do
			local mo = self._mapCells[i][j]

			mo = mo or SxGameCellMO.New()

			if type(layoutCfg[i].blocksRow[j]) == "number" then
				mo._type = checknumber(layoutCfg[i].blocksRow[j])
				mo._addType = {}
				mo._isIce = false
			elseif type(layoutCfg[i].blocksRow[j]) == "string" then
				mo:string2Type(layoutCfg[i].blocksRow[j])
			end

			mo._x = j
			mo._y = i

			mo:initCell()

			self._mapCells[i][j] = mo
		end
	end

	if self._lvlCfg.isRamdonColor then
		local randomList = {}

		for i = 1, self._lvlCfg.colorCount do
			table.insert(randomList, SxGameCellType.Red + i - 1)
		end

		GameUtil.permuteArray(randomList)

		local repaceList = {}

		for i = 1, self._lvlCfg.colorCount do
			repaceList[SxGameCellType.Red + i - 1] = randomList[i]
		end

		for i = 1, self._map_size.y do
			for j = 1, self._map_size.x do
				if repaceList[self._mapCells[i][j]._type] then
					self._mapCells[i][j]._type = repaceList[self._mapCells[i][j]._type]

					self._mapCells[i][j]:initCell()
				end
			end
		end
	end
end

function SxGameModel:reset()
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

function SxGameModel:showMap()
	for i = 1, self._map_size.y do
		local str = " "

		for j = 1, self._map_size.x do
			str = str .. " " .. self._mapCells[i][j]:typeToString()
		end

		printInfo(str)
	end
end

function SxGameModel:randomClientKey()
	self._clientKey = math.random(1, 100000)

	return self._clientKey
end

function SxGameModel:getClientKey()
	return self._clientKey
end

function SxGameModel:setServerKey(key)
	self._severKey = key
end

function SxGameModel:getServerKey()
	return self._severKey
end

function SxGameModel:getGameMapArr()
	return self._mapCells
end

function SxGameModel:getSpecialCell()
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

function SxGameModel:getGameMapSize()
	return self._map_size
end

function SxGameModel:getCurStep()
	return self._step
end

function SxGameModel:getRunStep()
	return SxGameModel.MaxStep - self._step
end

function SxGameModel:reduceStep()
	self._step = math.max(self._step - 1, 0)

	if self._step == 0 then
		-- block empty
	end
end

function SxGameModel:getActions()
	return self._actionArray
end

function SxGameModel:addAction(actionData)
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
		GlobalDispatcher:dispatch(GlobalNotify.SxCellSel)

		return false
	elseif GameUtil.getVector2Distance(Vector2.New(preAction._x, preAction._y), Vector2.New(actionData._x, actionData._y)) > 1 then
		GlobalDispatcher:dispatch(GlobalNotify.SxCellDeSel, preAction._x, preAction._y)
		self._actionArray:Clear()
		self._actionArray:PushBack(TableUtil.deepcopy(actionData))
		GlobalDispatcher:dispatch(GlobalNotify.SxCellSel)

		return true
	end

	self._actionArray:PushBack(TableUtil.deepcopy(actionData))
	GlobalDispatcher:dispatch(GlobalNotify.SxCellSel)

	return true
end

function SxGameModel:addActionByGuest(x, y)
	if self._mapCells[y] and self._mapCells[y][x] then
		return (self:addAction(self._mapCells[y][x]))
	end

	return false
end

function SxGameModel:removeAction()
	self._actionArray:ForEach(function(action, index)
		if action then
			GlobalDispatcher:dispatch(GlobalNotify.SxCellDeSel, action._x, action._y)
		end
	end)
	self._actionArray:Clear()
end

function SxGameModel:exchangeAction()
	self._actionArray:PushBack(self._actionArray:PopFront())
end

function SxGameModel:swapCellData()
	local preCell = self._actionArray:Get(0)
	local afterCell = self._actionArray:Get(1)

	self._mapCells[preCell._y][preCell._x]._type = afterCell._type

	self._mapCells[preCell._y][preCell._x]:initCell()

	self._mapCells[afterCell._y][afterCell._x]._type = preCell._type

	self._mapCells[afterCell._y][afterCell._x]:initCell()
end

function SxGameModel:setCellData(x, y, type, addType)
	self._mapCells[y][x]._type = type
	self._mapCells[y][x]._addType = addType or {}
	self._mapCells[y][x]._isIce = not not (addType and #addType > 0)

	self._mapCells[y][x]:initCell()
end

function SxGameModel:setCombo()
	self._combo = self._combo + 1
end

function SxGameModel:getCombo()
	return self._combo
end

function SxGameModel:comBoFish(...)
	self._combo = 0
end

function SxGameModel:addRemoveCount()
	self._willRemoveCount = self._willRemoveCount + 1
end

function SxGameModel:reduceRemoveCount()
	self._willRemoveCount = self._willRemoveCount - 1
end

function SxGameModel:getRemoveCount()
	return self._willRemoveCount
end

function SxGameModel:setFormulaCnts(formulaCnts)
	self._formulaCnts = formulaCnts
end

function SxGameModel:getFormulaCnts()
	return self._formulaCnts
end

function SxGameModel:setRemainCnt(remainCnt)
	self._remainCnt = remainCnt
end

function SxGameModel:getRemainCnt()
	return self._remainCnt
end

function SxGameModel:JudgeAndGetRemoveDataAll()
	local canRemoveTag = false

	for i = 1, self._map_size.y do
		for j = 1, self._map_size.x do
			local start_x, end_x, start_y, end_y, canRemove = self:JudgeAndGetRemoveDataByPoints(j, i)

			if canRemove then
				canRemoveTag = true
			end
		end
	end

	return canRemoveTag
end

function SxGameModel:checkRemoveDataAll()
	local hasCheckArr = {}
	local canRemoveTag1 = false
	local canRemoveTag2 = false
	local c1 = false
	local c2 = false

	canRemoveTag1, hasCheckArr, c1 = self:checkAllLines(hasCheckArr, 1, self._map_size.y, self._map_size.x)
	canRemoveTag2, hasCheckArr, c2 = self:checkAllLines(hasCheckArr, 1, self._map_size.x, self._map_size.y, true)

	local can = canRemoveTag1 or canRemoveTag2

	if self._initReady then
		for i = 1, #hasCheckArr do
			local mo = hasCheckArr[i]

			self:AddRemoveOp(mo._x, mo._y)
		end
	end

	return can
end

function SxGameModel:checkAllLines(hasCheckArr, fo, to, len, isRev)
	local createSpecial = false

	fo = fo or 1
	hasCheckArr = hasCheckArr or {}

	local canRemoveTag = false
	local tem = {}

	for i = fo, to do
		local lastType = -1

		for j = 1, len do
			local act = isRev and self._mapCells[j][i] or self._mapCells[i][j]
			local type = act._type
			local isIce = false

			if type ~= lastType or self:isCanRemoveType(type) == false or self:isIce(act._x, act._y) == true then
				isIce = self:isIce(act._x, act._y)

				if #tem >= 3 then
					canRemoveTag = true

					table.insert(self.scoreTypes, lastType)

					if #tem > 3 then
						createSpecial = true
					end

					for k = 1, #tem do
						local mo = tem[k]

						if table.indexof(hasCheckArr, mo) == false then
							table.insert(hasCheckArr, mo)
						end
					end
				end

				tem = {}
			end

			lastType = isIce == true and -1 or act._type

			table.insert(tem, act)
		end

		if #tem >= 3 then
			canRemoveTag = true

			table.insert(self.scoreTypes, lastType)

			if #tem > 3 then
				createSpecial = true
			end

			for k = 1, #tem do
				local mo = tem[k]

				if table.indexof(hasCheckArr, mo) == false then
					table.insert(hasCheckArr, mo)
				end
			end
		end
	end

	return canRemoveTag, hasCheckArr, createSpecial
end

function SxGameModel:clearOperate()
	self._removeOperate:Clear()
end

function SxGameModel:getOperate()
	return self._removeOperate
end

function SxGameModel:addSpecial(spMo)
	self._skillArray:PushBack(spMo)
end

function SxGameModel:getSpecial()
	return self._skillArray
end

local giftRate = {
	[SxGameCellType.Red] = 1,
	[SxGameCellType.Yellow] = 1,
	[SxGameCellType.Blue] = 1,
	[SxGameCellType.Green] = 1,
	[SxGameCellType.Purple] = 1
}

function SxGameModel:randomGift(type)
	if giftRate[type] and math.random() <= giftRate[type] then
		self._giftArr[type] = self._giftArr[type] or 0
		self._giftArr[type] = self._giftArr[type] + 1
	end
end

function SxGameModel:getGiftArr()
	return self._giftArr
end

function SxGameModel:calcScore()
	local score = 0
	local giftArr = self:getGiftArr()
	local keyList = {
		SxGameCellType.Red,
		SxGameCellType.Green,
		SxGameCellType.Yellow,
		SxGameCellType.Purple
	}

	for _, v in ipairs(keyList) do
		score = score + checknumber(giftArr[v])
	end

	return score
end

function SxGameModel:removeCellData()
	self._removeOperate:ForEach(function(operateMo, index)
		local type = self._mapCells[operateMo._operatePos.y][operateMo._operatePos.x]._type

		self:randomGift(type)

		self._removeCellType[type] = (self._removeCellType[type] or 0) + 1
		self._preRemoveCell[type] = (self._preRemoveCell[type] or 0) + 1
		self._mapCells[operateMo._operatePos.y][operateMo._operatePos.x]._type = -1
	end)

	self.scoreTypes = {}

	self._skillArray:ForEach(function(skill)
		self._mapCells[skill._y][skill._x]._type = skill._type
	end)
end

function SxGameModel:AddRemoveOperate(changeX, changeY, start_x, end_x, start_y, end_y, special, specialType, specialEffect)
	local operateMo = SxGameOperateMo.New()

	operateMo:initMO(Vector2.New(changeX, changeY), start_x, end_x, start_y, end_y, special, specialType, specialEffect, self._mapCells[changeX][changeY]._type)

	if self._initReady and self:_checkRemoveOperate(start_x, end_x, start_y, end_y) then
		if not special then
			if not self:_handleSpecialsRemove(operateMo) then
				self._removeOperate:PushBack(operateMo)
				self:_checkSpecialsRemove(operateMo)
			end
		else
			self._removeOperate:PushBack(operateMo)
			self:_checkSpecialsRemove(operateMo)
		end
	end
end

function SxGameModel:AddRemoveOp(changeX, changeY, special, isBySpecial, isByEffect)
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

		local operateMo = SxGameOperateMo.New()

		operateMo:initMO(Vector2.New(changeX, changeY), 0, 0, 0, 0, special, specialType, specialEffect, self._mapCells[changeY][changeX]._type)

		local has, idx = self._removeOperate:FindByFunc(function(item)
			return item:checkSamePos(operateMo)
		end)

		if not has then
			self._removeOperate:PushBack(operateMo)

			if not special and specialEffect then
				self:doSpecial(changeX, changeY)
			end
		end
	end
end

function SxGameModel:doSpecial(changeX, changeY)
	if not self._mapCells[changeY][changeX] then
		return nil
	end

	local _type = self._mapCells[changeY][changeX]._type

	if _type == SxGameCellType.Flash then
		for i = 1, self._map_size.x do
			if self:isIce(i, changeY) == true then
				self:addIceList(i, changeY)
				self:clearAllIce()
			elseif self:isNoRemoveType(self._mapCells[changeY][i]._type) then
				-- block empty
			elseif i == changeX then
				self:AddRemoveOp(changeX, changeY, true, true)
			else
				self:AddRemoveOp(i, changeY, false, true)
			end
		end
	end

	if _type == SxGameCellType.Bloom then
		local start_x, end_x, start_y, end_y = math.max(changeX - 1, 1), math.min(changeX + 1, self._map_size.x), math.max(changeY - 1, 1), math.min(changeY + 1, self._map_size.y)

		for i = start_x, end_x do
			for j = start_y, end_y do
				if self:isIce(i, j) == true then
					self:addIceList(i, j)
					self:clearAllIce()
				elseif self:isNoRemoveType(self._mapCells[j][i]._type) then
					-- block empty
				elseif i == changeX and j == changeY then
					self:AddRemoveOp(changeX, changeY, true, true)
				else
					self:AddRemoveOp(i, j, false, true)
				end
			end
		end
	end

	if _type == SxGameCellType.FlashShu then
		for i = 1, self._map_size.y do
			if self:isIce(changeX, i) == true then
				self:addIceList(changeX, i)
				self:clearAllIce()
			elseif self:isNoRemoveType(self._mapCells[i][changeX]._type) then
				-- block empty
			elseif i == changeY then
				self:AddRemoveOp(changeX, changeY, true, true)
			else
				self:AddRemoveOp(changeX, i, false, true)
			end
		end
	end
end

function SxGameModel:_handleSpecialsRemove(operateMo)
	if operateMo._remove_to_x - operateMo._remove_from_x + 1 >= 3 and self:_isSpecial(self._mapCells[operateMo._operatePos.y][operateMo._remove_to_x]._type) then
		return true
	end

	if operateMo._remove_to_y - operateMo._remove_from_y + 1 >= 3 and self:_isSpecial(self._mapCells[operateMo._remove_to_y][operateMo._operatePos.x]._type) then
		return true
	end
end

function SxGameModel:_checkSpecialsRemove(operateMo)
	if operateMo._remove_to_x - operateMo._remove_from_x + 1 >= 3 then
		local j = operateMo._operatePos.y

		for i = operateMo._remove_from_x, operateMo._remove_to_x do
			if self:_isSpecial(self._mapCells[j][i]._type) then
				self:JudgeAndGetRemoveDataWithSpecial(i, j)
			end
		end
	end

	if operateMo._remove_to_y - operateMo._remove_from_y + 1 >= 3 then
		local i = operateMo._operatePos.x

		for j = operateMo._remove_from_y, operateMo._remove_to_y do
			if self:_isSpecial(self._mapCells[j][i]._type) then
				self:JudgeAndGetRemoveDataWithSpecial(i, j)
			end
		end
	end
end

function SxGameModel:_isSpecial(specialType)
	return self._specialType[specialType] or false
end

function SxGameModel:_checkRemoveOperate(start_x, end_x, start_y, end_y)
	local _theSame = true

	self._removeOperate:ForEach(function(mo, index)
		if mo._remove_from_x == start_x and mo._remove_from_y == start_y and mo._remove_to_x == end_x and mo._remove_to_y == end_y then
			_theSame = false
		end
	end)

	return _theSame
end

function SxGameModel:JudgeAndGetRemoveDataWithSpecial(changeX, changeY)
	if not self._mapCells[changeY][changeX] then
		return nil
	end

	local _type = self._mapCells[changeY][changeX]._type

	if _type == SxGameCellType.Flash then
		self:AddRemoveOperate(changeX, changeY, 1, 8, changeY, changeY, true, _type, true)

		return 1, 8, changeY, changeY, true, true
	end

	if _type == SxGameCellType.Bloom then
		local start_x, end_x, start_y, end_y = math.max(changeX - 1, 1), math.min(changeX + 1, 8), math.max(changeY - 1, 1), math.min(changeY + 1, 8)

		self:AddRemoveOperate(changeX, math.min(changeY + 1, 8), math.max(changeX - 1, 1), math.min(changeX + 1, 8), math.min(changeY + 1, 8), math.min(changeY + 1, 8), true, _type)
		self:AddRemoveOperate(changeX, changeY, math.max(changeX - 1, 1), math.min(changeX + 1, 8), changeY, changeY, true, _type, true)
		self:AddRemoveOperate(changeX, math.max(changeY - 1, 1), math.max(changeX - 1, 1), math.min(changeX + 1, 8), math.max(changeY - 1, 1), math.max(changeY - 1, 1), true, _type)

		return start_x, end_x, start_y, end_y, true, true
	end

	if _type == SxGameCellType.FlashShu then
		self:AddRemoveOperate(changeX, changeY, changeX, changeX, 1, 8, true, _type, true)

		return changeX, changeX, 1, 8, true, true
	end

	local start_x, end_x, start_y, end_y, canRemove = self:JudgeAndGetRemoveDataByPoints(changeX, changeY)

	return start_x, end_x, start_y, end_y, canRemove
end

function SxGameModel:JudgeSpecialContact(start_x, end_x, start_y, end_y, e_x, e_y)
	for i = start_x, end_x do
		for j = start_y, end_y do
			if i ~= e_x and j ~= e_y then
				self:JudgeAndGetRemoveDataWithSpecial(i, j)
			end
		end
	end
end

function SxGameModel:checkDataByPoints(changeX, changeY)
	local hasCheckArr = {}
	local canRemoveTag1 = false
	local canRemoveTag2 = false
	local c1, c2 = false, false

	canRemoveTag1, hasCheckArr, c1 = self:checkAllLines(hasCheckArr, changeX, changeX, self._map_size.y, true)
	canRemoveTag2, hasCheckArr, c2 = self:checkAllLines(hasCheckArr, changeY, changeY, self._map_size.x)

	local type2 = self._mapCells[changeY][changeX]._type
	local tlNum = 0
	local can = canRemoveTag1 or canRemoveTag2

	for i = 1, #hasCheckArr do
		local mo = hasCheckArr[i]

		self:AddRemoveOp(mo._x, mo._y)

		local type = self._mapCells[mo._y][mo._x]._type

		if type == type2 then
			tlNum = tlNum + 1
		end
	end

	return can, c1 or c2 or tlNum >= 5, c1, c2, tlNum >= 5
end

function SxGameModel:JudgeAndGetRemoveDataByPoints(changeX, changeY)
	if not self._mapCells[changeY][changeX] then
		return nil
	end

	local checkCellType = self._mapCells[changeY][changeX]._type

	if checkCellType == SxGameCellType.Bloom or checkCellType == SxGameCellType.Flash or checkCellType == SxGameCellType.FlashShu then
		return changeX, changeX, changeY, changeY, false
	end

	local start_x = changeX

	while start_x > 0 and self._mapCells[changeY][start_x]._type == checkCellType do
		start_x = start_x - 1
	end

	start_x = start_x + 1

	local end_x = changeX

	while end_x <= self._map_size.x and self._mapCells[changeY][end_x]._type == checkCellType do
		end_x = end_x + 1
	end

	end_x = end_x - 1

	local start_y = changeY

	while start_y > 0 and self._mapCells[start_y][changeX]._type == checkCellType do
		start_y = start_y - 1
	end

	start_y = start_y + 1

	local end_y = changeY

	while end_y <= self._map_size.y and self._mapCells[end_y][changeX]._type == checkCellType do
		end_y = end_y + 1
	end

	end_y = end_y - 1

	local canRemove = false

	if end_x - start_x + 1 >= 3 then
		canRemove = true

		if end_y - start_y + 1 < 3 then
			end_y = changeY
			start_y = changeY
		end
	end

	if end_y - start_y + 1 >= 3 then
		canRemove = true

		if end_x - start_x + 1 < 3 then
			end_x = changeX
			start_x = changeX
		end
	end

	if canRemove then
		self:AddRemoveOperate(changeX, changeY, start_x, end_x, start_y, end_y)
	end

	return start_x, end_x, start_y, end_y, canRemove
end

function SxGameModel:JudgeAndGetProsibleTips()
	for i = 1, self._map_size.y do
		for j = 1, self._map_size.x do
			local checkCell = self._mapCells[i][j]._type

			if i + 1 <= self._map_size.y and checkCell == self._mapCells[i + 1][j]._type then
				if i + 3 <= self._map_size.y and checkCell == self._mapCells[i + 3][j]._type then
					return true
				end

				if j - 1 > 0 and i + 2 <= self._map_size.y and checkCell == self._mapCells[i + 2][j - 1]._type then
					return true
				end

				if j + 1 <= self._map_size.x and i + 2 <= self._map_size.y and checkCell == self._mapCells[i + 2][j + 1]._type then
					return true
				end

				if j - 1 > 0 and i - 1 > 0 and checkCell == self._mapCells[i - 1][j - 1]._type then
					return true
				end

				if j + 1 <= self._map_size.x and i - 1 > 0 and checkCell == self._mapCells[i - 1][j + 1]._type then
					return true
				end

				if i - 2 > 0 and checkCell == self._mapCells[i - 2][j]._type then
					return true
				end
			end

			if self._mapCells[i][j] and self._mapCells[i][j + 1] and self._mapCells[i][j + 1]._type == checkCell then
				if j - 1 > 0 and i + 1 <= self._map_size.y and checkCell == self._mapCells[i + 1][j - 1]._type then
					return true
				end

				if j + 2 <= self._map_size.x and i + 1 <= self._map_size.y and checkCell == self._mapCells[i + 1][j + 1]._type then
					return true
				end

				if j - 2 > 0 and checkCell == self._mapCells[i][j - 2]._type then
					return true
				end

				if j + 3 < self._map_size.y and checkCell == self._mapCells[i][j + 3]._type then
					return true
				end

				if j - 1 > 0 and i - 1 > 0 and checkCell == self._mapCells[i - 1][j - 1]._type then
					return true
				end

				if j + 2 <= self._map_size.x and checkCell == self._mapCells[i][j + 2]._type then
					return true
				end
			end

			if i + 2 < self._map_size.y and checkCell == self._mapCells[i + 2][j]._type then
				if j - 1 > 0 and i + 1 <= self._map_size.y and checkCell == self._mapCells[i + 2][j - 1]._type then
					return true
				end

				if j + 1 <= self._map_size.x and i + 1 < self._map_size.y and checkCell == self._mapCells[i + 1][j + 1]._type then
					return true
				end

				if i + 3 < self._map_size.y and checkCell == self._mapCells[i + 3][j]._type then
					return true
				end

				if i - 1 > 0 and checkCell == self._mapCells[i - 1][j]._type then
					return true
				end
			end

			if j + 2 <= self._map_size.x and checkCell == self._mapCells[i][j + 2]._type then
				if j + 1 <= self._map_size.x and i + 1 <= self._map_size.y and checkCell == self._mapCells[i + 1][j + 1]._type then
					return true
				end

				if j + 1 <= self._map_size.x and i - 1 > 0 and checkCell == self._mapCells[i - 1][j + 1]._type then
					return true
				end

				if j - 1 > 0 and checkCell == self._mapCells[i][j - 1]._type then
					return true
				end

				if j + 3 <= self._map_size.x and checkCell == self._mapCells[i][j + 3]._type then
					return true
				end
			end
		end
	end

	return false
end

function SxGameModel:JudgeAndGetProsible()
	if self:getSpecialCell() then
		return true
	end

	for y = 1, self._map_size.x do
		for x = 1, self._map_size.y do
			if self:isCanRemoveType(self._mapCells[y][x]._type) and not self:isIce(x, y) then
				if self._mapCells[y - 1] and self._mapCells[y - 1][x - 1] and self._mapCells[y - 1][x - 1]._type == self._mapCells[y][x]._type and not self:isIce(x - 1, y - 1) then
					if self._mapCells[y - 2] and self._mapCells[y - 2][x - 1] and self._mapCells[y - 2][x - 1]._type == self._mapCells[y][x]._type and not self:isIce(x - 1, y - 2) then
						return true
					end

					if self._mapCells[y - 1] and self._mapCells[y - 1][x - 2] and self._mapCells[y - 1][x - 2]._type == self._mapCells[y][x]._type and not self:isIce(x - 2, y - 1) then
						return true
					end

					if self._mapCells[y + 1] and self._mapCells[y + 1][x - 1] and self._mapCells[y + 1][x - 1]._type == self._mapCells[y][x]._type and not self:isIce(x - 1, y + 1) then
						return true
					end

					if self._mapCells[y - 1] and self._mapCells[y - 1][x + 1] and self._mapCells[y - 1][x + 1]._type == self._mapCells[y][x]._type and not self:isIce(x + 1, y - 1) then
						return true
					end
				end

				if self._mapCells[y + 1] and self._mapCells[y + 1][x - 1] and self._mapCells[y + 1][x - 1]._type == self._mapCells[y][x]._type and not self:isIce(x - 1, y + 1) then
					if self._mapCells[y + 2] and self._mapCells[y + 2][x - 1] and self._mapCells[y + 2][x - 1]._type == self._mapCells[y][x]._type and not self:isIce(x - 1, y + 2) then
						return true
					end

					if self._mapCells[y + 1] and self._mapCells[y + 1][x - 2] and self._mapCells[y + 1][x - 2]._type == self._mapCells[y][x]._type and not self:isIce(x - 2, y + 1) then
						return true
					end

					if self._mapCells[y + 1] and self._mapCells[y + 1][x + 1] and self._mapCells[y + 1][x + 1]._type == self._mapCells[y][x]._type and not self:isIce(x + 1, y + 1) then
						return true
					end
				end

				if self._mapCells[y + 1] and self._mapCells[y + 1][x + 1] and self._mapCells[y + 1][x + 1]._type == self._mapCells[y][x]._type and not self:isIce(x + 1, y + 1) then
					if self._mapCells[y + 2] and self._mapCells[y + 2][x + 1] and self._mapCells[y + 2][x + 1]._type == self._mapCells[y][x]._type and not self:isIce(x + 1, y + 2) then
						return true
					end

					if self._mapCells[y + 1] and self._mapCells[y + 1][x + 2] and self._mapCells[y + 1][x + 2]._type == self._mapCells[y][x]._type and not self:isIce(x + 2, y + 1) then
						return true
					end

					if self._mapCells[y - 1] and self._mapCells[y - 1][x + 1] and self._mapCells[y - 1][x + 1]._type == self._mapCells[y][x]._type and not self:isIce(x + 1, y - 1) then
						return true
					end
				end

				if self._mapCells[y - 1] and self._mapCells[y - 1][x + 1] and self._mapCells[y - 1][x + 1]._type == self._mapCells[y][x]._type and not self:isIce(x + 1, y - 1) then
					if self._mapCells[y - 2] and self._mapCells[y - 2][x + 1] and self._mapCells[y - 2][x + 1]._type == self._mapCells[y][x]._type and not self:isIce(x + 1, y - 2) then
						return true
					end

					if self._mapCells[y - 1] and self._mapCells[y - 1][x + 2] and self._mapCells[y - 1][x + 2]._type == self._mapCells[y][x]._type and not self:isIce(x + 2, y - 1) then
						return true
					end
				end

				if self._mapCells[y - 3] and self._mapCells[y - 3][x]._type == self._mapCells[y][x]._type and not self:isIce(x, y - 3) and self._mapCells[y - 2][x]._type == self._mapCells[y][x]._type and not self:isIce(x, y - 2) then
					return true
				end

				if self._mapCells[y + 3] and self._mapCells[y + 3][x]._type == self._mapCells[y][x]._type and not self:isIce(x, y + 3) and self._mapCells[y + 2][x]._type == self._mapCells[y][x]._type and not self:isIce(x, y + 2) then
					return true
				end

				if self._mapCells[y][x - 3] and self._mapCells[y][x - 3]._type == self._mapCells[y][x]._type and not self:isIce(x - 3, y) and self._mapCells[y][x - 2]._type == self._mapCells[y][x]._type and not self:isIce(x - 2, y) then
					return true
				end

				if self._mapCells[y][x + 3] and self._mapCells[y][x + 3]._type == self._mapCells[y][x]._type and not self:isIce(x + 3, y) and self._mapCells[y][x + 2]._type == self._mapCells[y][x]._type and not self:isIce(x + 2, y) then
					return true
				end
			end
		end
	end

	return false
end

function SxGameModel:isIce(changeX, changeY)
	return self._mapCells[changeY][changeX]._isIce or false
end

function SxGameModel:_clearIce(changeX, changeY)
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

function SxGameModel:effectSpecial(changeX, changeY)
	if self._mapCells[changeY] and self._mapCells[changeY][changeX] then
		if self:isIce(changeX, changeY) == true then
			self:addIceList(changeX, changeY)
		elseif self._mapCells[changeY][changeX]._type == SxGameCellType.MoveForward then
			self:AddRemoveOp(changeX, changeY, false, true, true)
		elseif self._mapCells[changeY][changeX]._type == SxGameCellType.MoveBack then
			self:AddRemoveOp(changeX, changeY, false, true, true)
		end
	end
end

function SxGameModel:getNeedResetCell()
	return self._needResetCell
end

function SxGameModel:clearNeedResetCell()
	self._needResetCell:Clear()
end

function SxGameModel:isNoRemoveType(specialType)
	return self._noRemoveType[specialType] or false
end

function SxGameModel:isStoodType(specialType)
	return specialType == SxGameCellType.Block
end

function SxGameModel:isCanRemoveType(type)
	return self._canRemoveType[type] or false
end

function SxGameModel:getRemoveCreateItem(c1, c2, tlNum5)
	local res = SxGameCellType.Bloom

	if self._lvlCfg.useRandomSpecial == true then
		res = math.random(1, 3)

		if res == 1 then
			res = SxGameCellType.Bloom
		elseif res == 2 then
			res = SxGameCellType.Flash
		elseif res == 3 then
			res = SxGameCellType.FlashShu
		end
	elseif tlNum5 == true then
		res = SxGameCellType.Bloom
	elseif c1 == true then
		res = SxGameCellType.FlashShu
	elseif c2 == true then
		res = SxGameCellType.Flash
	end

	return res
end

function SxGameModel:getSupplyCellType()
	local randomWeight = math.random(1, self._lvlCfg:getTotalWeight())
	local addWeight = 0
	local res = 0

	for i = 1, self._lvlCfg.colorCount do
		if randomWeight <= addWeight + 1000 then
			res = SxGameCellType.Red + i - 1

			break
		else
			addWeight = addWeight + 1000
		end
	end

	if res == 0 then
		for i, v in ipairs(self._lvlCfg._itemList) do
			res = v

			if randomWeight <= addWeight + self._lvlCfg:getTypeWeight(v) then
				break
			else
				addWeight = addWeight + self._lvlCfg:getTypeWeight(v)
			end
		end
	end

	return res
end

function SxGameModel:getSupplyCellAddType(supplyType)
	local res = {}

	if self._lvlCfg:getAddTypeRate(SxGameCellAddType.Ice_1) > 0 and supplyType < SxGameCellType.Red + SxGameModel.instance._lvlCfg.colorCount and supplyType >= SxGameCellType.Red then
		local random = math.random(1, 10000)

		if random < self._lvlCfg:getAddTypeRate(SxGameCellAddType.Ice_1) then
			table.insert(res, SxGameCellAddType.Ice_1)
		end
	end

	return res
end

function SxGameModel:waitMoveRes()
	self._isWaittingMoveRes = true
end

function SxGameModel:getMoveRes()
	self._isWaittingMoveRes = nil
end

function SxGameModel:isWaitingMoveRes()
	return self._isWaittingMoveRes
end

function SxGameModel:removePreRemoveCell()
	self._preRemoveCell = {}
end

function SxGameModel:getPreRemoveCell()
	return self._preRemoveCell
end

function SxGameModel:getMapArrList()
	local arrList = {}

	for i = 1, self._map_size.y do
		for j = 1, self._map_size.x do
			local mo = self._mapCells[i][j]

			table.insert(arrList, mo:typeToString())
		end
	end

	return arrList
end

function SxGameModel:addIceList(changeX, changeY)
	self._iceList:PushBack(self._mapCells[changeY][changeX])
end

function SxGameModel:clearAllIce()
	self._iceList:ForEach(function(mo, index)
		self:_clearIce(mo._x, mo._y)
	end)
	self._iceList:Clear()
end

SxGameModel.instance = SxGameModel.New()

return SxGameModel
