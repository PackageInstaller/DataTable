-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_invincible_normal_stage.lua

module("logicconfig.config.t_divine_invincible_normal_stage", package.seeall)

local title = {
	buffDesc = 4,
	creepsMasterIds = 3,
	normalPlanId = 1,
	day = 2
}
local dataList = {
	{
		1,
		1,
		{
			2001,
			2002,
			2003
		},
		"己阵伤害+50%"
	},
	{
		1,
		2,
		{
			2004,
			2005,
			2006
		},
		"己阵初始气势+50"
	},
	{
		1,
		3,
		{
			2007,
			2008,
			2009
		},
		"己阵全属性+30%"
	},
	{
		1,
		4,
		{
			2001,
			2002,
			2003
		},
		"己阵伤害+50%"
	},
	{
		1,
		5,
		{
			2004,
			2005,
			2006
		},
		"己阵初始气势+50"
	},
	{
		1,
		6,
		{
			2007,
			2008,
			2009
		},
		"己阵全属性+30%"
	},
	{
		1,
		7,
		{
			2001,
			2002,
			2003
		},
		"己阵伤害+50%"
	},
	{
		1,
		8,
		{
			2004,
			2005,
			2006
		},
		"己阵初始气势+50"
	},
	{
		1,
		9,
		{
			2007,
			2008,
			2009
		},
		"己阵全属性+30%"
	}
}
local t_divine_invincible_normal_stage = {
	{
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

t_divine_invincible_normal_stage.dataList = dataList

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

return t_divine_invincible_normal_stage
