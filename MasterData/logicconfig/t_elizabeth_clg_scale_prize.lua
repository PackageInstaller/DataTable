-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_elizabeth_clg_scale_prize.lua

module("logicconfig.config.t_elizabeth_clg_scale_prize", package.seeall)

local title = {
	planId = 1,
	scale = 2,
	flowerNum = 3
}
local dataList = {
	{
		1,
		15,
		5
	},
	{
		1,
		35,
		5
	},
	{
		1,
		50,
		10
	},
	{
		1,
		70,
		10
	},
	{
		1,
		96,
		20
	}
}
local t_elizabeth_clg_scale_prize = {
	{
		[15] = dataList[1],
		[35] = dataList[2],
		[50] = dataList[3],
		[70] = dataList[4],
		[96] = dataList[5]
	}
}

t_elizabeth_clg_scale_prize.dataList = dataList

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

return t_elizabeth_clg_scale_prize
