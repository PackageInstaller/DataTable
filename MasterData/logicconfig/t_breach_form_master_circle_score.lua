-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_breach_form_master_circle_score.lua

module("logicconfig.config.t_breach_form_master_circle_score", package.seeall)

local title = {
	id = 2,
	circle = 3,
	score = 4,
	circlePlanId = 1
}
local dataList = {
	{
		1,
		1,
		1,
		400
	},
	{
		1,
		2,
		2,
		300
	},
	{
		1,
		3,
		3,
		200
	},
	{
		1,
		4,
		4,
		100
	},
	{
		1,
		5,
		5,
		50
	},
	{
		1,
		6,
		6,
		30
	},
	{
		1,
		7,
		8,
		10
	},
	{
		2,
		1,
		1,
		80
	},
	{
		2,
		2,
		2,
		60
	},
	{
		2,
		3,
		3,
		40
	},
	{
		2,
		4,
		4,
		20
	},
	{
		2,
		5,
		5,
		10
	},
	{
		2,
		6,
		6,
		6
	},
	{
		2,
		7,
		8,
		2
	}
}
local t_breach_form_master_circle_score = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	},
	{
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14]
	}
}

t_breach_form_master_circle_score.dataList = dataList

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

return t_breach_form_master_circle_score
