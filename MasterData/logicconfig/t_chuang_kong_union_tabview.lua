-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_chuang_kong_union_tabview.lua

module("logicconfig.config.t_chuang_kong_union_tabview", package.seeall)

local title = {
	id = 1,
	parameter = 6,
	viewname = 3,
	coin = 7,
	redpointId = 4,
	title = 2,
	reportBehavior = 5
}
local dataList = {
	{
		1,
		"天鸣剧情",
		"chuangkongcopyview",
		"-172",
		0,
		"",
		"600"
	},
	{
		2,
		"天鸣试炼",
		"chuangkonguniontrialview",
		"-173",
		0,
		"",
		"5000"
	},
	{
		3,
		"天鸣任务",
		"chuangkonguniontaskview",
		"-174",
		0,
		"",
		"28350"
	}
}
local t_chuang_kong_union_tabview = {
	dataList[1],
	dataList[2],
	dataList[3]
}

t_chuang_kong_union_tabview.dataList = dataList

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

return t_chuang_kong_union_tabview
