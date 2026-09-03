-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/BattleLogger.lua

require("logging.DpsLogger")
pcall(function()
	require("dev.devConfig")
end)

local function check_array(t)
	local result = true
	local max = 0

	for i, v in pairs(t) do
		if type(i) ~= "number" then
			result = false
		end

		max = max + 1
	end

	return result, max
end

local function check_class(t)
	if type(t.class) == "table" then
		return true
	end

	return false
end

local function _prepareDumpTight(maxNesting, dump_print, dump_print_contact, indent_suffix)
	if type(maxNesting) ~= "number" then
		maxNesting = 99
	end

	indent_suffix = indent_suffix or "    "

	local lookup_table = {}
	local checkResult

	local function checkRecursive(object, prefix)
		checkResult = nil

		local lookup = lookup_table[object]

		if lookup then
			for _, path in ipairs(lookup) do
				if path == string.sub(prefix, 1, #path) then
					checkResult = path

					return true
				end
			end
		end

		return false
	end

	local function _dump(object, prefix, label, indent, nest, withoutLabel)
		if label == "class" and type(object) == "table" then
			if withoutLabel then
				dump_print(string.gsub(string.format("%s\"%s\"", indent, object:className() .. ""), " ", "_"))
			else
				dump_print(string.gsub(string.format("%s%s=\"%s\"", indent, tostring(label), object:className() .. ""), " ", "_"))
			end

			return
		end

		if type(object) ~= "table" then
			if withoutLabel then
				dump_print(string.gsub(string.format("%s%s", indent, tostring(object)), " ", ""))
			else
				dump_print(string.gsub(string.format("%s%s=%s", indent, tostring(label), tostring(object)), " ", "_"))
			end
		elseif checkRecursive(object, prefix) then
			local ref = checkResult

			if withoutLabel then
				dump_print(string.format("%s\"*REF(%s)*\"", indent, tostring(label), tostring(ref)))
			else
				dump_print(string.format("%s%s=\"*REF(%s)*\"", indent, tostring(label), tostring(ref)))
			end
		else
			local path = label

			if prefix ~= nil then
				path = prefix .. "." .. tostring(label)
			end

			local isArray, max = check_array(object)

			if nest > maxNesting then
				if withoutLabel then
					dump_print(string.format("%s{\"*MAX_NESTING*\"}", indent, label))
				else
					dump_print(string.format("%s%s=\"*MAX_NESTING*\"", indent, label))
				end
			else
				lookup_table[object] = lookup_table[object] or {}
				lookup_table[object][#lookup_table[object] + 1] = path

				if withoutLabel then
					dump_print(string.format("%s{", indent))
				else
					dump_print(string.format("%s%s={", indent, tostring(label)))
				end

				local indent2 = indent .. indent_suffix

				if isArray then
					for k, v in ipairs(object) do
						_dump(v, path, k, indent2, nest + 1, true)

						if k < max then
							dump_print_contact(",")
						end
					end
				else
					local count = 0
					local isClass = check_class(object)

					if isClass then
						max = 0

						for k, v in pairs(object) do
							if k ~= "__prototype__" and k ~= "superclass" and k ~= "_M" then
								max = max + 1
							end
						end
					end

					for k, v in pairs(object) do
						if not isClass or k ~= "__prototype__" and k ~= "superclass" and k ~= "_M" then
							_dump(v, path, k, indent2, nest + 1)

							count = count + 1

							if count < max then
								dump_print_contact(",")
							end
						end
					end
				end

				dump_print(string.format("%s}", indent))
			end
		end
	end

	return _dump
end

local function _prepareDumpJson(maxNesting, dump_print, dump_print_contact, indent_suffix)
	if type(maxNesting) ~= "number" then
		maxNesting = 99
	end

	indent_suffix = indent_suffix or "    "

	local lookup_table = {}
	local checkResult

	local function checkRecursive(object, prefix)
		checkResult = nil

		local lookup = lookup_table[object]

		if lookup then
			for _, path in ipairs(lookup) do
				if path == string.sub(prefix, 1, #path) then
					checkResult = path

					return true
				end
			end
		end

		return false
	end

	local function _dump(object, prefix, label, indent, nest, withoutLabel)
		if label == "class" and type(object) == "table" then
			if withoutLabel then
				dump_print(string.gsub(string.format("%s\"%s\"", indent, object:className() .. ""), " ", "_"))
			else
				dump_print(string.gsub(string.format("%s\"%s\":\"%s\"", indent, tostring(label), object:className() .. ""), " ", "_"))
			end

			return
		end

		if type(object) ~= "table" then
			if type(object) == "number" then
				if withoutLabel then
					dump_print(string.format("%s%s", indent, tostring(object)))
				else
					dump_print(string.format("%s\"%s\":%s", indent, tostring(label), tostring(object)))
				end
			elseif withoutLabel then
				dump_print(string.gsub(string.format("%s\"%s\"", indent, tostring(object)), " ", "_"))
			else
				dump_print(string.gsub(string.format("%s\"%s\":\"%s\"", indent, tostring(label), tostring(object)), " ", "_"))
			end
		elseif checkRecursive(object, prefix) then
			local ref = checkResult

			if withoutLabel then
				dump_print(string.format("%s\"*REF(%s)*\"", indent, tostring(ref)))
			else
				dump_print(string.format("%s\"%s\":\"*REF(%s)*\"", indent, tostring(label), tostring(ref)))
			end
		else
			local path = label

			if prefix ~= nil then
				path = prefix .. "." .. tostring(label)
			end

			local isArray, max = check_array(object)

			if nest > maxNesting then
				if withoutLabel then
					dump_print(string.format("%s{\"*MAX_NESTING*\"}", indent))
				else
					dump_print(string.format("%s\"%s\":\"*MAX_NESTING*\"", indent, label))
				end
			else
				lookup_table[object] = lookup_table[object] or {}
				lookup_table[object][#lookup_table[object] + 1] = path

				local indent2 = indent .. indent_suffix

				if isArray then
					if withoutLabel then
						dump_print(string.format("%s[", indent))
					else
						dump_print(string.format("%s\"%s\":[", indent, tostring(label)))
					end

					for k, v in ipairs(object) do
						_dump(v, path, k, indent2, nest + 1, true)

						if k < max then
							dump_print_contact(",")
						end
					end

					dump_print(string.format("%s]", indent))
				else
					if withoutLabel then
						dump_print(string.format("%s{", indent))
					else
						dump_print(string.format("%s\"%s\":{", indent, tostring(label)))
					end

					local count = 0
					local isClass = check_class(object)

					if isClass then
						max = 0

						for k, v in pairs(object) do
							if k ~= "__prototype__" and k ~= "superclass" and k ~= "_M" then
								max = max + 1
							end
						end
					end

					for k, v in pairs(object) do
						if not isClass or k ~= "__prototype__" and k ~= "superclass" and k ~= "_M" then
							count = count + 1

							_dump(v, path, tostring(k), indent2, nest + 1)

							if count < max then
								dump_print_contact(",")
							end
						end
					end

					dump_print(string.format("%s}", indent))
				end
			end
		end
	end

	return _dump
end

local function dumpsl(object, label, maxNesting)
	local arr = {}
	local _dump = _prepareDumpTight(maxNesting, function(s)
		arr[#arr + 1] = s
	end, function(s)
		arr[#arr] = arr[#arr] .. s
	end, "")

	_dump(object, nil, "var", "", 1)

	return ((label or nil) and ("\"" .. label .. "\":" or "")) .. string.sub(table.concat(arr, ""), 5)
end

local function dumpjson(object, label, maxNesting)
	local arr = {}
	local _dump = _prepareDumpJson(maxNesting, function(s)
		arr[#arr + 1] = s
	end, function(s)
		arr[#arr] = arr[#arr] .. s
	end, "")

	_dump(object, nil, "var", "", 1)

	return ((label or nil) and ("\"" .. label .. "\":" or "")) .. string.sub(table.concat(arr, ""), 7)
end

local function StringFormat(fmt, ...)
	local param = {
		...
	}
	local index = 1
	local start, ended, maxnest = string.find(fmt, "{(%d*)}")

	if start then
		while start do
			local message = type(param[index]) == "table" and dumpjson(param[index], nil, maxnest and tonumber(maxnest)) or tostring(param[index])

			fmt = string.gsub(fmt, "{%d*}", message, 1)
			index = index + 1
			start, ended, maxnest = string.find(fmt, "{(%d*)}")
		end
	else
		for _, str in ipairs(param) do
			fmt = fmt .. "," .. dumpjson(str)
		end
	end

	return fmt
end

local function FileFormat(file, line, fmt, ...)
	if type(fmt) ~= "string" then
		local param = {
			...
		}
		local result = StringFormat("[{}:{}] ", file, line) .. dumpsl(fmt)

		for _, str in ipairs(param) do
			result = result .. "," .. dumpsl(str)
		end

		return result
	end

	fmt = StringFormat("[{}:{}] ", file, line) .. fmt

	local param = {
		...
	}
	local index = 1
	local start, ended, maxnest = string.find(fmt, "{(%d*)}")

	if start then
		while start do
			local message = type(param[index]) == "table" and dumpjson(param[index], nil, maxnest and tonumber(maxnest)) or tostring(param[index])

			fmt = string.gsub(fmt, "{%d*}", message, 1)
			index = index + 1
			start, ended, maxnest = string.find(fmt, "{(%d*)}")
		end
	else
		for _, str in ipairs(param) do
			fmt = fmt .. "," .. dumpjson(str)
		end
	end

	return fmt
end

local function DumpFormat(file, line, fmt, ...)
	if type(fmt) ~= "string" then
		local param = {
			...
		}
		local result = StringFormat("[{}:{}]", file, line) .. ":" .. dumpsl(fmt)

		for _, str in ipairs(param) do
			result = result .. "," .. dumpsl(str)
		end

		print(result)
	else
		dump(StringFormat(fmt, ...), StringFormat("[{}:{}]", file, line))
	end
end

if GameConfigs and GameConfigs.battleLoggerEnable then
	BattleLogger = setmetatable({
		_stdoutEnabled = true,
		_enabled = false,
		_loggers = {}
	}, {
		__index = DpsLogger
	})

	function BattleLogger:init(path)
		self._logRoot = path
	end

	BattleLogger:init(GameConfigs.battleLoggerConfig.root)
	BattleLogger:enable()

	for _, category in ipairs(GameConfigs.battleLoggerConfig.category) do
		local appenders = {}

		for _, appender in ipairs(category.appender) do
			appenders[#appenders + 1] = appender == "File" and {
				fmtfunc = FileFormat,
				filename = category.name
			} or {
				fmtfunc = DumpFormat
			}
		end

		BattleLogger:addLogger(category.name, category.level, appenders)
	end
end
