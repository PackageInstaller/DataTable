-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/viewlib/usualviews/ItemFilter.lua

module("logiccommon.common.viewlib.usualviews.ItemFilter", package.seeall)

local ItemFilter = class("ItemFilter")

function ItemFilter:ctor(go, startIndex, endIndex, isIncompatible, preName, selectedName)
	self.mainGO = go
	self._startIndex = startIndex
	self._endIndex = endIndex
	self._isIncompatible = isIncompatible
	self.preName = preName or ""
	self._selectedName = selectedName or "selected"
	self._filters = {}

	for i = self._startIndex, self._endIndex do
		local childGo = goutil.findChild(self.mainGO, self.preName .. i)

		if childGo then
			local filter = {}

			filter.mainGO = childGo
			filter.imgGou = goutil.findChild(childGo, self._selectedName)
			filter.selected = false
			self._filters[i] = filter

			self:setSelectedActive(i, false)
		end
	end
end

function ItemFilter:bindEvents()
	if self._filters then
		for i, filter in pairs(self._filters) do
			GameUtil.addClickHandler(filter.mainGO, GameUtil.handler(self._onClickFilter, self, i))
		end
	end
end

function ItemFilter:unbindEvents()
	if self._filters then
		for k, v in pairs(self._filters) do
			GameUtil.rmClickHandler(v.mainGO)
		end
	end

	if self._relatedBtn then
		self._relatedBtn:RemoveClickListener()
	end

	if self._customInput then
		self._customInput:RemoveListener()
	end

	self._handle = nil
	self._handleTarget = nil
	self.dataList = nil
end

function ItemFilter:updateTxtLabel(id, label, childName)
	local filter = self._filters[id]

	if filter then
		local go = filter.mainGO
		local txt = goutil.findChildTextComponent(go, childName)

		if txt then
			txt.text = label
		end
	end
end

function ItemFilter:initData(list)
	self.dataList = list

	for k, v in pairs(list) do
		self:setSelectedActive(k, v)
	end
end

function ItemFilter:getData()
	return self.dataList
end

function ItemFilter.checkIsMatch(list, value)
	local isAllFalse = true
	local isHit = false

	if list then
		for k, v in pairs(list) do
			if v then
				isAllFalse = false
			end

			if checknumber(k) == checknumber(value) then
				isHit = v
			end
		end
	end

	return isAllFalse or isHit
end

function ItemFilter:setSelectedActive(idx, isActive)
	if self.dataList then
		self.dataList[idx] = isActive
	end

	local filter = self._filters[idx]

	if filter ~= nil then
		filter.selected = isActive

		goutil.setActive(filter.imgGou, isActive)
	end
end

function ItemFilter:setAllChecked()
	for k, v in pairs(self._filters) do
		self:setSelectedActive(k, true)
	end

	GameUtil.callBack(self._handle, self._handleTarget)
end

function ItemFilter:getIsChecked(i)
	if self._filters[i] ~= nil then
		return self._filters[i].selected
	else
		return false
	end
end

function ItemFilter:getIsAllSame()
	local flag

	for i, v in pairs(self._filters) do
		if flag == nil then
			flag = self:getIsChecked(i)
		elseif flag ~= self:getIsChecked(i) then
			return false
		end
	end

	return true
end

function ItemFilter:isMatch(value)
	local isAllFalse = true
	local isHit = false

	for k, v in pairs(self._filters) do
		if v.selected then
			isAllFalse = false
		end

		if k == value then
			isHit = v.selected
		end
	end

	return isAllFalse or isHit
end

function ItemFilter:setValueChanged(handle, handleTarget)
	self._handle = handle
	self._handleTarget = handleTarget
end

function ItemFilter:_onClickFilter(i)
	local isChecked = self:getIsChecked(i)

	self:setSelectedActive(i, not isChecked)

	if self._isIncompatible then
		for index = self._startIndex, self._endIndex do
			if i ~= index then
				self:setSelectedActive(index, false)
			end
		end
	end

	GameUtil.callBack(self._handle, self._handleTarget)
end

function ItemFilter:reset()
	for k, v in pairs(self._filters) do
		self:setSelectedActive(k, false)
	end
end

function ItemFilter:relatedToBtn(btn)
	self._relatedBtn = btn

	if btn ~= nil then
		btn:AddClickListener(function()
			self:setActive(true)
		end)

		self._customInput = UICustomInput.Get(self.mainGO)

		self._customInput:AddListener(self._onCustomInputCallback, self)
		self:setActive(false)
	end
end

function ItemFilter:_onCustomInputCallback(hover)
	if not hover then
		self:setActive(false)
	end
end

function ItemFilter:setActive(isActive)
	goutil.setActive(self.mainGO, isActive)
end

return ItemFilter
