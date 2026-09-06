-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_recommend_formation_max_common.lua

module("logicconfig.config.t_recommend_formation_max_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"RANK_GAIN_ITEM",
		82037499
	},
	{
		"ACT_TIME_OVER",
		82037500
	}
}
local t_recommend_formation_max_common = {
	RANK_GAIN_ITEM = dataList[1],
	ACT_TIME_OVER = dataList[2]
}

t_recommend_formation_max_common.dataList = dataList

local multiLanguageCells = {
	value = true
}
local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			local value = rawget(t, index)

			if multiLanguageCells[key] then
				value = lang(value)
			end

			return value
		else
			printWarn(string.format("the field name [%s] is nonexist!", key))
		end
	end
}

for i, v in ipairs(dataList) do
	setmetatable(v, mt)
end

return t_recommend_formation_max_common
