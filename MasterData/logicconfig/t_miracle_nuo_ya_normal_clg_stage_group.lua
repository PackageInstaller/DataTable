-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_miracle_nuo_ya_normal_clg_stage_group.lua

module("logicconfig.config.t_miracle_nuo_ya_normal_clg_stage_group", package.seeall)

local title = {
	groupId = 2,
	pos = 5,
	skinId = 4,
	creepsMasterId = 3,
	activityId = 1
}
local dataList = {
	{
		382001,
		1,
		2001,
		18001,
		{
			-120,
			-400,
			1
		}
	},
	{
		382001,
		2,
		2002,
		14022,
		{
			0,
			-550,
			1
		}
	},
	{
		382001,
		3,
		2003,
		16010,
		{
			0,
			-380,
			1
		}
	},
	{
		382002,
		1,
		2001,
		18001,
		{
			-120,
			-400,
			1
		}
	},
	{
		382002,
		2,
		2002,
		14022,
		{
			0,
			-550,
			1
		}
	},
	{
		382002,
		3,
		2003,
		16010,
		{
			0,
			-380,
			1
		}
	}
}
local t_miracle_nuo_ya_normal_clg_stage_group = {
	[382001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	},
	[382002] = {
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_miracle_nuo_ya_normal_clg_stage_group.dataList = dataList

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

return t_miracle_nuo_ya_normal_clg_stage_group
