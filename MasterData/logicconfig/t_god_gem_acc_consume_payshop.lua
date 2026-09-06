-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_god_gem_acc_consume_payshop.lua

module("logicconfig.config.t_god_gem_acc_consume_payshop", package.seeall)

local title = {
	jumpTo1 = 4,
	payShopItemId = 2,
	jumpTo2 = 5,
	progress = 3,
	skinId = 6,
	activityId = 1
}
local dataList = {
	{
		114019,
		8506,
		300,
		"",
		"ui#sourcetraceevolveview",
		15051
	}
}
local t_god_gem_acc_consume_payshop = {
	[114019] = dataList[1]
}

t_god_gem_acc_consume_payshop.dataList = dataList

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

return t_god_gem_acc_consume_payshop
