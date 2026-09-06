-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_companion_mall_pack_show.lua

module("logicconfig.config.t_companion_mall_pack_show", package.seeall)

local title = {
	sortId = 3,
	selectPackId = 5,
	groupId = 2,
	activityId = 1,
	dealType = 4
}
local dataList = {
	{
		492003,
		1,
		1,
		"single",
		0
	},
	{
		492003,
		1,
		2,
		"pack",
		1001
	},
	{
		492003,
		1,
		3,
		"pack",
		1002
	},
	{
		492003,
		1,
		4,
		"all",
		1003
	}
}
local t_companion_mall_pack_show = {
	[492003] = {
		{
			dataList[1],
			dataList[2],
			dataList[3],
			dataList[4]
		}
	}
}

t_companion_mall_pack_show.dataList = dataList

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

return t_companion_mall_pack_show
