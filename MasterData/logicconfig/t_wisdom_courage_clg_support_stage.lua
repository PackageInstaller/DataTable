-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_wisdom_courage_clg_support_stage.lua

module("logicconfig.config.t_wisdom_courage_clg_support_stage", package.seeall)

local title = {
	stageId = 2,
	prize = 3,
	supportPetPoolId = 5,
	creepsMasterId = 4,
	activityId = 1
}
local dataList = {
	{
		456001,
		1,
		"8:1:1000000#10:453001:300",
		1001,
		1
	},
	{
		456001,
		2,
		"4:510022:3#10:453001:300",
		1002,
		1
	},
	{
		456001,
		3,
		"4:400002:50#10:453001:300",
		1003,
		1
	},
	{
		456001,
		4,
		"4:90316:1#10:453001:300",
		1004,
		1
	},
	{
		456001,
		5,
		"4:30006:50#10:453001:300",
		1005,
		1
	}
}
local t_wisdom_courage_clg_support_stage = {
	[456001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_wisdom_courage_clg_support_stage.dataList = dataList

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

return t_wisdom_courage_clg_support_stage
