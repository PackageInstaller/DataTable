-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ao_qi_attack_force_shape_define.lua

module("logicconfig.config.t_ao_qi_attack_force_shape_define", package.seeall)

local title = {
	cutdownId = 4,
	height = 3,
	width = 2,
	shapTypeId = 1
}
local dataList = {
	{
		-1,
		3,
		3
	},
	{
		1,
		1,
		1
	},
	{
		2,
		1,
		2
	},
	{
		3,
		1,
		3
	},
	{
		4,
		2,
		1
	},
	{
		5,
		2,
		2
	},
	{
		6,
		2,
		2,
		{
			4
		}
	},
	{
		7,
		2,
		2,
		{
			3
		}
	},
	{
		8,
		2,
		2,
		{
			2
		}
	},
	{
		9,
		2,
		2,
		{
			1
		}
	},
	{
		10,
		3,
		1
	},
	{
		11,
		3,
		3,
		{
			1,
			2,
			7,
			8
		}
	},
	{
		12,
		3,
		1
	},
	{
		13,
		2,
		1
	}
}
local t_ao_qi_attack_force_shape_define = {
	[-1] = dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8],
	dataList[9],
	dataList[10],
	dataList[11],
	dataList[12],
	dataList[13],
	dataList[14]
}

t_ao_qi_attack_force_shape_define.dataList = dataList

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

return t_ao_qi_attack_force_shape_define
