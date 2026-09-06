-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_gulas_clg_sign_in_buff.lua

module("logicconfig.config.t_gulas_clg_sign_in_buff", package.seeall)

local title = {
	desc = 3,
	activityId = 1,
	level = 2
}
local dataList = {
	{
		437001,
		1,
		"全属性\n+10%"
	},
	{
		437001,
		2,
		"全属性\n+30%"
	},
	{
		437001,
		3,
		"全属性\n+80%"
	},
	{
		437001,
		4,
		"全属性\n+200%"
	},
	{
		437001,
		5,
		"全属性\n+400%"
	},
	{
		437001,
		6,
		"全属性\n+600%"
	},
	{
		437001,
		7,
		"全属性\n+1000%"
	},
	{
		437001,
		8,
		"全属性\n+1500%"
	},
	{
		437002,
		1,
		"全属性\n+10%"
	},
	{
		437002,
		2,
		"全属性\n+30%"
	},
	{
		437002,
		3,
		"全属性\n+80%"
	},
	{
		437002,
		4,
		"全属性\n+200%"
	},
	{
		437002,
		5,
		"全属性\n+400%"
	},
	{
		437002,
		6,
		"全属性\n+600%"
	},
	{
		437002,
		7,
		"全属性\n+1000%"
	},
	{
		437002,
		8,
		"全属性\n+1500%"
	}
}
local t_gulas_clg_sign_in_buff = {
	[437001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	},
	[437002] = {
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16]
	}
}

t_gulas_clg_sign_in_buff.dataList = dataList

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

return t_gulas_clg_sign_in_buff
