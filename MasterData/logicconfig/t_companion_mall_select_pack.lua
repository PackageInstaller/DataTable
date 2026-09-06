-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_companion_mall_select_pack.lua

module("logicconfig.config.t_companion_mall_select_pack", package.seeall)

local title = {
	packGroupId = 3,
	content = 6,
	selectCount = 4,
	selectPackId = 2,
	goodsId = 5,
	activityId = 1
}
local dataList = {
	{
		492003,
		1001,
		1,
		2,
		"rmb_30",
		"4:400004:15#4:147:1"
	},
	{
		492003,
		1002,
		1,
		3,
		"rmb_45",
		"4:400004:20#4:147:1"
	},
	{
		492003,
		1003,
		1,
		7,
		"rmb_78",
		"4:410002:1#4:12101:5#4:510243:5#4:438:1"
	}
}
local t_companion_mall_select_pack = {
	[492003] = {
		[1001] = dataList[1],
		[1002] = dataList[2],
		[1003] = dataList[3]
	}
}

t_companion_mall_select_pack.dataList = dataList

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

return t_companion_mall_select_pack
