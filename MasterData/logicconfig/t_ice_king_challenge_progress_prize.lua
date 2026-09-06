-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ice_king_challenge_progress_prize.lua

module("logicconfig.config.t_ice_king_challenge_progress_prize", package.seeall)

local title = {
	challengeId = 1,
	name = 4,
	needItemCount = 3,
	prizeId = 2,
	prize = 5
}
local dataList = {
	{
		15,
		1,
		100,
		"金币",
		"8:1:500000"
	},
	{
		15,
		2,
		300,
		"体力",
		"60:1:120"
	},
	{
		15,
		3,
		500,
		"超级经验果",
		"4:3:50"
	},
	{
		15,
		4,
		750,
		"橙色装备箱",
		"4:40008:1"
	},
	{
		15,
		5,
		1000,
		"高级强化石",
		"4:30003:15"
	},
	{
		15,
		6,
		1250,
		"金色星神宝箱",
		"4:41004:1"
	},
	{
		15,
		7,
		1500,
		"冰灵王",
		"100:10098:1:1#62:54:1"
	}
}
local t_ice_king_challenge_progress_prize = {
	[15] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	}
}

t_ice_king_challenge_progress_prize.dataList = dataList

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

return t_ice_king_challenge_progress_prize
