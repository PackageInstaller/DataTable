-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_king_arena_zdl_ratio.lua

module("logicconfig.config.t_king_arena_zdl_ratio", package.seeall)

local title = {
	beginRank = 1,
	ratio = 2
}
local dataList = {
	{
		1,
		"0.25"
	},
	{
		6,
		"0.25"
	},
	{
		101,
		"0.25"
	},
	{
		1001,
		"0.25"
	},
	{
		5001,
		"0.25"
	},
	{
		10001,
		"0.25"
	},
	{
		50001,
		"0.25"
	}
}
local t_king_arena_zdl_ratio = {
	dataList[1],
	[6] = dataList[2],
	[101] = dataList[3],
	[1001] = dataList[4],
	[5001] = dataList[5],
	[10001] = dataList[6],
	[50001] = dataList[7]
}

t_king_arena_zdl_ratio.dataList = dataList

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

return t_king_arena_zdl_ratio
