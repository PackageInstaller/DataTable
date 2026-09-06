-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_xiu_nuo_clg_stage.lua

module("logicconfig.config.t_divine_xiu_nuo_clg_stage", package.seeall)

local title = {
	stageId = 3,
	creepsId = 5,
	phaseId = 2,
	creepsMasterId = 4,
	activityId = 1,
	isShowLock = 6
}
local dataList = {
	{
		395001,
		1,
		1,
		1001,
		100000001,
		0
	},
	{
		395001,
		1,
		2,
		1002,
		100000002,
		0
	},
	{
		395001,
		1,
		3,
		1003,
		100000003,
		0
	},
	{
		395001,
		1,
		4,
		1004,
		100000004,
		0
	},
	{
		395001,
		1,
		5,
		1005,
		100000005,
		0
	},
	{
		395001,
		2,
		1,
		2001,
		100000006,
		0
	},
	{
		395001,
		2,
		2,
		2002,
		100000007,
		0
	},
	{
		395001,
		2,
		3,
		2003,
		100000008,
		0
	},
	{
		395001,
		2,
		4,
		2004,
		100000009,
		0
	},
	{
		395001,
		2,
		5,
		2005,
		100000010,
		0
	},
	{
		395001,
		3,
		1,
		3001,
		0,
		1
	},
	{
		395001,
		3,
		2,
		3002,
		0,
		1
	},
	{
		395001,
		3,
		3,
		3003,
		0,
		1
	},
	{
		395001,
		3,
		4,
		3004,
		0,
		1
	},
	{
		395001,
		3,
		5,
		3005,
		0,
		1
	}
}
local t_divine_xiu_nuo_clg_stage = {
	[395001] = {
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
}

t_divine_xiu_nuo_clg_stage.dataList = dataList

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

return t_divine_xiu_nuo_clg_stage
