-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_alchemy_meng_meng_reagent.lua

module("logicconfig.config.t_origin_alchemy_meng_meng_reagent", package.seeall)

local title = {
	needCompound = 4,
	name = 3,
	reagentId = 2,
	resName = 6,
	activityId = 1,
	desc = 5
}
local dataList = {
	{
		601001,
		1,
		82056671,
		{
			1
		},
		82056176,
		"icon_hechengwu_01"
	},
	{
		601001,
		2,
		82056672,
		{
			1,
			3
		},
		82056673,
		"icon_hechengwu_02"
	},
	{
		601001,
		3,
		82056084,
		{
			2,
			3
		},
		82056178,
		"icon_hechengwu_03"
	},
	{
		601001,
		4,
		82056674,
		{
			1,
			3
		},
		82056675,
		"icon_hechengwu_04"
	},
	{
		601001,
		5,
		82056676,
		{
			1,
			2,
			3,
			3
		},
		82056180,
		"icon_hechengwu_05"
	}
}
local t_origin_alchemy_meng_meng_reagent = {
	[601001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_origin_alchemy_meng_meng_reagent.dataList = dataList

local multiLanguageCells = {
	desc = true,
	name = true
}
local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			local value = rawget(t, index)

			if multiLanguageCells[key] then
				value = lang(value)
			end

			return value
		else
			printWarn(string.format("the field name [%s] is nonexist!", key))
		end
	end
}

for i, v in ipairs(dataList) do
	setmetatable(v, mt)
end

return t_origin_alchemy_meng_meng_reagent
