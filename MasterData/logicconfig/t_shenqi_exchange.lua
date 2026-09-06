-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_shenqi_exchange.lua

module("logicconfig.config.t_shenqi_exchange", package.seeall)

local title = {
	id = 1,
	item = 2
}
local dataList = {
	{
		1,
		"4:64001"
	},
	{
		2,
		"4:64006"
	},
	{
		3,
		"4:64007"
	}
}
local t_shenqi_exchange = {
	dataList[1],
	dataList[2],
	dataList[3]
}

t_shenqi_exchange.dataList = dataList

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

return t_shenqi_exchange
