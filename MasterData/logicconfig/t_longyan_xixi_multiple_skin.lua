-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_longyan_xixi_multiple_skin.lua

module("logicconfig.config.t_longyan_xixi_multiple_skin", package.seeall)

local title = {
	id = 1,
	lyId1 = 3,
	lyId2 = 4,
	funcId = 2
}
local dataList = {
	{
		1,
		373,
		9,
		10
	},
	{
		2,
		289,
		3,
		4
	}
}
local t_longyan_xixi_multiple_skin = {
	dataList[1],
	dataList[2]
}

t_longyan_xixi_multiple_skin.dataList = dataList

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

return t_longyan_xixi_multiple_skin
