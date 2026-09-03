-- chunkname: @/tmp/or_script/lua_compile/dm/utils/StringUtils.lua

local libCjson = require("cjson.safe")

function StringFormat(fmt, ...)
	local param = {
		...
	}
	local index = 1
	local start, ended = string.find(fmt, "{}")

	while start do
		local message = type(param[index]) == "table" and libCjson.encode(param[index]) or tostring(param[index])

		fmt = string.gsub(fmt, "{}", message, 1)
		index = index + 1
		start, ended = string.find(fmt, "{}")
	end

	return fmt
end

function FileFormat(file, line, fmt, ...)
	if type(fmt) ~= "string" then
		return StringFormat("[{}:{}] ", file, line) .. libCjson.encode(fmt)
	end

	fmt = StringFormat("[{}:{}] ", file, line) .. fmt

	local param = {
		...
	}
	local index = 1
	local start, ended = string.find(fmt, "{}")

	while start do
		local message = type(param[index]) == "table" and libCjson.encode(param[index]) or tostring(param[index])

		fmt = string.gsub(fmt, "{}", message, 1)
		index = index + 1
		start, ended = string.find(fmt, "{}")
	end

	return fmt
end

function JsonFormat(file, line, fmt, ...)
	local params = {
		...
	}

	if #params == 1 then
		params = params[1]
	end

	return libCjson.encode(params)
end

function DumpFormat(file, line, fmt, ...)
	if type(fmt) ~= "string" then
		dump(fmt, StringFormat("[{}:{}]", file, line))
	else
		dump(StringFormat(fmt, ...), StringFormat("[{}:{}]", file, line))
	end
end

local function chsize(char)
	if not char then
		print("not char", char)

		return 0
	elseif char >= 252 then
		return 6
	elseif char >= 248 then
		return 5
	elseif char >= 240 then
		return 4
	elseif char >= 224 then
		return 3
	elseif char >= 192 then
		return 2
	else
		return 1
	end
end

function utfStrToTable(str)
	local len = string.len(str)
	local startIndex = 1
	local charTable = {}

	while startIndex <= len do
		local charSize = chsize(string.byte(str, startIndex))
		local char = string.sub(str, startIndex, startIndex + charSize - 1)

		startIndex = startIndex + charSize

		table.insert(charTable, char)
	end

	return charTable
end

function utfStrToCodeTable(str)
	local len = string.len(str)
	local startIndex = 1
	local charTable = {}

	while startIndex <= len do
		local charSize = chsize(string.byte(str, startIndex))
		local char = string.sub(str, startIndex, startIndex + charSize - 1)
		local charCode = {}

		for i = 1, charSize do
			charCode[i] = string.byte(string.sub(char, i, i))
		end

		startIndex = startIndex + charSize

		table.insert(charTable, {
			char = char,
			charCode = charCode
		})
	end

	return charTable
end
