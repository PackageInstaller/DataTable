-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Control\\Scroll\\ScrollRectLoopV.lua

local UIBaseControl = require("UI/Control/Base/UIBaseControl")
local UIConst = UIConst
local strClassName = "ScrollRectLoopV"
local ScrollRectLoopV = Class(strClassName, UIBaseControl)

function ScrollRectLoopV:ctor(parent, path, totalCount, cellInitFunc)
	self.mTotalCount = totalCount or 0
	self._cellInitFunc = cellInitFunc
end

function ScrollRectLoopV:_getControlType()
	return UIConst.ControlTypeLoopScrollRectVertical
end

function ScrollRectLoopV:getComObj()
	if self._obj == nil then
		local obj = ScrollRectLoopV.super.getComObj(self)

		obj.TotalCount = self.mTotalCount

		if self._cellInitFunc ~= nil then
			self:addEventCellChanged(self._cellInitFunc)
		end
	end

	return self._obj
end

function ScrollRectLoopV:getTotalCount()
	local obj = self:getComObj()

	if obj ~= nil then
		return obj.TotalCount
	else
		return false
	end
end

function ScrollRectLoopV:setTotalCount(totalCount, jumpIdx, forceRefresh)
	local obj = self:getComObj()

	if obj ~= nil then
		if jumpIdx == true then
			jumpIdx = 1
		end

		if forceRefresh == nil then
			forceRefresh = true
		end

		obj:SetTotalCount(totalCount, jumpIdx or 0, forceRefresh)
	end
end

function ScrollRectLoopV:cancelScroll()
	local obj = self:getComObj()

	if obj then
		obj.vertical = false
		obj.horizontal = false
	end
end

function ScrollRectLoopV:openScroll(vertical, horizontal)
	local obj = self:getComObj()

	if obj then
		obj.vertical = vertical or false
		obj.horizontal = horizontal or false
	end
end

function ScrollRectLoopV:setPosToCell(index)
	local obj = self:getComObj()

	if obj ~= nil and index > 0 then
		obj:SetPosToCell(index - 1)
	end
end

function ScrollRectLoopV:goToBottom()
	local obj = self:getComObj()

	if obj ~= nil then
		obj:GoToBottom()
	end
end

function ScrollRectLoopV:goToTop()
	local obj = self:getComObj()

	if obj ~= nil then
		obj:GoToTop()
	end
end

function ScrollRectLoopV:addItem(insertIndex)
	local obj = self:getComObj()

	if obj ~= nil then
		obj:AddItem(insertIndex or self:getTotalCount() + 1)
	end
end

function ScrollRectLoopV:delItem(tgtIndex)
	local obj = self:getComObj()

	if obj ~= nil then
		obj:DelItem(tgtIndex or self:getTotalCount())
	end
end

function ScrollRectLoopV:refreshCells()
	local obj = self:getComObj()

	if obj ~= nil then
		obj:RefreshCells()
	end
end

function ScrollRectLoopV:clearPool()
	if VersionUtils.getEngineVersion() >= 113819 then
		local obj = self:getComObj()

		if obj ~= nil then
			obj:ClearPool()
		end
	end
end

function ScrollRectLoopV:clearCells()
	self:setTotalCount(0)
end

function ScrollRectLoopV:jumpToCell(index)
	return
end

function ScrollRectLoopV:scrollToCell(index, speed)
	index = math.max(0, (index or 1) - 1)
	speed = math.max(1, speed or 10000)

	local obj = self:getComObj()

	if obj ~= nil then
		obj:SrollToCell(index, speed)
	end
end

function ScrollRectLoopV:refillCells(offset, fromEnd)
	local obj = self:getComObj()

	if obj ~= nil then
		obj:RefillCells(offset or 0, fromEnd or false)
	end
end

function ScrollRectLoopV:getVerticalValue()
	local obj = self:getComObj()

	if obj ~= nil then
		return obj.verticalScrollbar.value
	end

	return -1
end

function ScrollRectLoopV:getHorizontalValue()
	local obj = self:getComObj()

	if obj ~= nil then
		return obj.horizontalScrollbar.value
	end

	return -1
end

function ScrollRectLoopV:addEventValueChanged(eventFunc)
	local obj = self:getComObj()

	if obj ~= nil then
		self:getController():AddLoopScrollRectOnValueChanged(obj, self:_packageCallback(eventFunc))
	end
end

function ScrollRectLoopV:clearEventValueChanged()
	local obj = self:getComObj()

	if obj ~= nil then
		self:getController():ClearLoopScrollRectOnValueChanged(obj)
	end
end

function ScrollRectLoopV:addEventCellChanged(eventFunc)
	local obj = self:getComObj()

	if obj ~= nil then
		self:getController():AddLoopScrollRectOnCellChanged(obj, self:_packageCallback(eventFunc))
	end
end

function ScrollRectLoopV:clearEventCellChanged()
	local obj = self:getComObj()

	if obj ~= nil then
		self:getController():ClearLoopScrollRectOnCellChanged(obj)
	end
end

function ScrollRectLoopV:setRectSize(width, height)
	if (height ~= nil or width ~= nil) and obj ~= nil then
		local oldSize = obj.transform.sizeDelta

		height = height or oldSize.y
		width = width or oldSize.x
		obj.transform.sizeDelta = UnityEngine.Vector2(width, height)
	end
end

return ScrollRectLoopV
