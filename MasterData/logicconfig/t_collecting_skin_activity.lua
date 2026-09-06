-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_collecting_skin_activity.lua

module("logicconfig.config.t_collecting_skin_activity", package.seeall)

local title = {
	activityId = 1,
	redPointId = 2
}
local dataList = {
	{
		362001,
		574
	},
	{
		362002,
		574
	},
	{
		362003,
		574
	},
	{
		362004,
		574
	},
	{
		362005,
		574
	},
	{
		362006,
		759
	},
	{
		362007,
		759
	},
	{
		362008,
		574
	},
	{
		362009,
		759
	}
}
local t_collecting_skin_activity = {
	[362001] = dataList[1],
	[362002] = dataList[2],
	[362003] = dataList[3],
	[362004] = dataList[4],
	[362005] = dataList[5],
	[362006] = dataList[6],
	[362007] = dataList[7],
	[362008] = dataList[8],
	[362009] = dataList[9]
}

t_collecting_skin_activity.dataList = dataList

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

return t_collecting_skin_activity
