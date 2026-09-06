-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_fruit_ninja_combo.lua

module("logicconfig.config.t_fruit_ninja_combo", package.seeall)

local title = {
	comboCount = 3,
	comboId = 2,
	comboPlanId = 1,
	score = 4
}
local dataList = {
	{
		1,
		1,
		3,
		1
	},
	{
		1,
		2,
		5,
		5
	},
	{
		1,
		3,
		7,
		10
	},
	{
		1,
		4,
		9,
		15
	},
	{
		1,
		5,
		11,
		20
	},
	{
		1,
		6,
		13,
		25
	},
	{
		1,
		7,
		15,
		30
	},
	{
		1,
		8,
		17,
		35
	},
	{
		1,
		9,
		19,
		40
	},
	{
		1,
		10,
		21,
		45
	}
}
local t_fruit_ninja_combo = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	}
}

t_fruit_ninja_combo.dataList = dataList

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

return t_fruit_ninja_combo
