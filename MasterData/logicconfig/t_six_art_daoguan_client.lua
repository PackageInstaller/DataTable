-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_six_art_daoguan_client.lua

module("logicconfig.config.t_six_art_daoguan_client", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"PetShopRaceId",
		"1202701"
	},
	{
		"PetShopBubble",
		"招募强力助战精灵，面对挑战无压力！"
	},
	{
		"PetShopCoin",
		"10:447002"
	},
	{
		"FirstStoryId",
		"4760006"
	}
}
local t_six_art_daoguan_client = {
	PetShopRaceId = dataList[1],
	PetShopBubble = dataList[2],
	PetShopCoin = dataList[3],
	FirstStoryId = dataList[4]
}

t_six_art_daoguan_client.dataList = dataList

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

return t_six_art_daoguan_client
