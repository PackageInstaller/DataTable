-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_scuffle_daily_buff.lua

module("logicconfig.config.t_scuffle_daily_buff", package.seeall)

local title = {
	id = 1,
	desc = 3,
	day = 2
}
local dataList = {
	{
		1,
		1,
		""
	},
	{
		1,
		2,
		""
	},
	{
		1,
		3,
		""
	},
	{
		1,
		4,
		""
	},
	{
		1,
		5,
		""
	},
	{
		1,
		6,
		""
	},
	{
		1,
		7,
		""
	}
}
local t_scuffle_daily_buff = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	}
}

t_scuffle_daily_buff.dataList = dataList

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

return t_scuffle_daily_buff
