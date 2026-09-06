-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_jigsaw_exchange_jigsaw.lua

module("logicconfig.config.t_jigsaw_exchange_jigsaw", package.seeall)

local title = {
	jigsawPlanId = 1,
	jigsawId = 2,
	rowGroupPrizeId = 3,
	columnGroupPrizeId = 4
}
local dataList = {
	{
		101,
		1,
		1,
		4
	},
	{
		101,
		2,
		1,
		5
	},
	{
		101,
		3,
		1,
		6
	},
	{
		101,
		4,
		1,
		7
	},
	{
		101,
		5,
		1,
		8
	},
	{
		101,
		6,
		2,
		4
	},
	{
		101,
		7,
		2,
		5
	},
	{
		101,
		8,
		2,
		6
	},
	{
		101,
		9,
		2,
		7
	},
	{
		101,
		10,
		2,
		8
	},
	{
		101,
		11,
		3,
		4
	},
	{
		101,
		12,
		3,
		5
	},
	{
		101,
		13,
		3,
		6
	},
	{
		101,
		14,
		3,
		7
	},
	{
		101,
		15,
		3,
		8
	}
}
local t_jigsaw_exchange_jigsaw = {
	[101] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15]
	}
}

t_jigsaw_exchange_jigsaw.dataList = dataList

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

return t_jigsaw_exchange_jigsaw
