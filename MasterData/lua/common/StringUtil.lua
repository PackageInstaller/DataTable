--[[
-- added by wsh @ 2017-12-18
-- string扩展工具类，对string不支持的功能执行扩展
--]]

local unpack = unpack or table.unpack

-- 字符串分割
-- @split_string：被分割的字符串
-- @pattern：分隔符，可以为模式匹配
-- @init：起始位置
-- @plain：为true禁用pattern模式匹配；为false则开启模式匹配
local function split(split_string, pattern, search_pos_begin, plain)
	split_string = tostring(split_string)
	assert(type(split_string) == "string")
	assert(type(pattern) == "string" and #pattern > 0)
	search_pos_begin = search_pos_begin or 1
	plain = plain or true
	local split_result = {}

	while true do
		local find_pos_begin, find_pos_end = string.find(split_string, pattern, search_pos_begin, plain)
		if not find_pos_begin then
			break
		end
		local cur_str = ""
		if find_pos_begin > search_pos_begin then
			cur_str = string.sub(split_string, search_pos_begin, find_pos_begin - 1)
		end
		split_result[#split_result + 1] = cur_str
		search_pos_begin = find_pos_end + 1
	end

	if search_pos_begin <= string.len(split_string) then
		split_result[#split_result + 1] = string.sub(split_string, search_pos_begin)
	else
		split_result[#split_result + 1] = ""
	end

	return split_result
end

-- 字符串连接
local function join(join_table, joiner)
	if #join_table == 0 then
		return ""
	end

	local fmt = "%s"
	for i = 2, #join_table do
		fmt = fmt .. joiner .. "%s"
	end

	return string.format(fmt, unpack(join_table))
end

-- 是否包含
-- 注意：plain为true时，关闭模式匹配机制，此时函数仅做直接的 “查找子串”的操作
local function contains(target_string, pattern, plain)
	plain = plain or true
	local find_pos_begin, find_pos_end = string.find(target_string, pattern, 1, plain)
	return find_pos_begin ~= nil
end

-- 以某个字符串开始
local function startswith(target_string, start_pattern, plain)
	plain = plain or true
	local find_pos_begin, find_pos_end = string.find(target_string, start_pattern, 1, plain)
	return find_pos_begin == 1
end

-- 以某个字符串结尾
local function endswith(target_string, start_pattern, plain)
	plain = plain or true
	local find_pos_begin, find_pos_end = string.find(target_string, start_pattern, -#start_pattern, plain)
	return find_pos_end == #target_string
end

local function IsNullOrEmpty(target_string)
	return target_string == nil or #target_string == 0
end

local function utf8len(input)
	local len  = string.len(input)
	local left = len
	local cnt  = 0
	local arr  = {0, 0xc0, 0xe0, 0xf0, 0xf8, 0xfc}
	while left ~= 0 do
		local tmp = string.byte(input, -left)
		local i   = #arr
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

local function toarray(input)
	local lenInByte = #input
	local arr = {}
	local index = 0
	for i = 1, lenInByte do
		local curByte = string.byte(input, i)
		local byteCount = 1
		if curByte > 0 and curByte <= 127 then
			byteCount = 1
			index = index + 1
			arr[index] = string.sub(input, i, i + byteCount - 1)
		elseif curByte >= 192 and curByte <= 223 then
			byteCount = 2
			index = index + 1
			arr[index] = string.sub(input, i, i + byteCount - 1)
		elseif curByte >= 224 and curByte <= 239 then -- utf-8 汉字 3个字节
			byteCount = 3
			index = index + 1
			arr[index] = string.sub(input, i, i + byteCount - 1)
		elseif curByte >= 240 and curByte <= 247 then
			byteCount = 4
			index = index + 1
			arr[index] = string.sub(input, i, i + byteCount - 1)
		end
	end
	return arr
end

local function trim(str)
	local arr = toarray(str)
	local result = ""
	local len = #arr
	local st = 1
	while ((st <= len) and (arr[st] == ' ')) do
		st = st + 1
	end
	while ((st <= len) and (arr[len] == ' ')) do
		len = len - 1
	end
	if st <= 1 and st >= #arr then
		return str
	end
	for i = st, len do
		result = result..arr[i]
	end
	return result
end

string.split = split
string.join = join
string.contains = contains
string.startswith = startswith
string.endswith = endswith
string.IsNullOrEmpty = IsNullOrEmpty
string.utf8len= utf8len
string.toarray = toarray
string.trim = trim