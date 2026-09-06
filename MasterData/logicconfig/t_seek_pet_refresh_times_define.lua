-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_seek_pet_refresh_times_define.lua

module("logicconfig.config.t_seek_pet_refresh_times_define", package.seeall)

local title = {
	cost = 2,
	times = 1
}
local dataList = {
	{
		1,
		"105:164:20"
	},
	{
		2,
		"105:164:20"
	},
	{
		3,
		"105:164:20"
	},
	{
		4,
		"105:164:20"
	},
	{
		5,
		"105:164:20"
	},
	{
		6,
		"105:164:20"
	},
	{
		7,
		"105:164:20"
	},
	{
		8,
		"105:164:20"
	},
	{
		9,
		"105:164:20"
	},
	{
		10,
		"105:164:20"
	},
	{
		11,
		"105:164:20"
	},
	{
		12,
		"105:164:20"
	},
	{
		13,
		"105:164:20"
	},
	{
		14,
		"105:164:20"
	},
	{
		15,
		"105:164:20"
	},
	{
		16,
		"105:164:20"
	},
	{
		17,
		"105:164:20"
	},
	{
		18,
		"105:164:20"
	},
	{
		19,
		"105:164:20"
	},
	{
		20,
		"105:164:20"
	}
}
local t_seek_pet_refresh_times_define = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8],
	dataList[9],
	dataList[10],
	dataList[11],
	dataList[12],
	dataList[13],
	dataList[14],
	dataList[15],
	dataList[16],
	dataList[17],
	dataList[18],
	dataList[19],
	dataList[20]
}

t_seek_pet_refresh_times_define.dataList = dataList

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

return t_seek_pet_refresh_times_define
