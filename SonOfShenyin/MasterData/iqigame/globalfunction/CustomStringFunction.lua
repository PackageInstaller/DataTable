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

		if char_len then
			len = len + 1
			ptr = ptr + char_len
		end
	until ptr > #str

	return len
end

function string.getSubstringByBytes(str, maxBytes)
	if str == nil or str == "" then
		return str
	end

	local totalBytes = #str
	local ret = ""
	local curBytes = 0

	while curBytes < totalBytes and curBytes < maxBytes do
		local char = string.byte(str, curBytes + 1)
		local char_byte = string._getUTF8CharLength(char)

		if maxBytes >= curBytes + char_byte then
			for i = 0, char_byte - 1 do
				ret = ret .. string.char(string.byte(str, curBytes + 1 + i))
			end

			curBytes = curBytes + char_byte
		else
			return ret
		end
	end

	return ret
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
		v = tostring(v)
		formatString = string.gsub(formatString, "{" .. i - 1 .. "}", v)
	end

	return formatString
end

function string.trim(str)
	return string.gsub(str, "^%s*(.-)%s*$", "%1")
end

function StringWeidhInsert1(str, Insertsymbol, interval)
	local lenInByte = #str
	local i = lenInByte
	local result = ""
	local index = 0

	while i >= 1 do
		local curByte = string.byte(str, i)
		local byteCount = 1

		if curByte > 0 and curByte <= 127 then
			byteCount = 1
		elseif curByte >= 192 and curByte < 223 then
			byteCount = 2
		elseif curByte >= 224 and curByte < 239 then
			byteCount = 3
		elseif curByte >= 240 and curByte <= 247 then
			byteCount = 4
		end

		index = index + 1

		local char = string.sub(str, i - byteCount + 1, i)

		if index % interval == 0 and i ~= 1 then
			char = Insertsymbol .. char
		end

		result = char .. result
		i = i - byteCount
	end

	return result
end

function GetStringSubArr(str)
	local CharArr = {}
	local lenInByte = #str
	local width = 0
	local i = 1

	while i <= lenInByte do
		local curByte = string.byte(str, i)
		local byteCount = 1

		if curByte > 0 and curByte <= 127 then
			byteCount = 1
		elseif curByte >= 192 and curByte < 223 then
			byteCount = 2
		elseif curByte >= 224 and curByte < 239 then
			byteCount = 3
		elseif curByte >= 240 and curByte <= 247 then
			byteCount = 4
		end

		local char = string.sub(str, i, i + byteCount - 1)

		table.insert(CharArr, char)

		i = i + byteCount
		width = width + 1
	end

	return CharArr, width
end
