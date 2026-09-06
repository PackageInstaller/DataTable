-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/viewlib/scrolldraw/ScrollDrawComponent.lua

module("logiccommon.common/viewlib/scrolldraw/ScrollDrawComponent", package.seeall)

local ScrollDrawComponent = class("ScrollDrawComponent")

function ScrollDrawComponent:ctor(go)
	self:_onReset()

	self._parentGo = go.gameObject
	self._parentTr = self._parentGo.transform
	self._sizeX = self._parentTr.sizeDelta.x
	self._sizeY = self._parentTr.sizeDelta.y
	self._minSpeed = 200
end

function ScrollDrawComponent:OnDestroy()
	self:dispose()
	self:_onReset()
end

function ScrollDrawComponent:_onReset()
	self._callFunc = nil
	self._drawFinishCallFunc = nil
	self._disposeCallFunc = nil
	self._callFuncObj = nil
	self._parentGo = nil
	self._parentTr = nil
	self._cellGo = nil
	self._itemList = {}
	self._freeItemList = {}
	self._moveItems = {}
	self._isHorizontal = false
	self._space = 10
	self._outSize = 100
	self._drawTime = 2
end

function ScrollDrawComponent:dispose()
	removetimer(self._checkItemMove, self)
	removetimer(self._changeRunTime, self)
	removetimer(self._changeRewardHit, self)
	removetimer(self._drawFnish, self)
	removetimer(self._updateMoveItems, self)

	for i, item in ipairs(self._itemList) do
		self:_retrunItem(item)
	end

	for i, item in ipairs(self._freeItemList) do
		self:_invokeDisposeCallBack(item)
	end

	self._itemList = {}
end

function ScrollDrawComponent:initComponent(cellGo, itemCallFunc, drawFinishCallFunc, disposeCallFunc, callFuncObj)
	self._cellGo = cellGo
	self._callFunc = itemCallFunc
	self._disposeCallFunc = disposeCallFunc
	self._drawFinishCallFunc = drawFinishCallFunc
	self._callFuncObj = callFuncObj

	goutil.setActive(self._cellGo, false)
end

function ScrollDrawComponent:updateItems(dataList, itemSpace, isHorizontal)
	self._dataList = dataList or {}

	local len = #self._dataList

	if len < 3 then
		printError("少于3个不给用")
	end

	if isHorizontal == nil then
		isHorizontal = true
	end

	self._isHorizontal = isHorizontal
	self._runTime = 0
	self._space = math.ceil(itemSpace or self._space)
	self._isInitSuc = false

	self:_initItems(len)

	self._isInitSuc = true

	if self._needRestart then
		self._needRestart = false

		self:start(self._rewardIndex)
	end
end

function ScrollDrawComponent:_initItems(len)
	for i = 1, len do
		local item = self._itemList[i]

		item = item or self:_getFreeItem()

		self:_invokeCallBack(item, self._dataList[i])
	end

	for i = len + 1, #self._itemList do
		local item = self._itemList[i]

		self:_retrunItem(item)

		self._itemList[i] = nil
	end

	self:_setItemPos(len)
end

function ScrollDrawComponent:_setItemPos(len)
	self._centerIndex = math.floor(len / 2)

	local x = 0
	local y = 0

	for i = 1, self._centerIndex do
		x, y = self:_getItemPos(i, self._centerIndex)

		GameUtil.setAnchoredPos(self._itemList[i].gameObject, x, y)
		self:_checkOutSizeNum(x, y)
	end

	for i = self._centerIndex + 1, #self._itemList do
		x, y = self:_getItemPos(i, self._centerIndex)

		GameUtil.setAnchoredPos(self._itemList[i].gameObject, x, y)
		self:_checkOutSizeNum(x, y)
	end
end

function ScrollDrawComponent:_checkOutSizeNum(x, y)
	self._outSize = self._isHorizontal and math.max(self._outSize, x) or math.max(self._outSize, y)
end

function ScrollDrawComponent:_getItemPos(index, centerIndex)
	local x = 0
	local y = 0

	if self._isHorizontal then
		y = 0
		x = self._space * math.abs(centerIndex - index) * (index < centerIndex and -1 or 1)
	else
		x = 0
		y = self._space * math.abs(centerIndex - index) * (index < centerIndex and 1 or -1)
	end

	return x, y
end

function ScrollDrawComponent:start(rewardIndex)
	self._rewardIndex = rewardIndex

	if not rewardIndex then
		printError("没有指定中奖索引")

		return
	end

	if not self._isInitSuc then
		self._needRestart = true

		return
	end

	self._needSlow = false
	self._needStopDraw = false
	self._lastHitPos = -1
	self._onDoOutOper = false
	self._isRunCheckOut = false
	self._moveItems = {}

	for i, item in ipairs(self._itemList) do
		table.insert(self._moveItems, item)
	end

	self._firItem = self._moveItems[1]
	self._lastItem = self._moveItems[#self._moveItems]

	settimer(0, self._updateMoveItems, self, true)
	settimer(0.02, self._checkItemMove, self, true)
	settimer(0.05, self._changeRunTime, self, true)
end

function ScrollDrawComponent:_updateMoveItems()
	if self._onDoOutOper then
		return
	end

	local add = Time.deltaTime * self:_getCurrMoveSpeed()

	for i, item in ipairs(self._moveItems) do
		local x, y, z = Framework.TransformUtil.GetLocalPos(item.trans, 0, 0, 0)

		if self._isHorizontal then
			x = x - add
		else
			y = y - add
		end

		Framework.TransformUtil.SetLocalPos(item.trans, x, y, z)
	end
end

function ScrollDrawComponent:_checkItemMove()
	if self._isResetPos then
		return
	end

	if self._isRunCheckOut then
		return
	end

	self._isRunCheckOut = true

	local isOut = false
	local x, y, z = Framework.TransformUtil.GetLocalPos(self._firItem.trans, 0, 0, 0)

	if self._isHorizontal then
		if x <= -(self._outSize + self._space) then
			isOut = true
		end
	elseif y <= -(self._outSize + self._space) then
		isOut = true
	end

	self._onDoOutOper = isOut

	if isOut then
		local lx, ly, lz = Framework.TransformUtil.GetLocalPos(self._lastItem.trans, 0, 0, 0)

		if self._isHorizontal then
			lx = self._space + lx
		else
			ly = self._space + ly
		end

		Framework.TransformUtil.SetLocalPos(self._firItem.trans, lx, ly, lz)

		self._lastItem = self._firItem

		table.remove(self._moveItems, 1)
		table.insert(self._moveItems, self._firItem)

		self._firItem = self._moveItems[1]
	end

	self._onDoOutOper = false
	self._isRunCheckOut = false
end

function ScrollDrawComponent:_getCurrMoveSpeed()
	local time = self:_getRunTime()

	if time >= self._drawTime and self._needSlow then
		return self._minSpeed
	elseif time > self._drawTime * 0.8 then
		return self._minSpeed + 100
	elseif time <= self._drawTime * 0.2 then
		return self._minSpeed + 1500
	elseif time <= self._drawTime * 0.4 then
		return self._minSpeed + 1000
	elseif time <= self._drawTime * 0.6 then
		return self._minSpeed + 500
	elseif time <= self._drawTime * 0.8 then
		return self._minSpeed + 200
	else
		return self._minSpeed + 200
	end
end

function ScrollDrawComponent:_getFreeItem()
	local item = table.remove(self._freeItemList, 1)

	if item == nil then
		local go = goutil.cloneAndSetParent(self._cellGo, self._parentTr)

		item = {
			index = 0,
			gameObject = go,
			trans = go.transform
		}
	end

	table.insert(self._itemList, item)

	item.index = #self._itemList

	goutil.setActive(item.gameObject, true)

	item.gameObject.name = "movecell_" .. item.index

	return item
end

function ScrollDrawComponent:_invokeCallBack(item, data)
	if self._callFunc then
		if self._callFuncObj then
			self._callFunc(self._callFuncObj, item, data)
		else
			self._callFunc(item, data)
		end
	end
end

function ScrollDrawComponent:_invokeDisposeCallBack(item)
	if self._disposeCallFunc then
		if self._callFuncObj then
			self._disposeCallFunc(self._callFuncObj, item)
		else
			self._disposeCallFunc(item)
		end
	end
end

function ScrollDrawComponent:_retrunItem(item)
	goutil.setActive(item.gameObject, false)
	table.insert(self._freeItemList, item)
end

function ScrollDrawComponent:_changeRunTime()
	self._runTime = self._runTime + Time.deltaTime

	local time = self:_getRunTime()

	if time >= self._drawTime and not self._needStopDraw then
		self._hitItem = false

		for i, item in ipairs(self._moveItems) do
			if item.index == self._rewardIndex then
				self._hitItem = item

				break
			end
		end

		if self._hitItem then
			local x, y, z = Framework.TransformUtil.GetLocalPos(self._hitItem.trans, 0, 0, 0)

			self._lastHitPos = self._isHorizontal and x or y

			if self._lastHitPos > 0 then
				self._needStopDraw = true
				self._needSlow = true

				settimer(0, self._changeRewardHit, self, true)
			end
		else
			printError("没有找到奖励", self._rewardIndex)
		end
	end
end

function ScrollDrawComponent:_getRunTime()
	return self._runTime
end

function ScrollDrawComponent:_changeRewardHit()
	local pos = -1

	if self._hitItem then
		local isHit = false
		local x, y = Framework.TransformUtil.GetLocalPos(self._hitItem.trans, 0, 0, 0)

		if self._isHorizontal then
			pos = x
			isHit = self._lastHitPos > 0 and pos <= 0
		else
			pos = y
			isHit = self._lastHitPos > 0 and pos <= 0
		end

		if isHit then
			self:_stopDraw()
			settimer(0.5, self._drawFnish, self, false)

			return
		end
	end

	self._lastHitPos = pos
end

function ScrollDrawComponent:_drawFnish()
	if self._drawFinishCallFunc then
		if self._callFuncObj then
			self._drawFinishCallFunc(self._callFuncObj, self._rewardIndex)
		else
			self._drawFinishCallFunc(self._rewardIndex)
		end
	end
end

function ScrollDrawComponent:_stopDraw()
	removetimer(self._checkItemMove, self)
	removetimer(self._changeRunTime, self)
	removetimer(self._changeRewardHit, self)
	removetimer(self._updateMoveItems, self)
end

return ScrollDrawComponent
