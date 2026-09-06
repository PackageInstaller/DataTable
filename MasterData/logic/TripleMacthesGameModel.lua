-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/triplemacthesgame/model/TripleMacthesGameModel.lua

module("logic.extensions.triplemacthesgame.model.TripleMacthesGameModel", package.seeall)

local TripleMacthesGameModel = class("TripleMacthesGameModel", BaseModel)

TripleMacthesGameModel.MaxStep = 20
TripleMacthesGameModel.ALL_TYPES = {
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
TripleMacthesGameModel.RAND_TYPES = {
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

function TripleMacthesGameModel:ctor()
	self._mapCells = {}
	self._lvlCfg = nil
	self._map_size = Vector2.New(8, 8)
	self._actionArray = Array.New()
	self._removeOperate = Array.New()
	self._needResetCell = Array.New()
	self._skillArray = Array.New()
	self._combo = 0
	self._step = 0
	self._clientKey = 0
	self._severKey = 0
	self._formulaCnts = nil
	self._willRemoveCount = 0
	self._initReady = false
	self.scoreTypes = {}
	self._stageId = nil
	self._activityId = nil
	self._isWaittingMoveRes = nil
	self._createCellType = {}
	self._removeCellType = {}
	self._supplyCellType = {}
	self._preRemoveCell = {}
	self._supplyCellCount = 0
	self._noRemoveType = {}
	self._stoodType = {}
	self._iceList = Array.New()
	self._iceSpecialList = Array.New()
	self._effectMap = {}
	self._removeGroup = {}
	self._groupIndexAdd = 0
	self._canRemoveType = {
		[SxGameCellType.Red] = true,
		[SxGameCellType.Yellow] = true,
		[SxGameCellType.Green] = true,
		[SxGameCellType.Purple] = true,
		[SxGameCellType.Blue] = true
	}
	self._noRemoveType = {
		[SxGameCellType.Block] = true,
		[SxGameCellType.Empty] = true,
		[SxGameCellType.EmptyShow] = true
	}
	self._specialType = {
		[SxGameCellType.Flash] = true,
		[SxGameCellType.Bloom] = true,
		[SxGameCellType.FlashShu] = true,
		[SxGameCellType.RainbowBall] = true,
		[SxGameCellType.Fly] = true
	}
	self._collectionType = {
		[SxGameCellType.MoveForward] = true,
		[SxGameCellType.MoveBack] = true,
		[SxGameCellType.Collection1] = true,
		[SxGameCellType.Collection2] = true,
		[SxGameCellType.Collection3] = true,
		[SxGameCellType.Collection4] = true
	}
end

function TripleMacthesGameModel:onInit()
	self:onReset()
end

function TripleMacthesGameModel:onReset()
	self._remainCnt = nil
	self._isWaittingMoveRes = nil
	self._removeCellType = {}
	self._createCellType = {}
	self._supplyCellType = {}
	self._preRemoveCell = {}
	self._effectMap = {}

	self._iceList:Clear()
	self._iceSpecialList:Clear()

	self._supplyCellCount = 0
end

function TripleMacthesGameModel:initGameMapArr(activityId, stageId, lvl)
	self._step = 0

	local stageCfg

	self._lvlCfg = TripleMacthesGameConfigureMO.New((activityId and stageId or nil) and TripleMachesGameConfig.instance:getStageCfg(activityId, stageId))
	self._stageId = stageId
	self._activityId = activityId

	local idx = math.random(1, #TripleMacthesGameModel.ALL_TYPES)
	local t_idx = math.random(1, #TripleMacthesGameModel.RAND_TYPES)
	local arr = TripleMacthesGameModel.ALL_TYPES[idx]
	local types = TripleMacthesGameModel.RAND_TYPES[t_idx]

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
	self._createCellType = {}
	self._supplyCellType = {}
	self._preRemoveCell = {}
	self._effectMap = {}
	self._supplyCellCount = 0
	self._initReady = true
end

function TripleMacthesGameModel:getMapInfo(activityId, stageId)
	self._stageId = stageId
	self._activityId = activityId
end

function TripleMacthesGameModel:initGameMapArrFromMsg(activityId, stageInfo)
	if activityId then
		self._activityId = activityId
	end

	self._step = 0

	if stageInfo and stageInfo.stageId == self._stageId and stageInfo.pieceIds then
		local stageCfg = TripleMachesGameConfig.instance:getStageCfg(self._activityId, self._stageId)

		self._lvlCfg = TripleMacthesGameConfigureMO.New(stageCfg)

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
		local stageCfg = TripleMachesGameConfig.instance:getStageCfg(self._activityId, self._stageId)

		self:resetGameMapByStageCfg(stageCfg)
	end

	self.scoreTypes = {}
	self._initReady = true
end

function TripleMacthesGameModel:resetGameMapByStageCfg(stageCfg)
	self._lvlCfg = TripleMacthesGameConfigureMO.New(stageCfg)

	local layoutCfg = TripleMachesGameConfig.instance:getLayoutInfo(stageCfg.layoutId[math.random(1, #stageCfg.layoutId)])

	for i = 1, self._map_size.y do
		self._mapCells[i] = self._mapCells[i] or {}

		for j = 1, self._map_size.x do
			local mo = self._mapCells[i][j]

			mo = mo or SxGameCellMO.New()
			mo._defualIceCount = self._lvlCfg.defaultIce
			mo._defualBoxCount = self._lvlCfg.defalutBox

			if type(layoutCfg[i].blocksRow[j]) == "number" then
				if checknumber(layoutCfg[i].blocksRow[j]) == SxGameCellType.Box then
					mo._type = SxGameCellType.EmptyShow
					mo._addType = {}

					table.insert(mo._addType, self._lvlCfg.defalutBox)

					mo._isIce = true
				else
					mo._type = checknumber(layoutCfg[i].blocksRow[j])
					mo._addType = {}
					mo._isIce = false
				end
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

	if self._lvlCfg.isRamdonItem then
		local randomList = {}
		local origonList = {}

		for i, v in pairs(self._lvlCfg.supplyLimit) do
			if self._collectionType[v] == true then
				table.insert(randomList, v)
				table.insert(origonList, v)
			end
		end

		GameUtil.permuteArray(randomList)

		local repaceList = {}

		for i = 1, #origonList do
			repaceList[origonList[i]] = randomList[i]
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

	self._removeCellType = {}
	self._createCellType = {}
	self._supplyCellType = {}
	self._preRemoveCell = {}
	self._effectMap = {}
	self._supplyCellCount = 0
end

function TripleMacthesGameModel:reset()
	self._actionArray:Clear()
	self._removeOperate:Clear()
	self._skillArray:Clear()

	self._combo = 0
	self._step = 0
	self._giftArr = {}
	self._clientKey = 0
	self._initReady = false
	self.scoreTypes = {}
end

function TripleMacthesGameModel:showMap()
	for i = 1, self._map_size.y do
		local str = " "

		for j = 1, self._map_size.x do
			str = str .. " " .. self._mapCells[i][j]:typeToString()
		end

		printInfo(str)
	end
end

function TripleMacthesGameModel:randomClientKey()
	self._clientKey = math.random(1, 100000)

	return self._clientKey
end

function TripleMacthesGameModel:getClientKey()
	return self._clientKey
end

function TripleMacthesGameModel:setServerKey(key)
	self._severKey = key
end

function TripleMacthesGameModel:getServerKey()
	return self._severKey
end

function TripleMacthesGameModel:getGameMapArr()
	return self._mapCells
end

function TripleMacthesGameModel:getSpecialCell()
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

function TripleMacthesGameModel:getGameMapSize()
	return self._map_size
end

function TripleMacthesGameModel:getCurStep()
	return self._step
end

function TripleMacthesGameModel:reduceStep()
	self._step = self._step + 1
end

function TripleMacthesGameModel:getActions()
	return self._actionArray
end

function TripleMacthesGameModel:addAction(actionData)
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

function TripleMacthesGameModel:addActionByGuest(x, y)
	if self._mapCells[y] and self._mapCells[y][x] then
		return (self:addAction(self._mapCells[y][x]))
	end

	return false
end

function TripleMacthesGameModel:removeAction()
	self._actionArray:ForEach(function(action, index)
		if action then
			GlobalDispatcher:dispatch(GlobalNotify.SxCellDeSel, action._x, action._y)
		end
	end)
	self._actionArray:Clear()
end

function TripleMacthesGameModel:exchangeAction()
	self._actionArray:PushBack(self._actionArray:PopFront())
end

function TripleMacthesGameModel:swapCellData()
	local preCell = self._actionArray:Get(0)
	local afterCell = self._actionArray:Get(1)

	self._mapCells[preCell._y][preCell._x]._type = afterCell._type

	self._mapCells[preCell._y][preCell._x]:initCell()

	self._mapCells[afterCell._y][afterCell._x]._type = preCell._type

	self._mapCells[afterCell._y][afterCell._x]:initCell()
end

function TripleMacthesGameModel:setCellData(x, y, type, addType)
	self._mapCells[y][x]._type = type
	self._mapCells[y][x]._addType = addType or {}

	if addType and #addType > 0 then
		local isFind = false

		for i, v in pairs(addType) do
			if v >= SxGameCellAddType.Ice_1 and v <= SxGameCellAddType.Ice_7 then
				isFind = true

				break
			end
		end

		self._mapCells[y][x]._isIce = isFind
	else
		self._mapCells[y][x]._isIce = false
	end

	self._mapCells[y][x]:initCell()
end

function TripleMacthesGameModel:getCellData(x, y)
	return self._mapCells[y][x]
end

function TripleMacthesGameModel:setCombo()
	self._combo = self._combo + 1
end

function TripleMacthesGameModel:getCombo()
	return self._combo
end

function TripleMacthesGameModel:comBoFish(...)
	self._combo = 0
end

function TripleMacthesGameModel:addRemoveCount()
	self._willRemoveCount = self._willRemoveCount + 1
end

function TripleMacthesGameModel:reduceRemoveCount()
	self._willRemoveCount = self._willRemoveCount - 1
end

function TripleMacthesGameModel:getRemoveCount()
	return self._willRemoveCount
end

function TripleMacthesGameModel:setFormulaCnts(formulaCnts)
	self._formulaCnts = formulaCnts
end

function TripleMacthesGameModel:getFormulaCnts()
	return self._formulaCnts
end

function TripleMacthesGameModel:setRemainCnt(remainCnt)
	self._remainCnt = remainCnt
end

function TripleMacthesGameModel:getRemainCnt()
	return self._remainCnt
end

function TripleMacthesGameModel:getRemoveGroup()
	return self._removeGroup or {}
end

function TripleMacthesGameModel:resetRemoveGroup()
	self._removeGroup = self._removeGroup and table.clear(self._removeGroup) or {}
end

function TripleMacthesGameModel:checkRemoveDataAll()
	local hasCheckArr = {}
	local canRemoveTag1 = false
	local canRemoveTag2 = false
	local canRemoveTag3 = false
	local c1 = false
	local c2 = false

	self._removeGroup = self._removeGroup and table.clear(self._removeGroup) or {}
	canRemoveTag1, hasCheckArr, c1 = self:checkAllLines(hasCheckArr, 1, self._map_size.x, self._map_size.y, true)
	canRemoveTag2, hasCheckArr, c2 = self:checkAllLines(hasCheckArr, 1, self._map_size.y, self._map_size.x)
	canRemoveTag3, hasCheckArr = self:checkAllMatrix(hasCheckArr, 2, 2)

	local can = canRemoveTag1 or canRemoveTag2 or canRemoveTag3

	if self._initReady then
		for i = 1, #hasCheckArr do
			local mo = hasCheckArr[i]

			self:AddRemoveOp(mo._x, mo._y)
		end
	end

	return can
end

function TripleMacthesGameModel:checkAllLines(hasCheckArr, fo, to, len, isRev)
	local maxCount = 0

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

			if type ~= lastType or not self:isCanRemoveType(type) or self:isIce(act._x, act._y) == true then
				isIce = self:isIce(act._x, act._y)

				if #tem >= 3 then
					canRemoveTag = true

					table.insert(self.scoreTypes, lastType)

					if #tem > 3 and maxCount < #tem then
						maxCount = #tem
					end

					for k = 1, #tem do
						local mo = tem[k]

						if table.indexof(hasCheckArr, mo) == false then
							table.insert(hasCheckArr, mo)
						end
					end

					self:mixRemoveGroupInCheckLine(tem, isRev)
				end

				tem = {}
			end

			lastType = isIce == true and -1 or act._type

			table.insert(tem, act)
		end

		if #tem >= 3 then
			canRemoveTag = true

			table.insert(self.scoreTypes, lastType)

			if #tem > 3 and maxCount < #tem then
				maxCount = #tem
			end

			for k = 1, #tem do
				local mo = tem[k]

				if table.indexof(hasCheckArr, mo) == false then
					table.insert(hasCheckArr, mo)
				end

				self:mixRemoveGroupInCheckLine(tem, isRev)
			end
		end
	end

	return canRemoveTag, hasCheckArr, maxCount
end

function TripleMacthesGameModel:mixRemoveGroupInCheckLine(moList, isShu)
	local group = TripleMacthesGameRemoveGroupMO.New()

	if isShu then
		group.maxCount1 = #moList
		group.maxCount2 = 0
	else
		group.maxCount1 = 0
		group.maxCount2 = #moList
	end

	group.totalNum = 0

	for i, mo in ipairs(moList) do
		if not self._removeGroup[mo] then
			self._removeGroup[mo] = group

			table.insert(group.mos, mo)

			group.totalNum = group.totalNum + 1
		elseif self._removeGroup[mo] ~= group then
			local findGroup = self._removeGroup[mo]

			if isShu then
				group.maxCount1 = math.max(group.maxCount1, findGroup.maxCount1)
			else
				group.maxCount2 = math.max(group.maxCount2, findGroup.maxCount2)
			end

			for j, v in ipairs(findGroup.mos) do
				table.insert(group.mos, v)

				group.totalNum = group.totalNum + 1
				self._removeGroup[v] = group
			end

			if findGroup.hasMatx == true then
				group.hasMatx = true
			end
		end
	end
end

function TripleMacthesGameModel:checkAllMatrix(hasCheckArr, width, heigh)
	local canRemoveTag = false

	for i = 1, self._map_size.y do
		for j = 1, self._map_size.x do
			local removeTag
			local var_43_0, var_43_1 = self:checkMatrix(hasCheckArr, j, i, width, heigh)

			hasCheckArr = var_43_1

			if var_43_0 == true then
				canRemoveTag = true
			end
		end
	end

	return canRemoveTag, hasCheckArr
end

function TripleMacthesGameModel:checkMatrix(hasCheckArr, formX, formY, width, heigh)
	local canRemoveTag = false

	hasCheckArr = hasCheckArr or {}

	if formX > 0 and formY > 0 and formX + width - 1 <= self._map_size.x and formY + heigh - 1 <= self._map_size.y then
		local lastType = -1
		local tem = {}

		canRemoveTag = true

		for i = formY, formY + heigh - 1 do
			for j = formX, formX + width - 1 do
				local mo = self._mapCells[i][j]

				if lastType == -1 then
					lastType = mo._type
				end

				if mo._type == lastType and not self:isIce(j, i) and self:isCanRemoveType(mo._type) == true then
					table.insert(tem, mo)
				else
					canRemoveTag = false

					break
				end
			end

			if not canRemoveTag then
				break
			end
		end

		if canRemoveTag == true then
			for k = 1, #tem do
				local mo = tem[k]

				if table.indexof(hasCheckArr, mo) == false then
					table.insert(hasCheckArr, mo)
				end

				self:mixRemoveGroupInCheckMatrix(tem, width, heigh)
			end
		end
	end

	return canRemoveTag, hasCheckArr
end

function TripleMacthesGameModel:mixRemoveGroupInCheckMatrix(moList, width, heigh)
	local group = TripleMacthesGameRemoveGroupMO.New()

	group.totalNum = 0
	group.maxCount1 = 0
	group.maxCount2 = 0
	group.hasMatx = true

	for i, mo in ipairs(moList) do
		if not self._removeGroup[mo] then
			self._removeGroup[mo] = group

			table.insert(group.mos, mo)

			group.totalNum = group.totalNum + 1
		elseif self._removeGroup[mo] ~= group then
			local findGroup = self._removeGroup[mo]

			group.maxCount1 = math.max(group.maxCount1, findGroup.maxCount1)
			group.maxCount2 = math.max(group.maxCount2, findGroup.maxCount2)

			for j, v in ipairs(findGroup.mos) do
				table.insert(group.mos, v)

				group.totalNum = group.totalNum + 1
				self._removeGroup[v] = group
			end
		end
	end
end

function TripleMacthesGameModel:clearOperate()
	self._removeOperate:Clear()
end

function TripleMacthesGameModel:getOperate()
	return self._removeOperate
end

function TripleMacthesGameModel:addSpecial(spMo)
	self._createCellType[spMo._type] = (self._createCellType[spMo._type] or 0) + 1

	self._skillArray:PushBack(spMo)
end

function TripleMacthesGameModel:getSpecial()
	return self._skillArray
end

function TripleMacthesGameModel:getGiftArr()
	return self._giftArr
end

function TripleMacthesGameModel:calcScore()
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

function TripleMacthesGameModel:removeCellData()
	self._removeOperate:ForEach(function(operateMo, index)
		local type = self._mapCells[operateMo._operatePos.y][operateMo._operatePos.x]._type

		self._removeCellType[type] = (self._removeCellType[type] or 0) + 1
		self._preRemoveCell[type] = (self._preRemoveCell[type] or 0) + 1
		self._mapCells[operateMo._operatePos.y][operateMo._operatePos.x]._type = SxGameCellType.Empty
		self._mapCells[operateMo._operatePos.y][operateMo._operatePos.x]._addType = {}
	end)

	self.scoreTypes = {}

	self._skillArray:ForEach(function(skill)
		self._mapCells[skill._y][skill._x]._type = skill._type
		self._mapCells[skill._y][skill._x]._addType = skill._addType
	end)
end

function TripleMacthesGameModel:AddRemoveOp(changeX, changeY, special, isBySpecial, isByEffect, specialType)
	if self._initReady then
		local cellMo = self._mapCells[changeY][changeX]

		if cellMo._type == SxGameCellType.EmptyShow or cellMo._type == SxGameCellType.Empty then
			return
		end

		local isIce = cellMo._isIce

		if not isByEffect then
			self:effectSpecial(changeX, changeY)
		end

		if not isBySpecial and not isByEffect and not isIce and not self._effectMap[cellMo] then
			self:effectSpecial(changeX - 1, changeY)
			self:effectSpecial(changeX + 1, changeY)
			self:effectSpecial(changeX, changeY - 1)
			self:effectSpecial(changeX, changeY + 1)

			self._effectMap[cellMo] = true
		end

		local specialEffect = self:_isSpecial(cellMo._type)
		local operateMo = SxGameOperateMo.New()

		operateMo:initMO(Vector2.New(changeX, changeY), 0, 0, 0, 0, isBySpecial, specialType, specialEffect, cellMo._type)

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

function TripleMacthesGameModel:AddRemoveOpBySpecial(changeX, changeY, formX, formY, special, isBySpecial, isByEffect, specialType)
	if self._initReady then
		if self._mapCells[changeY][changeX]._type == SxGameCellType.EmptyShow or self._mapCells[changeY][changeX]._type == SxGameCellType.Empty then
			return
		end

		local isIce = self._mapCells[changeY][changeX]._isIce

		if not isByEffect then
			self:effectSpecial(changeX, changeY, formX, formY)
		end

		if not isBySpecial and not isByEffect and not isIce then
			self:effectSpecial(changeX - 1, changeY, formX, formY)
			self:effectSpecial(changeX + 1, changeY, formX, formY)
			self:effectSpecial(changeX, changeY - 1, formX, formY)
			self:effectSpecial(changeX, changeY + 1, formX, formY)
		end

		local specialEffect = self:_isSpecial(self._mapCells[changeY][changeX]._type)
		local operateMo = SxGameOperateMo.New()

		operateMo:initMO(Vector2.New(changeX, changeY), formX, 0, formY, 0, isBySpecial, specialType, specialEffect, self._mapCells[changeY][changeX]._type)

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

function TripleMacthesGameModel:doSpecial(changeX, changeY)
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
				self:AddRemoveOp(changeX, changeY, true, true, false, SxGameCellType.Flash)
			else
				self:AddRemoveOpBySpecial(i, changeY, changeX, changeY, false, true, false, SxGameCellType.Flash)
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
					self:AddRemoveOp(changeX, changeY, true, true, false, SxGameCellType.Bloom)
				else
					self:AddRemoveOpBySpecial(i, j, changeX, changeY, false, true, false, SxGameCellType.Bloom)
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
				self:AddRemoveOp(changeX, changeY, true, true, false, SxGameCellType.FlashShu)
			else
				self:AddRemoveOpBySpecial(changeX, i, changeX, changeY, false, true, false, SxGameCellType.FlashShu)
			end
		end
	end

	if _type == SxGameCellType.RainbowBall then
		local addType = self._mapCells[changeY][changeX]._addType
		local clearCellType = SxGameCellAddType.Red + math.random(0, self._lvlCfg.colorCount - 1)

		for i, v in ipairs(addType) do
			if v >= SxGameCellAddType.Red and v <= SxGameCellAddType.Purple then
				clearCellType = v
			end
		end

		for y = 1, self._map_size.y do
			for x = 1, self._map_size.x do
				if self._mapCells[y][x]._type == clearCellType then
					if self:isIce(x, y) == true then
						self:addIceList(x, y)
						self:clearAllIce()
						self:addIceListBySpeical(x, y, changeX, changeY, SxGameCellType.RainbowBall)
					else
						self:AddRemoveOpBySpecial(x, y, changeX, changeY, false, true, false, SxGameCellType.RainbowBall)
					end
				end
			end
		end

		self:AddRemoveOp(changeX, changeY, true, true, false, SxGameCellType.RainbowBall)
	end

	if _type == SxGameCellType.Fly then
		local addType = self._mapCells[changeY][changeX]._addType
		local clearCellType = SxGameCellAddType.Red + math.random(0, self._lvlCfg.colorCount - 1)

		for i, v in ipairs(addType) do
			if v >= SxGameCellAddType.Red and v <= SxGameCellAddType.Purple then
				clearCellType = v
			end
		end

		local num = self._lvlCfg.flyClearCellCount
		local ramdomCell = {}
		local defaultCell = {}
		local iceReadyCell = {}
		local clearCell = {}

		for y = 1, self._map_size.y do
			for x = 1, self._map_size.x do
				if TripleMacthesGameModel.instance:isCollectionType(self._mapCells[y][x]._type) == true then
					if self:isIce(x, y) == true then
						if num > #iceReadyCell then
							table.insert(iceReadyCell, self._mapCells[y][x])
						elseif math.random() < 1 / num then
							iceReadyCell[math.random(1, num)] = self._mapCells[y][x]
						end
					elseif num > #clearCell then
						table.insert(clearCell, self._mapCells[y][x])
					elseif math.random() < 1 / num then
						clearCell[math.random(1, num)] = self._mapCells[y][x]
					end
				elseif self._mapCells[y][x]._type == clearCellType then
					if num > #defaultCell then
						table.insert(defaultCell, self._mapCells[y][x])
					elseif math.random() < 1 / num then
						defaultCell[math.random(1, num)] = self._mapCells[y][x]
					end
				elseif self._mapCells[y][x]._type >= SxGameCellAddType.Red and self._mapCells[y][x]._type <= SxGameCellAddType.Purple then
					if num > #ramdomCell then
						table.insert(ramdomCell, self._mapCells[y][x])
					elseif math.random() < 1 / num then
						ramdomCell[math.random(1, num)] = self._mapCells[y][x]
					end
				end
			end
		end

		for i = 1, #iceReadyCell do
			table.insert(clearCell, iceReadyCell[i])
		end

		for i = 1, #defaultCell do
			table.insert(clearCell, defaultCell[i])
		end

		for i = 1, #ramdomCell do
			table.insert(clearCell, ramdomCell[i])
		end

		for i = 1, num do
			if clearCell[i] then
				if self:isIce(clearCell[i]._x, clearCell[i]._y) then
					self:addIceList(clearCell[i]._x, clearCell[i]._y)
					self:addIceListBySpeical(clearCell[i]._x, clearCell[i]._y, changeX, changeY, SxGameCellType.Fly)
				else
					self:AddRemoveOpBySpecial(clearCell[i]._x, clearCell[i]._y, changeX, changeY, false, true, false, SxGameCellType.Fly)
				end
			end
		end

		self:AddRemoveOp(changeX, changeY, true, true, false, SxGameCellType.Fly)
	end
end

function TripleMacthesGameModel:_isSpecial(specialType)
	return self._specialType[specialType] or false
end

function TripleMacthesGameModel:checkDataByPoints(changeX, changeY)
	local hasCheckArr = {}
	local canRemoveTag1, canRemoveTag2, canRemoveTag3, canRemoveTag4, canRemoveTag5, canRemoveTag6, c1, c2

	canRemoveTag1, hasCheckArr, c1 = self:checkAllLines(hasCheckArr, changeX, changeX, self._map_size.y, true)
	canRemoveTag2, hasCheckArr, c2 = self:checkAllLines(hasCheckArr, changeY, changeY, self._map_size.x)
	canRemoveTag3, hasCheckArr = self:checkMatrix(hasCheckArr, changeX - 1, changeY - 1, 2, 2)
	canRemoveTag4, hasCheckArr = self:checkMatrix(hasCheckArr, changeX, changeY - 1, 2, 2)
	canRemoveTag5, hasCheckArr = self:checkMatrix(hasCheckArr, changeX - 1, changeY, 2, 2)
	canRemoveTag6, hasCheckArr = self:checkMatrix(hasCheckArr, changeX, changeY, 2, 2)

	local canMatrix = canRemoveTag3 or canRemoveTag4 or canRemoveTag5 or canRemoveTag6
	local type2 = self._mapCells[changeY][changeX]._type
	local tlNum = 0
	local can = canRemoveTag1 or canRemoveTag2 or canMatrix

	for i = 1, #hasCheckArr do
		local mo = hasCheckArr[i]

		self:AddRemoveOp(mo._x, mo._y)

		local type = self._mapCells[mo._y][mo._x]._type

		if type == type2 then
			tlNum = tlNum + 1
		end
	end

	return can, c1 > 3 or c2 > 3 or tlNum >= 5 or canMatrix, c1, c2, tlNum >= 5, canMatrix
end

function TripleMacthesGameModel:JudgeAndGetProsible()
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

function TripleMacthesGameModel:isIce(changeX, changeY)
	return self._mapCells[changeY][changeX]._isIce or false
end

function TripleMacthesGameModel:_clearIce(changeX, changeY)
	local iceIndex = 0

	if self._mapCells[changeY][changeX]._isIce == false then
		return false
	end

	for i, v in pairs(self._mapCells[changeY][changeX]._addType) do
		if v >= SxGameCellAddType.Ice_1 and v <= SxGameCellAddType.Ice_7 then
			iceIndex = i

			break
		end
	end

	if iceIndex > 0 then
		if self._mapCells[changeY][changeX]._addType[iceIndex] == SxGameCellAddType.Ice_1 then
			table.remove(self._mapCells[changeY][changeX]._addType, iceIndex)

			if self._mapCells[changeY][changeX]._type == SxGameCellType.EmptyShow then
				self:AddRemoveOp(changeX, changeY, false, false, true)

				self._mapCells[changeY][changeX]._type = SxGameCellType.Empty
				self._removeCellType[SxGameCellType.Box] = (self._removeCellType[SxGameCellType.Box] or 0) + 1
			else
				self._removeCellType[SxGameCellType.Ice] = ((not self._removeCellType[SxGameCellType.Ice] or nil) and 0) + 1
			end

			self._mapCells[changeY][changeX]._isIce = false
		else
			self._mapCells[changeY][changeX]._addType[iceIndex] = self._mapCells[changeY][changeX]._addType[iceIndex] - 1
		end

		self._needResetCell:PushBack(self._mapCells[changeY][changeX])

		return true
	end

	return false
end

function TripleMacthesGameModel:effectSpecial(changeX, changeY, formX, formY)
	if self._mapCells[changeY] and self._mapCells[changeY][changeX] then
		if self:isIce(changeX, changeY) == true then
			self:addIceList(changeX, changeY)
		elseif self:isCollectionType(self._mapCells[changeY][changeX]._type) then
			if formX and formY then
				local type = self._mapCells[formY][formX]._type

				self:AddRemoveOpBySpecial(changeX, changeY, formX, formY, false, true, true, type)
			else
				self:AddRemoveOp(changeX, changeY, false, true, true)
			end
		end
	end
end

function TripleMacthesGameModel:getNeedResetCell()
	return self._needResetCell
end

function TripleMacthesGameModel:clearNeedResetCell()
	self._needResetCell:Clear()
end

function TripleMacthesGameModel:isNoRemoveType(specialType)
	return self._noRemoveType[specialType] or false
end

function TripleMacthesGameModel:isStoodType(specialType)
	return specialType == SxGameCellType.Block or specialType == SxGameCellType.EmptyShow
end

function TripleMacthesGameModel:isStoodCell(x, y)
	return self:isStoodType(self._mapCells[y][x]._type) or self:isIce(x, y)
end

function TripleMacthesGameModel:isCanRemoveType(type)
	return self._canRemoveType[type] or false
end

function TripleMacthesGameModel:isCollectionType(type)
	return self._collectionType[type] or false
end

function TripleMacthesGameModel:getRemoveCreateItem(c1, c2, tlNum5, matx)
	local res = SxGameCellType.Bloom

	if c1 >= 5 or c2 >= 5 then
		res = SxGameCellType.RainbowBall
	elseif matx == true then
		res = SxGameCellType.Fly
	elseif tlNum5 == true then
		res = SxGameCellType.Bloom
	elseif c1 > 3 then
		res = SxGameCellType.FlashShu
	elseif c2 > 3 then
		res = SxGameCellType.Flash
	end

	return res
end

function TripleMacthesGameModel:getSupplyCellType()
	if self._lvlCfg.useFixSupply > 0 and self._supplyCellCount > 0 and self._supplyCellCount % self._lvlCfg.useFixSupply == 0 and not self._isSupplyLimit then
		local canSupplyType = {}

		for type, number in pairs(self._lvlCfg.supplyLimit) do
			if not self._supplyCellType[type] or number > self._supplyCellType[type] then
				table.insert(canSupplyType, type)
			end
		end

		if #canSupplyType > 0 then
			return canSupplyType[math.random(1, #canSupplyType)]
		end
	end

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

function TripleMacthesGameModel:getSupplyCellAddType(supplyType)
	local res = {}

	if self._lvlCfg:getAddTypeRate(self._lvlCfg.defaultIce) > 0 and supplyType < SxGameCellType.Red + self._lvlCfg.colorCount and supplyType >= SxGameCellType.Red then
		local random = math.random(1, 10000)

		if random < self._lvlCfg:getAddTypeRate(self._lvlCfg.defaultIce) then
			table.insert(res, self._lvlCfg.defaultIce)
		end
	end

	return res
end

function TripleMacthesGameModel:_supplyCell(supplyType, addType)
	self._supplyCellType[supplyType] = (self._supplyCellType[supplyType] or 0) + 1

	if self._canRemoveType[supplyType] == true then
		self._supplyCellCount = self._supplyCellCount + 1
		self._isSupplyLimit = false
	end

	if self._lvlCfg.supplyLimit[supplyType] and self._lvlCfg.supplyLimit[supplyType] > 0 then
		self._isSupplyLimit = true
	end
end

function TripleMacthesGameModel:waitMoveRes()
	self._isWaittingMoveRes = true
end

function TripleMacthesGameModel:getMoveRes()
	self._isWaittingMoveRes = nil
end

function TripleMacthesGameModel:isWaitingMoveRes()
	return self._isWaittingMoveRes
end

function TripleMacthesGameModel:removePreRemoveCell()
	self._preRemoveCell = self._preRemoveCell and table.clear(self._preRemoveCell) or {}
end

function TripleMacthesGameModel:getPreRemoveCell()
	return self._preRemoveCell
end

function TripleMacthesGameModel:getMapArrList()
	local arrList = {}

	for i = 1, self._map_size.y do
		for j = 1, self._map_size.x do
			local mo = self._mapCells[i][j]

			table.insert(arrList, mo:typeToString())
		end
	end

	return arrList
end

function TripleMacthesGameModel:addIceList(changeX, changeY)
	self._iceList:PushBack(self._mapCells[changeY][changeX])
end

function TripleMacthesGameModel:clearAllIce()
	self._iceList:ForEach(function(mo, index)
		self:_clearIce(mo._x, mo._y)
	end)
	self._iceList:Clear()
end

function TripleMacthesGameModel:addIceListBySpeical(changeX, changeY, formX, formY, specialType)
	self._iceSpecialList:PushBack({
		cellData = self._mapCells[changeY][changeX],
		formX = formX,
		formY = formY,
		specialType = specialType
	})
end

function TripleMacthesGameModel:clearAllIceSpeical()
	self._iceSpecialList:Clear()
end

function TripleMacthesGameModel:getAllIceSpeical()
	return self._iceSpecialList
end

function TripleMacthesGameModel:getIconReplaceCfg()
	return self._lvlCfg.blockIconCfg
end

function TripleMacthesGameModel:getIceDefualtCount()
	return self._lvlCfg.defaultIce
end

function TripleMacthesGameModel:getBoxDefualtCount()
	return self._lvlCfg.defalutBox
end

function TripleMacthesGameModel:changeAllEmptyShow(isReverse)
	for i = 1, self._map_size.y do
		for j = 1, self._map_size.x do
			if self._mapCells[i] then
				if not self._mapCells[i][j] then
					local mo

					if mo and not isReverse and mo._type == SxGameCellType.EmptyShow and self:isIce(j, i) == false then
						mo._type = SxGameCellType.Empty
					elseif mo and isReverse == true and mo._type == SxGameCellType.Empty then
						mo._type = SxGameCellType.EmptyShow
					end
				end
			end
		end
	end
end

function TripleMacthesGameModel:getRemoveCellType()
	return self._removeCellType
end

function TripleMacthesGameModel:getCreateCellType()
	return self._createCellType
end

function TripleMacthesGameModel:clearEffectMap()
	table.clear(self._effectMap)
end

function TripleMacthesGameModel:initGameMapArrFromTourArena(activityId, stageId)
	if activityId then
		self._activityId = activityId
	end

	self._step = 0
	self._stageId = stageId

	local stageCfg = TripleMachesGameConfig.instance:getStageCfg(self._activityId, self._stageId)

	self:resetGameMapByStageCfg(stageCfg)

	self.scoreTypes = {}
	self._initReady = true
end

TripleMacthesGameModel.instance = TripleMacthesGameModel.New()

return TripleMacthesGameModel
