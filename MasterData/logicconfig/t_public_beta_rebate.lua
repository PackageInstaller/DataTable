-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_public_beta_rebate.lua

module("logicconfig.config.t_public_beta_rebate", package.seeall)

local title = {
	multiple = 4,
	reward = 5,
	id = 1,
	left = 2,
	right = 3
}
local dataList = {
	{
		1,
		0,
		6,
		10,
		""
	},
	{
		2,
		6,
		200,
		5,
		""
	},
	{
		3,
		200,
		800,
		3,
		""
	},
	{
		4,
		800,
		99999999,
		2,
		""
	}
}
local t_public_beta_rebate = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4]
}

t_public_beta_rebate.dataList = dataList

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

return t_public_beta_rebate
