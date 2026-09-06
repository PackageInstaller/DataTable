-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ranking_match_buff.lua

module("logicconfig.config.t_ranking_match_buff", package.seeall)

local title = {
	id = 1,
	name = 2,
	icon = 4,
	desc = 3
}
local dataList = {
	{
		1,
		82008000,
		82008001,
		"rankracebuff_1"
	},
	{
		2,
		82008002,
		82008003,
		"rankracebuff_2"
	},
	{
		3,
		82008004,
		82008005,
		"rankracebuff_3"
	},
	{
		4,
		82008006,
		82008007,
		"rankracebuff_4"
	},
	{
		5,
		82008008,
		82008009,
		"rankracebuff_5"
	}
}
local t_ranking_match_buff = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5]
}

t_ranking_match_buff.dataList = dataList

local multiLanguageCells = {
	desc = true,
	name = true
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

return t_ranking_match_buff
