-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_red_lotus_gala_buy.lua

module("logicconfig.config.t_red_lotus_gala_buy", package.seeall)

local title = {
	buyPlanId = 1,
	buyCost = 3,
	times = 2
}
local dataList = {
	{
		1,
		1,
		"105:6050:100"
	},
	{
		1,
		2,
		"105:6050:101"
	}
}
local t_red_lotus_gala_buy = {
	{
		dataList[1],
		dataList[2]
	}
}

t_red_lotus_gala_buy.dataList = dataList

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

return t_red_lotus_gala_buy
