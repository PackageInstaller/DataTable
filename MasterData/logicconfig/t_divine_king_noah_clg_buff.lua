-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_king_noah_clg_buff.lua

module("logicconfig.config.t_divine_king_noah_clg_buff", package.seeall)

local title = {
	buffPlanId = 1,
	buffId = 2,
	lineCount = 3
}
local dataList = {
	{
		1,
		1,
		0
	},
	{
		1,
		2,
		1
	},
	{
		1,
		3,
		2
	},
	{
		1,
		4,
		3
	},
	{
		1,
		5,
		4
	},
	{
		1,
		6,
		5
	}
}
local t_divine_king_noah_clg_buff = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_divine_king_noah_clg_buff.dataList = dataList

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

return t_divine_king_noah_clg_buff
