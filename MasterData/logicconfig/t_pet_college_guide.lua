-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pet_college_guide.lua

module("logicconfig.config.t_pet_college_guide", package.seeall)

local title = {
	challengeId = 1,
	start = 3,
	skill = 5,
	buff = 4,
	stageId = 2,
	pos = 6
}
local dataList = {
	{
		1,
		1,
		"11::次元龙的攻击可以连续攻击2次，超杀可以连续攻击敌方3次！",
		"",
		"",
		{
			-316,
			-62
		}
	},
	{
		1,
		2,
		"11::次元龙的被动可以免疫控制效果，绝地反杀！",
		"",
		"",
		{
			-316,
			-62
		}
	},
	{
		2,
		1,
		"",
		"",
		"13::21016701::潘多拉的超杀可以攻击敌方全阵精灵！",
		{
			-316,
			-62
		}
	},
	{
		2,
		2,
		"13::潘多拉的攻击带有<color=#0068b7>吸血</color>效果，提供强大的生存能力！",
		"",
		"",
		{
			-316,
			-62
		}
	},
	{
		3,
		1,
		"12::龙炎的超杀会<color=#0068b7>变身战神</color>，提升<color=#0068b7>攻击</color>，<color=#0068b7>受伤减少</color>并获得<color=#0068b7>攻击吸血</color>",
		"",
		"",
		{
			-316,
			-62
		}
	},
	{
		3,
		2,
		"12::龙炎的英雄技可给全阵提供高额属性，同时阵上<color=#0068b7>每回合</color>额外获得<color=#0068b7>15点气势</color>！",
		"",
		"",
		{
			-316,
			-62
		}
	},
	{
		4,
		1,
		"",
		"",
		"14::21030901::茜茜的超杀可以攻击敌方<color=#0068b7>所有</color>精灵！",
		{
			-316,
			-62
		}
	},
	{
		4,
		2,
		"",
		"",
		"14::11030901::茜茜的攻击带有<color=#0068b7>额外</color>伤害，破解敌方超高防御！",
		{
			-316,
			-62
		}
	},
	{
		5,
		1,
		"",
		"",
		""
	},
	{
		5,
		2,
		"",
		"",
		""
	},
	{
		6,
		1,
		"",
		"",
		""
	},
	{
		6,
		2,
		"",
		"",
		""
	},
	{
		7,
		1,
		"",
		"",
		""
	},
	{
		8,
		1,
		"",
		"",
		""
	},
	{
		8,
		2,
		"",
		"",
		""
	},
	{
		9,
		1,
		"",
		"",
		""
	}
}
local t_pet_college_guide = {
	{
		dataList[1],
		dataList[2]
	},
	{
		dataList[3],
		dataList[4]
	},
	{
		dataList[5],
		dataList[6]
	},
	{
		dataList[7],
		dataList[8]
	},
	{
		dataList[9],
		dataList[10]
	},
	{
		dataList[11],
		dataList[12]
	},
	{
		dataList[13]
	},
	{
		dataList[14],
		dataList[15]
	},
	{
		dataList[16]
	}
}

t_pet_college_guide.dataList = dataList

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

return t_pet_college_guide
