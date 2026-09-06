-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_element_spark_product.lua

module("logicconfig.config.t_element_spark_product", package.seeall)

local title = {
	maxManualGainLimit = 4,
	productId = 1,
	rate = 3,
	productType = 2,
	desc = 5
}
local dataList = {
	{
		1,
		"manualCampScoreRate",
		30,
		100000,
		"阵营积分（手动发放）每分钟+30"
	},
	{
		2,
		"manualPersonScoreRate",
		30,
		100000,
		"个人积分（手动发放）每分钟+30"
	},
	{
		3,
		"manualPetShopScoreRate",
		30,
		100000,
		"酒馆道具（手动发放）每分钟+30"
	},
	{
		4,
		"autoCampScoreRate",
		50,
		0,
		"阵营积分（自动发放）每分钟+50"
	},
	{
		5,
		"autoPersonScoreRate",
		50,
		0,
		"个人积分（自动发放）每分钟+50"
	},
	{
		6,
		"autoPersonScoreRate",
		100,
		0,
		"个人积分（自动发放）每分钟+100"
	},
	{
		7,
		"autoPersonScoreRate",
		150,
		0,
		"个人积分（自动发放）每分钟+150"
	},
	{
		8,
		"autoCampScoreRate",
		1,
		0,
		"阵营积分（自动发放）每分钟+1"
	},
	{
		9,
		"autoCampScoreRate",
		2,
		0,
		"阵营积分（自动发放）每分钟+2"
	},
	{
		10,
		"autoCampScoreRate",
		10,
		0,
		"阵营积分（自动发放）每分钟+10"
	},
	{
		11,
		"manualCampScoreRate",
		50,
		150000,
		"阵营积分（手动发放）每分钟+50"
	},
	{
		12,
		"manualPersonScoreRate",
		50,
		150000,
		"个人积分（手动发放）每分钟+50"
	},
	{
		13,
		"manualPetShopScoreRate",
		50,
		150000,
		"酒馆道具（手动发放）每分钟+50"
	},
	{
		14,
		"manualCampScoreRate",
		100,
		200000,
		"阵营积分（手动发放）每分钟+100"
	},
	{
		15,
		"manualPersonScoreRate",
		100,
		200000,
		"个人积分（手动发放）每分钟+100"
	},
	{
		16,
		"manualPetShopScoreRate",
		100,
		200000,
		"酒馆道具（手动发放）每分钟+100"
	},
	{
		17,
		"manualCampScoreRate",
		150,
		250000,
		"阵营积分（手动发放）每分钟+150"
	},
	{
		18,
		"manualPersonScoreRate",
		150,
		250000,
		"个人积分（手动发放）每分钟+150"
	},
	{
		19,
		"manualPetShopScoreRate",
		150,
		250000,
		"酒馆道具（手动发放）每分钟+150"
	},
	{
		20,
		"autoCampScoreRate",
		100,
		0,
		"阵营积分（自动发放）每分钟+100"
	},
	{
		21,
		"autoCampScoreRate",
		200,
		0,
		"阵营积分（自动发放）每分钟+200"
	},
	{
		22,
		"autoCampScoreRate",
		300,
		0,
		"阵营积分（自动发放）每分钟+300"
	}
}
local t_element_spark_product = {
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
	dataList[15],
	dataList[16],
	dataList[17],
	dataList[18],
	dataList[19],
	dataList[20],
	dataList[21],
	dataList[22]
}

t_element_spark_product.dataList = dataList

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

return t_element_spark_product
