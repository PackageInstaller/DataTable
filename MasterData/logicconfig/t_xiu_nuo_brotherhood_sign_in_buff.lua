-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_xiu_nuo_brotherhood_sign_in_buff.lua

module("logicconfig.config.t_xiu_nuo_brotherhood_sign_in_buff", package.seeall)

local title = {
	desc = 3,
	activityId = 1,
	level = 2
}
local dataList = {
	{
		208004,
		1,
		"全属性\r\n+10%"
	},
	{
		208004,
		2,
		"全属性\r\n+30%"
	},
	{
		208004,
		3,
		"全属性\r\n+50%"
	},
	{
		208004,
		4,
		"全属性\r\n+150%"
	},
	{
		208004,
		5,
		"全属性\r\n+300%"
	},
	{
		208004,
		6,
		"全属性\r\n+500%"
	},
	{
		208004,
		7,
		"全属性\r\n+800%"
	},
	{
		208004,
		8,
		"全属性\r\n+1200%"
	}
}
local t_xiu_nuo_brotherhood_sign_in_buff = {
	[208004] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	}
}

t_xiu_nuo_brotherhood_sign_in_buff.dataList = dataList

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

return t_xiu_nuo_brotherhood_sign_in_buff
