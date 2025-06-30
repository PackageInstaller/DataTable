-- chunkname: @IQIGame\\Common\\Sorter.lua

Sorter = {
	isDesc = true
}

function Sorter.New()
	return Clone(Sorter)
end

function Sorter:Apply(list)
	local result = {}

	for i, item in pairs(list) do
		table.insert(result, item)
	end

	table.sort(result, function(tb1, tb2)
		for i, f in pairs(self.sortFunctionList) do
			local diff = f(tb1, tb2)

			if diff ~= 0 then
				if self.isDesc then
					return diff > 0
				else
					return diff < 0
				end
			end
		end

		return false
	end)

	return result
end

function Sorter:SetSortFunctionList(sortFunctionList)
	self.sortFunctionList = sortFunctionList
end

function Sorter:SwitchSortingOrder()
	self.isDesc = not self.isDesc
end

function Sorter:Reset()
	self.isDesc = Sorter.isDesc
end
