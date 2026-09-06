-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_guessgame_gametips.lua

module("logicconfig.config.t_guessgame_gametips", package.seeall)

local title = {
	id = 2,
	content = 3,
	prizePlanId = 1
}
local dataList = {
	{
		1,
		1,
		"铁甲巨龙是这座城市最骄傲的作品，然而比起真实的龙，似乎还差上一些。"
	},
	{
		1,
		2,
		"还记得我们一起并肩作战的日子么？"
	},
	{
		1,
		3,
		"你要来观赏一下，我的收藏品么？"
	},
	{
		1,
		4,
		"我一向独行于世间，铁甲巨龙是意外得来的收藏品。"
	},
	{
		1,
		5,
		"铁甲巨龙所带来的焰火，将把黑夜点亮。"
	},
	{
		1,
		6,
		"诞生了灵智的铁甲巨龙，确实比其他事物有意思。"
	},
	{
		1,
		7,
		"好久不见，你还记得我么？"
	}
}
local t_guessgame_gametips = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	}
}

t_guessgame_gametips.dataList = dataList

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

return t_guessgame_gametips
