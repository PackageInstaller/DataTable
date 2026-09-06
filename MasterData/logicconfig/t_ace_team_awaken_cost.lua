-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ace_team_awaken_cost.lua

module("logicconfig.config.t_ace_team_awaken_cost", package.seeall)

local title = {
	point = 2,
	level = 1
}
local dataList = {
	{
		0,
		0
	},
	{
		1,
		200
	},
	{
		2,
		200
	},
	{
		3,
		300
	},
	{
		4,
		300
	},
	{
		5,
		400
	},
	{
		6,
		400
	}
}
local t_ace_team_awaken_cost = {
	[0] = dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7]
}

t_ace_team_awaken_cost.dataList = dataList

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

return t_ace_team_awaken_cost
