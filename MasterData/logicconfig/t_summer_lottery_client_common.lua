-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_summer_lottery_client_common.lua

module("logicconfig.config.t_summer_lottery_client_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"RollerSpeed",
		"0.2"
	},
	{
		"ActId",
		"167006"
	}
}
local t_summer_lottery_client_common = {
	RollerSpeed = dataList[1],
	ActId = dataList[2]
}

t_summer_lottery_client_common.dataList = dataList

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

return t_summer_lottery_client_common
