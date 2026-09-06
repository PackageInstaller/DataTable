-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pet_skin_tab1.lua

module("logicconfig.config.t_pet_skin_tab1", package.seeall)

local title = {
	tabViewName = 6,
	name = 2,
	sortIndex = 4,
	isHide = 5,
	index = 1,
	childIndex = 3
}
local dataList = {
	{
		1,
		"皮肤",
		{
			1,
			2,
			3,
			4,
			5,
			6,
			7
		},
		1,
		false,
		""
	},
	{
		2,
		"海报",
		{
			8,
			9
		},
		2,
		true,
		""
	}
}
local t_pet_skin_tab1 = {
	dataList[1],
	dataList[2]
}

t_pet_skin_tab1.dataList = dataList

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

return t_pet_skin_tab1
