-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_team_play_rank.lua

module("logicconfig.config.t_team_play_rank", package.seeall)

local title = {
	id = 1,
	prize = 3,
	rank = 2
}
local dataList = {
	{
		1,
		1,
		"104:2:2000#8:5:3000#8:27:300"
	},
	{
		2,
		3,
		"104:2:1500#8:5:2000#8:27:200"
	},
	{
		3,
		10,
		"104:2:1000#8:5:1500#8:27:150"
	},
	{
		4,
		50,
		"104:2:700#8:5:800#8:27:80"
	},
	{
		5,
		100,
		"104:2:500#8:5:600#8:27:60"
	},
	{
		6,
		200,
		"104:2:300#8:5:200#8:27:20"
	}
}
local t_team_play_rank = {
	{
		dataList[1]
	},
	{
		[3] = dataList[2]
	},
	{
		[10] = dataList[3]
	},
	{
		[50] = dataList[4]
	},
	{
		[100] = dataList[5]
	},
	{
		[200] = dataList[6]
	}
}

t_team_play_rank.dataList = dataList

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

return t_team_play_rank
