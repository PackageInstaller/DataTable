-- chunkname: @IQIGame\\Module\\Util\\InheritableClass.lua

local classTable = {}
local constructorKeyword = "ctor"
local baseKeyword = "base"
local fieldsKeyword = "__fields"

local function DeepCopy(fieldsTable, sourceTable)
	for key, value in pairs(fieldsTable) do
		if type(value) == "table" then
			local isPrototypeInstance = false
			local classPrototype = getmetatable(value)

			if classPrototype then
				local prototype = getmetatable(classPrototype)

				if prototype and prototype.__call then
					isPrototypeInstance = true
				end
			end

			sourceTable[key] = {}

			DeepCopy(value, sourceTable[key])

			if isPrototypeInstance then
				setmetatable(sourceTable[key], classPrototype)
			end
		elseif type(value) ~= "function" then
			sourceTable[key] = value
		end
	end
end

local function class(fields, baseClassPrototype)
	local classPrototype = {}

	classPrototype[fieldsKeyword] = fields
	classPrototype[baseKeyword] = baseClassPrototype
	classPrototype.__index = classPrototype

	local classMetatable = classTable.classMetatable

	if not classMetatable then
		classMetatable = {
			__call = function(classPrototypeOuter, ...)
				local obj = {}

				setmetatable(obj, classPrototypeOuter)

				local constructRecursively

				function constructRecursively(classPrototypeInner, ...)
					if not classPrototypeInner then
						return
					end

					constructRecursively(rawget(classPrototypeInner, baseKeyword), ...)

					if type(classPrototypeInner[fieldsKeyword]) == "table" then
						for fieldName, fieldValue in pairs(classPrototypeInner[fieldsKeyword]) do
							if fieldName ~= constructorKeyword and fieldName ~= baseKeyword then
								DeepCopy(classPrototypeInner[fieldsKeyword], obj)
							end
						end
					end

					local constructor = rawget(classPrototypeInner, constructorKeyword)

					if constructor then
						constructor(obj, ...)
					end
				end

				constructRecursively(classPrototypeOuter, ...)

				return obj
			end,
			__index = function(classPrototype, key)
				local baseClassPrototype = rawget(classPrototype, baseKeyword)

				if baseClassPrototype then
					return baseClassPrototype[key]
				else
					return nil
				end
			end
		}
		classTable.classMetatable = classMetatable
	end

	setmetatable(classPrototype, classMetatable)

	return classPrototype
end

return class
