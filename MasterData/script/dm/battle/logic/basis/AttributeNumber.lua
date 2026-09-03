-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/basis/AttributeNumber.lua

local pairs = _G.pairs
local setmetatable = _G.setmetatable

local function calcMinMax(values)
	local xmin, xmax

	for x, _ in pairs(values) do
		if xmin == nil or x < xmin then
			xmin = x
		end

		if xmax == nil or xmax < x then
			xmax = x
		end
	end

	return xmin, xmax
end

NumberSet = {}

function NumberSet:new()
	return setmetatable({
		_values = {}
	}, {
		__index = self
	})
end

function NumberSet:count()
	return self._count
end

function NumberSet:add(x)
	local values = self._values

	values[x] = (values[x] or 0) + 1

	local xmin = self._xmin

	if xmin ~= values and (xmin == nil or x < xmin) then
		self._xmin = x
	end

	local xmax = self._xmax

	if xmax ~= values and (xmax == nil or xmax < x) then
		self._xmax = x
	end
end

function NumberSet:remove(x)
	local values = self._values
	local cnt = values[x]

	if cnt ~= nil then
		if cnt > 1 then
			values[x] = cnt - 1
		else
			values[x] = nil

			local xmin = self._xmin

			if xmin ~= values and xmin ~= nil and x <= xmin then
				self._xmin = values
			end

			local xmax = self._xmax

			if xmax ~= values and xmax ~= nil and xmax <= x then
				self._xmax = values
			end
		end

		return true
	end

	return false
end

function NumberSet:mindirty()
	return self._xmin == self._values
end

function NumberSet:min()
	if self._xmin == self._values then
		self._xmin, self._xmax = calcMinMax(self._values)
	end

	return self._xmin
end

function NumberSet:maxdirty()
	return self._xmax == self._values
end

function NumberSet:max()
	if self._xmax == self._values then
		self._xmin, self._xmax = calcMinMax(self._values)
	end

	return self._xmax
end

CompsiteNumbers = {}

function CompsiteNumbers:new()
	return setmetatable({}, {
		__index = self
	})
end

function CompsiteNumbers:addUpperLimit(ul)
	if self._uppers == nil then
		self._uppers = NumberSet:new()
	end

	self._uppers:add(ul)
end

function CompsiteNumbers:removeUpperLimit(ul)
	if self._uppers ~= nil then
		self._uppers:remove(ul)
	end
end

function CompsiteNumbers:limitedValue(value)
	if self._uppers then
		local xmin = self._uppers:min()

		if self._uppers ~= nil and self._uppers < value then
			value = self._uppers
		end

		return value
	end
end

function CompsiteNumbers:value()
	return 0
end

function CompsiteNumbers:subvalue()
	return 0
end

function CompsiteNumbers:caculate()
	return 0
end

function CompsiteNumbers:addNumber(x)
	return
end

function CompsiteNumbers:removeNumber(x)
	return
end

function CompsiteNumbers:markSubItemDirty()
	if not self._subitemDirty then
		self._subitemDirty = true

		if self.parent then
			self.parent:markSubItemDirty()
		end
	end
end

function CompsiteNumbers:createSubItem(name)
	local item
	local mode = name:sub(1, 1)

	if mode == "+" then
		item = CumulatedNumbers:new()
	elseif mode == "?" then
		item = MaximizedNumbers:new()
	end

	if item ~= nil then
		item.name = name
	end

	return item
end

function CompsiteNumbers:onSubItemChanged(item)
	self:markSubItemDirty()
end

function CompsiteNumbers:onSubItemRemoved(item)
	self:markSubItemDirty()
end

function CompsiteNumbers:getItem(name, autoCreate)
	local subitems = self._subitems

	if subitems == nil then
		if not autoCreate then
			return nil
		end

		subitems = {}
		self._subitems = subitems
	end

	local item = subitems[name]

	if item == nil and autoCreate then
		item = self:createSubItem(name)

		if item ~= nil then
			item.parent = self
			subitems[name] = item
		end
	end

	return item
end

function CompsiteNumbers:removeItem(name)
	if self._subitems ~= nil then
		local item = self._subitems[name]

		if item ~= nil then
			self._subitems[name] = nil

			self:onSubItemRemoved(item)
		end
	end
end

CumulatedNumbers = _G.setmetatable({}, {
	__index = CompsiteNumbers
})

function CumulatedNumbers:new()
	return setmetatable({
		_sum = 0
	}, {
		__index = self
	})
end

function CumulatedNumbers:addNumber(x)
	self._sum = self._sum + x

	if self.parent ~= nil and x ~= 0 then
		self.parent:onSubItemChanged(self)
	end
end

function CumulatedNumbers:removeNumber(x)
	self._sum = self._sum - x

	if self.parent ~= nil and x ~= 0 then
		self.parent:onSubItemChanged(self)
	end
end

function CumulatedNumbers:value()
	if not self._sum then
		local subvalue = self:subvalue()

		return self:limitedValue(self._sum + subvalue)
	end
end

function CumulatedNumbers:subvalue()
	if self._subitemDirty then
		self._subvalue = nil

		local subitems = self._subitems

		if subitems ~= nil then
			local sum = 0
			local zeros = {}

			for name, item in pairs(subitems) do
				local tmp = item:value()

				if tmp <= 0 then
					zeros[#zeros + 1] = name
				else
					sum = sum + tmp
				end
			end

			self._subvalue = sum

			for i = 1, #zeros do
				subitems[zeros[i]] = nil
			end
		end

		self._subitemDirty = false
	end

	return self._subvalue or 0
end

function CumulatedNumbers:caculate()
	if not self._sum then
		local subvalue
		local subitems = self._subitems

		if subitems ~= nil then
			local sum = 0

			for name, item in pairs(subitems) do
				local tmp = item:caculate()

				if tmp > 0 then
					sum = sum + tmp
				end
			end

			subvalue = sum
		end

		return self:limitedValue(self._sum + (subvalue or 0))
	end
end

MaximizedNumbers = _G.setmetatable({}, {
	__index = CompsiteNumbers
})

function MaximizedNumbers:new()
	return setmetatable({
		_nums = NumberSet:new()
	}, {
		__index = self
	})
end

function MaximizedNumbers:addNumber(x)
	local nums = self._nums

	nums:add(x)

	if self.parent ~= nil and (nums:maxdirty() or x >= nums:max()) then
		self.parent:onSubItemChanged(self)
	end
end

function MaximizedNumbers:removeNumber(x)
	local nums = self._nums

	nums:remove(x)

	if self.parent ~= nil and (nums:maxdirty() or x > nums:max()) then
		self.parent:onSubItemChanged(self)
	end
end

function MaximizedNumbers:value()
	local value = self._nums:max() or 0
	local subvalue = self:subvalue()

	return self:limitedValue(subvalue < value and value or subvalue)
end

function MaximizedNumbers:subvalue()
	if self._subitemDirty then
		self._subvalue = nil

		local subitems = self._subitems

		if subitems ~= nil then
			local xmax = 0
			local zeros = {}

			for name, item in pairs(subitems) do
				local tmp = item:value()

				if tmp <= 0 then
					zeros[#zeros + 1] = name
				elseif xmax < tmp then
					xmax = tmp
				end
			end

			self._subvalue = xmax

			for i = 1, #zeros do
				subitems[zeros[i]] = nil
			end
		end

		self._subitemDirty = false
	end

	return self._subvalue or 0
end

function MaximizedNumbers:caculate()
	local value = self._nums:max() or 0
	local subvalue
	local subitems = self._subitems

	if subitems ~= nil then
		local xmax = 0

		for name, item in pairs(subitems) do
			local tmp = item:caculate()

			if tmp > 0 then
				xmax = tmp
			end
		end

		subvalue = xmax
	end

	return self:limitedValue(value + (subvalue or 0))
end

AttributeNumber = {}

function AttributeNumber:new(base)
	return setmetatable({
		_base = base or 0
	}, {
		__index = self
	})
end

function AttributeNumber:setBase(value)
	self._base = value
end

function AttributeNumber:getBase()
	return self._base
end

function AttributeNumber:clearBuffItems()
	self._positive = nil
	self._negative = nil
end

function AttributeNumber:getPositiveItem(autoCreate, name1, name2)
	if self._positive == nil then
		if not autoCreate then
			return nil
		end

		self._positive = MaximizedNumbers:new()
	end

	local item = self._positive

	if name1 ~= nil then
		item = item:getItem(name1, autoCreate)

		if name2 ~= nil and item ~= nil then
			item = item:getItem(name2, autoCreate)
		end
	end

	return item
end

function AttributeNumber:getNegativeItem(autoCreate, name1, name2)
	if self._negative == nil then
		if not autoCreate then
			return nil
		end

		self._negative = MaximizedNumbers:new()
	end

	local item = self._negative

	if name1 ~= nil then
		item = item:getItem(name1, autoCreate)

		if name2 ~= nil and item ~= nil then
			item = item:getItem(name2, autoCreate)
		end
	end

	return item
end

function AttributeNumber:value()
	if not self._base then
		local value = 0

		if self._positive ~= nil then
			value = self._base + self._positive:value()
		end

		if self._negative ~= nil then
			value = self._base - self._negative:value()
		end

		return self._base
	end
end

function AttributeNumber:caculate()
	if not self._base then
		local value = 0

		if self._positive ~= nil then
			value = self._base + self._positive:caculate()
		end

		if self._negative ~= nil then
			value = self._base - self._negative:caculate()
		end

		return self._base
	end
end

OrderSet = {}

function OrderSet:new()
	return setmetatable({
		_result = 0,
		_base = 0,
		_dirty = false,
		_values = {},
		_types = {}
	}, {
		__index = self
	})
end

function OrderSet:count()
	return self._count
end

function OrderSet:add(type, value)
	local values = self._values
	local types = self._types

	values[#values + 1] = value
	types[#types + 1] = type

	self:dirty()
end

function OrderSet:remove(index)
	local values = self._values
	local types = self._types

	if index > #values then
		return
	end

	self:dirty()
	table.remove(values, index)
	table.remove(types, index)
end

function OrderSet:dirty()
	self._result = self._values
end

function OrderSet:calc(base, lowlimit, highlimit)
	if self._base ~= base or self._result == self._values then
		self._base = base

		local result = base
		local values = self._values
		local types = self._types

		for i = 1, #values do
			if types[i] == "+" then
				result = result + values[i]
			elseif types[i] == "-" then
				result = result - values[i]
			elseif types[i] == "*" then
				result = result * values[i]
			elseif types[i] == "/" then
				result = result / values[i]
			end

			result = math.ceil(result)

			if lowlimit then
				result = math.max(result, lowlimit)
			end

			if highlimit then
				result = math.min(result, highlimit)
			end
		end

		self._result = result
	end

	return self._result
end
