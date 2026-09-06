-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_defend_carrot_material_clg_prize.lua

module("logicconfig.config.t_defend_carrot_material_clg_prize", package.seeall)

local title = {
	stageId = 2,
	waveNum = 3,
	activityId = 1,
	prize = 4
}
local dataList = {
	{
		517001,
		1,
		1,
		"10:517002:100"
	},
	{
		517001,
		1,
		5,
		"10:517002:150"
	},
	{
		517001,
		1,
		10,
		"10:517002:200"
	},
	{
		517001,
		2,
		1,
		"10:517002:150"
	},
	{
		517001,
		2,
		5,
		"10:517002:200"
	},
	{
		517001,
		2,
		10,
		"10:517002:250"
	},
	{
		517001,
		3,
		1,
		"10:517002:200"
	},
	{
		517001,
		3,
		5,
		"10:517002:250"
	},
	{
		517001,
		3,
		10,
		"10:517002:300"
	}
}
local t_defend_carrot_material_clg_prize = {
	[517001] = {
		{
			dataList[1],
			[5] = dataList[2],
			[10] = dataList[3]
		},
		{
			dataList[4],
			[5] = dataList[5],
			[10] = dataList[6]
		},
		{
			dataList[7],
			[5] = dataList[8],
			[10] = dataList[9]
		}
	}
}

t_defend_carrot_material_clg_prize.dataList = dataList

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

return t_defend_carrot_material_clg_prize
