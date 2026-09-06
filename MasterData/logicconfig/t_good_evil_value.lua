-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_good_evil_value.lua

module("logicconfig.config.t_good_evil_value", package.seeall)

local title = {
	title = 3,
	res = 2,
	lv = 1,
	desc = 4
}
local dataList = {
	{
		0,
		"icon_cwyc_04",
		"你是个资本家",
		"该拉去吊路灯了"
	},
	{
		20,
		"icon_cwyc_06",
		"你是个大恶人",
		"斯大林很看好你，决定送你去西伯利亚搞建设"
	},
	{
		50,
		"icon_cwyc_05",
		"你是个恶人",
		"晚上出门注意点"
	},
	{
		100,
		"icon_cwyc_01",
		"你是个好人",
		"好人卡X1"
	},
	{
		150,
		"icon_cwyc_02",
		"你是个好人X2",
		"好人卡X2"
	},
	{
		200,
		"icon_cwyc_03",
		"你是个好人X3",
		"好人卡X3"
	}
}
local t_good_evil_value = {
	[0] = dataList[1],
	[20] = dataList[2],
	[50] = dataList[3],
	[100] = dataList[4],
	[150] = dataList[5],
	[200] = dataList[6]
}

t_good_evil_value.dataList = dataList

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

return t_good_evil_value
