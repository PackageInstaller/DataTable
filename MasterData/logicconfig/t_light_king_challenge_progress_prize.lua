-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_light_king_challenge_progress_prize.lua

module("logicconfig.config.t_light_king_challenge_progress_prize", package.seeall)

local title = {
	score = 2,
	name = 3,
	id = 1,
	gain = 4
}
local dataList = {
	{
		1,
		50,
		"金币",
		"8:1:500000"
	},
	{
		2,
		150,
		"体力",
		"60:1:120"
	},
	{
		3,
		250,
		"超级经验果",
		"4:3:50"
	},
	{
		4,
		350,
		"神圣·光明王",
		"100:10100:1:1#62:53:1"
	},
	{
		5,
		500,
		"橙色装备箱",
		"4:40008:1"
	},
	{
		6,
		650,
		"金色星神宝箱",
		"4:41004:1"
	},
	{
		7,
		800,
		"光明王之魂",
		"4:80100:1"
	},
	{
		8,
		1000,
		"光明王之魂",
		"4:80100:1"
	}
}
local t_light_king_challenge_progress_prize = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8]
}

t_light_king_challenge_progress_prize.dataList = dataList

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

return t_light_king_challenge_progress_prize
