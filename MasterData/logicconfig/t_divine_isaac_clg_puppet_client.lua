-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_isaac_clg_puppet_client.lua

module("logicconfig.config.t_divine_isaac_clg_puppet_client", package.seeall)

local title = {
	puppetId = 1,
	iconName = 2
}
local dataList = {
	{
		1,
		"icon_jixiekuilei_01"
	},
	{
		2,
		"icon_jixiekuilei_02"
	},
	{
		3,
		"icon_jixiekuilei_03"
	}
}
local t_divine_isaac_clg_puppet_client = {
	dataList[1],
	dataList[2],
	dataList[3]
}

t_divine_isaac_clg_puppet_client.dataList = dataList

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

return t_divine_isaac_clg_puppet_client
