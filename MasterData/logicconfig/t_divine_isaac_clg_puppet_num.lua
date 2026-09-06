-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_isaac_clg_puppet_num.lua

module("logicconfig.config.t_divine_isaac_clg_puppet_num", package.seeall)

local title = {
	id = 3,
	phaseId = 2,
	buffDesc = 5,
	puppetNum = 4,
	activityId = 1
}
local dataList = {
	{
		491001,
		1,
		1,
		1,
		"敌阵全属性及生命上限+5%"
	},
	{
		491001,
		1,
		2,
		2,
		"敌阵全属性及生命上限+10%"
	},
	{
		491001,
		1,
		3,
		3,
		"敌阵全属性及生命上限+15%"
	},
	{
		491001,
		2,
		1,
		1,
		"敌阵全属性及生命上限+5%"
	},
	{
		491001,
		2,
		2,
		2,
		"敌阵全属性及生命上限+10%"
	},
	{
		491001,
		2,
		3,
		3,
		"敌阵全属性及生命上限+15%"
	},
	{
		491001,
		2,
		4,
		4,
		"敌阵全属性及生命上限+20%"
	},
	{
		491001,
		2,
		5,
		5,
		"敌阵全属性及生命上限+25%"
	},
	{
		491001,
		3,
		1,
		1,
		"敌阵全属性及生命上限+5%"
	},
	{
		491001,
		3,
		2,
		2,
		"敌阵全属性及生命上限+10%"
	},
	{
		491001,
		3,
		3,
		3,
		"敌阵全属性及生命上限+15%"
	},
	{
		491001,
		3,
		4,
		4,
		"敌阵全属性及生命上限+20%"
	},
	{
		491001,
		3,
		5,
		5,
		"敌阵全属性及生命上限+25%"
	},
	{
		491001,
		3,
		6,
		6,
		"敌阵全属性及生命上限+30%"
	},
	{
		491001,
		3,
		7,
		7,
		"敌阵全属性及生命上限+35%"
	}
}
local t_divine_isaac_clg_puppet_num = {
	[491001] = {
		{
			dataList[1],
			dataList[2],
			dataList[3]
		},
		{
			dataList[4],
			dataList[5],
			dataList[6],
			dataList[7],
			dataList[8]
		},
		{
			dataList[9],
			dataList[10],
			dataList[11],
			dataList[12],
			dataList[13],
			dataList[14],
			dataList[15]
		}
	}
}

t_divine_isaac_clg_puppet_num.dataList = dataList

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

return t_divine_isaac_clg_puppet_num
