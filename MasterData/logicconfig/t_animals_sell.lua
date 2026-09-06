-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_animals_sell.lua

module("logicconfig.config.t_animals_sell", package.seeall)

local title = {
	goodsId = 3,
	petId = 2,
	funcId = 1,
	camPos = 4,
	camSize = 5
}
local dataList = {
	{
		362,
		6,
		4013,
		{
			-0.15,
			0.5,
			-1
		},
		0.56
	},
	{
		390,
		7,
		4014,
		{
			-0.15,
			0.5,
			-1
		},
		0.56
	},
	{
		422,
		9,
		4017,
		{
			-0.15,
			0.5,
			-1
		},
		0.56
	},
	{
		443,
		10,
		4018,
		{
			-0.15,
			0.5,
			-1
		},
		0.56
	},
	{
		607,
		11,
		4019,
		{
			-0.15,
			0.5,
			-1
		},
		0.56
	},
	{
		627,
		12,
		4020,
		{
			-0.15,
			0.5,
			-1
		},
		0.56
	},
	{
		702,
		14,
		4021,
		{
			-0.15,
			0.5,
			-1
		},
		0.56
	}
}
local t_animals_sell = {
	[362] = dataList[1],
	[390] = dataList[2],
	[422] = dataList[3],
	[443] = dataList[4],
	[607] = dataList[5],
	[627] = dataList[6],
	[702] = dataList[7]
}

t_animals_sell.dataList = dataList

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

return t_animals_sell
