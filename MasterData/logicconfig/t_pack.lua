-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pack.lua

module("logicconfig.config.t_pack", package.seeall)

local title = {
	packId = 1,
	name = 2,
	content = 3
}
local dataList = {
	{
		10001,
		"金币礼盒",
		"8:1:20000"
	},
	{
		10011,
		"百万经验礼包",
		"4:25:8#4:3:40"
	},
	{
		10021,
		"千载难逢礼包",
		"4:20001:1#8:1:3000"
	},
	{
		10022,
		"万众瞩目礼包",
		"4:20002:1#8:1:5000"
	}
}
local t_pack = {
	[10001] = dataList[1],
	[10011] = dataList[2],
	[10021] = dataList[3],
	[10022] = dataList[4]
}

t_pack.dataList = dataList

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

return t_pack
