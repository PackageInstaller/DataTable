-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_element_spark_pet_shop_item.lua

module("logicconfig.config.t_element_spark_pet_shop_item", package.seeall)

local title = {
	shopId = 1,
	shopItemId = 2,
	supportPetId = 3,
	price = 4
}
local dataList = {
	{
		1,
		1,
		10000001,
		30000
	},
	{
		1,
		2,
		10000002,
		30000
	},
	{
		1,
		3,
		10000003,
		30000
	},
	{
		1,
		4,
		10000004,
		30000
	},
	{
		1,
		5,
		10000005,
		30000
	},
	{
		1,
		7,
		10000006,
		30000
	},
	{
		1,
		8,
		10000007,
		30000
	},
	{
		1,
		9,
		10000008,
		30000
	},
	{
		2,
		1,
		10000009,
		30000
	},
	{
		2,
		2,
		10000010,
		30000
	},
	{
		2,
		3,
		10000011,
		30000
	},
	{
		2,
		4,
		10000012,
		30000
	},
	{
		2,
		5,
		10000013,
		30000
	},
	{
		2,
		6,
		10000014,
		30000
	},
	{
		2,
		7,
		10000015,
		30000
	},
	{
		2,
		8,
		10000016,
		30000
	},
	{
		3,
		1,
		10000017,
		30000
	},
	{
		3,
		2,
		10000018,
		30000
	},
	{
		3,
		3,
		10000019,
		30000
	},
	{
		3,
		4,
		10000020,
		30000
	},
	{
		3,
		5,
		10000021,
		30000
	},
	{
		3,
		6,
		10000022,
		30000
	},
	{
		3,
		7,
		10000023,
		30000
	},
	{
		3,
		8,
		10000024,
		30000
	},
	{
		4,
		1,
		10000025,
		30000
	},
	{
		4,
		2,
		10000026,
		30000
	},
	{
		4,
		3,
		10000027,
		30000
	},
	{
		4,
		4,
		10000028,
		30000
	},
	{
		4,
		5,
		10000029,
		30000
	},
	{
		4,
		6,
		10000030,
		30000
	},
	{
		4,
		7,
		10000031,
		30000
	},
	{
		4,
		8,
		10000032,
		30000
	}
}
local t_element_spark_pet_shop_item = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		[7] = dataList[6],
		[8] = dataList[7],
		[9] = dataList[8]
	},
	{
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16]
	},
	{
		dataList[17],
		dataList[18],
		dataList[19],
		dataList[20],
		dataList[21],
		dataList[22],
		dataList[23],
		dataList[24]
	},
	{
		dataList[25],
		dataList[26],
		dataList[27],
		dataList[28],
		dataList[29],
		dataList[30],
		dataList[31],
		dataList[32]
	}
}

t_element_spark_pet_shop_item.dataList = dataList

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

return t_element_spark_pet_shop_item
