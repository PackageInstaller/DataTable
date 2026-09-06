-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_summer_treasure_snatch_buff.lua

module("logicconfig.config.t_summer_treasure_snatch_buff", package.seeall)

local title = {
	name = 4,
	buffId = 2,
	icon = 5,
	activityId = 1,
	desc = 3
}
local dataList = {
	{
		623001,
		1,
		82053977,
		82053976,
		"icon_expedition_buqu"
	},
	{
		623001,
		2,
		82053979,
		82053978,
		"icon_expedition_bianyi01"
	},
	{
		623001,
		3,
		82053981,
		82053980,
		"icon_expedition_chaoshahoumianyi"
	},
	{
		623001,
		4,
		82058006,
		82058007,
		"icon_expedition_zhuiji"
	}
}
local t_summer_treasure_snatch_buff = {
	[623001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_summer_treasure_snatch_buff.dataList = dataList

local multiLanguageCells = {
	name = true,
	desc = true
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

return t_summer_treasure_snatch_buff
