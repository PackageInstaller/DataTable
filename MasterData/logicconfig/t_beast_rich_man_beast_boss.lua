-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_beast_rich_man_beast_boss.lua

module("logicconfig.config.t_beast_rich_man_beast_boss", package.seeall)

local title = {
	bossId = 2,
	creepsMasterId = 3,
	activityId = 1,
	iconName = 4
}
local dataList = {
	{
		558001,
		1,
		4001,
		"board_ruishoudamaoxian_gz13"
	},
	{
		558001,
		2,
		5001,
		"board_ruishoudamaoxian_gz12"
	},
	{
		558001,
		3,
		6001,
		"board_ruishoudamaoxian_gz11"
	},
	{
		558001,
		4,
		7001,
		"board_ruishoudamaoxian_gz16"
	}
}
local t_beast_rich_man_beast_boss = {
	[558001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_beast_rich_man_beast_boss.dataList = dataList

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

return t_beast_rich_man_beast_boss
