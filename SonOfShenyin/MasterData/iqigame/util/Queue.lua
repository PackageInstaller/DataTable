-- chunkname: @IQIGame\\Util\\Queue.lua

Queue = {
	Size = 0,
	__list = {}
}

function Queue.New()
	return Clone(Queue)
end

function Queue:Enqueue(obj)
	table.insert(self.__list, obj)

	self.Size = self.Size + 1
end

function Queue:Dequeue()
	if self.Size == 0 then
		error("The size of the queue is 0.")

		return
	end

	local first = table.remove(self.__list, 1)

	self.Size = self.Size - 1

	return first
end

function Queue:Peek()
	return self.__list[1]
end

function Queue:Clear()
	self.__list = {}
	self.Size = 0
end
