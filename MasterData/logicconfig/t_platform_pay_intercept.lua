-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_platform_pay_intercept.lua

module("logicconfig.config.t_platform_pay_intercept", package.seeall)

local title = {
	createPlatformId = 1,
	loginPlatformIds = 2
}
local dataList = {
	{
		500,
		{
			10
		}
	},
	{
		2,
		{
			500
		}
	},
	{
		10,
		{
			500
		}
	}
}
local t_platform_pay_intercept = {
	[500] = dataList[1],
	[2] = dataList[2],
	[10] = dataList[3]
}

t_platform_pay_intercept.dataList = dataList

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

return t_platform_pay_intercept
