-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_mimengli_clg_team.lua

module("logicconfig.config.t_divine_mimengli_clg_team", package.seeall)

local title = {
	teamId = 2,
	stagePlanId = 1,
	creepsMasterId = 3,
	tagPosId = 4
}
local dataList = {
	{
		1,
		1,
		1001,
		0
	},
	{
		1,
		2,
		1002,
		0
	},
	{
		1,
		3,
		1003,
		0
	},
	{
		1,
		4,
		1004,
		0
	},
	{
		1,
		5,
		1005,
		0
	},
	{
		2,
		1,
		1006,
		2
	},
	{
		2,
		2,
		1007,
		2
	},
	{
		2,
		3,
		1008,
		2
	},
	{
		2,
		4,
		1009,
		2
	},
	{
		2,
		5,
		1010,
		2
	},
	{
		3,
		1,
		1011,
		2
	},
	{
		3,
		2,
		1012,
		2
	},
	{
		3,
		3,
		1013,
		2
	},
	{
		3,
		4,
		1014,
		2
	},
	{
		3,
		5,
		1015,
		2
	}
}
local t_divine_mimengli_clg_team = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	},
	{
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	},
	{
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15]
	}
}

t_divine_mimengli_clg_team.dataList = dataList

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

return t_divine_mimengli_clg_team
