-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Logic\\RearHouse\\RearHouseDragWall.lua

local UIUtils = require("Framework.UI.UIUtils")
local GameSettings = require("Helper/GameSettings")
local ResRearHouseLayer = require("ClientData/ResRearHouseLayer")
local ResRearHouseLevelConfig = require("ClientData/ResRearHouseLevelConfig")
local ResRearHouseLockAreaConfig = require("ClientData/ResRearHouseLockAreaConfig")
local ResRearHouseForbiddenAreaConfig = require("ClientData/ResRearHouseForbiddenAreaConfig")
local RearHouseDragObject = require("Logic/RearHouse/RearHouseDragObject")
local RearHouseDragHero = require("Logic/RearHouse/RearHouseDragHero")
local RearHouseDragShelf = require("Logic/RearHouse/RearHouseDragShelf")
local RearHouseCommon = require("Logic/RearHouse/RearHouseCommon")
local DEFAULT_WALL_PIC_PATH = "Drag/RearHouse/bizhi/hz_bizhi_default"
local RearHouseDragWall = Class("RearHouseDragWall")
local LEFT_OFFSET = 4
local RIGHT_OFFSET = 4
local UP_OFFSET = Const.REARHOUSE_UP_OFFSET
local ROW = 69 + UP_OFFSET
local COLUMN = 65 + LEFT_OFFSET + RIGHT_OFFSET

RearHouseDragWall.ROW = ROW
RearHouseDragWall.COLUMN = COLUMN

local DESK_AVAILABLE_COL = {
	LEFT = {
		12 + LEFT_OFFSET,
		22 + LEFT_OFFSET
	},
	RIGHT = {
		45 + LEFT_OFFSET,
		57 + LEFT_OFFSET
	}
}
local FALL_LAYERS = {
	nil,
	nil,
	nil,
	true,
	true,
	true
}
local NOT_FALL_LAYERS = {
	2,
	3,
	7
}
local CIRCLE_ORDER = {
	8,
	7,
	6,
	4,
	2,
	3,
	1,
	5
}
local STAGE_POS = {
	26 + LEFT_OFFSET,
	30 + LEFT_OFFSET,
	34 + LEFT_OFFSET,
	38 + LEFT_OFFSET,
	42 + LEFT_OFFSET
}
local STAGE_ROW = 64 + UP_OFFSET
local DESK_ROW = 66 + UP_OFFSET
local STAGE_INFO = {
	{
		index = 4553,
		rows = 6,
		columns = 22
	},
	{
		index = 4845,
		rows = 2,
		columns = 22
	}
}

function RearHouseDragWall:ctor(dragCenter, state, zoneName, index)
	self.inited = false
	self.mainState = state
	self.dragCenter = dragCenter
	self.zoneName = zoneName
	self.index = index
	self.zoneId = self.dragCenter.getZoneId(zoneName)
	self.csPanel = UIUtils.InitRearHouseDragCenter(self.zoneName, Slot(self.mCheckPos, self))
	self.transform = self.csPanel.transform
	self.objs = {}
	self.stageObjs = {}
	self.initWallObjs = {}
	self.curDragObj = nil
	self.unlockWall = 0
	self.initLoadNum = 0
	self.lastSaveInfo = {}
	self.occupyDic = {}
	self._initLoadObjs = {}
	self.newPutObjDatas = {}
	self.rows = ROW
	self.limitRows = self.rows - 4
	self.columns = COLUMN
	self.gridSize = Const.REARHOUSE_GRID_SIZE

	local traRoot = self.csPanel.transform.parent

	self:initRoot(traRoot)
	self.csPanel:SetGridCount(self.rows, self.columns, self.gridSize)
	self:initData()
	self:showBack(false)
end

function RearHouseDragWall:initRoot(traRoot)
	traRoot.position = Vector3(traRoot.position.x, traRoot.position.y - 1 * Const.REARHOUSE_GRID_SIZE, traRoot.position.z)
end

function RearHouseDragWall:initData(...)
	self.bounds = {}

	local tra = self.csPanel.transform
	local xOffset = self.columns * self.gridSize * 0.5
	local yOffset = self.rows * self.gridSize * 0.5
	local leftUpPos = Vector2(tra.position.x + xOffset, tra.position.y + yOffset)
	local rightDownPos = Vector2(tra.position.x - xOffset, tra.position.y - yOffset)
	local main = {}

	main.leftUpPos = leftUpPos
	main.rightDownPos = rightDownPos
	self.bounds.main = main

	local edit = {}

	edit.leftUpPos = leftUpPos
	edit.rightDownPos = {}
	edit.rightDownPos.y = rightDownPos.y + 3.5 * self.gridSize
	edit.rightDownPos.x = rightDownPos.x
	self.bounds.edit = edit
	self.bounds.edit.z = tra.position.z
	self.bounds.main.z = tra.position.z
	self.dragCenter.bounds = self.bounds
	self.dragModelRoot = self.csPanel:GetDragModelRoot()
	self.staticModelRoot = self.csPanel:GetStaticModelRoot()

	for i = 1, self.rows do
		self.occupyDic[i] = {}

		for j = 1, self.columns do
			self.occupyDic[i][j] = {
				isLock = true,
				isForbid = false,
				objInfos = {}
			}
		end
	end

	for typeId, layerInfo in pairs(ResRearHouseLayer) do
		self.objs[layerInfo.layer_id] = {}
	end

	self:initForbiddenAreas()
	self:initDeskData()
	self:initCreation()
	self:initUnLockAreas()
end

function RearHouseDragWall:getEffectParentTransform(...)
	return self.transform.parent
end

function RearHouseDragWall:getStageRoot(...)
	if self.transform then
		return self.transform.parent:Find("StageRoot")
	end
end

function RearHouseDragWall:initCreation(...)
	local t = {}
	local oriWidth = self.bounds.main.leftUpPos.x - self.bounds.main.rightDownPos.x
	local oriHeight = self.bounds.main.leftUpPos.y - self.bounds.main.rightDownPos.y

	t.size = Vector2(oriWidth * 1.5, oriHeight * 1.5)

	local data = {}
	local temp = 1
	local lockConfig = self:_getLockInfo()
	local startLevel = RearHouseCommon.getWallUnlockLevel(self.zoneId)
	local endLevel = RearHouseCommon.getNextWallUnlockLevel(self.zoneId)
	local map = {}

	for i = startLevel, endLevel do
		local levelInfo = ResRearHouseLevelConfig[i]

		map[levelInfo.level_part] = map[levelInfo.level_part] or 0
		map[levelInfo.level_part] = map[levelInfo.level_part] + 1

		if levelInfo.unlock_wall == temp then
			local lockInfo = lockConfig[temp]

			if lockInfo then
				local pos = Vector3(lockInfo.index, lockInfo.columns, lockInfo.rows)
				local info = CurAvatar:getRearHouseLevelInfo(i)
				local desc = utils.format(Lang.get(29964), info.bigLv, info.smallLv)

				if Const.REVIEW_VERSION then
					desc = utils.format(Lang.get(111357), info.bigLv, info.smallLv)
				end

				table.insert(data, {
					pos = pos,
					desc = desc
				})
			end

			temp = temp + 1
		end
	end

	t.lock = data

	self.csPanel:InitCreation(t)
end

function RearHouseDragWall:_getLockInfo(...)
	return ResRearHouseLockAreaConfig[self.zoneId]
end

function RearHouseDragWall:_getCurStageInfo(...)
	return STAGE_INFO[1]
end

function RearHouseDragWall:initDeskData(...)
	local stage = {
		posInfo = {}
	}
	local startCol = STAGE_POS
	local row = STAGE_ROW

	for i = 1, 5 do
		local info = {
			free = true,
			row = row,
			col = startCol[i]
		}

		table.insert(stage.posInfo, info)
	end

	local row = DESK_ROW
	local desk = {}
	local posInfo = {}
	local deskConfig = self:getDeskPosConfig()

	for i = deskConfig.LEFT[1], deskConfig.LEFT[2] do
		posInfo[i] = true
	end

	for i = deskConfig.RIGHT[1], deskConfig.RIGHT[2] do
		posInfo[i] = true
	end

	desk[row] = posInfo
	self.specialPos = {
		desk = desk,
		stage = stage
	}
end

function RearHouseDragWall:getDeskPosConfig(...)
	return DESK_AVAILABLE_COL
end

function RearHouseDragWall:initForbiddenAreas(...)
	local forbidInfo = self:_getCurStageInfo()

	self:_setOccupyInfo(forbidInfo, "isForbid", true)
end

function RearHouseDragWall:_setOccupyInfo(data, stateName, state)
	local r, c = self:gridIdxToRowColumn(data.index)
	local _r, _c, posInfo

	for i = 1, data.columns do
		_c = c + i - 1

		for j = 1, data.rows do
			_r = r + j - 1
			posInfo = self:_checkBounds(_r, _c)

			if posInfo and posInfo[stateName] ~= nil then
				posInfo[stateName] = state
			end
		end
	end
end

function RearHouseDragWall:setStageLevel(t)
	self.csPanel:SetStageLevel(t)
end

function RearHouseDragWall:hideStageRoot(...)
	if self.stageRootGo == nil and self.csPanel then
		local tran = self.csPanel.transform.parent:Find("StageRoot")

		if tran then
			self.stageRootGo = tran.gameObject
		end
	end

	if self.stageRootGo then
		self.stageRootGo:SetActive(false)
	end

	local state = GameFsm.getState(Const.STATE_MAIN_REAR_HOUSE)

	if state.newLevelDlg then
		state.newLevelDlg:onHideShow()
	end
end

function RearHouseDragWall:getLockPosOffset(idx)
	local lockConfig = self:_getLockInfo()
	local lockData = lockConfig[idx]
	local r, c = self:gridIdxToRowColumn(lockData.index)
	local x = self.bounds.main.leftUpPos.x - (c - 1 + lockData.columns * 0.5) * self.gridSize
	local y = self.bounds.main.leftUpPos.y - (r - 1 + lockData.rows * 0.5) * self.gridSize
	local pos = self.transform.parent.position

	return Vector3(-pos.x + x, -pos.y + y, 0), Vector3(x, y, 0)
end

function RearHouseDragWall:getCurUnlockWall(...)
	return self.unlockWall
end

function RearHouseDragWall:getTopRowOffset(...)
	local index = self.unlockWall

	if self.unlockWall <= 4 then
		index = 4
	end

	local rows = 0
	local lockConfig = self:_getLockInfo()

	for i = index + 1, #lockConfig do
		rows = rows + lockConfig[i].rows
	end

	return rows
end

function RearHouseDragWall:initUnLockAreas(unlockLevel)
	local houseData = self.dragCenter.getCurShowData()

	houseData = houseData or CurAvatar.rearHouseData

	local level = unlockLevel or houseData.level

	level = level > 0 and level or 1

	local nextWallUnlockLevel = RearHouseCommon.getNextWallUnlockLevel(self.zoneId)

	level = math.min(nextWallUnlockLevel, level)

	local levelInfo = ResRearHouseLevelConfig[level]

	self.unlockAreas = {}

	if levelInfo then
		self.unlockWall = levelInfo.unlock_wall

		local minRow, minCol, maxRow, maxCol = 999, 999, 0, 0
		local lockData
		local lockConfig = self:_getLockInfo()

		for i = 1, levelInfo.unlock_wall do
			lockData = lockConfig[i]

			local r, c = self:gridIdxToRowColumn(lockData.index)

			minRow = math.min(minRow, r)
			minCol = math.min(minCol, c)
			maxRow = math.max(r + lockData.rows, maxRow)
			maxCol = math.max(c + lockData.columns, maxCol)

			self:_setOccupyInfo(lockData, "isLock", false)
		end

		if lockData ~= nil then
			local _lockData = {}

			_lockData.index = self:rowColToGridIdx(minRow, minCol)
			_lockData.rows = maxRow - minRow
			_lockData.columns = maxCol - minCol

			local r, c = minRow, minCol
			local range = Vector2(_lockData.columns, _lockData.rows)
			local centerIndex = _lockData.index + self.columns * math.ceil((_lockData.rows - 1) * 0.5) + math.ceil(_lockData.columns * 0.5)
			local data = {
				minRow = r,
				maxRow = r + range.y - 1,
				minCol = c,
				maxCol = c + range.x - 1,
				centerIndex = centerIndex
			}
			local oriWidth = self.bounds.main.leftUpPos.x - self.bounds.main.rightDownPos.x
			local oriHeight = self.bounds.main.leftUpPos.y - self.bounds.main.rightDownPos.y
			local width = oriWidth * 1.5
			local height = oriHeight * 1.5
			local left = ((width - oriWidth) * 0.5 + (c - 1) * self.gridSize) / width
			local right = ((width - oriWidth) * 0.5 + (c + _lockData.columns - 1) * self.gridSize) / width
			local up = 1 - ((height - oriHeight) * 0.5 + (r - 1) * self.gridSize) / height
			local down = 1 - ((height - oriHeight) * 0.5 + (r + _lockData.rows - 1) * self.gridSize) / height

			self.csPanel:SetUnLockArea(levelInfo.unlock_wall, Vector4(left, right, down, up))
			table.insert(self.unlockAreas, data)
		else
			self.csPanel:SetUnLockArea(levelInfo.unlock_wall, Vector4.zero)
		end

		local remove = {}

		for i = #self.initWallObjs, 1, -1 do
			local obj = self.initWallObjs[i]

			if obj and obj.initData.lock_id <= levelInfo.unlock_wall then
				obj:destroy()
				table.remove(self.initWallObjs, i)

				obj = nil
			end
		end
	end
end

function RearHouseDragWall:addOccupyPoint(rcData, moveObj)
	for _, rc in ipairs(rcData) do
		local info = self:_checkBounds(rc.r, rc.c)

		if info then
			local data = info.objInfos

			for _, d in ipairs(data) do
				if self.objs[d.layer] and self.objs[d.layer][d.did] then
					local obj = self.objs[d.layer][d.did]

					if obj.conflictLayers[moveObj.layer] then
						obj:addConflictObj(moveObj.did)
						moveObj:addConflictObj(obj.did)
					end
				end
			end

			table.insert(data, {
				layer = moveObj.layer,
				did = moveObj.did
			})
		end
	end
end

function RearHouseDragWall:removeOccupyPoint(rcData, moveObj)
	for _, rc in ipairs(rcData) do
		local info = self:_checkBounds(rc.r, rc.c)

		if info then
			local data = info.objInfos
			local index = -1

			for i = 1, #data do
				if data[i].did == moveObj.did then
					index = i

					break
				end
			end

			if index > 0 then
				table.remove(data, index)

				for _, d in ipairs(data) do
					if self.objs[d.layer] and self.objs[d.layer][d.did] then
						local obj = self.objs[d.layer][d.did]

						if obj.conflictLayers[moveObj.layer] then
							obj:removeConflictObj(moveObj.did)
							moveObj:removeConflictObj(obj.did)
						end
					end
				end
			end
		end
	end
end

function RearHouseDragWall:_checkBounds(r, c)
	if self.occupyDic[r] and self.occupyDic[r][c] then
		return self.occupyDic[r][c]
	else
		return nil
	end
end

function RearHouseDragWall:_isInArea(rowIdx, colIdx, stateName, occupyInfo)
	if not rowIdx or not colIdx then
		return false
	end

	local info

	if occupyInfo == nil then
		info = self:_checkBounds(rowIdx, colIdx)

		if info then
			return info[stateName]
		else
			return false
		end
	else
		for _, data in ipairs(occupyInfo) do
			info = self:_checkBounds(rowIdx + data.rowOffset, colIdx + data.colOffset)

			if info then
				if info[stateName] == true then
					return true
				end
			else
				return false
			end
		end
	end

	return false
end

function RearHouseDragWall:isInLockArea(rowIdx, colIdx, occupyInfo)
	return self:_isInArea(rowIdx, colIdx, "isLock", occupyInfo)
end

function RearHouseDragWall:isInForbiddenArea(rowIdx, colIdx, occupyInfo)
	return self:_isInArea(rowIdx, colIdx, "isForbid", occupyInfo)
end

function RearHouseDragWall:showBack(v)
	if self.csPanel then
		self.csPanel:Show(v)

		local z = v == true and 0.6 or 0

		self.csPanel:TweenMoveDragModelRoot(z, 0)
	end
end

function RearHouseDragWall:circleChoose(gridIdx)
	local areaObjs = {}

	for layer, objs in pairs(self.objs) do
		if objs then
			for did, obj in pairs(objs) do
				if obj:isInArea(gridIdx) then
					table.insert(areaObjs, obj)
				end
			end
		end
	end

	if self.dragCenter.isMainMode() then
		for _, obj in pairs(self.stageObjs) do
			if obj and obj:isInArea(gridIdx) then
				table.insert(areaObjs, obj)
			end
		end
	end

	if #areaObjs == 0 then
		local r, c = self:gridIdxToRowColumn(gridIdx)

		if self:isInForbiddenArea(r, c) then
			CueManager.audioMgr:playUISfx("Audios/SFX/UI/ui_house_unselectable.ogg")
		end

		self:setCurDragObj(nil)

		self.lastClickPos = nil

		self:checkClickStage(gridIdx)

		return
	else
		CueManager.audioMgr:playUISfx("Audios/SFX/UI/ui_house_optional.ogg")
	end

	table.sort(areaObjs, function(v1, v2)
		return CIRCLE_ORDER[v1.type] < CIRCLE_ORDER[v2.type]
	end)

	self.areaObjs = areaObjs

	if self.lastClickPos ~= gridIdx then
		self.clickIndex = 1
	end

	self.lastClickPos = gridIdx

	local isFindObj = false

	for i, obj in ipairs(areaObjs) do
		if self.clickIndex == i then
			self.clickIndex = i % #areaObjs + 1

			obj:setClick()
			self.dragCenter.setClickingObj()

			isFindObj = true

			break
		end
	end

	if isFindObj == false then
		self:setCurDragObj(nil)
	end
end

function RearHouseDragWall:checkClickStage(gridIdx)
	if self.index ~= 1 then
		return
	end

	if self:isEditMode() or self.dragCenter.isInMode(Const.REARHOUSE_CREATE_MODE.VISIT) then
		return
	end

	local r, c = self:gridIdxToRowColumn(gridIdx)

	if c > DESK_AVAILABLE_COL.LEFT[2] and c < DESK_AVAILABLE_COL.RIGHT[1] and r >= STAGE_ROW and r <= DESK_ROW then
		CurAvatar:onClickCrystalStage()
	end
end

function RearHouseDragWall:findDragingObj(gridIdx)
	if self.curDragObj and self.curDragObj.isClick and self.curDragObj:isInArea(gridIdx) then
		self.curDragObj:setDragBegin()
	elseif self.areaObjs then
		for _, obj in ipairs(self.areaObjs) do
			if obj.isDelete == false and obj.isClick and obj:isInArea(gridIdx) then
				obj:setDragBegin()

				break
			end
		end
	end
end

function RearHouseDragWall:mCheckPos(pos, eventName)
	local gridIdx = self:posToGridIndex(pos)

	if eventName == "click" then
		self:circleChoose(gridIdx)

		return
	elseif eventName == "dragBegin" then
		self:findDragingObj(gridIdx)

		return
	end

	if self.curDragObj == nil then
		return
	end

	local r, c = self:posToRowCol(pos)
	local rowOffset = self.curDragObj.gridIndexOffset.rowOffset
	local colOffset = self.curDragObj.gridIndexOffset.colOffset
	local modelPos = self.curDragObj.posOffset + pos

	self.curDragObj:setModelMovePos(modelPos)

	local newGridIdx = self.curDragObj:isInLimitBounds(r - rowOffset, c - colOffset)

	if newGridIdx == -1 or self.curDragObj.gridPos == newGridIdx then
		return
	end

	self.curDragObj:setGridIndex(newGridIdx, true)
	self:checkFallDown()
end

function RearHouseDragWall:posToRowCol(pos)
	local x = self.bounds.edit.leftUpPos.x - pos.x
	local y = self.bounds.edit.leftUpPos.y - pos.y
	local rowIdx = math.ceil(y / self.gridSize)
	local columnIdx = math.ceil(x / self.gridSize)

	return rowIdx, columnIdx
end

function RearHouseDragWall:posToGridIndex(pos)
	local rowIdx, columnIdx = self:posToRowCol(pos)

	return math.max(0, rowIdx - 1) * self.columns + columnIdx
end

function RearHouseDragWall:gridIdxToRowColumn(gridIdx)
	local r = math.ceil(gridIdx / self.columns)
	local c = gridIdx % self.columns

	c = c == 0 and self.columns or c

	return r, c
end

function RearHouseDragWall:rowColToGridIdx(r, c)
	return (r - 1) * self.columns + c
end

function RearHouseDragWall:gridIdxToPos(gridIdx, range)
	local r, c = self:gridIdxToRowColumn(gridIdx)
	local vec = Vector3(self.bounds.edit.leftUpPos.x - (c - 1 + range.x * 0.5) * self.gridSize, self.bounds.edit.leftUpPos.y - (r - 1 + range.y * 0.5) * self.gridSize, 0)

	return vec
end

function RearHouseDragWall:removeHeros(removeData)
	local removeObjs = {}
	local objs = self:getObjsByType({
		5
	})

	if objs then
		for did, obj in pairs(objs) do
			if removeData[obj.data.hero.gid] then
				table.insert(removeObjs, obj)
			end
		end
	end

	self:delObj(removeObjs)
end

function RearHouseDragWall:removeWallPic(...)
	self:delObj(self:getObjsByType({
		1
	}))
	self:setWallTexture(nil)
end

function RearHouseDragWall:checkHeroModelHigh()
	local layerInfo = ResRearHouseLayer[Const.REARHOUSE_TYPE_HERO]

	if layerInfo then
		local objs = self.objs[layerInfo.layer_id]

		if objs then
			for did, obj in pairs(objs) do
				if obj.type == Const.REARHOUSE_TYPE_HERO then
					obj:checkLoadHigh()
				end
			end
		end
	end

	for _, obj in pairs(self.stageObjs) do
		if obj then
			obj:checkLoadHigh()
		end
	end
end

local checkPriority = {
	5,
	6,
	4,
	7,
	3,
	2
}
local directionConfig = {
	right = {
		1,
		2,
		3,
		4
	},
	left = {
		3,
		2,
		1,
		4
	}
}
local directionIndex = directionConfig.right

function RearHouseDragWall:getPutPos(putData)
	local target
	local gridPos = self:posToGridIndex(self.mainState:getCameraPos())

	for i, layer in ipairs(checkPriority) do
		local objs = self.objs[layer]

		if objs then
			for did, obj in pairs(objs) do
				if obj:isInArea(gridPos) and layer == putData.data.modelData.typeInfo.layer_id then
					target = obj

					break
				end
			end
		end
	end

	local bounds = putData.data.modelData.boundsInfo

	if target == nil then
		directionIndex = directionConfig.right
		self.newPutObjDatas = {}

		return gridPos
	end

	local pos
	local lastPutObj = self:_getNewPutObj()

	if lastPutObj ~= nil then
		target = lastPutObj
		gridPos = target.gridPos
	end

	local offsets = {
		target.boundsInfo.right,
		target.boundsInfo.down * self.columns,
		-bounds.right,
		-bounds.down * self.columns
	}

	for _, index in ipairs(directionIndex) do
		local offset = offsets[index]

		pos = gridPos + offset

		if self:_checkPutPosOk(pos, bounds) then
			if directionIndex == directionConfig.right then
				if index == 2 or index == 3 then
					directionIndex = directionConfig.left
				end
			elseif index == 2 or index == 1 then
				directionIndex = directionConfig.right
			end

			return pos
		end
	end

	return gridPos
end

function RearHouseDragWall:_addNewPutObj(obj)
	table.insert(self.newPutObjDatas, {
		layer = obj.layer,
		did = obj.did
	})
end

function RearHouseDragWall:_getNewPutObj(...)
	if #self.newPutObjDatas == 0 then
		return nil
	end

	local obj, layer, did

	for i = #self.newPutObjDatas, 1, -1 do
		layer = self.newPutObjDatas[i].layer
		did = self.newPutObjDatas[i].did

		local objs = self.objs[layer]

		if objs then
			obj = objs[did]

			if obj then
				return obj
			end
		end

		table.remove(self.newPutObjDatas, i)
	end

	return nil
end

function RearHouseDragWall:_checkPutPosOk(pos, bounds)
	local r, c = self:gridIdxToRowColumn(pos)

	return r > UP_OFFSET and r + bounds.down - 1 <= self.limitRows and c > LEFT_OFFSET and c + bounds.right - 1 <= self.columns - RIGHT_OFFSET
end

function RearHouseDragWall:getOccupyInfo(modelId, isTurn)
	return self.dragCenter.getOccupyInfo(modelId, isTurn)
end

function RearHouseDragWall:isPosValid(putData, initData)
	if putData.data.typeId == 1 or initData.pos == nil then
		return true
	end

	if initData.isStage or initData.isPreView or initData.initWall or self.dragCenter.isInMode(Const.REARHOUSE_CREATE_MODE.VISIT) then
		return true
	end

	local gridIdx = initData.pos

	if gridIdx < 1 or gridIdx > self.rows * self.columns then
		return false
	end

	local bounds = putData.data.modelData.boundsInfo
	local r, c = self:gridIdxToRowColumn(gridIdx)
	local occupyInfo = self:getOccupyInfo(putData.data.modelId, initData.angle == 180)

	if self:isInLockArea(r, c, occupyInfo) == true or self:isInForbiddenArea(r, c, occupyInfo) == true then
		return false
	end

	return true
end

function RearHouseDragWall:getStagePos(index, range)
	local info = self.specialPos.stage.posInfo[index]

	if info then
		local pos = (info.row - 1 - range.y) * self.columns + info.col - math.floor(range.x * 0.5)

		return pos
	end
end

function RearHouseDragWall:addObj(datas)
	local tempObjs = {}

	for i, data in ipairs(datas) do
		local putData = data.putData
		local initData = data.initData

		if putData.data.typeId == 1 then
			self:setWallTexture(putData.data.modelData.baseInfo.path)

			if self.wallTextureData then
				self:delObj({
					{
						putData = self.wallTextureData
					}
				})
			end

			self.wallTextureData = putData
			putData.data.count = putData.data.count - 1

			table.insert(tempObjs, {
				putData = putData,
				initData = {}
			})
		else
			if initData.inBeginner == true then
				initData.pos = putData.data.modelData.baseInfo.beginner_pos
			end

			if initData.pos == nil and initData.isNewDrag ~= true then
				initData.pos = self:getPutPos(putData)
			end

			local obj = self:_createObj(self, putData, initData)

			if initData.isNewPut == true then
				self:_addNewPutObj(obj)
			end

			if initData.checkInit then
				initData.show = false
				self.initLoadNum = self.initLoadNum + 1
			end

			if initData.isStage == true then
				table.insert(self.stageObjs, obj)
			elseif initData.initWall == true then
				table.insert(self.initWallObjs, obj)
			else
				if not self.objs[obj.layer] then
					self.objs[obj.layer] = {}
				end

				self.objs[obj.layer][obj.did] = obj
			end

			obj.data.count = obj.data.count - 1

			table.insert(tempObjs, obj)
			obj:loadModel()
		end
	end

	if self.dragCenter.mEventAddObj then
		self.dragCenter.mEventAddObj(tempObjs)
	end
end

function RearHouseDragWall:_createObj(parent, putData, initData)
	if putData.data.typeId == 5 then
		return RearHouseDragHero(parent, putData, initData)
	elseif putData.data.typeId == 8 then
		return RearHouseDragShelf(parent, putData, initData)
	else
		return RearHouseDragObject(parent, putData, initData)
	end
end

function RearHouseDragWall:delObj(objs)
	local tempObjs = {}

	for i, obj in ipairs(objs) do
		if obj then
			obj.putData.data.count = obj.putData.data.count + 1

			table.insert(tempObjs, {
				putData = obj.putData
			})

			if obj.putData.data.typeId == 1 then
				-- block empty
			else
				if obj == self.curDragObj then
					self:setCurDragObj(nil)
				end

				obj:onDel()

				self.objs[obj.layer][obj.did] = nil
			end
		end
	end

	if self.dragCenter.mEventDelObj then
		self.dragCenter.mEventDelObj(tempObjs)
	end

	if #objs == 1 and objs[1].putData.data.typeId == 1 then
		-- block empty
	else
		self:checkFallDown()
	end

	return true
end

function RearHouseDragWall:getNowObjsCountByType(typeId)
	if typeId == 1 then
		return self.wallTextureData == nil and 0 or 1
	elseif RearHouseCommon.isWeightType(typeId) then
		local objs = self:getObjsByType({
			typeId
		})
		local count = 0

		for _, obj in ipairs(objs) do
			count = count + obj.data.modelData.baseInfo.weight or 0
		end

		return count
	else
		local objs = self:getObjsByType({
			typeId
		})

		return objs and #objs or 0
	end
end

function RearHouseDragWall:getHeroObjs(heros)
	local data = {}
	local objs = self.objs[5]

	if objs then
		for did, obj in pairs(objs) do
			if obj.type == 5 then
				for _, hero in ipairs(heros) do
					if obj.putData.hero.gid == hero.gid then
						table.insert(data, obj)
					end
				end
			end
		end
	end

	return data
end

function RearHouseDragWall:getObjsByType(typeIds)
	local temp = {}

	for _, typeId in ipairs(typeIds) do
		if typeId == 1 and self.wallTextureData then
			table.insert(temp, {
				putData = self.wallTextureData
			})
		else
			local layer = ResRearHouseLayer[typeId].layer_id
			local objs = self.objs[layer]

			if objs then
				for did, obj in pairs(objs) do
					if obj.type == typeId then
						table.insert(temp, obj)
					end
				end
			end
		end
	end

	return temp
end

function RearHouseDragWall:setDraging(...)
	self.dragCenter.setDraging(true)
end

function RearHouseDragWall:resetLoadNum(...)
	self.initLoadNum = 0
end

function RearHouseDragWall:resetLoad(func)
	self:resetLoadNum()

	if func then
		func()
	end

	self:onInitObjsLoadEnd()
end

function RearHouseDragWall:addLoadedNum(obj)
	table.insert(self._initLoadObjs, obj)
end

function RearHouseDragWall:onInitObjsLoadEnd(...)
	local function func(...)
		self:save(true, true)
		self:clearState(true)
		self:setCurDragObj(nil)
		self.dragCenter.logo:setVisible(false)

		local counter = 0
		local t = 0
		local totalCount = 0
		local _initLoadNum = self.initLoadNum

		while true do
			totalCount = #self._initLoadObjs

			if totalCount >= 5 then
				for i = totalCount, totalCount - 4, -1 do
					self._initLoadObjs[i]:showModel()
					table.remove(self._initLoadObjs, i)

					_initLoadNum = _initLoadNum - 1
				end
			elseif totalCount == _initLoadNum then
				for i = totalCount, 1, -1 do
					self._initLoadObjs[i]:showModel()
					table.remove(self._initLoadObjs, i)

					_initLoadNum = _initLoadNum - 1
				end

				break
			end

			coroutine.step()

			t = t + 1

			if t > 300 then
				for i = #self._initLoadObjs, 1, -1 do
					self._initLoadObjs[i]:showModel()
					table.remove(self._initLoadObjs, i)

					_initLoadNum = _initLoadNum - 1
				end

				break
			end
		end

		self.inited = true
	end

	self.coInitObjs = coroutine.start(func)
end

function RearHouseDragWall:setCurDragObj(obj)
	self.curDragObj = obj

	self.dragCenter.setCurDragObj(obj)
	self:clearState()

	if self.curDragObj then
		self.curDragObj:showInfoPanel(true)
	end
end

function RearHouseDragWall:getCurDragObj(...)
	return self.curDragObj
end

function RearHouseDragWall:setWallTexture(url)
	if self.csPanel then
		if not url then
			local zoneId = self.dragCenter.getZoneId(self.zoneName)

			if zoneId >= 10 then
				url = DEFAULT_WALL_PIC_PATH .. zoneId
			else
				url = DEFAULT_WALL_PIC_PATH .. "0" .. zoneId
			end

			self.wallTextureData = nil
		end

		self.csPanel:SetWallTexture(url)
	end
end

function RearHouseDragWall:setRotateMode(v)
	if self.csPanel then
		self.csPanel:SetRotateMode(v)
	end
end

function RearHouseDragWall:rotate(delta)
	if self.curDragObj and self.curDragObj.type == 5 then
		self.curDragObj:rotate(delta)
	end
end

function RearHouseDragWall:save(isInit)
	local _isPutWrong = false

	for i, layer in pairs(NOT_FALL_LAYERS) do
		local objs = self.objs[layer]

		if objs then
			for did, obj in pairs(objs) do
				if obj:isPutStateWrong() then
					_isPutWrong = true

					break
				end
			end
		end
	end

	self.newPutObjDatas = {}

	if isInit then
		self.lastSaveInfo = self:recordSaveInfo()
	end

	if self:checkFallDown(isInit, true) and _isPutWrong == false then
		return true
	end

	return false
end

function RearHouseDragWall:isChanged(...)
	local data = self:recordSaveInfo()

	if data.wallData == nil and self.lastSaveInfo.wallData == nil then
		-- block empty
	elseif data.wallData and self.lastSaveInfo.wallData then
		if data.wallData.data ~= self.lastSaveInfo.wallData.data then
			return true
		end
	else
		return true
	end

	if utils.getTableElemCount(data.objData) == utils.getTableElemCount(self.lastSaveInfo.objData) then
		local lastData = self.lastSaveInfo.objData

		for mid, _data in pairs(data.objData) do
			if lastData[mid] and #lastData[mid] == #_data then
				if not self:_contrast(_data, lastData[mid]) then
					return true
				end
			else
				return true
			end
		end
	else
		return true
	end

	return false
end

function RearHouseDragWall:_contrast(data1, data2)
	local matchedIdx = {}

	for i, _data1 in ipairs(data1) do
		local isMatch = false

		for j, _data2 in ipairs(data2) do
			if not matchedIdx[j] and _data1.putData.hero == _data2.putData.hero and _data1.initData.pos == _data2.initData.pos and _data1.initData.angle == _data2.initData.angle then
				matchedIdx[j] = true
				isMatch = true

				break
			end
		end

		if not isMatch then
			return false
		end
	end

	return true
end

function RearHouseDragWall:recordSaveInfo(...)
	local data = {}

	data.wallData = self.wallTextureData

	local objData = {}

	for layer, objs in pairs(self.objs) do
		for did, obj in pairs(objs) do
			objData[obj.modelId] = objData[obj.modelId] or {}

			table.insert(objData[obj.modelId], obj:getSaveInfo())
		end
	end

	data.objData = objData

	return data
end

function RearHouseDragWall:resetOpration(...)
	local tempAddObjs = {}
	local tempDelObjs = {}

	if self.lastSaveInfo.wallData ~= nil then
		if self.wallTextureData == nil or self.lastSaveInfo.wallData.data.modelId ~= self.wallTextureData.data.modelId then
			table.insert(tempAddObjs, {
				putData = self.lastSaveInfo.wallData,
				initData = {}
			})
		end
	else
		if self.wallTextureData then
			table.insert(tempDelObjs, {
				putData = self.wallTextureData,
				initData = {}
			})
		end

		self:setWallTexture(nil)
	end

	local needCreate = {}
	local needDelete = {}
	local needRePos = {}
	local objData = self.lastSaveInfo.objData or {}

	for layer, objs in pairs(self.objs) do
		for did, obj in pairs(objs) do
			if objData[obj.modelId] then
				if #objData[obj.modelId] > 0 then
					local initData = objData[obj.modelId][1].initData

					table.insert(needRePos, {
						obj = obj,
						initData = initData
					})
					table.remove(objData[obj.modelId], 1)
				else
					table.insert(needDelete, obj)
				end
			else
				table.insert(needDelete, obj)
			end
		end
	end

	for modelId, data in pairs(objData) do
		if #data > 0 then
			for i, _data in ipairs(data) do
				table.insert(needCreate, {
					putData = _data.putData,
					initData = _data.initData
				})
			end
		end
	end

	for i, obj in ipairs(needDelete) do
		table.insert(tempDelObjs, obj)
	end

	self:delObj(tempDelObjs)

	for i, info in ipairs(needRePos) do
		info.obj:resetPos(info.initData)
	end

	self.inited = false

	for i, info in ipairs(needCreate) do
		table.insert(tempAddObjs, {
			putData = info.putData,
			initData = info.initData
		})
	end

	self:resetLoad(Functor(self.addObj, self, tempAddObjs))
end

function RearHouseDragWall:getObjsCount(...)
	if self.objs == nil then
		return 0
	end

	local count = 0

	for layer, objs in pairs(self.objs) do
		for did, obj in pairs(objs) do
			if obj ~= nil then
				count = count + 1
			end
		end
	end

	return count
end

function RearHouseDragWall:showPlane(obj, isInit, show, colorMode)
	if obj and not isInit then
		obj:showPlane(show, colorMode)
	end
end

function RearHouseDragWall:checkSpecialPos(leftDownRow, colDic, specialData)
	local data = specialData[leftDownRow + 1]
	local ok = true

	for col, _ in pairs(colDic) do
		if not data[col] then
			ok = false

			break
		end
	end

	return ok
end

function RearHouseDragWall:isEditMode(...)
	return self.dragCenter.curMode.mode == self.dragCenter.MODE.EDIT
end

function RearHouseDragWall:checkFallDown(isInit, isFall)
	if self:getObjsCount() == 0 then
		self.dragCenter.showWarning(false)

		return true
	end

	if self:isEditMode() == false then
		isInit = true
	end

	local shelfData = self:getShelfsState()

	shelfData = shelfData or {}

	local curObjLayer = -1
	local allOk = true
	local occupy = {}
	local objOk = true

	if self.curDragObj then
		curObjLayer = self.curDragObj.layer
	end

	local occupyed = false

	for layer, objs in pairs(self.objs) do
		if objs then
			for did, obj in pairs(objs) do
				objOk = true

				if obj:isPutStateWrong() then
					objOk = false
				elseif FALL_LAYERS[layer] then
					occupy = {}

					if obj.shelf or obj.halfShelfs then
						objOk = true
					else
						local leftDownRow, colDic = obj:getPosInfo()

						if self.specialPos.desk[leftDownRow + 1] then
							objOk = self:checkSpecialPos(leftDownRow, colDic, self.specialPos.desk)
							obj.onDesk = objOk
						else
							objOk = false

							local halfShelfs = {}

							for _, rowInfo in ipairs(shelfData) do
								if rowInfo.shelf:isPutStateWrong() == false and leftDownRow + 1 == rowInfo.rowIdx then
									occupyed = false

									local rowIdx = rowInfo.rowIdx
									local result, partIndex = rowInfo.shelf:canFallDown(colDic, rowInfo.partInfo)

									if result > 0 then
										if isFall then
											obj:telepotRow(rowIdx, partIndex, {
												rowInfo.shelf
											}, isInit)
										end

										objOk = true

										break
									elseif result == -1 then
										-- block empty
									elseif result == -2 then
										table.insert(halfShelfs, rowInfo.shelf)

										local can = true

										for c, l in pairs(colDic) do
											if l == 0 then
												can = false

												break
											end
										end

										if can then
											if isFall then
												obj:telepotRow(rowIdx, partIndex, halfShelfs, nil, isInit)
											end

											objOk = true

											break
										end
									end
								end
							end
						end
					end
				end

				if objOk then
					if layer == curObjLayer then
						self:showPlane(obj, isInit, true, "green")
					else
						self:showPlane(obj, isInit, false)
					end
				else
					self:showPlane(obj, isInit, true, "red")

					allOk = false
				end
			end
		end
	end

	if not allOk then
		self.dragCenter.showWarning(true)

		return false
	end

	self.dragCenter.showWarning(false)

	return true
end

function RearHouseDragWall:getShelfsState(...)
	local shelfLayer = 7

	if self.objs[shelfLayer] then
		local data = {}
		local empty = true
		local objs = self.objs[shelfLayer]

		for did, shelf in pairs(objs) do
			if shelf then
				empty = false

				local info = shelf:getShelfPartInfo()

				if info then
					for rowIdx, partInfo in pairs(info) do
						table.insert(data, {
							rowIdx = rowIdx,
							shelf = shelf,
							partInfo = partInfo
						})
					end
				end
			end
		end

		if empty then
			return false
		end

		return data
	end
end

function RearHouseDragWall:setInitObjsGray(v)
	for _, obj in ipairs(self.initWallObjs) do
		obj:setGray(v)
	end
end

function RearHouseDragWall:isInitWallObjsLoadEnd(...)
	if #self.initWallObjs == 0 then
		return true
	end

	for i, obj in ipairs(self.initWallObjs) do
		if not obj:isInitWallObjLoadEnd() then
			return false
		end
	end

	return true
end

function RearHouseDragWall:clearState(isAll)
	if isAll then
		self:setCurDragObj(nil)
	end

	for layer, objs in pairs(self.objs) do
		for did, obj in pairs(objs) do
			if isAll then
				obj:showPlane(false)
				obj:clearDragState()
			else
				if self.curDragObj ~= obj then
					obj:clearDragState()
				end

				if obj:isPutStateWrong() == false then
					if FALL_LAYERS[obj.layer] and (obj.shelf or obj.halfShelfs or obj.onDesk or obj.onStage) then
						obj:showPlane(false)
					elseif not FALL_LAYERS[obj.layer] then
						obj:showPlane(false)
					end
				end
			end
		end
	end

	self:_clearStageState(isAll)
end

function RearHouseDragWall:_clearStageState(isAll)
	for i, obj in ipairs(self.stageObjs) do
		if isAll then
			obj:showPlane(false)
			obj:clearDragState()
		else
			if self.curDragObj ~= obj then
				obj:clearDragState()
			end

			if obj:isPutStateWrong() == false then
				if FALL_LAYERS[obj.layer] and (obj.shelf or obj.halfShelfs or obj.onDesk or obj.onStage) then
					obj:showPlane(false)
				elseif not FALL_LAYERS[obj.layer] then
					obj:showPlane(false)
				end
			end
		end
	end
end

function RearHouseDragWall:isObjPosOk(obj)
	if obj:isPutStateWrong() then
		return false
	elseif FALL_LAYERS[obj.layer] then
		if obj.shelf or obj.halfShelfs or obj.onDesk or obj.onStage then
			if obj.shelf and obj.shelf:isPutStateWrong() then
				return false
			end

			if obj.halfShelfs then
				for _, shelf in ipairs(obj.halfShelfs) do
					if shelf:isPutStateWrong() then
						return false
					end
				end
			end

			return true
		else
			return false
		end
	end

	return true
end

function RearHouseDragWall:_getSaveData(removeConflict)
	local heros = {}
	local parts = {}
	local remove = {}

	if self.wallTextureData then
		local posData = {}

		posData.pos = 1
		posData.angle = 0
		posData.area = self.dragCenter.getZoneId(self.zoneName)

		local housePart = {}

		housePart.id = self.wallTextureData.data.modelId
		housePart.pos = posData

		table.insert(parts, housePart)
	end

	for layer, objs in pairs(self.objs) do
		if objs then
			for did, obj in pairs(objs) do
				if removeConflict and not self:isObjPosOk(obj) then
					table.insert(remove, obj)
				else
					local area = self.dragCenter.getZoneId(self.zoneName)
					local data

					if obj.type == 5 then
						data = self:wrapSaveData(obj.gridPos, obj.angle, area, obj.putData.hero.id, obj.putData.hero)

						table.insert(heros, data)
					else
						data = self:wrapSaveData(obj.gridPos, obj.angle, area, obj.putData.data.modelId)

						table.insert(parts, data)
					end
				end
			end
		end
	end

	if #remove > 0 and removeConflict then
		self:delObj(remove)
	end

	if #parts > 1 then
		table.sort(parts, function(v1, v2)
			return v1.id < v2.id
		end)
	end

	return {
		heros = heros,
		parts = parts
	}
end

function RearHouseDragWall:getCurPutSaveData(...)
	return self:_getSaveData()
end

function RearHouseDragWall:getSaveData(removeConflict)
	local data = self:_getSaveData(removeConflict)

	self.lastSaveInfo = self:recordSaveInfo()

	return data
end

function RearHouseDragWall:wrapSaveData(pos, angle, area, id, hero)
	local data = {}
	local posData = {
		pos = pos,
		angle = angle,
		area = area
	}

	data.pos = posData
	data.id = id

	if hero then
		data.gid = hero.gid
		data.base = hero.base
		data.skin = hero.skin
	end

	return data
end

function RearHouseDragWall:delObjByType(typeId)
	local layer = ResRearHouseLayer[typeId].layer_id
	local tempObjs = {}
	local objs = self.objs[layer]

	if objs then
		for did, obj in pairs(objs) do
			if obj.type == typeId then
				table.insert(tempObjs, obj)
			end
		end
	end

	self:delObj(tempObjs)
end

function RearHouseDragWall:delAllObj(isForceAll, isIncludeStage)
	self:setCurDragObj(nil)

	local tempObjs = {}

	for layer, objs in pairs(self.objs) do
		for did, obj in pairs(objs) do
			if obj then
				table.insert(tempObjs, obj)
			end
		end
	end

	self:delObj(tempObjs)
	self:removeWallPic()

	self.objs = {}

	if isForceAll then
		for i, obj in ipairs(self.initWallObjs) do
			obj:onDel()

			obj = nil
		end

		self.initWallObjs = {}
	end

	if isIncludeStage then
		for i, obj in ipairs(self.stageObjs) do
			if obj then
				obj:onDel()

				obj = nil
			end
		end

		self.stageObjs = {}
	end
end

function RearHouseDragWall:clearObjs(...)
	for layer, objs in pairs(self.objs) do
		for did, obj in pairs(objs) do
			if obj then
				obj:destroy()

				obj = nil
			end
		end
	end

	self.objs = {}

	for _, obj in ipairs(self.stageObjs) do
		if obj then
			obj:destroy()

			obj = nil
		end
	end

	self.stageObjs = {}

	for _, obj in ipairs(self.initWallObjs) do
		if obj then
			obj:destroy()

			obj = nil
		end
	end

	self.initWallObjs = {}
end

function RearHouseDragWall:destroy(...)
	self:clearObjs()

	if self.stageRootGo then
		self.stageRootGo = nil
	end

	self.csPanel = nil
	self.dragModelRoot = nil
	self.staticModelRoot = nil
	self.inited = false

	if self.coInitObjs then
		coroutine.stop(self.coInitObjs)

		self.coInitObjs = nil
	end

	if self.transform and self.transform.parent then
		UnityEngine.Object.Destroy(self.transform.parent.gameObject)
	end

	self.transform = nil
end

return RearHouseDragWall
