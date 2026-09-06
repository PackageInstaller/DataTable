-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_time_wheel_decompose_pet.lua

module("logicconfig.config.t_time_wheel_decompose_pet", package.seeall)

local title = {
	paramValue = 2,
	paramKey = 1
}
local dataList = {
	{
		"needAwakenLv",
		"6"
	},
	{
		"rare_N",
		"8:8:200"
	},
	{
		"rare_R",
		"8:8:500"
	},
	{
		"rare_SR",
		"8:8:3000"
	},
	{
		"rare_SSR",
		"8:8:20000"
	},
	{
		"fadeAway_ElvesID",
		"10137,10138,10139,10140,10141,10382,12001,14002"
	}
}
local t_time_wheel_decompose_pet = {
	needAwakenLv = dataList[1],
	rare_N = dataList[2],
	rare_R = dataList[3],
	rare_SR = dataList[4],
	rare_SSR = dataList[5],
	fadeAway_ElvesID = dataList[6]
}

t_time_wheel_decompose_pet.dataList = dataList

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

return t_time_wheel_decompose_pet
