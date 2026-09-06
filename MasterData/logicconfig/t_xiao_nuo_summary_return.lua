-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_xiao_nuo_summary_return.lua

module("logicconfig.config.t_xiao_nuo_summary_return", package.seeall)

local title = {
	id = 1,
	raceId = 2,
	jumpTo = 5,
	offsetY = 4,
	icon = 3
}
local dataList = {
	{
		1,
		10147,
		"board_xnsrflhz_bg04",
		-25,
		"func#427#2"
	},
	{
		2,
		10328,
		"board_xnsrflhz_bg05",
		25,
		"func#427#2"
	},
	{
		3,
		14000,
		"board_xnsrflhz_bg06",
		-25,
		"func#427#2"
	},
	{
		4,
		10100,
		"board_xnsrflhz_bg07",
		25,
		"func#427#2"
	}
}
local t_xiao_nuo_summary_return = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4]
}

t_xiao_nuo_summary_return.dataList = dataList

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

return t_xiao_nuo_summary_return
