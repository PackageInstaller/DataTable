-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_h5_back_activity.lua

module("logicconfig.config.t_h5_back_activity", package.seeall)

local title = {
	loginTaskMax = 3,
	backDay = 2,
	activityId = 1
}
local dataList = {
	{
		216001,
		30,
		999
	},
	{
		216002,
		30,
		999
	},
	{
		216003,
		30,
		999
	},
	{
		216004,
		30,
		999
	},
	{
		216005,
		30,
		999
	},
	{
		216006,
		21,
		999
	},
	{
		216007,
		28,
		999
	},
	{
		216008,
		28,
		999
	}
}
local t_h5_back_activity = {
	[216001] = dataList[1],
	[216002] = dataList[2],
	[216003] = dataList[3],
	[216004] = dataList[4],
	[216005] = dataList[5],
	[216006] = dataList[6],
	[216007] = dataList[7],
	[216008] = dataList[8]
}

t_h5_back_activity.dataList = dataList

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

return t_h5_back_activity
