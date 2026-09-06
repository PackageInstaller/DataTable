-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pet_awaken_verification_goto.lua

module("logicconfig.config.t_pet_awaken_verification_goto", package.seeall)

local title = {
	gotoStr = 3,
	redId = 5,
	goPlanId = 1,
	index = 2,
	title = 4
}
local dataList = {
	{
		1,
		1,
		"func#433",
		"商城&直升机",
		""
	},
	{
		1,
		2,
		"func#95#ExchangeFamily",
		"兑换觉醒魂",
		""
	}
}
local t_pet_awaken_verification_goto = {
	{
		dataList[1],
		dataList[2]
	}
}

t_pet_awaken_verification_goto.dataList = dataList

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

return t_pet_awaken_verification_goto
