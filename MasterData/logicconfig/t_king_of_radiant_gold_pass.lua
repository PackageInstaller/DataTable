-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_king_of_radiant_gold_pass.lua

module("logicconfig.config.t_king_of_radiant_gold_pass", package.seeall)

local title = {
	cost = 3,
	num = 2,
	activityId = 1
}
local dataList = {
	{
		462001,
		1,
		"204:250356:160"
	},
	{
		462001,
		2,
		"204:250356:320"
	},
	{
		462001,
		3,
		"204:250356:480"
	},
	{
		462001,
		4,
		"204:250356:640"
	},
	{
		462001,
		5,
		"204:250356:800"
	},
	{
		462001,
		6,
		"204:250356:960"
	},
	{
		462001,
		7,
		"204:250356:1120"
	},
	{
		462001,
		8,
		"204:250356:1280"
	},
	{
		462001,
		9,
		"204:250356:1440"
	}
}
local t_king_of_radiant_gold_pass = {
	[462001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9]
	}
}

t_king_of_radiant_gold_pass.dataList = dataList

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

return t_king_of_radiant_gold_pass
