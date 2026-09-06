-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dress_shop_tab_define.lua

module("logicconfig.config.t_dress_shop_tab_define", package.seeall)

local title = {
	leftTab = 2,
	rootTab = 1,
	tabShow = 3
}
local dataList = {
	{
		1,
		0,
		82007915
	},
	{
		2,
		0,
		82007916
	},
	{
		2,
		1,
		82007917
	},
	{
		2,
		2,
		82007918
	},
	{
		2,
		3,
		82007919
	},
	{
		2,
		4,
		82007920
	},
	{
		2,
		5,
		82007921
	},
	{
		2,
		6,
		82007922
	},
	{
		2,
		7,
		82007923
	},
	{
		3,
		0,
		82007916
	},
	{
		4,
		0,
		82007916
	},
	{
		4,
		1,
		82007917
	},
	{
		4,
		2,
		82007918
	},
	{
		4,
		3,
		82007919
	},
	{
		4,
		4,
		82007920
	},
	{
		4,
		5,
		82007921
	},
	{
		4,
		6,
		82007922
	}
}
local t_dress_shop_tab_define = {
	{
		[0] = dataList[1]
	},
	{
		[0] = dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9]
	},
	{
		[0] = dataList[10]
	},
	{
		[0] = dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16],
		dataList[17]
	}
}

t_dress_shop_tab_define.dataList = dataList

local multiLanguageCells = {
	tabShow = true
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

return t_dress_shop_tab_define
