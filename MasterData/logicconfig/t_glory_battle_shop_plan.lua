-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_glory_battle_shop_plan.lua

module("logicconfig.config.t_glory_battle_shop_plan", package.seeall)

local title = {
	level = 2,
	goodsPoolPlan = 4,
	round = 3,
	shopPlan = 1
}
local dataList = {
	{
		1,
		1,
		3,
		1
	},
	{
		1,
		2,
		6,
		2
	},
	{
		1,
		3,
		11,
		3
	}
}
local t_glory_battle_shop_plan = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_glory_battle_shop_plan.dataList = dataList

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

return t_glory_battle_shop_plan
