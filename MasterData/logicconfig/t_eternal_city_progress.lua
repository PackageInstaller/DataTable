-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_eternal_city_progress.lua

module("logicconfig.config.t_eternal_city_progress", package.seeall)

local title = {
	progressPlan = 1,
	prize = 3,
	progress = 2
}
local dataList = {
	{
		1,
		10000000,
		"10:557002:5000"
	},
	{
		1,
		70000000,
		"10:557002:5500"
	},
	{
		1,
		130000000,
		"10:557002:6000"
	},
	{
		1,
		190000000,
		"10:557002:6500"
	},
	{
		1,
		250000000,
		"10:557002:7000"
	},
	{
		1,
		310000000,
		"10:557002:7500"
	},
	{
		1,
		370000000,
		"10:557002:8000"
	},
	{
		1,
		430000000,
		"10:557002:8500"
	},
	{
		1,
		490000000,
		"10:557002:9000"
	},
	{
		1,
		550000000,
		"10:557002:10000"
	}
}
local t_eternal_city_progress = {
	{
		[10000000] = dataList[1],
		[70000000] = dataList[2],
		[130000000] = dataList[3],
		[190000000] = dataList[4],
		[250000000] = dataList[5],
		[310000000] = dataList[6],
		[370000000] = dataList[7],
		[430000000] = dataList[8],
		[490000000] = dataList[9],
		[550000000] = dataList[10]
	}
}

t_eternal_city_progress.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		end
	end
}

for i, v in ipairs(dataList) do
	setmetatable(v, mt)
end

return t_eternal_city_progress
