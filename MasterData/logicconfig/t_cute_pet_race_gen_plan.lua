-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_cute_pet_race_gen_plan.lua

module("logicconfig.config.t_cute_pet_race_gen_plan", package.seeall)

local title = {
	race = 2,
	weight = 3,
	planId = 1
}
local dataList = {
	{
		1,
		101,
		4
	},
	{
		1,
		102,
		6
	},
	{
		1,
		103,
		5
	},
	{
		1,
		104,
		6
	},
	{
		1,
		201,
		5
	},
	{
		1,
		202,
		5
	},
	{
		1,
		203,
		6
	},
	{
		1,
		204,
		4
	},
	{
		1,
		301,
		5
	},
	{
		1,
		302,
		5
	},
	{
		1,
		401,
		6
	},
	{
		1,
		402,
		5
	},
	{
		2,
		101,
		4
	},
	{
		2,
		102,
		6
	},
	{
		2,
		103,
		5
	},
	{
		2,
		104,
		6
	},
	{
		2,
		201,
		5
	},
	{
		2,
		202,
		5
	},
	{
		2,
		203,
		6
	},
	{
		2,
		204,
		4
	},
	{
		2,
		301,
		5
	},
	{
		2,
		302,
		5
	},
	{
		2,
		401,
		6
	},
	{
		2,
		402,
		5
	}
}
local t_cute_pet_race_gen_plan = {
	{
		[101] = dataList[1],
		[102] = dataList[2],
		[103] = dataList[3],
		[104] = dataList[4],
		[201] = dataList[5],
		[202] = dataList[6],
		[203] = dataList[7],
		[204] = dataList[8],
		[301] = dataList[9],
		[302] = dataList[10],
		[401] = dataList[11],
		[402] = dataList[12]
	},
	{
		[101] = dataList[13],
		[102] = dataList[14],
		[103] = dataList[15],
		[104] = dataList[16],
		[201] = dataList[17],
		[202] = dataList[18],
		[203] = dataList[19],
		[204] = dataList[20],
		[301] = dataList[21],
		[302] = dataList[22],
		[401] = dataList[23],
		[402] = dataList[24]
	}
}

t_cute_pet_race_gen_plan.dataList = dataList

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

return t_cute_pet_race_gen_plan
