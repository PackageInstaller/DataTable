-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_yun_jie_dragon_clg_one_key_pass_cost.lua

module("logicconfig.config.t_yun_jie_dragon_clg_one_key_pass_cost", package.seeall)

local title = {
	cost = 3,
	leftStageCount = 2,
	activityId = 1
}
local dataList = {
	{
		572001,
		1,
		"204:250801:160"
	},
	{
		572001,
		2,
		"204:250801:320"
	},
	{
		572001,
		3,
		"204:250801:480"
	},
	{
		572001,
		4,
		"204:250801:640"
	},
	{
		572001,
		5,
		"204:250801:800"
	},
	{
		572001,
		6,
		"204:250801:960"
	},
	{
		572001,
		7,
		"204:250801:1120"
	},
	{
		572001,
		8,
		"204:250801:1280"
	},
	{
		572001,
		9,
		"204:250801:1440"
	}
}
local t_yun_jie_dragon_clg_one_key_pass_cost = {
	[572001] = {
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

t_yun_jie_dragon_clg_one_key_pass_cost.dataList = dataList

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

return t_yun_jie_dragon_clg_one_key_pass_cost
