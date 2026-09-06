-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pet_skin_tab2.lua

module("logicconfig.config.t_pet_skin_tab2", package.seeall)

local title = {
	index = 1,
	name = 2,
	viewName = 3,
	params = 4
}
local dataList = {
	{
		1,
		"神话",
		"petskinpreskinview",
		{
			previewSkin = true,
			quality = 10,
			needDispatchSelectSubTab = true
		}
	},
	{
		2,
		"圣品",
		"petskinpreskinview",
		{
			previewSkin = true,
			quality = 8,
			needDispatchSelectSubTab = true
		}
	},
	{
		3,
		"性转",
		"petskinpreskinview",
		{
			previewSkin = true,
			quality = 6,
			needDispatchSelectSubTab = true
		}
	},
	{
		4,
		"绝品",
		"petskinpreskinview",
		{
			previewSkin = true,
			quality = 9,
			needDispatchSelectSubTab = true
		}
	},
	{
		5,
		"臻品",
		"petskinpreskinview",
		{
			previewSkin = true,
			quality = 7,
			needDispatchSelectSubTab = true
		}
	},
	{
		6,
		"精品",
		"petskinpreskinview",
		{
			previewSkin = true,
			quality = 5,
			needDispatchSelectSubTab = true
		}
	},
	{
		7,
		"良品",
		"petskinpreskinview",
		{
			previewSkin = true,
			quality = 3,
			needDispatchSelectSubTab = true
		}
	},
	{
		8,
		"多人海报",
		"petskinposterpreview",
		{
			tabType = 0
		}
	},
	{
		9,
		"单人海报",
		"petskinposterpreview",
		{
			tabType = 1
		}
	}
}
local t_pet_skin_tab2 = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8],
	dataList[9]
}

t_pet_skin_tab2.dataList = dataList

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

return t_pet_skin_tab2
