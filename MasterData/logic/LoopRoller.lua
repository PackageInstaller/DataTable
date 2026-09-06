-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summerlottery/view/LoopRoller.lua

module("logic.extensions.summerlottery.view.LoopRoller", package.seeall)

local LoopRoller = class("LoopRoller")

LoopRoller.Direction_L2R = 1
LoopRoller.Direction_R2L = 2
LoopRoller.Direction_T2B = 3
LoopRoller.Direction_B2T = 4
LoopRoller.WeekAlign_LeftOrTop = 1
LoopRoller.WeekAlign_MiddleOrCenter = 2
LoopRoller.WeekAlign_RightRoBottom = 3

function LoopRoller:ctor(rootGo)
	self._itemCell = goutil.findChild(rootGo, "loopItem")
	self._container = goutil.findChild(rootGo, "loopList")
	self._nobodyTxtGo = goutil.findChild(rootGo, "nobodyTxt")

	goutil.setActive(self._itemCell, false)

	self._itemPool = {}
	self._showingItems = {}
end

function LoopRoller:init(params)
	self._params = params or {}

	return self
end

function LoopRoller:reload(dataList)
	self._dataList = {}
	self._item2DataIndex = {}

	for _, data in ipairs(dataList) do
		table.insert(self._dataList, data)
	end

	local newShowItemLen = #self._dataList

	goutil.setActive(self._nobodyTxtGo, newShowItemLen <= 0)
	self:_recoverAllItem()

	local updateCellFunc = self:_getParam("updateCellFunc")
	local thisArg = self:_getParam("thisArg")

	self._direction = self:_getParam("direction", LoopRoller.Direction_R2L)
	self._margin = self:_getParam("margin", 4)

	self:setSpeed(self:_getParam("speed", 4))

	self._containerWidth = GameUtil.getWidth(self._container)
	self._containerHeight = GameUtil.getHeight(self._container)
	self._halfContainerWidth = self._containerWidth * 0.5
	self._halfContainerHeight = self._containerHeight * 0.5
	self._itemCellWidth = GameUtil.getWidth(self._itemCell)
	self._itemCellHeight = GameUtil.getHeight(self._itemCell)
	self._halfItemCellWidth = self._itemCellWidth * 0.5
	self._halfItemCellHeight = self._itemCellHeight * 0.5
	self._bNeedMove = false
	self._showLen = 0

	if self._direction == LoopRoller.Direction_L2R or self._direction == LoopRoller.Direction_R2L then
		self._bNeedMove = self._containerWidth < (self._itemCellWidth + self._margin) * newShowItemLen
		self._showLen = math.ceil(self._containerWidth / (self._itemCellWidth + self._margin)) + 3
	elseif self._direction == LoopRoller.Direction_T2B or self._direction == LoopRoller.Direction_B2T then
		self._bNeedMove = self._containerHeight < (self._itemCellHeight + self._margin) * newShowItemLen
		self._showLen = math.ceil(self._containerHeight / (self._itemCellHeight + self._margin)) + 3
	end

	self._boundary = 0

	if self._direction == LoopRoller.Direction_L2R then
		self._boundary = self._halfContainerWidth - 1 * (self._itemCellWidth + self._margin)
	elseif self._direction == LoopRoller.Direction_R2L then
		self._boundary = -(self._halfContainerWidth - 1 * (self._itemCellWidth + self._margin))
	elseif self._direction == LoopRoller.Direction_T2B then
		self._boundary = -(self._halfContainerHeight - 1 * (self._itemCellHeight + self._margin))
	elseif self._direction == LoopRoller.Direction_B2T then
		self._boundary = self._halfContainerHeight - 1 * (self._itemCellHeight + self._margin)
	end

	local weekAlign = self:_getParam("weekAlign", LoopRoller.WeekAlign_LeftOrTop)

	for i = 1, self._showLen do
		if not self._dataList[i] then
			break
		end

		local item = self:_newItem()

		table.insert(self._showingItems, item)
		self:_callBack(updateCellFunc, thisArg, item, self._dataList[i], i)

		local pos = Vector3.New(0, 0, 0)

		if self._direction == LoopRoller.Direction_L2R then
			pos.x = self._halfContainerWidth - (self._halfItemCellWidth + i * (self._itemCellWidth + self._margin))
			pos.y = weekAlign == LoopRoller.WeekAlign_LeftOrTop and self._containerHeight or weekAlign == LoopRoller.WeekAlign_MiddleOrCenter and self._halfContainerHeight or 0
		elseif self._direction == LoopRoller.Direction_R2L then
			pos.x = 0 + self._halfItemCellWidth + i * (self._itemCellWidth + self._margin)
			pos.y = weekAlign == LoopRoller.WeekAlign_LeftOrTop and self._containerHeight or weekAlign == LoopRoller.WeekAlign_MiddleOrCenter and self._halfContainerHeight or 0
		elseif self._direction == LoopRoller.Direction_T2B then
			pos.x = weekAlign == LoopRoller.WeekAlign_LeftOrTop and 0 or weekAlign == LoopRoller.WeekAlign_MiddleOrCenter and self._halfContainerWidth or self._containerWidth
			pos.y = 0 + (self._halfItemCellHeight + i * (self._itemCellHeight + self._margin))
		elseif self._direction == LoopRoller.Direction_B2T then
			pos.x = weekAlign == LoopRoller.WeekAlign_LeftOrTop and 0 or weekAlign == LoopRoller.WeekAlign_MiddleOrCenter and self._halfContainerWidth or self._containerWidth
			pos.y = self._halfItemCellHeight - i * (self._itemCellHeight + self._margin)
		end

		GameUtil.setLocalPos(item, pos.x, pos.y, pos.z)

		self._item2DataIndex[item] = i
	end

	return self
end

function LoopRoller:setSpeed(speed)
	speed = math.max(speed, 0)
	self._speedValue = speed
	self._speedVec = Vector3.New(0, 0, 0)

	if self._direction == LoopRoller.Direction_L2R then
		self._speedVec.x = speed
	elseif self._direction == LoopRoller.Direction_R2L then
		self._speedVec.x = -speed
	elseif self._direction == LoopRoller.Direction_T2B then
		self._speedVec.y = -speed
	elseif self._direction == LoopRoller.Direction_B2T then
		self._speedVec.y = speed
	end
end

function LoopRoller:stop()
	self._bPlaying = false

	removetimer(self._tick, self)

	return self
end

function LoopRoller:play()
	self:stop()

	self._bPlaying = true

	settimer(0.01, self._tick, self)

	return self
end

function LoopRoller:dispose()
	self:_recoverAllItem()
	self:stop()
end

function LoopRoller:_tick()
	if not self._bNeedMove then
		return
	end

	if not self._bPlaying then
		return
	end

	local speedVec = self._speedVec:Clone()
	local bOutOfBound = false

	for i = #self._showingItems, 1, -1 do
		local item = self._showingItems[i]

		if self:_doMove(speedVec, item) then
			bOutOfBound = true
		end
	end

	if bOutOfBound then
		local updateCellFunc = self:_getParam("updateCellFunc")
		local thisArg = self:_getParam("thisArg")

		for i = #self._showingItems, 1, -1 do
			local item = self._showingItems[i]

			self:_shift(item)

			local nextDataIndex = self._item2DataIndex[item] + 1

			if nextDataIndex > #self._dataList then
				nextDataIndex = 1
			end

			self:_callBack(updateCellFunc, thisArg, item, self._dataList[nextDataIndex], i)

			self._item2DataIndex[item] = nextDataIndex
		end
	end
end

function LoopRoller:_doMove(speedVec, item)
	local pos = GameUtil.getLocalPos(item)

	pos = pos + speedVec

	GameUtil.setLocalPos(item, pos.x, pos.y, pos.z)

	if self._direction == LoopRoller.Direction_L2R then
		if pos.x >= self._boundary then
			return true
		end
	elseif self._direction == LoopRoller.Direction_R2L then
		if pos.x <= self._boundary then
			return true
		end
	elseif self._direction == LoopRoller.Direction_T2B then
		if pos.y <= self._boundary then
			return true
		end
	elseif self._direction == LoopRoller.Direction_B2T and pos.y >= self._boundary then
		return true
	end
end

function LoopRoller:_shift(item)
	local pos = GameUtil.getLocalPos(item)

	if self._direction == LoopRoller.Direction_L2R then
		pos.x = pos.x - (self._itemCellWidth + self._margin)
	elseif self._direction == LoopRoller.Direction_R2L then
		pos.x = pos.x + (self._itemCellWidth + self._margin)
	elseif self._direction == LoopRoller.Direction_T2B then
		pos.y = pos.y + (self._itemCellHeight + self._margin)
	elseif self._direction == LoopRoller.Direction_B2T then
		pos.y = pos.y - (self._itemCellHeight + self._margin)
	end

	GameUtil.setLocalPos(item, pos.x, pos.y, pos.z)
end

function LoopRoller:_newItem()
	local item = #self._itemPool > 0 and table.remove(self._itemPool, #self._itemPool) or goutil.cloneAndSetParent(self._itemCell, self._container.transform)

	goutil.setActive(item, true)

	return item
end

function LoopRoller:_recoverItem(item)
	if not goutil.isNil(item) then
		goutil.setActive(item, false)
		table.insert(self._itemPool, item)
	end
end

function LoopRoller:_recoverAllItem()
	local removeCellFunc = self:_getParam("removeCellFunc")
	local thisArg = self:_getParam("thisArg")

	for _, item in ipairs(self._showingItems) do
		self:_recoverItem(item)
		self:_callBack(removeCellFunc, thisArg, item)
	end

	self._showingItems = {}
end

function LoopRoller:_getParam(key, defaultValue)
	if self._params[key] ~= nil then
		return self._params[key]
	end

	return defaultValue
end

function LoopRoller:_callBack(func, thisArg, ...)
	if func and type(func) == "function" then
		local args = {
			...
		}

		if thisArg then
			func(thisArg, unpack(args))
		else
			func(unpack(args))
		end
	end
end

return LoopRoller
