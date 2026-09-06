-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_dakinos_clg_buff.lua

module("logicconfig.config.t_divine_dakinos_clg_buff", package.seeall)

local title = {
	buffDesc = 3,
	activityId = 1,
	buffLevel = 2
}
local dataList = {
	{
		400001,
		1,
		"全属性+10%"
	},
	{
		400001,
		2,
		"全属性+30%"
	},
	{
		400001,
		3,
		"全属性+50%"
	},
	{
		400001,
		4,
		"全属性+150%"
	},
	{
		400001,
		5,
		"全属性+300%"
	},
	{
		400001,
		6,
		"全属性+500%"
	},
	{
		400001,
		7,
		"全属性+800%"
	},
	{
		400002,
		1,
		"全属性+10%"
	},
	{
		400002,
		2,
		"全属性+30%"
	},
	{
		400002,
		3,
		"全属性+50%"
	},
	{
		400002,
		4,
		"全属性+150%"
	},
	{
		400002,
		5,
		"全属性+300%"
	},
	{
		400002,
		6,
		"全属性+500%"
	},
	{
		400002,
		7,
		"全属性+800%"
	}
}
local t_divine_dakinos_clg_buff = {
	[400001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	},
	[400002] = {
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14]
	}
}

t_divine_dakinos_clg_buff.dataList = dataList

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

return t_divine_dakinos_clg_buff
