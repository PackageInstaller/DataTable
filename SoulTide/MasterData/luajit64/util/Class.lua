﻿-- chunkname: @Util\\Class.lua

function Clone(object)
	local lookup_table = {}

	local function _copy(object)
		if type(object) ~= "table" then
			return object
		elseif lookup_table[object] then
			return lookup_table[object]
		end

		local new_table = {}

		lookup_table[object] = new_table

		for key, value in pairs(object) do
			new_table[_copy(key)] = _copy(value)
		end

		return setmetatable(new_table, getmetatable(object))
	end

	return _copy(object)
end

function Class(classname, super)
	local superType = type(super)
	local cls

	if superType ~= "function" and superType ~= "table" then
		superType = nil
		super = nil
	end

	if superType == "function" or super and super.__ctype == 1 then
		cls = {}

		if superType == "table" then
			for k, v in pairs(super) do
				cls[k] = v
			end

			cls.__create = super.__create
			cls.super = super
		else
			cls.__create = super
		end

		function cls.ctor()
			return
		end

		cls.__cname = classname
		cls.__ctype = 1

		function cls.New(...)
			local instance = cls.__create(...)

			for k, v in pairs(cls) do
				instance[k] = v
			end

			instance.class = cls

			instance:ctor(...)

			return instance
		end
	else
		if super then
			cls = clone(super)
			cls.super = super
		else
			cls = {
				ctor = function()
					return
				end
			}
		end

		cls.__cname = classname
		cls.__ctype = 2
		cls.__index = cls

		function cls.New(...)
			local instance = setmetatable({}, cls)

			instance.class = cls

			instance:ctor(...)

			return instance
		end
	end

	return cls
end
