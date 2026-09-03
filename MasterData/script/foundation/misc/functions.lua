-- chunkname: @/tmp/or_script/lua_compile/foundation/misc/functions.lua

local print = _G.print

function cclog(...)
	print(...)
end

function cclogf(fmt, ...)
	print(string.format(fmt, ...))
end

local function _prepareDump(maxNesting, dump_print)
	if type(maxNesting) ~= "number" then
		maxNesting = 99
	end

	local lookup_table = {}

	local function _dump(object, prefix, label, indent, nest)
		if label == "class" and type(object) == "table" then
			dump_print(string.format("%s%s = %s", indent, tostring(label), object:className() .. ""))

			return
		end

		if type(object) ~= "table" then
			dump_print(string.format("%s%s = %s", indent, tostring(label), tostring(object)))
		elseif lookup_table[object] ~= nil then
			local ref = lookup_table[object]

			dump_print(string.format("%s%s = *REF(%s)*", indent, tostring(label), tostring(ref)))
		else
			local path = label

			if prefix ~= nil then
				path = prefix .. "." .. tostring(label)
			end

			lookup_table[object] = path

			if nest > maxNesting then
				dump_print(string.format("%s%s = *MAX NESTING*", indent, label))
			else
				dump_print(string.format("%s%s = {", indent, tostring(label)))

				local indent2 = indent .. "    "

				for k, v in pairs(object) do
					_dump(v, path, k, indent2, nest + 1)
				end

				dump_print(string.format("%s}", indent))
			end
		end
	end

	return _dump
end

function dump(object, label, maxNesting, print)
	local _dump = _prepareDump(maxNesting, print or _G.print)

	_dump(object, nil, label or "var", "- ", 1)
end

function dumps(object, label, maxNesting)
	local arr = {}
	local _dump = _prepareDump(maxNesting, function(s)
		arr[#arr + 1] = s
	end)

	_dump(object, nil, label or "var", "- ", 1)

	return table.concat(arr, "\n")
end

function bind(f, ...)
	local prev_args, argc = {
		...
	}, select("#", ...)

	return function(...)
		local args = {
			unpack(prev_args, 1, argc)
		}
		local args2, argc2 = {
			...
		}, select("#", ...)

		for i = 1, argc2 do
			args[argc + i] = args2[i]
		end

		return f(unpack(args, 1, argc + argc2))
	end
end

function bind1(f, arg1)
	return function(...)
		return f(arg1, ...)
	end
end

function bind2(f, arg1, arg2)
	return function(...)
		return f(arg1, arg2, ...)
	end
end

function bind3(f, arg1, arg2, arg3)
	return function(...)
		return f(arg1, arg2, arg3, ...)
	end
end

function bind4(f, arg1, arg2, arg3, arg4)
	return function(...)
		return f(arg1, arg2, arg3, arg4, ...)
	end
end

function bind5(f, arg1, arg2, arg3, arg4, arg5)
	return function(...)
		return f(arg1, arg2, arg3, arg4, arg5, ...)
	end
end

function memorize(f)
	local mem = {}

	setmetatable(mem, {
		mode = "kv"
	})

	return function(x)
		local r = mem[x]

		if r == nil then
			r = f(x)
			mem[x] = r
		end

		return r
	end
end

function easyIterator(f, s, var)
	if f == nil then
		return nil
	end

	local _s, _var = s, var

	return function()
		local results = {
			f(_s, _var)
		}

		_var = results[1]

		return unpack(results, 1, table.maxn(results))
	end
end

function firstOf(f, s, var)
	if f == nil then
		return nil
	end

	local _, elem = f(s, var)

	return elem
end

local __xmlESCMap = {
	[">"] = "&gt;",
	["'"] = "&apos;",
	["<"] = "&lt;",
	["&"] = "&amp;",
	["\""] = "&quot;"
}

function xmlEscape(str)
	return (string.gsub(str, "([&'\"><])", function(c)
		return __xmlESCMap[c] or c
	end))
end

local __xmlUNESCMap = {
	["&apos;"] = "'",
	["&lt;"] = "<",
	["&gt;"] = ">",
	["&amp;"] = "&",
	["&quot;"] = "\""
}

function xmlUnescape(str)
	return (string.gsub(str, "(&%w+;)", function(s)
		return __xmlUNESCMap[s] or s
	end))
end

function c3bFromHtmlColor(colorCode)
	return cc.c3b(tonumber(string.sub(colorCode, 2, 3), 16), tonumber(string.sub(colorCode, 4, 5), 16), tonumber(string.sub(colorCode, 6, 7), 16))
end

function c3bToHtmlColor(color)
	return string.format("#%02x%02x%02x", color.r, color.g, color.b)
end
