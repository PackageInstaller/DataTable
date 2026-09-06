-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_defend_carrot_material_clg.lua

module("logicconfig.config.t_defend_carrot_material_clg", package.seeall)

local title = {
	stagePlanId = 4,
	stageId = 2,
	stagename = 5,
	picRath = 6,
	weaponLevel = 3,
	activityId = 1
}
local dataList = {
	{
		517001,
		1,
		0,
		16,
		"入门难度",
		"ui/emoji/miao/miao_3.png"
	},
	{
		517001,
		2,
		15,
		17,
		"普通难度",
		"ui/emoji/miao/miao_5.png"
	},
	{
		517001,
		3,
		25,
		18,
		"困难难度",
		"ui/emoji/miao/miao_4.png"
	}
}
local t_defend_carrot_material_clg = {
	[517001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_defend_carrot_material_clg.dataList = dataList

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

return t_defend_carrot_material_clg
