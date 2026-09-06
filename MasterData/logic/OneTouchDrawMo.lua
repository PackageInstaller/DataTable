-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luoshiqiordeal/model/OneTouchDrawMo.lua

module("logic.extensions.luoshiqiordeal.model.OneTouchDrawMo", package.seeall)

local OneTouchDrawMo = class("OneTouchDrawMo")
local EOneTouchCellType = {
	Normal = 1,
	StartPos = 2,
	None = 0
}

function OneTouchDrawMo:ctor()
	self._levelJsonStr = ""
	self._levelObj = nil
	self._availableCellCount = 0
	self._stepRecordList = {}
	self._lineRecordList = {}
	self._lineCycleList = {}
	self._curLineMo = nil
end

function OneTouchDrawMo:init(levelJsonStr)
	self._levelJsonStr = levelJsonStr
	self._levelObj = GameUtil.jsonToTable(levelJsonStr)
	self._availableCellCount = self:_getAvailableCellCount()

	self:_clearStep()
	self:_setFirstStep()
end

function OneTouchDrawMo:isSuccessPass()
	local recordCount = #self._stepRecordList

	return self._availableCellCount == recordCount
end

function OneTouchDrawMo:reset()
	self:_clearStep()
	self:_setFirstStep()
end

function OneTouchDrawMo:getLevelObj()
	return self._levelObj
end

function OneTouchDrawMo:_getAvailableCellCount()
	local count = 0
	local list = self._levelObj.list

	for i, v in ipairs(list) do
		if v.cellType >= 1 then
			count = count + 1
		end
	end

	return count
end

function OneTouchDrawMo:_clearStep()
	self._stepRecordList = {}

	self:_clearLineRecordList()

	self._curLineMo = nil

	printInfo("test _clearStep", #self._lineRecordList)
end

function OneTouchDrawMo:_clearLineRecordList()
	if self._lineRecordList then
		local count = #self._lineRecordList

		for i = count, 1, -1 do
			self:_recycleLineMo(table.remove(self._lineRecordList, #self._lineRecordList))
		end
	else
		self._lineRecordList = {}
	end
end

function OneTouchDrawMo:_setFirstStep()
	if self._levelObj then
		local lastObj = self:getCellObjByIndex(#self._levelObj.list - 1)

		self._curLineMo = self:_getNewLineMo(lastObj.row + 1, lastObj.column + 1)

		self._curLineMo:setStartIndex(self._levelObj.startPosIndex)
		self._curLineMo:setEndIndex(self._levelObj.startPosIndex)
		table.insert(self._lineRecordList, self._curLineMo)
		self:addStep(self._levelObj.startPosIndex)
	end
end

function OneTouchDrawMo:_getNewLineMo(row, column)
	if #self._lineCycleList > 0 then
		local cls = table.remove(self._lineCycleList, #self._lineCycleList)

		cls:init(row, column)

		return cls
	else
		return OneTouchLineMo.New(row, column)
	end
end

function OneTouchDrawMo:_recycleLineMo(mo)
	table.insert(self._lineCycleList, mo)
end

function OneTouchDrawMo:_recycleLastLineMo()
	table.insert(self._lineCycleList, table.remove(self._lineRecordList, #self._lineRecordList))
end

function OneTouchDrawMo:addStep(newIndex)
	local isSuccess = false
	local count = #self._stepRecordList

	if count == 0 then
		table.insert(self._stepRecordList, newIndex)

		isSuccess = true
	else
		local curIndex = self._stepRecordList[count]
		local curObj = self:getCellObjByIndex(curIndex)

		if self:isCellAvailable(curIndex, newIndex) then
			table.insert(self._stepRecordList, newIndex)

			isSuccess = true
		end

		if isSuccess then
			local newObj = self:getCellObjByIndex(newIndex)
			local startIndex = self._curLineMo:getStartIndex()
			local startObj = self:getCellObjByIndex(startIndex)

			if startObj.row == newObj.row or startObj.column == newObj.column then
				self._curLineMo:setEndIndex(newIndex)
			else
				local endIndex = self._curLineMo:getEndIndex()
				local endObj = self:getCellObjByIndex(endIndex)

				if endObj.row == newObj.row or endObj.column == newObj.column then
					local lastObj = self:getCellObjByIndex(#self._levelObj.list - 1)

					self._curLineMo = self:_getNewLineMo(lastObj.row + 1, lastObj.column + 1)

					self._curLineMo:setStartIndex(endIndex)
					self._curLineMo:setEndIndex(newIndex)
					table.insert(self._lineRecordList, self._curLineMo)
				end
			end
		end
	end

	return isSuccess
end

function OneTouchDrawMo:removeStep(index, enterIndex)
	local isSuccess = false
	local count = #self._stepRecordList

	if count > 1 then
		local lastIndex = self._stepRecordList[count]
		local last2Index = self._stepRecordList[count - 1]

		if lastIndex == index and enterIndex == last2Index then
			table.remove(self._stepRecordList, count)

			isSuccess = true
		end
	end

	if isSuccess then
		local startIndex = self._curLineMo:getStartIndex()
		local endIndex = self._curLineMo:getEndIndex()

		if startIndex == endIndex and startIndex == index then
			self:_recycleLastLineMo()

			self._curLineMo = self._lineRecordList[#self._lineRecordList]

			if self._curLineMo:getEndIndex() == index then
				self._curLineMo:setEndIndex(enterIndex)
			end
		else
			local newEndIndex = self._stepRecordList[#self._stepRecordList]

			self._curLineMo:setEndIndex(newEndIndex)
		end
	end

	return isSuccess
end

function OneTouchDrawMo:isStepRecorded(index)
	for i, v in ipairs(self._stepRecordList) do
		if v == index then
			return true
		end
	end

	return false
end

function OneTouchDrawMo:getCurStepIndex()
	local count = #self._stepRecordList

	return self._stepRecordList[count]
end

function OneTouchDrawMo:getStepRecordList()
	return self._stepRecordList
end

function OneTouchDrawMo:getCellObjByIndex(index)
	return self._levelObj.list[index + 1]
end

function OneTouchDrawMo:isCellAvailable(curCellIndex, newCellIndex)
	if curCellIndex == newCellIndex then
		return
	end

	local newObj = self:getCellObjByIndex(newCellIndex)

	if not newObj then
		return false
	end

	if newObj.cellType == EOneTouchCellType.None or newObj.cellType == EOneTouchCellType.StartPos then
		return false
	end

	local curObj = self:getCellObjByIndex(curCellIndex)

	if not curObj then
		return
	end

	local isNear = Mathf.Abs(newObj.row - curObj.row) + Mathf.Abs(newObj.column - curObj.column) <= 1

	if not isNear then
		return false
	end

	if self:isStepRecorded(newCellIndex) then
		return false
	end

	return true
end

function OneTouchDrawMo:isCellNear(oldIndex, newIndex)
	local oldObj = self:getCellObjByIndex(oldIndex)
	local newObj = self:getCellObjByIndex(newIndex)

	return Mathf.Abs(newObj.row - oldObj.row) + Mathf.Abs(newObj.column - oldObj.column) <= 1
end

function OneTouchDrawMo:getLineRecordList()
	return self._lineRecordList
end

return OneTouchDrawMo
