-- chunkname: @modules/logic/versionactivity3_4/chg/view/V3a4_Chg_GameItem.lua

local ti = table.insert

module("modules.logic.versionactivity3_4.chg.view.V3a4_Chg_GameItem", package.seeall)

local V3a4_Chg_GameItem = class("V3a4_Chg_GameItem", RougeSimpleItemBase)

function V3a4_Chg_GameItem:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a4_Chg_GameItem:addEvents()
	return
end

function V3a4_Chg_GameItem:removeEvents()
	return
end

local _B = Bitwise

function V3a4_Chg_GameItem:ctor(ctorParam)
	V3a4_Chg_GameItem.super.ctor(self, ctorParam)

	self._mo = false
end

function V3a4_Chg_GameItem:addEventListeners()
	V3a4_Chg_GameItem.super.addEventListeners(self)
end

function V3a4_Chg_GameItem:removeEventListeners()
	V3a4_Chg_GameItem.super.removeEventListeners(self)
end

function V3a4_Chg_GameItem:onDestroyView()
	V3a4_Chg_GameItem.super.onDestroyView(self)
end

function V3a4_Chg_GameItem:_editableInitView_None()
	local go = self.viewGO
	local item = self:newObject(V3a4_Chg_GameItem_None)

	item:init(go)

	self._none = item
end

function V3a4_Chg_GameItem:_editableInitView_Obstacle()
	local go = gohelper.findChild(self.viewGO, "Obstacle")
	local item = self:newObject(V3a4_Chg_GameItem_Obstacle)

	item:init(go)

	self._obstacle = item
end

function V3a4_Chg_GameItem:_editableInitView_Start()
	local go = gohelper.findChild(self.viewGO, "Role1")
	local item = self:newObject(V3a4_Chg_GameItem_Start)

	item:init(go)

	self._start = item
end

function V3a4_Chg_GameItem:_editableInitView_End()
	local go = gohelper.findChild(self.viewGO, "Role2")
	local item = self:newObject(V3a4_Chg_GameItem_End)

	item:init(go)

	self._end = item
end

function V3a4_Chg_GameItem:_editableInitView_CheckPoint()
	local go = gohelper.findChild(self.viewGO, "Prop")
	local item = self:newObject(V3a4_Chg_GameItem_Prop)

	item:init(go)

	self._checkPoint = item
end

function V3a4_Chg_GameItem:_editableInitView_Objs()
	self:_editableInitView_None()
	self:_editableInitView_Obstacle()
	self:_editableInitView_Start()
	self:_editableInitView_End()
	self:_editableInitView_CheckPoint()
end

function V3a4_Chg_GameItem:_editableInitView()
	V3a4_Chg_GameItem.super._editableInitView(self)
	self:_editableInitView_Objs()

	local x, y, w, h = self:XYWH()

	self._safeArea = {
		x = x,
		y = y,
		w = w,
		h = h,
		hw = w * 0.5,
		hh = h * 0.5
	}
end

function V3a4_Chg_GameItem:isNone()
	return self._mo:isNone()
end

function V3a4_Chg_GameItem:isStart()
	return self._mo:isStart()
end

function V3a4_Chg_GameItem:isEnd()
	return self._mo:isEnd()
end

function V3a4_Chg_GameItem:isObstacle()
	return self._mo:isObstacle()
end

function V3a4_Chg_GameItem:isCheckPoint()
	return self._mo:isCheckPoint()
end

function V3a4_Chg_GameItem:mapObj()
	return self._mo
end

function V3a4_Chg_GameItem:safeArea()
	return self._safeArea
end

function V3a4_Chg_GameItem:getLineItemAPos()
	return self:_getLineItemAPosByKey(self:key())
end

function V3a4_Chg_GameItem:_getLineItemAPosByKey(key)
	return self:baseViewContainer():getLineItemAPosByKey(key)
end

function V3a4_Chg_GameItem:setData(mo)
	local last_ePuzzleMazeObjType = self:getPuzzleMazeObjType()

	V3a4_Chg_GameItem.super.setData(self, mo)

	local ePuzzleMazeObjType = self:getPuzzleMazeObjType()

	if self._impl == nil or last_ePuzzleMazeObjType ~= ePuzzleMazeObjType then
		self:_switchType(ePuzzleMazeObjType)
	end

	self:_refreshNum()
	self:_refreshIcon()
	self:_refreshGroup()
	self:setInvoked(false)
end

function V3a4_Chg_GameItem:_switchType(ePuzzleMazeObjType)
	if self._impl then
		self._impl:setActive(false)
	end

	if ePuzzleMazeObjType == ChgEnum.PuzzleMazeObjType.None then
		self:asNone()
	elseif ePuzzleMazeObjType == ChgEnum.PuzzleMazeObjType.CheckPoint then
		self:asCheckPoint()
	elseif ePuzzleMazeObjType == ChgEnum.PuzzleMazeObjType.End then
		self:asEnd()
	elseif ePuzzleMazeObjType == ChgEnum.PuzzleMazeObjType.Start then
		self:asStart()
	elseif ePuzzleMazeObjType == ChgEnum.PuzzleMazeObjType.Obstacle then
		self:asObstacle()
	else
		assert(false, "unsupported ePuzzleMazeObjType:" .. tostring(ePuzzleMazeObjType))
	end

	if self._impl then
		self._impl:setActive(true)
	end
end

function V3a4_Chg_GameItem:_refreshNum(optNum)
	if self._impl then
		if self:isEnd() or self:isStart() then
			local hp = self._mo:curHP()

			self._impl:setNum(optNum or hp)
		elseif self:isCheckPoint() then
			local addStartHp = self._mo:getV3a4_AddStartHP()

			self._impl:setNum(optNum or addStartHp)
		else
			self._impl:setNum(optNum or "")
		end
	end
end

function V3a4_Chg_GameItem:playDeltaNumAnim(...)
	if self._impl then
		return self._impl:playDeltaNumAnim(...)
	end
end

function V3a4_Chg_GameItem:stopDeltaNumAnim(...)
	if self._impl then
		self._impl:stopDeltaNumAnim(...)
	end
end

function V3a4_Chg_GameItem:animatorPlayer(...)
	if self._impl then
		return self._impl:animatorPlayer(...)
	end
end

function V3a4_Chg_GameItem:setInvoked(...)
	if self._impl then
		self._impl:setInvoked(...)
	end
end

function V3a4_Chg_GameItem:_refreshIcon(optIconName)
	if self._impl then
		self._impl:setIcon(optIconName or self._mo:iconUrl())
	end
end

function V3a4_Chg_GameItem:_refreshGroup()
	if self._impl then
		self._impl:setGroup(self._mo:group())
	end
end

function V3a4_Chg_GameItem:playIdleAnim()
	if self._impl then
		self._impl:playIdleAnim()
	end
end

function V3a4_Chg_GameItem:_hideOtherPart()
	if self._impl ~= self._none then
		self._none:setActive(false)
	end

	if self._impl ~= self._start then
		self._start:setActive(false)
	end

	if self._impl ~= self._end then
		self._end:setActive(false)
	end

	if self._impl ~= self._obstacle then
		self._obstacle:setActive(false)
	end

	if self._impl ~= self._checkPoint then
		self._checkPoint:setActive(false)
	end
end

function V3a4_Chg_GameItem:asNone()
	self._impl = self._none

	self:_hideOtherPart()
end

function V3a4_Chg_GameItem:asObstacle()
	self._impl = self._obstacle

	self:_hideOtherPart()
end

function V3a4_Chg_GameItem:asStart()
	self._impl = self._start

	self:_hideOtherPart()
end

function V3a4_Chg_GameItem:asEnd()
	self._impl = self._end

	self:_hideOtherPart()
end

function V3a4_Chg_GameItem:asCheckPoint()
	self._impl = self._checkPoint

	self:_hideOtherPart()
end

function V3a4_Chg_GameItem:getPuzzleMazeObjType()
	return self._mo and self._mo:type() or ChgEnum.PuzzleMazeObjType.None
end

function V3a4_Chg_GameItem:isPoint()
	return self._mo and self._mo:objIsPoint() or false
end

function V3a4_Chg_GameItem:isLine()
	return self._mo and self._mo:objIsLine() or false
end

function V3a4_Chg_GameItem:_g_getItemByKey(key)
	local p = self:parent()

	return p:g_getItemByKey(key)
end

function V3a4_Chg_GameItem:getNeighborItemList()
	local list = {}

	local function _appendIfValid(key)
		local item = self:_g_getItemByKey(key)

		if not item then
			return
		end

		ti(list, item)
	end

	if self:isPoint() then
		local x1 = self._mo:x()
		local y1 = self._mo:y()

		for i = 1, 4 do
			local x2 = x1 + ChgEnum.dX[i]
			local y2 = y1 + ChgEnum.dY[i]

			_appendIfValid(PuzzleMazeHelper.getLineKey(x1, y1, x2, y2))
		end
	else
		local x1 = self._mo:x1()
		local y1 = self._mo:y1()
		local x2 = self._mo:x2()
		local y2 = self._mo:y2()

		_appendIfValid(PuzzleMazeHelper.getPosKey(x1, y1))
		_appendIfValid(PuzzleMazeHelper.getPosKey(x2, y2))
	end

	return list
end

function V3a4_Chg_GameItem:expectAreaList()
	if self:isObstacle() then
		return {}
	end

	local list = {}

	local function _appendIfValid(expectItem)
		if not expectItem then
			return
		end

		local hotMapObj = expectItem:mapObj()

		if not hotMapObj then
			return
		end

		if hotMapObj == self._mo then
			return
		end

		if hotMapObj:isObstacle() then
			return
		end

		ti(list, expectItem)
	end

	local neighborItemList = self:getNeighborItemList()

	for _, neighborItem in ipairs(neighborItemList) do
		_appendIfValid(neighborItem)
	end

	return list
end

function V3a4_Chg_GameItem:key()
	return self._mo:key()
end

function V3a4_Chg_GameItem:debugName()
	return self._mo:debugName()
end

function V3a4_Chg_GameItem:_clampDeltaV2ByLitmitedDir(refDeltaV2, litmitedDir)
	if not _B.hasAny(litmitedDir, ChgEnum.Dir.Right) then
		refDeltaV2.x = math.min(0, refDeltaV2.x)
	end

	if not _B.hasAny(litmitedDir, ChgEnum.Dir.Left) then
		refDeltaV2.x = math.max(0, refDeltaV2.x)
	end

	if not _B.hasAny(litmitedDir, ChgEnum.Dir.Up) then
		refDeltaV2.y = math.min(0, refDeltaV2.y)
	end

	if not _B.hasAny(litmitedDir, ChgEnum.Dir.Down) then
		refDeltaV2.y = math.max(0, refDeltaV2.y)
	end
end

function V3a4_Chg_GameItem:_diffXY(eDir, diffX, diffY)
	eDir = eDir or ChgEnum.Dir.None

	if diffX > 0 then
		eDir = _B["|"](eDir, ChgEnum.Dir.Right)
	elseif diffX < 0 then
		eDir = _B["|"](eDir, ChgEnum.Dir.Left)
	end

	if diffY > 0 then
		eDir = _B["|"](eDir, ChgEnum.Dir.Up)
	elseif diffY < 0 then
		eDir = _B["|"](eDir, ChgEnum.Dir.Down)
	end

	return eDir
end

function V3a4_Chg_GameItem:relativeDir(target)
	local eDir = ChgEnum.Dir.None

	if not target then
		return eDir
	end

	local targetMapObj = target:mapObj()
	local mapObj = self:mapObj()

	if targetMapObj:objIsPoint() then
		local targetX = targetMapObj:x()
		local targetY = targetMapObj:y()

		if mapObj:objIsPoint() then
			eDir = self:_diffXY(eDir, targetX - mapObj:x(), targetY - mapObj:y())
		else
			local cx, cy = mapObj:center()

			eDir = self:_diffXY(eDir, targetX - cx, targetY - cy)
		end
	else
		local targetCX, targetCY = targetMapObj:center()

		if mapObj:objIsPoint() then
			eDir = self:_diffXY(eDir, targetCX - mapObj:x(), targetCY - mapObj:y())
		else
			local cx, cy = mapObj:center()

			eDir = self:_diffXY(eDir, targetCX - cx, targetCY - cy)
		end
	end

	return eDir
end

function V3a4_Chg_GameItem:leftItem()
	local key = self._mo:keyOfLeft()

	return self:_g_getItemByKey(key)
end

function V3a4_Chg_GameItem:rightItem()
	local key = self._mo:keyOfRight()

	return self:_g_getItemByKey(key)
end

function V3a4_Chg_GameItem:upItem()
	local key = self._mo:keyOfUp()

	return self:_g_getItemByKey(key)
end

function V3a4_Chg_GameItem:downItem()
	local key = self._mo:keyOfDown()

	return self:_g_getItemByKey(key)
end

function V3a4_Chg_GameItem:getNeighborItemByDir(eDir)
	if eDir == ChgEnum.Dir.Down then
		return self:downItem()
	elseif eDir == ChgEnum.Dir.Up then
		return self:upItem()
	elseif eDir == ChgEnum.Dir.Left then
		return self:leftItem()
	elseif eDir == ChgEnum.Dir.Right then
		return self:rightItem()
	end
end

function V3a4_Chg_GameItem:getSpacing(optDir)
	local p = self:parent()
	local v2 = p:getSpacing()

	if not optDir or optDir == ChgEnum.Dir.None then
		return v2
	end

	if optDir == ChgEnum.Dir.Down or optDir == ChgEnum.Dir.Up then
		return v2.y
	else
		return v2.x
	end
end

function V3a4_Chg_GameItem:clampMovableDistance(eDir, value)
	return GameUtil.clamp(value, 0, self:maxMovableRangeDistance(eDir))
end

function V3a4_Chg_GameItem:maxMovableRangeDistance(eDir)
	local dict = self:getMaxMovableRangeDict()
	local v2 = dict[eDir]

	return (ChgEnum.isVertical(eDir) or nil) and (v2.y or v2.x)
end

function V3a4_Chg_GameItem:_distBtweenAndSafeAreaSize(eDir)
	local v2 = self:baseViewContainer():distBetweenVertV2()
	local distBetween, safeAreaSize
	local maxDistance = self:maxMovableRangeDistance(eDir)

	if ChgEnum.isVertical(eDir) then
		distBetween = v2.y
		safeAreaSize = self._safeArea.hh
	else
		distBetween = v2.x
		safeAreaSize = self._safeArea.hw
	end

	return distBetween, safeAreaSize, distBetween * 0.5, maxDistance
end

function V3a4_Chg_GameItem:getItemByVector(eDir, distance)
	distance = distance or 0
	eDir = eDir or ChgEnum.Dir.None

	local distBetween, safeAreaSize, halfDistBetween, maxDistance = self:_distBtweenAndSafeAreaSize(eDir)

	if distance <= safeAreaSize or eDir == ChgEnum.Dir.None then
		return self
	end

	distance = math.min(distance, maxDistance)

	local item

	if self:isPoint() then
		local stepToPt, line = math.modf(distance / distBetween)
		local stepToLine = distBetween * line
		local _, newX, newY = self._mo:stepOfDir(eDir, stepToPt)

		newX, newY = self:_clampKey(newX, newY)

		local key = PuzzleMazeHelper.getPosKey(newX, newY)

		item = self:_g_getItemByKey(key)

		if stepToLine <= safeAreaSize then
			return item
		else
			return item:getNeighborItemByDir(eDir) or item
		end
	else
		if distance < halfDistBetween - safeAreaSize then
			return self
		end

		distance = distance - halfDistBetween

		local ptItem = self:getNeighborItemByDir(eDir)

		if not ptItem then
			return self
		end

		return ptItem:getItemByVector(eDir, distance)
	end
end

function V3a4_Chg_GameItem:_clampKey(...)
	return self:baseViewContainer():clampKey(...)
end

local kZeroV2 = {
	x = 0,
	y = 0
}

function V3a4_Chg_GameItem:getMaxMovableRangeDict()
	if self._cacheMaxMovableRange then
		return self._cacheMaxMovableRange
	end

	local curX, curY = self:getLineItemAPos()

	local function _getItem(x_, y_)
		x_, y_ = self:_clampKey(x_, y_)

		local k = PuzzleMazeHelper.getPosKey(x_, y_)

		return self:_getLineItemAPosByKey(k)
	end

	local dir2MaxRange = {}

	if self:isPoint() then
		for i = 1, 4 do
			local eDir = ChgEnum.bitPos2Dir(i - 1)
			local maxEdX = self._mo:x() + ChgEnum.dX[i] * 100
			local maxEdY = self._mo:y() + ChgEnum.dY[i] * 100
			local maxX, maxY = _getItem(maxEdX, maxEdY)
			local distX = math.abs(maxX - curX)
			local distY = math.abs(maxY - curY)

			dir2MaxRange[eDir] = {
				x = distX,
				y = distY
			}
		end
	else
		local mapObj = self:mapObj()

		if mapObj:isV() then
			dir2MaxRange[ChgEnum.Dir.Left] = kZeroV2
			dir2MaxRange[ChgEnum.Dir.Right] = kZeroV2

			local upY = mapObj:y1() + 100
			local downY = mapObj:y1() - 100
			local _, maxY = _getItem(mapObj:x1(), upY)
			local _, minY = _getItem(mapObj:x1(), downY)

			dir2MaxRange[ChgEnum.Dir.Up] = {
				x = 0,
				y = math.abs(maxY - curY)
			}
			dir2MaxRange[ChgEnum.Dir.Down] = {
				x = 0,
				y = math.abs(minY - curY)
			}
		else
			dir2MaxRange[ChgEnum.Dir.Up] = kZeroV2
			dir2MaxRange[ChgEnum.Dir.Down] = kZeroV2

			local leftX = mapObj:x1() + 100
			local rightX = mapObj:x1() - 100
			local minX, _ = _getItem(leftX, mapObj:y1())
			local maxX, _ = _getItem(rightX, mapObj:y1())

			dir2MaxRange[ChgEnum.Dir.Left] = {
				y = 0,
				x = math.abs(minX - curX)
			}
			dir2MaxRange[ChgEnum.Dir.Right] = {
				y = 0,
				x = math.abs(maxX - curX)
			}
		end
	end

	dir2MaxRange[ChgEnum.Dir.None] = kZeroV2
	self._cacheMaxMovableRange = dir2MaxRange

	return dir2MaxRange
end

function V3a4_Chg_GameItem:getItemInfoListByVector(eDir, distance)
	local infoList = {}
	local ptList = {}
	local distBetween, safeAreaSize, halfDistBetween, maxDistance = self:_distBtweenAndSafeAreaSize(eDir)

	local function _append(item, spacing, endWidth)
		if item:isPoint() then
			ti(ptList, item)
		end

		ti(infoList, {
			item = item,
			spacing = spacing or distBetween,
			endWidth = endWidth or 0
		})
	end

	_append(self)

	distance = distance or 0
	eDir = eDir or ChgEnum.Dir.None

	if distance <= safeAreaSize or eDir == ChgEnum.Dir.None then
		return infoList, ptList, 0
	end

	distance = math.min(distance, maxDistance)

	local realDistance = distance
	local curItem = self
	local kFallbak = 20

	repeat
		kFallbak = kFallbak - 1

		if kFallbak <= 0 then
			logError("stack overflow")

			break
		end

		distance = distance - halfDistBetween

		if distance < 0 then
			break
		end

		curItem = curItem:getNeighborItemByDir(eDir)

		if not curItem then
			break
		end

		_append(curItem, halfDistBetween)
	until distance < 0

	for i = 2, #infoList do
		local info = infoList[i]
		local lastInfo = infoList[i - 1]

		info.endWidth = lastInfo.endWidth + lastInfo.spacing
	end

	return infoList, ptList, realDistance
end

function V3a4_Chg_GameItem:calcDeltaV2(rhs)
	if not rhs then
		return {
			x = 0,
			y = 0
		}
	end

	local edx, edy = rhs:getLineItemAPos()
	local stx, sty = self:getLineItemAPos()

	return {
		x = edx - stx,
		y = edy - sty
	}
end

return V3a4_Chg_GameItem
