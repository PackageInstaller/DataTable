-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_global_celebrate_item.lua

module("logicconfig.config.t_global_celebrate_item", package.seeall)

local title = {
	title1 = 2,
	title2 = 3,
	type = 1
}
local dataList = {
	{
		1,
		"全服已领取#个金币",
		"金币"
	},
	{
		2,
		"全服已领取#个钻石",
		"钻石"
	},
	{
		3,
		"全服已领取#个召唤券",
		"召唤券"
	},
	{
		4,
		"全服已领取#个精灵",
		"精灵"
	},
	{
		5,
		"全服已领取#个传说精灵",
		"传说精灵"
	}
}
local t_global_celebrate_item = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5]
}

t_global_celebrate_item.dataList = dataList

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

return t_global_celebrate_item
