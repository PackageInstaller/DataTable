-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_dishitian_challenge_normal_stage.lua

module("logicconfig.config.t_divine_dishitian_challenge_normal_stage", package.seeall)

local title = {
	creepsMasterIds = 3,
	activityId = 1,
	day = 2
}
local dataList = {
	{
		363001,
		1,
		{
			201,
			202,
			203
		}
	},
	{
		363001,
		2,
		{
			204,
			205,
			206
		}
	},
	{
		363001,
		3,
		{
			207,
			208,
			209
		}
	},
	{
		363001,
		4,
		{
			210,
			211,
			212
		}
	},
	{
		363001,
		5,
		{
			213,
			214,
			215
		}
	},
	{
		363001,
		6,
		{
			216,
			217,
			218
		}
	},
	{
		363001,
		7,
		{
			219,
			220,
			221
		}
	}
}
local t_divine_dishitian_challenge_normal_stage = {
	[363001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	}
}

t_divine_dishitian_challenge_normal_stage.dataList = dataList

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

return t_divine_dishitian_challenge_normal_stage
