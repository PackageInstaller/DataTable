-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_aoqi_god_race_buff.lua

module("logicconfig.config.t_aoqi_god_race_buff", package.seeall)

local title = {
	raceNum = 2,
	activityId = 1,
	desc = 3
}
local dataList = {
	{
		424013,
		1,
		82056422
	},
	{
		424013,
		2,
		82056423
	},
	{
		424013,
		3,
		82056424
	},
	{
		424013,
		4,
		82056425
	},
	{
		424013,
		5,
		82056426
	},
	{
		424013,
		6,
		82056427
	},
	{
		424014,
		1,
		82056422
	},
	{
		424014,
		2,
		82056423
	},
	{
		424014,
		3,
		82056424
	},
	{
		424014,
		4,
		82056425
	},
	{
		424014,
		5,
		82056426
	},
	{
		424014,
		6,
		82056427
	},
	{
		424015,
		1,
		82056422
	},
	{
		424015,
		2,
		82056423
	},
	{
		424015,
		3,
		82056424
	},
	{
		424015,
		4,
		82056425
	},
	{
		424015,
		5,
		82056426
	},
	{
		424015,
		6,
		82056427
	}
}
local t_aoqi_god_race_buff = {
	[424013] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	},
	[424014] = {
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12]
	},
	[424015] = {
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16],
		dataList[17],
		dataList[18]
	}
}

t_aoqi_god_race_buff.dataList = dataList

local multiLanguageCells = {
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

return t_aoqi_god_race_buff
