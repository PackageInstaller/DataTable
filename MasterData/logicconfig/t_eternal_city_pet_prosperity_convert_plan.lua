-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_eternal_city_pet_prosperity_convert_plan.lua

module("logicconfig.config.t_eternal_city_pet_prosperity_convert_plan", package.seeall)

local title = {
	num = 2,
	activityId = 1,
	prosperity = 3
}
local dataList = {
	{
		557001,
		1,
		100
	},
	{
		557001,
		5,
		350
	},
	{
		557001,
		10,
		600
	},
	{
		557001,
		13,
		750
	},
	{
		557001,
		25,
		1350
	},
	{
		557001,
		30,
		1600
	},
	{
		557001,
		35,
		1850
	},
	{
		557001,
		40,
		2100
	},
	{
		557001,
		45,
		2350
	},
	{
		557001,
		50,
		2600
	},
	{
		557001,
		55,
		2850
	},
	{
		557001,
		60,
		3100
	},
	{
		557001,
		65,
		3350
	},
	{
		557001,
		70,
		3600
	},
	{
		557001,
		75,
		3850
	},
	{
		557001,
		80,
		4100
	},
	{
		557001,
		95,
		4850
	},
	{
		557001,
		110,
		5600
	}
}
local t_eternal_city_pet_prosperity_convert_plan = {
	[557001] = {
		dataList[1],
		[5] = dataList[2],
		[10] = dataList[3],
		[13] = dataList[4],
		[25] = dataList[5],
		[30] = dataList[6],
		[35] = dataList[7],
		[40] = dataList[8],
		[45] = dataList[9],
		[50] = dataList[10],
		[55] = dataList[11],
		[60] = dataList[12],
		[65] = dataList[13],
		[70] = dataList[14],
		[75] = dataList[15],
		[80] = dataList[16],
		[95] = dataList[17],
		[110] = dataList[18]
	}
}

t_eternal_city_pet_prosperity_convert_plan.dataList = dataList

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

return t_eternal_city_pet_prosperity_convert_plan
