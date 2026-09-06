-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pet_divine_common.lua

module("logicconfig.config.t_pet_divine_common", package.seeall)

local title = {
	value = 2,
	key = 1,
	desc = 3
}
local dataList = {
	{
		"ENTER_POPUP_POWER_LIMIT",
		"1000000",
		"1.如果有神曜态,建议先神曜再源起(源起进化放入神曜态可继承觉醒等级)\r\n2、建议先将精灵图鉴满级后再进化"
	},
	{
		"EXCHANGE_JUMP",
		"func#94",
		"神启商店跳转"
	},
	{
		"MATERIAL_JUMP",
		"func#95#ExchangeJiazu_High",
		"材料商店跳转"
	}
}
local t_pet_divine_common = {
	ENTER_POPUP_POWER_LIMIT = dataList[1],
	EXCHANGE_JUMP = dataList[2],
	MATERIAL_JUMP = dataList[3]
}

t_pet_divine_common.dataList = dataList

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

return t_pet_divine_common
