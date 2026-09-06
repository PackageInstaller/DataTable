-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_btl_combination_skill_skin.lua

module("logicconfig.config.t_btl_combination_skill_skin", package.seeall)

local title = {
	faceIds = 4,
	formulaId = 2,
	skinId = 3,
	skillId = 1,
	showSkillId = 5
}
local dataList = {
	{
		610338,
		1,
		5033801,
		{
			1033801,
			1033901,
			1034101,
			1034201,
			1034301
		},
		61033801
	},
	{
		610339,
		1,
		5033901,
		{
			1033801,
			1033901,
			1034101,
			1034201,
			1034301
		},
		61033901
	},
	{
		610341,
		1,
		5034101,
		{
			1033801,
			1033901,
			1034101,
			1034201,
			1034301
		},
		61034101
	},
	{
		610342,
		1,
		5034201,
		{
			1033801,
			1033901,
			1034101,
			1034201,
			1034301
		},
		61034201
	},
	{
		610343,
		1,
		5034301,
		{
			1033801,
			1033901,
			1034101,
			1034201,
			1034301
		},
		61034301
	}
}
local t_btl_combination_skill_skin = {
	[610338] = {
		{
			[5033801] = dataList[1]
		}
	},
	[610339] = {
		{
			[5033901] = dataList[2]
		}
	},
	[610341] = {
		{
			[5034101] = dataList[3]
		}
	},
	[610342] = {
		{
			[5034201] = dataList[4]
		}
	},
	[610343] = {
		{
			[5034301] = dataList[5]
		}
	}
}

t_btl_combination_skill_skin.dataList = dataList

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

return t_btl_combination_skill_skin
