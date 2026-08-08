-- SortedList contains the following functions:
--		.new(comparator) - Creates a new SortedList
--			comparator: Uses this function to compare values. If none is given, will assume the largest value is table[1]
--						Comparator should accept two values and return 1 if a > b, -1 if a < b, and 0 if a == b
--		:CreateFromTable(t, comparator) - Converts a table to a SortedList
--			comparator: The comparator to pass to SortedList.new(comparator)
--		:Merge(list1, list2) - Creates a new SortedList using the two provided SortedLists
-- A SortedList object has the following functions:
--		:Add(newValue) - Adds an element to the SortedList
--		:Pop(numValues) - Removes the first elements in the SortedList and returns them
--			numValues: The number of items to Pop(), defaults to 1
--		:Peek(numValues) - Returns the first elements in the SortedList but does not remove them
--			numValues: The number of items to Peek(), defaults to 1
--		:GetAsTable() - Returns a table of the elements in the SortedList
--		:SetComparator(comparator) - Sets the tables comparator to the new value, then sorts it
--		:Clear() - Removes all values from the SortedList
--		:Print() - Prints out all the values in the SortedList
--		:Size() - Returns the size of the SortedList
--		:Clone() - Creates and returns a new copy of the SortedList
--		:Contains(value) - Checks if the requested value is in the list. Returns the index in the list if it is, or nil if it's not. Assumes the list is sorted
--		:Sort() - Sorts the list using the comparator

local SortedList = {}
SortedList.__index = SortedList

local function DefaultCompare(a, b)
	if b > a then
		return -1
	elseif b < a then
		return 1
	else
		return 0
	end
end

local function SortCompare(node1, node2, comparator)
	if comparator(node1, node2) > 0 then
		return true
	else
		return false
	end
end

local function FindInsertionPoint(listToSearch, toInsert)
	if #listToSearch == 0 then
		return 1
	end
	
	local minIndex = 1
	local maxIndex = #listToSearch
	local mid
	
	while true do
		mid = math.floor((maxIndex+minIndex)/2)
		local compareVal = listToSearch.Compare(listToSearch[mid], toInsert)
		if compareVal == 0 then
			return mid
		elseif compareVal > 0 then
			minIndex = mid+1
			if minIndex > maxIndex then
				return mid+1
			end
		else
			maxIndex = mid-1
			if minIndex > maxIndex then
				return mid
			end
		end
	end
end

function SortedList.new(comparator)
	local newList = { }
	setmetatable(newList, SortedList)
	if comparator then
		newList.Compare = comparator
	else
		newList.Compare = DefaultCompare
	end
	
	return newList
end

function SortedList:Add(newValue)
	table.insert(self, FindInsertionPoint(self, newValue), newValue)
end

function SortedList:Pop(numValues)
	if numValues == nil or numValues == 1 then
		return table.remove(self, 1)
	end
	
	local returnVals = { }
	for i = 1, numValues do
		table.insert(returnVals, self:Pop())
	end
	
	return unpack(returnVals)
end

function SortedList:Peek(numValues)
	if numValues == nil or numValues == 1 then
		return self[1]
	end
	
	local returnVals = { }
	for i = 1, numValues do
		table.insert(returnVals, self[i])
	end
	
	return unpack(returnVals)
end

function SortedList:Print()
	print(table.concat(self, " "))
end

function SortedList:GetAsTable()
	local newTable = { }
	for i = 1, #self do
		table.insert(newTable, self[i])
	end
	return newTable
end

function SortedList:SetComparator(comparator)
	if comparator then
		self.Compare = comparator
	end
	
	self:Sort()
end

function SortedList:Clear()
	for i = #self, 1, -1 do
		table.remove(self, i)
	end
end

function SortedList:Clone()
	local newList = SortedList.new(self.Compare)
	for i = 1, #self do
		table.insert(newList, self[i])
	end
	return newList
end

function SortedList:Size()
	return #self
end

function SortedList:Contains(value)
	local ret
	local success, message = pcall(function()
		local minIndex = 1
		local maxIndex = #self
		
		while minIndex <= maxIndex do
			local mid = math.floor((maxIndex+minIndex)/2)
			
			local compareVal = self.Compare(self[mid], value)
			if compareVal == 0 then
				ret = mid
				return true
			elseif compareVal > 0 then
				minIndex = mid + 1
			else
				maxIndex = mid - 1
			end
		end
	end)
	
	return ret
end

function SortedList:Sort()
	table.sort(self, function(a, b) return SortCompare(a, b, self.Compare) end)
end

-- Functions that are not self-referential
function SortedList:Merge(list1, list2, comparator)
	if not comparator then
		comparator = list1.Compare or list2.Compare
	end
	
	local newList = SortedList.new(comparator)
	for i = 1, #list1 do
		newList:Add(list1[i])
	end
	for i = 1, #list2 do
		newList:Add(list2[i])
	end
	return newList
end

function SortedList:CreateFromTable(t, comparator)
	if not comparator then
		comparator = DefaultCompare
	end
	local newList = SortedList.new(comparator)
	for i = 1, #t do
		newList:Add(t[i])
	end
end

return SortedList
