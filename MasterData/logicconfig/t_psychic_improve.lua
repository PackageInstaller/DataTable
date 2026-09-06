-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_psychic_improve.lua

module("logicconfig.config.t_psychic_improve", package.seeall)

local title = {
	hireLimit = 3,
	activityId = 1,
	hirePlanId = 2
}
local dataList = {
	{
		221001,
		1,
		3
	},
	{
		221002,
		2,
		1
	},
	{
		221003,
		3,
		1
	},
	{
		221005,
		4,
		1
	},
	{
		221006,
		5,
		1
	}
}
local t_psychic_improve = {
	[221001] = dataList[1],
	[221002] = dataList[2],
	[221003] = dataList[3],
	[221005] = dataList[4],
	[221006] = dataList[5]
}

t_psychic_improve.dataList = dataList

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

return t_psychic_improve
