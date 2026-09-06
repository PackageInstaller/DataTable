-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/starequipment/view/ItemGroup.lua

module("logic.extensions.starequipment.view.ItemGroup", package.seeall)

local ItemGroup = class("ItemGroup")

function ItemGroup:ctor(parent, cloneGo, buildHandle, buildHandleTarget, notInsertCloneGo, disposeHandle, disposeHandleTarget)
	self.mainGO = parent
	self._items = {}
	self._buildHandle = buildHandle
	self._buildHandleTarget = buildHandleTarget
	self._disposeHandle = disposeHandle
	self._disposeHandleTarget = disposeHandleTarget

	if cloneGo ~= nil then
		cloneGo:SetActive(false)

		if not notInsertCloneGo then
			self:_insertItem(cloneGo)
		end
	end

	if cloneGo == nil and parent.transform.childCount >= 1 then
		cloneGo = parent.transform:GetChild(0).gameObject

		for i = 0, parent.transform.childCount - 1 do
			self:_insertItem(parent.transform:GetChild(i).gameObject)
		end
	end

	self._cloneGo = cloneGo
end

function ItemGroup:updateWithMoArray(mos, handle, handleTarget)
	mos = mos or {}

	for i = #self._items + 1, #mos do
		if self._cloneGo ~= nil then
			self:_insertItem(goutil.cloneAndSetParent(self._cloneGo, self.mainGO.transform))
		end
	end

	for i = 1, #mos do
		local item = self._items[i]

		item.mainGO:SetActive(true)

		if handle ~= nil and handleTarget ~= nil then
			handle(handleTarget, item, mos[i], i)
		elseif handle ~= nil then
			handle(item, mos[i], i)
		end
	end

	for i = #mos + 1, #self._items do
		local item = self._items[i]

		item.mainGO:SetActive(false)
	end
end

function ItemGroup:getItems()
	return self._items
end

function ItemGroup:updateWithLen(len, handle, handleTarget)
	for _, item in ipairs(self._items) do
		item.mainGO:SetActive(false)
	end

	local i = 1

	while i <= len do
		local item = self:_getFreeItem()

		if handle ~= nil and handleTarget ~= nil then
			handle(handleTarget, item, item.index)
		elseif handle ~= nil then
			handle(item, item.index)
		end

		i = i + 1
	end
end

function ItemGroup:updateWithNoCreate(len, handle, handleTarget)
	for _, item in ipairs(self._items) do
		item.mainGO:SetActive(false)
	end

	local i = 1

	while i <= len do
		local item = self._items[i]

		if handle ~= nil and handleTarget ~= nil then
			handle(handleTarget, item, item.index)
		elseif handle ~= nil then
			handle(item, item.index)
		end

		i = i + 1
	end
end

function ItemGroup:updateWithMoMap(mos, handle, handleTarget)
	mos = mos or {}

	for _, item in ipairs(self._items) do
		if item and item.mainGO then
			item.mainGO:SetActive(false)
		end
	end

	for key, value in pairs(mos) do
		local item = self:_getFreeItem()

		if handle ~= nil and handleTarget ~= nil then
			handle(handleTarget, item, key, value)
		elseif handle ~= nil then
			handle(item, key, value)
		end
	end
end

function ItemGroup:_getFreeItem()
	local freeItem

	for i = 1, #self._items do
		if not self._items[i].mainGO.activeSelf then
			freeItem = self._items[i]

			break
		end
	end

	if freeItem == nil and self._cloneGo ~= nil then
		freeItem = self:_insertItem(goutil.cloneAndSetParent(self._cloneGo, self.mainGO.transform))
	end

	if freeItem ~= nil then
		freeItem.mainGO:SetActive(true)
	end

	return freeItem
end

function ItemGroup:_insertItem(go)
	local item = {}

	item.mainGO = go
	item.index = #self._items + 1

	if self._buildHandle ~= nil and self._buildHandleTarget ~= nil then
		self._buildHandle(self._buildHandleTarget, go, item)
	elseif self._buildHandle ~= nil then
		self._buildHandle(go, item)
	end

	go:SetActive(false)
	table.insert(self._items, item)

	return item
end

function ItemGroup:dispose(handle, handleTarget)
	for k, item in pairs(self._items) do
		if handle then
			if handleTarget then
				handle(handleTarget, item)
			else
				handle(item)
			end
		end

		if self._disposeHandle then
			if self._disposeHandleTarget then
				self._disposeHandle(self._disposeHandleTarget, item)
			else
				self._disposeHandle(item)
			end
		end
	end
end

return ItemGroup
