-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_king_ji_pass_plan.lua

module("logicconfig.config.t_king_ji_pass_plan", package.seeall)

local title = {
	conditionId = 2,
	passPlanId = 1,
	needCount = 4,
	attribute = 3
}
local dataList = {
	{
		1,
		1,
		"光",
		1
	},
	{
		1,
		2,
		"水",
		1
	},
	{
		1,
		3,
		"火",
		1
	},
	{
		1,
		4,
		"草",
		1
	},
	{
		1,
		5,
		"暗",
		1
	},
	{
		2,
		1,
		"光",
		2
	},
	{
		2,
		2,
		"水",
		2
	},
	{
		2,
		3,
		"火",
		2
	},
	{
		2,
		4,
		"草",
		2
	},
	{
		2,
		5,
		"暗",
		2
	},
	{
		3,
		1,
		"光",
		3
	},
	{
		3,
		2,
		"水",
		3
	},
	{
		3,
		3,
		"火",
		3
	},
	{
		3,
		4,
		"草",
		3
	},
	{
		3,
		5,
		"暗",
		3
	}
}
local t_king_ji_pass_plan = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	},
	{
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	},
	{
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15]
	}
}

t_king_ji_pass_plan.dataList = dataList

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

return t_king_ji_pass_plan
