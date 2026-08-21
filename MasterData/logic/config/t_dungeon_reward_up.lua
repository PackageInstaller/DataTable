-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_dungeon_reward_up.lua

module("logic.config.t_dungeon_reward_up", package.seeall)

local title = {
	jumpId = 8,
	name = 2,
	count = 7,
	rewardTypes = 4,
	dungeonType = 3,
	icons = 9,
	openCode = 10,
	timesLanguage = 11,
	extraRate = 6,
	explainLanguage = 12,
	rewardItemIds = 5,
	describe = 13,
	code = 1
}
local dataList = {
	{
		90001,
		"序列矿场",
		{
			8
		},
		nil,
		nil,
		1,
		1,
		10400001,
		{},
		16003,
		"tip_multipleDrop_double",
		"tip_multipleDrop_coin_explain",
		"tip_multipleDrop_coin_describe"
	},
	{
		90002,
		"夸克制药",
		{
			9
		},
		nil,
		nil,
		1,
		1,
		10400002,
		{
			1003001,
			1003002,
			1003003,
			1003004
		},
		16004,
		"tip_multipleDrop_double",
		"tip_multipleDrop_level_explain",
		"tip_multipleDrop_level_describe"
	},
	{
		90003,
		"守卫测验点",
		{
			4,
			1004
		},
		nil,
		{
			1004081,
			1004082,
			1004083,
			1004084
		},
		1,
		1,
		10400004,
		{
			1004081,
			1004082,
			1004083,
			1004084
		},
		16006,
		"tip_multipleDrop_double",
		"tip_multipleDrop_assault_explain",
		"tip_multipleDrop_assault_describe"
	},
	{
		90004,
		"狙击测验点",
		{
			4,
			1005
		},
		nil,
		{
			1004085,
			1004086,
			1004087,
			1004088
		},
		1,
		1,
		10400005,
		{
			1004085,
			1004086,
			1004087,
			1004088
		},
		16007,
		"tip_multipleDrop_double",
		"tip_multipleDrop_sniper_explain",
		"tip_multipleDrop_sniper_describe"
	}
}
local t_dungeon_reward_up = {}

t_dungeon_reward_up.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		else
			error(string.format("the field name [%s] is nonexist!", key))
		end
	end
}

for i, v in ipairs(dataList) do
	t_dungeon_reward_up[v[1]] = v

	setmetatable(v, mt)
end

return t_dungeon_reward_up
