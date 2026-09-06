-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_hoshigami_suit_info.lua

module("logicconfig.config.t_hoshigami_suit_info", package.seeall)

local title = {
	typeDes = 3,
	name = 2,
	icon = 5,
	type = 1,
	source = 4
}
local dataList = {
	{
		1,
		"战神",
		"输出套装",
		"1,3,5",
		"icon_xz_01"
	},
	{
		2,
		"无敌",
		"防御套装",
		"1,3,8",
		"icon_hudun"
	}
}
local t_hoshigami_suit_info = {
	dataList[1],
	dataList[2]
}

t_hoshigami_suit_info.dataList = dataList

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

return t_hoshigami_suit_info
