-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_inflation_money_closet_pop.lua

module("logicconfig.config.t_inflation_money_closet_pop", package.seeall)

local title = {
	skinId = 6,
	jumpStr = 5,
	id = 2,
	title = 3,
	activityId = 1,
	desc = 4
}
local dataList = {
	{
		452001,
		1,
		"满减商城",
		"皮肤满300减50\r\n叠加膨胀金再减20",
		"event#opentabframeworkview#8#6",
		1301603
	},
	{
		452001,
		2,
		"皮肤抽奖",
		"单抽抵扣10%神钻",
		"event#opentabframeworkview#8#3",
		1403101
	}
}
local t_inflation_money_closet_pop = {
	[452001] = {
		dataList[1],
		dataList[2]
	}
}

t_inflation_money_closet_pop.dataList = dataList

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

return t_inflation_money_closet_pop
