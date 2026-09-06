-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_christmas_gather_progress_prize.lua

module("logicconfig.config.t_christmas_gather_progress_prize", package.seeall)

local title = {
	id = 2,
	collectionNum = 3,
	prize = 4,
	progressPlanId = 1
}
local dataList = {
	{
		1,
		1,
		1,
		"4:90062:60"
	},
	{
		1,
		2,
		2,
		"4:90062:60"
	},
	{
		1,
		3,
		4,
		"4:90062:80"
	},
	{
		1,
		4,
		5,
		"4:90062:60"
	},
	{
		1,
		5,
		6,
		"4:90062:60"
	},
	{
		1,
		6,
		8,
		"4:90062:80"
	},
	{
		1,
		7,
		9,
		"4:90062:60"
	},
	{
		1,
		8,
		10,
		"4:90062:60"
	},
	{
		1,
		9,
		12,
		"4:90062:80"
	},
	{
		1,
		10,
		16,
		"100:10322:1:1"
	},
	{
		1,
		11,
		17,
		"4:90062:60"
	},
	{
		1,
		12,
		18,
		"4:90062:60"
	},
	{
		1,
		13,
		20,
		"4:90062:80"
	},
	{
		1,
		14,
		21,
		"4:90062:60"
	},
	{
		1,
		15,
		22,
		"4:90062:60"
	},
	{
		1,
		16,
		24,
		"4:90062:80"
	}
}
local t_christmas_gather_progress_prize = {
	{
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
		dataList[16]
	}
}

t_christmas_gather_progress_prize.dataList = dataList

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

return t_christmas_gather_progress_prize
