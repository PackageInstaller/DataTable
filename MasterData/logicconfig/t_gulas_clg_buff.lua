-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_gulas_clg_buff.lua

module("logicconfig.config.t_gulas_clg_buff", package.seeall)

local title = {
	buffId = 1
}
local dataList = {
	{
		1
	},
	{
		2
	},
	{
		3
	},
	{
		4
	}
}
local t_gulas_clg_buff = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4]
}

t_gulas_clg_buff.dataList = dataList

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

return t_gulas_clg_buff
