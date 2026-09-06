-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_chop_king_first_clg_buff_rerandom_cost.lua

module("logicconfig.config.t_chop_king_first_clg_buff_rerandom_cost", package.seeall)

local title = {
	cost = 3,
	activityId = 1,
	reRandomCount = 2
}
local dataList = {
	{
		470001,
		1,
		"105:2:50"
	},
	{
		470001,
		2,
		"105:2:100"
	},
	{
		470001,
		3,
		"105:2:150"
	}
}
local t_chop_king_first_clg_buff_rerandom_cost = {
	[470001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_chop_king_first_clg_buff_rerandom_cost.dataList = dataList

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

return t_chop_king_first_clg_buff_rerandom_cost
