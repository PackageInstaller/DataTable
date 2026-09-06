-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_king_load_collect_prize.lua

module("logicconfig.config.t_king_load_collect_prize", package.seeall)

local title = {
	id = 1,
	prize = 3,
	target = 2
}
local dataList = {
	{
		0,
		3,
		"8:1:6666"
	},
	{
		1,
		5,
		"8:4:6666"
	},
	{
		2,
		8,
		"113:103:1:6"
	}
}
local t_king_load_collect_prize = {
	[0] = dataList[1],
	dataList[2],
	dataList[3]
}

t_king_load_collect_prize.dataList = dataList

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

return t_king_load_collect_prize
