-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dark_mo_yan_drop_plan.lua

module("logicconfig.config.t_dark_mo_yan_drop_plan", package.seeall)

local title = {
	dropPlanId = 1,
	weight = 3,
	type = 2
}
local dataList = {
	{
		1,
		1,
		100
	},
	{
		1,
		2,
		100
	},
	{
		1,
		3,
		100
	},
	{
		1,
		4,
		100
	},
	{
		1,
		5,
		100
	},
	{
		1,
		0,
		0
	},
	{
		2,
		1,
		50
	},
	{
		2,
		2,
		100
	},
	{
		2,
		3,
		30
	},
	{
		2,
		4,
		10
	},
	{
		2,
		5,
		100
	},
	{
		3,
		1,
		50
	},
	{
		3,
		2,
		40
	},
	{
		3,
		3,
		30
	},
	{
		3,
		4,
		10
	},
	{
		3,
		5,
		100
	},
	{
		4,
		1,
		50
	},
	{
		4,
		2,
		40
	},
	{
		4,
		3,
		30
	},
	{
		4,
		4,
		10
	},
	{
		4,
		5,
		20
	},
	{
		5,
		1,
		10
	},
	{
		5,
		2,
		40
	},
	{
		5,
		3,
		30
	},
	{
		5,
		4,
		10
	},
	{
		5,
		5,
		20
	},
	{
		6,
		1,
		30
	},
	{
		6,
		2,
		30
	},
	{
		6,
		3,
		30
	}
}
local t_dark_mo_yan_drop_plan = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		[0] = dataList[6]
	},
	{
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11]
	},
	{
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16]
	},
	{
		dataList[17],
		dataList[18],
		dataList[19],
		dataList[20],
		dataList[21]
	},
	{
		dataList[22],
		dataList[23],
		dataList[24],
		dataList[25],
		dataList[26]
	},
	{
		dataList[27],
		dataList[28],
		dataList[29]
	}
}

t_dark_mo_yan_drop_plan.dataList = dataList

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

return t_dark_mo_yan_drop_plan
