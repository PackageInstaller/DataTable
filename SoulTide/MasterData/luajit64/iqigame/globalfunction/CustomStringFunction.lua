-- chunkname: @IQIGame\\GlobalFunction\\CustomStringFunction.lua

function string._getUTF8CharLength(ch)
	local utf8_look_for_table = {
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		2,
		2,
		2,
		2,
		2,
		2,
		2,
		2,
		2,
		2,
		2,
		2,
		2,
		2,
		2,
		2,
		2,
		2,
		2,
		2,
		2,
		2,
		2,
		2,
		2,
		2,
		2,
		2,
		2,
		2,
		2,
		2,
		3,
		3,
		3,
		3,
		3,
		3,
		3,
		3,
		3,
		3,
		3,
		3,
		3,
		3,
		3,
		3,
		4,
		4,
		4,
		4,
		4,
		4,
		4,
		4,
		5,
		5,
		5,
		5,
		6,
		6,
		1,
		1
	}

	return utf8_look_for_table[ch]
end

function string.getUTF8Length(str)
	if str == nil or str == "" then
		return 0
	end

	local len = 0
	local ptr = 1

	repeat
		local char = string.byte(str, ptr)
		local char_len = string._getUTF8CharLength(char)

		len = len + 1
		ptr = ptr + char_len
	until ptr > #str

	return len
end

function string.subUTF8(str, begin, length)
	begin = begin or 1
	length = length or -1

	local ret = ""
	local len = 0
	local ptr = 1

	repeat
		local char = string.byte(str, ptr)
		local char_len = string._getUTF8CharLength(char)

		len = len + 1

		if begin <= len and (length == -1 or len < begin + length) then
			for i = 0, char_len - 1 do
				ret = ret .. string.char(string.byte(str, ptr + i))
			end
		end

		ptr = ptr + char_len
	until ptr > #str

	return ret
end

function string.formatCSharp(formatString, ...)
	local arg = {
		...
	}

	for i, v in ipairs(arg) do
		formatString = string.gsub(formatString, "{" .. i - 1 .. "}", v)
	end

	return formatString
end

function string.trim(str)
	return string.gsub(str, "^[%s\n\r\t]*(.-)[%s\n\r\t]*$", "%1")
end

function string.subUTF8Length(str, maxByte)
	local len = string.len(str)
	local subStr = ""
	local byteLen = 0
	local i = 1

	while i <= len do
		local c = string.byte(str, i)
		local byteCount = 1

		if c >= 0 and c <= 127 then
			byteCount = 1
		elseif c >= 194 and c <= 223 then
			byteCount = 2
		elseif c >= 224 and c <= 239 then
			byteCount = 3
		elseif c >= 240 and c <= 244 then
			byteCount = 4
		end

		byteLen = byteLen + byteCount

		local char = string.sub(str, i, i + byteCount - 1)

		i = i + byteCount

		if byteLen <= maxByte then
			subStr = subStr .. char
		end

		if maxByte < i then
			break
		end
	end

	if subStr == "" then
		subStr = str
	end

	return subStr
end
