-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_martial_contest_finals_buff.lua

module("logicconfig.config.t_martial_contest_finals_buff", package.seeall)

local title = {
	name = 3,
	buffId = 2,
	icon = 5,
	activityId = 1,
	desc = 4
}
local dataList = {
	{
		583001,
		1,
		82053976,
		82053977,
		"icon_expedition_xieli01"
	},
	{
		583001,
		2,
		82053978,
		82053979,
		"icon_expedition_baojilv1"
	},
	{
		583001,
		3,
		82053980,
		82053981,
		"icon_expedition_chaoshatisheng"
	},
	{
		583001,
		4,
		82053982,
		82053983,
		"icon_expedition_chixue01"
	},
	{
		583001,
		5,
		82053984,
		82053985,
		"icon_expedition_wugong3"
	},
	{
		583001,
		6,
		82053986,
		82053987,
		"icon_expedition_guijia"
	}
}
local t_martial_contest_finals_buff = {
	[583001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_martial_contest_finals_buff.dataList = dataList

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

return t_martial_contest_finals_buff
