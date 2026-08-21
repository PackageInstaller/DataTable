-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_word.lua

module("logic.config.t_word", package.seeall)

local title = {
	name = 2,
	key = 1,
	icon = 4,
	desc = 3
}
local dataList = {
	{
		"密室时间",
		"密室时间",
		"标准时区下每天24点后进入持续12小时的密室时间，密室生物相继涌现对城市进行破坏，严重时会导致时序失效形成红雾区。密室时间下只有守秘人能够活动",
		""
	},
	{
		"异能",
		"异能",
		"守秘人凭借感知超凡力量的天赋，可获得不同效果的异能，触发异能可以加强守秘人的作战能力",
		""
	},
	{
		"普通理智",
		"普通理智",
		"当前理智为普通理智",
		"bqtb20011"
	},
	{
		"代理调查",
		"代理调查",
		"将使用玩家之前的战斗记录，自动进行战斗",
		""
	},
	{
		"网络接入RAM",
		"网络接入RAM",
		"每周所有关卡最多可挑战5次",
		""
	},
	{
		"等级压制",
		"等级压制",
		"受到时序紊乱影响，所有守秘人等级不超过<color=#ffffff>%s级</color>",
		""
	}
}
local t_word = {}

t_word.dataList = dataList

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
	t_word[v[1]] = v

	setmetatable(v, mt)
end

return t_word
