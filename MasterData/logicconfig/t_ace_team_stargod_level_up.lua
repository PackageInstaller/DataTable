-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ace_team_stargod_level_up.lua

module("logicconfig.config.t_ace_team_stargod_level_up", package.seeall)

local title = {
	point = 2,
	level = 1
}
local dataList = {
	{
		1,
		0
	},
	{
		5,
		10
	},
	{
		10,
		10
	},
	{
		15,
		20
	},
	{
		20,
		20
	},
	{
		25,
		30
	},
	{
		30,
		30
	},
	{
		35,
		40
	},
	{
		40,
		40
	},
	{
		45,
		50
	},
	{
		50,
		50
	}
}
local t_ace_team_stargod_level_up = {
	dataList[1],
	[5] = dataList[2],
	[10] = dataList[3],
	[15] = dataList[4],
	[20] = dataList[5],
	[25] = dataList[6],
	[30] = dataList[7],
	[35] = dataList[8],
	[40] = dataList[9],
	[45] = dataList[10],
	[50] = dataList[11]
}

t_ace_team_stargod_level_up.dataList = dataList

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

return t_ace_team_stargod_level_up
