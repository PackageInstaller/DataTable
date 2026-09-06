-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_canke_xiaonuo_common.lua

module("logicconfig.config.t_canke_xiaonuo_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"CAKE_RULE1",
		"瓜分<color=#87FA77FF>S级</color>次数达到一定时，必中部分<color=#C54949>S级奖品</color>"
	},
	{
		"CAKE_RULE2",
		"瓜分<color=#87FA77FF>S级</color>次数达到一定时，必中部分<color=#C54949>S级奖品</color>"
	}
}
local t_canke_xiaonuo_common = {
	CAKE_RULE1 = dataList[1],
	CAKE_RULE2 = dataList[2]
}

t_canke_xiaonuo_common.dataList = dataList

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

return t_canke_xiaonuo_common
