-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dragon_pool_weed.lua

module("logicconfig.config.t_dragon_pool_weed", package.seeall)

local title = {
	cd = 3,
	actId = 1,
	grassId = 2
}
local dataList = {
	{
		300001,
		1,
		60
	},
	{
		300001,
		2,
		240
	},
	{
		300001,
		3,
		180
	},
	{
		300001,
		4,
		300
	},
	{
		300001,
		5,
		180
	},
	{
		300001,
		6,
		120
	},
	{
		300001,
		7,
		120
	}
}
local t_dragon_pool_weed = {
	[300001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	}
}

t_dragon_pool_weed.dataList = dataList

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

return t_dragon_pool_weed
