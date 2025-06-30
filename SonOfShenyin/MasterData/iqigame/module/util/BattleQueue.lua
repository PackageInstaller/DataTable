-- chunkname: @IQIGame\\Module\\Util\\BattleQueue.lua

local Queue = class({
	Count = 0,
	startIndex = 1,
	__elements = {}
})

function Queue:Enqueue(element)
	table.insert(self.__elements, self.startIndex + self.Count, element)

	self.Count = self.Count + 1
	self.Current = self:Peek()
	self.Last = element
end

function Queue:Dequeue()
	if self.Count == 0 then
		return nil
	end

	local element = self.__elements[self.startIndex]

	if self.Count == 1 then
		self:Clear()

		return element
	end

	self.startIndex = self.startIndex + 1
	self.Count = self.Count - 1
	self.Current = self:Peek()

	return element
end

function Queue:Peek()
	return self.__elements[self.startIndex]
end

function Queue:RemoveLast()
	local element = self.__elements[#self.__elements]

	table.remove(self.__elements, #self.__elements)

	return element
end

function Queue:Clear()
	self.__elements = {}
	self.startIndex = 1
	self.Count = 0
	self.Current = nil
	self.Last = nil
end

local iterator

function Queue:GetEnumerator()
	local state = {
		index = 0,
		elements = self.__elements
	}

	return iterator, state
end

function iterator(state)
	state.index = state.index + 1

	if state.index > #state.elements then
		return nil
	end

	return state.elements[state.index]
end

return Queue
