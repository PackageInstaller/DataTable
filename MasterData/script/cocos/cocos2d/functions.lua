-- chunkname: @/tmp/or_script/lua_compile/cocos/cocos2d/functions.lua

function printLog(tag, fmt, ...)
	local t = {
		"[",
		string.upper(tostring(tag)),
		"] ",
		string.format(tostring(fmt), ...)
	}

	print(table.concat(t))
end

function printError(fmt, ...)
	printLog("ERR", fmt, ...)
	print(debug.traceback("", 2))
end

function printInfo(fmt, ...)
	if type(DEBUG) ~= "number" or DEBUG < 2 then
		return
	end

	printLog("INFO", fmt, ...)
end

local function dump_value_(v)
	if type(v) == "string" then
		v = "\"" .. v .. "\""
	end

	return tostring(v)
end

function dump(value, desciption, nesting)
	if type(nesting) ~= "number" then
		nesting = 3
	end

	local lookupTable = {}
	local result = {}
	local traceback = string.split(debug.traceback("", 2), "\n")

	print("dump from: " .. string.trim(traceback[3]))

	local function dump_(value, desciption, indent, nest, keylen)
		desciption = desciption or "<var>"

		local spc = ""

		if type(keylen) == "number" then
			spc = string.rep(" ", keylen - string.len(dump_value_(desciption)))
		end

		if type(value) ~= "table" then
			result[#result + 1] = string.format("%s%s%s = %s", indent, dump_value_(desciption), spc, dump_value_(value))
		elseif lookupTable[tostring(value)] then
			result[#result + 1] = string.format("%s%s%s = *REF*", indent, dump_value_(desciption), spc)
		else
			lookupTable[tostring(value)] = true

			if nest > nesting then
				result[#result + 1] = string.format("%s%s = *MAX NESTING*", indent, dump_value_(desciption))
			else
				result[#result + 1] = string.format("%s%s = {", indent, dump_value_(desciption))

				local indent2 = indent .. "    "
				local keys = {}
				local keylen = 0
				local values = {}

				for k, v in pairs(value) do
					keys[#keys + 1] = k

					local vk = dump_value_(k)
					local vkl = string.len(vk)

					if keylen < vkl then
						keylen = vkl
					end

					values[k] = v
				end

				table.sort(keys, function(a, b)
					if type(a) == "number" and type(b) == "number" then
						return a < b
					else
						return tostring(a) < tostring(b)
					end
				end)

				for i, k in ipairs(keys) do
					dump_(values[k], k, indent2, nest + 1, keylen)
				end

				result[#result + 1] = string.format("%s}", indent)
			end
		end
	end

	dump_(value, desciption, "- ", 1)

	for i, line in ipairs(result) do
		print(line)
	end
end

function printf(fmt, ...)
	print(string.format(tostring(fmt), ...))
end

function checknumber(value, base)
	return tonumber(value, base) or 0
end

function checkint(value)
	return math.round(checknumber(value))
end

function checkbool(value)
	return value ~= nil and value ~= false
end

function checktable(value)
	if type(value) ~= "table" then
		value = {}
	end

	return value
end

function isset(hashtable, key)
	local t = type(hashtable)

	return (t == "table" or t == "userdata") and hashtable[key] ~= nil
end

local setmetatableindex_

function setmetatableindex_(t, index)
	if type(t) == "userdata" then
		local peer = tolua.getpeer(t)

		if not peer then
			peer = {}

			tolua.setpeer(t, peer)
		end

		setmetatableindex_(peer, index)
	else
		local mt = getmetatable(t)

		mt = mt or {}

		if not mt.__index then
			mt.__index = index

			setmetatable(t, mt)
		elseif mt.__index ~= index then
			setmetatableindex_(mt, index)
		end
	end
end

setmetatableindex = setmetatableindex_

function clone(object)
	local lookup_table = {}

	local function _copy(object)
		if type(object) ~= "table" then
			return object
		elseif lookup_table[object] then
			return lookup_table[object]
		end

		local newObject = {}

		lookup_table[object] = newObject

		for key, value in pairs(object) do
			newObject[_copy(key)] = _copy(value)
		end

		return setmetatable(newObject, getmetatable(object))
	end

	return _copy(object)
end

function cclass(classname, ...)
	local cls = {
		__cname = classname
	}
	local supers = {
		...
	}

	for _, super in ipairs(supers) do
		local superType = type(super)

		assert(superType == "nil" or superType == "table" or superType == "function", string.format("cclass() - create class \"%s\" with invalid super class type \"%s\"", classname, superType))

		if superType == "function" then
			assert(cls.__create == nil, string.format("cclass() - create class \"%s\" with more than one creating function", classname))

			cls.__create = super
		elseif superType == "table" then
			if super[".isclass"] then
				assert(cls.__create == nil, string.format("cclass() - create class \"%s\" with more than one creating function or native class", classname))

				function cls.__create()
					return super:create()
				end
			else
				cls.__supers = cls.__supers or {}
				cls.__supers[#cls.__supers + 1] = super
				cls.super = cls.super or super
			end
		else
			error(string.format("cclass() - create class \"%s\" with invalid super type", classname), 0)
		end
	end

	cls.__index = cls

	if not cls.__supers or #cls.__supers == 1 then
		setmetatable(cls, {
			__index = cls.super
		})
	else
		setmetatable(cls, {
			__index = function(_, key)
				local supers = cls.__supers

				for i = 1, #supers do
					local super = supers[i]

					if super[key] then
						return super[key]
					end
				end
			end
		})
	end

	local function cls_new(...)
		local instance = cls.__create and cls.__create(...) or {}

		setmetatableindex(instance, cls)

		instance.class = cls

		if instance.ctor ~= nil then
			instance:ctor(...)
		elseif instance.initialize ~= nil then
			instance:initialize(...)
		end

		return instance
	end

	function cls.new(a1, ...)
		if a1 == cls then
			return cls_new(...)
		else
			return cls_new(a1, ...)
		end
	end

	function cls.create(_, ...)
		return cls_new(...)
	end

	return cls
end

local iskindof_

function iskindof_(cls, name)
	local __index = rawget(cls, "__index")

	if type(__index) == "table" and rawget(__index, "__cname") == name then
		return true
	end

	if rawget(cls, "__cname") == name then
		return true
	end

	local __supers = rawget(cls, "__supers")

	if not __supers then
		return false
	end

	for _, super in ipairs(__supers) do
		if iskindof_(super, name) then
			return true
		end
	end

	return false
end

function iskindof(obj, classname)
	local t = type(obj)

	if t ~= "table" and t ~= "userdata" then
		return false
	end

	local mt

	if t == "userdata" then
		if tolua.iskindof(obj, classname) then
			return true
		end

		mt = tolua.getpeer(obj)
	else
		mt = getmetatable(obj)
	end

	if mt then
		return iskindof_(mt, classname)
	end

	return false
end

function import(moduleName, currentModuleName)
	local currentModuleNameParts
	local moduleFullName = moduleName
	local offset = 1

	while true do
		if string.byte(moduleName, offset) ~= 46 then
			moduleFullName = string.sub(moduleName, offset)

			if currentModuleNameParts and #currentModuleNameParts > 0 then
				moduleFullName = table.concat(currentModuleNameParts, ".") .. "." .. moduleFullName
			end

			break
		end

		offset = offset + 1

		if not currentModuleNameParts then
			if not currentModuleName then
				local n, v = debug.getlocal(3, 1)

				currentModuleName = v
			end

			currentModuleNameParts = string.split(currentModuleName, ".")
		end

		table.remove(currentModuleNameParts, #currentModuleNameParts)
	end

	return require(moduleFullName)
end

function handler(obj, method)
	return function(...)
		return method(obj, ...)
	end
end

function math.newrandomseed()
	local ok, socket = pcall(function()
		return require("socket")
	end)

	if ok then
		math.randomseed(socket.gettime() * 1000)
	else
		math.randomseed(os.time())
	end

	math.random()
	math.random()
	math.random()
	math.random()
end

function math.round(value)
	value = checknumber(value)

	return math.floor(value + 0.5)
end

local pi_div_180 = math.pi / 180

function math.angle2radian(angle)
	return angle * pi_div_180
end

local inv_pi_div_180 = 180 / math.pi

function math.radian2angle(radian)
	return radian * inv_pi_div_180
end

function io.exists(path)
	local file = io.open(path, "r")

	if file then
		io.close(file)

		return true
	end

	return false
end

function io.readfile(path)
	local file = io.open(path, "r")

	if file then
		local content = file:read("*a")

		io.close(file)

		return content
	end

	return nil
end

function io.writefile(path, content, mode)
	mode = mode or "w+b"

	local file = io.open(path, mode)

	if file then
		if file:write(content) == nil then
			return false
		end

		io.close(file)

		return true
	else
		return false
	end
end

function io.pathinfo(path)
	local pos = string.len(path)
	local extpos = pos + 1

	while pos > 0 do
		local b = string.byte(path, pos)

		if b == 46 then
			extpos = pos
		elseif b == 47 then
			break
		end

		pos = pos - 1
	end

	local dirname = string.sub(path, 1, pos)
	local filename = string.sub(path, pos + 1)

	extpos = extpos - pos

	local basename = string.sub(filename, 1, extpos - 1)
	local extname = string.sub(filename, extpos)

	return {
		dirname = dirname,
		filename = filename,
		basename = basename,
		extname = extname
	}
end

function io.filesize(path)
	local size = false
	local file = io.open(path, "r")

	if file then
		local current = file:seek()

		size = file:seek("end")

		file:seek("set", current)
		io.close(file)
	end

	return size
end

function table.nums(t)
	local count = 0

	for k, v in pairs(t) do
		count = count + 1
	end

	return count
end

function table.keys(hashtable)
	local keys = {}

	for k, v in pairs(hashtable) do
		keys[#keys + 1] = k
	end

	return keys
end

function table.values(hashtable)
	local values = {}

	for k, v in pairs(hashtable) do
		values[#values + 1] = v
	end

	return values
end

function table.merge(dest, src)
	for k, v in pairs(src) do
		dest[k] = v
	end
end

function table.insertto(dest, src, begin)
	begin = checkint(begin)

	if begin <= 0 then
		begin = #dest + 1
	end

	local len = #src

	for i = 0, len - 1 do
		dest[i + begin] = src[i + 1]
	end
end

function table.indexof(array, value, begin)
	for i = begin or 1, #array do
		if array[i] == value then
			return i
		end
	end

	return false
end

function table.keyof(hashtable, value)
	for k, v in pairs(hashtable) do
		if v == value then
			return k
		end
	end

	return nil
end

function table.removebyvalue(array, value, removeall)
	local c, i, max = 0, 1, #array

	while i <= max do
		if array[i] == value then
			table.remove(array, i)

			c = c + 1
			i = i - 1
			max = max - 1

			if not removeall then
				break
			end
		end

		i = i + 1
	end

	return c
end

function table.map(t, fn)
	for k, v in pairs(t) do
		t[k] = fn(v, k)
	end
end

function table.walk(t, fn)
	for k, v in pairs(t) do
		fn(v, k)
	end
end

function table.filter(t, fn)
	for k, v in pairs(t) do
		if not fn(v, k) then
			t[k] = nil
		end
	end
end

function table.unique(t, bArray)
	local check = {}
	local n = {}
	local idx = 1

	for k, v in pairs(t) do
		if not check[v] then
			if bArray then
				n[idx] = v
				idx = idx + 1
			else
				n[k] = v
			end

			check[v] = true
		end
	end

	return n
end

string._htmlspecialchars_set = {}
string._htmlspecialchars_set["&"] = "&amp;"
string._htmlspecialchars_set["\""] = "&quot;"
string._htmlspecialchars_set["'"] = "&#039;"
string._htmlspecialchars_set["<"] = "&lt;"
string._htmlspecialchars_set[">"] = "&gt;"

function string.htmlspecialchars(input)
	for k, v in pairs(string._htmlspecialchars_set) do
		input = string.gsub(input, k, v)
	end

	return input
end

function string.restorehtmlspecialchars(input)
	for k, v in pairs(string._htmlspecialchars_set) do
		input = string.gsub(input, v, k)
	end

	return input
end

function string.nl2br(input)
	return string.gsub(input, "\n", "<br />")
end

function string.text2html(input)
	input = string.gsub(input, "\t", "    ")
	input = string.htmlspecialchars(input)
	input = string.gsub(input, " ", "&nbsp;")
	input = string.nl2br(input)

	return input
end

function string.split(input, delimiter)
	input = tostring(input)
	delimiter = tostring(delimiter)

	if delimiter == "" then
		return false
	end

	local pos, arr = 0, {}

	for st, sp in function()
		return string.find(input, delimiter, pos, true)
	end do
		table.insert(arr, string.sub(input, pos, st - 1))

		pos = sp + 1
	end

	table.insert(arr, string.sub(input, pos))

	return arr
end

function string.ltrim(input)
	return string.gsub(input, "^[ \t\n\r]+", "")
end

function string.rtrim(input)
	return string.gsub(input, "[ \t\n\r]+$", "")
end

function string.trim(input)
	input = string.gsub(input, "^[ \t\n\r]+", "")

	return string.gsub(input, "[ \t\n\r]+$", "")
end

function string.ucfirst(input)
	return string.upper(string.sub(input, 1, 1)) .. string.sub(input, 2)
end

local function urlencodechar(char)
	return "%" .. string.format("%02X", string.byte(char))
end

function string.urlencode(input)
	input = string.gsub(tostring(input), "\n", "\r\n")
	input = string.gsub(input, "([^%w%.%- ])", urlencodechar)

	return string.gsub(input, " ", "+")
end

function string.urldecode(input)
	input = string.gsub(input, "+", " ")
	input = string.gsub(input, "%%(%x%x)", function(h)
		return string.char(checknumber(h, 16))
	end)
	input = string.gsub(input, "\r\n", "\n")

	return input
end

function string.utf8len(input)
	local left = string.len(input)
	local cnt = 0
	local arr = {
		0,
		192,
		224,
		240,
		248,
		252
	}

	while left ~= 0 do
		local tmp = string.byte(input, -left)
		local i = #arr

		while arr[i] do
			if tmp >= arr[i] then
				left = left - i

				break
			end

			i = i - 1
		end

		cnt = cnt + 1
	end

	return cnt
end

function string.formatnumberthousands(num)
	local formatted = tostring(checknumber(num))
	local k

	repeat
		local var_65_0, var_65_1 = string.gsub(formatted, "^(-?%d+)(%d%d%d)", "%1,%2")

		formatted = var_65_0
	until var_65_1 == 0

	return formatted
end

function schedule(node, callback, delay, tag)
	local delay = cc.DelayTime:create(delay)
	local sequence = cc.Sequence:create(delay, cc.CallFunc:create(callback))
	local action = cc.RepeatForever:create(sequence)

	if tag then
		action:setTag(tag)
	end

	node:runAction(action)

	return action
end

function performWithDelay(node, callback, delay)
	local delay = cc.DelayTime:create(delay)
	local sequence = cc.Sequence:create(delay, cc.CallFunc:create(callback))

	node:runAction(sequence)

	return sequence
end
