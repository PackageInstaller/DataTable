-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_restore_glory_game_sword.lua

module("logicconfig.config.t_restore_glory_game_sword", package.seeall)

local title = {
	hitCountArr = 2,
	ruleId = 4,
	storyId = 3,
	descSuccess = 5,
	gameId = 1
}
local dataList = {
	{
		1,
		{
			5,
			4,
			6
		},
		4450005,
		2,
		"恭喜你，锻造圣光宝剑成功，消耗神曜之剑*100即可将【破空·圣光飞龙】神曜突破为【神曜苍穹·圣光飞龙】"
	}
}
local t_restore_glory_game_sword = {
	dataList[1]
}

t_restore_glory_game_sword.dataList = dataList

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

return t_restore_glory_game_sword
