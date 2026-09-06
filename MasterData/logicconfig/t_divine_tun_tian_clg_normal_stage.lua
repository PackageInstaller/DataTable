-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_tun_tian_clg_normal_stage.lua

module("logicconfig.config.t_divine_tun_tian_clg_normal_stage", package.seeall)

local title = {
	index = 3,
	creepsMasterId = 4,
	activityId = 1,
	day = 2
}
local dataList = {
	{
		508001,
		1,
		1,
		2001
	},
	{
		508001,
		1,
		2,
		2002
	},
	{
		508001,
		1,
		3,
		2003
	},
	{
		508001,
		2,
		1,
		2004
	},
	{
		508001,
		2,
		2,
		2005
	},
	{
		508001,
		2,
		3,
		2006
	},
	{
		508001,
		3,
		1,
		2007
	},
	{
		508001,
		3,
		2,
		2008
	},
	{
		508001,
		3,
		3,
		2009
	},
	{
		508001,
		4,
		1,
		2010
	},
	{
		508001,
		4,
		2,
		2011
	},
	{
		508001,
		4,
		3,
		2012
	},
	{
		508001,
		5,
		1,
		2013
	},
	{
		508001,
		5,
		2,
		2014
	},
	{
		508001,
		5,
		3,
		2015
	}
}
local t_divine_tun_tian_clg_normal_stage = {
	[508001] = {
		{
			dataList[1],
			dataList[2],
			dataList[3]
		},
		{
			dataList[4],
			dataList[5],
			dataList[6]
		},
		{
			dataList[7],
			dataList[8],
			dataList[9]
		},
		{
			dataList[10],
			dataList[11],
			dataList[12]
		},
		{
			dataList[13],
			dataList[14],
			dataList[15]
		}
	}
}

t_divine_tun_tian_clg_normal_stage.dataList = dataList

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

return t_divine_tun_tian_clg_normal_stage
