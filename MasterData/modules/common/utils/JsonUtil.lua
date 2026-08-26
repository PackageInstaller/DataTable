-- chunkname: @modules/common/utils/JsonUtil.lua

module("modules.common.utils.JsonUtil", package.seeall)

local JsonUtil = {}

JsonUtil.emptyArrayPlaceholder = "empty_array_placeholder_202205171648"

function JsonUtil.encode(t)
	JsonUtil._add_placeholder(t)

	local jsonStr = cjson.encode(t)

	if not string.nilorempty(jsonStr) then
		jsonStr = string.gsub(jsonStr, "%[\"" .. JsonUtil.emptyArrayPlaceholder .. "\"]", "[]")
	end

	return jsonStr
end

function JsonUtil.markAsArray(t)
	local mt = getmetatable(t) or {}

	mt.__jsontype = "array"

	setmetatable(t, mt)
end

function JsonUtil._is_marked_as_array(t)
	local mt = getmetatable(t)

	return mt and mt.__jsontype == "array"
end

function JsonUtil._add_placeholder(t, dict)
	if not t or not LuaUtil.isTable(t) then
		return
	end

	local empty = true

	dict = dict or {}
	dict[t] = true

	for key, value in pairs(t) do
		if not dict[value] and LuaUtil.isTable(value) then
			JsonUtil._add_placeholder(value, dict)
		end

		empty = false
	end

	if JsonUtil._is_marked_as_array(t) and empty then
		table.insert(t, JsonUtil.emptyArrayPlaceholder)
	end
end

return JsonUtil
