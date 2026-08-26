-- chunkname: @modules/logic/versionactivity3_7/wmz/model/WmzMapDragContext.lua

local ti = table.insert
local sf = string.format
local abs = math.abs
local Input = UnityEngine.Input
local KeyCode = UnityEngine.KeyCode

module("modules.logic.versionactivity3_7.wmz.model.WmzMapDragContext", package.seeall)

local WmzMapDragContext = class("WmzMapDragContext", UserDataDispose)

function WmzMapDragContext:ctor()
	self:clear()
end

function WmzMapDragContext:_mapMO()
	return WmzBattleModel.instance:mapMO()
end

function WmzMapDragContext:curSelectedTileItem()
	return self._viewObj:curSelectedTileItem()
end

function WmzMapDragContext:curSelectedId2TileItemDict()
	return self._viewObj:curSelectedId2TileItemDict()
end

function WmzMapDragContext:getCellItem(...)
	return self._viewObj:getCellItem(...)
end

function WmzMapDragContext:getTileItem(...)
	return self._viewObj:getTileItem(...)
end

function WmzMapDragContext:getItemByObj(...)
	return self._viewObj:getItemByObj(...)
end

function WmzMapDragContext:setEnergy(...)
	self._viewContainer:setEnergy(...)
end

function WmzMapDragContext:curEnergy(...)
	return self._viewContainer:curEnergy(...)
end

function WmzMapDragContext:setClearZoneCnt(...)
	self._viewContainer:setClearZoneCnt(...)
end

function WmzMapDragContext:zoneClearCurAndMax()
	return self._viewContainer:zoneClearCurAndMax()
end

function WmzMapDragContext:clear()
	self:__onDispose()
	self:__onInit()

	self._enabled = false
	self._viewObj = false
	self._viewContainer = false
	self._isCompleted = false
	self._edit_Energy = 0
	self._fromV2 = Vector2.New(-1, -1)
	self._toV2 = Vector2.New(-1, -1)

	if isDebugBuild then
		UpdateBeat:Remove(self._onTick, self)
	end
end

function WmzMapDragContext:reset(current_V3a7_Wmz_GameView)
	self:clear()

	self._viewObj = current_V3a7_Wmz_GameView
	self._viewContainer = self._viewObj.viewContainer
	self._edit_Energy = self:curEnergy()

	self._viewObj:selectTile(nil)
	self:setEnabled(true)

	if isDebugBuild then
		UpdateBeat:Add(self._onTick, self)
	end
end

function WmzMapDragContext:setEnabled(isEnabled)
	self._enabled = not not isEnabled
end

function WmzMapDragContext:_critical_beforeClear()
	self:setEnabled(false)
end

function WmzMapDragContext:isCompleted()
	return self._isCompleted
end

function WmzMapDragContext:setCompleted()
	if self._isCompleted then
		return
	end

	self._isCompleted = true

	self:setEnabled(false)
end

function WmzMapDragContext:_isZeroEnergy()
	return self._edit_Energy <= 0
end

function WmzMapDragContext:_isValidDrag()
	if self:_isZeroEnergy() then
		return false
	end

	return true
end

function WmzMapDragContext:_onResetSelectTileItem(tileItem)
	local x, y = tileItem:xy()

	self._fromV2:Set(x, y)
	self._toV2:Set(x, y)
end

function WmzMapDragContext:onDragBegin(tileItem, dragObj, userParams)
	if not self._enabled then
		return
	end

	if not self:_isValidDrag() then
		if self:_isZeroEnergy() then
			self:doFailed()
		end

		return
	end

	self._viewObj:selectTile(tileItem)
	self:_onResetSelectTileItem(tileItem)
end

function WmzMapDragContext:onDrag(tileItem, dragObj, userParams)
	if not self._enabled then
		return
	end

	if not self:_isValidDrag() then
		if self:_isZeroEnergy() then
			self:doFailed()
		end

		return
	end

	if not self:curSelectedTileItem() then
		return
	end

	if self:curSelectedTileItem() ~= tileItem then
		local lastGpId = self:curSelectedTileItem():groupId()

		if not lastGpId or lastGpId == 0 then
			return
		end

		if lastGpId == tileItem:groupId() then
			self:_onResetSelectTileItem(tileItem)
		end
	end

	local dragInfo = dragObj:dragInfo()
	local endV2 = dragInfo.screenPos
	local deltaV2 = dragInfo.delta
	local eDir = UIGlobalDragHelper.deltaV2ToSimpleDir(deltaV2)

	if eDir == UIGlobalDragHelper.Dir.None then
		return
	end

	local toX, toY = self._viewContainer:screenToGridCoordXY(endV2)

	if toX == -1 or toY == -1 then
		return
	end

	local fromX, fromY = self._toV2:Get()
	local dx = toX - fromX
	local dy = toY - fromY

	if dx == 0 and dy == 0 then
		return
	end

	local dstX, dstY = fromX, fromY

	if abs(dx) > abs(dy) then
		dstX = dx < 0 and dstX - 1 or dstX + 1
	else
		dstY = dy < 0 and dstY - 1 or dstY + 1
	end

	self:_tryMoveTo(dstX, dstY)
end

function WmzMapDragContext:_tryMoveTo(dstX, dstY)
	dstX, dstY = self:_clamp(dstX, dstY)

	local newToV2 = Vector2.New(dstX, dstY)

	if self._fromV2 == newToV2 then
		return
	end

	local refId2TileItemDict = {}
	local bMovable = self:_calcMovable(refId2TileItemDict, newToV2)

	if not bMovable then
		return
	end

	self._fromV2:Set(self._toV2:Get())
	self._toV2:Set(newToV2:Get())
	self:_doMoving(refId2TileItemDict)
end

function WmzMapDragContext:_calcMovable(refId2TileItemDict, newToV2)
	if isDebugBuild then
		assert(newToV2.x)
		assert(newToV2.y)
	end

	local deltaV2 = newToV2 - self._fromV2
	local hh = 1
	local tt = 0
	local q = {}

	local function _pop()
		hh = hh + 1

		return q[hh]
	end

	local set = {
		[-1] = true
	}

	local function _append(obj)
		assert(obj, "invalid input")

		tt = tt + 1
		q[tt] = obj
	end

	_append(self:curSelectedTileItem())

	while hh <= tt do
		local tileItem = _pop()
		local tileId = tileItem:tileId()

		if not set[tileId] then
			local tileIdList = tileItem:getTileIdListByGroup()

			for _, tileId_ in pairs(tileIdList) do
				if not set[tileId_] then
					_append(self:getTileItem(tileId_))
				end
			end
		end

		set[tileId] = tileItem

		local toV2 = tileItem._mo.index + deltaV2
		local toCellItem = self:getCellItem(toV2.x, toV2.y)

		if not toCellItem then
			return false
		end

		if not toCellItem:isPassable() then
			return false
		end

		local cellOfTileId = toCellItem:tileId()

		if not set[cellOfTileId] then
			_append(self:getTileItem(cellOfTileId))
		end
	end

	for tileId, tileItem in pairs(set) do
		if tileId ~= -1 then
			refId2TileItemDict[tileId] = tileItem
		end
	end

	return true
end

function WmzMapDragContext:_doMoving(refId2TileItemDict)
	AudioMgr.instance:trigger(AudioEnum2_7.Act191.play_ui_yuzhou_dqq_pmgressbar_01)

	local deltaV2 = self._toV2 - self._fromV2

	for tileId, tileItem in pairs(refId2TileItemDict) do
		local lastCellItem = tileItem:getCellItem()

		tileItem:unbind()
	end

	for tileId, tileItem in pairs(refId2TileItemDict) do
		local x, y = tileItem:xy()

		x = x + deltaV2.x
		y = y + deltaV2.y

		tileItem:bind(x, y)
		tileItem:resetPos()
	end

	self._viewObj:_doSelectedTiles()
	self:_onMoveDone()
end

function WmzMapDragContext:_subEnergy()
	self._edit_Energy = self._edit_Energy - 1

	self._viewObj:_refreshEnergy(self._edit_Energy)

	if self:_isZeroEnergy() then
		self:doFailed()

		return
	end

	WmzController.instance:dispatchEvent(WmzEvent.GuideStart2)
end

function WmzMapDragContext:_onMoveDone()
	if isDebugBuild and not self:curSelectedTileItem() then
		assert(false)
	end

	self._fromV2:Set(self._toV2:Get())

	local bAllCompleted = self._viewContainer:floodfill()

	self._viewContainer:foreachWire(function(gridObj, x, y)
		local item = self:getItemByObj(gridObj)

		if not item:isStart() then
			item:refresh()
		end
	end)
	self:_subEnergy()

	if bAllCompleted then
		self:setCompleted()
	end

	local bZoneCompleted = false

	if self:curSelectedTileItem():bInZone() then
		bZoneCompleted = self:_mapMO():isZoneCompleted(self:curSelectedTileItem():zoneId())
	end

	if bZoneCompleted then
		self:setZoneCompleted()
	end
end

function WmzMapDragContext:setZoneCompleted()
	local zoneClearCur = self:zoneClearCurAndMax()

	self:setClearZoneCnt(zoneClearCur + 1)
	self:setEnergy(self._edit_Energy)
	self._viewObj:onCompleteZone()
end

function WmzMapDragContext:doFailed()
	self._enabled = false

	self._viewObj:onFailed()
end

function WmzMapDragContext:_clamp(x, y)
	if isDebugBuild then
		assert(x)
		assert(y)
	end

	local mapW, mapH = self._viewContainer:mapSize()

	x = GameUtil.clamp(x, 0, mapW - 1)
	y = GameUtil.clamp(y, 0, mapH - 1)

	return x, y
end

function WmzMapDragContext:onDragEnd(tileItem, dragObj, userParams)
	self._viewObj:selectTile(nil)

	if not self._enabled then
		return
	end
end

function WmzMapDragContext:_onTick()
	if not self._enabled then
		return
	end

	if not self._viewObj then
		return
	end

	if not self._viewContainer then
		return
	end

	if not self._viewObj._mapContentTrans then
		return
	end

	if self:curSelectedTileItem() then
		local curSelectedItem = self:curSelectedTileItem()

		if Input.GetKeyDown(KeyCode.UpArrow) then
			local x, y = curSelectedItem:xy()

			self:_onResetSelectTileItem(curSelectedItem)
			self:_tryMoveTo(x, y - 1)
		elseif Input.GetKeyDown(KeyCode.DownArrow) then
			local x, y = curSelectedItem:xy()

			self:_onResetSelectTileItem(curSelectedItem)
			self:_tryMoveTo(x, y + 1)
		elseif Input.GetKeyDown(KeyCode.LeftArrow) then
			local x, y = curSelectedItem:xy()

			self:_onResetSelectTileItem(curSelectedItem)
			self:_tryMoveTo(x - 1, y)
		elseif Input.GetKeyDown(KeyCode.RightArrow) then
			local x, y = curSelectedItem:xy()

			self:_onResetSelectTileItem(curSelectedItem)
			self:_tryMoveTo(x + 1, y)
		end
	end

	if WmzEnum.rDir then
		local v3 = Input.mousePosition
		local gridCoordX, gridCoordY = self._viewContainer:screenToGridCoordXY(v3)
		local refStrBuf = {}

		ti(refStrBuf, sf("(%s,%s)", gridCoordX, gridCoordY))

		local cellItem = self:getCellItem(gridCoordX, gridCoordY)

		if cellItem then
			ti(refStrBuf, sf("%s zId:%s", cellItem:name(), cellItem:zoneId()))
		end

		local str = table.concat(refStrBuf, "\n")

		self._viewObj:setText_txtTarget(str)
	end

	if isDebugBuild then
		local leftControl = Input.GetKey(UnityEngine.KeyCode.LeftControl)

		if leftControl and Input.GetKeyDown(KeyCode.W) then
			self:setCompleted()
		end
	end
end

return WmzMapDragContext
