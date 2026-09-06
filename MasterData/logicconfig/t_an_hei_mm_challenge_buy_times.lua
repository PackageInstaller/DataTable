-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_an_hei_mm_challenge_buy_times.lua

module("logicconfig.config.t_an_hei_mm_challenge_buy_times", package.seeall)

local title = {
	cost = 2,
	times = 1
}
local dataList = {
	{
		1,
		"105:166:20"
	},
	{
		2,
		"105:166:20"
	},
	{
		3,
		"105:166:50"
	},
	{
		4,
		"105:166:50"
	},
	{
		5,
		"105:166:100"
	}
}
local t_an_hei_mm_challenge_buy_times = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5]
}

t_an_hei_mm_challenge_buy_times.dataList = dataList

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

return t_an_hei_mm_challenge_buy_times
