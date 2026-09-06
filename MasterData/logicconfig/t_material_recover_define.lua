-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_material_recover_define.lua

module("logicconfig.config.t_material_recover_define", package.seeall)

local title = {
	calBeginDate = 4,
	openLevel = 5,
	tips = 6,
	tag = 7,
	id = 1,
	priceUnit = 3,
	desc = 2
}
local dataList = {
	{
		1,
		"失落遗迹",
		200,
		"2022-02-12",
		15,
		"<size=18>资源最多保存6天</size>",
		"每周找回"
	},
	{
		2,
		"暗影来袭",
		50,
		"2021-07-02",
		15,
		"<size=18>收藏品概率获得</size>",
		""
	},
	{
		3,
		"世界魔王战",
		50,
		"2021-07-02",
		15,
		"<size=18>阵法碎片数量概率获得</size>",
		""
	},
	{
		4,
		"日常任务",
		5,
		"2021-07-02",
		15,
		"",
		""
	},
	{
		5,
		"领取体力",
		50,
		"2021-07-02",
		15,
		"",
		""
	}
}
local t_material_recover_define = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5]
}

t_material_recover_define.dataList = dataList

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

return t_material_recover_define
