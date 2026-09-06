-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/datastruct/Array.lua

module("logiccommon.common.datastruct.Array", package.seeall)

Array = class("Array")

function Array:ctor()
	self.size = 0
	self.items = {}
end

function Array:IsEmpty()
	return self.size <= 0
end

function Array:PushBack(val)
	self.size = self.size + 1
	self.items[self.size] = val
end

function Array:PopBack()
	if self.size > 0 then
		self.items[self.size] = nil
		self.size = self.size - 1

		return self.items[self.size]
	end

	return nil
end

function Array:PushFront(val)
	table.insert(self.items, 1, val)

	self.size = self.size + 1
end

function Array:PopFront()
	if self.size > 0 then
		local val = self.items[1]

		table.remove(self.items, 1)

		self.size = self.size - 1

		return val
	end

	return nil
end

function Array:ForEach(func)
	for i = 1, self.size do
		func(self.items[i], i)
	end
end

function Array:Get(index)
	if index < self.size then
		return self.items[index + 1]
	else
		print("Array:Get() out of index!")

		return nil
	end
end

function Array:Set(index, val)
	if index < self.size then
		self.items[index + 1] = val
	else
		print("Array:Set() out of index!")
	end
end

function Array:GetSize()
	return self.size
end

function Array:LowerSort(key_name)
	local sort_func

	table.sort(self.items, key_name and TableUtil.KeyLowerSorter(key_name) or TableUtil.ItemLowerSorter())
end

function Array:UpperSort(key_name)
	local sort_func

	table.sort(self.items, key_name and TableUtil.KeyUpperSorter(key_name) or TableUtil.ItemUpperSorter())
end

function Array:FindByKey(item_key, val, offset)
	offset = offset or 0

	for i = offset + 1, self.size do
		local item = self.items[i]

		if item[item_key] == val then
			return item, i - 1
		end
	end

	return nil, -1
end

function Array:FindByFunc(equal_func, offset)
	offset = offset or 0

	for i = offset + 1, self.size do
		local item = self.items[i]

		if equal_func(item) then
			return item, i - 1
		end
	end

	return nil, -1
end

function Array:Erase(index)
	index = index or self.size - 1

	if index >= 0 and index < self.size then
		table.remove(self.items, index + 1)

		self.size = self.size - 1
	end
end

function Array:Insert(item, index)
	index = index or 0

	table.insert(self.items, index + 1)

	self.size = self.size + 1
end

function Array.GetArray(array, begin_pos, end_pos)
	if array == nil then
		return {}
	end

	local ret = {}

	for i = begin_pos, end_pos do
		if i > #array then
			break
		end

		table.insert(ret, array[i])
	end

	return ret
end

function Array.GetArrayByScale(array, scale, length)
	if array == nil then
		return {}
	end

	local begin_pos = math.floor(#array * scale) + 1
	local end_pos = begin_pos + length - 1

	return Array.GetArray(array, begin_pos, end_pos)
end

function Array:Clear()
	if self.items == nil or self.size == 0 then
		return
	end

	self.items = nil
	self.items = {}
	self.size = 0
end

return Array
