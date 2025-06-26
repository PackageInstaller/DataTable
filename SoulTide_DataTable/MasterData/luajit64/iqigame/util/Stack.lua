-- chunkname: @IQIGame\\Util\\Stack.lua

Stack = {
	Size = 0,
	__list = {}
}

function Stack.New()
	return Clone(Stack)
end

function Stack:Push(obj)
	table.insert(self.__list, obj)

	self.Size = self.Size + 1
end

function Stack:Pop()
	if self.Size == 0 then
		return nil
	end

	local tail = table.remove(self.__list, #self.__list)

	self.Size = self.Size - 1

	return tail
end

function Stack:Peek()
	return self.__list[#self.__list]
end

function Stack:Clear()
	self.__list = {}
	self.Size = 0
end
