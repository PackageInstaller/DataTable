-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_golden_ten_robot_1.lua

module("logicconfig.config.t_golden_ten_robot_1", package.seeall)

local title = {
	activityId = 1,
	robotId = 2
}
local dataList = {
	{
		259001,
		30001
	},
	{
		259001,
		30002
	},
	{
		259001,
		30003
	},
	{
		259001,
		30004
	},
	{
		259001,
		30005
	},
	{
		259001,
		30006
	},
	{
		259001,
		30007
	},
	{
		259001,
		30008
	},
	{
		259001,
		30009
	},
	{
		259001,
		30010
	}
}
local t_golden_ten_robot_1 = {
	[259001] = {
		[30001] = dataList[1],
		[30002] = dataList[2],
		[30003] = dataList[3],
		[30004] = dataList[4],
		[30005] = dataList[5],
		[30006] = dataList[6],
		[30007] = dataList[7],
		[30008] = dataList[8],
		[30009] = dataList[9],
		[30010] = dataList[10]
	}
}

t_golden_ten_robot_1.dataList = dataList

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

return t_golden_ten_robot_1
