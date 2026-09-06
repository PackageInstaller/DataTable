-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_form_strength_trigger.lua

module("logicconfig.config.t_form_strength_trigger", package.seeall)

local title = {
	posList = 3,
	name = 2,
	formStrengthId = 1
}
local dataList = {
	{
		1,
		"格挡阵",
		{
			2,
			4,
			5,
			6,
			8
		}
	},
	{
		2,
		"攻击阵",
		{
			1,
			4,
			5,
			6,
			9
		}
	},
	{
		3,
		"暴击阵",
		{
			2,
			3,
			4,
			6,
			7
		}
	},
	{
		4,
		"防御阵",
		{
			1,
			3,
			4,
			6,
			8
		}
	},
	{
		5,
		"闪避阵",
		{
			2,
			4,
			6,
			7,
			9
		}
	},
	{
		6,
		"命中阵",
		{
			1,
			3,
			5,
			7,
			9
		}
	},
	{
		7,
		"防暴阵",
		{
			1,
			2,
			3,
			5,
			8
		}
	},
	{
		8,
		"破击阵",
		{
			1,
			4,
			5,
			8,
			9
		}
	}
}
local t_form_strength_trigger = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8]
}

t_form_strength_trigger.dataList = dataList

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

return t_form_strength_trigger
