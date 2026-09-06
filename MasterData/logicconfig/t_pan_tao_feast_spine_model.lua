-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pan_tao_feast_spine_model.lua

module("logicconfig.config.t_pan_tao_feast_spine_model", package.seeall)

local title = {
	posOffset = 3,
	planId = 1,
	spinePath = 5,
	id = 2,
	scale = 4,
	aniName = 6
}
local dataList = {
	{
		1,
		1,
		{
			0,
			0
		},
		{
			0.28,
			0.28,
			0.28
		},
		"zhiren_aoqi",
		"run"
	},
	{
		1,
		2,
		{
			0,
			-65
		},
		{
			0.3,
			0.3,
			0.3
		},
		"zhiren_shuangshengbai",
		"walk"
	},
	{
		1,
		3,
		{
			0,
			-65
		},
		{
			0.3,
			0.3,
			0.3
		},
		"zhiren_shuangshenghei",
		"walk"
	},
	{
		1,
		4,
		{
			0,
			-10
		},
		{
			0.28,
			0.28,
			0.28
		},
		"10140_xiaonuo_gensui",
		"fly"
	},
	{
		1,
		5,
		{
			0,
			-25
		},
		{
			0.3,
			0.3,
			0.3
		},
		"10014_liya",
		"run"
	}
}
local t_pan_tao_feast_spine_model = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_pan_tao_feast_spine_model.dataList = dataList

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

return t_pan_tao_feast_spine_model
